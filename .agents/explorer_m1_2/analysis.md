# Analysis and Design Proposal: Local Jenkins DooD Setup (Milestone 1)

This document provides the dynamic Docker-out-of-Docker (DooD) permissions resolution design.

## 1. Overview of the Problem
In a Docker-outside-of-Docker (DooD) setup, the Jenkins container runs the Docker CLI and mounts `/var/run/docker.sock` from the host. This enables Jenkins to build and run Docker containers directly on the host's Docker daemon.
However, `/var/run/docker.sock` is owned by the host's `root` user and a specific `docker` group (e.g., GID 999, 998, 1001, etc.). The GID varies depending on the host operating system and Docker installation.
If the Jenkins user inside the container does not belong to a group with the matching GID, it will encounter a permission denied error when attempting to access the socket:
```
got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock
```

To resolve this issue dynamically without rebuilding the image for every target host, we implement a wrapper entrypoint script that:
1. Runs initially as root.
2. Identifies the GID of `/var/run/docker.sock`.
3. Ensures a group exists with that GID (reusing/adjusting groups if needed).
4. Adds the `jenkins` user to that group.
5. Re-executes the original Jenkins entrypoint as the `jenkins` user using `gosu`.

---

## 2. Component Design

### A. Dynamic Entrypoint Script (`prod-setup/jenkins/entrypoint.sh`)
This script acts as the bootstrap wrapper. It is run as `root`, configures the groups, and then uses `gosu` to drop privileges to the `jenkins` user before executing the original Jenkins entrypoint.

#### Proposed Content:
```bash
#!/bin/bash
# entrypoint.sh - Dynamic Docker GID mapping wrapper for Jenkins DooD

set -e

# If running as root, adjust docker group to match host's docker socket GID
if [ "$(id -u)" = "0" ]; then
    if [ -S /var/run/docker.sock ]; then
        # Dynamically read the GID of the mounted docker.sock
        DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)
        echo "Docker socket found. GID is $DOCKER_GID"

        # Check if a group with this GID already exists in /etc/group
        EXISTING_GROUP=$(getent group "$DOCKER_GID" | cut -d: -f1)

        if [ -n "$EXISTING_GROUP" ]; then
            echo "Group '$EXISTING_GROUP' already exists with GID $DOCKER_GID. Adding jenkins user to it."
            usermod -aG "$EXISTING_GROUP" jenkins
        else
            echo "No group found with GID $DOCKER_GID."
            # Check if group name 'docker' already exists
            if getent group docker >/dev/null 2>&1; then
                echo "Group 'docker' already exists. Changing its GID to $DOCKER_GID."
                groupmod -g "$DOCKER_GID" docker
            else
                echo "Creating group 'docker' with GID $DOCKER_GID."
                groupadd -g "$DOCKER_GID" docker
            fi
            usermod -aG docker jenkins
        fi
    else
        echo "Docker socket not found at /var/run/docker.sock. Skipping docker group configuration."
    fi

    # Switch to the jenkins user and execute the original Jenkins entrypoint
    echo "Switching to user 'jenkins' and executing main Jenkins entrypoint..."
    exec gosu jenkins /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
else
    # If not running as root, just execute the original entrypoint directly
    echo "Not running as root. Executing main entrypoint directly..."
    exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
fi
```

### B. Modified Dockerfile (`prod-setup/jenkins/Dockerfile`)
The Dockerfile installs `gosu`, copies the `entrypoint.sh` wrapper, and sets it as the container's entrypoint.

#### Proposed Content:
```dockerfile
FROM jenkins/jenkins:lts
USER root

# Install dependencies for Docker CLI installation
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common

# Add Docker's official GPG key
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the stable repository
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker CLI, Docker Compose CLI plugin, and gosu (for privileges dropping)
RUN apt-get update && apt-get install -y \
    docker-ce-cli \
    docker-compose-plugin \
    gosu \
    && rm -rf /var/lib/apt/lists/*

# Create docker group with host-compatible GID as default fallback
RUN groupadd -g 999 docker || true && usermod -aG docker jenkins

# Copy and configure the entrypoint wrapper script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set entrypoint to wrapper
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Keep USER jenkins for image metadata defaults (docker-compose will override with user: root)
USER jenkins
```

### C. Modified Docker Compose (`prod-setup/jenkins/docker-compose.yml`)
The docker-compose configuration forces the container to run as `root` (initially) and mounts the host's Docker socket.

#### Proposed Content:
```yaml
version: '3.8'

services:
  jenkins:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: jenkins-server
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

## 3. Rationale and Key Decisions
1. **Choosing `gosu` over `sudo`/`su`:** `gosu` is a simple Go-based privilege-dropping tool that avoids the TTY and signal forwarding caveats of `su` and `sudo`. This ensures that Jenkins receives signals (like SIGTERM) properly for graceful shutdowns.
2. **Flexible Group Mapping:** Rather than blindly creating the `docker` group, the script checks if a group with the socket's GID already exists. This prevents collisions if the GID is already assigned to a different group in the image (such as `systemd-journal`, `input`, etc.), and adds the `jenkins` user to whichever group owns the socket.
3. **Double Fallback:**
   - If `/var/run/docker.sock` does not exist or is not a socket, the script skips group configuration and proceeds smoothly.
   - If the container is not run as root (no `user: root` specified), it bypasses the modifications and directly starts the Jenkins server, maintaining the image's ability to run in standard non-root restricted environments.
