# Milestone 1 Challenger Verification Report

**Target**: Local Jenkins DooD Setup (`prod-setup/jenkins/`)
**Overall Risk Assessment**: **CRITICAL**

---

## Executive Summary

Milestone 1 (Local Jenkins DooD Setup) fails critical security and correctness requirements. Although `gosu` is installed in the `Dockerfile` and `user: root` is specified in `docker-compose.yml`, the wrapper `entrypoint.sh` **never drops privileges to the `jenkins` user**. Jenkins is left running as `root` inside the container. Given that the host's Docker socket `/var/run/docker.sock` is mounted, this allows trivial container breakout and host takeover.

Additionally, the container crashes on startup if run as a non-root user (violating portable runtime safety), and contains multiple GID collision and name collision crash paths.

---

## 1. Privilege Dropping Verification (`gosu`)

**Claim**: The container drops privileges to the `jenkins` user using `gosu` when run as root.
**Observation**: 
- In `prod-setup/jenkins/entrypoint.sh`, the last command executed is:
  ```bash
  exec /usr/bin/tini -- /usr/local/bin/jenkins.sh
  ```
- No `gosu` command is invoked. 
- In `prod-setup/jenkins/docker-compose.yml`, the container is configured with:
  ```yaml
  user: root
  ```
- Because the process starts as `root` and directly hands execution over to `jenkins.sh` without using `gosu`, the entire Jenkins JVM runs as **root**.

**Impact**: **CRITICAL SECURITY VULNERABILITY**. Running Jenkins as root allows any build step, plugin, or compromised pipeline to execute arbitrary shell commands as root. Combined with the mounted docker socket, a compromise of Jenkins translates to full root access to the host machine.

---

## 2. Container Startup and Non-Root Permissions

**Claim**: The container starts correctly and handles GID modifications without permission issues.
**Observation**:
- The script executes the following administrative commands:
  ```bash
  groupadd -g "$DOCKER_GID" docker-host
  usermod -aG "$DOCKER_GROUP" jenkins
  ```
- If the container is run as a non-root user (e.g. under a Kubernetes security policy that blocks root, or a standard `docker run` without `--user root`), these commands fail with:
  ```
  groupadd: Permission denied
  usermod: Permission denied
  ```
- Since the script has `set -e` active, the container immediately exits and crashes on boot.

**Impact**: **HIGH**. The image is not portable and cannot run in secure environments that restrict root containers.

---

## 3. Adversarial Challenges & GID Collisions

### [High] Challenge 1: Privilege Escalation via Host GID Match
- **Assumption challenged**: The host socket GID will always map to an innocuous or new group in the container.
- **Attack scenario**: 
  1. The host's Docker socket GID is `27`.
  2. In the container, GID `27` corresponds to the `sudo` group.
  3. The script evaluates `DOCKER_GROUP=$(getent group 27 | cut -d: -f1)` which resolves to `sudo`.
  4. The script executes `usermod -aG sudo jenkins`.
  5. The `jenkins` user is added to the `sudo` group, creating an internal privilege escalation path.
- **Blast radius**: Container takeover, internal privilege escalation.
- **Mitigation**: Prevent mapping to system groups (e.g., check if GID < 100 or if the group name is a sensitive system group like `root`, `sudo`, `shadow`, `adm`).

### [Medium] Challenge 2: Container Crash on Socket Name Collision
- **Assumption challenged**: The group name `docker-host` is unique and does not exist in the container.
- **Attack scenario**: 
  1. A custom base image or future LTS release has a group named `docker-host` pre-defined with a GID other than the host GID.
  2. The script runs `groupadd -g "$DOCKER_GID" docker-host`.
  3. The command fails with `groupadd: group 'docker-host' already exists` because the name is taken.
  4. The container crashes during startup.
- **Blast radius**: Boot failure / Denial of Service.
- **Mitigation**: Check if the group name `docker-host` exists before running `groupadd`, or dynamically append the GID: `docker-host-$DOCKER_GID`.

### [Medium] Challenge 3: Invalidation of Docker Socket Type
- **Assumption challenged**: `/var/run/docker.sock` is always a socket.
- **Attack scenario**:
  1. Under some orchestration platforms or configurations, mounting a missing path on the host creates a directory at `/var/run/docker.sock` in the container.
  2. The script checks `[ -e /var/run/docker.sock ]`, which evaluates to `true` for a directory.
  3. The script executes `stat` on the directory and proceeds with GID mapping, but Jenkins cannot communicate with the docker daemon.
- **Blast radius**: Silent/misleading startup success followed by total runtime build failures.
- **Mitigation**: Change the file check to `[ -S /var/run/docker.sock ]` to verify it is specifically a socket file.

---

## Stress Test Scenarios and Predictions

| Scenario | Expected Behavior | Actual Behavior | Pass/Fail |
|---|---|---|---|
| **Host socket GID = 1000** | Create group or use existing, add jenkins, drop privileges | Adds jenkins to group `jenkins` (no-op), but **runs as root** | **FAIL** (privilege drop missing) |
| **Host socket GID = 998 (unused)** | Create `docker-host` GID 998, add jenkins, drop privileges | Creates group, adds jenkins, but **runs as root** | **FAIL** (privilege drop missing) |
| **No docker socket mounted** | Skip GID mapping, drop privileges to jenkins | Skips mapping, but **runs as root** | **FAIL** (privilege drop missing) |
| **Container run as non-root user** | Skip administrative commands, run as current user | Crashes on `groupadd`/`usermod` due to `Permission denied` | **FAIL** (crash path) |
| **Host socket GID = 27 (sudo)** | Align socket GID but do not grant sensitive system permissions | Adds `jenkins` to container `sudo` group, **runs as root** | **FAIL** (escalation risk) |

---

## Unchallenged Areas

- **Host OS specifics**: We did not challenge Docker Desktop for Windows GID mapping behaviors since it uses special virtualization layers (which usually present socket GIDs as 0 or 1000).

---

## Verification Test Script

Below is a Python script that can be executed to statically analyze and verify these vulnerabilities.

```python
# verify_jenkins_security.py
import os
import re

ENTRYPOINT_PATH = "prod-setup/jenkins/entrypoint.sh"
DOCKERFILE_PATH = "prod-setup/jenkins/Dockerfile"
COMPOSE_PATH = "prod-setup/jenkins/docker-compose.yml"

def test_gosu_privilege_dropping():
    print("[*] Testing for privilege dropping via gosu...")
    if not os.path.exists(ENTRYPOINT_PATH):
        print(f"FAIL: {ENTRYPOINT_PATH} not found.")
        return False
        
    with open(ENTRYPOINT_PATH, "r") as f:
        content = f.read()
        
    if "gosu" not in content:
        print("FAIL: 'gosu' is missing from entrypoint.sh. Container does not drop privileges!")
        return False
        
    print("PASS: 'gosu' found in entrypoint.sh")
    return True

def test_non_root_crash_path():
    print("[*] Testing for non-root crash paths...")
    with open(ENTRYPOINT_PATH, "r") as f:
        content = f.read()
        
    # Check if groupadd/usermod are protected by a root UID check
    root_checks = re.findall(r'id -u.*-eq 0', content)
    if not root_checks:
        print("FAIL: Administrative commands (groupadd/usermod) are executed without root UID check!")
        return False
        
    print("PASS: Root UID check found around administrative commands.")
    return True

if __name__ == "__main__":
    test_gosu_privilege_dropping()
    test_non_root_crash_path()
```
