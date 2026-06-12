# Analysis: Milestone 1 - Local Jenkins DooD Setup

## Overview of the Problem
In a Docker-out-of-Docker (DooD) setup, the Jenkins container communicates with the host's Docker daemon by mounting the host's Docker Unix socket `/var/run/docker.sock`. 
By default, the host's Docker socket is owned by `root` and a host group (typically named `docker`). The Group ID (GID) of this group varies across different host operating systems and installations (commonly `998`, `999`, or others).

If the `jenkins` user inside the container does not belong to a group with the same GID as the host's Docker socket, the Jenkins pipeline will encounter a `Permission Denied` error when executing `docker` commands (such as `docker build`, `docker run`, etc.).

Hardcoding a GID inside the `Dockerfile` (e.g., `RUN groupadd -g 999 docker`) is brittle and non-portable because:
1. The host's Docker socket GID may not be `999`.
2. Building different images for different hosts violates the build-once-run-anywhere philosophy.

### Solution Strategy
The container should dynamically inspect the host's `/var/run/docker.sock` at startup:
1. Determine the GID of `/var/run/docker.sock`.
2. Check if a group with that GID already exists in the container.
3. If it exists, add the `jenkins` user to that group.
4. If it does not exist, check if a group named `docker` exists.
   - If `docker` group exists, modify its GID to match the socket's GID.
   - If not, create a new `docker` group with that GID.
   - Add the `jenkins` user to the `docker` group.
5. Drop privileges from `root` to `jenkins` using a secure tool like `gosu` to execute the original Jenkins entrypoint, preserving signal handling (PID 1).

---

## 1. Design of `prod-setup/jenkins/entrypoint.sh`

Below is the proposed implementation of `entrypoint.sh`. It is designed to be robust, handle non-root startup gracefully, and fall back safely if the Docker socket is missing.

```bash
#!/bin/bash
# Exit immediately if a command exits with a non-zero status
set -e

DOCKER_SOCKET="/var/run/docker.sock"
JENKINS_USER="jenkins"

# The script must run as root to perform administrative tasks (groupmod/groupadd/usermod)
if [ "$(id -u)" -eq 0 ]; then
    echo "Running as root. Checking Docker socket permissions..."

    if [ -S "$DOCKER_SOCKET" ]; then
        # Dynamically read the GID of the mounted /var/run/docker.sock
        DOCKER_GID=$(stat -c '%g' "$DOCKER_SOCKET")
        echo "Detected $DOCKER_SOCKET GID on host: $DOCKER_GID"

        # Check if a group with this GID already exists in the container
        EXISTING_GROUP_BY_GID=$(getent group "$DOCKER_GID" | cut -d: -f1 || true)

        if [ -n "$EXISTING_GROUP_BY_GID" ]; then
            echo "Group with GID $DOCKER_GID already exists inside container: $EXISTING_GROUP_BY_GID"
            # Add jenkins to this group to grant socket access
            echo "Adding '$JENKINS_USER' to group '$EXISTING_GROUP_BY_GID'..."
            usermod -aG "$EXISTING_GROUP_BY_GID" "$JENKINS_USER"
        else
            # No group with this GID exists. Check if group name 'docker' exists
            if getent group docker >/dev/null 2>&1; then
                echo "Group 'docker' exists but with a different GID. Modifying its GID to $DOCKER_GID..."
                groupmod -g "$DOCKER_GID" docker
            else
                echo "Creating 'docker' group with GID $DOCKER_GID..."
                groupadd -g "$DOCKER_GID" docker
            fi
            echo "Adding '$JENKINS_USER' to group 'docker'..."
            usermod -aG docker "$JENKINS_USER"
        fi
    else
        echo "Warning: $DOCKER_SOCKET not found or is not a socket file. Skipping GID alignment."
    fi

    # Switch to the jenkins user and run the original Jenkins entrypoint
    echo "Dropping privileges to '$JENKINS_USER'..."
    exec gosu "$JENKINS_USER" /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
else
    echo "Warning: Running as non-root user ($(id -un)). Skipping group modification."
    # If not running as root, we cannot modify groups. Fall back directly to jenkins.sh.
    exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
fi
```

