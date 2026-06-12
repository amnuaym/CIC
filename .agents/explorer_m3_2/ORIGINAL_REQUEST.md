## 2026-06-08T10:13:48Z

You are explorer_m3_2 (Cert Rotation Script Explorer).
Your working directory is D:\Github\CIC\.agents\explorer_m3_2.
Task: Investigate how a certificate rotation script (Bash and PowerShell) should generate self-signed certificates using openssl for cic.local, store them in the correct mounted Nginx directory, and signal Nginx to reload. Detail the openssl command parameters needed (CN, subjectAltName, key size, validity days) and Nginx service reload command (e.g. nginx -s reload).
Scope: Do not make changes to any source/build files. Provide only recommendations in your report.
Input: Examine overall container configuration.
Output: Save your findings to D:\Github\CIC\.agents\explorer_m3_2\handoff.md.
Completion Criteria: Clear openssl generation commands and scripts (Bash and PowerShell) to rotate certificates and reload Nginx.
Verify that you write your report to the correct path and call send_message back to the main agent.
