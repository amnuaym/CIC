# Handoff Report: Milestone 1 Jenkins DooD Privilege Escalation Fix

This report outlines the observations, logic chain, and proposed remediation strategy to address the Forensic Audit verdict of **INTEGRITY VIOLATION** for Milestone 1.

---

## 1. Observation

### 1.1 Docker Compose User Configuration
In `prod-setup/jenkins/docker-compose.yml` (lines 4-11):
```yaml
  jenkins:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: jenkins-server
    user: root
```
The container is explicitly configured to run as `root` at startup.

### 1.2 Entrypoint Privilege Hand-off
In the actual `prod-setup/jenkins/entrypoint.sh` (lines 21-22):
```bash
# Hand off to the standard Jenkins entrypoint
exec /usr/bin/tini -- /usr/local/bin/jenkins.sh
```
The script ends by executing the Jenkins start script as the active user (`root`) without dropping privileges.

### 1.3 Dockerfile Configuration
In `prod-setup/jenkins/Dockerfile` (lines 34-37):
```dockerfile
USER jenkins

# Set entrypoint to our custom wrapper script
ENTRYPOINT ["/entrypoint.sh"]
```
The image specifies `USER jenkins` by default, but this is overridden by `user: root` in the docker-compose configuration.

### 1.4 Plan requirements
In `.agents/orchestrator/plan.md` (lines 14-15):
```markdown
- **Local Jenkins entrypoint**: entrypoint.sh must read /var/run/docker.sock GID, ensure docker group exists with that GID, add jenkins to it, and drop privileges to jenkins using `gosu`.
```

---

## 2. Logic Chain

1. **Premise 1**: The orchestrator plan demands that the entrypoint dynamically maps the GID of `/var/run/docker.sock`, adds the `jenkins` user to that group, and drops privileges to the `jenkins` user using `gosu`.
2. **Premise 2**: Since `user: root` is specified in `docker-compose.yml`, the container starts as `root`. This allows the script to successfully run user/group modification tools (`groupadd`, `usermod`).
3. **Premise 3**: The original `entrypoint.sh` lacks the privilege-dropping code block using `gosu`. Instead, it invokes the Jenkins entrypoint as root (`exec /usr/bin/tini ...`), creating a security facade that keeps the Jenkins process running as root.
4. **Premise 4**: To remediate this, `entrypoint.sh` must check if it is running as root, detect and handle the host Docker socket GID, perform GID collision and name collision checks, add the `jenkins` user to that group, and explicitly call `exec gosu jenkins ...` to drop root privileges.
5. **Premise 5**: If the container starts as non-root (e.g. without `user: root` specified in compose), it must bypass root-only changes to avoid permission errors and execute Jenkins directly.

---

## 3. Caveats
* The verification commands (such as running `docker build` and testing container execution) were not run locally because terminal execution timed out waiting for user approval.
* The analysis assumes that the Docker daemon `/var/run/docker.sock` is mounted as a bind mount (as defined in `docker-compose.yml`). If the socket is not mounted, the entrypoint will log a warning and proceed without group alignment.

---

## 4. Conclusion
The INTEGRITY VIOLATION was caused by a missing privilege dropping mechanism in `entrypoint.sh`, leaving the Jenkins process running as root. 
The proposed fix strategy resolves this by modifying `prod-setup/jenkins/entrypoint.sh` to include a full root check, GID alignment, GID collision checking, group name validation, privilege dropping via `gosu`, and fallback behavior for non-root execution. No changes are required for `Dockerfile` or `docker-compose.yml` as they are already aligned.

---

## 5. Verification Method

To verify the proposed fix:
1. Replace `prod-setup/jenkins/entrypoint.sh` with the proposed code block in `analysis.md`.
2. Build the Jenkins image:
   ```bash
   docker build -t jenkins-server-test prod-setup/jenkins
   ```
3. Run the container via Compose:
   ```bash
   docker compose -f prod-setup/jenkins/docker-compose.yml up -d
   ```
4. Verify the process is running under the `jenkins` user:
   ```bash
   docker exec -it jenkins-server whoami
   # Expected output: jenkins

   docker exec -it jenkins-server ps aux
   # Expected output: Jenkins process is owned by 'jenkins' (PID 1/etc. via tini)
   ```
5. Verify Docker socket accessibility:
   ```bash
   docker exec -it jenkins-server docker ps
   # Expected output: Successfully lists host docker containers (proving DooD works without root)
   ```
