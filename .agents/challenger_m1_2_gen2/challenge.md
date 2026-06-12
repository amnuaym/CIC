# Adversarial Challenge Report: Milestone 1 (Local Jenkins DooD Setup)

**Overall risk assessment**: HIGH

This report evaluates the robustness and security of the remediated Jenkins DooD (Docker-out-of-Docker) entrypoint script (`prod-setup/jenkins/entrypoint.sh`) against GID collisions, privileged system GIDs, privilege escalation, and non-root execution crash paths.

---

## 1. GID Collisions
- **Assumption Challenged**: Creating a non-unique group with the colliding GID (e.g. `docker-host-$DOCKER_GID`) prevents "group hijacking" and safely separates permissions.
- **Attack Scenario**: The host's Docker socket is owned by a GID that matches an existing container system group (e.g., GID 101, which is `systemd-journal` in Debian). The entrypoint script detects the collision, creates a non-unique group named `docker-host-101` with GID 101, and adds the `jenkins` user to it.
- **Blast Radius**: **HIGH**. In Linux, permission checks are executed by the kernel using numeric GIDs, not group names. Adding the `jenkins` user to a group with GID 101 (even if named `docker-host-101`) grants the `jenkins` process all permissions associated with GID 101 (`systemd-journal`) inside the container. This allows the non-root `jenkins` user to read and interact with systemd journal files or logs.
- **Mitigation**:
  - GID-level sharing is a fundamental characteristic of Docker socket mount setups. However, the script should explicitly warn the administrator if the GID matches an existing sensitive system group:
    ```bash
    echo "[!] WARNING: GID collision with container system group '$EXISTING_GROUP' (GID $DOCKER_GID)."
    echo "[!] The '$JENKINS_USER' user will inherit all container permissions for '$EXISTING_GROUP'."
    ```

---

## 2. Highly Privileged System GIDs (< 100)
- **Assumption Challenged**: Protecting GIDs `< 100` is sufficient to block all privileged groups.
- **Attack Scenario**: The host Docker socket GID is a privileged system GID `>= 100`. For example, on some Linux distributions:
  - `systemd-journal` is GID 101 (access to system logs).
  - `input` is GID 104 (access to raw input devices / keylogger).
  - `disk` is GID 993 on RedHat/Arch (allowing direct read/write access to raw block devices).
- **Blast Radius**: **MEDIUM**. The `< 100` threshold fails to block these privileged groups. If the host Docker GID matches these, the entrypoint script will proceed to add the `jenkins` user to the group, granting it access.
- **Mitigation**:
  - Expand the exclusion list to block known high-privilege GIDs above 100, or explicitly block known dangerous groups by name if they are detected:
    ```bash
    SENSITIVE_GROUPS="root|daemon|bin|sys|adm|disk|sudo|shadow|input|wheel"
    if [ "$DOCKER_GID" -lt 100 ] || echo "$EXISTING_GROUP" | grep -qE "^($SENSITIVE_GROUPS)$"; then
        echo "[!] Skipping group creation/addition for sensitive GID $DOCKER_GID ($EXISTING_GROUP) to prevent privilege escalation."
    fi
    ```

---

## 3. Privilege Escalation
- **Assumption Challenged**: Dropping privileges via `gosu` is secure, and no local privilege escalation is possible.
- **Attack Scenario**: 
  - **Host GID Manipulation**: A malicious host user with access to modify docker socket permissions can change its GID to match a privileged GID in the container (e.g. `disk` or `input`). When the container starts, the root-owned entrypoint script will automatically add `jenkins` to that GID, granting the container user elevated permissions.
  - **Script Crash Resilience**: If a command fails in the script prior to the privilege drop, does it drop the user into a root shell?
- **Blast Radius**: **LOW**. 
  - Since `set -e` is active, any command failure (like `stat` or `groupadd` failing) will cause the entrypoint script to immediately exit and terminate the container. It does not drop to an interactive root shell, which prevents root access leakage.
  - SUID risks are mitigated since `gosu` drops privileges before executing the target binary.
