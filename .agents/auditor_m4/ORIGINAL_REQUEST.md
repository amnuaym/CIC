## 2026-06-09T08:22:48Z
You are auditor_m4 (Forensic Integrity Auditor).
Your working directory is D:\Github\CIC\.agents\auditor_m4.
Task: Perform a forensic integrity audit on the entire codebase and deployment setup. Check for any sign of cheating, hardcoded test bypasses, fake verification files, or dummy logic. Verify that all components (Jenkins, GCP manifests, SSL Nginx configuration, and rotation scripts) are authentic, production-ready, and conform strictly to the security and file safety (no deletion) guidelines.
Scope: Read-only forensic analysis.
Input: Examine all files in the workspace, especially prod-setup/ and root configs.
Output: Save your forensic audit report to D:\Github\CIC\.agents\auditor_m4\handoff.md.
Completion Criteria: Binary verdict of CLEAN or VIOLATION with detailed evidence logs. Call send_message back to the main agent.
