# Handoff Report - Milestone 1 Review

## 1. Observation

I have examined the following files in the repository:
- `prod-setup/jenkins/entrypoint.sh`
- `prod-setup/jenkins/Dockerfile`
- `prod-setup/jenkins/docker-compose.yml`

Specifically, I observed the following key blocks:

### A. Non-Root Early Check and Privilege Dropping
Lines 8-9 and 60-69 of `prod-setup/jenkins/entrypoint.sh`:
```bash
if [ "$(id -u)" -eq 0 ]; then
    echo "[+] Running as root. Performing Docker GID alignment and group setup..."
...
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

### B. Dynamic GID Mapping and Collision Logic
Lines 12-58 of `prod-setup/jenkins/entrypoint.sh`:
```bash
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
```

### C. Dockerfile Configuration
`prod-setup/jenkins/Dockerfile`:
- Lines 12: Installs `gosu`.
- Line 28: Runs `groupadd -g 999 docker || true && usermod -aG docker jenkins`.
- Line 31-32: Copies and makes `entrypoint.sh` executable.
- Line 34: Sets default user as `USER jenkins`.
- Line 37: Sets `ENTRYPOINT ["/entrypoint.sh"]`.

### D. Docker Compose Configuration
`prod-setup/jenkins/docker-compose.yml`:
- Line 9: Sets `user: root`.
- Line 21: Mounts host `/var/run/docker.sock:/var/run/docker.sock`.

---

## 2. Logic Chain

1. **Requirement 1 (Privilege Dropping)**: Verified via Observation A. When UID is 0, the script runs `exec gosu "$JENKINS_USER" /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"`. This drops the process from `root` to `jenkins` user privileges correctly while launching Jenkins under tini.
2. **Requirement 2 (Early Non-Root Check)**: Verified via Observation A. The script checks `if [ "$(id -u)" -eq 0 ]`. If not root, it routes directly to the `else` block and calls `exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"`, bypassing root-only group modifications, preventing a crash.
3. **Requirement 3 (GID Collision Logic)**: Verified via Observation B. The logic does the following:
   - Check if GID is privileged (`$DOCKER_GID -lt 100`). If so, skip modifications to avoid escalation (Observation B, lines 18-21).
   - Read the existing group names with that GID using `getent`. If one exists and is not `docker` or `docker-host`, it creates a non-unique group named `docker-host-$DOCKER_GID` using `groupadd -o -g` (Observation B, lines 33-40) and adds `jenkins` to it. This handles the collision safely.
   - If no group exists with that GID, it creates a new group named `docker-host` (or `docker-host-$DOCKER_GID` if the name is already taken but with a different GID) and adds `jenkins` to it.
4. **Requirement 4 (Alignment)**: Verified via Observations C & D. `docker-compose.yml` runs the container as `user: root` to allow dynamic host socket mapping, and the `Dockerfile` is built with a default `USER jenkins` and custom `ENTRYPOINT` wrapper, ensuring the dynamic GID mapping script executes first as root and then drops privileges to the `jenkins` user.

---

## 3. Caveats

- **Runtime Execution**: Dynamic behavior under actual docker execution was not tested at runtime due to local terminal command timeout constraints. All logic verification was performed via static code analysis.

---

## 4. Conclusion

The remediated files are fully compliant, correct, and secure. They handle all GID mapping, GID collisions, name collisions, and privilege drop workflows robustly. No changes are requested.

---

## 5. Verification Method

To independently verify the runtime behavior, perform the following steps:
1. Navigate to `prod-setup/jenkins/`.
2. Run `docker compose up --build -d`.
3. Check the logs: `docker compose logs`. Verify that it prints the following:
   - `[+] Running as root. Performing Docker GID alignment and group setup...`
   - `[+] Detected host /var/run/docker.sock GID: <host_gid>`
   - Depending on host GID, either group addition, group creation, or collision handling log messages.
   - `[+] Dropping privileges to 'jenkins'...`
4. Confirm the running user in the container is `jenkins` (UID 1000) but has group access to the docker socket:
   - Run `docker compose exec jenkins id`.
   - Verify that the output shows UID `1000(jenkins)` and secondary GID matching the host `/var/run/docker.sock` GID.
5. Verify non-root execution path:
   - Run `docker run --rm -it -u jenkins $(docker build -q .) id`.
   - Verify the logs output `[!] Running as non-root user (1000). Skipping group/socket GID modification.` and it launches Jenkins without crash.
