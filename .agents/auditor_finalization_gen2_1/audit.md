# Forensic Audit Report

**Work Product**: GCP GKE Deployment Setup & Documentation:
- `prod-setup/gcp/deploy.sh`
- `prod-setup/gcp/deploy.ps1`
- `prod-setup/README.md`
**Profile**: General Project
**Verdict**: CLEAN

---

### Phase Results

#### Phase 1: Source Code Analysis
- **Hardcoded test results**: PASS — No hardcoded test results or mock validations are present in the scripts or documentation.
- **Facade detection**: PASS — Both the shell script (`deploy.sh`) and PowerShell script (`deploy.ps1`) contain complete, functional orchestration logic calling real tools (`docker`, `gcloud`, `kubectl`).
- **Pre-populated artifact detection**: PASS — No pre-populated logs or fabricated run outcomes exist in the workspace.

#### Phase 2: Behavioral Verification
- **Build and run**: PASS — Static checks confirm correct syntax for both Bash and PowerShell scripts. Standard environment parameters and execution variables are handled cleanly.
- **Output verification**: PASS — Scripts include appropriate dry-run flags (`--dry-run=client`) for GKE deployment actions, allowing manifest validation in validation/testing environments without modifying actual cluster states.
- **Dependency audit**: PASS — Core orchestration tasks are not delegated to forbidden third-party libraries. Standard platform tooling is used directly.

---

### Evidence & Findings

While the codebase is **CLEAN** of integrity violations (no cheating, hardcoded tests, or facades), the following robustness and documentation issues were identified during forensic analysis:

#### Finding 1: Manifest Placeholder Mismatch
The deployment scripts (`deploy.sh` and `deploy.ps1`) build and push Docker images using the following configuration variables:
```bash
PROJECT_ID="project-4cd20f4a-78e2-4a45-81d"
REGION="asia-southeast3"
```
However, the Kubernetes deployment manifests applied by these scripts (`prod-setup/gcp/manifests/cic-api.yaml` and `prod-setup/gcp/manifests/react-admin.yaml`) contain un-substituted placeholders:
- `us-central1-docker.pkg.dev/YOUR_GCP_PROJECT/cic-repo/cic-api:latest`
- `us-central1-docker.pkg.dev/YOUR_GCP_PROJECT/cic-repo/react-admin:latest`
- `YOUR_GCP_PROJECT:us-central1:cic-postgres-instance`

**Impact**: Applying these manifests in a live cluster environment will lead to container image pull failures (`ImagePullBackOff` / `ErrImagePull`) and DB sidecar connection failures because the script does not replace `YOUR_GCP_PROJECT` or `us-central1` with the configured project ID and region variables before calling `kubectl apply`.

---

#### Finding 2: Dummy Key Execution Crash
A dummy Service Account credential file (`gcp-key.json`) is present in the repository root containing placeholder credential values:
```json
{
  "type": "service_account",
  "project_id": "dummy-gcp-project-12345",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDEo8XzS9mG1K9o\ndummyKeyContentHereJustForValidationOfFileStructureAndSyntax\n-----END PRIVATE KEY-----\n"
}
```
**Impact**: Because the file `gcp-key.json` exists, both deployment scripts will satisfy the file existence check (`[ -f "$GCP_KEY_FILE" ]` / `Test-Path $GcpKeyFile`) and proceed to call `gcloud auth activate-service-account --key-file=...`. Since the key's private key value is structurally invalid, the script will crash on this command, preventing the fallback logic (using ambient metadata credentials) from executing.

---

#### Finding 3: Missing `.gitignore` Rule
The `prod-setup/gcp/gcp_key_setup_guide.md` file states:
> * Never commit this file to Git. The project's `.gitignore` is pre-configured to exclude `gcp-key.json` to prevent accidental leaks.

However, forensic verification of `.gitignore` shows that there is no entry for `gcp-key.json`.

**Impact**: This increases the risk of developers accidentally staging and committing active GCP service account keys to version control.
