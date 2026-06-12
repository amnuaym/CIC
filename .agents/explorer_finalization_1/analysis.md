# Detailed Analysis Report: Infrastructure & CI/CD Finalization

This document presents a detailed read-only analysis of the repository files to address finalization tasks for GCP provisioning, Jenkins pipelines, and deployment scripts.

---

## Task 1: Terraform Configuration Consistency (`prod-setup/gcp/terraform/main.tf`)

### 1. Unused `google_service_account` Resource Block
* **Observation**:
  - We scanned all `.tf` files in `prod-setup/gcp/terraform/`.
  - There is **no** `google_service_account` resource block defined in `main.tf` or any other `.tf` file.
  - A comment on line 59 reads: `# Using existing service account: cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com`.
* **Conclusion & Recommendation**:
  - No action is needed for removing an unused resource block, as none exists.
  - Using an existing service account is appropriate and correctly implemented.

### 2. Daily Start/Stop Resource Policy
* **Observation**:
  - The `jenkins_schedule` resource policy in `main.tf` is defined as:
    ```hcl
    14: resource "google_compute_resource_policy" "jenkins_schedule" {
    15:   name        = "jenkins-daily-schedule"
    16:   description = "Start at 07:00, stop at 21:00 daily (Asia/Southeast3)"
    17: 
    18:   schedule {
    19:     daily_schedule {
    20:       start_time = "07:00"
    21:       duration   = "14:00" # 14 hours (until 21:00)
    22:     }
    23:     time_zone = "Asia/Southeast3"
    24:   }
    25: }
    ```
  - **Inconsistencies**:
    1. It uses `daily_schedule` inside a `schedule` block. Under the Google Terraform Provider, `daily_schedule` is intended for disk snapshots.
    2. For instance start/stop schedules, GCP requires the policy to be defined using `instance_schedule_policy`.
    3. The timezone `"Asia/Southeast3"` is not a standard IANA timezone. The standard IANA timezone corresponding to the `asia-southeast3` region (Jakarta) is `"Asia/Jakarta"`.
