# CIC — RBAC & User Management Walkthrough

## What Changed

### 4-Tier Role System

| Role          | Capabilities                            |
| ------------- | --------------------------------------- |
| `SUPER_ADMIN` | Full user CRUD + everything             |
| `ADMIN`       | Delete/restore customers, view users    |
| `OPERATOR`    | CRUD customers, consents, relationships |
| `VIEWER`      | Read-only on all data                   |

### Files Changed

**Go Backend:**

- [rbac.go](file:///d:/GitHub/CIC/go/internal/middleware/rbac.go) — `RequireRole()` middleware + role constants
- [rbac_test.go](file:///d:/GitHub/CIC/go/internal/middleware/rbac_test.go) — 4 test cases
- [handlers.go](file:///d:/GitHub/CIC/go/internal/api/handlers.go) — Routes restructured into 4 RBAC tiers, `CreateUser`/`UpdateUser`/`DeactivateUser` added, all Post handlers removed
- [models.go](file:///d:/GitHub/CIC/go/internal/models/models.go) — Post model removed

**Frontend:**

- [users.tsx](file:///d:/GitHub/CIC/react-admin/src/resources/users.tsx) — Full CRUD forms with role dropdown, supervisor selection
- [App.tsx](file:///d:/GitHub/CIC/react-admin/src/App.tsx) — Role-based menu visibility
- [authProvider.ts](file:///d:/GitHub/CIC/react-admin/src/authProvider.ts) — Returns role as permissions

**Database:**

- [000003_update_roles.up.sql](file:///d:/GitHub/CIC/go/migrations/000003_update_roles.up.sql) — Migrates old role values
- [init-db.sql](file:///d:/GitHub/CIC/scripts/init-db.sql) — Posts removed, 4 roles seeded

## Test Results

All Go tests pass:

```
PASS TestRequireRole_AllowsMatchingRole
PASS TestRequireRole_RejectsWrongRole
PASS TestRequireRole_RejectsNoClaims
PASS TestRequireRole_ViewerCannotAccessAdminRoute
```

## Deployment

```
✔ cic-api          Built + Started
✔ react-admin      Built + Started
✔ cic-nginx        Running
✔ Health: go-api healthy
```
