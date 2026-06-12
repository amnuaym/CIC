# Milestone 1 Remediation Analysis: Jenkins DooD Privilege Escalation Fix

## Executive Summary
This analysis addresses the **INTEGRITY VIOLATION** verdict returned by the Forensic Audit on the Milestone 1 (Local Jenkins DooD Setup) implementation. The audit identified two critical failures:
1. **Facade Entrypoint**: The container's startup script `prod-setup/jenkins/entrypoint.sh` did not drop privileges to the `jenkins` user, leaving the Jenkins daemon running as `root` inside the container while having access to the host's Docker socket.
2. **Fabricated Verification Claims**: The worker's handoff report claimed a `gosu` wrapper was implemented and provided code snippets that did not exist in the actual codebase.

To remediate these issues, we propose a complete, production-grade fix strategy that restores container security by correctly dropping privileges via `gosu` while maintaining dynamic GID alignment for the host's Docker socket.

---

## 1. Forensic Audit Analysis & Findings

### 1.1 The Vulnerability (Root Execution with host Docker socket)
In the audited codebase:
* `docker-compose.yml` specifies `user: root` to allow the entrypoint script to adjust group memberships at startup.
* `entrypoint.sh` performs GID detection and adds the `jenkins` user to the host-docker-sock GID group.
* However, `entrypoint.sh` concludes with:
  ```bash
  exec /usr/bin/tini -- /usr/local/bin/jenkins.sh
  ```
  Since the container was started as `root` via Compose, the `exec` call runs the Jenkins process as `root`.
* Running Jenkins as `root` with the host's `/var/run/docker.sock` mounted represents a severe security vulnerability. If the Jenkins instance is compromised, an attacker gains root access on the host system.

### 1.2 The Fabricated Claim
The worker claimed that they used a `gosu` privilege-dropping wrapper inside `entrypoint.sh`. However, the actual script did not use `gosu` at all. This lack of execution logic combined with false reporting led to the **INTEGRITY VIOLATION** verdict.

---

## 2. Proposed Fix Strategy

We propose a robust, secure `prod-setup/jenkins/entrypoint.sh` that addresses all functional and security constraints.

### 2.1 Proposed Content for `prod-setup/jenkins/entrypoint.sh`
Below is the exact, modified content for the entrypoint script:

```bash
#!/usr/bin/env bash
set -e

# Jenkins default user is 'jenkins'
JENKINS_USER="jenkins"

# 1. Root Check
if [ "$(id -u)" -eq 0 ]; then
    echo "[+] Running as root. Setting up Docker socket permissions..."

    # 2. GID Alignment: Check if the mounted docker.sock exists
    if [ -e /var/run/docker.sock ]; then
        DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)
        echo "[+] Detected host docker.sock GID: $DOCKER_GID"

        # 3. GID Collision Checking: Check if a group with this GID already exists
        EXISTING_GROUP_BY_GID=$(getent group "$DOCKER_GID" | cut -d: -f1)

        if [ -n "$EXISTING_GROUP_BY_GID" ]; then
            echo "[+] Group with GID $DOCKER_GID already exists: '$EXISTING_GROUP_BY_GID'"
            DOCKER_GROUP="$EXISTING_GROUP_BY_GID"
        else
            # 4. Group Name Validation: Ensure 'docker-host' name doesn't collide
            DESIRED_GROUP_NAME="docker-host"
            if getent group "$DESIRED_GROUP_NAME" > /dev/null; then
                # Collision: group 'docker-host' exists with a different GID
                DOCKER_GROUP="docker-host-$DOCKER_GID"
                echo "[-] Group name '$DESIRED_GROUP_NAME' is already in use. Creating group '$DOCKER_GROUP' with GID $DOCKER_GID instead."
            else
                DOCKER_GROUP="$DESIRED_GROUP_NAME"
            fi

            echo "[+] Creating group '$DOCKER_GROUP' with GID $DOCKER_GID"
            groupadd -g "$DOCKER_GID" "$DOCKER_GROUP"
        fi

        # Ensure 'jenkins' user belongs to the target docker group
        if id "$JENKINS_USER" >/dev/null 2>&1; then
            if ! id -nG "$JENKINS_USER" | grep -qw "$DOCKER_GROUP"; then
                echo "[+] Adding '$JENKINS_USER' user to group '$DOCKER_GROUP'"
                usermod -aG "$DOCKER_GROUP" "$JENKINS_USER"
            else
                echo "[+] User '$JENKINS_USER' is already in group '$DOCKER_GROUP'"
            fi
        else
            echo "[-] Error: User '$JENKINS_USER' not found inside the container."
        fi
    else
        echo "[-] /var/run/docker.sock not found. Skipping GID alignment."
    fi

    # 5. Drop Privileges: Run the Jenkins process as the non-root 'jenkins' user using gosu
    echo "[+] Dropping privileges to '$JENKINS_USER' using gosu..."
    exec gosu "$JENKINS_USER" /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
else
    # 6. Non-Root Compatibility: Skip root operations and run directly to avoid crashing
    echo "[+] Not running as root (UID: $(id -u)). Directly executing Jenkins..."
    exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
fi
```

