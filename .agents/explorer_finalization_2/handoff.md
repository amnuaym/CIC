# Handoff Report — Explorer Finalization 2

## 1. Observation

- **Terraform Policy configuration (`prod-setup/gcp/terraform/main.tf` lines 14-25)**:
  ```tf
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
- **Terraform Service Account References (`prod-setup/gcp/terraform/main.tf`)**:
  - Line 51: `email  = "cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com"`
  - Line 65: `member  = "serviceAccount:cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com"`
  - Line 71: `member  = "serviceAccount:cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com"`
  - There is no `google_service_account` resource block defined in the terraform folder files (`main.tf`, `variables.tf`, `providers.tf`, `outputs.tf`).
- **GKE Deploy Script (`prod-setup/gcp/deploy.sh`)**:
  - Line 12: `GCP_KEY_FILE="$REPO_ROOT/gcp-key.json"`
  - Line 13: `PROJECT_ID="project-4cd20f4a-78e2-4a45-81d"`
  - Line 14: `REGION="asia-southeast3"`
  - Line 26: `gcloud auth activate-service-account --key-file="$GCP_KEY_FILE"`
  - Lines 56, 59, 71, 73-77: All `kubectl apply` commands include the `--dry-run=client` flag.
- **Jenkins Compose (`prod-setup/jenkins/docker-compose.yml`)**:
  - Line 22: `- ${GCP_KEY_PATH:-/path/to/key.json}:/var/jenkins_home/gcp-key.json`
  - Line 25: `- GOOGLE_APPLICATION_CREDENTIALS=/var/jenkins_home/gcp-key.json`
- **Root Jenkinsfile (`Jenkinsfile`)**:
  - Line 83: `gcloud container clusters get-credentials cic-gke-cluster --region asia-southeast3`
  - Line 84: `kubectl apply -f prod-setup/gcp/manifests/` (relying on implicit default VM credentials).
- **Jenkins Entrypoint (`prod-setup/jenkins/entrypoint.sh`)**:
  - Line 14: `DOCKER_GID=$(stat -c '%g' "$DOCKER_SOCKET")`
  - Line 18: `if [ "$DOCKER_GID" -lt 100 ]; then`
  - Line 62: `exec gosu "$JENKINS_USER" /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"`
  - Line 68: `exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"`
- **Jenkins Base Image (`prod-setup/jenkins/Dockerfile` line 1)**:
  - `FROM jenkins/jenkins:lts`

## 2. Logic Chain

1. **VM Scheduling Policy:** GCE VM instance start/stop schedules must use the `instance_schedule_policy` block inside `google_compute_resource_policy` instead of the `schedule.daily_schedule` block (which is for backup snapshots). Setting `daily_schedule` for VM start/stop will fail GCP resource policy attachment.
2. **Timezone:** Standard IANA timezone names are required by GCP APIs. `"Asia/Southeast3"` is not a valid IANA timezone (valid options include `"Asia/Singapore"`, `"Asia/Bangkok"`, etc.). Using an invalid timezone name will result in Terraform provisioning failures.
3. **Jenkins Entrypoint Tini Path:** In the official `jenkins/jenkins:lts` image, the `tini` binary is installed at `/sbin/tini`, not `/usr/bin/tini`. Running the entrypoint with `/usr/bin/tini` causes startup failures.
4. **Shell syntax crash:** If `DOCKER_GID` is empty (e.g. if the socket doesn't exist, stat fails, or file permissions prevent reading GID), the command `[ "$DOCKER_GID" -lt 100 ]` evaluates to `[ "" -lt 100 ]`, which throws a runtime shell error. Validating that `DOCKER_GID` is a non-empty numeric string resolves this.

## 3. Caveats

- **Active GCP Environment:** Since we are operating in CODE_ONLY network mode and under a read-only mandate, we did not verify deployment against a live GCP project or GKE cluster.
- **Region "asia-southeast3":** Google Cloud Platform does not have a physical region named `asia-southeast3`. We assumed this is either a simulated environment or a legacy/custom project specification, so we did not recommend changing it to standard regions like `asia-southeast1` or `asia-southeast2` unless explicitly asked.

## 4. Conclusion

- The repository configuration files are mostly consistent and well-aligned, except for:
  1. An incorrect Terraform daily VM power schedule definition.
  2. An invalid IANA timezone reference.
  3. An incorrect path to `tini` inside the Jenkins docker entrypoint.
  4. A potential runtime shell crash in the entrypoint script when `DOCKER_GID` is empty.
- Applying the recommended changes outlined in `analysis.md` will resolve these issues.

## 5. Verification Method

- **Terraform Validation:**
  Run the validation command inside the Terraform directory:
  ```bash
  cd prod-setup/gcp/terraform
  terraform init -backend=false
  terraform validate
  ```
- **Tini path verification:**
  Locally verify the location of `tini` inside the Jenkins LTS container:
  ```bash
  docker run --rm --entrypoint sh jenkins/jenkins:lts -c 'which tini'
  ```
  Expected output: `/sbin/tini`
- **Shell syntax verification:**
  Test the modified `entrypoint.sh` by running it in a shell where the docker socket path does not exist, and confirm that it skips GID alignment cleanly without throwing a bash syntax/integer evaluation error.
