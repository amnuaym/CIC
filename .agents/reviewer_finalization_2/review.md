# Review and Challenge Report

---

# Part 1: Quality Review

## Review Summary

**Verdict**: REQUEST_CHANGES

The worker has done an excellent job of ensuring shell alignment between `deploy.sh` and `deploy.ps1`, securing the Jenkins Docker entrypoint against empty GID and privilege escalation risks, and configuring the Terraform VM schedule policy correctly. 

However, there is a major discrepancy regarding service account credential usage: the user request specifies that the `Jenkinsfile` GKE deployment stage should use **VM service account metadata credentials**. Currently, the `Jenkinsfile` stage and the underlying `deploy.sh` script explicitly require a static `gcp-key.json` file to be present in the workspace root, failing immediately with a hard error if the file is absent. As such, the setup does not support VM service account metadata credentials.

Additionally, all `kubectl apply` commands use `--dry-run=client`. While safe for verification, this prevents actual deployment, which should be documented or parameterized.

---

## Findings

### [Major] Finding 1: Lack of VM Service Account Metadata Credentials Support in Deployment Stage

- **What**: The GKE deployment pipeline stage and the GKE deploy script do not support VM service account metadata credentials.
- **Where**: `Jenkinsfile` (Lines 74–89) and `prod-setup/gcp/deploy.sh` (Lines 11–26) / `prod-setup/gcp/deploy.ps1` (Lines 10–25).
- **Why**: The `deploy.sh` script enforces a hard check on `$GCP_KEY_FILE` (`gcp-key.json` in the workspace root). If the file is missing, the script prints an error and exits with code 1. Therefore, when running on a GCE VM (where VM service account metadata credentials would normally be available via the instance metadata service), the script fails instead of falling back to default/metadata credentials.
- **Suggestion**: Modify `prod-setup/gcp/deploy.sh` and `prod-setup/gcp/deploy.ps1` to check if `gcp-key.json` is present. If it is present, run the `gcloud auth activate-service-account` authentication. If it is missing, log a warning and proceed without manual key authentication, allowing `gcloud` and `kubectl` to fall back to the VM instance metadata credentials:
  ```bash
  if [ -f "$GCP_KEY_FILE" ]; then
      echo "[+] Authenticating using Service Account Key..."
      gcloud auth activate-service-account --key-file="$GCP_KEY_FILE"
  else
      echo "[!] GCP Service Account key not found at: $GCP_KEY_FILE. Proceeding using VM Service Account metadata credentials..."
  fi
  ```

### [Minor] Finding 2: All `kubectl apply` Commands Forced to Dry-Run Mode

- **What**: All Kubernetes manifests are applied using `--dry-run=client`.
- **Where**: `prod-setup/gcp/deploy.sh` (Lines 56, 59, 71, 73–77) and `prod-setup/gcp/deploy.ps1` (Lines 57, 60, 71, 73–77).
- **Why**: While this fulfills the safety constraint requested, it means running the pipeline or deploy scripts will never actually mutate the GKE cluster or deploy/update the application in production. The subsequent `kubectl rollout status` checks will either check a stale/previous deployment state or fail entirely if no deployment exists.
- **Suggestion**: Document in the README that the scripts currently operate in validation-only (dry-run) mode and that the `--dry-run=client` flag must be removed or parameterized for real-world deployments.

---

## Verified Claims

- **Unused `google_service_account` resource removed** → verified via checking `prod-setup/gcp/terraform/main.tf` and `variables.tf` (no such resource block exists) → **PASS**
- **Terraform VM daily start/stop schedule policy configured correctly** → verified via checking `prod-setup/gcp/terraform/main.tf` lines 3–17 (`instance_schedule_policy` defined with region `var.region`, start at `07:00` (`0 7 * * *`), stop at `21:00` (`0 21 * * *`), and IANA timezone `Asia/Jakarta`) → **PASS**
- **Existing service account email used in Terraform VM & IAM** → verified via checking `prod-setup/gcp/terraform/main.tf` lines 43, 57, and 63 (references `cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com` correctly) → **PASS**
- **Bash and PowerShell deploy scripts are aligned** → verified via side-by-side comparison of `prod-setup/gcp/deploy.sh` and `deploy.ps1` variables and structural logic → **PASS**
- **Deploy scripts configured with correct Project ID, Region, and Key File** → verified via checking config variables in `deploy.sh` (Lines 12-14) and `deploy.ps1` (Lines 11-13) → **PASS**
- **All `kubectl apply` commands use `--dry-run=client`** → verified via grep checking of all `kubectl apply` calls in both deploy scripts → **PASS**
- **Docker Compose mounts the key file optionally** → verified via checking `prod-setup/jenkins/docker-compose.yml` line 22 (`${GCP_KEY_PATH:-/path/to/key.json}:/var/jenkins_home/gcp-key.json`) → **PASS**
- **Docker Compose sets `GOOGLE_APPLICATION_CREDENTIALS`** → verified via checking `prod-setup/jenkins/docker-compose.yml` line 25 (`GOOGLE_APPLICATION_CREDENTIALS=/var/jenkins_home/gcp-key.json`) → **PASS**
- **Jenkinsfile stage `Deploy to Production GKE` references region `asia-southeast3`** → verified via checking `Jenkinsfile` line 80 (`echo 'Deploying to GKE production cluster in region asia-southeast3...'`) → **PASS**
- **Entrypoint script resolves path to `/sbin/tini`** → verified via checking `prod-setup/jenkins/entrypoint.sh` lines 67 and 73 → **PASS**
- **Entrypoint script handles empty `DOCKER_GID` values gracefully** → verified via checking `prod-setup/jenkins/entrypoint.sh` lines 21–23 (logs a warning and skips group setup) → **PASS**
- **README accurately summarizes components** → verified via checking `prod-setup/README.md` which covers GCE VM schedule policy, Docker Compose setup, `deploy.sh`/`deploy.ps1` scripts, and the Jenkinsfile GKE deployment stage → **PASS**

