# GCP Kubernetes & Deploy Explorer Handoff Report

This report outlines the recommended Kubernetes manifests (Deployment, Service, Ingress, and GKE BackendConfig) and deployment scripts (Bash and PowerShell) for hosting the CIC application in Google Kubernetes Engine (GKE) using service account authentication (`gcp-key.json`).

---

## 1. Observation

During the read-only investigation, the following files and structural configurations were directly observed in the workspace:

### 1.1 Service Structure (`docker-compose.yml`)
* **Path**: `D:\Github\CIC\docker-compose.yml`
* **Services**:
  * **`cic-api`** (Lines 4-20):
    * Context: `./go` using `Dockerfile`.
    * Ports: `8080:8080` (Line 15).
    * Environment: `DATABASE_URL` (Line 11): `postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@host.docker.internal:5432/${POSTGRES_DB:-cic_dev}?sslmode=disable`
    * Environment: `PORT` (Line 12) set to `8080`.
    * Environment: `JWT_SECRET` (Line 13) set to `${JWT_SECRET:-your-secret-key-change-in-production}`.
  * **`react-admin`** (Lines 21-35):
    * Context: `./react-admin` using `Dockerfile`.
    * Args: `VITE_API_URL=http://localhost:80/api/v1` (Line 26).
    * Environment: `VITE_API_URL: http://localhost:80/api/v1` (Line 30).
    * Ports: `3000:80` (Line 32).
  * **`keycloak`** (Lines 36-47):
    * Image: `quay.io/keycloak/keycloak:23.0` (Line 37).
    * Command: `start-dev` (Line 42).
    * Ports: `8081:8080` (Line 44).
  * **`nginx`** (Lines 48-60):
    * Image: `nginx:alpine` (Line 49).
    * Volumes: `./nginx/nginx.conf:/etc/nginx/nginx.conf:ro` (Line 52).
    * Ports: `80:80` (Line 54).

### 1.2 Routing Rules (`nginx/nginx.conf`)
* **Path**: `D:\Github\CIC\nginx\nginx.conf`
* **Rules** (Lines 13-51):
  * `/health` -> `http://cic-api:8080/health` (Line 14)
  * `/swagger/` -> `http://cic-api:8080/swagger/` (Line 22)
  * `/api/` -> `http://cic-api:8080/api/` (Line 31)
  * `/api/v1/` -> `http://cic-api:8080/api/v1/` (Line 39)
  * `/` -> `http://react-admin:80/` (Line 47)

### 1.3 React Admin Client Build Config & API Client
* **Path**: `D:\Github\CIC\react-admin\Dockerfile`
  * Build Argument: `ARG VITE_API_URL` (Line 7) is passed into the build environment as `ENV VITE_API_URL=$VITE_API_URL` (Line 8).
  * Static build output `dist` is served via `nginx:alpine` on port 80 (Lines 23-33).
* **Path**: `D:\Github\CIC\react-admin\src\dataProvider.ts`
  * `const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:80/api/v1';` (Line 4)
  * Line 34: `const url = new URL(`${API_URL}/${config.apiResource}`, window.location.origin);`
* **Path**: `D:\Github\CIC\react-admin\src\authProvider.ts`
  * `const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000/api';` (Line 3)

---

## 2. Logic Chain

1. **Routing and Proxy Layer**: The existing setup utilizes Nginx for path-based routing, splitting paths like `/api/v1/*` to `cic-api` and root `/` to `react-admin`. In GKE, we can replace this containerized Nginx service entirely with a native Kubernetes **Ingress** or **Gateway**. This simplifies the architecture, utilizes GCP's global External HTTP(S) Load Balancer, and offloads SSL/TLS termination to GCP managed certificates.
2. **Frontend Build Dependency**: Because the React frontend (`react-admin`) utilizes Vite, the environment variable `VITE_API_URL` is statically compiled into JS assets at build time. Since GKE Ingress exposes both the frontend and backend on the same host (routing via paths `/api` and `/`), we can configure the build argument `VITE_API_URL` as a relative path `/api/v1`. This allows the React app to automatically resolve requests against the browser's current host (e.g. `https://my-domain.com/api/v1`), keeping the Docker image fully environment-agnostic.
3. **Database Configuration**: The `cic-api` service connects to a PostgreSQL database via `DATABASE_URL`. GCP best practice for GKE is to use a managed **Google Cloud SQL** instance. Rather than storing database credentials in plain environment variables, we should recommend:
   * A GKE **Workload Identity** linking a Kubernetes Service Account to a GCP IAM Service Account.
   * A **Cloud SQL Auth Proxy** sidecar container running inside the `cic-api` pod. This sidecar secures connection tunnels to Cloud SQL on `127.0.0.1:5432`, eliminating the need to expose PostgreSQL to the public internet.
