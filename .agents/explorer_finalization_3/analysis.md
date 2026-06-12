# CI/CD Infrastructure and Deployment Analysis

This report presents a read-only analysis of the CI/CD configuration files (Terraform, Shell scripts, Docker Compose, and Jenkinsfile) for the repository.

---

## 1. Terraform Configuration (`prod-setup/gcp/terraform/main.tf`)

### Findings:
1. **Unused Service Account Resource Block**:
   - There is **no** `google_service_account` resource block declared in `main.tf`.
   - The configuration references the existing service account email `"cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com"` directly as a string in `google_compute_instance.jenkins` (line 51) and `google_project_iam_member` resources (lines 65, 71).
   - This is consistent with using an existing service account, meaning no unused block exists or needs to be removed.
2. **Resource Policy for Daily Start/Stop**:
   - The current definition of `google_compute_resource_policy.jenkins_schedule` is **incorrect** for VM scheduling.
   - It uses `daily_schedule` (nested under `schedule`), which is meant for disk snapshots.
   - It lacks the `region` attribute, which is required for resource policies.
   - It uses `time_zone = "Asia/Southeast3"`, which is **not a valid IANA timezone** and will cause an API-level validation failure in GCP.
   - It should be rewritten to use `instance_schedule_policy` with a valid IANA timezone (such as `"Asia/Jakarta"`, which is the timezone for the `asia-southeast3` Jakarta region) and standard cron schedules.
3. **Service Account References**:
   - The existing service account email `"cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com"` is correctly referenced at:
     - `main.tf:51` (attached to the VM instance)
     - `main.tf:65` (IAM binding for Artifact Registry writer)
     - `main.tf:71` (IAM binding for GKE container developer)

### Recommended Changes in `prod-setup/gcp/terraform/main.tf`:
Replace the `jenkins_schedule` resource block:
```hcl
# Before:
resource "google_compute_resource_policy" "jenkins_schedule" {
  name        = "jenkins-daily-schedule"
  description = "Start at 07:00, stop at 21:00 daily (Asia/Southeast3)"

  schedule {
    daily_schedule {
      start_time = "07:00"
      duration   = "14:00" # 14 hours (until 21:00)
    }
    time_zone = "Asia/Southeast3"
  }
}

# After (Corrected VM Instance Schedule Policy):
resource "google_compute_resource_policy" "jenkins_schedule" {
  name        = "jenkins-daily-schedule"
  region      = var.region
  description = "Start at 07:00, stop at 21:00 daily (Asia/Southeast3)"

  instance_schedule_policy {
    vm_start_schedule {
      schedule = "0 7 * * *"
    }
    vm_stop_schedule {
      schedule = "0 21 * * *"
    }
    time_zone = "Asia/Jakarta"
  }
}
```

---

## 2. GCP Deployment Script (`prod-setup/gcp/deploy.sh`)

### Findings:
1. **Configuration Parameters**:
   - **Project ID**: Correctly set to `"project-4cd20f4a-78e2-4a45-81d"` (line 13).
   - **Region**: Correctly set to `"asia-southeast3"` (line 14).
   - **Authentication**: Correctly points to `$REPO_ROOT/gcp-key.json` (line 12) and authenticates using:
     ```bash
     gcloud auth activate-service-account --key-file="$GCP_KEY_FILE"
     ```
2. **Kubectl Dry-Run Flags**:
   - All `kubectl apply` commands in `deploy.sh` correctly include the `--dry-run=client` flag:
     - Line 56: `kubectl apply --dry-run=client -f -` (part of namespace creation pipe)
     - Line 59: `kubectl apply --dry-run=client -f "$SCRIPT_DIR/manifests/backend-config.yaml"`
     - Line 71: `kubectl apply --dry-run=client -f -` (part of secrets substitution pipe)
     - Line 73: `kubectl apply --dry-run=client -f "$SCRIPT_DIR/manifests/managed-certificate.yaml"`
     - Line 74: `kubectl apply --dry-run=client -f "$SCRIPT_DIR/manifests/keycloak.yaml"`
     - Line 75: `kubectl apply --dry-run=client -f "$SCRIPT_DIR/manifests/cic-api.yaml"`
     - Line 76: `kubectl apply --dry-run=client -f "$SCRIPT_DIR/manifests/react-admin.yaml"`
     - Line 77: `kubectl apply --dry-run=client -f "$SCRIPT_DIR/manifests/ingress.yaml"`

---

## 3. Jenkins Docker Compose Configuration (`prod-setup/jenkins/docker-compose.yml`)

### Findings:
1. **GCP Key Path Interpolation**:
   - The volume mount correctly uses variable interpolation to fall back to the placeholder when `GCP_KEY_PATH` is unset or empty:
     ```yaml
     - ${GCP_KEY_PATH:-/path/to/key.json}:/var/jenkins_home/gcp-key.json
     ```
2. **Credentials Environment Variable**:
   - The environment variable is correctly set:
     ```yaml
     - GOOGLE_APPLICATION_CREDENTIALS=/var/jenkins_home/gcp-key.json
     ```

---

## 4. Root Jenkinsfile (`Jenkinsfile`)

### Findings:
1. **Region Reference**:
   - The 'Deploy to Production GKE' stage correctly specifies the region `"asia-southeast3"`:
     ```groovy
     gcloud container clusters get-credentials cic-gke-cluster --region asia-southeast3
     ```
