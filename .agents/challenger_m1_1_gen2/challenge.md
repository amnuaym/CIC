# Adversarial Challenge Report: Local Jenkins DooD Setup

## Challenge Summary

**Overall risk assessment**: HIGH (due to a critical hardcoded path crash bug that prevents container execution under any configuration, and potential GID collision risks).

---

## Challenges

### [Critical] Challenge 1: Root & Non-root Startup Crash due to Incorrect Tini Path

- **Assumption challenged**: Assumed that `/usr/bin/tini` is the correct path to the init system inside the `jenkins/jenkins:lts` base image.
- **Attack scenario**: 
  - When the container starts as `root` (e.g. via `docker-compose.yml` with `user: root`), it executes line 62:
    `exec gosu "$JENKINS_USER" /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"`
  - When the container starts as non-root (e.g. via `docker run` without overrides), it executes line 68:
    `exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"`
  - In the official `jenkins/jenkins:lts` base image (based on Debian), the `tini` binary is installed at `/sbin/tini` (or `/tini` in some older versions), but **never** at `/usr/bin/tini`. As a result, the startup fails with `gosu: /usr/bin/tini: No such file or directory` or shell file-not-found errors, crashing the container immediately.
- **Blast radius**: 100% of container boots fail. The container cannot start or run Jenkins under any configuration.
- **Mitigation**: Change `/usr/bin/tini` to `/sbin/tini` in both line 62 and line 68 of `prod-setup/jenkins/entrypoint.sh`.

---

### [Medium] Challenge 2: Supplementary Group Access via GID Collision

- **Assumption challenged**: Assumed that creating a non-unique group (`docker-host-$DOCKER_GID`) and adding the `jenkins` user to it is completely isolated and safe.
- **Attack scenario**: 
  - If the host's Docker socket GID is 101, which matches the container's `systemd-journal` group, the script creates `docker-host-101` with GID 101 and adds `jenkins` to it.
  - Because Unix permissions are GID-based rather than name-based, the `jenkins` user inside the container now has full write/read access to all files and directories owned by GID 101 (`systemd-journal`).
  - An attacker who compromises the Jenkins container can read/write the systemd-journal logs of the container, potentially leaking sensitive system data or logs.
- **Blast radius**: Elevated access inside the container to system services or files owned by the colliding group (e.g., journal logs, system configuration).
- **Mitigation**: Maintain an explicit deny-list of known sensitive system GIDs in the `100-999` range (e.g., `systemd-journal`, `messagebus`) and refuse socket access for those as well, similar to the `< 100` check, or clearly document that colliding GIDs grant supplementary access.

---

### [Low] Challenge 3: Pathological Crash on Dynamic Socket GID Changes (Idempotency)

- **Assumption challenged**: Assumed that the script is fully idempotent across restarts if the host socket GID changes.
- **Attack scenario**: 
  - If the container is run first with host GID 1001, it creates `docker-host` (GID 1001).
  - If the container is subsequently restarted (in a persistent state or if group state is somehow preserved) with a new host socket GID of 1002, but some other group already exists with GID 1002, the script will try to create a duplicate group named `docker-host-1002` with GID 1002.
  - However, if a group named `docker-host-1002` was already created previously with a *different* GID, the `groupadd -g 1002 docker-host-1002` command will fail because the name is already in use, causing the script to crash (due to `set -e`).
- **Blast radius**: Container crash on startup under dynamic socket GID changes.
- **Mitigation**: When generating the group name for a collision, check if the group name exists and has a different GID. If so, append a suffix to ensure uniqueness.

---

### [Low] Challenge 4: Syntax Error and Crash on Empty/Non-numeric GID

- **Assumption challenged**: Assumed that `DOCKER_GID` is always populated with a valid numeric GID if the socket exists.
- **Attack scenario**: 
  - If `/var/run/docker.sock` exists but `stat -c '%g'` fails or returns an empty/non-numeric value (e.g., in weird filesystem mounts), `DOCKER_GID` will be empty.
  - The check `[ "$DOCKER_GID" -lt 100 ]` will syntax-error because `$DOCKER_GID` evaluates to nothing, leading to `[ -lt 100 ]` which is a bash syntax error. Under `set -e`, this syntax error causes the container to crash.
- **Blast radius**: Container startup crash.
- **Mitigation**: Validate that `DOCKER_GID` is a non-empty integer before performing numeric comparisons. E.g.:
  `if [ -n "$DOCKER_GID" ] && [ "$DOCKER_GID" -eq "$DOCKER_GID" ] 2>/dev/null; then ...`

---

## Stress Test Results

- **Scenario 1**: Start container with default entrypoint.sh (`/usr/bin/tini`).
  - Expected behavior: Container starts and launches Jenkins.
  - Predicted behavior: Container crashes with `gosu: /usr/bin/tini: No such file or directory` or file not found.
  - **Status**: FAIL (Crashes).

- **Scenario 2**: Host GID matches `systemd-journal` GID 101.
  - Expected behavior: Safe mapping.
  - Predicted behavior: Creates a duplicate GID mapping, granting the `jenkins` user access to `systemd-journal` resources.
  - **Status**: PASS (Functional, but introduces minor supplementary group exposure).

- **Scenario 3**: Host GID is `< 100` (e.g., GID 4).
  - Expected behavior: Group creation skipped, preventing privilege escalation.
  - Predicted behavior: Correctly skipped.
  - **Status**: PASS (Secure).

- **Scenario 4**: Run container as non-root user.
  - Expected behavior: Skips root-only alignment blocks and starts safely.
  - Predicted behavior: Crashes due to incorrect `/usr/bin/tini` path.
  - **Status**: FAIL (Crashes).

---

## Unchallenged Areas

- **GCP Key configuration (`gcp-key.json` / credentials)**: Out of scope for Milestone 1.
- **Host Docker Daemon Vulnerabilities**: While using DooD exposes the host Docker daemon (which is equivalent to root access on the host), this is an inherent design trade-off of the DooD architecture and is not challenged as a bug in the script.
