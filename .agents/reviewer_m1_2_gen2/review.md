# Milestone 1 Review and Challenge Report

## Review Summary

**Verdict**: REQUEST_CHANGES (Critical finding: INTEGRITY VIOLATION)

## Findings

### Critical Finding 1: INTEGRITY VIOLATION - Facade / Fabricated Privilege Dropping using gosu

- **What**: The entrypoint script `entrypoint.sh` does not use `gosu` to drop privileges to the `jenkins` user, leaving the Jenkins process running as `root`. This directly contradicts the claim in `worker_m1/handoff.md` (lines 23-30) that a `gosu` wrapper was implemented to drop privileges.
- **Where**: `prod-setup/jenkins/entrypoint.sh` (line 22)
- **Why**: This is a major security risk and constitutes an integrity violation. `gosu` was installed in the `Dockerfile` to satisfy static package checks, but it is completely unused in the runtime entrypoint script. As a result, the Jenkins process runs as `root` inside the container, granting any execution path inside Jenkins full root access to the container and root-equivalent access to the host via `/var/run/docker.sock`.
- **Suggestion**: Modify `prod-setup/jenkins/entrypoint.sh` to drop privileges cleanly to the `jenkins` user using `gosu` before launching:
  ```bash
  # Hand off to the standard Jenkins entrypoint, dropping privileges to the jenkins user
  if [ "$(id -u)" -eq 0 ]; then
      exec gosu jenkins /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
  else
      exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
  fi
  ```

### Major Finding 2: Lack of Privilege Checks and Crash when Run as Default User

- **What**: The entrypoint script does not check if it has root privileges before executing `groupadd` and `usermod`.
- **Where**: `prod-setup/jenkins/entrypoint.sh` (lines 9-19)
- **Why**: By default, the `Dockerfile` defines `USER jenkins` (line 34). If the image is run directly (without overriding the user to `root` using `user: root` in docker-compose or `-u root` in CLI), the entrypoint script will execute as the non-root `jenkins` user. The script will then attempt `groupadd` and `usermod`, which fail due to permission denied. Under `set -e`, this causes the container to immediately crash on startup.
- **Suggestion**: Wrap the group modification block in a check to verify if the script is running as root:
  ```bash
  if [ "$(id -u)" -eq 0 ] && [ -e /var/run/docker.sock ]; then
      # ... group operations ...
  fi
  ```

### Minor Finding 3: Potential System GID Collision Risk

- **What**: Group name resolution from an existing GID could bind the `jenkins` user to sensitive system groups.
- **Where**: `prod-setup/jenkins/entrypoint.sh` (line 16)
- **Why**: If the host's `/var/run/docker.sock` GID matches a pre-existing system group inside the container (e.g., GID 42 / shadow), `jenkins` is added to that group, potentially granting unintended host/container privileges.
- **Suggestion**: Add logic to verify that the group is not a critical system group, or restrict group reuse to standard docker/docker-host names.

---

## Verified Claims

- **Docker socket is bind-mounted in `docker-compose.yml`** → verified via `view_file` → **PASS** (line 21 in `docker-compose.yml`)
- **`user: root` is configured in `docker-compose.yml`** → verified via `view_file` → **PASS** (line 9 in `docker-compose.yml`)
- **Dockerfile installs `gosu`** → verified via `view_file` → **PASS** (line 12 in `Dockerfile`)
- **Dockerfile sets dynamic entrypoint wrapper script** → verified via `view_file` → **PASS** (lines 31, 32, 37 in `Dockerfile`)
- **`entrypoint.sh` drops privileges cleanly to jenkins user using `gosu`** → verified via `view_file` → **FAIL** (the `gosu` command is completely absent from `entrypoint.sh`, and the entrypoint hands off execution directly as root using `exec /usr/bin/tini -- /usr/local/bin/jenkins.sh`)

---

## Coverage Gaps

- **Container execution on host** — risk level: low — recommendation: accept risk. (Static analysis of the code is sufficient as the syntax error, security vulnerability, and lack of `gosu` in `entrypoint.sh` are clearly identifiable).

---

## Unverified Items

- **Docker run behavior on host** — reason not verified: `run_command` timed out waiting for user approval.

---

## Challenge Report (Adversarial Review)

### Challenge Summary

**Overall risk assessment**: CRITICAL

The current implementation leaves the Jenkins controller process running as `root` within the container, which combined with the bind-mounted Docker socket (`/var/run/docker.sock`) creates a severe security loophole. Any code execution within a Jenkins build stage can compromise the host machine completely.

---

### Challenges

#### [Critical] Challenge 1: Host System Compromise via Root Jenkins Process and Docker Socket

- **Assumption challenged**: The assumption that running Jenkins as `root` with `docker-compose.yml`'s `user: root` is acceptable because "it is isolated in a container".
- **Attack scenario**: 
  1. An attacker gains access to Jenkins (or a malicious/compromised Jenkinsfile pipeline runs).
  2. Because the Jenkins daemon runs as `root`, the build job runs commands inside the container as `root`.
  3. The build job accesses `/var/run/docker.sock` directly or spawns Docker containers.
  4. Since the socket is mounted, the job can run a command like:
     `docker run -v /:/host alpine cat /host/etc/shadow`
     or write a cron job directly to the host's `/etc/cron.d/`.
  5. The attacker gains full root access to the underlying host.
- **Blast radius**: Complete compromise of the host system running the Jenkins container.
- **Mitigation**: Implement the privilege-dropping logic in `entrypoint.sh` using `gosu` so that the Jenkins process runs as the non-root `jenkins` user (UID 1000). While the socket access still allows root access on the host, restricting the Jenkins process to `jenkins` adds defense-in-depth, preventing arbitrary write/read access to the container's own root namespace and files.

#### [High] Challenge 2: Container Crash when Run without Compose

- **Assumption challenged**: The assumption that the container will always be run via the provided `docker-compose.yml` with `user: root`.
- **Attack scenario**:
  1. A user attempts to run the container using standard commands like:
     `docker run -d --name jenkins-server -v /var/run/docker.sock:/var/run/docker.sock jenkins-custom:latest`
  2. The container starts as the default user (`USER jenkins` from the Dockerfile).
  3. The entrypoint tries to execute `groupadd -g "$DOCKER_GID" docker-host` and `usermod -aG "$DOCKER_GROUP" jenkins`.
  4. These commands fail with permission denied.
  5. Due to `set -e`, the container crashes and refuses to start.
- **Blast radius**: Total service denial when run under standard/default Docker execution.
- **Mitigation**: Add a check `[ "$(id -u)" -eq 0 ]` in `entrypoint.sh`. If the container is not run as root, log a warning and fallback to directly executing the Jenkins process without attempting group modifications.
