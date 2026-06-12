# Handoff Report - Reviewer Finalization 1

## 1. Observation

- **Terraform Policy & SA**: In `prod-setup/gcp/terraform/main.tf`, observed the schedule policy configuration:
  ```hcl
  resource "google_compute_resource_policy" "jenkins_schedule" {
    name        = "jenkins-daily-schedule"
    description = "Start at 07:00, stop at 21:00 daily (Asia/Jakarta)"
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
  Verified no `google_service_account` resource block exists. Checked service account usage at line 43:
  ```hcl
    service_account {
      email  = "cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com"
      scopes = ["cloud-platform"]
    }
  ```

- **Deploy Scripts**: In `prod-setup/gcp/deploy.sh`:
  - Line 12: `GCP_KEY_FILE="$REPO_ROOT/gcp-key.json"`
  - Line 13: `PROJECT_ID="project-4cd20f4a-78e2-4a45-81d"`
  - Line 14: `REGION="asia-southeast3"`
  - Lines 20-23:
    ```bash
    if [ ! -f "$GCP_KEY_FILE" ]; then
        echo "[-] Error: GCP Service Account key not found at: $GCP_KEY_FILE"
        exit 1
    fi
    ```
  - All `kubectl apply` commands use `--dry-run=client`, e.g., line 59:
    ```bash
    kubectl apply --dry-run=client -f "$SCRIPT_DIR/manifests/backend-config.yaml"
    ```
  In `prod-setup/gcp/deploy.ps1`, identical configurations were observed:
  - Line 11: `$GcpKeyFile = "$RepoRoot\gcp-key.json"`
  - Line 12: `$ProjectId = "project-4cd20f4a-78e2-4a45-81d"`
  - Line 13: `$Region = "asia-southeast3"`
  - Lines 19-22:
    ```powershell
    if (-not (Test-Path $GcpKeyFile)) {
        Write-Error "[-] GCP Service Account key not found at: $GcpKeyFile"
        exit 1
    }
    ```

- **Jenkins Docker Compose**: In `prod-setup/jenkins/docker-compose.yml`:
  - Line 22: `- ${GCP_KEY_PATH:-/path/to/key.json}:/var/jenkins_home/gcp-key.json`
  - Line 25: `- GOOGLE_APPLICATION_CREDENTIALS=/var/jenkins_home/gcp-key.json`

- **Jenkinsfile**: In `Jenkinsfile` stage `Deploy to Production GKE`:
  - Line 80: `echo 'Deploying to GKE production cluster in region asia-southeast3...'`
  - Lines 81-86:
    ```groovy
    sh '''
        if [ -f "/var/jenkins_home/gcp-key.json" ]; then
            cp /var/jenkins_home/gcp-key.json ./gcp-key.json
        fi
        bash prod-setup/gcp/deploy.sh
    '''
    ```

- **Entrypoint**: In `prod-setup/jenkins/entrypoint.sh`:
  - Line 12: `DOCKER_GID=""`
  - Lines 21-22:
    ```bash
    if [ -z "$DOCKER_GID" ]; then
        echo "[!] Warning: Host Docker GID is empty or socket is missing/unreadable. Skipping alignment/group operations safely."
    ```
  - Lines 67 & 73: `/sbin/tini` is explicitly resolved:
    ```bash
    exec gosu "$JENKINS_USER" /sbin/tini -- /usr/local/bin/jenkins.sh "$@"
    # ...
    exec /sbin/tini -- /usr/local/bin/jenkins.sh "$@"
    ```

- **README**: In `prod-setup/README.md`, verified description of GKE pipeline stage at lines 81-87:
  ```markdown
  ## Jenkinsfile GKE Deployment Stage

  The root `Jenkinsfile` contains the CI/CD pipeline definition:
  - The `Deploy to Production GKE` stage is executed when code is merged into the `main` branch.
  - It copies the GCP service account key from `/var/jenkins_home/gcp-key.json` to the workspace root if it exists, and then executes `prod-setup/gcp/deploy.sh`.
  - The `deploy.sh` script connects to the GKE cluster in region `asia-southeast3`, performs placeholder substitution on `secrets.yaml` (avoiding applying raw manifests with `__JWT_SECRET__` directly), and applies manifests safely with the `--dry-run=client` flag.
  ```

## 2. Logic Chain

- **Terraform**: The resource `google_compute_resource_policy.jenkins_schedule` correctly defines `instance_schedule_policy` with regional configuration (`region = var.region`), standard IANA timezone `Asia/Jakarta`, and daily start/stop hours (`07:00` and `21:00`). The VM correctly references the existing service account, and no new service accounts are generated, meaning Terraform is logically complete and clean.
- **Deploy scripts**: Both scripts are aligned with correct project ID (`project-4cd20f4a-78e2-4a45-81d`) and region (`asia-southeast3`), authenticate with `gcp-key.json` relative to repo root, and use `--dry-run=client` for all applies.
- **Jenkins Compose**: Setting up the volume mount optionally and defining `GOOGLE_APPLICATION_CREDENTIALS` matches the requirements.
- **Entrypoint**: Resolving `/sbin/tini` explicitly and using `[ -z "$DOCKER_GID" ]` to handle empty values avoids typical shell execution exceptions.
- **Key finding (discrepancy)**: In `deploy.sh` and `deploy.ps1`, the script forces the exit of the pipeline if the service account key `gcp-key.json` is missing. This breaks the requirement that the pipeline should support using VM metadata credentials if running on the Jenkins GCE VM instance.
- **Dry-run rollout finding**: Because `--dry-run=client` prevents GKE resources from being created, `kubectl rollout status` checks will fail on clusters where the resources are not pre-existing.

## 3. Caveats

- Checked the configurations using static analysis due to the lack of live credentials and non-interactive shell limits. No live deployment was performed.

## 4. Conclusion

The worker has completed the vast majority of the tasks with clean and robust code, but two issues prevent approval: (1) lack of fallback in `deploy.sh`/`deploy.ps1` for VM service account metadata credentials when the key file is missing, and (2) rollout checks failing in dry-run mode. A verdict of `REQUEST_CHANGES` is issued.

## 5. Verification Method

- Check `D:\Github\cic\.agents\reviewer_finalization_1\review.md` to see the full detailed review findings.
- Inspect `prod-setup/gcp/deploy.sh` and try executing it without `gcp-key.json` to verify that it exits immediately on line 22 instead of falling back to default VM credentials.
- Confirm that `deploy.ps1` does the same.
