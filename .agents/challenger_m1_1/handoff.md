# Handoff Report — Milestone 1 Challenger Verification

## 1. Observation
- In `prod-setup/jenkins/entrypoint.sh` (lines 21-22), the script ends with:
  ```bash
  # Hand off to the standard Jenkins entrypoint
  exec /usr/bin/tini -- /usr/local/bin/jenkins.sh
  ```
  No `gosu` command or privilege-dropping switch is present.
- In `prod-setup/jenkins/Dockerfile` (line 34), it sets the default user:
  ```dockerfile
  USER jenkins
  ```
- In `prod-setup/jenkins/docker-compose.yml` (line 9), it overrides the default user:
  ```yaml
  user: root
  ```
- In `prod-setup/jenkins/entrypoint.sh` (lines 10-18), group alignment is run directly without conditional root checks:
  ```bash
      # Ensure a group with this GID exists
      if ! getent group "$DOCKER_GID" > /dev/null; then
          echo "[+] Creating group 'docker-host' with GID $DOCKER_GID"
          groupadd -g "$DOCKER_GID" docker-host
      fi

      # Add jenkins user to the group matching the socket GID
      DOCKER_GROUP=$(getent group "$DOCKER_GID" | cut -d: -f1)
      echo "[+] Adding jenkins user to group '$DOCKER_GROUP'"
      usermod -aG "$DOCKER_GROUP" jenkins
  ```
- During command execution attempt, running `python --version` and `docker --version` failed due to non-interactive environment timeout:
  ```
  Encountered error in step execution: Permission prompt for action 'command' on target 'python --version' timed out waiting for user response.
  ```

## 2. Logic Chain
- **Observation 1**: The container compose overrides the user to `root`.
- **Observation 2**: The entrypoint script executes `groupadd` and `usermod` directly.
- **Observation 3**: The entrypoint script passes execution to `jenkins.sh` directly as `root` without dropping privileges (no `gosu` used).
- **Logical Connection**: Therefore, when running under Docker Compose, the Jenkins JVM process runs entirely as root inside the container.
- **Observation 4**: In a DooD setup, `/var/run/docker.sock` is mounted inside the container.
- **Logical Connection**: Running the container process as root with docker socket access allows any shell command execution or compromised plugin in Jenkins to gain full root access to the host machine.
- **Observation 5**: If the user runs the container as a non-root user (e.g. standard `docker run`), the `groupadd` and `usermod` commands will crash due to permission denied (Observation 2).
- **Logical Connection**: Therefore, the container crashes on boot when run in secure non-root environments.
- **Conclusion**: The setup is insecure (runs as root, vulnerable to breakout) and non-portable (crashes when run as non-root).

## 3. Caveats
- Since the execution environment timed out on tool approval for Python and Docker commands, we were unable to run a live container to dynamically query the active process user list (e.g. via `ps aux`).
- Verification is done through thorough static code analysis of the entrypoint script, dockerfile, and docker-compose configurations.

## 4. Conclusion
Milestone 1's Jenkins setup has severe security issues (runs as root, missing privilege-dropping wrapper) and robustness bugs (crashes when executed as non-root, vulnerable to group name collisions). Immediate remediation is required to implement the `gosu` privilege-dropping wrapper and add root checking logic.

## 5. Verification Method
1. Inspect the content of `prod-setup/jenkins/entrypoint.sh` to confirm if `gosu` is used to hand off execution.
2. In a machine with Docker running, build the image and run it using compose:
   ```bash
   docker build -t jenkins-dood prod-setup/jenkins/
   docker-compose -f prod-setup/jenkins/docker-compose.yml up -d
   ```
3. Verify that the Jenkins process inside the container is running as root:
   ```bash
   docker exec -it jenkins-server id
   ```
   (If it returns `uid=0(root)`, the privilege drop failed).