---

## Coverage Gaps

- **Real GKE Connectivity and Deployment** — risk level: **Medium** — The deploy scripts' dry-run configuration prevents live tests on the Kubernetes cluster. We accept this validation risk because we are verifying safety and syntax configuration conformance.
- **Dynamic Group Creation Permissions** — risk level: **Low** — The entrypoint script attempts to run `groupadd` and `usermod` as root, but if the container's `/etc/group` is read-only, it will output errors. The entrypoint script does not explicitly handle write errors on `/etc/group` when dropping privileges, though it has fallback mock testing. We accept this risk as the container runs with `user: root` in docker-compose.

---

## Unverified Items

- **Real pipeline execution against GKE** — reason not verified: We do not have a live GKE cluster `cic-gke-cluster` or GCP project credentials to run the actual deploy steps. Live connection credentials were not provided.

---

# Part 2: Adversarial Challenge Report

## Challenge Summary

**Overall risk assessment**: MEDIUM

Our adversarial challenge is focused on potential failures in credential fallbacks, false positives in deployment verification, and privilege/functional limitations under restricted environments.

---

## Challenges

### [High] Challenge 1: Pipeline failure on GCE VM due to missing fallback in `deploy.sh`/`deploy.ps1`
- **Assumption challenged**: The GKE deploy scripts assume that a static service account key file is always required and available.
- **Attack scenario**: When the Jenkins CI/CD pipeline runs on the GCE VM created via Terraform (which is already bound to the service account `cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com`), the static key `gcp-key.json` is not provided. `deploy.sh` initiates, verifies the file does not exist, and exits with code 1 immediately.
- **Blast radius**: Prevents the pipeline from running on GCP VM instances using their native identity/credentials, breaking the deployment pipeline unless a static key is manually generated and mounted.
- **Mitigation**: Update deploy scripts to conditionally skip `gcloud auth activate-service-account` if the key file is missing, relying instead on ambient credentials.

### [Medium] Challenge 2: False Positive Deployment Validation
- **Assumption challenged**: Using `--dry-run=client` for all `kubectl apply` commands validates the full deployment process.
- **Attack scenario**: 
  1. A developer pushes code changes.
  2. The Jenkins build runs, creating Docker images and pushing them.
  3. The `Deploy to Production GKE` stage executes. `kubectl apply --dry-run=client` validates the syntax and exits cleanly without applying the new image version to the GKE cluster.
  4. The script executes `kubectl rollout status deployment/cic-api -n cic-prod`. Since the deployment was not updated, `rollout status` checks the *previously* deployed container version. It returns a success code.
  5. The pipeline marks the build as **SUCCESS** and completes.
  6. The live production server runs the outdated application.
- **Blast radius**: System remains unupdated in production, and teams receive false confirmation of a successful deployment.
- **Mitigation**: Make the dry-run behavior configurable via a CLI parameter or environment variable (e.g. `DRY_RUN=true/false`). In CI, it should be set to `false` for actual deployments.

### [Low] Challenge 3: Jenkins Docker Socket Permission Failure Under GID Collision
- **Assumption challenged**: Jenkins can always use Docker commands in the container.
- **Attack scenario**: If the host GID of `/var/run/docker.sock` is `< 100` (e.g., matching a system group on the host like `shadow`), the entrypoint script skips group creation to prevent privilege escalation.
- **Blast radius**: The `jenkins` user will not be added to a group with GID `< 100`, resulting in `Permission denied` when Jenkins tries to connect to `/var/run/docker.sock` inside the pipeline (e.g., during testing or image building).
- **Mitigation**: Ensure that in the host VM setup, the `docker` group GID is assigned a standard non-system GID (>= 100).
