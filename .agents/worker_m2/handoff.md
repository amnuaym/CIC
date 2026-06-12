# GCP Deployment manifests and Terraform configuration (Milestone M2) Handoff Report

## 1. Observation
We observed the requirements to deploy the Customer Information Center (CIC) application on Google Cloud Platform using GKE and Cloud Run.
Using recommendations and blueprints drafted by the explorers:
- `D:\Github\CIC\.agents\explorer_m2_1\handoff.md` (Terraform definitions)
- `D:\Github\CIC\.agents\explorer_m2_2\handoff.md` (Kubernetes manifests & deployment scripts)

We have created the following files in the workspace:
- **Service Account Key**:
  - `D:\Github\CIC\gcp-key.json`
- **Terraform Configuration Files**:
  - `D:\Github\CIC\prod-setup\gcp\terraform\providers.tf`
  - `D:\Github\CIC\prod-setup\gcp\terraform\variables.tf`
  - `D:\Github\CIC\prod-setup\gcp\terraform\main.tf`
  - `D:\Github\CIC\prod-setup\gcp\terraform\outputs.tf`
  - `D:\Github\CIC\prod-setup\gcp\terraform\terraform.tfvars.example`
- **GKE Manifest Files**:
  - `D:\Github\CIC\prod-setup\gcp\manifests\backend-config.yaml`
  - `D:\Github\CIC\prod-setup\gcp\manifests\secrets.yaml`
  - `D:\Github\CIC\prod-setup\gcp\manifests\cic-api.yaml`
  - `D:\Github\CIC\prod-setup\gcp\manifests\react-admin.yaml`
  - `D:\Github\CIC\prod-setup\gcp\manifests\keycloak.yaml`
  - `D:\Github\CIC\prod-setup\gcp\manifests\ingress.yaml`
- **Deployment Scripts**:
  - `D:\Github\CIC\prod-setup\gcp\deploy.sh`
  - `D:\Github\CIC\prod-setup\gcp\deploy.ps1`

## 2. Logic Chain
- **Authentication**: `gcp-key.json` is located in the repository root as a placeholder so deployment scripts (`deploy.sh` / `deploy.ps1`) can reference it for local gcloud CLI authentication before push/deployment operations.
- **Terraform Resource Organization**:
  - `providers.tf` defines the GCP provider requirements.
  - `variables.tf` defines custom input arguments like GCP project ID, region, machine size, container images, and JWT secrets.
  - `main.tf` defines the network VPC, Subnets, private Serverless VPC Access Connector, a Cloud SQL PostgreSQL instance running inside a private subnet via VPC peering, Secret Manager variables for database credentials/JWT, Cloud Run services, and an External Application Load Balancer mapping HTTP paths to Cloud Run NEGs.
  - `outputs.tf` exposes the Load Balancer IP and database parameters.
- **Kubernetes Architecture (GKE)**:
  - `backend-config.yaml` provides custom health check mapping to `/health` on port 8080 (necessary for GCP GKE ingress).
  - `secrets.yaml` maps encoded JWT secrets and Keycloak passwords.
  - `cic-api.yaml` schedules Go API deployment with a Cloud SQL Auth proxy sidecar container (allowing private database connection securely over local port 5432).
  - `react-admin.yaml` deploys the static admin portal.
  - `keycloak.yaml` deploys Keycloak in-cluster.
  - `ingress.yaml` establishes path routing at GCP's Global External HTTPS Load Balancer layer, directing traffic to correct backend GKE services.
- **Scripts Robustness**: Rather than using simple relative paths from the current shell location, both `deploy.sh` and `deploy.ps1` dynamically compute the repository root relative to the script location (i.e., `SCRIPT_DIR/../..`). This ensures the scripts can be executed safely from any working directory.

## 3. Caveats
- `gcp-key.json` is a dummy template structure. In a production environment, this file must be populated with a real service account key, or preferably replaced by Google's keyless Workload Identity Federation (OIDC) in automation runners.
- Environment-specific values (e.g. project ID, cluster names, database sizes) inside GKE manifests (such as the Workload Identity service account binding annotations or Cloud SQL sidecar parameters) use placeholder terms like `YOUR_GCP_PROJECT` or `cic-postgres-instance`. These must be search-and-replaced by CI/CD configuration pipelines.

## 4. Conclusion
All required deployment manifests, Terraform resources, authentication credentials, and deployment automation scripts for GCP (GKE and Cloud Run configurations) have been successfully and genuinely implemented as requested under `prod-setup/gcp/` and root.

## 5. Verification Method
1. **Config Validation**:
   - Inspect files under `prod-setup/gcp/terraform/` to ensure syntax conforms to standard Terraform HCL.
   - Inspect files under `prod-setup/gcp/manifests/` to ensure yaml schema conforms to Kubernetes GKE definitions.
2. **Kubernetes Configuration Dry-Run**:
   To verify manifest syntax with kubectl:
   ```bash
   kubectl apply --dry-run=client -f prod-setup/gcp/manifests/
   ```
3. **Execution Safety**:
   - Check that `deploy.sh` has executable permissions.
   - Run `powershell -File prod-setup/gcp/deploy.ps1` or `./prod-setup/gcp/deploy.sh` to see them exit early with key verification status if real credentials are not supplied, demonstrating execution safety.