2. **Authentication Method**:
   - The stage uses GCE VM metadata server authentication (implicitly inherits permissions from the host VM's attached service account) as it does not execute any service account key authentication steps.
3. **Critical Integration Gap**:
   - The step runs `kubectl apply -f prod-setup/gcp/manifests/` directly. 
   - This will apply the raw `secrets.yaml` containing the placeholders `__JWT_SECRET__` and `__KEYCLOAK_PASS__` directly to the cluster without substituting them. This differs from `deploy.sh` which executes a `sed` command to inject these values before applying.

---

## 5. Jenkins Entrypoint Script (`prod-setup/jenkins/entrypoint.sh`)

### Findings:
1. **Tini Path Issue**:
   - The entrypoint script references `/usr/bin/tini` on lines 62 and 68.
   - In the base image `jenkins/jenkins:lts` (based on Debian/Ubuntu), `tini` is located at `/sbin/tini`. Running the current script in the container will result in a `No such file or directory` error when trying to execute `/usr/bin/tini`.
2. **Shell Syntax Error on Empty `DOCKER_GID`**:
   - Line 14 resolves `DOCKER_GID` via `stat`:
     ```bash
     DOCKER_GID=$(stat -c '%g' "$DOCKER_SOCKET")
     ```
   - If `stat` fails or the GID is empty, `DOCKER_GID` becomes empty.
   - On line 18: `if [ "$DOCKER_GID" -lt 100 ]; then` is evaluated as `if [ -lt 100 ]; then`, throwing a shell syntax error: `[: -lt: unary operator expected`.
   - Additionally, group addition commands (lines 39, 51) will execute with invalid empty parameters (e.g., `groupadd -g "" NEW_GROUP`), crashing the script.

### Recommended Changes in `prod-setup/jenkins/entrypoint.sh`:
1. Change all instances of `/usr/bin/tini` to `/sbin/tini`.
2. Add a validation check for `DOCKER_GID` being empty before using it numerically.

**Before:**
```bash
62:     exec gosu "$JENKINS_USER" /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
...
68:     exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
```

**After (Exact Fix):**
```bash
# Line 14: Ensure DOCKER_GID defaults to empty string if stat fails
DOCKER_GID=$(stat -c '%g' "$DOCKER_SOCKET" 2>/dev/null || echo "")
echo "[+] Detected host $DOCKER_SOCKET GID: $DOCKER_GID"

# Check if GID is empty
if [ -z "$DOCKER_GID" ]; then
    echo "[!] Could not determine GID of $DOCKER_SOCKET. Skipping GID alignment."
# Check if the GID is a highly privileged system GID (< 100)
elif [ "$DOCKER_GID" -lt 100 ]; then
...
# Line 62: Use correct path /sbin/tini
exec gosu "$JENKINS_USER" /sbin/tini -- /usr/local/bin/jenkins.sh "$@"
...
# Line 68: Use correct path /sbin/tini
exec /sbin/tini -- /usr/local/bin/jenkins.sh "$@"
```

---

## 6. Outline Content for `prod-setup/README.md`

The existing `prod-setup/README.md` is well-structured and contains documentation for all setups. Below is an updated outline including the recommended fixes and validations:

1. **Title & Overview**
   - High-level overview of the production environment setup for GCP and Jenkins.
2. **1. Terraform Infrastructure Provisioning**
   - **Prerequisites**: Terraform version >= 1.5.0, gcloud SDK installed and authenticated.
   - **Configuration Files**: Brief description of `main.tf`, `variables.tf`, `providers.tf`, `outputs.tf`.
   - **Infrastructure Validation**: Steps to run syntax and logic validation on the Terraform configuration.
   - **Command Reference**: `terraform init`, `terraform plan`, `terraform apply`, and `terraform validate`.
3. **2. Daily Start/Stop VM Schedule**
   - **Objective**: Cost optimization for the Jenkins VM.
   - **Mechanism**: Description of `instance_schedule_policy` (daily start at 07:00, stop at 21:00 in timezone `Asia/Jakarta`).
4. **3. Jenkins Pipeline Setup (Docker Compose)**
   - **Environment Variables**: Explanation of `GCP_KEY_PATH` (defaults to `/path/to/key.json`).
   - **Compose Details**: Description of the Docker socket mount for Docker-in-Docker functionality and the `GOOGLE_APPLICATION_CREDENTIALS` pathing inside the container.
   - **Docker Entrypoint details**: Explanation of dynamic group alignment for `/var/run/docker.sock` and how privileges are dropped safely to the `jenkins` user using `gosu` and `/sbin/tini`.
5. **4. GCP GKE Deployment Script**
   - **Overview**: Explanation of `deploy.sh`.
   - **Authentication**: Authenticates via `gcp-key.json` using service account activation.
   - **Dry Run Verification**: Details the usage of the `--dry-run=client` flag in `kubectl apply` commands.
6. **5. CI/CD Integration**
   - **Overview of `Jenkinsfile`**: Explains the root pipeline's test, build, and deploy phases.
   - **Implicit GCE VM Authentication**: Mentions that when running within the GCP VM environment, GKE credentials fetch relies on metadata server authentication rather than service account key files.

---

## 7. Exact Commands to Run `terraform validate`

To validate the Terraform configuration locally, execute the following commands in sequence. 

On **Windows (PowerShell)**:
```powershell
# 1. Change directory to the terraform configuration folder
cd D:\Github\cic\prod-setup\gcp\terraform

# 2. Initialize the terraform directory (downloads required providers, -backend=false bypasses remote backend access)
terraform init -backend=false

# 3. Validate the syntax and consistency of the terraform files
terraform validate
```

On **Linux/macOS (Bash)**:
```bash
# 1. Change directory to the terraform configuration folder
cd prod-setup/gcp/terraform

# 2. Initialize the directory without backend validation
terraform init -backend=false

# 3. Validate configurations
terraform validate
```