- **Mitigation**: Keep `set -e` active to guarantee the container terminates rather than degrading to a root shell upon command failure.

---

## 4. Non-Root User Execution Crash Paths
- **Assumption Challenged**: Hardcoded command paths (`/usr/bin/tini`) and GID extraction commands will succeed across all execution modes.
- **Attack Scenarios & Crash Paths**:
  1. **Hardcoded Tini Path (`/usr/bin/tini`)**:
     - The script executes `exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"` (on non-root path) and `exec gosu "$JENKINS_USER" /usr/bin/tini ...` (on root path).
     - In the official `jenkins/jenkins:lts` image, `tini` is located at `/sbin/tini`, **NOT** `/usr/bin/tini`.
     - **Result**: The container crashes immediately on startup with "No such file or directory" for *all* execution paths (both root and non-root).
  2. **Empty or Non-Numeric GID Evaluation**:
     - If `/var/run/docker.sock` exists but the `stat` command fails or returns an empty GID (e.g., if the command isn't fully compatible or has permissions restrictions):
       - `DOCKER_GID` is set to an empty string.
       - The comparison `[ "$DOCKER_GID" -lt 100 ]` evaluates to `[ -lt 100 ]`.
       - **Result**: Bash throws a syntax error (`unary operator expected`) and, due to `set -e`, the script immediately exits, crashing the container.
  3. **Read-Only Filesystem**:
     - If the container is deployed in a hardened environment with a read-only root filesystem (e.g., Kubernetes `readOnlyRootFilesystem: true` or Docker `--read-only`), `/etc/group` and `/etc/passwd` are read-only.
     - The entrypoint script will attempt to run `groupadd` or `usermod`, which will fail with write errors.
     - **Result**: Because of `set -e`, the script immediately terminates, causing the container to crash on startup.
- **Mitigations**:
  1. **Resolve Tini Dynamically**:
     ```bash
     if [ -x "/sbin/tini" ]; then
         TINI_BIN="/sbin/tini"
     elif [ -x "/usr/bin/tini" ]; then
         TINI_BIN="/usr/bin/tini"
     else
         TINI_BIN="tini"
     fi
     ```
  2. **Sanitize GID Variable**:
     ```bash
     if [ -z "$DOCKER_GID" ] || ! [ "$DOCKER_GID" -eq "$DOCKER_GID" ] 2>/dev/null; then
         echo "[!] Invalid or empty Docker GID: '$DOCKER_GID'. Skipping GID alignment."
     elif [ "$DOCKER_GID" -lt 100 ]; then
         ...
     ```
  3. **Check for Writable Filesystem**:
     ```bash
     if [ ! -w "/etc/group" ]; then
         echo "[!] /etc/group is read-only. Skipping GID alignment."
     else
         # Run GID alignment logic
         ...
     fi
     ```

---

## Stress Test Results

| Scenario | Expected Behavior | Actual Behavior | Pass/Fail |
|---|---|---|---|
| Non-Root User Execution | Smooth handoff to Jenkins via tini | Crashes due to missing `/usr/bin/tini` | **FAIL** |
| Root User Execution | Success, dropping privileges to `jenkins` | Crashes due to missing `/usr/bin/tini` | **FAIL** |
| Host GID collision with system group (101) | Avoid hijacking system group | User added to GID 101, inheriting system group privileges | **FAIL** (Security Assumption) |
| Host GID < 100 (e.g. GID 42) | Skip group creation & addition | Skips group creation & addition | **PASS** |
| Stat command fails / returns empty | Fallback safely without crashing | Crashes with syntax error in integer comparison | **FAIL** |
| Read-only Root Filesystem | Proceed safely without crashing | Crashes due to write failures in `groupadd`/`usermod` | **FAIL** |

---

## Recommendations

Update the `/entrypoint.sh` script to incorporate dynamic path resolution, read-only filesystem detection, integer validation, and strict group checks as described in the mitigations. A suggested secure and robust entrypoint script is:

```bash
#!/usr/bin/env bash
set -e

DOCKER_SOCKET="/var/run/docker.sock"
JENKINS_USER="jenkins"

# Resolve tini path dynamically
if [ -x "/sbin/tini" ]; then
    TINI_BIN="/sbin/tini"
elif [ -x "/usr/bin/tini" ]; then
    TINI_BIN="/usr/bin/tini"
else
    TINI_BIN="tini"
fi

# Check if the script is running as root (UID 0)
if [ "$(id -u)" -eq 0 ]; then
    echo "[+] Running as root. Performing Docker GID alignment and group setup..."

    # Detect if the host's Docker socket is mounted and /etc/group is writable
    if [ -e "$DOCKER_SOCKET" ] && [ -w "/etc/group" ]; then
        # Dynamically read the GID of the mounted /var/run/docker.sock
        DOCKER_GID=$(stat -c '%g' "$DOCKER_SOCKET" 2>/dev/null || true)
        echo "[+] Detected host $DOCKER_SOCKET GID: $DOCKER_GID"

        # Check if GID is valid and not empty
        if [ -z "$DOCKER_GID" ] || ! [ "$DOCKER_GID" -eq "$DOCKER_GID" ] 2>/dev/null; then
            echo "[!] Could not resolve a valid numeric GID for $DOCKER_SOCKET. Skipping GID alignment."
        # Check if the GID is a highly privileged system GID (< 100)
        elif [ "$DOCKER_GID" -lt 100 ]; then
            echo "[!] Host Docker GID $DOCKER_GID is a highly privileged system GID (< 100)."
            echo "[!] Skipping group creation and addition to prevent privilege escalation."
        else
            # Check if a group with this GID already exists in the container
            EXISTING_GROUP=$(getent group "$DOCKER_GID" | cut -d: -f1 | head -n 1 || true)
            SENSITIVE_GROUPS="root|daemon|bin|sys|adm|disk|sudo|shadow|input|wheel"

            if [ -n "$EXISTING_GROUP" ]; then
                # Group exists. Check if it is a sensitive group
                if echo "$EXISTING_GROUP" | grep -qE "^($SENSITIVE_GROUPS)$"; then
                    echo "[!] GID collision with sensitive system group '$EXISTING_GROUP' (GID $DOCKER_GID)."
                    echo "[!] Skipping group addition to prevent privilege escalation."
                elif [ "$EXISTING_GROUP" = "docker" ] || [ "$EXISTING_GROUP" = "docker-host" ]; then
                    echo "[+] Group '$EXISTING_GROUP' already exists with GID $DOCKER_GID. Adding '$JENKINS_USER'..."
                    usermod -aG "$EXISTING_GROUP" "$JENKINS_USER"
                else
                    echo "[!] GID collision: GID $DOCKER_GID is already used by group '$EXISTING_GROUP'."
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
        if [ ! -e "$DOCKER_SOCKET" ]; then
            echo "[!] $DOCKER_SOCKET not found. Skipping GID alignment."
        fi
        if [ ! -w "/etc/group" ]; then
            echo "[!] /etc/group is read-only. Skipping GID alignment."
        fi
    fi

    # Drop privileges to the non-root jenkins user using gosu and pass control to tini/jenkins.sh
    echo "[+] Dropping privileges to '$JENKINS_USER'..."
    exec gosu "$JENKINS_USER" "$TINI_BIN" -- /usr/local/bin/jenkins.sh "$@"
else
    # Not running as root (e.g. USER jenkins in Dockerfile and no user override in run/compose)
    echo "[!] Running as non-root user ($(id -u)). Skipping group/socket GID modification."
    
    # Hand off to the standard Jenkins entrypoint directly without gosu
    exec "$TINI_BIN" -- /usr/local/bin/jenkins.sh "$@"
fi
```
