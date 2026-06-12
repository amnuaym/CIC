# Handoff Report — Explorer Finalization 3

## 1. Observation

Direct observations from the codebase files:

### A. `prod-setup/gcp/terraform/main.tf`
- **Resource Policy**:
  - Located at lines 13-25:
    ```tf
    # ---------- Resource Policy for Daily Start/Stop ----------
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
    ```
- **Service Account Resource**:
  - No `google_service_account` resource block exists in `main.tf` (lines 1-75).
- **Service Account Referencing**:
  - Line 51: `email  = "cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com"`
  - Line 65: `member  = "serviceAccount:cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com"`
  - Line 71: `member  = "serviceAccount:cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com"`

### B. `prod-setup/gcp/deploy.sh`
- **Parameters**:
  - Line 12: `GCP_KEY_FILE="$REPO_ROOT/gcp-key.json"`
  - Line 13: `PROJECT_ID="project-4cd20f4a-78e2-4a45-81d"`
  - Line 14: `REGION="asia-southeast3"`
- **Kubectl dry-run commands**:
  - Lines 56, 59, 71, 73, 74, 75, 76, 77 all use `kubectl apply --dry-run=client` or `kubectl create namespace ... --dry-run=client`.

### C. `prod-setup/jenkins/docker-compose.yml`
- **Volume mount & Env**:
  - Line 22: `- ${GCP_KEY_PATH:-/path/to/key.json}:/var/jenkins_home/gcp-key.json`
  - Line 25: `- GOOGLE_APPLICATION_CREDENTIALS=/var/jenkins_home/gcp-key.json`

### D. Root `Jenkinsfile`
- **Region**:
  - Line 83: `gcloud container clusters get-credentials cic-gke-cluster --region asia-southeast3`
- **Authentication**:
  - No service account key file is used; it relies purely on ambient metadata authentication (GCE VM metadata server).

### E. `prod-setup/jenkins/entrypoint.sh`
- **Tini path**:
  - Line 62: `exec gosu "$JENKINS_USER" /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"`
  - Line 68: `exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"`
- **Syntax checking**:
  - Line 14: `DOCKER_GID=$(stat -c '%g' "$DOCKER_SOCKET")`
  - Line 18: `if [ "$DOCKER_GID" -lt 100 ]; then`

---

## 2. Logic Chain

1. **Terraform VM Scheduling**:
   - The observed `jenkins_schedule` block uses `daily_schedule` inside `schedule`. This is the schema for disk backup schedules. For scheduling GCE VM instances, Terraform and GCP APIs require the `instance_schedule_policy` block.
   - The observed `time_zone = "Asia/Southeast3"` will fail validation because `"Asia/Southeast3"` is not a valid standard IANA timezone name. Changing it to `"Asia/Jakarta"` (the region `asia-southeast3` is located in Jakarta) provides a valid timezone name.
2. **Service Account Resource**:
   - Since no `google_service_account` block is present and the configuration references an existing service account directly via strings, there are no unused service account resource declarations to clean up.
3. **Entrypoint Script (Tini & GID Check)**:
   - In the base image `jenkins/jenkins:lts` (Debian-based), `tini` is installed in `/sbin/tini`, not `/usr/bin/tini`. Thus, the current paths on lines 62 and 68 will result in a `file not found` crash at container startup.
   - If `$DOCKER_SOCKET` is not accessible or `stat` fails, `$DOCKER_GID` is set to an empty string. The conditional `[ "$DOCKER_GID" -lt 100 ]` collapses to `[ -lt 100 ]`, which causes a shell syntax error `unary operator expected` and terminates execution under `set -e`. Therefore, adding a check for `-z "$DOCKER_GID"` prevents syntax and execution errors.

---

## 3. Caveats

- **Validation Check**: Running `terraform validate` requires installing Terraform on the local system, which has not been performed during this read-only investigation.
- **Mock Tests**: The python script `test_entrypoint.py` mocks the `tini` command as a global command in PATH, which hides the path issue in automated tests but would fail in a real Docker container.

---

## 4. Conclusion

- **Terraform**: The `google_compute_resource_policy.jenkins_schedule` block must be updated to use `instance_schedule_policy` with standard cron expressions and `Asia/Jakarta` timezone. The service account reference is correct. No unused service account resources exist.
- **Deployment Script & Docker Compose**: Both `deploy.sh` and `docker-compose.yml` are consistent and correctly handle properties, dry-runs, and path variables.
- **Root Jenkinsfile**: Confirmed to use region `asia-southeast3` and GCE VM metadata server authentication. However, there is an integration gap in `Jenkinsfile` where it applies manifests directly without replacing placeholder values in `secrets.yaml`.
- **Jenkins Entrypoint**: Path `/usr/bin/tini` must be updated to `/sbin/tini`. A check must be added to handle empty `DOCKER_GID` values gracefully.

---

## 5. Verification Method

To verify the suggested changes:
1. Run Terraform validation:
   ```bash
   cd prod-setup/gcp/terraform
   terraform init -backend=false
   terraform validate
   ```
2. Verify Entrypoint script execution by executing `python prod-setup/jenkins/verification/test_entrypoint.py` after patching.
