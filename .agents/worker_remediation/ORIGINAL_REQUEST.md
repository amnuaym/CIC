## 2026-06-09T08:27:30Z
You are worker_remediation (Remediation & Fixes Worker).
Your working directory is D:\Github\CIC\.agents\worker_remediation.
Task: Remediate and fix all CI/CD, GCP, and Nginx SSL/TLS issues identified during the review and validation phase.
Implement the following changes:

1. **Jenkins & Docker Setup (M1 Fixes)**:
   - Create react-admin/nginx.conf with a custom block for SPA routing fallback:
     ```nginx
     server {
         listen 80;
         location / {
             root /usr/share/nginx/html;
             index index.html index.htm;
             try_files $uri $uri/ /index.html;
         }
     }
     ```
   - Update react-admin/Dockerfile to copy this nginx.conf to /etc/nginx/conf.d/default.conf.
   - Create react-admin/.dockerignore and go/.dockerignore to exclude node_modules and local build artifacts.
   - Move prod-setup/jenkins/Jenkinsfile to to_be_deleted/prod-setup-jenkins-Jenkinsfile to comply with the R4 safety constraint (no direct file deletions).
   - Update root Jenkinsfile:
     - Implement a robust PostgreSQL readiness wait loop with a retry/timeout exit check (do not use infinite loops).
     - Remove double compilation of the React frontend.
     - To prevent DooD named volume workspace mount failures, do not use stage-level agent { docker }. Instead, run unit/integration tests directly using CLI commands like docker run --rm -v $(pwd)/go:/app -w /app golang:1.21-alpine go test -v ./... or run them as builder steps in Dockerfile.
   - Update prod-setup/jenkins/docker-compose.yml:
     - Add resource constraints (limits cpus: '2.0', memory: 4096M).
     - Bind host ports to localhost (127.0.0.1:8080).

2. **GCP Deployment Setup (M2 Fixes)**:
   - Update prod-setup/gcp/terraform/main.tf to provision a Google Kubernetes Engine (GKE) cluster in addition to Cloud Run, resolving GKE/Cloud Run architectural mismatch.
   - Update prod-setup/gcp/manifests/secrets.yaml: replace plain encoded values with env placeholders (__JWT_SECRET__, __KEYCLOAK_PASS__) and document in deploy scripts how it replaces them dynamically using sed or env sub.
   - Update prod-setup/gcp/manifests/ingress.yaml to configure TLS termination and managed certificate annotations.
   - Create prod-setup/gcp/manifests/managed-certificate.yaml.
   - Update prod-setup/gcp/manifests/keycloak.yaml to connect to PostgreSQL database and have persistent storage.
   - Update prod-setup/gcp/deploy.sh & deploy.ps1 to do placeholder substitutions at deploy time.

3. **Nginx SSL & rotation (M3 Fixes)**:
   - Update prod-setup/nginx/nginx.conf:
     - Secure redirect on port 80 against Host Header Injection by redirecting to hardcoded cic.local.
     - Remove trailing slash dependency on API routes (like /api, /api/v1, /swagger).
   - Update prod-setup/nginx/rotate-certs.sh & rotate-certs.ps1:
     - Implement $LASTEXITCODE check in PowerShell.
     - Implement rollback logic (restore backup files if Nginx reload fails).
     - Set secure permissions (restrict key file access).

MANDATORY INTEGRITY WARNING:
DO NOT CHEAT. All implementations must be genuine. DO NOT hardcode test results, create dummy/facade implementations, or circumvent the intended task. A Forensic Auditor will independently verify your work. Integrity violations WILL be detected and your work WILL be rejected.

Output: Save your changes report to D:\Github\CIC\.agents\worker_remediation\handoff.md once complete, indicating all files updated. Report back to the main agent with send_message.

## 2026-06-11T05:38:53Z
You are a Worker subagent. Remediate Milestone 1 (Local Jenkins DooD Setup) in D:\Github\cic\.

