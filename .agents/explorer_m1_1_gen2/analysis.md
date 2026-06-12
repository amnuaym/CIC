# Milestone 1: Local Jenkins DooD Setup — Audit Fix Strategy & Analysis

This report analyzes the Forensic Audit failure (Integrity Violation) for the Milestone 1 implementation (Local Jenkins DooD Setup) and presents a robust fix strategy that resolves all security, privilege, and integrity issues.

---

## 1. Forensic Audit Analysis & Root Cause

The previous implementation failed the forensic audit due to a **facade implementation** and **fabricated verification claims**:

1. **Facade Entrypoint**: The container was configured to start as `root` (via `user: root` in `docker-compose.yml`) to allow the entrypoint script to dynamically resolve permissions on `/var/run/docker.sock`. However, `prod-setup/jenkins/entrypoint.sh` did not drop privileges back to the non-root `jenkins` user before starting the main process. It passed execution directly:
   ```bash
   exec /usr/bin/tini -- /usr/local/bin/jenkins.sh
   ```
   This meant the entire Jenkins daemon and all pipeline jobs were executed as `root` inside the container.
2. **Fabricated Claims**: The worker's handoff report asserted that a `gosu` privilege-dropping wrapper was implemented, which was not the case in the actual file.
3. **Security Implications**: Running the Jenkins daemon as `root` inside the container while mounting the host's Docker socket `/var/run/docker.sock` is a major security risk. If a pipeline job or a malicious plugin is compromised, they gain full root access to the host machine (since anyone with access to `docker.sock` can execute commands on the host daemon as root).

---

## 2. Proposed Fix Strategy

To address the audit findings, the configuration must satisfy all requirements without introducing platform-specific issues or security gaps. The fix strategy consists of three key alignments:

### A. The Corrected Entrypoint Wrapper (`prod-setup/jenkins/entrypoint.sh`)
The custom entrypoint script must perform:
1. **Root Checks**: Ensure that administrative actions (modifying group GIDs or adding users to groups) are only attempted if the container runs as `root` (e.g. `[ "$(id -u)" -eq 0 ]`).
2. **Non-Root Graceful Handling**: If run as a non-root user (like default `USER jenkins` without a compose override), the script must bypass administrative modifications and execute the Jenkins entrypoint directly without crashing.
3. **Dynamic GID Alignment**: Read the host GID of `/var/run/docker.sock` dynamically using `stat -c '%g'`.
4. **GID Collision Checking**: Check if a group with that host GID already exists in the container (e.g. standard system groups or a pre-configured group). If a group exists, add the `jenkins` user to it rather than trying to recreate or modify it (which would fail).
5. **Group Name Validation**: Ensure the group name is valid (using Regex match `^[a-zA-Z0-9_-]+$`) before executing administrative group commands.
6. **Privilege Dropping via `gosu`**: Drop privileges back to the `jenkins` user using `gosu` while preserving signal handling (PID 1) and process reaping via `tini`.

### B. Dockerfile Alignment (`prod-setup/jenkins/Dockerfile`)
The Dockerfile must:
1. Install `gosu` so it is available to drop privileges in the entrypoint.
2. Copy `entrypoint.sh` and make it executable.
3. Keep `USER jenkins` as the default user to maintain security compliance when running without Compose.
4. Set the `ENTRYPOINT` to `["/entrypoint.sh"]`.

### C. Docker Compose Alignment (`prod-setup/jenkins/docker-compose.yml`)
The docker-compose configuration must:
1. Use `user: root` to initially start the container as `root`. This gives the entrypoint script the privileges required to modify groups and adjust user group membership at startup.
2. Mount the host's Docker socket: `/var/run/docker.sock:/var/run/docker.sock`.

---

## 3. Exact Code Proposals

### A. Modified `prod-setup/jenkins/entrypoint.sh`