4. **Service Authentication & Deployment Pipeline**: A service account key `gcp-key.json` located in the workspace root must be activated using `gcloud auth activate-service-account --key-file=gcp-key.json`. Once activated, the deployment script can set the target project, configure docker credential helpers for Google Artifact Registry (GAR), compile the images with appropriate build args, push them to GAR, fetch GKE credentials via `gcloud container clusters get-credentials`, and apply the manifests using `kubectl`.

---

## 3. Caveats

* **Local Database Dev vs. Cloud SQL**: If Cloud SQL is not used, a standard PostgreSQL statefulset must be deployed inside GKE. The manifests below assume the recommended Cloud SQL Auth Proxy sidecar pattern, but a local fallback is documented.
* **Service Account Key Security**: Storing `gcp-key.json` in the workspace is useful for development scripts but should be avoided in production CI/CD pipelines (e.g. GitHub Actions, GitLab CI) in favor of OIDC (OpenID Connect) federation which allows keyless authentication.
* **Keycloak Session & Database**: For production, Keycloak should be configured with a persistent database (e.g. Cloud SQL PostgreSQL) and ingress configuration, rather than using `start-dev` with in-memory storage.

---

## 4. Conclusion

### 4.1 Recommended GKE Architecture Manifests
Create a `manifests/` directory in the project repository and place these files.

#### Manifest 1: `manifests/backend-config.yaml`
GKE Ingress uses health checks to monitor backend health. Because `cic-api` does not serve a response on `/` but serves `/health`, we must explicitly map the Load Balancer health check to `/health` using a BackendConfig.
```yaml
apiVersion: cloud.google.com/v1
kind: BackendConfig
metadata:
  name: cic-api-backend-config
  namespace: cic-prod
spec:
  healthCheck:
    checkIntervalSec: 15
    timeoutSec: 5
    healthyThreshold: 1
    unhealthyThreshold: 2
    type: HTTP
    requestPath: /health
    port: 8080
```

#### Manifest 2: `manifests/secrets.yaml`
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: cic-secrets
  namespace: cic-prod
type: Opaque
data:
  # Base64 encoded values for production secrets
  jwt-secret: eW91ci1zZWNyZXQta2V5LWNoYW5nZS1pbi1wcm9kdWN0aW9u # "your-secret-key-change-in-production"
  keycloak-admin-password: YWRtaW4= # "admin"
```

#### Manifest 3: `manifests/cic-api.yaml`
This deployment includes GKE Workload Identity annotation and the Cloud SQL Auth Proxy sidecar container.
```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: cic-api-sa
  namespace: cic-prod
  annotations:
    # Binds this K8s SA to a GCP IAM Service Account with Cloud SQL Client role
    iam.gke.io/gcp-service-account: cic-api-sa@YOUR_GCP_PROJECT.iam.gserviceaccount.com
---
apiVersion: v1
kind: Service
metadata:
  name: cic-api
  namespace: cic-prod
  annotations:
    # Tells GKE Ingress to use the custom health check configuration
    cloud.google.com/backend-config: '{"default": "cic-api-backend-config"}'
spec:
  type: ClusterIP
  selector:
    app: cic-api
  ports:
    - name: http
      port: 8080
      targetPort: 8080
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cic-api
  namespace: cic-prod