* **Recommendation**:
  Replace the block with a valid `instance_schedule_policy` that starts at 07:00 and stops at 21:00 daily using cron expressions:
  ```hcl
  resource "google_compute_resource_policy" "jenkins_schedule" {
    name        = "jenkins-daily-schedule"
    description = "Start at 07:00, stop at 21:00 daily (Asia/Southeast3)"
    region      = var.region

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

### 3. Existing Service Account Email Reference
* **Observation**:
  - The service account email `cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com` is referenced on:
    - Line 51 (inside `google_compute_instance.jenkins` block under `service_account`):
      `email  = "cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com"`
    - Line 65 (inside `google_project_iam_member.artifact_writer` under `member`):
      `member  = "serviceAccount:cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com"`
    - Line 71 (inside `google_project_iam_member.gke_deployer` under `member`):
      `member  = "serviceAccount:cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com"`
* **Conclusion & Recommendation**:
  - The email is consistently and correctly referenced throughout `main.tf`. No changes are required.

---

## Task 2: GKE Deployment Script (`prod-setup/gcp/deploy.sh`)

* **Observation**:
  - **Project ID**: Line 13 sets `PROJECT_ID="project-4cd20f4a-78e2-4a45-81d"`. (Correct)
  - **Region**: Line 14 sets `REGION="asia-southeast3"`. (Correct)
  - **Authentication**: Line 12 sets `GCP_KEY_FILE="$REPO_ROOT/gcp-key.json"` and line 26 runs `gcloud auth activate-service-account --key-file="$GCP_KEY_FILE"`. (Correct)
  - **Kubectl dry-run flags**:
    We inspected all `kubectl apply` commands in the file:
    - Line 56: `kubectl create namespace cic-prod --dry-run=client -o yaml | kubectl apply --dry-run=client -f -`
    - Line 59: `kubectl apply --dry-run=client -f "$SCRIPT_DIR/manifests/backend-config.yaml"`
    - Line 71: `"$SCRIPT_DIR/manifests/secrets.yaml" | kubectl apply --dry-run=client -f -`
    - Line 73: `kubectl apply --dry-run=client -f "$SCRIPT_DIR/manifests/managed-certificate.yaml"`
    - Line 74: `kubectl apply --dry-run=client -f "$SCRIPT_DIR/manifests/keycloak.yaml"`
    - Line 75: `kubectl apply --dry-run=client -f "$SCRIPT_DIR/manifests/cic-api.yaml"`
    - Line 76: `kubectl apply --dry-run=client -f "$SCRIPT_DIR/manifests/react-admin.yaml"`
    - Line 77: `kubectl apply --dry-run=client -f "$SCRIPT_DIR/manifests/ingress.yaml"`
* **Conclusion & Recommendation**:
  - The script perfectly complies with all parameters. Every single `kubectl apply` call uses `--dry-run=client`. No modifications are required.

---

## Task 3: Jenkins Docker Compose Configuration (`prod-setup/jenkins/docker-compose.yml`)

* **Observation**:
  - **Mounting Key**: Line 22 contains:
    `- ${GCP_KEY_PATH:-/path/to/key.json}:/var/jenkins_home/gcp-key.json`
    This maps the host variable `GCP_KEY_PATH` to `/var/jenkins_home/gcp-key.json`, defaulting to the placeholder `/path/to/key.json` if the host variable is empty/unset.
  - **Environment Variable**: Line 25 contains:
    `- GOOGLE_APPLICATION_CREDENTIALS=/var/jenkins_home/gcp-key.json`
* **Conclusion & Recommendation**:
  - The Docker Compose configuration correctly mounts the credential file and configures the environment variable. No modifications are required.

---

## Task 4: Jenkins Pipeline (`Jenkinsfile`)

* **Observation**:
  - Stage `'Deploy to Production GKE'` (lines 74–88):
    ```groovy
    74:     stage('Deploy to Production GKE') {
    75:         when {
    76:             branch 'main'
    77:         }
    78:         steps {
    79:             script {
    80:                 echo 'Deploying to GKE production cluster...'
    81:                 // Authenticate using VM metadata (service account)
    82:                 sh '''
    83:                     gcloud container clusters get-credentials cic-gke-cluster --region asia-southeast3
    84:                     kubectl apply -f prod-setup/gcp/manifests/
    85:                 '''
    86:             }
    87:         }
    88:     }
    ```
  - **Region**: Region is correctly specified as `asia-southeast3` on line 83.
  - **Authentication**: The command runs `gcloud container clusters get-credentials` directly, without configuring any key file. This relies entirely on the IAM permissions of the host VM (GCE VM Metadata Server), which is correct and secure.
* **Conclusion & Recommendation**:
  - The `Jenkinsfile` meets all requirements. No modifications are required.

---

## Task 5: Jenkins Entrypoint Review (`prod-setup/jenkins/entrypoint.sh`)

### 1. Tini Path Check
* **Observation**:
  - The script uses `/usr/bin/tini` on line 62 and line 68:
    - Line 62: `exec gosu "$JENKINS_USER" /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"`
    - Line 68: `exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"`
  - However, in the standard `jenkins/jenkins:lts` Docker image (which is used as the base in `prod-setup/jenkins/Dockerfile`), the `tini` binary is installed at `/sbin/tini`.
* **Recommendation**:
  - Change all references of `/usr/bin/tini` to `/sbin/tini`.

### 2. Shell Syntax Error on Empty `DOCKER_GID`
* **Observation**:
  - Line 14 resolves the GID: `DOCKER_GID=$(stat -c '%g' "$DOCKER_SOCKET")`.
  - Line 18 performs the check: `if [ "$DOCKER_GID" -lt 100 ]; then`.
  - If the socket exists but `stat` fails (or if `DOCKER_GID` is empty for any reason), unquoted `[ $DOCKER_GID -lt 100 ]` evaluates to `[ -lt 100 ]`, producing:
    `bash: [: -lt: unary operator expected`
  - Even if quoted as `[ "$DOCKER_GID" -lt 100 ]`, it evaluates to `[ "" -lt 100 ]`, producing:
    `bash: [: : integer expression expected`
* **Recommendation**:
  - Make `DOCKER_GID` extraction robust using a fallback, and validate that it is non-empty and contains a valid integer.

### Proposed Code Changes for `prod-setup/jenkins/entrypoint.sh`