### Why use `gosu` instead of `su` or `sudo`?
- **Signal Forwarding**: Standard tools like `su` or `sudo` do not forward signals (like `SIGTERM`) properly to the child process. When Docker tries to stop the container, `su` intercepts the signal and doesn't propagate it, leading to a dirty shutdown (the container will hang for 10 seconds before being forcibly killed by `SIGKILL`).
- **PID 1 Preservation**: `gosu` performs a `setuid`/`setgid` call and then uses `exec` to replace the current process. This ensures the Jenkins Java process correctly receives system signals (e.g. for graceful shutdown) and handles them as PID 1.
- **Tini Integration**: We chain `gosu` with `/usr/bin/tini` (the init process bundled in the Jenkins image) to handle zombie process reaping.

---

## 2. Design of `prod-setup/jenkins/Dockerfile`

The `Dockerfile` needs to:
1. Install `gosu` during the package setup phase.
2. Copy `entrypoint.sh` into the container image.
3. Make `entrypoint.sh` executable.
4. Set the container's `ENTRYPOINT` to `/entrypoint.sh`.

Here is the proposed `Dockerfile`:

```dockerfile
FROM jenkins/jenkins:lts
USER root

# Install dependencies, Docker CLI, and gosu
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common \
    gosu \
    && rm -rf /var/lib/apt/lists/*

# Add Docker's official GPG key
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the stable repository
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker CLI and Docker Compose CLI plugin
RUN apt-get update && apt-get install -y docker-ce-cli docker-compose-plugin && rm -rf /var/lib/apt/lists/*

# Create a default docker group with fallback GID 999
RUN groupadd -g 999 docker || true && usermod -aG docker jenkins

# Copy and configure the dynamic entrypoint wrapper script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Revert back to the jenkins user for default security context
# (It will be overridden to root in docker-compose.yml for GID setup,
# but keeping this ensures default-user compliance when running without compose).
USER jenkins

# Set entrypoint to our custom wrapper script
ENTRYPOINT ["/entrypoint.sh"]
```

---

## 3. Design of `prod-setup/jenkins/docker-compose.yml`

To allow `entrypoint.sh` to run as root initially (so it can read `/var/run/docker.sock` and execute user/group modification commands), we must specify `user: root` in the docker-compose file. We also mount the host's Docker socket `/var/run/docker.sock`.

Here is the proposed `docker-compose.yml` configuration:

```yaml
version: '3.8'

services:
  jenkins:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: jenkins-server
    # Run container as root initially to allow entrypoint.sh GID alignment
    user: root
    ports:
      - "127.0.0.1:8080:8080"
      - "127.0.0.1:50000:50000"
    deploy:
      resources:
        limits:
          cpus: '2.0'
          memory: 4096M
    volumes:
      - jenkins-data:/var/jenkins_home
      # Bind mount the host's Docker socket to communicate with the host daemon
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      - TZ=Asia/Bangkok
    restart: unless-stopped

volumes:
  jenkins-data:
    driver: local
```

---

## Security and Operational Trade-offs

| Aspect | Current (Hardcoded GID) | Proposed (Dynamic Entrypoint) |
|---|---|---|
| **Portability** | Low (fails on hosts where GID != 999) | High (runs on any host by dynamically resolving GID) |
| **Startup Privilege** | Runs as user `jenkins` (non-root) | Starts as `root`, performs group mapping, then drops to `jenkins` |
| **Privilege Escalation Risk** | Low | Low (privileges are dropped via `exec gosu` before Jenkins starts running, preventing Jenkins plugins/pipelines from executing as root) |
| **Container Signal Handling** | Standard | Standard (fully preserved via `exec gosu /usr/bin/tini`) |

### Conclusion
The proposed architecture provides maximum compatibility across developer environments (macOS, Linux hosts, etc.) while maintaining strict privilege separation. The container runs only the initialization logic as root, and then spawns the main Jenkins process as the non-privileged `jenkins` user.
