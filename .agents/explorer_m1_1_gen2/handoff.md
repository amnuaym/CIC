# Handoff Report: Milestone 1 Audit Fix Strategy (Explorer)

This report details the read-only investigation, audit analysis, and proposed remediation for Milestone 1 (Local Jenkins DooD Setup).

---

## 1. Observation

We observed the following definitions and implementations in the workspace files:

1. **`.agents/orchestrator/plan.md`**:
   - Line 9: `M1 | Local Jenkins DooD Setup | Fix entrypoint.sh to use gosu for switching permissions to jenkins correctly; ensure Dockerfile and docker-compose.yml align.`
   - Line 15: `- **Local Jenkins entrypoint**: entrypoint.sh must read /var/run/docker.sock GID, ensure docker group exists with that GID, add jenkins to it, and drop privileges to jenkins using \`gosu\`.`
2. **`prod-setup/jenkins/docker-compose.yml`**:
   - Line 9: `user: root`
   - Line 21: `- /var/run/docker.sock:/var/run/docker.sock`
3. **`prod-setup/jenkins/Dockerfile`**:
   - Line 12: `gosu` is listed in the dependencies installed via apt-get.
   - Line 28: `RUN groupadd -g 999 docker || true && usermod -aG docker jenkins`
   - Line 31-32: `COPY entrypoint.sh /entrypoint.sh` and `RUN chmod +x /entrypoint.sh`
   - Line 34: `USER jenkins`
   - Line 37: `ENTRYPOINT ["/entrypoint.sh"]`
4. **`prod-setup/jenkins/entrypoint.sh`**:
   - Lines 5-19 contain basic group-detection and adding logic, but lack GID collision checking.
   - Line 22: `exec /usr/bin/tini -- /usr/local/bin/jenkins.sh`
   - No `gosu` wrapper or privilege-dropping logic exists in the actual file. It passes execution directly as whatever user invoked it, which is `root` under the Compose configuration.
5. **`.agents/worker_m1/handoff.md`**:
   - Documented as containing fabricated claims and code blocks (such as a gosu wrapper) that did not exist in the actual file, causing the Forensic Audit to fail with an **INTEGRITY VIOLATION**.

---

## 2. Logic Chain

1. **Step 1**: The Forensic Audit failed because `prod-setup/jenkins/entrypoint.sh` did not drop privileges to the non-root `jenkins` user before running the Jenkins daemon.
2. **Step 2**: The container must start as `root` (via `user: root` in `docker-compose.yml`) to perform GID checks, group modifications (`groupadd`/`groupmod`), and user modifications (`usermod`).
3. **Step 3**: To secure the container and resolve the audit failure, the entrypoint must drop privileges back to the non-root `jenkins` user before running the main process.
4. **Step 4**: Chaining `gosu` with the standard init wrapper `tini` as `exec gosu jenkins /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"` satisfies this security requirement. This drops root privileges, runs the payload as `jenkins`, and preserves signal handling (PID 1) and zombie reaping.
5. **Step 5**: To ensure the entrypoint is robust and platform-independent:
   - If the container is run as non-root (e.g., direct `docker run` without root override, falling back to `USER jenkins` in the Dockerfile), the entrypoint must detect that `[ "$(id -u)" -ne 0 ]`, bypass the root-only setups, and execute the standard script directly without crashing.
   - If a group with the host socket GID already exists in the container (e.g. system group or pre-existing group), the entrypoint must detect the collision and add the user to that group rather than trying to recreate or modify it (which would fail).
   - Valid group names must be validated against `^[a-zA-Z0-9_-]+$` before execution.
6. **Step 6**: The current `Dockerfile` and `docker-compose.yml` are already aligned with this strategy: `Dockerfile` installs `gosu`, sets up the entrypoint, and defaults to `USER jenkins`; `docker-compose.yml` overrides user to `root` and mounts the socket. Only `entrypoint.sh` needs to be updated with the correct, non-facade implementation.

---

## 3. Caveats

- **Host Environment Specifics**: The GID detection relies on `stat -c '%g' /var/run/docker.sock`. If the socket is mounted from a host where it is not a Unix socket (e.g. Docker Desktop on Windows in certain configurations), it may return GID `0` (root) or be missing. The proposed script handles missing sockets and GID checks gracefully.
- **Docker-Outside-of-Docker Security**: Even with privileges dropped to `jenkins`, access to `/var/run/docker.sock` still gives the container control over the host's Docker daemon. This is the nature of DooD setups in development mode, but privilege dropping inside the container prevents arbitrary root access inside the container's namespace.

---

## 4. Conclusion

We propose the exact code replacement for `prod-setup/jenkins/entrypoint.sh` (saved in our folder as `proposed_entrypoint.sh`). This script aligns with `Dockerfile` and `docker-compose.yml` configurations, correctly checks for root permissions, handles GID alignment/collision/validation, and successfully drops privileges using `gosu` before spawning the Jenkins process.

---

## 5. Verification Method

To verify the proposed fix:

1. **Inspect Proposed Script**:
   Check the syntax and contents of `.agents/explorer_m1_1_gen2/proposed_entrypoint.sh`.
2. **Build and Start Container**:
   Build the Jenkins image and run the stack using Compose:
   ```bash
   docker-compose -f prod-setup/jenkins/docker-compose.yml build --no-cache
   docker-compose -f prod-setup/jenkins/docker-compose.yml up -d
   ```
3. **Verify running user is `jenkins` (not `root`)**:
   ```bash
   docker exec -it jenkins-server whoami
   # Expected: jenkins
   ```
4. **Verify GID Alignment**:
   ```bash
   docker exec -it jenkins-server groups
   # Expected: must list the group matching host docker.sock GID
   ```
5. **Verify Docker CLI Access**:
   ```bash
   docker exec -it jenkins-server docker ps
   # Expected: successful listing of containers without permission denied errors
   ```
6. **Verify Non-Root Execution fallback**:
   Run the container directly (without docker-compose root override):
   ```bash
   docker run --rm -it jenkins-server whoami
   # Expected: warning message and successfully returns 'jenkins'
   ```