spec:
  replicas: 2
  selector:
    matchLabels:
      app: cic-api
  template:
    metadata:
      labels:
        app: cic-api
    spec:
      serviceAccountName: cic-api-sa
      containers:
        # Main Go API Container
        - name: api
          image: us-central1-docker.pkg.dev/YOUR_GCP_PROJECT/cic-repo/cic-api:latest
          imagePullPolicy: Always
          ports:
            - containerPort: 8080
          env:
            - name: PORT
              value: "8080"
            - name: DATABASE_URL
              # Connects via Cloud SQL Auth Proxy listening on localhost
              value: "postgres://db_user:db_password@127.0.0.1:5432/cic?sslmode=disable"
            - name: JWT_SECRET
              valueFrom:
                secretKeyRef:
                  name: cic-secrets
                  key: jwt-secret
          resources:
            limits:
              cpu: "500m"
              memory: "512Mi"
            requests:
              cpu: "100m"
              memory: "128Mi"
          readinessProbe:
            httpGet:
              path: /health
              port: 8080
            initialDelaySeconds: 5
            periodSeconds: 10
          livenessProbe:
            httpGet:
              path: /health
              port: 8080
            initialDelaySeconds: 10
            periodSeconds: 20

        # Cloud SQL Auth Proxy sidecar container (GCP Best Practice)
        - name: cloud-sql-proxy
          image: gcr.io/cloud-sql-connectors/cloud-sql-proxy:2.8.2
          args:
            # Replace with your Cloud SQL connection name (project:region:instance)
            - "YOUR_GCP_PROJECT:us-central1:cic-postgres-instance"
            # If using private IP connection within VPC
            - "--private-ip"
            - "--port=5432"
          securityContext:
            runAsNonRoot: true
          resources:
            limits:
              cpu: "250m"
              memory: "256Mi"
            requests:
              cpu: "50m"
              memory: "64Mi"
```

#### Manifest 4: `manifests/react-admin.yaml`
```yaml
apiVersion: v1
kind: Service
metadata:
  name: react-admin
  namespace: cic-prod
spec:
  type: ClusterIP
  selector:
    app: react-admin
  ports:
    - name: http
      port: 80
      targetPort: 80
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: react-admin
  namespace: cic-prod
spec:
  replicas: 2
  selector:
    matchLabels:
      app: react-admin
  template:
    metadata:
      labels:
        app: react-admin
    spec:
      containers:
        - name: web
          image: us-central1-docker.pkg.dev/YOUR_GCP_PROJECT/cic-repo/react-admin:latest
          imagePullPolicy: Always
          ports:
            - containerPort: 80
          resources:
            limits:
              cpu: "250m"
              memory: "256Mi"
            requests:
              cpu: "50m"
              memory: "64Mi"
          livenessProbe:
            httpGet:
              path: /
              port: 80
            initialDelaySeconds: 5
            periodSeconds: 15
```

#### Manifest 5: `manifests/keycloak.yaml`
```yaml
apiVersion: v1
kind: Service
metadata:
  name: keycloak
  namespace: cic-prod
spec:
  type: ClusterIP
  selector:
    app: keycloak
  ports:
    - name: http
      port: 8080
      targetPort: 8080
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: keycloak
  namespace: cic-prod
spec:
  replicas: 1
  selector:
    matchLabels:
      app: keycloak
  template:
    metadata:
      labels:
        app: keycloak
    spec:
      containers:
        - name: keycloak
          image: quay.io/keycloak/keycloak:23.0
          args: ["start-dev"]
          ports:
            - containerPort: 8080
          env:
            - name: KEYCLOAK_ADMIN
              value: "admin"
            - name: KEYCLOAK_ADMIN_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: cic-secrets
                  key: keycloak-admin-password
          resources:
            limits:
              cpu: "1"
              memory: "1024Mi"
            requests:
              cpu: "500m"
              memory: "512Mi"
```

#### Manifest 6: `manifests/ingress.yaml`
GKE Ingress that provisions a GCP Global HTTP(S) Load Balancer. It terminates traffic at the edge and routes dynamically based on paths.
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: cic-ingress
  namespace: cic-prod
  annotations:
    kubernetes.io/ingress.class: gce
    # Provisions static public IP from GCP (reserved beforehand)
    kubernetes.io/ingress.global-static-ip-name: cic-static-ip
spec:
  rules:
    - http:
        paths:
          # Route API endpoints (including swagger & v1) to the API service
          - path: /health
            pathType: Prefix
            backend:
              service:
                name: cic-api
                port:
                  number: 8080
          - path: /swagger
            pathType: Prefix
            backend:
              service:
                name: cic-api
                port:
                  number: 8080
          - path: /api
            pathType: Prefix
            backend:
              service:
                name: cic-api
                port:
                  number: 8080
          # Keycloak endpoints
          - path: /auth
            pathType: Prefix
            backend:
              service:
                name: keycloak
                port:
                  number: 8080
          # Catch-all routes to Frontend React app
          - path: /
            pathType: Prefix
            backend:
              service:
                name: react-admin
                port:
                  number: 80
```

