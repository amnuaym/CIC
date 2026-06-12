# Scope: Finalization of CIC Project CI/CD Infrastructure

## Architecture
The CIC production setup consists of:
- **Terraform Configuration** (`prod-setup/gcp/terraform/`): Deploys the GCE Jenkins VM with a resource policy for daily start/stop, uses an existing service account, and grants Artifact Registry writer and GKE container developer roles.
- **GCP Deployment Script** (`prod-setup/gcp/deploy.sh`): Sets active project, configures docker authentication, builds & pushes docker images, connects to GKE, and applies manifests with `--dry-run=client`.
- **Jenkins Compose Setup** (`prod-setup/jenkins/docker-compose.yml`): Runs Jenkins in a container, with options to mount a GCP service account key, and sets `GOOGLE_APPLICATION_CREDENTIALS`.
- **Jenkins Pipeline** (`Jenkinsfile`): Defines stages for testing, packaging, and deploying GKE production with metadata server auth.
- **Documentation** (`prod-setup/README.md`): Summarizes Terraform setup, deploy scripts, and Jenkins pipeline usage.

## Milestones
| # | Name | Scope | Dependencies | Status |
|---|---|---|---|---|
| M1 | Terraform Configuration Cleanup | Remove unused `google_service_account` resource, resolve duplicate provider & variable declarations, update outputs to match existing resources, and ensure daily start/stop resource policy is intact. | none | DONE (worker: f1f643a4-e606-4089-8a1b-866beb73479f) |
| M2 | Deployment Script Updates | Ensure `deploy.sh` uses correct project, region, and key path; add `--dry-run=client` to all `kubectl apply` commands. | M1 | DONE (worker: f1f643a4-e606-4089-8a1b-866beb73479f) |
| M3 | Docker Compose & Pipeline Setup | Update `docker-compose.yml` for optional key mounting and env var. Verify `Jenkinsfile` region and VM service-account metadata integration. | M1 | DONE (worker: f1f643a4-e606-4089-8a1b-866beb73479f) |
| M4 | README Documentation | Create `prod-setup/README.md` with operational guides. | M2, M3 | DONE (worker: f1f643a4-e606-4089-8a1b-866beb73479f) |
| M5 | Validation & Integrity Audit | Run `terraform validate` and Forensic Auditor check to ensure high-quality and integrity-compliant state. | M1, M2, M3, M4 | DONE (auditor: c5683857-389c-4073-ab79-906eebeb6a62) |

## Interface Contracts
- **Terraform VM Account**: VM instance must specify `cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com` as its service account.
- **Terraform IAM Members**: Must grant Artifact Registry Writer and GKE developer roles using the static service account email.
- **Deployment Script**: Must use `$REPO_ROOT/gcp-key.json` and deploy to `asia-southeast3` in project `project-4cd20f4a-78e2-4a45-81d`.
- **Jenkins Compose**: Must optionally mount the GCP key path using a placeholder `/path/to/key.json` and set `GOOGLE_APPLICATION_CREDENTIALS`.
- **Jenkins GKE Stage**: Must reference `asia-southeast3` region.
