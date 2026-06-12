# Verification & Security Challenge Report: SSL & Nginx Configuration

## 1. Observation
I have performed a detailed code audit of the Nginx configuration and certificate rotation scripts in the `prod-setup/nginx/` directory.

### Verified Files:
- **Nginx Configuration**: `prod-setup/nginx/nginx.conf`
- **Bash Rotation Script**: `prod-setup/nginx/rotate-certs.sh`
- **PowerShell Rotation Script**: `prod-setup/nginx/rotate-certs.ps1`
- **Docker Compose**: `docker-compose.yml`

### Verbatim Findings:
1. **Nginx HTTP-to-HTTPS Redirection (`nginx.conf` lines 48-54)**:
   ```nginx
   server {
       listen 80;
       listen [::]:80;
       server_name cic.local localhost;

       return 301 https://$host$request_uri;
   }
   ```
2. **Nginx HTTPS Server (`nginx.conf` lines 57-64)**:
   ```nginx
   server {
       listen 443 ssl http2;
       listen [::]:443 ssl http2;
       server_name cic.local localhost;

       # Certificate Files
       ssl_certificate /etc/nginx/certs/cic.local.crt;
       ssl_certificate_key /etc/nginx/certs/cic.local.key;
   ```
3. **Nginx Locations (`nginx.conf` lines 81-103)**:
   ```nginx
   location /health {
       proxy_pass http://cic-api:8080/health;
   }
   location /swagger/ {
       proxy_pass http://cic-api:8080/swagger/;
   }
   location /api/ {
       proxy_pass http://cic-api:8080/api/;
   }
   location /api/v1/ {
       proxy_pass http://cic-api:8080/api/v1/;
   }
   location / {
       proxy_pass http://react-admin:80/;
   }
   ```
4. **PowerShell Nginx Reload Logic (`rotate-certs.ps1` lines 81-93)**:
   ```powershell
   if (Get-Command docker -ErrorAction SilentlyContinue) {
       $containerRunning = docker inspect -f '{{.State.Running}}' cic-nginx 2>$null
       if ($containerRunning -eq "true") {
           Write-Host "Reloading Nginx service in 'cic-nginx' container..."
           docker exec cic-nginx nginx -s reload
           Write-Host "Nginx configuration reloaded successfully."
       }
   ```

---

## 2. Logic Chain
1. **HTTP/2 Deprecation**: The `http2` parameter on the `listen` directive (e.g. `listen 443 ssl http2;`) was deprecated starting with Nginx 1.25.1. Modern `nginx:alpine` docker images run version 1.25+ or 1.27+, which emits a deprecation warning at startup/reload.
2. **Host Header Open Redirect**: In `listen 80`, because there is no default server block that drops unmatched host headers, Nginx routes all requests here. The redirect using `$host` will redirect clients to whatever hostname is provided in the `Host` header, exposing the setup to Host Header Injection / Open Redirect vulnerabilities.
3. **Trailing Slash Mismatch (Proxy Bypass)**:
   - In `nginx.conf`, the location blocks `/api/`, `/api/v1/`, and `/swagger/` require trailing slashes.
   - If a request is made to `https://cic.local/api` (without the trailing slash), it fails to match `location /api/`.
   - Instead, it matches the catch-all `location /` and gets proxied to `http://react-admin:80/` (frontend).
   - This results in API calls without trailing slashes failing or displaying frontend pages.
4. **PowerShell False Success on Reload Failure**:
   - In `rotate-certs.ps1`, the command `docker exec cic-nginx nginx -s reload` is executed.
   - External executables in PowerShell do not throw exceptions on non-zero exit codes.
   - Because the script does not check `$LASTEXITCODE`, if the Nginx reload fails (e.g., due to an invalid configuration or certificate issue), the script continues and outputs `"Nginx configuration reloaded successfully."` instead of failing.
5. **Lack of Certificate Rollback**:
   - Both `rotate-certs.sh` and `rotate-certs.ps1` use `mv` / `Move-Item` to archive the active certificates before writing the new ones.
   - If the script is interrupted or fails in between, the certificates are missing, causing Nginx to fail on startup.
   - If Nginx reload fails, the scripts do not restore the old working certificates.

---

## 3. Caveats
- I observed that the `prod-setup/nginx/certs/` folder on the host is currently empty (except for `.gitkeep`), but the container `cic-nginx` is running. This means Nginx is running in memory with certificates that have since been deleted or not yet rotated on the host. **Restarting the Nginx container before running a rotation script will cause Nginx to crash on startup.**
- Actual OpenSSL commands were simulated and verified textually rather than executed interactively because command execution required user approval and timed out.

---

