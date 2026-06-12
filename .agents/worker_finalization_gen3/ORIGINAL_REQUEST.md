## 2026-06-12T03:27:24Z
You are the worker_finalization_gen3 subagent (remediation worker).
Your working directory is D:\Github\cic\.agents\worker_finalization_gen3.
Your task is to implement the 7 finalization tasks for the CIC project:

1. Fix the Terraform configuration in prod-setup/gcp/terraform/ to ensure it is valid and consistent:
   - In main.tf, update the google_compute_resource_policy.jenkins_schedule to use instance_schedule_policy with standard cron schedules (Start at 07:00: "0 7 * * *", Stop at 21:00: "0 21 * * *") and timezone "Asia/Jakarta" (a valid standard IANA timezone).
   - Ensure main.tf uses the hardcoded service account email "cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com" directly. Remove the commented-out google_service_account block.
   - Remove duplicate required provider blocks and duplicate project_id/region/zone variables across main.tf, variables.tf, and providers.tf. Keep required providers in providers.tf, and variables in variables.tf.
   - Clean up outputs.tf to remove non-existent resource output variables (such as load_balancer_ip, database_private_ip, database_name) to prevent compilation/plan errors. Replace them with relevant outputs (like VM instance name/zone).

2. Fix prod-setup/jenkins/entrypoint.sh:
   - Change tini path from /usr/bin/tini to the correct path /sbin/tini.
   - Prevent shell syntax errors on empty GID values. Modify DOCKER_GID resolution to: DOCKER_GID=$(stat -c '%g' "$DOCKER_SOCKET" 2>/dev/null || echo "")
   - Add a check if [ -z "$DOCKER_GID" ] to skip alignment/group operations safely if the socket is missing or unreadable.

3. Update prod-setup/jenkins/docker-compose.yml:
   - Optionally mount the service-account key if GCP_KEY_PATH is provided on host: use volume mapping `- ${GCP_KEY_PATH:-/path/to/key.json}:/var/jenkins_home/gcp-key.json`
   - Add environment variable GOOGLE_APPLICATION_CREDENTIALS=/var/jenkins_home/gcp-key.json to the container.

4. Update prod-setup/gcp/deploy.sh:
   - Set PROJECT_ID="project-4cd20f4a-78e2-4a45-81d", REGION="asia-southeast3".
   - Use the service account key gcp-key.json.
   - Add --dry-run=client flags to all 8 kubectl apply commands.

5. Update the root Jenkinsfile GKE deploy stage:
   - Ensure it references region asia-southeast3.
   - Ensure it runs the deploy.sh script or performs placeholder substitution before applying manifests, rather than applying raw manifests with __JWT_SECRET__ directly.

6. Create/update prod-setup/README.md:
   - Document how to initialize Terraform, apply it, and run the Jenkins pipeline, including the daily schedule info.

7. Run terraform validate on prod-setup/gcp/terraform/ (you may propose a run_command for the user to approve) to verify correctness.

MANDATORY INTEGRITY WARNING:
DO NOT CHEAT. All implementations must be genuine. DO NOT hardcode test results, create dummy/facade implementations, or circumvent the intended task. A Forensic Auditor will independently verify your work. Integrity violations WILL be detected and your work WILL be rejected.

Save your changes report to D:\Github\cic\.agents\worker_finalization_gen3\handoff.md and progress in D:\Github\cic\.agents\worker_finalization_gen3\progress.md. Message the Project Orchestrator once complete.
