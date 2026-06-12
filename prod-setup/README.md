# Production Setup & CI/CD Pipeline Documentation

This directory contains the Terraform configuration, Docker Compose configuration, and scripts required to set up the production environment and the Jenkins CI/CD server for the CIC Application.

## GCP GCE Terraform Configuration

The Terraform files in `prod-setup/gcp/terraform/` provision the Google Compute Engine (GCE) VM instance for Jenkins along with the daily start/stop resource policy.

### Initialization, Planning, and Application

To initialize and validate the Terraform configuration:

1. **Initialize Terraform** (without a remote backend for local validation):
   ```bash
   cd prod-setup/gcp/terraform
   terraform init -backend=false
   ```
2. **Validate Configuration**:
   ```bash
   terraform validate
   ```
3. **Plan Configuration**:
   ```bash
   terraform plan -var-file="terraform.tfvars"
   ```
4. **Apply Configuration**:
   ```bash
   terraform apply -var-file="terraform.tfvars"
   ```

### Daily VM Schedule Policy

A resource policy `google_compute_resource_policy.jenkins_schedule` is attached to the Jenkins GCE VM instance to automatically start and stop the VM:
- **VM Start Schedule**: Daily at `07:00` (`0 7 * * *` in cron format).
- **VM Stop Schedule**: Daily at `21:00` (`0 21 * * *` in cron format).
- **Timezone**: `Asia/Jakarta`.
- **Region**: Specified at the resource level via `region = var.region`.

This ensures that the VM instance is run only during working hours to optimize resource utilization and reduce GCP costs.

---

## Running Jenkins Server Locally via Docker Compose

To run the Jenkins server locally:

1. Ensure Docker and Docker Compose are installed.
2. Bind the host GCP Service Account (SA) Key optionally by setting the `GCP_KEY_PATH` environment variable:
   - On Linux/macOS:
     ```bash
     export GCP_KEY_PATH="/path/to/your/gcp-key.json"
     docker-compose up --build -d
     ```
   - On Windows (PowerShell):
     ```powershell
     $env:GCP_KEY_PATH="C:\path\to\your\gcp-key.json"
     docker-compose up --build -d
     ```
3. Inside the container:
   - The key file will be mounted to `/var/jenkins_home/gcp-key.json`.
   - The environment variable `GOOGLE_APPLICATION_CREDENTIALS` is automatically set to `/var/jenkins_home/gcp-key.json`.
   - The entrypoint script (`entrypoint.sh`) aligns the container's Docker group GID with the host's `/var/run/docker.sock` GID, warning and skipping alignment if `DOCKER_GID` is empty or matches a system GID to prevent privilege escalation or syntax errors.

---

## GKE Deploy Scripts (`deploy.sh` & `deploy.ps1`)

The deployment scripts `deploy.sh` (Bash) and `deploy.ps1` (PowerShell) authenticate with GCP, build the Docker images for the API and React Admin frontend, push them to Google Artifact Registry, and apply Kubernetes manifests to GKE.

### Authentication Fallback
Both scripts support optional authentication using the service account key file:
- **Key-based Authentication**: If a `gcp-key.json` file is present in the repository root, the scripts automatically authenticate using `gcloud auth activate-service-account`.
- **Keyless Authentication Fallback**: If the `gcp-key.json` file is omitted, the scripts will log a warning and proceed without raising an error, defaulting to the ambient credentials available on the GCE VM Instance Service Account metadata.

### Dry-Run Safety Flag & Conditional Rollout Checks
To prevent accidental resource modification during local testing or CI testing, all `kubectl apply` commands in both scripts utilize the `--dry-run=client` flag:
- `kubectl create namespace cic-prod --dry-run=client -o yaml | kubectl apply --dry-run=client -f -`
- `kubectl apply --dry-run=client -f manifests/backend-config.yaml`
- Substituted secrets are applied with `kubectl apply --dry-run=client -f -`
- Other resource manifests (`managed-certificate.yaml`, `keycloak.yaml`, `cic-api.yaml`, `react-admin.yaml`, `ingress.yaml`) are applied using `kubectl apply --dry-run=client -f <file>`

This verifies that the manifests are syntactically and logically correct without making changes to the actual cluster.

Additionally, to prevent script crashes on dry-runs or empty clusters:
- The scripts conditionally check the rollout status of `deployment/cic-api` and `deployment/react-admin` via `kubectl get deployment`.
- If the deployment resource does not exist on the cluster, the script logs a warning and safely skips the `kubectl rollout status` checks.

---

## Jenkinsfile GKE Deployment Stage

The root `Jenkinsfile` contains the CI/CD pipeline definition:
- The `Deploy to Production GKE` stage is executed when code is merged into the `main` branch.
- It copies the GCP service account key from `/var/jenkins_home/gcp-key.json` to the workspace root if it exists, and then executes `prod-setup/gcp/deploy.sh`.
- The `deploy.sh` script connects to the GKE cluster in region `asia-southeast3`, performs placeholder substitution on `secrets.yaml` (avoiding applying raw manifests with `__JWT_SECRET__` directly), and applies manifests safely with the `--dry-run=client` flag.