---

### 4.2 Complete Deployment Scripts
These scripts automate authentication using `gcp-key.json`, build images (injecting relative path routing for React-admin), push to Google Artifact Registry, configure GKE context, and apply all manifests.

#### Deployment Option A: Bash Script (`deploy.sh`)
```bash
#!/usr/bin/env bash
# ==============================================================================
# CIC Application GCP GKE Deployment Script (Bash)
# ==============================================================================
set -euo pipefail

# --- Deployment Configuration ---
GCP_KEY_FILE="./gcp-key.json"
PROJECT_ID="YOUR_GCP_PROJECT"
REGION="us-central1"
CLUSTER_NAME="cic-gke-cluster"
REPOSITORY="cic-repo"
IMAGE_TAG="latest"

# 1. Verification
if [ ! -f "$GCP_KEY_FILE" ]; then
    echo "[-] Error: GCP Service Account key not found at: $GCP_KEY_FILE"
    exit 1
fi

echo "[+] Authenticating using Service Account Key..."
gcloud auth activate-service-account --key-file="$GCP_KEY_FILE"

echo "[+] Setting active GCP Project: $PROJECT_ID..."
gcloud config set project "$PROJECT_ID"

# 2. Setup Container Registry Auth
echo "[+] Configuring Docker authentication with Google Artifact Registry..."
gcloud auth configure-docker "${REGION}-docker.pkg.dev" --quiet

# 3. Build & Push API Image
API_IMAGE="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPOSITORY}/cic-api:${IMAGE_TAG}"
echo "[+] Building API image: $API_IMAGE..."
docker build -t "$API_IMAGE" ./go
echo "[+] Pushing API image to Artifact Registry..."
docker push "$API_IMAGE"

# 4. Build & Push Frontend Image
# Crucial: Compile-time injection of VITE_API_URL as relative "/api/v1" for path routing
FRONTEND_IMAGE="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPOSITORY}/react-admin:${IMAGE_TAG}"
echo "[+] Building Frontend image: $FRONTEND_IMAGE..."
docker build --build-arg VITE_API_URL=/api/v1 -t "$FRONTEND_IMAGE" ./react-admin
echo "[+] Pushing Frontend image to Artifact Registry..."
docker push "$FRONTEND_IMAGE"

# 5. Connect to GKE Cluster
echo "[+] Fetching credentials for GKE cluster: $CLUSTER_NAME..."
gcloud container clusters get-credentials "$CLUSTER_NAME" --region "$REGION"

# 6. Apply Kubernetes Manifests
echo "[+] Creating namespace if not exists..."
kubectl create namespace cic-prod --dry-run=client -o yaml | kubectl apply -f -

echo "[+] Applying Kubernetes configurations..."
kubectl apply -f manifests/backend-config.yaml
kubectl apply -f manifests/secrets.yaml
kubectl apply -f manifests/keycloak.yaml
kubectl apply -f manifests/cic-api.yaml
kubectl apply -f manifests/react-admin.yaml
kubectl apply -f manifests/ingress.yaml

# 7. Check Deployment Status
echo "[+] Verifying deployments rollouts..."
kubectl rollout status deployment/cic-api -n cic-prod
kubectl rollout status deployment/react-admin -n cic-prod

echo "[+] Deployment successfully completed!"
```

