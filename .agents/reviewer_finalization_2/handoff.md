# Handoff Report - Reviewer 2

## 1. Observation

Direct observations from the files in the workspace:

- **Terraform Schedule Policy**: In `prod-setup/gcp/terraform/main.tf` (lines 3–17):
  ```tf
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
  And no `google_service_account` resource block exists in this file. The VM instance in `main.tf` (lines 42–45) uses:
  ```tf
    service_account {
      email  = "cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com"
      scopes = ["cloud-platform"]
    }
  ```

- **Deployment Script Configs & Authentication**: In `prod-setup/gcp/deploy.sh` (lines 11–26):
  ```bash
  # --- Deployment Configuration ---
  GCP_KEY_FILE="$REPO_ROOT/gcp-key.json"
  PROJECT_ID="project-4cd20f4a-78e2-4a45-81d"
  REGION="asia-southeast3"
  ...
  # 1. Verification
  if [ ! -f "$GCP_KEY_FILE" ]; then
      echo "[-] Error: GCP Service Account key not found at: $GCP_KEY_FILE"
      exit 1
  fi

  echo "[+] Authenticating using Service Account Key..."
  gcloud auth activate-service-account --key-file="$GCP_KEY_FILE"
  ```
  The PowerShell equivalent `prod-setup/gcp/deploy.ps1` (lines 10–25) performs an identical check and authentication using `$GcpKeyFile`.

- **Kubernetes dry-run**: In `prod-setup/gcp/deploy.sh` and `prod-setup/gcp/deploy.ps1`, all `kubectl apply` commands include the `--dry-run=client` flag. For example:
  ```bash
  kubectl apply --dry-run=client -f "$SCRIPT_DIR/manifests/backend-config.yaml"
  ```

- **Docker Compose optional GCP key mount**: In `prod-setup/jenkins/docker-compose.yml` (line 22):
  ```yaml
        - ${GCP_KEY_PATH:-/path/to/key.json}:/var/jenkins_home/gcp-key.json
  ```
  And environment variables in `docker-compose.yml` (line 25):
  ```yaml
        - GOOGLE_APPLICATION_CREDENTIALS=/var/jenkins_home/gcp-key.json
  ```

- **Jenkinsfile GKE Deployment stage**: In the root `Jenkinsfile` (lines 74–89):
  ```groovy
      stage('Deploy to Production GKE') {
          when {
              branch 'main'
          }
          steps {
              script {
                  echo 'Deploying to GKE production cluster in region asia-southeast3...'
                  sh '''
                      if [ -f "/var/jenkins_home/gcp-key.json" ]; then
                          cp /var/jenkins_home/gcp-key.json ./gcp-key.json
                      fi
                      bash prod-setup/gcp/deploy.sh
                  '''
              }
          }
      }
  ```

- **Entrypoint script resolution**: In `prod-setup/jenkins/entrypoint.sh` (lines 65–74):
  ```bash
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
  Empty GID handling in `entrypoint.sh` (lines 21–23):
  ```bash
      if [ -z "$DOCKER_GID" ]; then
          echo "[!] Warning: Host Docker GID is empty or socket is missing/unreadable. Skipping alignment/group operations safely."
  ```

- **README Pipeline alignment**: In `prod-setup/README.md` (lines 81–87):
  ```markdown
  ## Jenkinsfile GKE Deployment Stage

  The root `Jenkinsfile` contains the CI/CD pipeline definition:
  - The `Deploy to Production GKE` stage is executed when code is merged into the `main` branch.
  - It copies the GCP service account key from `/var/jenkins_home/gcp-key.json` to the workspace root if it exists, and then executes `prod-setup/gcp/deploy.sh`.
  ```

## 2. Logic Chain

1. The user request asks to verify that the `Jenkinsfile` stage `Deploy to Production GKE` references region `asia-southeast3` and uses VM service account metadata credentials.
2. Based on the observation of the root `Jenkinsfile` stage `Deploy to Production GKE`, the script copies `/var/jenkins_home/gcp-key.json` to `./gcp-key.json` and runs `bash prod-setup/gcp/deploy.sh`.
3. Based on the observation of `prod-setup/gcp/deploy.sh`, the script terminates with exit code 1 if `gcp-key.json` is missing and runs `gcloud auth activate-service-account --key-file="$GCP_KEY_FILE"`.
4. Therefore, the deployment pipeline does not use VM service account metadata credentials; it explicitly mandates and authenticates with a static JSON key file.
5. The `deploy.sh` and `deploy.ps1` scripts have matching project IDs, regions, and both have `--dry-run=client` on all apply commands.
6. The `docker-compose.yml` mounts the key optionally and sets `GOOGLE_APPLICATION_CREDENTIALS`.
7. The `entrypoint.sh` resolves `/sbin/tini` and gracefully checks for empty `DOCKER_GID`.
8. The `README.md` aligns with the actual implementation (key-copying behavior) but inherits the discrepancy concerning metadata credentials.

## 3. Caveats

- We did not connect to the actual GCP project (`project-4cd20f4a-78e2-4a45-81d`) or the GKE cluster (`cic-gke-cluster`) as we operate in a review-only subagent environment and do not possess credentials.
- Execution tests of the entrypoint via python (`test_entrypoint.py`) were analyzed statically because the interactive command executor timed out waiting for manual authorization on the system shell.

## 4. Conclusion

The review verdict is **REQUEST_CHANGES**. The deployment scripts must be amended to allow optional bypass/fallback of the service account key check to enable VM service account metadata credentials when run in GCP instances. All other verification checklist items are correct, consistent, and satisfy project constraints.

## 5. Verification Method

To independently verify the configurations:
1. View `prod-setup/gcp/terraform/main.tf` to verify the `instance_schedule_policy` settings and service account references.
2. View `prod-setup/gcp/deploy.sh` and `prod-setup/gcp/deploy.ps1` to check variables and confirm `--dry-run=client` is used on all `kubectl apply` lines.
3. View `Jenkinsfile` and `prod-setup/README.md` to confirm the discrepancy on VM service account credentials vs static key usage.
4. View `prod-setup/jenkins/entrypoint.sh` to confirm `/sbin/tini` references and `DOCKER_GID` warning logs.
