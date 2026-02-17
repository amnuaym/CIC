---
description: Create timestamped snapshots of the project artifacts (implementation plan, task list, walkthrough) in the local .agent/snapshots directory.
---

1. Get the current date and time in the format `yyyyMMdd.HHmm` (e.g. using `Get-Date -Format "yyyyMMdd.HHmm"`).
2. Read the following artifacts:
   - `implementation_plan.md`
   - `task.md`
   - `walkthrough.md`
3. Ensure the directory `.agent/snapshots` exists.
4. Create copies of these files with the timestamp appended to the filename (e.g., `.agent/snapshots/implementation_plan_20240101.1200.md`).
5. Write the content to the new files.
6. Notify the user that snapshots have been created in `.agent/snapshots`.
