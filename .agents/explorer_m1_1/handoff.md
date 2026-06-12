# Handoff Report: Milestone 1 (Local Jenkins DooD Setup)

This report details the findings and proposals for Milestone 1, focusing on dynamically aligning the Jenkins container's group ownership with the host's `/var/run/docker.sock` to enable Docker-out-of-Docker (DooD) commands.

## 1. Observation
We observed the following configurations in the repository files:
- **`D:\Github\cic\.agents\orchestrator\plan.md`**:
  - Line 9: `M1 | Local Jenkins DooD Setup | Implement entrypoint.sh, modify Dockerfile and docker-compose.yml to dynamically resolve socket permissions issues.`
  - Line 15: `- **Local Jenkins entrypoint**: entrypoint.sh must read /var/run/docker.sock GID, ensure docker group exists with that GID, add jenkins to it, and exec the Jenkins entrypoint as jenkins.`
- **`D:\Github\cic\prod-setup\jenkins\Dockerfile`**:
  - Line 27: `RUN groupadd -g 999 docker || true && usermod -aG docker jenkins`
  - Line 30: `USER jenkins`
- **`D:\Github\cic\prod-setup\jenkins\docker-compose.yml`**:
  - Lines 18-20:
    ```yaml
    volumes:
      - jenkins-data:/var/jenkins_home
      # Bind mount the host's Docker socket to communicate with the host daemon
      - /var/run/docker.sock:/var/run/docker.sock
    ```
  - The `docker-compose.yml` does not currently define `user: root`, meaning the container starts under the default user defined in the Dockerfile (`jenkins`).

## 2. Logic Chain
- **Step 1**: The mounted host socket `/var/run/docker.sock` is owned by root and a docker group on the host. The GID of this host group varies across environments (e.g. `998`, `999`, or others).
- **Step 2**: The current `Dockerfile` creates a docker group with a hardcoded GID `999`. If the host's socket GID differs (e.g., `998` on some hosts), the container's `jenkins` user will lack access permissions to the socket, causing `Permission Denied` errors for any pipeline executing docker commands.
- **Step 3**: To handle this dynamically at runtime, we must use a custom entrypoint wrapper (`entrypoint.sh`). This script reads the GID of `/var/run/docker.sock` dynamically using `stat -c '%g' /var/run/docker.sock`.
- **Step 4**: Because changing group IDs (`groupmod`), creating groups (`groupadd`), and adding users to groups (`usermod`) require administrative privileges, the container must start up as `root` (configured via `user: root` in `docker-compose.yml`).
- **Step 5**: To ensure container security, the entrypoint must drop privileges to the `jenkins` user before running the Jenkins daemon. Standard `su` or `sudo` fail to forward process signals (like `SIGTERM` on container stop) correctly, leading to zombie processes and ungraceful shutdowns. Therefore, `gosu` is required to securely switch users while replacing the PID 1 process (`exec`).
- **Step 6**: Combining `gosu` and the pre-installed `tini` inside the entrypoint ensures that signals are propagated correctly and privileges are safely dropped to `jenkins`.

## 3. Caveats
- **Live Verification**: A live container startup test could not be run as terminal command execution timed out awaiting user confirmation. The design is based on standard Docker/Linux practices and official Jenkins LTS image characteristics.
- **Tini Path**: The official Jenkins LTS image includes `tini` at `/usr/bin/tini` (or in path). The script assumes it is available there. If not, it can be resolved by using the system path `tini`.
- **Gosu Package**: We assume `gosu` is available in the standard debian apt repository. (Debian 12 Bookworm, which is the base of the current `jenkins/jenkins:lts`, includes `gosu` in main).

## 4. Conclusion
We propose a complete design consisting of:
1. `entrypoint.sh`: Reads GID, creates/updates the docker group inside the container, adds `jenkins` to it, and drops privileges to `jenkins` via `exec gosu jenkins /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"`.
2. `Dockerfile`: Installs `gosu`, copies the `entrypoint.sh` wrapper, and sets the `ENTRYPOINT` to it.
3. `docker-compose.yml`: Configures the service to run as `user: root` so the entrypoint has the permissions needed to perform group alignment.

The full design is documented in `D:\Github\cic\.agents\explorer_m1_1\analysis.md`.

## 5. Verification Method
To verify this setup:
1. Build and run the service:
   ```bash
   docker-compose -f prod-setup/jenkins/docker-compose.yml up --build -d
   ```
2. Inspect container logs to verify that GID detection and privilege dropping occur:
   ```bash
   docker logs jenkins-server
   ```
   *Expected output snippet:*
   ```
   Detected /var/run/docker.sock GID on host: <GID>
   Dropping privileges to 'jenkins'...
   ```
3. Exec into the running container to verify the user and group:
   ```bash
   docker exec -it jenkins-server whoami
   # Expected: jenkins
   docker exec -it jenkins-server groups
   # Expected: list containing jenkins and the group owning the host docker socket
   docker exec -it jenkins-server docker ps
   # Expected: successful listing of running containers without permission errors
   ```
