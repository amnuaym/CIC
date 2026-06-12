# Review Report: Milestone 1 - Local Jenkins DooD Setup

## Review Summary

**Verdict**: **APPROVE**

The remediated files for Milestone 1 (Local Jenkins DooD Setup) have been thoroughly reviewed. All key requirements, including dynamic GID alignment, non-root run protection, privilege dropping using `gosu`, and configuration alignment, have been implemented correctly and securely. No integrity violations, shortcuts, or dummy implementations were found.

---

## Findings & Verification of Requirements

### 1. Privilege Dropping via `gosu`
- **Requirement**: `prod-setup/jenkins/entrypoint.sh` must drop privileges to the `jenkins` user using `gosu` when run as root.
- **Verification**: 
  - In `prod-setup/jenkins/entrypoint.sh` (lines 61-62):
    ```bash
    echo "[+] Dropping privileges to '$JENKINS_USER'..."
    exec gosu "$JENKINS_USER" /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
    ```
  - This correctly drops privileges to the `jenkins` user (defined as `jenkins` on line 5) and passes control to the standard Jenkins startup flow using `tini` as the init daemon.
- **Verdict**: **PASS**

### 2. Early Check for Non-Root Execution
- **Requirement**: An early check for non-root execution (`[ "$(id -u)" -eq 0 ]`) is implemented to prevent crash when run without user override.
- **Verification**:
  - In `prod-setup/jenkins/entrypoint.sh` (line 8):
    ```bash
    if [ "$(id -u)" -eq 0 ]; then
    ```
  - If the container is run as a non-root user (e.g. `USER jenkins` default from the Dockerfile, or a user override like `docker run --user 1000 ...`), the `else` block (lines 63-69) is executed:
    ```bash
    else
        echo "[!] Running as non-root user ($(id -u)). Skipping group/socket GID modification."
        exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
    fi
    ```
  - This prevents the container from crashing when attempting privileged group/socket manipulation commands (`groupadd`, `usermod`) under a non-root context.
- **Verdict**: **PASS**

### 3. GID Collision and Security Mapping Logic
- **Requirement**: GID collision logic safely handles mapping host socket GID to existing group GIDs. This includes collision checks, privileged system GID checks, and non-unique group creation.
- **Verification**:
  - **Host Socket Detection**: Checks for `/var/run/docker.sock` and retrieves its GID using `stat -c '%g' "/var/run/docker.sock"`.
  - **Privileged GID Check** (lines 18-21):
    ```bash
    if [ "$DOCKER_GID" -lt 100 ]; then
        echo "[!] Host Docker GID $DOCKER_GID is a highly privileged system GID (< 100)."
        echo "[!] Skipping group creation and addition to prevent privilege escalation."
    ```
    This prevents privilege escalation by refusing to add `jenkins` to privileged system groups (e.g. root, daemon, disk, etc.).
  - **Collision and Non-Unique Group Mapping** (lines 25-54):
    - If a group with the host socket's GID already exists in the container:
      - If it is the expected `docker` or `docker-host` group, it adds `jenkins` directly to it.
      - Otherwise, to avoid hijacking/modifying a system group name (e.g. `audio` or `staff`), it creates a non-unique group (`docker-host-$DOCKER_GID`) with the target GID using the `-o` (non-unique) option:
        ```bash
        groupadd -o -g "$DOCKER_GID" "$NEW_GROUP"
        ```
        Then, it adds the `jenkins` user to this newly created non-unique group.
    - If the GID is not used:
      - It safely creates a group (`docker-host` or `docker-host-$DOCKER_GID` if name is taken) and adds `jenkins` to it.
- **Verdict**: **PASS**

### 4. Dockerfile and Docker Compose Alignment
- **Requirement**: `Dockerfile` and `docker-compose.yml` must be correctly aligned.
- **Verification**:
  - **Dockerfile**:
    - Extends `jenkins/jenkins:lts`.
    - Installs dependencies including `gosu` and the Docker CLI.
    - Creates a default `docker` group with GID 999.
    - Sets `USER jenkins` (line 34) so the default image run is secure and non-root.
    - Sets `ENTRYPOINT ["/entrypoint.sh"]` (line 37).
  - **Docker Compose**:
    - Defines `user: root` (line 9) to override the default non-root user. This triggers the privilege drop flow in `entrypoint.sh`, allowing dynamic socket GID alignment to run first.
    - Mounts `/var/run/docker.sock` (line 21).
  - This layout is correct. The compose file initiates the container as root to perform dynamic runtime GID alignment, and the entrypoint immediately drops privileges to the `jenkins` user. The Dockerfile retains `USER jenkins` for environments that execute without docker-compose or override.
- **Verdict**: **PASS**

---

## Verified Claims

- **Privilege Drop**: Verified that `gosu` is invoked when starting as root. -> **PASS**
- **Non-Root Safety**: Verified that the script handles non-root starts gracefully without calling `groupadd`/`usermod`. -> **PASS**
- **System GID Protection**: Verified that GIDs < 100 are blocked. -> **PASS**
- **Collision Handling**: Verified that duplicate GIDs are mapped using `groupadd -o`. -> **PASS**
- **Alignment**: Verified that `docker-compose.yml` specifies `user: root` and `Dockerfile` specifies `USER jenkins`. -> **PASS**

---

## Adversarial Challenge Report

### Challenge Summary
- **Overall risk assessment**: **LOW**
- The setup is highly robust. The main failure modes would stem from unexpected host OS configurations (such as an empty docker socket GID result or missing dependencies in customized base images).

### Challenges & Mitigation Analysis

#### 1. Missing or Failed `stat` Command
- **Assumption Challenged**: `stat -c '%g' "$DOCKER_SOCKET"` will always succeed when `/var/run/docker.sock` exists.
- **Attack Scenario / Failure Mode**: If `/var/run/docker.sock` is mounted as a broken symlink or has access permissions such that the container's root user cannot stat it, the command will fail. Because of `set -e` at the top of `entrypoint.sh`, any failure in `stat` will cause the container to crash/exit immediately.
- **Blast Radius**: Jenkins fails to start.
- **Mitigation**: Wrap the `stat` call in a fallback. For example:
  ```bash
  DOCKER_GID=$(stat -c '%g' "$DOCKER_SOCKET" 2>/dev/null || echo "")
  if [ -z "$DOCKER_GID" ]; then
      echo "[!] Failed to retrieve GID for $DOCKER_SOCKET. Skipping alignment."
  else
      ...
  fi
  ```
  *(Recommendation: Low priority, as the Docker socket is normally readable by root inside the container).*

#### 2. System GID Bypass via GID >= 100
- **Assumption Challenged**: System/privileged groups only use GIDs < 100.
- **Attack Scenario / Failure Mode**: Some Linux distributions may assign privileged system groups to GIDs between 100 and 999 (e.g. systemd groups, system services). If the host's Docker GID maps to one of these groups inside the container, the collision logic will map the GID using `groupadd -o`.
- **Blast Radius**: While this gives the `jenkins` user access to files owned by that GID inside the container, this is unavoidable because the Docker socket itself is owned by that GID on the host. Access to the Docker socket is equivalent to full root access on the host anyway.
- **Mitigation**: None needed. Access to the Docker daemon is implicitly root-equivalent on the host.

---

## Coverage Gaps
- None. All relevant configuration files and logic blocks for Milestone 1 were analyzed.

## Unverified Items
- None. All logic paths were verified by static analysis.
