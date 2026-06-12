## 2026-06-09T08:20:27Z
You are worker_m3_gen2, a worker subagent.
Your task is to implement the SSL/TLS and Key Rotation setup (Milestone M3) for the CIC application.

Read the explorer handoff files for design details:
1. D:\Github\CIC\.agents\explorer_m3_1_gen2\handoff.md (Nginx HTTPS & docker-compose design)
2. D:\Github\CIC\.agents\explorer_m3_2_gen2\handoff.md (Certificate generation & rotation scripts)
3. D:\Github\CIC\.agents\explorer_m3_3_gen2\handoff.md (Testing, verification, and integration strategy)

Your implementation must:
1. Create the 'prod-setup/nginx/' directory.
2. Create 'prod-setup/nginx/nginx.conf' with the secure SSL Nginx configuration listening on 443 for cic.local, redirecting HTTP (port 80) to HTTPS (port 443), and reverse-proxying key application paths.
3. Create 'prod-setup/nginx/certs/' directory.
4. Implement both 'prod-setup/nginx/rotate-certs.sh' (Bash) and 'prod-setup/nginx/rotate-certs.ps1' (PowerShell) scripts.
   - The scripts must generate a self-signed certificate for cic.local with Subject Alternative Name (SAN) using openssl.
   - The scripts must reload the Nginx container (cic-nginx) using 'docker exec cic-nginx nginx -s reload'.
   - The scripts must NOT delete any old certificate files directly. Instead, move pre-existing certificates to a backup/ subdirectory with a timestamp (e.g. cic.local.crt.YYYYMMDD_HHMMSS).
5. Edit the root 'docker-compose.yml' file to:
   - Expose port 443 for Nginx.
   - Update mounts for Nginx to map './prod-setup/nginx/nginx.conf' to '/etc/nginx/nginx.conf:ro' and './prod-setup/nginx/certs' to '/etc/nginx/certs:ro'.
   - Set 'VITE_API_URL' to 'https://cic.local/api/v1' in the 'react-admin' args and environment.
6. Generate initial certificates in 'prod-setup/nginx/certs/' by running the rotation script once (or the OpenSSL command).
7. Test the setup to ensure Nginx configuration syntax is valid and services boot up. Run the verification steps outlined in the Explorer 3 handoff report.
8. If needed, configure Playwright to bypass SSL errors (e.g., set 'ignoreHTTPSErrors: true' in 'e2e-tests/playwright.config.ts') to allow the test suite to pass.

CRUCIAL CONSTRAINTS:
- No file is allowed to be deleted directly. Any deleted targets must be moved to a 'to_be_deleted/' folder and require explicit user approval.
- Do NOT delete the original 'nginx/nginx.conf' file in the root 'nginx/' directory, as it's not a direct replacement; just leave it as is or move it only if necessary (and in that case, to 'to_be_deleted/').
- Do not reuse a subagent after it has delivered its handoff.
- Write your agent metadata (progress.md, BRIEFING.md, handoff.md) only to your working directory: D:\Github\CIC\.agents\worker_m3_gen2

MANDATORY INTEGRITY WARNING:
DO NOT CHEAT. All implementations must be genuine. DO NOT hardcode test results, create dummy/facade implementations, or circumvent the intended task. A Forensic Auditor will independently verify your work. Integrity violations WILL be detected and your work WILL be rejected.

When completed, verify that all services compile/build/run, and document your verification commands and results in your handoff report. Then message the orchestrator (ee155bc0-aa40-40c8-a6e7-7d0690efe810).
