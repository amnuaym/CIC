## 2026-06-11T05:40:01Z

You are teamwork_preview_worker. Your working directory is D:/Github/cic/.agents/worker_finalization_1.
Your objective is to implement the following changes in the codebase:

MANDATORY INTEGRITY WARNING:
DO NOT CHEAT. All implementations must be genuine. DO NOT hardcode test results, create dummy/facade implementations, or circumvent the intended task. A Forensic Auditor will independently verify your work. Integrity violations WILL be detected and your work WILL be rejected.

Task details:
1. Update `prod-setup/gcp/terraform/main.tf`:
   - Remove duplicate provider "google" block (lines 11-15).
   - Remove duplicate variable declarations at the bottom of the file (lines 78-93).
   - In `google_project_iam_member.artifact_writer` and `google_project_iam_member.gke_deployer`, replace `serviceAccount:${google_service_account.jenkins_sa.email}` with `serviceAccount:cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com`.
   - Ensure the resource policy `jenkins_schedule` for daily start/stop is intact.
2. Update `prod-setup/gcp/terraform/variables.tf`:
   - Set the default of `project_id` to `"project-4cd20f4a-78e2-4a45-81d"`.
   - Set the default of `region` to `"asia-southeast3"`.
   - Add `variable "zone"` with default `"asia-southeast3-c"`.
3. Update `prod-setup/gcp/terraform/providers.tf`:
   - Ensure `provider "google"` specifies `zone = var.zone` in addition to `project` and `region`.
4. Update `prod-setup/gcp/terraform/outputs.tf`:
   - Remove all the outputs referencing non-existent resources (`load_balancer_ip`, `database_private_ip`, `database_name`).
   - Add output `jenkins_instance_name` returning `google_compute_instance.jenkins.name`.
   - Add output `jenkins_instance_zone` returning `google_compute_instance.jenkins.zone`.
5. Update `prod-setup/gcp/deploy.sh`:
   - Ensure `PROJECT_ID="project-4cd20f4a-78e2-4a45-81d"` and `REGION="asia-southeast3"`.
   - Ensure it uses the existing service-account key path `GCP_KEY_FILE="$REPO_ROOT/gcp-key.json"`.
   - Add `--dry-run=client` to ALL `kubectl apply` commands. There are 8 such commands in the script.
6. Update `prod-setup/jenkins/docker-compose.yml`:
   - Add a volume mapping: `- ${GCP_KEY_PATH:-/path/to/key.json}:/var/jenkins_home/gcp-key.json`
   - Add environment variable: `GOOGLE_APPLICATION_CREDENTIALS=/var/jenkins_home/gcp-key.json` under `environment:`.
7. Ensure that the root `Jenkinsfile` stage `Deploy to Production GKE` references the correct region (`asia-southeast3`) and uses the service-account attached to the VM (no extra credentials/keys loaded).
8. Create `prod-setup/README.md` summarizing:
   - How to initialize Terraform (`terraform init`) and apply it (`terraform apply`).
   - Daily start/stop schedule details (Start: 07:00, Stop: 21:00 daily in timezone `Asia/Southeast3`).
   - How to run the Jenkins pipeline (Docker Compose setup, environment variable requirements).
   - How to execute the GCP deployment script.

Write a handoff report documenting the changes made to `D:/Github/cic/.agents/worker_finalization_1/handoff.md` and then send a message to the orchestrator (conversation ID: 782c7f6f-4ca9-49c5-b649-0695368e308e) when done.