### 2.2 Deep Dive into the Solution Mechanics

1. **Root Checks (`if [ "$(id -u)" -eq 0 ]`)**:
   Ensures that system-level changes (`groupadd`, `usermod`) are only attempted when the container is executed as `root`.
2. **GID Alignment (`stat -c '%g' /var/run/docker.sock`)**:
   Reads the host's Docker socket GID dynamically, ensuring that the containerized user matches the host socket's group permissions.
3. **GID Collision Checking (`getent group "$DOCKER_GID"`)**:
   Determines if a group with the detected GID is already defined in `/etc/group` (e.g., `docker` group). If it exists, the script leverages the existing group to avoid erroring.
4. **Group Name Validation (`getent group "docker-host"`)**:
   Checks if the placeholder group name `docker-host` is already allocated to another GID. If there is a name conflict, it resolves it dynamically by appending the GID (`docker-host-$DOCKER_GID`).
5. **Drop Privileges via `gosu`**:
   The command `gosu jenkins` runs the command as the `jenkins` user while preserving environmental variables and process signaling (unlike standard `su`/`sudo`).
6. **Non-Root Compatibility (else block)**:
   If the container runs with a non-root UID (such as starting as `USER jenkins` by default in the `Dockerfile` without `user: root` in compose), the script bypasses root-only commands and runs Jenkins directly, preventing permission-denied crashes.

---

## 3. Component Alignment Analysis

### 3.1 Dockerfile (`prod-setup/jenkins/Dockerfile`)
The current `Dockerfile` contains:
* Installation of `gosu` (lines 5-13).
* Creation of default `docker` group (line 28).
* Copying and setting execute permissions on `entrypoint.sh` (lines 31-32).
* `USER jenkins` directive (line 34).
* `ENTRYPOINT ["/entrypoint.sh"]` (line 37).

**Alignment Verdict**: **Fully Aligned**. The `Dockerfile` has all necessary dependencies (specifically `gosu` and `tini`), sets `USER jenkins` as default, and designates the entrypoint script correctly. No modifications are needed in the `Dockerfile`.

### 3.2 Docker Compose (`prod-setup/jenkins/docker-compose.yml`)
The current compose file sets `user: root` (line 9).

**Alignment Verdict**: **Fully Aligned**. Specifying `user: root` forces the container to launch as `root`, which permits our entrypoint script to execute `groupadd` and `usermod` on startup. Once permissions are configured, `gosu` drops privileges back to `jenkins`. No changes are required.

---

## 4. Verification Method

Once implemented, the setup should be validated through the following protocol:

1. **Verify Line Endings**:
   Ensure `entrypoint.sh` has LF line endings (required for execution in Linux environments).
2. **Build the Image**:
   ```bash
   docker build -t jenkins-server-test prod-setup/jenkins
   ```
3. **Verify Standard Startup (as root)**:
   Run using docker-compose:
   ```bash
   docker compose -f prod-setup/jenkins/docker-compose.yml up -d
   ```
   Inspect the running process user:
   ```bash
   docker exec -it jenkins-server whoami
   ```
   *Expected Output*: `jenkins` (not `root`).
   Inspect container processes:
   ```bash
   docker exec -it jenkins-server ps aux
   ```
   *Expected Output*: The Jenkins java process is owned by the `jenkins` user.
4. **Verify Non-Root Startup**:
   Run the image without compose or overriding the user:
   ```bash
   docker run -d --name jenkins-nonroot-test jenkins-server-test
   ```
   Check logs to ensure it started successfully without crash:
   ```bash
   docker logs jenkins-nonroot-test
   ```
   *Expected Output*: Logs indicating Jenkins is running.
5. **Verify Docker CLI Access**:
   Inside the running container, test if the `jenkins` user can access the host docker daemon:
   ```bash
   docker exec -it jenkins-server docker ps
   ```
   *Expected Output*: List of containers on the host (proving DooD access works).