### Tasks:
1. Overwrite `prod-setup/jenkins/entrypoint.sh` with the following content (LF line endings):
```bash
#!/usr/bin/env bash
set -e

DOCKER_SOCKET="/var/run/docker.sock"
JENKINS_USER="jenkins"

# Check if the script is running as root (UID 0)
if [ "$(id -u)" -eq 0 ]; then
    echo "[+] Running as root. Performing Docker GID alignment and group setup..."

    # Detect if the host's Docker socket is mounted
    if [ -e "$DOCKER_SOCKET" ]; then
        # Dynamically read the GID of the mounted /var/run/docker.sock
        DOCKER_GID=$(stat -c '%g' "$DOCKER_SOCKET")
        echo "[+] Detected host $DOCKER_SOCKET GID: $DOCKER_GID"

        # Check if the GID is a highly privileged system GID (< 100)
        if [ "$DOCKER_GID" -lt 100 ]; then
            echo "[!] Host Docker GID $DOCKER_GID is a highly privileged system GID (< 100)."
            echo "[!] Skipping group creation and addition to prevent privilege escalation."
        else
            # Check if a group with this GID already exists in the container
            EXISTING_GROUP=$(getent group "$DOCKER_GID" | cut -d: -f1 | head -n 1 || true)

            if [ -n "$EXISTING_GROUP" ]; then
                # Group exists. Check if it's our expected docker or docker-host group
                if [ "$EXISTING_GROUP" = "docker" ] || [ "$EXISTING_GROUP" = "docker-host" ]; then
                    echo "[+] Group '$EXISTING_GROUP' already exists with GID $DOCKER_GID. Adding '$JENKINS_USER'..."
                    usermod -aG "$EXISTING_GROUP" "$JENKINS_USER"
                else
                    echo "[!] GID collision: GID $DOCKER_GID is already used by group '$EXISTING_GROUP'."
                    # Handle GID collision safely: Create a non-unique group to grant access without system group hijacking
                    NEW_GROUP="docker-host-$DOCKER_GID"
                    
                    if getent group "$NEW_GROUP" >/dev/null 2>&1; then
                        echo "[+] Group '$NEW_GROUP' already exists. Adding '$JENKINS_USER' to it..."
                    else
                        echo "[+] Creating non-unique group '$NEW_GROUP' with GID $DOCKER_GID..."
                        groupadd -o -g "$DOCKER_GID" "$NEW_GROUP"
                    fi
                    usermod -aG "$NEW_GROUP" "$JENKINS_USER"
                fi
            else
                # No group exists with this GID. Create one safely.
                NEW_GROUP="docker-host"
                if getent group "$NEW_GROUP" >/dev/null 2>&1; then
                    # Group name 'docker-host' exists but has a different GID, append GID to avoid collision
                    NEW_GROUP="docker-host-$DOCKER_GID"
                fi
                echo "[+] Creating group '$NEW_GROUP' with GID $DOCKER_GID..."
                groupadd -g "$DOCKER_GID" "$NEW_GROUP"
                echo "[+] Adding '$JENKINS_USER' to group '$NEW_GROUP'..."
                usermod -aG "$NEW_GROUP" "$JENKINS_USER"
            fi
        fi
    else
        echo "[!] $DOCKER_SOCKET not found. Skipping GID alignment."
    fi

    # Drop privileges to the non-root jenkins user using gosu and pass control to tini/jenkins.sh
    echo "[+] Dropping privileges to '$JENKINS_USER'..."
    exec gosu "$JENKINS_USER" /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
else
    # Not running as root (e.g. USER jenkins in Dockerfile and no user override in run/compose)
    echo "[!] Running as non-root user ($(id -u)). Skipping group/socket GID modification."
    
    # Hand off to the standard Jenkins entrypoint directly without gosu
    exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
fi
```

2. Verify that `prod-setup/jenkins/Dockerfile` and `prod-setup/jenkins/docker-compose.yml` are still correctly configured (from the previous attempt) to install `gosu`, copy the entrypoint wrapper, set ENTRYPOINT, and run as root in compose. Make any necessary updates if they are not.
3. Ensure the `entrypoint.sh` file uses LF line endings (not CRLF) so it executes correctly in a Linux container.

### Verification:
Statically check file contents. If you attempt a docker build and it times out, document that verification was completed via static inspection of the scripts.

### MANDATORY INTEGRITY WARNING:
DO NOT CHEAT. All implementations must be genuine. DO NOT hardcode test results, create dummy/facade implementations, or circumvent the intended task. A Forensic Auditor will independently verify your work. Integrity violations WILL be detected and your work WILL be rejected.

Please write your handoff report to D:\Github\cic\.agents\worker_remediation\handoff.md and message me when complete.
