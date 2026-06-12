# GCP & SSL/TLS Deployment Review Report (M4)

This handoff report is prepared by agent **reviewer_m4_2** (GCP & SSL/TLS Reviewer) for the main agent, detailing the evaluation of the GCP deployment manifests/scripts (`prod-setup/gcp/*`) and Nginx secure SSL configuration/rotation scripts (`prod-setup/nginx/*`).

---

## 1. Observation
We reviewed the implementation files located in the repository under:
- `prod-setup/gcp/` (Terraform configurations, GKE manifests, and deployment scripts)
- `prod-setup/nginx/` (Nginx gateway configs and certificate rotation scripts)

Direct observations made on specific files:
1. **`prod-setup/gcp/manifests/secrets.yaml` (Lines 10, 12)** contains base64 encoded plaintext secrets:
   * `jwt-secret`: `eW91ci1zZWNyZXQta2V5LWNoYW5nZS1pbi1wcm9kdWN0aW9u` (decoded: `"your-secret-key-change-in-production"`)
   * `keycloak-admin-password`: `YWRtaW4=` (decoded: `"admin"`)
2. **`prod-setup/gcp/manifests/cic-api.yaml` (Line 55)** contains hardcoded database credentials in the connection string:
   * `postgres://db_user:db_password@127.0.0.1:5432/cic?sslmode=disable`
3. **`prod-setup/gcp/manifests/ingress.yaml`** has no `tls` block under `spec` or managed-certificate annotations.
4. **`prod-setup/gcp/manifests/keycloak.yaml` (Line 33)** uses the dev argument `start-dev` and has no configured database volume or connection.
5. **`prod-setup/gcp/terraform/main.tf`** provisions Google Cloud Run services and a forwarding rule listening on HTTP (port 80), while the deployment scripts `deploy.sh` and `deploy.ps1` expect a GKE cluster configuration.
6. **`prod-setup/nginx/rotate-certs.ps1`** rotates self-signed certificates but does not restrict permissions on the newly created private key file under Windows/NTFS.
7. **R4 Safety Constraint**: No files are marked for deletion in the repository, and no file deletions occurred in the rotation scripts (old keys are moved to `certs/backup/` with a timestamp).

---

## 2. Logic Chain
- **Vulnerability Identification**: Having plaintext credentials and secrets committed to Git (`secrets.yaml` and `cic-api.yaml`) violates standard security practices. Any developer or CI system with read access can compromise the application and database.
- **Architectural Conflict**: Terraform manifests are set up for **Cloud Run**, while deployment manifests/scripts target **GKE**. This means applying the Terraform files will not set up the required GKE cluster, causing the deployment script `deploy.sh`/`deploy.ps1` to fail.
- **TLS Failure**: The GKE Ingress manifest has no configuration for TLS/SSL (port 443). As a result, the public-facing entry point on GKE will not terminate SSL/TLS, and traffic will remain unencrypted.
- **Data Persistence Risk**: Deployed Keycloak containers will use the in-memory H2 database because no external database connection or volume is configured in `keycloak.yaml`. When the Keycloak pod restarts, all user databases and realms will be lost.
- **Safety Compliance**: The certificate rotation scripts successfully follow the R4 safety constraint. Instead of using destructive commands like `rm` or `Remove-Item` on older keys, they archive the files using `mv`/`Move-Item` to a local `backup/` sub-folder.

---

## 3. Caveats
- Actual verification of deployment commands (`gcloud`, `kubectl`, `terraform`) on a live GCP environment was not performed due to lack of a live sandbox and command approval timeouts.
- The analysis assumes that the application is meant to run in a production environment matching standard enterprise benchmarks.

---

## 4. Conclusion & Verdict

**Verdict**: **REQUEST_CHANGES** (due to critical security gaps and architectural mismatch)

The implemented manifests and scripts have solid groundwork, but they contain critical security flaws (committed secrets, unencrypted ingress, hardcoded DB creds) and a major architectural mismatch between Terraform (Cloud Run) and K8s (GKE).

---

## 5. Verification Method
To independently verify the configuration syntax and structure:
1. **Kubernetes Configuration Dry-Run**:
   ```bash
   kubectl apply --dry-run=client -f prod-setup/gcp/manifests/
   ```
2. **Terraform Formatting & Validation**:
   ```bash
   cd prod-setup/gcp/terraform
   terraform init -backend=false
   terraform validate
   ```
3. **OpenSSL Generation & Rotation Check**:
   Run `./prod-setup/nginx/rotate-certs.sh` on Linux/macOS or `powershell -File .\prod-setup\nginx\rotate-certs.ps1` on Windows and verify new files are generated under `prod-setup/nginx/certs/` and old keys are archived in `backup/`.

---

# QUALITY REVIEW REPORT

## Review Summary
- **Verdict**: REQUEST_CHANGES
- **Reviewed Items**: `prod-setup/gcp/*`, `prod-setup/nginx/*`
- **Unverified Claims**: Actual GKE rollout status verification (due to lack of target cluster access).

## Findings

