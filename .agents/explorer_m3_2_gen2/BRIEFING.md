# BRIEFING — 2026-06-09T08:20:00Z

## Mission
Design OpenSSL command parameters to generate a self-signed certificate for cic.local with a SAN, and write cross-platform rotation scripts (Bash & PowerShell) to generate, rotate, and reload Nginx container safely.

## 🔒 My Identity
- Archetype: explorer
- Roles: Cert Rotation Script Explorer
- Working directory: D:\Github\CIC\.agents\explorer_m3_2_gen2
- Original parent: 5b0ce7f9-0cef-4d42-8d0a-da8eb0e62bf6
- Milestone: Cert Rotation Investigation

## 🔒 Key Constraints
- Read-only investigation — do NOT implement
- Do not make changes to any source/build files. Provide only recommendations and proposed scripts in handoff.md.
- Ensure no files are deleted directly. If any files must be replaced/rotated, ensure safety.
- Detail where certificates are stored on host and how they map to Nginx container.
- CODE_ONLY network mode

## Current Parent
- Conversation ID: 5b0ce7f9-0cef-4d42-8d0a-da8eb0e62bf6
- Updated: 2026-06-09T08:20:00Z

## Investigation State
- **Explored paths**:
  - `D:\Github\CIC\docker-compose.yml`
  - `D:\Github\CIC\nginx\nginx.conf`
  - `D:\Github\CIC\.agents\sub_orch_prod_setup_gen2\BRIEFING.md`
  - `D:\Github\CIC\PROJECT.md`
- **Key findings**:
  - Existing Nginx maps `./nginx/nginx.conf` to `/etc/nginx/nginx.conf` on port 80.
  - Modern browsers require Subject Alternative Name (SAN) in SSL certificates; commonName is deprecated.
  - Recommended OpenSSL parameters utilize the `-addext` option, with a fallback `openssl.cnf` structure for older setups.
  - Active certs reside in `prod-setup/nginx/certs/`, mapped to `/etc/nginx/certs:ro` in container.
  - Rotate scripts check container status and call `docker exec cic-nginx nginx -s reload`.
  - Non-destructive backup of old certificates to `certs/backup/` with timestamps.
- **Unexplored areas**: None. All requirements covered.

## Key Decisions Made
- Active certificates stored at `prod-setup/nginx/certs/`.
- Archive old certificates in `prod-setup/nginx/certs/backup/` rather than deleting.
- Mount certificates read-only in Nginx container.
- Retain HTTP health check capability on port 80 to prevent disruption.

## Artifact Index
- D:\Github\CIC\.agents\explorer_m3_2_gen2\handoff.md — Analysis and recommendation report
