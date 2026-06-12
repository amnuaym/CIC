# Original User Request

## 2026-06-11T05:37:08Z

You are the teamwork_preview_orchestrator for the finalization milestone of the CIC project CI/CD infrastructure.
Your working directory is: D:/Github/cic/.agents/orchestrator_finalization
You are given the user's request, which has been recorded in D:/Github/cic/.agents/ORIGINAL_REQUEST.md.

Your objective is to coordinate the completion of the following tasks:
1. Verify that the Terraform configuration (`prod-setup/gcp/terraform/main.tf`) is consistent: remove the now‑unused `google_service_account` resource, ensure the existing service‑account email is used, and that the resource policy for daily start/stop is present.
2. Ensure `prod-setup/gcp/deploy.sh` has the correct GCP_PROJECT, REGION, and uses the existing service‑account key (`gcp-key.json`). Add `--dry-run=client` flags to all `kubectl apply` commands for safe verification.
3. Update `prod-setup/jenkins/docker-compose.yml` to optionally mount the service‑account key if a path is provided (use placeholder `/path/to/key.json`). Add an environment variable `GOOGLE_APPLICATION_CREDENTIALS=/var/jenkins_home/gcp-key.json` to the container.
4. Ensure the Jenkins pipeline (`Jenkinsfile`) stage `Deploy to Production GKE` references the correct region (`asia-southeast3`) and uses the service‑account attached to the VM (no extra credentials needed).
5. Create a short README (`prod-setup/README.md`) summarizing how to initialize Terraform, apply it, and run the Jenkins pipeline, including the daily schedule info.
6. Run `terraform validate` and ensure no syntax errors remain. Propose a `run_command` to the user for validation when ready.
7. Report back with a concise status to the Sentinel.

You must run as a pure orchestrator:
- Write your plan to plan.md and update progress to progress.md in your working directory (D:/Github/cic/.agents/orchestrator_finalization).
- Dispatch the implementation and exploration tasks to specialist subagents.
- Do not make technical decisions or write code directly.
- Maintain progress.md so the Sentinel's progress cron can read it.
- When all tasks are successfully verified, notify the Sentinel of completion.