### [Critical] Finding 1: GKE Ingress Lacks SSL/TLS Termination
- **What**: The Ingress manifest does not define any TLS blocks or annotations for managed SSL.
- **Where**: `prod-setup/gcp/manifests/ingress.yaml`
- **Why**: Traffic to the GKE ingress will be unencrypted (HTTP only), exposing sensitive client data.
- **Suggestion**: Add a `tls` spec section referencing a cert secret or add GCP Managed Certificate annotations.

### [Critical] Finding 2: Plaintext Secrets Committed to Git
- **What**: Base64 encoded secrets (JWT secret, Keycloak admin password) are hardcoded in the manifest.
- **Where**: `prod-setup/gcp/manifests/secrets.yaml`, lines 10, 12
- **Why**: Committing secrets to a git repository leads to credential exposure.
- **Suggestion**: Inject these values dynamically using environment variables or a Secret Manager provider during CI/CD.

### [Major] Finding 3: Architectural Mismatch (Cloud Run vs. GKE)
- **What**: Terraform provisions Cloud Run, but Kubernetes manifests and deployment scripts target GKE.
- **Where**: `prod-setup/gcp/terraform/main.tf` vs `prod-setup/gcp/manifests/`
- **Why**: Running Terraform will not provision the infrastructure expected by `deploy.sh`/`deploy.ps1`.
- **Suggestion**: Update Terraform to provision a GKE cluster or update deployment manifests to use Cloud Run.

### [Major] Finding 4: Keycloak runs in Dev Mode without Data Persistence
- **What**: Keycloak is configured with `start-dev` and has no persistent backend.
- **Where**: `prod-setup/gcp/manifests/keycloak.yaml`
- **Why**: Keycloak will lose all user accounts and realms upon pod restart.
- **Suggestion**: Bind Keycloak to the PostgreSQL instance and use the standard `start` argument.

### [Major] Finding 5: Hardcoded Database Connection String
- **What**: Cleartext database credentials are embedded in the Deployment spec.
- **Where**: `prod-setup/gcp/manifests/cic-api.yaml`, line 55
- **Why**: Exposes the database password to anyone who can view the Kubernetes deployment descriptor.
- **Suggestion**: Store the connection string or credentials in K8s Secrets and reference them via `valueFrom.secretKeyRef`.

### [Minor] Finding 6: Permissive NTFS Permissions on Private Key
- **What**: Private key is generated without restricting NTFS permissions on Windows.
- **Where**: `prod-setup/nginx/rotate-certs.ps1`
- **Why**: Standard users on the Windows machine may have read access to the certificate's private key.
- **Suggestion**: Use PowerShell Access Control List (ACL) commands to restrict access to the Nginx service account/Administrators.

### [Minor] Finding 7: Unencrypted Database Traffic
- **What**: `sslmode=disable` is set on the DB connection.
- **Where**: `prod-setup/gcp/manifests/cic-api.yaml` (Line 55) and `prod-setup/gcp/terraform/main.tf` (Line 137)
- **Why**: Database traffic travels unencrypted over the VPC network.
- **Suggestion**: Set `sslmode=require` or `sslmode=verify-ca`.

---

# ADVERSARIAL CHALLENGE REPORT

## Challenge Summary
- **Overall Risk Assessment**: HIGH

## Challenges

### [Critical] Challenge 1: Hardcoded JWT Secret Exposure
- **Assumption Challenged**: Encoding secrets to Base64 in `secrets.yaml` is secure enough for git.
- **Attack Scenario**: A malicious actor with access to the repository decodes the Base64 value, retrieves the JWT key, and signs custom JWT tokens to authenticate as an administrator.
- **Blast Radius**: Complete compromise of all API routes and database data access.
- **Mitigation**: Fetch the JWT secret from GCP Secret Manager dynamically.

### [High] Challenge 2: Keycloak Data Eviction
- **Assumption Challenged**: Keycloak pod will run continuously and store configurations safely in memory.
- **Attack Scenario**: GKE cluster node fails or reschedules the Keycloak pod. Upon startup on a new node, Keycloak uses a fresh H2 database, wiping out all previous config.
- **Blast Radius**: Total authentication system failure; users cannot log in.
- **Mitigation**: Mount a persistent volume or connect to Google Cloud SQL.

### [High] Challenge 3: Ingress HTTP Downgrade
- **Assumption Challenged**: Users will configure their own SSL termination externally.
- **Attack Scenario**: Man-in-the-middle (MITM) attacks capture plaintext traffic on port 80 since Ingress does not enforce or support HTTPS.
- **Blast Radius**: Eavesdropping on customer data.
- **Mitigation**: Configure TLS termination at GKE Ingress.

## Stress Test Results

- **Run deploy scripts without key file** -> Expect failure -> Script successfully stops when `gcp-key.json` is missing/empty -> **PASS**
- **Verify file deletion safety** -> Expect no files deleted -> Scripts move files to `certs/backup/` instead of removing them -> **PASS**

## Unchallenged Areas
- **GKE Cluster Deployment State**: Real deployment behavior of the manifests on GKE was not stress-tested because we do not have an active GCP cluster connection.