## 4. Conclusion
The Nginx configurations and certificate rotation scripts are generally well-designed but contain a few critical logic and security flaws:
1. **PowerShell Reload Error Suppression**: `rotate-certs.ps1` fails to check `$LASTEXITCODE` after running Nginx reload, leading to false success reports.
2. **Host Header / Open Redirect**: The HTTP-to-HTTPS redirect is vulnerable to Host Header Injection.
3. **Trailing Slash Mismatches**: API paths without trailing slashes are incorrectly proxied to the React frontend rather than the Go API.
4. **Missing Rollback Mechanism**: Script failures during rotation can leave Nginx without certificate files or with invalid ones.

---

## 5. Verification Method
To independently verify the certificate rotation:
1. Run the rotation script:
   - Linux/Bash: `bash prod-setup/nginx/rotate-certs.sh`
   - Windows/PowerShell: `powershell -File prod-setup/nginx/rotate-certs.ps1`
2. Check that the files `cic.local.crt` and `cic.local.key` are created in `prod-setup/nginx/certs/`.
3. Verify the generated certificate SAN attributes using:
   `openssl x509 -in prod-setup/nginx/certs/cic.local.crt -text -noout`
   Look for:
   `Subject Alternative Name: DNS:cic.local, DNS:www.cic.local, DNS:localhost, IP:127.0.0.1`
4. Test Nginx configuration syntax inside the container:
   `docker exec cic-nginx nginx -t`

---

# Adversarial Review / Challenge Report

**Overall risk assessment**: MEDIUM

## Challenges

### [High] Challenge 1: PowerShell Reload Failure Masked
- **Assumption challenged**: PowerShell stops execution when external commands fail because `$ErrorActionPreference = "Stop"` is set.
- **Attack/Failure scenario**: If Nginx configuration contains a syntax error or a new cert is corrupted, `docker exec cic-nginx nginx -s reload` fails with exit code 1. PowerShell ignores the non-zero exit code of external executables, prints `"Nginx configuration reloaded successfully"`, and exits with status 0.
- **Blast radius**: The administrator is falsely assured that the rotation succeeded, while Nginx is either still using the old certificate or has failed silently.
- **Mitigation**: Add a `$LASTEXITCODE` check in `rotate-certs.ps1`:
  ```powershell
  docker exec cic-nginx nginx -s reload
  if ($LASTEXITCODE -ne 0) {
      Write-Error "Nginx reload failed."
      Exit $LASTEXITCODE
  }
  ```

### [Medium] Challenge 2: Trailing Slash Proxy Mismatch
- **Assumption challenged**: Requests to `/api`, `/api/v1`, and `/swagger` will reach the Go API gateway.
- **Attack/Failure scenario**: A client sends a request to `https://cic.local/api`. It matches `location /` and is routed to the React admin frontend (`http://react-admin:80/api`) instead of the Go backend, resulting in a 404 or broken frontend routing.
- **Blast radius**: API routing failure.
- **Mitigation**: Rewrite or specify separate prefix matches without trailing slashes, e.g.:
  ```nginx
  location /api {
      proxy_pass http://cic-api:8080;
  }
  ```

### [Medium] Challenge 3: Host Header Injection / Open Redirect
- **Assumption challenged**: The HTTP port 80 redirect only processes traffic for `cic.local` and `localhost`.
- **Attack/Failure scenario**: An attacker sends an HTTP request to the server with `Host: malicious.com`. Because there is no default server block rejecting unmatched hosts, Nginx uses the first server block, matches the request, and redirects the client to `https://malicious.com/...`.
- **Blast radius**: Open redirect vulnerability.
- **Mitigation**: Change the redirect target to use a hardcoded hostname:
  ```nginx
  return 301 https://cic.local$request_uri;
  ```

### [Low] Challenge 4: Temporary File Absence / Lack of Rollback
- **Assumption challenged**: Moving files is always successful and doesn't affect Nginx uptime.
- **Attack/Failure scenario**: The active certificate is moved to backup. Before the new certificate can be moved to active, the script is killed or disk runs out. Nginx is left without certificates, causing startup failure. If reload fails, the old certificate is not restored.
- **Blast radius**: Service downtime.
- **Mitigation**: Use copy (`cp`) for backup and force-move (`mv -f`) to replace. Implement a trap/catch block to restore backup files if reload fails.

## Stress Test Results

| Scenario | Expected Behavior | Predicted Behavior | Pass/Fail |
|---|---|---|---|
| Run OpenSSL generation | Produces 2048-bit RSA cert with `cic.local` and `localhost` SANs | Produces correct cert structure | **PASS** |
| Run PowerShell script with Nginx stopped | Warning printed, script completes without error | Warning printed, script completes | **PASS** |
| Run PowerShell script with syntax error in Nginx config | Script fails and reports reload failure | Script prints success message and exits | **FAIL** |
| Request `https://cic.local/api` (no slash) | Request routed to Go API `/api/` | Request routed to React frontend `/` | **FAIL** |
| Request HTTP port 80 with `Host: attacker.com` | Redirect to `https://cic.local/` | Redirect to `https://attacker.com/` | **FAIL** |

## Untested Areas
- **GCP manifests / Keycloak settings**: Out of scope for this audit.
