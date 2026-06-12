# Challenge Report

## Challenge Summary

**Overall risk assessment**: CRITICAL

This report outlines critical design flaws, syntax checks, and reference errors discovered during verification of the Jenkins entrypoint, GCP deployment scripts, and Terraform configurations.

---

## Challenges

### [Critical] Challenge 1: Deployment Scripts Use Dry-Run for Manifest Application
- **Assumption challenged**: The deployment scripts (`deploy.sh` and `deploy.ps1`) successfully deploy/apply resources to the Kubernetes (GKE) cluster.
- **Attack scenario**: In both scripts, every single `kubectl apply` call includes the `--dry-run=client` flag. For example:
  - `kubectl create namespace cic-prod --dry-run=client -o yaml | kubectl apply --dry-run=client -f -`
  - `kubectl apply --dry-run=client -f "$SCRIPT_DIR/manifests/backend-config.yaml"`
  - `sed ... | kubectl apply --dry-run=client -f -`
  Running the script outputs `[+] Deployment successfully completed!` but actually creates/updates **zero** resources in the GKE cluster. On a fresh environment, the subsequent rollout check (`kubectl rollout status deployment/cic-api -n cic-prod`) will fail immediately since the deployments do not exist, halting the pipeline. If resources already existed, the scripts will verify old configurations instead of the new ones.
- **Blast radius**: The application is never deployed or updated in production.
- **Mitigation**: Remove the `--dry-run=client` flag from all `kubectl apply` commands in both `deploy.sh` and `deploy.ps1` to allow actual deployment to proceed.

### [High] Challenge 2: Unsubstituted GCP Project Placeholders in Kubernetes Manifests
- **Assumption challenged**: Kubernetes configuration files are fully prepared and reference the correct, parameterized images and service accounts.
- **Attack scenario**: The manifests (`cic-api.yaml`, `react-admin.yaml`, `keycloak.yaml`) contain hardcoded placeholder strings:
  - `YOUR_GCP_PROJECT` (used in images, service account annotations, and Cloud SQL proxy connection name).
  - Hardcoded region `us-central1` in GKE images and Cloud SQL proxy sidecars (whereas the deployment scripts configure `asia-southeast3`).
  - Example: `image: us-central1-docker.pkg.dev/YOUR_GCP_PROJECT/cic-repo/cic-api:latest`
  Because these placeholders are not substituted by the deployment scripts (only secrets are substituted), GKE will fail to pull the images (`ImagePullBackOff`), and the sidecar containers will fail to authenticate or find the Cloud SQL instances.
- **Blast radius**: Entire GKE deployment goes into a broken/crash-loop state.
- **Mitigation**: Update `deploy.sh` and `deploy.ps1` to substitute `YOUR_GCP_PROJECT` and `YOUR_GCP_REGION` with the project/region variables (e.g. using `sed` or environment variables) before executing `kubectl apply`.

### [High] Challenge 3: Invalid ManagedCertificate for Local/Private Domain
- **Assumption challenged**: GCP GKE Managed Certificates can secure a local test domain (`cic.local`).
- **Attack scenario**: `managed-certificate.yaml` requests a certificate for `cic.local`. GKE Managed Certificates only support public domains where Google's Certificate Authority can verify ownership via public DNS validation. It is impossible to provision a Google-managed certificate for a `.local` domain. The certificate provisioning will get stuck in `Provisioning` or `Failed` indefinitely, and the ingress controller will fail to serve traffic securely.
- **Blast radius**: External secure HTTPS access to `cic.local` is broken.
- **Mitigation**: Use self-signed or private CA certificates stored in a Kubernetes TLS Secret and reference it in the Ingress spec (`ingress.spec.tls[].secretName`), rather than relying on GKE's `ManagedCertificate` resource.

### [Medium] Challenge 4: Hardcoded Project ID in Terraform IAM/Service Account Configurations
- **Assumption challenged**: The Terraform configuration is generic, parameterized, and reusable across different environments.
- **Attack scenario**: In `main.tf`, the service account email is hardcoded:
  - `email = "cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com"`
  - `member = "serviceAccount:cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com"`
  If the `project_id` variable is changed (e.g. deploying to a staging/production project), Terraform will attempt to assign IAM permissions on the new project to a service account in the old project (resulting in permissions errors or cross-project access vulnerabilities).
- **Blast radius**: Terraform deployment fails or misconfigures permissions when the project ID is changed.
- **Mitigation**: Dynamically reference the service account using variable interpolation, e.g.:
  `"serviceAccount:cicsvc@${var.project_id}.iam.gserviceaccount.com"`

### [Low] Challenge 5: Unused Variables in Terraform
- **Assumption challenged**: All declared variables in `variables.tf` are utilized by the infrastructure setup.
- **Attack scenario**: The variables `api_image`, `admin_image`, and `jwt_secret_value` are declared but never referenced in `main.tf`. Running `terraform plan` or `terraform apply` forces the user to manually input values for these variables (as they lack defaults), which is confusing and unnecessary since GKE deployments are handled via separate Kubernetes manifests.
- **Blast radius**: Minor operator friction and confusion.
- **Mitigation**: Remove the unused variables from `variables.tf`.

### [Low] Challenge 6: Entrypoint Script Failure under Read-Only Filesystems
- **Assumption challenged**: The container's environment always allows modification of `/etc/group` and `/etc/passwd`.
- **Attack scenario**: In secure environments enforcing a read-only root filesystem (best practice), the entrypoint script will fail when executing `groupadd` or `usermod` due to being unable to acquire a lock. Since `set -e` is active, the container will crash immediately.
- **Blast radius**: Container startup failure under strict security runtime policies.
- **Mitigation**: Add a writeability check for `/etc/group` or allow skipping group alignment operations using an environment variable flag.

---

## Stress Test Results

- **Non-root execution (UID 1000)** → Skip group alignment & start Jenkins directly → **PASS** (expected behavior).
- **Root execution, no Docker socket mounted** → Skip alignment safely → **PASS** (expected behavior).
- **Root execution, privileged GID (<100)** → Skip group operations to prevent escalation → **PASS** (expected behavior).
- **Root execution, non-colliding GID (1005)** → Create group `docker-host`, add `jenkins` user → **PASS** (expected behavior).
- **Root execution, GID collision with system group (101)** → Create non-unique group `docker-host-101`, add `jenkins` user → **PASS** (expected behavior).
- **Root execution, read-only filesystem** → `groupadd` fails with exit code 10, script exits with 10 → **FAIL** (as predicted under Challenge 6).

---

## Unchallenged Areas

- **Nginx configuration & local cert rotation** — Out of scope for this specific verification task.
- **Jenkins build compilation logic** — Only the entrypoint shell script and test suite execution were reviewed.
