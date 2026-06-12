# Handoff Report - Milestone 1 (Local Jenkins DooD Setup)

## 1. Observation
- **Original docker-compose.yml contents** (lines 4-10 in `prod-setup/jenkins/docker-compose.yml` before changes):
  ```yaml
    jenkins:
      build:
        context: .
        dockerfile: Dockerfile
      container_name: jenkins-server
      ports:
  ```
- **Modified docker-compose.yml contents** (lines 4-11 in `prod-setup/jenkins/docker-compose.yml` after changes):
  ```yaml
    jenkins:
      build:
        context: .
        dockerfile: Dockerfile
      container_name: jenkins-server
      user: root
      ports:
  ```
- **Created `prod-setup/jenkins/entrypoint.sh`** with dynamic Docker GID mapping and `gosu` wrapper:
  ```bash
  #!/bin/bash
  set -e
  ...
  if [ "$(id -u)" -eq 0 ]; then
      ...
      exec gosu "$JENKINS_USER" /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
  ...
  ```
- **Overwrote `prod-setup/jenkins/Dockerfile`** containing the dependencies `gosu`, Docker GPG key, Docker CLI / Compose plugin, group GID setup, and setting the `ENTRYPOINT` to `/entrypoint.sh`.
- **Command execution**:
  - Tried running `python -c` to normalize line endings and `docker build -t jenkins-dood-test prod-setup/jenkins` to verify the build, but both commands timed out waiting for user permission (interactive approval).
    ```
    Encountered error in step execution: Permission prompt for action 'command' on target 'docker build -t jenkins-dood-test prod-setup/jenkins' timed out waiting for user response.
    ```

## 2. Logic Chain
- **Requirement 1**: Dynamic GID alignment for the host's `/var/run/docker.sock` in the Jenkins container.
  - *Step*: Created `entrypoint.sh` that checks if running as root, reads GID of `/var/run/docker.sock`, aligns group membership, and runs `gosu` to drop privileges to `jenkins`.
- **Requirement 2**: Provide `gosu`, copy the entrypoint wrapper, set permissions, and configure ENTRYPOINT.
  - *Step*: Overwrote `Dockerfile` installing `gosu` and the required docker cli tools, copying the entrypoint, and configuring `ENTRYPOINT ["/entrypoint.sh"]`.
- **Requirement 3**: Set `user: root` in docker-compose.yml.
  - *Step*: Added `user: root` right below `container_name: jenkins-server` in `prod-setup/jenkins/docker-compose.yml`. This ensures the entrypoint starts as root, allowing it to modify groups and permissions, before dropping privileges to the `jenkins` user.

## 3. Caveats
- Since the environment is non-interactive, the command execution for local build (`docker build`) timed out waiting for user permission. Verification was done via code review/inspection.
- No `graphify update` command could be run due to the same permission timeout constraint.

## 4. Conclusion
- The local Jenkins Docker-outside-of-Docker (DooD) setup is successfully configured to run as root on startup, dynamically align GID of `/var/run/docker.sock`, and drop privileges to the `jenkins` user using `gosu`.

## 5. Verification Method
1. Run the build command to verify the docker image build passes:
   ```bash
   docker build -t jenkins-dood-test prod-setup/jenkins
   ```
2. Verify docker-compose.yml config by checking files:
   - Check `prod-setup/jenkins/docker-compose.yml` to ensure `user: root` is present.
   - Check `prod-setup/jenkins/entrypoint.sh` contains the bash script with LF line endings.
   - Check `prod-setup/jenkins/Dockerfile` contains the custom ENTRYPOINT configuration.
