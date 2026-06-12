# Challenge Report — 2026-06-12T03:40:00Z

## Challenge Summary

**Overall risk assessment**: LOW

The updated deploy scripts and the docker entrypoint alignment logic are highly robust. They properly anticipate common CI/CD failure modes:
1. Missing credentials (`gcp-key.json`), falling back gracefully to ambient service accounts (e.g. GCE instance metadata or environment-configured gcloud).
2. Missing deployments during dry-runs or partial rollouts, bypassing the blocking/failing `kubectl rollout status` checks.
3. Complex Docker socket GID alignment scenarios, handled and tested in `test_entrypoint.py`.

A minor risk remains in `deploy.ps1` if the `kubectl` executable itself is not installed, which would trigger a terminating exception under `$ErrorActionPreference = "Stop"`.

---

## Challenges

### [Low] Challenge 1: PowerShell Terminating Error if `kubectl` is Missing

- **Assumption challenged**: Assumes `kubectl` is always installed in the PATH when running `deploy.ps1`.
- **Attack scenario**: If the deployment script is run in an environment or test stage where `kubectl` is not installed, the expression `$null = kubectl get deployment/... 2>$null` will throw a `CommandNotFoundException`. Under `$ErrorActionPreference = "Stop"`, this terminates the script execution immediately.
- **Blast radius**: The deployment script fails hard on environments lacking `kubectl` rather than logging a clean warning or proceeding.
- **Mitigation**: Use `Get-Command kubectl -ErrorAction SilentlyContinue` to verify the command exists before invoking it, e.g.:
  ```powershell
  if (Get-Command kubectl -ErrorAction SilentlyContinue) {
      $null = kubectl get deployment/cic-api -n cic-prod 2>$null
      if ($LastExitCode -eq 0) {
          kubectl rollout status deployment/cic-api -n cic-prod
      }
  } else {
      Write-Host "[!] Warning: kubectl is not installed. Skipping deployment checks." -ForegroundColor Yellow
  }
  ```

---

## Stress Test Results

- **Scenario 1: `test_entrypoint.py` - Non-root execution (UID 1000)**
  - Expected behavior: Skips GID/socket modification, logs message, invokes standard tini entrypoint.
  - Actual/Predicted behavior: Evaluates `id -u` as 1000, runs else block, drops into `exec /sbin/tini`, runs successfully.
  - Status: **PASS**

- **Scenario 2: `test_entrypoint.py` - Root execution, missing socket**
  - Expected behavior: Prints warning about empty GID/missing socket, drops privileges via gosu, exits 0.
  - Actual/Predicted behavior: GID empty check matches, logs warning, drops privileges via gosu, runs successfully.
  - Status: **PASS**

- **Scenario 3: `test_entrypoint.py` - Root execution, privileged GID < 100**
  - Expected behavior: Detects privileged system GID, skips group creation/addition to prevent privilege escalation, drops privileges, exits 0.
  - Actual/Predicted behavior: Matches GID < 100 check, logs safety skip message, drops privileges, runs successfully.
  - Status: **PASS**

- **Scenario 4: `test_entrypoint.py` - GID collision with system group**
  - Expected behavior: Detects collision, creates a non-unique group `docker-host-<GID>` matching the GID, adds jenkins user to it, drops privileges, exits 0.
  - Actual/Predicted behavior: Matches collision check, runs `groupadd -o -g <GID>`, adds user, runs successfully.
  - Status: **PASS**

- **Scenario 5: `test_entrypoint.py` - Read-only filesystem failure**
  - Expected behavior: Script fails to write `/etc/group`, aborts with non-zero exit code.
  - Actual/Predicted behavior: Mock `groupadd` returns exit code 10, script exits with code 10.
  - Status: **PASS**

- **Scenario 6: `deploy.sh` & `deploy.ps1` - Missing `gcp-key.json`**
  - Expected behavior: Script displays warning and continues deployment with ambient credentials.
  - Actual/Predicted behavior: If check detects key file is missing, skips auth statement, prints warning, and proceeds.
  - Status: **PASS**

- **Scenario 7: `deploy.sh` & `deploy.ps1` - Missing deployments during dry-run**
  - Expected behavior: Bypasses `kubectl rollout status` and prints warnings instead of failing or hanging.
  - Actual/Predicted behavior: `kubectl get` fails, script bypasses `rollout status` checks and completes successfully.
  - Status: **PASS**

---

## Unchallenged Areas

- **GCP API Registry Push Permission and GKE Credentials Fetching** — Out of scope. These depend on external GCP service states and ambient VM metadata permissions, which cannot be simulated locally without live credentials.
