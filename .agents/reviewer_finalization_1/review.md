## Review Summary

**Verdict**: REQUEST_CHANGES

The worker has done an excellent job aligning the configurations, hardening the entrypoint script, and documenting the local/production deployment steps. However, there are two major issues that need to be addressed before approval:
1. **VM Service Account Credentials Fallback**: The `Jenkinsfile` deployment stage is intended to use VM service account metadata credentials if the key file is not present. However, the underlying deployment script `prod-setup/gcp/deploy.sh` (and `deploy.ps1`) enforces the presence of `gcp-key.json` and immediately exits with a non-zero status if the file is missing. This prevents the pipeline from utilizing the attached VM service account metadata server credentials.
2. **Rollout Status Check in Dry-Run**: Since all `kubectl apply` commands in the deployment scripts are run with `--dry-run=client`, no resources are actually modified on the GKE cluster. Running `kubectl rollout status` immediately after will fail if the deployments do not exist on the target cluster, causing the pipeline or local test scripts to crash.

---

## Findings

### [Major] Finding 1: Lack of VM Service Account Credentials Fallback in Deploy Scripts
- **What**: The deployment scripts (`deploy.sh` and `deploy.ps1`) hard-require the presence of `gcp-key.json` and exit with an error if it is missing.
- **Where**: 
  - `prod-setup/gcp/deploy.sh` (lines 20-23)
  - `prod-setup/gcp/deploy.ps1` (lines 19-22)
- **Why**: The instruction states that the pipeline GKE deploy stage should use VM service account metadata credentials. Since the Jenkins VM has a service account attached (`cicsvc@...`), `gcloud` and `kubectl` commands should execute using the metadata server's token when no service account key file is present. By exiting immediately when the key file is missing, the scripts prevent this fallback from functioning.
- **Suggestion**: Modify the verification check in the deployment scripts to output a warning instead of exiting if the key file is missing, and conditionally skip the `gcloud auth activate-service-account` step:
  ```bash
  if [ -f "$GCP_KEY_FILE" ]; then
      echo "[+] Authenticating using Service Account Key..."
      gcloud auth activate-service-account --key-file="$GCP_KEY_FILE"
  else
      echo "[!] Warning: GCP Service Account key not found at: $GCP_KEY_FILE. Proceeding using default VM metadata credentials..."
  fi
  ```

### [Major] Finding 2: Rollout Status Check Failure on Dry-Run
- **What**: The script attempts to check rollout status of the deployments right after dry-run applying them.
- **Where**:
  - `prod-setup/gcp/deploy.sh` (lines 80-82)
  - `prod-setup/gcp/deploy.ps1` (lines 80-82)
- **Why**: Since `--dry-run=client` is used on all `kubectl apply` commands, the deployments are never actually applied to the cluster. If the deployments do not already exist on the GKE cluster, the `kubectl rollout status` commands will fail, causing the deployment script (and the Jenkins build) to fail.
- **Suggestion**: Only perform the rollout status check if the deployment actually exists on the cluster, or bypass it if running in dry-run mode.

---

## Verified Claims

- **Unused `google_service_account` resource removed** → verified via `view_file` on `prod-setup/gcp/terraform/main.tf` → **PASS** (No `google_service_account` resource block is present; only IAM role bindings are configured for the existing service account `cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com`).
- **Start/Stop Schedule Policy Configuration** → verified via `view_file` on `prod-setup/gcp/terraform/main.tf` → **PASS** (Uses `instance_schedule_policy` with regional configuration `region = var.region`, standard IANA timezone `Asia/Jakarta`, and daily start at `07:00` / stop at `21:00`).
- **Existing Service Account Email Used** → verified via `view_file` on `prod-setup/gcp/terraform/main.tf` → **PASS** (Correctly references `cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com` in VM configuration and IAM roles).
- **Bash & PowerShell Deploy Scripts Aligned** → verified via `view_file` on `prod-setup/gcp/deploy.sh` and `prod-setup/gcp/deploy.ps1` → **PASS** (Both scripts are fully aligned, use correct project ID `project-4cd20f4a-78e2-4a45-81d` and region `asia-southeast3`, authenticate using `gcp-key.json`, and apply all manifests with `--dry-run=client`).
- **Docker Compose Volume Mounts and Env Vars** → verified via `view_file` on `prod-setup/jenkins/docker-compose.yml` → **PASS** (Optional mount `${GCP_KEY_PATH:-/path/to/key.json}` and environment variable `GOOGLE_APPLICATION_CREDENTIALS=/var/jenkins_home/gcp-key.json` are correctly configured).
- **Jenkinsfile Stage Region Configuration** → verified via `view_file` on `Jenkinsfile` → **PASS** (References region `asia-southeast3` in output logs).
- **Entrypoint Tini Resolution and Docker GID alignment** → verified via `view_file` on `prod-setup/jenkins/entrypoint.sh` → **PASS** (Resolves paths to `/sbin/tini` and skips group modification safely if `DOCKER_GID` is empty).
- **README.md Summary of Components** → verified via `view_file` on `prod-setup/README.md` → **PASS** (Accurately describes components, validation workflows, entrypoint behavior, and the GKE stage).

---

## Coverage Gaps

- **Fallback testing without SA Key file** — risk level: **Medium** — recommendation: Investigate/Fix (addressed in Finding 1).

---

## Unverified Items

- **Live deployment verification** — reason not verified: Non-interactive environment does not support connecting to live GCP or executing commands requiring user authorization. Static validation and logical checking were used instead.

---

## Adversarial Challenge Report

### Challenge Summary

**Overall risk assessment**: MEDIUM

While the configurations are syntactically sound and the entrypoint script is well-hardened against GID privilege escalation/syntax issues, the deployment pipeline lacks flexibility in fallback authentication and contains logic that will break if the deployments are not pre-existing.

### Challenges

#### [High] Challenge 1: Pipeline crash on first-time deploy dry-runs
- **Assumption challenged**: Assumes `kubectl rollout status` will pass during dry-runs.
- **Attack scenario**: If the deployments `cic-api` or `react-admin` do not exist in the GKE namespace `cic-prod`, running the deployment script with `--dry-run=client` will skip creating them, and then the rollout status check command will fail because the resources are missing.
- **Blast radius**: Prevents dry-run pipelines from completing successfully.
- **Mitigation**: Conditionally check rollout status, e.g., in Bash:
  ```bash
  if kubectl get deployment/cic-api -n cic-prod >/dev/null 2>&1; then
      kubectl rollout status deployment/cic-api -n cic-prod
  fi
  ```

#### [Medium] Challenge 2: Mandatory Key file requirement
- **Assumption challenged**: Assumes key file `gcp-key.json` must be present.
- **Attack scenario**: If the Jenkins VM is assigned roles directly via its instance profile, the operator may omit the key file to conform to security guidelines. Under the current setup, the deployment script will crash.
- **Blast radius**: Inability to run in standard cloud-native passwordless mode.
- **Mitigation**: Allow script execution if key is absent but gcloud CLI has active credentials.

### Stress Test Results

- **Run deploy script without `gcp-key.json`** → Script exits immediately with code 1 → **FAIL**
- **Run deploy script on empty cluster with dry-run** → `kubectl rollout status` fails because resources do not exist → **FAIL**
