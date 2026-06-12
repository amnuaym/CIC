# Handoff Report: Milestone 1 (Local Jenkins DooD Setup)

## 1. Observation
- The orchestrator plan at `D:\Github\cic\.agents\orchestrator\plan.md` outlines the Milestone 1 contract:
  - Line 9: `| M1 | Local Jenkins DooD Setup | Implement entrypoint.sh, modify Dockerfile and docker-compose.yml to dynamically resolve socket permissions issues. | none | PLANNED |`
  - Line 15: `- **Local Jenkins entrypoint**: entrypoint.sh must read /var/run/docker.sock GID, ensure docker group exists with that GID, add jenkins to it, and exec the Jenkins entrypoint as jenkins.`
- The current `prod-setup/jenkins/Dockerfile` hardcodes GID 999:
  - Lines 27-30:
    ```dockerfile
    RUN groupadd -g 999 docker || true && usermod -aG docker jenkins

    # Revert back to the jenkins user
    USER jenkins
    ```
- The current `prod-setup/jenkins/docker-compose.yml` mounts the docker socket:
  - Lines 19-20:
    ```yaml
          # Bind mount the host's Docker socket to communicate with the host daemon
          - /var/run/docker.sock:/var/run/docker.sock
    ```
  - It does not specify `user: root`.

---

## 2. Logic Chain
1. To modify group memberships and adjust GIDs inside the container at startup, the container's entrypoint process must run as `root` (supported by observations of `Dockerfile` currently ending with `USER jenkins` which runs the entrypoint as non-root).
2. Running the container as `root` requires modifying the `Dockerfile` to end with `USER root` and updating `docker-compose.yml` to specify `user: root`.
3. To safely drop privileges from `root` to `jenkins` after group adjustment, standard Unix tools like `su` or `sudo` create nested process hierarchies and can break signal handling. Installing `gosu` via Debian apt repositories provides a clean, single-process way to execute `/usr/bin/tini` and `/usr/local/bin/jenkins.sh` as the `jenkins` user (supported by standard Docker best practices).
4. The entrypoint script (`entrypoint.sh`) must:
   - Identify the owner GID of `/var/run/docker.sock` using `stat -c '%g'`.
   - Update `etc/group` dynamically (using `groupmod`, `groupadd`, or `usermod`) depending on whether the GID or group `docker` already exists, ensuring no conflict.
   - Use `gosu jenkins /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"` to drop root privileges while retaining proper signal forwarding and zombie reaping capabilities.

---

## 3. Caveats
- Since this investigation was read-only and command execution timed out due to no permissions, the proposal has not been built and run on this host machine.
- We assumed the host machine runs Docker on Linux, exposing `/var/run/docker.sock` as a standard UNIX socket. Under Windows or macOS environments, Docker Desktop might manage permissions differently (often exposing `/var/run/docker.sock` as owned by `root:root` with read/write for all or mapping it automatically). The entrypoint script is designed to handle those cases safely (falling back or matching GID 0 / root).

---

## 4. Conclusion
We propose a complete design for the local Jenkins DooD setup. By implementing `entrypoint.sh` using `gosu` and adjusting `Dockerfile` and `docker-compose.yml` to run as root initially, the container will dynamically resolve host-dependent socket permissions without requiring host-side configuration changes.

---

## 5. Verification Method
1. **Implementation Files**: Inspect the proposed designs in `D:\Github\cic\.agents\explorer_m1_3\analysis.md`.
2. **Build and Start Test**:
   - Write the files to `prod-setup/jenkins/`.
   - Run `docker compose build` and `docker compose up -d` in `prod-setup/jenkins/`.
   - Verify that the container starts up successfully.
3. **Permission Verification**:
   - Run `docker exec -it jenkins-server ls -la /var/run/docker.sock` to check the socket's owner GID.
   - Run `docker exec -it jenkins-server id jenkins` to verify that the `jenkins` user belongs to a group with the same GID as the socket.
   - Run `docker exec -it jenkins-server gosu jenkins docker ps` to verify that the `jenkins` user can interact with the Docker daemon without permission denied errors.
