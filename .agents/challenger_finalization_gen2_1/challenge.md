## Challenge Summary

**Overall risk assessment**: MEDIUM

While the updated deploy scripts (`deploy.sh`, `deploy.ps1`) correctly implement syntax validation, missing GID checks, and rollout status bypass logic, the verification test suite `test_entrypoint.py` contains a critical path resolution bug that prevents the entrypoint tests from running at all.

---

## Challenges

### [High] Challenge 1: Incorrect Path Resolution in `test_entrypoint.py`

- **Assumption challenged**: The test script assumes that `WORKSPACE_DIR` is the repository root when using `parents[2]`.
- **Attack scenario**: `Path(__file__).resolve().parents[2]` points to `D:\Github\cic\prod-setup` instead of the actual repository root `D:\Github\cic`. This causes the script path `ENTRYPOINT_SH` to resolve to `D:\Github\cic\prod-setup\prod-setup\jenkins\entrypoint.sh`. Because this file does not exist, `entrypoint.sh` cannot be loaded, causing all 8 test cases to fail with exit code `-1` and a `FileNotFoundError`.
- **Blast radius**: The validation of the entrypoint group-alignment script is bypassed completely during test execution, which could allow silent permission/escalation regressions.
- **Mitigation**: Update `WORKSPACE_DIR = Path(__file__).resolve().parents[2]` to `WORKSPACE_DIR = Path(__file__).resolve().parents[3]` in `test_entrypoint.py` to resolve the path correctly.

### [Medium] Challenge 2: Potential `$PSNativeCommandUseErrorActionPreference` Failure in `deploy.ps1`

- **Assumption challenged**: The script assumes that a non-zero exit code from `kubectl get` will not terminate the script and will only set `$LastExitCode`.
- **Attack scenario**: In PowerShell (7.3+), if `$PSNativeCommandUseErrorActionPreference` is set to `$true` (either ambiently or via a user profile), a non-zero exit code from `kubectl get` (such as when a deployment is missing) will throw a native command error. Under `$ErrorActionPreference = "Stop"`, this error will terminate the script immediately, preventing it from reaching the `else` block to log a warning and continue.
- **Blast radius**: The deploy script will fail during dry-runs or when deployments are missing, completely breaking the safety bypass logic.
- **Mitigation**: Add `$PSNativeCommandUseErrorActionPreference = $false` at the top of `deploy.ps1`, or wrap `kubectl get` in a `try`/`catch` block.

### [Low] Challenge 3: Windows Bash Dependency for `test_entrypoint.py`

- **Assumption challenged**: The test runner environment on Windows has `bash` installed and in the PATH.
- **Attack scenario**: If `bash` is missing from the environment (e.g., standard CMD/PowerShell without Git Bash or WSL), the tests will silently bypass execution, printing `"Bash not found. Skipping execution test."` and returning `None`.
- **Blast radius**: Tests are skipped silently without a hard error, meaning developer runs might appear to pass but actually did not run.
- **Mitigation**: Print a prominent warning or exit with a non-zero status if `bash` is not found, rather than returning `None` and continuing silently.

---

## Stress Test Results

- **Test 1: Non-root execution in `test_entrypoint.py`**
  - Expected behavior: Runs non-root branch, skips group GID modifications, drops privileges via tini, and returns code 0.
  - Actual/predicted behavior: Returns code `-1` with `FileNotFoundError: [Errno 2] No such file or directory: 'D:\\Github\\cic\\prod-setup\\prod-setup\\jenkins\\entrypoint.sh'`.
  - Result: FAIL

- **Test 2-8: Root execution scenarios in `test_entrypoint.py`**
  - Expected behavior: Runs root alignment checks (handling missing socket, system GIDs, GID collision, non-collision, stat fail, and read-only FS), and returns code 0 (or 10 for read-only FS).
  - Actual/predicted behavior: Returns code `-1` with `FileNotFoundError: [Errno 2] No such file or directory: 'D:\\Github\\cic\\prod-setup\\prod-setup\\jenkins\\entrypoint.sh'`.
  - Result: FAIL

- **Deploy scripts syntax checks**
  - Expected behavior: `deploy.sh` and `deploy.ps1` perform dry-run manifest checks and complete without errors.
  - Actual/predicted behavior: Syntax checks (`kubectl apply --dry-run=client`) run correctly.
  - Result: PASS

- **Missing `gcp-key.json` safety**
  - Expected behavior: Scripts detect missing key, print a warning, and continue.
  - Actual/predicted behavior: Warnings are logged correctly and scripts continue.
  - Result: PASS

- **Missing deployments rollout bypass**
  - Expected behavior: Scripts check if deployments exist, find they do not, log a warning, and bypass `kubectl rollout status` without failing.
  - Actual/predicted behavior: Rollout checks are successfully bypassed.
  - Result: PASS

---

## Unchallenged Areas

- **GCP credentials authenticity** — Checked only file presence and structure; could not verify connection to GKE cluster or Artifact Registry since we lack credentials and active connection.
