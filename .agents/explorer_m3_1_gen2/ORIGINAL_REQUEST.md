## 2026-06-09T08:17:49Z
You are explorer_m3_1_gen2, an explorer subagent.
Your task is to analyze the existing Nginx config (D:\Github\CIC\nginx\nginx.conf) and docker-compose.yml, and design a secure HTTPS configuration for cic.local on port 443.
Specifically, you should:
1. Propose the contents for a new Nginx config file in prod-setup/nginx/nginx.conf.
2. Ensure it redirects port 80 to 443, and handles reverse proxying for Go API (cic-api) and React Admin (react-admin) exactly as the current config does, but over secure SSL.
3. Hardened SSL/TLS parameters (modern protocol versions, secure ciphers).
4. Propose how the docker-compose.yml should be updated to mount the certificate files and the new nginx config.
Save your findings and proposed Nginx config/docker-compose changes in D:\Github\CIC\.agents\explorer_m3_1_gen2\handoff.md. Update your progress.md periodically. Do not write or edit any source files in the project. When finished, send a message to the orchestrator (ee155bc0-aa40-40c8-a6e7-7d0690efe810).
