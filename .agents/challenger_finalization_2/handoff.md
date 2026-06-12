# Handoff Report

## 1. Observation

Direct observations made during investigation:
- **`prod-setup/jenkins/entrypoint.sh`**: The script checks if running as root using `[ "$(id -u)" -eq 0 ]` and aligns GIDs from `/var/run/docker.sock` to the `jenkins` user, dropping privileges using `gosu` and running tini.
- **`prod-setup/jenkins/verification/test_entrypoint.py`**: A python test suite that creates temporary mock environments (including mock binaries for `id`, `stat`, `getent`, `groupadd`, `usermod`, `gosu`, and `tini`) to verify 8 scenarios including non-root, root, privileged GID, group collision, and read-only FS behaviors.
- **`prod-setup/gcp/deploy.sh` & `prod-setup/gcp/deploy.ps1`**:
  * Every single `kubectl apply` call (e.g. line 56, 59, 71, 73-77 in `deploy.sh` and 57, 60, 71, 73-77 in `deploy.ps1`) specifies `--dry-run=client`.
- **`.gitignore`**: There is no entry for `gcp-key.json`.
- **`prod-setup/gcp/gcp_key_setup_guide.md`**: Line 68 states:
  > `* Never commit this file to Git. The project's .gitignore is pre-configured to exclude gcp-key.json to prevent accidental leaks.`
- **`prod-setup/gcp/terraform/variables.tf`**: Declares variables `environment`, `db_tier`, `api_image`, `admin_image`, and `jwt_secret_value` without defaults, but they are not used anywhere in `main.tf`.
- **`prod-setup/gcp/terraform/main.tf`**: Lines 43, 57, and 63 hardcode the service account email:
  `cicsvc@project-4cd20f4a-78e2-4a45-81d.iam.gserviceaccount.com`
- **Kubernetes Manifests (`prod-setup/gcp/manifests/`)**:
  * `cic-api.yaml` (lines 8, 46, 86), `react-admin.yaml` (line 32), and `keycloak.yaml` (line 79) contain placeholders such as `YOUR_GCP_PROJECT` and hardcoded regional endpoints like `us-central1` (which conflict with the script's default region of `asia-southeast3`).
  * `managed-certificate.yaml` (line 8) contains `cic.local` which is a private non-resolvable domain.
  * `ingress.yaml` (line 9) references a static IP named `cic-static-ip` which is not provisioned anywhere in Terraform or the deploy scripts.

---

## 2. Logic Chain

1. **Deployment Scripts Block Workloads**: Since `--dry-run=client` is appended to all `kubectl apply` commands in `deploy.sh` and `deploy.ps1`, no resources are actually modified on the target GKE cluster. Consequently, when the script attempts `kubectl rollout status` for the API and frontend deployments, the command will fail or hang indefinitely because the deployments were never created in the cluster.
2. **Credential Exposure Risk**: The setup guide directs developers to download their service account key to the workspace root as `gcp-key.json` and asserts that `.gitignore` is pre-configured to exclude it. Because the `.gitignore` does not contain this path, the untracked file will be presented to Git, making it highly probable that developers will accidentally commit the key.
3. **Broken Terraform Modularity**: Since the service account email is hardcoded with a specific project name (`project-4cd20f4a-78e2-4a45-81d`), overriding the `project_id` variable during a Terraform apply will result in failures when applying IAM member policies, or incorrect bindings pointing to the wrong GCP project.
4. **Terraform Interactive Prompt Blocks**: Because `api_image`, `admin_image`, and `jwt_secret_value` have no default values in `variables.tf` and are completely unused in the infrastructure manifests, running Terraform in an automated pipeline will halt and prompt for inputs that are ultimately disregarded.
5. **Ingress and SSL Provisioning Failures**: The Ingress configuration relies on a global static IP resource (`cic-static-ip`) that does not exist, and a Managed Certificate for a `.local` domain (`cic.local`). Public Certificate Authorities cannot validate or issue SSL certificates for `.local` domains, meaning the ManagedCertificate will fail to provision, and Google HTTP(S) Load Balancing will fail to configure the external IP and routing rules.

---

## 3. Caveats

- We were unable to execute the automated verification suite `test_entrypoint.py` inside the live workspace terminal due to execution permission prompt timeouts (command-line permissions were requested but timed out due to developer absence). The verification of the test suite was performed through a comprehensive logical trace of the python code and mock setups, which confirmed the structure and scenarios are correct.
- We did not review the specific Nginx reverse proxy configuration (`nginx.conf`) and certificate rotation scripts (`rotate-certs.*`) as they are outside the core requested scope.

---

## 4. Conclusion

The implemented entrypoint script `entrypoint.sh` and its companion test suite `test_entrypoint.py` are structurally sound, logically correct, and handle various runtime edge cases (such as non-root users, system GID collisions, and read-only filesystems).

However, the deployment scripts (`deploy.sh`/`deploy.ps1`), the configuration manifests, and the Terraform setup contain several critical bugs and security risks that must be mitigated before a production release:
1. **Remove dry-run behavior** in deployment scripts to enable actual cluster resource creation.
2. **Add `gcp-key.json` to `.gitignore`** to prevent severe service account key exposure.
3. **Update Terraform configuration** to dynamically interpolate `var.project_id` into service account emails, and remove unused variables from `variables.tf`.
4. **Replace placeholder variables** (e.g. `YOUR_GCP_PROJECT`) in Kubernetes manifests or integrate dynamic string replacement in the deployment scripts.
5. **Reserve `cic-static-ip`** in Terraform and **use a valid public domain** instead of `.local` for Google Managed Certificates.

---

## 5. Verification Method

- **To run entrypoint tests**: Executing the python test suite:
  ```powershell
  python prod-setup/jenkins/verification/test_entrypoint.py
  ```
  *(Requires `bash` to be available in the system PATH if executed on a Windows host).*
- **To verify deployment scripts**: Check for the presence of `--dry-run=client` in:
  * `prod-setup/gcp/deploy.sh`
  * `prod-setup/gcp/deploy.ps1`
- **To verify Terraform variables usage**: Check if `api_image`, `admin_image`, `db_tier`, `environment`, or `jwt_secret_value` are referenced in `prod-setup/gcp/terraform/main.tf` (they are not).
- **To verify GCP key exclusion**: Check `D:/Github/cic/.gitignore` for references to `gcp-key.json`.
