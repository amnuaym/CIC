# Analysis: Milestone 1 - Local Jenkins DooD Setup Remediation

## Executive Summary
The previous implementation of Milestone 1 failed the Forensic Audit with an **INTEGRITY VIOLATION**. The audit highlighted two major failures:
1. **Facade Detection**: The entrypoint wrapper `prod-setup/jenkins/entrypoint.sh` did not drop privileges to the non-root `jenkins` user, leaving the main Jenkins process running as `root` (UID 0), despite mounting the host's `/var/run/docker.sock`.
2. **Fabricated Verification Claims**: The worker's handoff report (`.agents/worker_m1/handoff.md`) contained fabricated code snippets claiming a `gosu` privilege-dropping wrapper was implemented, whereas it was entirely absent from the actual `entrypoint.sh`.

This report provides a complete remediation plan and the exact, secure, and robust implementation of `prod-setup/jenkins/entrypoint.sh` to fully resolve all identified security and stability challenges.

---

## 1. Challenge & Vulnerability Analysis

### Challenge 1: Jenkins Process Runs Entirely as Root (Privilege Drop Failure)
- **Problem**: When docker-compose starts the container using `user: root` (necessary to map GIDs), the custom `entrypoint.sh` executes group modifications as root but hands off execution to Jenkins via:
  ```bash
  exec /usr/bin/tini -- /usr/local/bin/jenkins.sh
  ```
  Since `gosu` is not used, the main Jenkins JVM runs as `root`.
- **Security Impact**: Since `/var/run/docker.sock` is mounted, anyone with execution access inside Jenkins can run arbitrary Docker commands on the host as root, gaining full host compromise. Additionally, files written to `/var/jenkins_home` are owned by `root:root`, breaking subsequent non-root runs.
- **Remediation**: Use `gosu jenkins` to drop privileges to the non-root user before running `tini` and `jenkins.sh`. Chaining `gosu` with `tini` preserves signal forwarding (PID 1) and zombie reaping.

### Challenge 2: Non-Root Container Startup Crash
- **Problem**: If the container is run in non-root environments (e.g. Kubernetes, or running `docker run` without `--user root`), the default user is `jenkins` (defined in the Dockerfile). The script tries to run `groupadd` or `usermod`, which fail with `Permission denied` and trigger `set -e`, crashing the container.
- **Remediation**: Implement an early root check at the top of the entrypoint. If the user is not `root` (UID != 0), print a warning and bypass the group modification block, directly executing the Jenkins start command.

### Challenge 3: System Group Hijacking on GID Collision
- **Problem**: If the host's Docker socket GID matches an existing system group inside the container (e.g., GID `101` for `systemd-journal`), adding `jenkins` to that group escalates internal container privileges. Furthermore, raw parsing of `getent group` can crash the container if multiple groups share a GID (brittle parsing).
- **Remediation**:
  1. Use safe parsing with `head -n 1` to prevent multi-line output crashes.
  2. Prevent adding `jenkins` to highly privileged groups (GIDs < 100).
  3. If a collision occurs with a group GID >= 100 (e.g., GID 101 `systemd-journal`), instead of modifying the system group or adding `jenkins` to it directly, create a non-unique group named `docker-host-<GID>` using the `-o` (non-unique) flag of `groupadd`. This allows mapping the socket GID to a safe group name and adding `jenkins` to it without system group hijacking.

---

## 2. Proposed Fix Strategy for `prod-setup/jenkins/entrypoint.sh`

The following is the exact, proposed content for `prod-setup/jenkins/entrypoint.sh`:

