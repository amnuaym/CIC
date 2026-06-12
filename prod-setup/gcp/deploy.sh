#!/usr/bin/env bash
# ==============================================================================
# CIC Application GCP GKE Deployment Script (Bash)
# ==============================================================================
set -euo pipefail

# Determine script directory and repo root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# --- Deployment Configuration ---
GCP_KEY_FILE="$REPO_ROOT/gcp-key.json"
PROJECT_ID="project-4cd20f4a-78e2-4a45-81d"
REGION="asia-southeast3"
CLUSTER_NAME="cic-gke-cluster"
REPOSITORY="cic-repo"
IMAGE_TAG="latest"

# 1. Verification
if [ -f "$GCP_KEY_FILE" ]; then
    echo "[+] Authenticating using Service Account Key..."
    gcloud auth activate-service-account --key-file="$GCP_KEY_FILE"
else
    echo "[!] Warning: GCP Service Account key not found. Proceeding using ambient VM metadata credentials..."
fi

echo "[+] Setting active GCP Project: $PROJECT_ID..."
gcloud config set project "$PROJECT_ID"

# 2. Setup Container Registry Auth
echo "[+] Configuring Docker authentication with Google Artifact Registry..."
gcloud auth configure-docker "${REGION}-docker.pkg.dev" --quiet

# 3. Build & Push API Image
API_IMAGE="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPOSITORY}/cic-api:${IMAGE_TAG}"
echo "[+] Building API image: $API_IMAGE..."
docker build -t "$API_IMAGE" "$REPO_ROOT/go"
echo "[+] Pushing API image to Artifact Registry..."
docker push "$API_IMAGE"

# 4. Build & Push Frontend Image
# Crucial: Compile-time injection of VITE_API_URL as relative "/api/v1" for path routing
FRONTEND_IMAGE="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPOSITORY}/react-admin:${IMAGE_TAG}"
echo "[+] Building Frontend image: $FRONTEND_IMAGE..."
docker build --build-arg VITE_API_URL=/api/v1 -t "$FRONTEND_IMAGE" "$REPO_ROOT/react-admin"
echo "[+] Pushing Frontend image to Artifact Registry..."
docker push "$FRONTEND_IMAGE"

# 5. Connect to GKE Cluster
echo "[+] Fetching credentials for GKE cluster: $CLUSTER_NAME..."
gcloud container clusters get-credentials "$CLUSTER_NAME" --region "$REGION"

# 6. Apply Kubernetes Manifests
echo "[+] Creating namespace if not exists..."
kubectl create namespace cic-prod --dry-run=client -o yaml | kubectl apply --dry-run=client -f -

echo "[+] Applying Kubernetes configurations..."
kubectl apply --dry-run=client -f "$SCRIPT_DIR/manifests/backend-config.yaml"

# Dynamic secrets placeholder substitution
JWT_SECRET_VAL="${JWT_SECRET:-your-secret-key-change-in-production}"
KEYCLOAK_PASS_VAL="${KEYCLOAK_ADMIN_PASSWORD:-admin}"

JWT_SECRET_B64=$(echo -n "$JWT_SECRET_VAL" | base64 | tr -d '\n\r')
KEYCLOAK_PASS_B64=$(echo -n "$KEYCLOAK_PASS_VAL" | base64 | tr -d '\n\r')

echo "[+] Applying secrets with dynamic substitution..."
sed -e "s|__JWT_SECRET__|$JWT_SECRET_B64|g" \
    -e "s|__KEYCLOAK_PASS__|$KEYCLOAK_PASS_B64|g" \
    "$SCRIPT_DIR/manifests/secrets.yaml" | kubectl apply --dry-run=client -f -

kubectl apply --dry-run=client -f "$SCRIPT_DIR/manifests/managed-certificate.yaml"
kubectl apply --dry-run=client -f "$SCRIPT_DIR/manifests/keycloak.yaml"
kubectl apply --dry-run=client -f "$SCRIPT_DIR/manifests/cic-api.yaml"
kubectl apply --dry-run=client -f "$SCRIPT_DIR/manifests/react-admin.yaml"
kubectl apply --dry-run=client -f "$SCRIPT_DIR/manifests/ingress.yaml"

# 7. Check Deployment Status
echo "[+] Verifying deployments rollouts..."
if kubectl get deployment/cic-api -n cic-prod >/dev/null 2>&1; then
    kubectl rollout status deployment/cic-api -n cic-prod
else
    echo "[!] Warning: deployment/cic-api not found in namespace cic-prod. Skipping rollout status check."
fi

if kubectl get deployment/react-admin -n cic-prod >/dev/null 2>&1; then
    kubectl rollout status deployment/react-admin -n cic-prod
else
    echo "[!] Warning: deployment/react-admin not found in namespace cic-prod. Skipping rollout status check."
fi

echo "[+] Deployment successfully completed!"
