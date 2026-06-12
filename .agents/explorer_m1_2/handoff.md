# Handoff Report: Local Jenkins DooD Setup Design Investigation (Milestone 1)

## 1. Observation
1. **Orchestrator Plan:**
   - File path: `.agents/orchestrator/plan.md`
   - Line 9: `| M1 | Local Jenkins DooD Setup | Implement entrypoint.sh, modify Dockerfile and docker-compose.yml to dynamically resolve socket permissions issues. | none | PLANNED |`
   - Line 15: `- **Local Jenkins entrypoint**: entrypoint.sh must read /var/run/docker.sock GID, ensure docker group exists with that GID, add jenkins to it, and exec the Jenkins entrypoint as jenkins.`

2. **Existing Dockerfile:**
   - File path: `prod-setup/jenkins/Dockerfile`
   - Lines 27-30:
     ```dockerfile
     RUN groupadd -g 999 docker || true && usermod -aG docker jenkins
     
     # Revert back to the jenkins user
     USER jenkins
     ```
   - Current setup builds the image with static GID 999 and switches to non-root `USER jenkins`.

3. **Existing Docker Compose:**
   - File path: `prod-setup/jenkins/docker-compose.yml`
   - Lines 4-8:
     ```yaml
     services:
       jenkins:
         build:
           context: .
           dockerfile: Dockerfile
         container_name: jenkins-server
     ```
   - Lines 19-20:
     ```yaml
           # Bind mount the host's Docker socket to communicate with the host daemon
           - /var/run/docker.sock:/var/run/docker.sock
     ```
   - The compose file currently binds `/var/run/docker.sock` but does not configure container execution as `root` (lacks `user: root`).

4. **Previous Agent Investigation:**
   - File path: `.agents/explorer_m1_1/handoff.md`
   - Lines 36-39: Recommended Docker-outside-of-Docker (DooD) setup, but proposed static GID `999` in `Dockerfile.jenkins`.

---

## 2. Logic Chain
1. **Dynamic Socket Permissions Issue:** Because GID of `/var/run/docker.sock` on the host machine varies (it is not always 999), a static group creation in the Dockerfile will fail to grant Jenkins access to the Docker socket on hosts where GID differs.
2. **Runtime Resolution Requirement:** To handle variable GIDs, the group assignment must occur at container startup (runtime) using a wrapper entrypoint script.
3. **Execution as Root:** The container must run as `root` during startup to possess the required privileges to read `/var/run/docker.sock`'s GID, create or modify groups, and add the `jenkins` user to the group. Therefore, the docker-compose service configuration must override user execution using `user: root` (Observation 3).
4. **Tool Selection for Privilege Dropping:** Once the script runs as root and configures permissions, it must execute Jenkins as the `jenkins` user. `gosu` is chosen over `su`/`sudo` because it avoids TTY/signal propagation issues, ensuring that the process receives signals directly and cleanly shuts down.
5. **Entrypoint Design:**
   - Extract the GID of `/var/run/docker.sock` via `stat -c '%g' /var/run/docker.sock`.
   - Check if the GID is already defined in `/etc/group`.
   - If defined, add `jenkins` to that group.
   - If not defined, create the `docker` group with that GID (or modify the existing `docker` group's GID) and add `jenkins`.
   - Re-run the main entrypoint: `exec gosu jenkins /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"`.

---

## 3. Caveats
1. **Security Exposure:** Giving the `jenkins` user access to the host's `/var/run/docker.sock` allows executing docker commands as root on the host machine, effectively granting complete administrative access to the host system. This is an inherent risk of Docker-outside-of-Docker (DooD).
2. **Alternative Host OS (Windows/macOS):** On Docker Desktop for Windows or macOS, `/var/run/docker.sock` is often mounted with standard permissions (e.g. root:root with read/write to everyone) or might not use numeric GIDs. The script addresses this by checking if the GID group mapping is necessary and falls back cleanly if group operations fail or are not required.
3. **Tini Location:** The script assumes `tini` is located at `/usr/bin/tini` as configured in the standard `jenkins/jenkins` base image. If the base image changes this location, the entrypoint script must be updated accordingly.

---

## 4. Conclusion
We propose a robust design for Milestone 1:
- An `entrypoint.sh` wrapper script that dynamically aligns the docker group GID inside the container with `/var/run/docker.sock`'s GID at startup.
- A modified `Dockerfile` that installs `gosu`, sets up default group configurations, copies the entrypoint wrapper, and sets the default `ENTRYPOINT`.
- A modified `docker-compose.yml` that mounts the socket and configures the container to run as `user: root`.

The proposed file designs have been documented in detail in `D:\Github\cic\.agents\explorer_m1_2\analysis.md`.

---

## 5. Verification Method
To verify the proposed setup once implemented:
1. Build and start the container using the modified configurations:
   ```bash
   docker compose -f prod-setup/jenkins/docker-compose.yml up -d --build
   ```
2. Verify that the `jenkins-server` container starts successfully and the logs indicate dynamic group mapping:
   ```bash
   docker logs jenkins-server
   ```
   *Expected log output:*
   ```
   Docker socket found. GID is <host_docker_gid>
   Creating/modifying group 'docker' with GID <host_docker_gid>
   Switching to user 'jenkins' and executing main Jenkins entrypoint...
   ```
3. Run a test command inside the container as the `jenkins` user to verify Docker daemon accessibility:
   ```bash
   docker exec -u jenkins -it jenkins-server docker ps
   ```
   *Pass Condition:* The command outputs the list of running containers on the host machine without permission errors.
4. Verify that signal forwarding works (for graceful shutdown):
   ```bash
   docker stop jenkins-server
   ```
   *Pass Condition:* The container shuts down cleanly within a few seconds (signaling that `gosu` successfully forwarded the signal to `tini` and Jenkins).
