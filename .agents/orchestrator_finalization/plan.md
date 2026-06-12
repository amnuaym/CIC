# Execution Plan: CIC Infrastructure Finalization

This plan coordinates the finalization and verification of the CIC CI/CD and GCP deployment setup.

## Phase 1: Exploration
- Gather detailed structure of the Terraform files (`main.tf`, `variables.tf`, `providers.tf`, `outputs.tf`).
- Identify all discrepancies and check for compile/syntax errors (e.g. duplicate resources, variables, providers).
- Identify all `kubectl apply` commands in `prod-setup/gcp/deploy.sh`.
- Subagent: `teamwork_preview_explorer` (investigate current setup).

## Phase 2: Implementation
- **Step 1: Terraform Cleanup**
  - Update `main.tf` to reference the existing service account `cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com` in `google_project_iam_member` resources.
  - Remove duplicates between `main.tf`, `variables.tf`, and `providers.tf`.
  - Update `outputs.tf` to only output valid resources (e.g. Jenkins GCE VM instance details) or delete invalid outputs referencing non-existent resources.
- **Step 2: Deploy Script Update**
  - Update `prod-setup/gcp/deploy.sh` with correct project, region, and key path variables.
  - Add `--dry-run=client` to all `kubectl apply` commands.
- **Step 3: Jenkins Compose & Jenkinsfile Update**
  - Update `prod-setup/jenkins/docker-compose.yml` to support optional GCP service account key mount (`${GCP_KEY_PATH:-/path/to/key.json}`) and set `GOOGLE_APPLICATION_CREDENTIALS`.
  - Verify that the `Jenkinsfile` stage `Deploy to Production GKE` uses `asia-southeast3` and relies on VM metadata credentials.
- **Step 4: Create README**
  - Write `prod-setup/README.md` covering Terraform initialization, VM scheduling, deployment, and Jenkins configuration.
- Subagent: `teamwork_preview_worker` (makes code changes).

## Phase 3: Verification & Review
- Run `terraform validate` using a user-approved command.
- Verify that changes meet all requirements and acceptance criteria.
- Reviewer checks the code changes.
- Forensic Auditor verifies integrity and correctness.
- Subagents: `teamwork_preview_reviewer`, `teamwork_preview_auditor`.

## Phase 4: Human Reporting
- Send final status report to the Sentinel.
