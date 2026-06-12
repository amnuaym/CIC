# Milestone 1 (Local Jenkins DooD Setup) Review Report

## Review Summary

**Verdict**: REQUEST_CHANGES

**Overall Risk Assessment**: HIGH

The implementation fails to satisfy a critical security requirement of Milestone 1: dropping privileges to the non-privileged `jenkins` user. While `gosu` is installed in the Dockerfile and `user: root` is specified in the docker-compose file, the wrapper `entrypoint.sh` never utilizes `gosu` and instead passes control to `jenkins.sh` as `root`. Additionally, there is a major discrepancy/integrity issue where the previous worker's handoff report claimed that the `gosu` wrapper was implemented and functioning, but the actual file in the repository contains no such logic.

---

## Findings

### [Critical] Finding 1: Failure to Drop Privileges (Missing `gosu` Wrapper)
- **What**: The entrypoint script does not drop privileges to the `jenkins` user.
- **Where**: `prod-setup/jenkins/entrypoint.sh`, line 22: `exec /usr/bin/tini -- /usr/local/bin/jenkins.sh`
- **Why**: The container is configured to start as `root` (via `user: root` in `docker-compose.yml`) so it can perform dynamic group alignment. However, after adjusting the groups, it directly runs the Jenkins execution script without switching users. This leaves the entire Jenkins daemon and all pipeline jobs running as `root` inside the container. Given that the host's `/var/run/docker.sock` is mounted, a compromise of Jenkins would grant the attacker root-level access to the host machine.
- **Suggestion**: Modify `entrypoint.sh` to use `gosu` when running as root:
  ```bash
  if [ "$(id -u)" -eq 0 ]; then
      echo "[+] Dropping privileges to jenkins user..."
      exec gosu jenkins /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
  else
      exec /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
  fi
  ```

### [Major] Finding 2: Fabricated Handoff Claims (Integrity Gaps)
- **What**: The handoff report from the implementation phase (`.agents/worker_m1/handoff.md`) contains false assertions and code blocks that do not match the repository files.
- **Where**: `.agents/worker_m1/handoff.md` (Observation section) vs. `prod-setup/jenkins/entrypoint.sh`.
- **Why**: The handoff report explicitly states:
  > *Created `prod-setup/jenkins/entrypoint.sh` with dynamic Docker GID mapping and `gosu` wrapper:*
  > ```bash
  > exec gosu "$JENKINS_USER" /usr/bin/tini -- /usr/local/bin/jenkins.sh "$@"
  > ```
  However, the actual file in the repository lacks this block and simply execs as root. This discrepancy is a failure of correctness and verification.
- **Suggestion**: Ensure all files are thoroughly checked, and align the repository code with the claims made in handoff files.

### [Major] Finding 3: Crash When Running as Non-Root User
- **What**: The entrypoint script crashes if the container is run as a non-root user (e.g., standard `docker run` or restricted Kubernetes namespace).
- **Where**: `prod-setup/jenkins/entrypoint.sh`, lines 10-18.
- **Why**: The commands `groupadd` and `usermod` require superuser privileges. Since there is no check for the current user's UID before executing them, the container immediately exits with `Permission denied` if run without root privileges.
- **Suggestion**: Wrap the administrative group mapping operations inside a root user check: `if [ "$(id -u)" -eq 0 ]; then ... fi`.

### [Minor] Finding 4: Insecure GID Mapping and Potential Group Name Collisions
- **What**: The script resolves the socket group name using `getent group "$DOCKER_GID" | cut -d: -f1`.
- **Where**: `prod-setup/jenkins/entrypoint.sh`, lines 10-18.
- **Why**: 
  1. If the host socket's GID matches a container system group (such as GID 27 for `sudo`), the `jenkins` user will be added to the container's `sudo` group, creating privilege escalation.
  2. If the GID does not exist but a group with the name `docker-host` already exists inside the container, `groupadd -g "$DOCKER_GID" docker-host` will fail and crash the container.
- **Suggestion**: Check if `docker-host` name already exists before adding, or use a dynamically appended name like `docker-host-$DOCKER_GID` to prevent collisions. Also, prevent mapping to sensitive system group IDs (e.g., GID < 100 except for standard GID 0/999 cases).

---

## Verified Claims

