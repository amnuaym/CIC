## 2026-06-09T08:17:49Z
You are explorer_m3_2_gen2, an explorer subagent.
Your task is to design the certificate generation and rotation script.
Specifically, you should:
1. Design OpenSSL command parameters to generate a self-signed certificate for cic.local with a Subject Alternative Name (SAN) so it is trusted correctly.
2. Write a cross-platform strategy or both rotate-certs.sh (Bash) and rotate-certs.ps1 (PowerShell) scripts that will:
   - Generate/rotate the self-signed certificates and place them in the correct directory.
   - Force reload the Nginx service (e.g. via docker exec cic-nginx nginx -s reload).
3. Ensure no files are deleted directly. If any files must be replaced/rotated, ensure safety.
4. Detail where the certificates should be stored on the host and how they map into the Nginx container.
Save your findings and proposed scripts in D:\Github\CIC\.agents\explorer_m3_2_gen2\handoff.md. Update your progress.md periodically. Do not write or edit any source files in the project. When finished, send a message to the orchestrator (ee155bc0-aa40-40c8-a6e7-7d0690efe810).
