# ==============================================================================
# CIC Application GCP GKE Deployment Script (PowerShell)
# ==============================================================================
$ErrorActionPreference = "Stop"

# Determine script directory and repo root
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = (Get-Item (Join-Path $ScriptDir "..\..")).FullName

# --- Deployment Configuration ---
$GcpKeyFile = "$RepoRoot\gcp-key.json"
$ProjectId = "project-4cd20f4a-78e2-4a45-81d"
$Region = "asia-southeast3"
$ClusterName = "cic-gke-cluster"
$Repository = "cic-repo"
$ImageTag = "latest"

# 1. Verification
if (Test-Path $GcpKeyFile) {
    Write-Host "[+] Authenticating using Service Account Key..." -ForegroundColor Green
    gcloud auth activate-service-account --key-file=$GcpKeyFile
} else {
    Write-Host "[!] Warning: GCP Service Account key not found. Proceeding using ambient VM metadata credentials..." -ForegroundColor Yellow
}

Write-Host "[+] Setting active GCP Project: $ProjectId..." -ForegroundColor Green
gcloud config set project $ProjectId

# 2. Setup Container Registry Auth
Write-Host "[+] Configuring Docker authentication with Google Artifact Registry..." -ForegroundColor Green
gcloud auth configure-docker "${Region}-docker.pkg.dev" --quiet

# 3. Build & Push API Image
$ApiImage = "${Region}-docker.pkg.dev/${ProjectId}/${Repository}/cic-api:${ImageTag}"
Write-Host "[+] Building API image: $ApiImage..." -ForegroundColor Green
$GoPath = Join-Path $RepoRoot "go"
docker build -t $ApiImage $GoPath
Write-Host "[+] Pushing API image to Artifact Registry..." -ForegroundColor Green
docker push $ApiImage

# 4. Build & Push Frontend Image
# Crucial: Compile-time injection of VITE_API_URL as relative "/api/v1" for path routing
$FrontendImage = "${Region}-docker.pkg.dev/${ProjectId}/${Repository}/react-admin:${ImageTag}"
Write-Host "[+] Building Frontend image: $FrontendImage..." -ForegroundColor Green
$ReactPath = Join-Path $RepoRoot "react-admin"
docker build --build-arg VITE_API_URL=/api/v1 -t $FrontendImage $ReactPath
Write-Host "[+] Pushing Frontend image to Artifact Registry..." -ForegroundColor Green
docker push $FrontendImage

# 5. Connect to GKE Cluster
Write-Host "[+] Fetching credentials for GKE cluster: $ClusterName..." -ForegroundColor Green
gcloud container clusters get-credentials $ClusterName --region $Region

# 6. Apply Kubernetes Manifests
Write-Host "[+] Creating namespace if not exists..." -ForegroundColor Green
kubectl create namespace cic-prod --dry-run=client -o yaml | kubectl apply --dry-run=client -f -

Write-Host "[+] Applying Kubernetes configurations..." -ForegroundColor Green
kubectl apply --dry-run=client -f (Join-Path $ScriptDir "manifests/backend-config.yaml")

# Dynamic secrets placeholder substitution
$JwtSecretVal = if ($env:JWT_SECRET) { $env:JWT_SECRET } else { "your-secret-key-change-in-production" }
$KeycloakPassVal = if ($env:KEYCLOAK_ADMIN_PASSWORD) { $env:KEYCLOAK_ADMIN_PASSWORD } else { "admin" }

$JwtSecretB64 = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($JwtSecretVal))
$KeycloakPassB64 = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($KeycloakPassVal))

Write-Host "[+] Applying secrets with dynamic substitution..." -ForegroundColor Green
$SecretsFile = Join-Path $ScriptDir "manifests/secrets.yaml"
(Get-Content $SecretsFile) -replace '__JWT_SECRET__', $JwtSecretB64 -replace '__KEYCLOAK_PASS__', $KeycloakPassB64 | kubectl apply --dry-run=client -f -

kubectl apply --dry-run=client -f (Join-Path $ScriptDir "manifests/managed-certificate.yaml")
kubectl apply --dry-run=client -f (Join-Path $ScriptDir "manifests/keycloak.yaml")
kubectl apply --dry-run=client -f (Join-Path $ScriptDir "manifests/cic-api.yaml")
kubectl apply --dry-run=client -f (Join-Path $ScriptDir "manifests/react-admin.yaml")
kubectl apply --dry-run=client -f (Join-Path $ScriptDir "manifests/ingress.yaml")

# 7. Check Deployment Status
Write-Host "[+] Verifying deployments rollouts..." -ForegroundColor Green

$null = kubectl get deployment/cic-api -n cic-prod 2>$null
if ($LastExitCode -eq 0) {
    kubectl rollout status deployment/cic-api -n cic-prod
} else {
    Write-Host "[!] Warning: deployment/cic-api not found in namespace cic-prod. Skipping rollout status check." -ForegroundColor Yellow
}

$null = kubectl get deployment/react-admin -n cic-prod 2>$null
if ($LastExitCode -eq 0) {
    kubectl rollout status deployment/react-admin -n cic-prod
} else {
    Write-Host "[!] Warning: deployment/react-admin not found in namespace cic-prod. Skipping rollout status check." -ForegroundColor Yellow
}

Write-Host "[+] Deployment successfully completed!" -ForegroundColor Green