#### Deployment Option B: PowerShell Script (`deploy.ps1`)
*Tailored for Windows hosts.*
```powershell
# ==============================================================================
# CIC Application GCP GKE Deployment Script (PowerShell)
# ==============================================================================
$ErrorActionPreference = "Stop"

# --- Deployment Configuration ---
$GcpKeyFile = "./gcp-key.json"
$ProjectId = "YOUR_GCP_PROJECT"
$Region = "us-central1"
$ClusterName = "cic-gke-cluster"
$Repository = "cic-repo"
$ImageTag = "latest"

# 1. Verification
if (-not (Test-Path $GcpKeyFile)) {
    Write-Error "[-] GCP Service Account key not found at: $GcpKeyFile"
    exit 1
}

Write-Host "[+] Authenticating using Service Account Key..." -ForegroundColor Green
gcloud auth activate-service-account --key-file=$GcpKeyFile

Write-Host "[+] Setting active GCP Project: $ProjectId..." -ForegroundColor Green
gcloud config set project $ProjectId

# 2. Setup Container Registry Auth
Write-Host "[+] Configuring Docker authentication with Google Artifact Registry..." -ForegroundColor Green
gcloud auth configure-docker "${Region}-docker.pkg.dev" --quiet

# 3. Build & Push API Image
$ApiImage = "${Region}-docker.pkg.dev/${ProjectId}/${Repository}/cic-api:${ImageTag}"
Write-Host "[+] Building API image: $ApiImage..." -ForegroundColor Green
docker build -t $ApiImage ./go
Write-Host "[+] Pushing API image to Artifact Registry..." -ForegroundColor Green
docker push $ApiImage

# 4. Build & Push Frontend Image
# Crucial: Compile-time injection of VITE_API_URL as relative "/api/v1" for path routing
$FrontendImage = "${Region}-docker.pkg.dev/${ProjectId}/${Repository}/react-admin:${ImageTag}"
Write-Host "[+] Building Frontend image: $FrontendImage..." -ForegroundColor Green
docker build --build-arg VITE_API_URL=/api/v1 -t $FrontendImage ./react-admin
Write-Host "[+] Pushing Frontend image to Artifact Registry..." -ForegroundColor Green
docker push $FrontendImage

# 5. Connect to GKE Cluster
Write-Host "[+] Fetching credentials for GKE cluster: $ClusterName..." -ForegroundColor Green
gcloud container clusters get-credentials $ClusterName --region $Region

# 6. Apply Kubernetes Manifests
Write-Host "[+] Creating namespace if not exists..." -ForegroundColor Green
kubectl create namespace cic-prod --dry-run=client -o yaml | kubectl apply -f -

Write-Host "[+] Applying Kubernetes configurations..." -ForegroundColor Green
kubectl apply -f manifests/backend-config.yaml
kubectl apply -f manifests/secrets.yaml
kubectl apply -f manifests/keycloak.yaml
kubectl apply -f manifests/cic-api.yaml
kubectl apply -f manifests/react-admin.yaml
kubectl apply -f manifests/ingress.yaml

# 7. Check Deployment Status
Write-Host "[+] Verifying deployments rollouts..." -ForegroundColor Green
kubectl rollout status deployment/cic-api -n cic-prod
kubectl rollout status deployment/react-admin -n cic-prod

Write-Host "[+] Deployment successfully completed!" -ForegroundColor Green
```

---

## 5. Verification Method

To independently verify this deployment configuration and the scripts, execute the following validation steps:

1. **Kubernetes Configuration Dry-Run**:
   Ensure your local machine or build server has `kubectl` CLI configured. Test each manifest's structural integrity using client-side dry-run:
   ```bash
   kubectl apply --dry-run=client -f manifests/
   ```
   *Expectation*: Output should show `created (dry run)` for all resources.
2. **GCP Auth Flow Simulation**:
   Create a test service account key file `gcp-key.json` locally or in a sandboxed CI environment and run:
   ```bash
   gcloud auth activate-service-account --key-file=gcp-key.json
   ```
   *Expectation*: Command succeeds and `gcloud config get-value project` returns the corresponding service account project ID.
3. **Frontend Relative URL Verification**:
   Execute the Docker build command manually with the relative API URL argument:
   ```bash
   docker build --build-arg VITE_API_URL=/api/v1 -t test-frontend ./react-admin
   ```
   *Expectation*: Build finishes successfully and generated JS bundles route calls correctly.
4. **Nginx Routing Equivalence verification**:
   After deploying to GKE, send HTTP requests to the Load Balancer IP:
   * `http://<load-balancer-ip>/health` should resolve to `cic-api`'s `/health` endpoint.
   * `http://<load-balancer-ip>/` should serve the frontend.