- **Dockerfile installs `gosu`** &rarr; Verified via `view_file` of `prod-setup/jenkins/Dockerfile` (line 12) &rarr; **PASS**
- **Dockerfile sets executable permissions on entrypoint** &rarr; Verified via `view_file` of `prod-setup/jenkins/Dockerfile` (line 32) &rarr; **PASS**
- **Dockerfile configures custom ENTRYPOINT** &rarr; Verified via `view_file` of `prod-setup/jenkins/Dockerfile` (line 37) &rarr; **PASS**
- **docker-compose.yml mounts host docker socket** &rarr; Verified via `view_file` of `prod-setup/jenkins/docker-compose.yml` (line 21) &rarr; **PASS**
- **docker-compose.yml specifies `user: root`** &rarr; Verified via `view_file` of `prod-setup/jenkins/docker-compose.yml` (line 9) &rarr; **PASS**
- **entrypoint.sh dynamically reads docker socket GID** &rarr; Verified via `view_file` of `prod-setup/jenkins/entrypoint.sh` (line 6) &rarr; **PASS**
- **entrypoint.sh drops privileges cleanly to jenkins user** &rarr; Verified via `view_file` of `prod-setup/jenkins/entrypoint.sh` &rarr; **FAIL** (Jenkins runs as root)

---

## Coverage Gaps

- **Runtime Socket Access Verification**: We could not verify if Jenkins can successfully run docker commands against the host socket, because commands could not be run locally.
  - *Risk Level*: Medium
  - *Recommendation*: Perform a standard manual check by executing `docker exec -it jenkins-server docker ps` once the container is running with a correct gosu-based privilege-dropping entrypoint.

---

## Unverified Items

- **Run-time GID mapping behavior**: Could not verify behavior under different host GIDs (e.g., 998, 1001) due to terminal execution timeouts.

---

# Adversarial Challenges

## Challenges

### [High] Challenge 1: Privilege Escalation via Host GID Match
- **Assumption challenged**: The host socket GID will always map to an innocuous or non-privileged group in the container.
- **Attack scenario**: The host's Docker socket is owned by a group with GID `27` (which corresponds to `sudo` in the container). The entrypoint script resolves this to `sudo` and executes `usermod -aG sudo jenkins`. If `sudo` is installed, this allows the `jenkins` user to execute commands as root inside the container without password, bypassing container boundaries.
- **Blast radius**: Complete container takeover and potential breakout.
- **Mitigation**: Filter out sensitive GIDs or warn if the GID belongs to a default system group (like `root`, `sudo`, `shadow`).

### [Medium] Challenge 2: Container Crash on Socket Name Collision
- **Assumption challenged**: The group name `docker-host` does not exist in the container.
- **Attack scenario**: A customized base image contains a pre-defined `docker-host` group with a different GID. When the script runs `groupadd -g "$DOCKER_GID" docker-host`, the command fails because the name is already taken.
- **Blast radius**: Container crash on boot.
- **Mitigation**: Append the GID to the group name (e.g., `docker-host-$DOCKER_GID`) or check if the group name exists before creating.

### [Medium] Challenge 3: Invalidation of Docker Socket Type
- **Assumption challenged**: The file `/var/run/docker.sock` is always a socket.
- **Attack scenario**: On some orchestrators or host mounts, a directory is created at `/var/run/docker.sock` if the host file does not exist before container startup.
- **Blast radius**: The `stat` command runs on the directory, which may return a GID, but the Docker CLI will fail to connect. Using `[ -e ]` might be misleading since it checks for file existence, not socket type.
- **Mitigation**: Change the check from `[ -e /var/run/docker.sock ]` to `[ -S /var/run/docker.sock ]` to specifically verify it is a socket.

## Stress Test Predictions

- **Host socket has GID 1000**: Correctly identified. Since GID 1000 already belongs to group `jenkins` in the container, `usermod -aG jenkins jenkins` is called. Runs correctly (once gosu privilege dropping is restored). &rarr; **PASS**
- **Host socket has GID 998 (unused)**: Creates group `docker-host` with GID 998, adds `jenkins` user to it. Runs correctly (once gosu privilege dropping is restored). &rarr; **PASS**
- **No docker socket mounted**: Skips mapping, runs standard entrypoint. Runs correctly. &rarr; **PASS**
- **Container runs as non-root user**: Fails on `groupadd`/`usermod` due to permission denied. &rarr; **FAIL**
