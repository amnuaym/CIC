## 2026-06-09T08:20:05Z
You are worker_m3 (Nginx SSL and Rotation Worker).
Your working directory is D:\Github\CIC\.agents\worker_m3.
Task: Implement the SSL/TLS configuration and mock automated certificate rotation scripts for Nginx gateway (Milestone M3).
1. Create prod-setup/nginx/nginx.conf:
   - Expose port 443 with SSL enabled for local domain cic.local.
   - Implement HTTP (port 80) to HTTPS (port 443) redirection.
   - Configure proxy routes matching nginx/nginx.conf in the project root:
     - /health -> http://cic-api:8080/health
     - /swagger/ -> http://cic-api:8080/swagger/
     - /api/ -> http://cic-api:8080/api/v1/
     - /api/v1/ -> http://cic-api:8080/api/v1/
     - / -> http://react-admin:80/
   - Set up robust TLS protocol options (TLSv1.2, TLSv1.3), secure cipher suites, and paths to SSL certificates: /etc/nginx/certs/cic.local.crt and /etc/nginx/certs/cic.local.key.
2. Create prod-setup/nginx/rotate-certs.sh (Bash) and prod-setup/nginx/rotate-certs.ps1 (PowerShell for Windows hosts):
   - Automated scripts that use openssl command to generate a self-signed certificate and private key for cic.local (with subjectAltName set to include cic.local and localhost, key size 2048, validity 365 days).
   - Write the generated files to the certs directory.
   - Run Nginx reload command (e.g. docker exec cic-nginx nginx -s reload or nginx -s reload) to dynamically load the new certificates.

MANDATORY INTEGRITY WARNING:
DO NOT CHEAT. All implementations must be genuine. DO NOT hardcode test results, create dummy/facade implementations, or circumvent the intended task. A Forensic Auditor will independently verify your work. Integrity violations WILL be detected and your work WILL be rejected.

Output: Save your changes report to D:\Github\CIC\.agents\worker_m3\handoff.md once complete, indicating files created. Call send_message back to the main agent.