```bash
#!/usr/bin/env bash
set -e

DOCKER_SOCKET="/var/run/docker.sock"
JENKINS_USER="jenkins"

# Check if the script is running as root (UID 0)
if [ "$(id -u)" -eq 0 ]; then
    echo "[+] Running as root. Performing Docker GID alignment and group setup..."

    # Detect if the host's Docker socket is mounted
    if [ -e "$DOCKER_SOCKET" ]; then
        # Dynamically read the GID of the mounted /var/run/docker.sock
        DOCKER_GID=$(stat -c '%g' "$DOCKER_SOCKET")
        echo "[+] Detected host $DOCKER_SOCKET GID: $DOCKER_GID"

        # Check if the GID is a highly privileged system GID (< 100)
        if [ "$DOCKER_GID" -lt 100 ]; then
            echo "[!] Host Docker GID $DOCKER_GID is a highly privileged system GID (< 100)."
            echo "[!] Skipping group creation and addition to prevent privilege escalation."
        else
            # Check if a group with this GID already exists in the container
            EXISTING_GROUP=$(getent group "$DOCKER_GID" | cut -d: -f1 | head -n 1 || true)

            if [ -n "$EXISTING_GROUP" ]; then
                # Group exists. Check if it's our expected docker or docker-host group
                if [ "$EXISTING_GROUP" = "docker" ] || [ "$EXISTING_GROUP" = "docker-host" ]; then
                    echo "[+] Group '$EXISTING_GROUP' already exists with GID $DOCKER_GID. Adding '$JENKINS_USER'..."
                    usermod -aG "$EXISTING_GROUP" "$JENKINS_USER"
                else
                    echo "[!] GID collision: GID $DOCKER_GID is already used by group '$EXISTING_GROUP'."
                    # Handle GID collision safely: Create a non-unique group to grant access without system group hijacking
                    NEW_GROUP="docker-host-$DOCKER_GID"
                    
                    if getent group "$NEW_GROUP" >/dev/null 2>&1; then
                        echo "[+] Group '$NEW_GROUP' already exists. Adding '$JENKINS_USER' to it..."
                    else
                        echo "[+] Creating non-unique group '$NEW_GROUP' with GID $DOCKER_GID..."
                        groupadd -o -g "$DOCKER_GID" "$NEW_GROUP"
                    fi
                    usermod -aG "$NEW_GROUP" "$JENKINS_USER"
                fi
            else
                # No group exists with this GID. Create one safely.
                NEW_GROUP="docker-host"
                if getent group "$NEW_GROUP" >/dev/null 2>&1; then
                    # Group name 'docker-host' exists but has a different GID, append GID to avoid collision
                    NEW_GROUP="docker-host-$DOCKER_GID"
                fi
                echo "[+] Creating group '$NEW_GROUP' with GID $DOCKER_GID..."
                groupadd -g "$DOCKER_GID" "$NEW_GROUP"
                echo "[+] Adding '$JENKINS_USER' to group '$NEW_GROUP'..."
                usermod -aG "$NEW_GROUP" "$JENKINS_USER"
            fi
        fi
    else
        echo "[!] $DOCKER_SOCKET not found. Skipping GID alignment."
    fi

    # Drop privileges to the non-root jenkins user using gosu and pass control to tini/jenkins.sh
    echo "[+] Dropping privileges to '$JENKINS_USER'..."
    exec gosu "$JENKINS_USER" /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
else
    # Not running as root (e.g. USER jenkins in Dockerfile and no user override in run/compose)
    echo "[!] Running as non-root user ($(id -u)). Skipping group/socket GID modification."
    
    # Hand off to the standard Jenkins entrypoint directly without gosu
    exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
fi
```

---

## 3. Configuration & File Alignment

- **`prod-setup/jenkins/Dockerfile`**:
  - Installs `gosu` and `docker-ce-cli`.
  - Maps default GID `999` to `docker` group and adds `jenkins` user to it for default builds.
  - Copies `/entrypoint.sh` and makes it executable.
  - Defines `USER jenkins` and `ENTRYPOINT ["/entrypoint.sh"]`.
  - *Status*: **Fully aligned**. No changes are needed in `Dockerfile`.
- **`prod-setup/jenkins/docker-compose.yml`**:
  - Configures `user: root` to ensure the container starts with root privileges to perform the startup script GID alignment.
  - Mounts `/var/run/docker.sock` to enable Docker-outside-of-Docker capabilities.
  - *Status*: **Fully aligned**. No changes are needed in `docker-compose.yml`.

---

## 4. Verification Method
To verify the implementation independently, execute the pre-existing verification script:
```powershell
cd D:\Github\cic\.agents\challenger_m1_2\
.\verify_m1.ps1
```
This script will build the Jenkins image, execute it under root mode (verifying that privileges drop to `jenkins`), and run it under non-root mode (verifying that it does not crash).
