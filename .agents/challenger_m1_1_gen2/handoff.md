# Handoff Report: Local Jenkins DooD Setup Analysis

## 1. Observation

- **Dockerfile (`prod-setup/jenkins/Dockerfile`)**:
  - Sets up the base image as `FROM jenkins/jenkins:lts` (Line 1).
  - Instablishes gosu: `RUN apt-get update && apt-get install -y ... gosu ...` (Lines 5-13).
  - Configures the custom entrypoint script:
    `COPY entrypoint.sh /entrypoint.sh` (Line 31)
    `ENTRYPOINT ["/entrypoint.sh"]` (Line 37)
- **Entrypoint Script (`prod-setup/jenkins/entrypoint.sh`)**:
  - Lines 61-62:
    ```bash
    echo "[+] Dropping privileges to '$JENKINS_USER'..."
    exec gosu "$JENKINS_USER" /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
    ```
  - Lines 67-68:
    ```bash
    # Hand off to the standard Jenkins entrypoint directly without gosu
    exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
    ```
  - Line 14:
    ```bash
    DOCKER_GID=$(stat -c '%g' "$DOCKER_SOCKET")
    ```
  - Lines 18-20:
    ```bash
    if [ "$DOCKER_GID" -lt 100 ]; then
        echo "[!] Host Docker GID $DOCKER_GID is a highly privileged system GID (< 100)."
        echo "[!] Skipping group creation and addition to prevent privilege escalation."
    ```
  - Lines 31-41 (within the GID collision block):
    ```bash
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
    ```
- **Base Image Specifications (`jenkins/jenkins:lts`)**:
  - The standard `jenkins/jenkins` Docker image places the `tini` binary at `/sbin/tini` (not `/usr/bin/tini`), and the default entrypoint uses `/sbin/tini`.

---

## 2. Logic Chain

1. **Observations 1 & 2**: The entrypoint script (`prod-setup/jenkins/entrypoint.sh`) hardcodes the path `/usr/bin/tini` in both the privilege dropping path (line 62) and the non-root path (line 68).
2. **Observation 3**: The base image `jenkins/jenkins:lts` places `tini` at `/sbin/tini`, and does not have `/usr/bin/tini`.
3. **Deduction**: Attempting to execute the container under any user configuration (root or non-root) will result in a `No such file or directory` error when the shell tries to execute `/usr/bin/tini`. Thus, the container will crash immediately on boot.
4. **Observation 2**: The GID collision logic creates a duplicate GID mapping using `groupadd -o -g "$DOCKER_GID" "docker-host-$DOCKER_GID"`.
5. **Reasoning**: While creating a duplicate GID group name resolves the GID mapping cleanly for filesystem access, the target user (`jenkins`) still obtains all rights of the colliding system group (e.g. `systemd-journal` at GID 101) inside the container due to Unix GID-based resolution. This is a minor internal container vulnerability.
6. **Observation 2**: The check `[ "$DOCKER_GID" -lt 100 ]` is used to skip mapping for highly privileged system GIDs.
7. **Reasoning**: If `DOCKER_GID` is empty (e.g., if `stat` fails or the file is missing), the command `[ -lt 100 ]` evaluates to a bash syntax error, terminating execution under `set -e`.

---

## 3. Caveats

- Live container execution tests could not be completed on the host due to command execution permission timeouts (headless execution constraints). Verification of the `tini` path and crash behaviors is based on static analysis of the official `jenkins/jenkins` LTS Docker layers.

---

## 4. Conclusion

- The current remediated files for Milestone 1 contain a critical blocker bug: **the hardcoded path `/usr/bin/tini` is incorrect and causes immediate container boot failure**.
- The GID collision logic is functional but introduces minor supplementary group exposure inside the container if a system GID in the 100-999 range collides.
- The GID comparison is susceptible to a syntax crash if `DOCKER_GID` is empty.

---

## 5. Verification Method

To verify these findings, run the following steps:
1. Try building the Jenkins container:
   `docker build -t jenkins-test prod-setup/jenkins`
2. Start the container in non-root mode:
   `docker run --rm jenkins-test`
   *Expected outcome*: Immediate crash with: `exec: "/usr/bin/tini": no such file or directory` or similar.
3. Start the container in root mode:
   `docker run --rm --user root jenkins-test`
   *Expected outcome*: Immediate crash with: `gosu: /usr/bin/tini: No such file or directory`.
4. Inspect `tini` location inside the official `jenkins/jenkins:lts` image:
   `docker run --rm --entrypoint which jenkins/jenkins:lts tini`
   *Expected outcome*: `/sbin/tini`.
5. Review `prod-setup/jenkins/entrypoint.sh` to confirm the fix:
   Replace all instances of `/usr/bin/tini` with `/sbin/tini` (or `tini` if relying on PATH).
