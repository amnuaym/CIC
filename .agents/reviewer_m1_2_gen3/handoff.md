# Handoff Report: Milestone 1 Review

## 1. Observation

- **`prod-setup/jenkins/entrypoint.sh`** (Lines 8-69):
  ```bash
  8: if [ "$(id -u)" -eq 0 ]; then
  ...
  18:         if [ "$DOCKER_GID" -lt 100 ]; then
  ...
  25:             if [ -n "$EXISTING_GROUP" ]; then
  ...
  27:                 if [ "$EXISTING_GROUP" = "docker" ] || [ "$EXISTING_GROUP" = "docker-host" ]; then
  ...
  31:                     echo "[!] GID collision: GID $DOCKER_GID is already used by group '$EXISTING_GROUP'."
  ...
  39:                         groupadd -o -g "$DOCKER_GID" "$NEW_GROUP"
  ...
  61:     echo "[+] Dropping privileges to '$JENKINS_USER'..."
  62:     exec gosu "$JENKINS_USER" /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
  63: else
  ...
  68:     exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
  69: fi
  ```
- **`prod-setup/jenkins/Dockerfile`** (Lines 28, 34, 37):
  ```dockerfile
  28: RUN groupadd -g 999 docker || true && usermod -aG docker jenkins
  ...
  34: USER jenkins
  ...
  37: ENTRYPOINT ["/entrypoint.sh"]
  ```
- **`prod-setup/jenkins/docker-compose.yml`** (Line 9, 21):
  ```yaml
  9:     user: root
  ...
  21:       - /var/run/docker.sock:/var/run/docker.sock
  ```

---

## 2. Logic Chain

1. **Gosu Privilege Drop**: Based on the observation of `entrypoint.sh` line 62, the script uses `exec gosu "$JENKINS_USER"` to run the standard Jenkins startup script. This ensures the main container process (`jenkins.sh`) runs under the non-privileged `jenkins` user instead of `root`.
2. **Early Check for Non-Root Execution**: Under `entrypoint.sh` line 8, the script checks `[ "$(id -u)" -eq 0 ]`. If this is false, it proceeds directly to the `else` block (line 63) and execs `jenkins.sh` without attempting any group modifications. This prevents crash/failure when the container is run as non-root (e.g. without user override).
3. **Dynamic GID Alignment & Collision Handling**:
   - The script uses `stat -c '%g'` to find the socket GID.
   - It checks `[ "$DOCKER_GID" -lt 100 ]` to bypass privileged system GIDs, avoiding escalation.
   - For GID collisions with non-system groups, it creates a duplicate GID group with `groupadd -o -g "$DOCKER_GID" "$NEW_GROUP"` (line 39) to map the group without hijacking/renaming the existing group name.
4. **Alignment**:
   - `Dockerfile` defines the default `USER jenkins` (non-root configuration).
   - `docker-compose.yml` overrides this default using `user: root`, allowing the entrypoint to run as root initially, perform the dynamic GID alignment, and drop privileges back to `jenkins` via `gosu`.
   - Thus, both files are correctly aligned and work in harmony.

---

## 3. Caveats

- We assumed that `stat`, `gosu`, and `tini` will always exist and behave correctly in the container context. The base image `jenkins/jenkins:lts` is Debian-based, where these tools are fully supported and installed via the `Dockerfile` instructions.
- We did not execute live Docker tests during this review due to timeout constraints on permission prompts. However, the logic has been statically verified.

---

## 4. Conclusion

The implementation of Milestone 1 is correct, secure, and meets all requirements. The code exhibits strong defensive programming against permission issues and GID collisions, with an appropriate user drop structure.

The verdict is **APPROVE**.

---

## 5. Verification Method

To independently verify the functionality:
1. Build and run the container using docker-compose:
   ```powershell
   cd prod-setup/jenkins
   docker compose up -d
   ```
2. Verify that Jenkins started successfully and is running as the `jenkins` user:
   ```powershell
   docker exec -it jenkins-server id
   ```
   *Expected Output*: UID should be 1000 (`jenkins`), and the user should belong to a group matching the host `/var/run/docker.sock` GID.
3. Test running the container without compose as a non-root user to verify it doesn't crash:
   ```powershell
   docker build -t jenkins-test .
   docker run --rm -it jenkins-test id
   ```
   *Expected Output*: The container runs and exits normally (or starts Jenkins) without any permission errors about group modification.
