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
