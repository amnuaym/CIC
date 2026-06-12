# Challenger Findings & Review Report

## Challenge Summary

**Overall risk assessment**: HIGH

Through static code review, logical trace analysis, and verification of configuration dependencies across Terraform, deployment scripts, and Kubernetes manifests, we identified several critical failure modes, security vulnerabilities, and configuration mismatches. 

---

## Challenges

### [High] Challenge 1: Deployment Scripts Disable Actual Deployment (`deploy.sh` & `deploy.ps1`)
- **Assumption challenged**: The assumption that executing the deployment script will apply the configuration changes to GKE and trigger rollout updates.
- **Attack scenario**: Every single `kubectl apply` call in `deploy.sh` (lines 56, 59, 71, 73–77) and `deploy.ps1` (lines 57, 60, 71, 73–77) contains the `--dry-run=client` flag. This means the resources are only validated locally by the client and are never sent to the GKE cluster for creation or updating.
- **Blast radius**: The application will not be deployed. Furthermore, when the scripts proceed to step 7 ("Check Deployment Status") using:
  ```bash
  kubectl rollout status deployment/cic-api -n cic-prod
  ```
  the verification commands will fail or wait indefinitely because the deployments do not exist in the active cluster state.
- **Mitigation**: Remove `--dry-run=client` from the `kubectl apply` commands in production, or implement a command-line flag (e.g., `--validate-only`) to conditionally apply the dry-run parameter.

### [High] Challenge 2: Security SA Key Leakage (`gcp-key.json` not in `.gitignore`)
- **Assumption challenged**: The documentation (`gcp_key_setup_guide.md`, line 68) states: *"Never commit this file to Git. The project's `.gitignore` is pre-configured to exclude `gcp-key.json` to prevent accidental leaks."*
- **Attack scenario**: The actual `.gitignore` file in the root directory does **not** contain `gcp-key.json` or any JSON patterns. A developer following the guide who places the credential file at `D:/Github/cic/gcp-key.json` will find that Git attempts to track the file.
- **Blast radius**: Severe security risk. If a developer accidentally commits `gcp-key.json` to a public or shared git repository, the private key of the GCP service account (which holds privileged permissions like Compute Admin and GKE Developer) will be leaked.
- **Mitigation**: Add `gcp-key.json` to the root `.gitignore` file immediately.

### [Medium] Challenge 3: Prompts Blocked by Unused Terraform Variables (`variables.tf`)
- **Assumption challenged**: The assumption that all variables defined in `variables.tf` are required for provisioning the Terraform infrastructure.
- **Attack scenario**: The variables `environment`, `db_tier`, `api_image`, `admin_image`, and `jwt_secret_value` are declared in `variables.tf` (and listed in `terraform.tfvars.example`), but are completely unused in `main.tf` or any other `.tf` file. Because `api_image`, `admin_image`, and `jwt_secret_value` do not have default values, executing `terraform plan` or `terraform apply` forces the developer to manually input values for them, even though they have no effect on the infrastructure.
- **Blast radius**: Friction during automation/CI runs (blocking commands waiting for interactive prompts) and maintainability overhead from dead configuration code.
- **Mitigation**: Remove the unused variables from `variables.tf` and `terraform.tfvars.example` since the application and container deployment are handled via GKE manifests instead of Terraform compute instances.

### [Medium] Challenge 4: Hardcoded GCP Project & Service Account in Terraform (`main.tf`)
- **Assumption challenged**: The assumption that the Terraform configuration is modular and can be deployed to different projects by overriding the `project_id` variable.
- **Attack scenario**: The service account email is hardcoded on line 43 of `main.tf` as `cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com`, and in the IAM member bindings on lines 57 and 63. Overriding the `project_id` variable in a tfvars file does not update these references.
- **Blast radius**: Deploying to a different project will fail during the IAM binding phase, or mistakenly bind permissions to a service account in project `project-4cd20f4a-78e2-4a45-81d`.
- **Mitigation**: Replace the hardcoded string with dynamic interpolation:
  `cicsvc@${var.project_id}.iam.gserviceaccount.com` or manage the service account as a resource.

### [High] Challenge 5: Reference Gap for GKE Ingress Static IP (`ingress.yaml`)
- **Assumption challenged**: The assumption that the static IP `cic-static-ip` is automatically provisioned or available.
- **Attack scenario**: In `ingress.yaml` (line 9), the Ingress is configured to use a static public IP with the annotation:
  `kubernetes.io/ingress.global-static-ip-name: cic-static-ip`
  However, this static IP resource is never created by the Terraform manifests or by the deployment scripts.
- **Blast radius**: GKE Ingress controller will fail to provision the Google Cloud HTTP(S) Load Balancer, causing the Ingress resource to remain in an unprovisioned state and the application to be unreachable.
- **Mitigation**: Define a `google_compute_global_address` resource in Terraform named `cic-static-ip`, or add a resource-checking step in the deploy scripts.

### [High] Challenge 6: Invalid `.local` Domain for Google Managed Certificate (`managed-certificate.yaml`)
- **Assumption challenged**: The assumption that Google Managed Certificates can issue SSL certificates for local/non-public domains.
- **Attack scenario**: The `managed-certificate.yaml` file specifies `cic.local` under the `domains` list. GKE Managed Certificates use Let's Encrypt / Google Trust Services which require domain validation via public DNS.
- **Blast radius**: The certificate (`cic-managed-cert`) will fail validation and remain stuck in `Provisioning` or `Failed` states indefinitely, blocking the Ingress from establishing secure HTTPS connections.
- **Mitigation**: Use a valid, public registered domain name for GKE managed certificates, or shift to self-signed TLS certificates using cert-manager/secrets for local or development environments.

---

## Stress Test Results

The python verification script `prod-setup/jenkins/verification/test_entrypoint.py` was statically analyzed and validated:
- **Test 1: Non-root execution** → Expected to skip modifications and handoff execution → **PASS** (Logical validation)
- **Test 2: Root execution, no socket** → Expected to emit warning and skip safely → **PASS** (Logical validation)
- **Test 3: Root execution, privileged GID < 100** → Expected to block privilege escalation and skip → **PASS** (Logical validation)
- **Test 4: Root execution, docker GID 999** → Expected to reuse existing group and add user → **PASS** (Logical validation)
- **Test 5: Root execution, GID collision** → Expected to create non-unique `docker-host-101` group → **PASS** (Logical validation)
- **Test 6: Root execution, new GID** → Expected to create new group and add user → **PASS** (Logical validation)
- **Test 7: Root execution, stat command fails** → Expected to warning-log and skip safely → **PASS** (Logical validation)
- **Test 8: Root execution, read-only FS** → Expected to fail at `groupadd` and exit non-zero due to `set -e` → **PASS** (Logical validation)

---

## Unchallenged Areas

- **Nginx configuration (`nginx.conf`) and local certificate rotation (`rotate-certs.*`)**: These files were not challenged as they were outside the core scope requested.
