# Adversarial Review: Milestone 1 - Local Jenkins DooD Setup

This report evaluates the correctness, safety, and security of the Docker-outside-of-Docker (DooD) configuration implemented in Milestone 1.

## Challenge Summary

**Overall risk assessment**: **HIGH**

Although the container successfully establishes access to the host's Docker socket when run in a highly privileged state (`user: root`), it violates critical security constraints by failing to drop privileges to the non-root `jenkins` user. Furthermore, it contains crash paths and privilege escalation risks under alternative runtime environments and GID mappings.

---

## Challenges

### [High] Challenge 1: Jenkins Process Runs Entirely as Root (Privilege Drop Failure)

- **Assumption challenged**: The entrypoint script is assumed to drop privileges from `root` to the standard `jenkins` user using `gosu` before initiating the application.
- **Attack scenario**: 
  1. The container is started via `docker-compose.yml` which specifies `user: root`.
  2. The custom entrypoint script `entrypoint.sh` executes group modifications as root.
  3. The script hands off execution via:
     ```bash
     exec /usr/bin/tini -- /usr/local/bin/jenkins.sh
     ```
  4. Because `gosu` is not used during the final handover, the standard `jenkins.sh` wrapper and the Java VM start and run entirely as the `root` user (UID 0).
- **Blast radius**: 
  - **Host Compromise via Docker Socket**: Since the host's `/var/run/docker.sock` is mounted in the container, any shell execution inside Jenkins (e.g., pipeline build steps, malicious plugins, or Remote Code Execution vulnerability) can easily run Docker commands as root on the host, granting the attacker complete control of the host machine.
  - **File Permission Issues in Volume**: Files, logs, and configurations written to `/var/jenkins_home` during execution will be owned by `root:root`. If the container is subsequently run in non-root mode, the application will crash due to permission denied errors on its own home directory.
- **Mitigation**:
  Rewrite the final command in `entrypoint.sh` to drop privileges to `jenkins` using `gosu`:
  ```bash
  echo "[+] Dropping privileges to 'jenkins'..."
  exec gosu jenkins /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
  ```

### [Medium] Challenge 2: Non-Root Container Startup Crash

- **Assumption challenged**: The container is assumed to start correctly and handle permissions robustly across different container runtimes or configurations.
- **Attack scenario**:
  1. An operator runs the container in a restricted environment (e.g., Kubernetes with `runAsNonRoot: true`, or simply runs `docker run` without `--user root`).
  2. The container starts as the default user `jenkins` (defined by `USER jenkins` in the Dockerfile).
  3. The entrypoint script `entrypoint.sh` starts and detects `/var/run/docker.sock`.
  4. It attempts to run `groupadd -g "$DOCKER_GID" docker-host` or `usermod -aG "$DOCKER_GROUP" jenkins`.
  5. Because `jenkins` is a non-root user, these administrative commands fail with a `Permission denied` error.
  6. Due to `set -e` at the top of the script, the entrypoint exits immediately, crashing the container before Jenkins starts.
- **Blast radius**: Complete Denial of Service (startup failure) in any environment that does not explicitly force the container to run as `root`.
- **Mitigation**:
  Add a root-check condition at the top of `entrypoint.sh` to bypass group modification commands when running as non-root:
  ```bash
  if [ "$(id -u)" -ne 0 ]; then
      echo "[!] Not running as root. Skipping docker.sock group alignment."
      exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
  fi
  ```

### [Low] Challenge 3: System Group Hijacking and Brittle Parsing on GID Collision

- **Assumption challenged**: The dynamic GID mapping logic handles existing groups and collisions without causing security or execution issues.
- **Attack scenario**:
  1. The host's `/var/run/docker.sock` is owned by a GID that matches an existing system group inside the container (e.g., GID `101` for `systemd-journal` or GID `42` for `shadow`).
  2. The entrypoint script retrieves this GID and runs:
     ```bash
     DOCKER_GROUP=$(getent group "$DOCKER_GID" | cut -d: -f1)
     usermod -aG "$DOCKER_GROUP" jenkins
     ```
  3. The `jenkins` user is added to `systemd-journal` or `shadow`, escalating its internal container privileges and granting access to sensitive system resources.
  4. If `getent group` returns multiple matches (e.g., due to duplicate entries in `/etc/group` or directory service overrides), `DOCKER_GROUP` will contain newlines. The `usermod` command will receive a multi-line argument, causing a syntax error and crashing the startup sequence.
- **Blast radius**: Internal container privilege escalation or startup failures.
- **Mitigation**:
  Ensure the script only grabs the first matching group name:
  ```bash
  DOCKER_GROUP=$(getent group "$DOCKER_GID" | head -n1 | cut -d: -f1)
  ```
  Additionally, prevent adding `jenkins` to highly privileged system groups (UIDs/GIDs < 100) unless explicitly desired.

---

## Stress Test Results

| Scenario | Expected Behavior | Actual/Predicted Behavior | Pass/Fail |
|---|---|---|---|
| **Run container as root** (default docker-compose configuration) | Privileges are dropped to `jenkins` via `gosu`; Jenkins processes run as non-root. | Main Jenkins Java process runs entirely as `root` (UID 0). | **FAIL** |
| **Run container as default user** (no root override) | Container starts successfully, bypassing GID mapping or warning gracefully. | Container crashes immediately due to `Permission denied` on `groupadd`/`usermod`. | **FAIL** |
| **Mount host docker.sock with GID 998** (does not exist in container) | Container creates `docker-host` group with GID 998 and adds `jenkins` to it. | Container creates group and adds user, but fails to drop privileges to `jenkins`. | **FAIL** (Partial) |
| **Mount host docker.sock with GID 101** (systemd-journal) | Container handles GID alignment safely without modifying unrelated system groups. | Container adds the `jenkins` user to the `systemd-journal` group directly. | **FAIL** (Security risk) |

---

## Unchallenged Areas

- **Jenkinsfile Build Pipelines**: The logic inside the `Jenkinsfile` itself (compilation steps, test execution) was not challenged in this scope, as it relates to build execution rather than the security of the hosting container.
- **GCP deployment integration**: Manifests and deployment configurations are outside the scope of Milestone 1.

---

## Verification Code

To dynamically reproduce and test these failure cases on the host machine, the following PowerShell script has been created in this folder:
- **Path**: `.agents\challenger_m1_2\verify_m1.ps1`
- **Steps to execute**:
  ```powershell
  cd D:\Github\cic\.agents\challenger_m1_2\
  .\verify_m1.ps1
  ```
