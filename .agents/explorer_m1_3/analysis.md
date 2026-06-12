# Milestone 1: Local Jenkins DooD Setup Analysis and Design Proposal

## Summary
The goal of Milestone 1 is to resolve permission issues when mounting the host's Docker socket (`/var/run/docker.sock`) inside the container for a Docker-outside-of-Docker (DooD) setup. Currently, the GID of the `docker` group inside the container is hardcoded to 999. In production or local environments, the GID of `/var/run/docker.sock` on the host may vary (e.g., 998, 999, 1001, etc.). If the GIDs do not match, the `jenkins` user inside the container will not have write access to the socket, preventing it from running Docker commands.

This document proposes a dynamic permissions solution using an `entrypoint.sh` wrapper, an updated `Dockerfile`, and a revised `docker-compose.yml` configuration.

---

## 1. Analysis of Current Configuration

### A. `prod-setup/jenkins/Dockerfile`
* **Current state**:
  - Inherits from `jenkins/jenkins:lts`.
  - Installs Docker CLI tools.
  - Hardcodes the `docker` group creation: `RUN groupadd -g 999 docker || true && usermod -aG docker jenkins`.
  - Switches back to `USER jenkins` at the end of the Dockerfile.
* **Limitations**:
  - Hardcoding GID 999 makes the build fragile and host-dependent.
  - Ending the Dockerfile with `USER jenkins` means the container starts as the non-root `jenkins` user. A non-root user cannot modify `/etc/group` or use `groupmod`/`groupadd` at runtime.

### B. `prod-setup/jenkins/docker-compose.yml`
* **Current state**:
  - Builds the container from the local Dockerfile.
  - Binds `/var/run/docker.sock` to the container's `/var/run/docker.sock`.
* **Limitations**:
  - It does not specify `user: root`. While the Dockerfile currently sets `USER jenkins`, we will need the container to start as `root` so the entrypoint wrapper can modify permissions before dropping privileges.

---

## 2. Proposed Designs

### A. `prod-setup/jenkins/entrypoint.sh`
The entrypoint wrapper runs as `root` at startup, inspects the Docker socket, configures the group permissions, and executes the main Jenkins application as the `jenkins` user.

#### Implementation Code
```bash
#!/bin/bash
# entrypoint.sh - Jenkins Docker-outside-of-Docker permission wrapper
set -e

# Path to the Docker socket inside the container
DOCKER_SOCKET="/var/run/docker.sock"

if [ -S "$DOCKER_SOCKET" ]; then
    # Get the GID of the Docker socket
    DOCKER_GID=$(stat -c '%g' "$DOCKER_SOCKET")
    echo "Found Docker socket with GID: $DOCKER_GID"

    # Check if a group with this GID already exists in the container
    EXISTING_GROUP=$(getent group "$DOCKER_GID" | cut -d: -f1)

    if [ -n "$EXISTING_GROUP" ]; then
        echo "Group '$EXISTING_GROUP' already exists with GID $DOCKER_GID. Adding 'jenkins' user to it."
        usermod -aG "$EXISTING_GROUP" jenkins
    else
        # No group exists with this GID. Check if the 'docker' group exists
        if getent group docker >/dev/null 2>&1; then
            echo "Modifying existing 'docker' group GID to $DOCKER_GID"
            groupmod -g "$DOCKER_GID" docker
        else
            echo "Creating 'docker' group with GID $DOCKER_GID"
            groupadd -g "$DOCKER_GID" docker
        fi
        echo "Adding 'jenkins' user to 'docker' group."
        usermod -aG docker jenkins
    fi
else
    echo "Docker socket not found at $DOCKER_SOCKET. Skipping GID alignment."
fi

# Execute the main Jenkins entrypoint as the 'jenkins' user.
# Using gosu allows the process to replace entrypoint.sh (PID 1) cleanly,
# forwarding signals correctly to tini.
echo "Starting Jenkins..."
exec gosu jenkins /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
```

#### Key Logic Features:
1. **Dynamic GID Detection**: Uses `stat -c '%g'` to retrieve the owner GID of `/var/run/docker.sock` at runtime.
2. **GID Collision Handling**:
   - If the socket's GID already matches an existing group (e.g., `root`, `staff`, or `jenkins`), the script adds the `jenkins` user to that group.
   - If the GID is not in use, the script checks if a `docker` group exists and updates its GID using `groupmod`. If it does not exist, it creates it.
3. **gosu execution**: Using `gosu` is superior to `su` or `sudo` because:
   - It performs `setuid`/`setgid` to the target user and directly executes (`execvp`) the command, allowing the application to run as PID 1 (or child of tini) and inherit signals directly without keeping a root helper process running.
   - It correctly initializes supplementary groups (via `initgroups`), ensuring that the dynamically configured `docker` group membership is active for the JVM process.

---

### B. `prod-setup/jenkins/Dockerfile`
We modify the Dockerfile to:
1. Install `gosu` from the standard Debian repositories.
2. Copy `entrypoint.sh` to the root directory and make it executable.
3. Ensure the container starts as `USER root` to allow the entrypoint script to execute system commands (`groupmod`, `usermod`, etc.).

#### Implementation Code
```dockerfile
FROM jenkins/jenkins:lts
USER root

# Install dependencies for Docker CLI installation and gosu
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common \
    gosu && \
    rm -rf /var/lib/apt/lists/*

# Add Docker's official GPG key
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the stable repository
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker CLI and Docker Compose CLI plugin
RUN apt-get update && apt-get install -y docker-ce-cli docker-compose-plugin && \
    rm -rf /var/lib/apt/lists/*

# Create a default docker group and add the jenkins user to it
# (This GID will be dynamically adjusted at startup by entrypoint.sh)
RUN groupadd -g 999 docker || true && usermod -aG docker jenkins

# Copy and configure the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Run as root to allow entrypoint.sh to adjust group permissions dynamically
USER root

ENTRYPOINT ["/entrypoint.sh"]
```

---

### C. `prod-setup/jenkins/docker-compose.yml`
We must mount the host's `/var/run/docker.sock` and ensure the container executes as `root` to enable permission setup.

#### Proposed Docker Compose File
```yaml
version: '3.8'

services:
  jenkins:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: jenkins-server
    user: root # Run container as root to allow entrypoint.sh to execute group operations
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

## 3. Benefits of the Proposed Design
* **Zero Host-side Configuration**: No need to manually chmod `/var/run/docker.sock` to `777` on the host, which is a major security risk.
* **Portable & Robust**: Works on any Linux host regardless of its specific `docker` group GID.
* **Correct Signal Handling**: Using `gosu` ensures that standard termination signals (like `SIGTERM`) are forwarded directly to Jenkins, allowing clean shutdowns.
* **Failsafe Fallback**: If the socket is missing or unmounted, the script gracefully logs the status and proceeds to start Jenkins normally.
