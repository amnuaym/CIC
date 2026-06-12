## 2026-06-11T05:51:00Z
You are the worker_finalization_gen2 subagent (remediation worker).
Your working directory is D:\Github\cic\.agents\worker_finalization_gen2.
Your task is to implement the 7 finalization tasks for the CIC project:
1. Fix the Terraform main, variables, providers, and outputs files in prod-setup/gcp/terraform/ to ensure syntax correctness:
   - Update jenkins_schedule resource policy to use instance_schedule_policy with start/stop schedules and Asia/Jakarta timezone.
   - Remove duplicate required provider blocks and duplicate project_id/region/zone variables.
   - Clean up outputs.tf to remove non-existent resources.
   - Remove the unused google_service_account resource and use the hardcoded service account email directly.
2. Fix prod-setup/jenkins/entrypoint.sh to change tini path to /sbin/tini and handle empty GID safely.
3. Update prod-setup/jenkins/docker-compose.yml to mount gcp-key.json optionally and set GOOGLE_APPLICATION_CREDENTIALS environment variable.
4. Ensure root Jenkinsfile stage "Deploy to Production GKE" runs deploy.sh or performs placeholder substitutions before applying manifests.
5. Update prod-setup/gcp/deploy.sh to use correct PROJECT_ID, REGION, and include --dry-run=client on all kubectl apply commands.
6. Update/create prod-setup/README.md summarizing steps.
7. Run terraform validate on prod-setup/gcp/terraform/ to verify correctness.

MANDATORY INTEGRITY WARNING:
DO NOT CHEAT. All implementations must be genuine. DO NOT hardcode test results, create dummy/facade implementations, or circumvent the intended task. A Forensic Auditor will independently verify your work. Integrity violations WILL be detected and your work WILL be rejected.

Save your changes report to D:\Github\cic\.agents\worker_finalization_gen2\handoff.md and progress in D:\Github\cic\.agents\worker_finalization_gen2\progress.md. Message the Project Orchestrator once complete.