#### Before:
```bash
12:     if [ -e "$DOCKER_SOCKET" ]; then
13:         # Dynamically read the GID of the mounted /var/run/docker.sock
14:         DOCKER_GID=$(stat -c '%g' "$DOCKER_SOCKET")
15:         echo "[+] Detected host $DOCKER_SOCKET GID: $DOCKER_GID"
16: 
17:         # Check if the GID is a highly privileged system GID (< 100)
18:         if [ "$DOCKER_GID" -lt 100 ]; then
...
60:     # Drop privileges to the non-root jenkins user using gosu and pass control to tini/jenkins.sh
61:     echo "[+] Dropping privileges to '$JENKINS_USER'..."
62:     exec gosu "$JENKINS_USER" /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
63: else
64:     # Not running as root (e.g. USER jenkins in Dockerfile and no user override in run/compose)
65:     echo "[!] Running as non-root user ($(id -u)). Skipping group/socket GID modification."
66:     
67:     # Hand off to the standard Jenkins entrypoint directly without gosu
68:     exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
69: fi
```

#### After (Proposed Fix):
```bash
    if [ -e "$DOCKER_SOCKET" ]; then
        # Dynamically read the GID of the mounted /var/run/docker.sock
        DOCKER_GID=$(stat -c '%g' "$DOCKER_SOCKET" 2>/dev/null || echo "")
        echo "[+] Detected host $DOCKER_SOCKET GID: $DOCKER_GID"

        # Check if GID is non-empty and a valid integer
        if [ -z "$DOCKER_GID" ] || ! [[ "$DOCKER_GID" =~ ^[0-9]+$ ]]; then
            echo "[!] Host Docker GID is empty or invalid. Skipping group setup."
        # Check if the GID is a highly privileged system GID (< 100)
        elif [ "$DOCKER_GID" -lt 100 ]; then
...
    # Drop privileges to the non-root jenkins user using gosu and pass control to tini/jenkins.sh
    echo "[+] Dropping privileges to '$JENKINS_USER'..."
    exec gosu "$JENKINS_USER" /sbin/tini -- /usr/local/bin/jenkins.sh "$@"
else
    # Not running as root (e.g. USER jenkins in Dockerfile and no user override in run/compose)
    echo "[!] Running as non-root user ($(id -u)). Skipping group/socket GID modification."
    
    # Hand off to the standard Jenkins entrypoint directly without gosu
    exec /sbin/tini -- /usr/local/bin/jenkins.sh "$@"
fi
```

---

## Task 6: Outline for `prod-setup/README.md`

The structure of `prod-setup/README.md` details how to provision, configure, and deploy resources in production:

1. **Title**: `# Production Setup Guide (GCP & Jenkins)`
2. **Overview**: Introduces the purpose of the folder (GCP infrastructure and Jenkins CI/CD config).
3. **Section 1: Terraform Infrastructure Provisioning**
   - **Prerequisites**: Lists required tool (Terraform `>= 1.5.0`) and GCP authentication CLI commands.
   - **Step-by-step Commands**: Clear instructions on running `terraform init`, `terraform plan`, and `terraform apply`.
4. **Section 2: Daily Start/Stop VM Schedule**
   - Details the VM power-saving schedule (Start: `07:00`, Stop: `21:00` daily).
   - *Suggested refinement*: Update timezone from `Asia/Southeast3` to `Asia/Jakarta` to reflect the corrected `instance_schedule_policy` configuration.
5. **Section 3: Jenkins Pipeline Setup**
   - Explains containerization of Jenkins via Docker Compose.
   - **Environment Variables**: Highlights the required host variable `GCP_KEY_PATH`.
   - **Docker Compose Startup**: Guides the user to run `docker-compose up -d`.
   - **Key Mount Details**: Documents how Compose dynamically mounts credentials and maps GID sockets.
6. **Section 4: GCP GKE Deployment Script**
   - Highlights the helper script `deploy.sh` for deploying to GKE.
   - **Prerequisites**: Mentions project ID `project-4cd20f4a-78e2-4a45-81d` and region `asia-southeast3`.
   - **Manifest Verification**: Emphasizes that all `kubectl apply` commands in the script use `--dry-run=client` to safely test manifests without modification.

---

## Task 7: Exact commands to run 'terraform validate'

To run syntax and validation checks on the Terraform configuration:

```bash
# 1. Navigate to the terraform configuration directory
cd prod-setup/gcp/terraform

# 2. Initialize Terraform (required to download the Google/random provider plugins)
terraform init

# 3. Perform the configuration validation check
terraform validate
```
*(Note: Validation checks syntax, block structure, and resource references. It does not require active credentials or inputs for variables without default values.)*