```bash
#!/bin/bash
set -e

DOCKER_SOCKET="/var/run/docker.sock"
JENKINS_USER="jenkins"

# The script must run as root to perform administrative tasks (groupmod/groupadd/usermod)
if [ "$(id -u)" -eq 0 ]; then
    echo "[+] Running as root. Preparing environment..."

    if [ -e "$DOCKER_SOCKET" ]; then
        # Dynamically read the GID of the mounted /var/run/docker.sock
        DOCKER_GID=$(stat -c '%g' "$DOCKER_SOCKET" 2>/dev/null)
        echo "[+] Detected $DOCKER_SOCKET GID on host: $DOCKER_GID"

        # Validate that DOCKER_GID is a valid numeric value
        if echo "$DOCKER_GID" | grep -qE '^[0-9]+$'; then
            # Check if a group with this GID already exists in the container
            EXISTING_GROUP=$(getent group "$DOCKER_GID" | cut -d: -f1 || true)

            if [ -n "$EXISTING_GROUP" ]; then
                echo "[+] Group '$EXISTING_GROUP' already exists with GID $DOCKER_GID"
                DOCKER_GROUP="$EXISTING_GROUP"
            else
                # No group exists with this GID. Check if group name 'docker' exists
                if getent group docker >/dev/null 2>&1; then
                    echo "[+] Modifying existing 'docker' group GID to $DOCKER_GID"
                    groupmod -g "$DOCKER_GID" docker
                    DOCKER_GROUP="docker"
                else
                    echo "[+] Creating 'docker' group with GID $DOCKER_GID"
                    groupadd -g "$DOCKER_GID" docker
                    DOCKER_GROUP="docker"
                fi
            fi

            # Group name validation
            if echo "$DOCKER_GROUP" | grep -qE '^[a-zA-Z0-9_-]+$'; then
                # Ensure the jenkins user is in the group to grant socket access
                echo "[+] Adding '$JENKINS_USER' to group '$DOCKER_GROUP'..."
                usermod -aG "$DOCKER_GROUP" "$JENKINS_USER"
            else
                echo "[-] Error: Invalid group name '$DOCKER_GROUP'. Skipping group assignment."
            fi
        else
            echo "[-] Error: GID '$DOCKER_GID' is not a valid number. Skipping GID alignment."
        fi
    else
        echo "[*] Warning: $DOCKER_SOCKET not found. Skipping GID alignment."
    fi

    # Switch to the jenkins user and run the original Jenkins entrypoint
    echo "[+] Dropping privileges to '$JENKINS_USER' using gosu..."
    exec gosu "$JENKINS_USER" /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
else
    echo "[*] Warning: Running as non-root user ($(id -un)). Skipping group modification and privilege dropping."
    # If not running as root, we cannot modify groups. Fall back directly to jenkins.sh.
    exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
fi
```

### B. Dockerfile Verification
The current `prod-setup/jenkins/Dockerfile` is already fully aligned with this strategy:
- Installs `gosu` (lines 12, 103)
- Copies `entrypoint.sh` and does `chmod +x` (lines 31-32)
- Reverts to `USER jenkins` (line 34)
- Sets `ENTRYPOINT ["/entrypoint.sh"]` (line 37)

### C. Docker Compose Verification
The current `prod-setup/jenkins/docker-compose.yml` is already fully aligned:
- Overrides container user to root via `user: root` (line 9)
- Mounts `/var/run/docker.sock` (line 21)

---

## 4. Verification & Validation Protocol

To independently verify the correct implementation of this fix:

1. **Verify Shell Syntax and Execution**:
   Run `shellcheck` or a syntax check on the proposed entrypoint script to ensure it does not contain syntax bugs.
2. **Build and Run**:
   Run the following command from `prod-setup/jenkins`:
   ```bash
   docker-compose build --no-cache
   docker-compose up -d
   ```
3. **Verify Privilege Drop**:
   Verify that the processes inside the container are running as `jenkins`, NOT `root`:
   ```bash
   docker exec -it jenkins-server whoami
   # Expected output: jenkins
   ```
4. **Verify GID Mapping**:
   Confirm that the `jenkins` user is a member of the group matching the host's `/var/run/docker.sock` GID:
   ```bash
   docker exec -it jenkins-server groups
   # Expected output: must include 'jenkins' and the group matching the socket's host GID
   ```
5. **Verify Docker Access**:
   Confirm that the `jenkins` user can access the Docker socket and run docker commands successfully:
   ```bash
   docker exec -it jenkins-server docker ps
   # Expected output: list of active containers (or empty list if none, but no permission error)
   ```
