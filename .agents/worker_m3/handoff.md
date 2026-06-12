# Handoff Report — Milestone M3 (SSL/TLS & Key Rotation)

## 1. Observation
- Created target directory `prod-setup/nginx/` since it did not exist initially.
- Inspected the existing `nginx/nginx.conf` in the project root:
  - Line 10: `listen 80;`
  - Lines 13-18: `/health` -> `http://cic-api:8080/health`
  - Lines 21-27: `/swagger/` -> `http://cic-api:8080/swagger/`
  - Lines 30-35: `/api/` -> `http://cic-api:8080/api/`
  - Lines 38-43: `/api/v1/` -> `http://cic-api:8080/api/v1/`
  - Lines 46-51: `/` -> `http://react-admin:80/`
- Created secure Nginx configuration at `prod-setup/nginx/nginx.conf` which handles HTTP to HTTPS redirection and exposes port 443 with SSL enabled for local domain `cic.local`.
- Created Bash automation script at `prod-setup/nginx/rotate-certs.sh`.
- Created PowerShell automation script at `prod-setup/nginx/rotate-certs.ps1`.

## 2. Logic Chain
- To achieve M3 goals, we first matched all proxy routes from `nginx/nginx.conf` in the project root.
- To enable secure HTTP-to-HTTPS redirection, we configured a server block on port 80 that returns 301 redirection to `https://$host$request_uri`.
- For HTTPS on port 443, we added certificate and key paths (`/etc/nginx/certs/cic.local.crt` and `/etc/nginx/certs/cic.local.key`) and robust TLS protocol versions (`TLSv1.2 TLSv1.3`) along with secure cipher suites.
- To ensure certificate rotation script works seamlessly, we used `openssl` with a dynamic configuration template specifying `subjectAltName` for `cic.local` and `localhost`.
- Both rotation scripts create the target `certs` directory if it does not exist, run the OpenSSL generation command, and reload Nginx using `docker exec cic-nginx nginx -s reload` or `nginx -s reload` if either is present and running.

## 3. Caveats
- The Nginx reload command is conditional on `cic-nginx` docker container or `nginx` system service being active. If they are not found during script execution, a warning will be logged, but the certificate generation will still succeed.
- Running the PowerShell script requires execution permissions (`Set-ExecutionPolicy`) and `openssl` to be present in Windows PATH.

## 4. Conclusion
- Secure HTTPS gateway Nginx configuration (`prod-setup/nginx/nginx.conf`) and dual-platform automated key rotation scripts (`prod-setup/nginx/rotate-certs.sh` and `prod-setup/nginx/rotate-certs.ps1`) have been successfully implemented.

## 5. Verification Method
1. Inspect the configuration file at `prod-setup/nginx/nginx.conf` to verify redirect and routing configurations.
2. Run the rotation script:
   - On Linux/macOS: `bash prod-setup/nginx/rotate-certs.sh`
   - On Windows: `powershell -File prod-setup/nginx/rotate-certs.ps1`
3. Verify that the files `cic.local.crt` and `cic.local.key` are successfully generated in `prod-setup/nginx/certs/`.
4. Inspect the generated certificate's SAN extensions by running:
   ```bash
   openssl x509 -in prod-setup/nginx/certs/cic.local.crt -text -noout | grep -A1 "Subject Alternative Name"
   ```
   Check that it includes `DNS:cic.local` and `DNS:localhost`.
