# User Management & RBAC for CIC

## Overview

Add full user management (CRUD) restricted by role, with a proper 4-tier role hierarchy designed for a Customer Information Center.

## Role Hierarchy

| Role            | Code          | Description                                                   |
| --------------- | ------------- | ------------------------------------------------------------- |
| **Super Admin** | `SUPER_ADMIN` | System owner. Full user CRUD + all permissions                |
| **Admin**       | `ADMIN`       | Team lead. Delete/restore customers + view users (read-only)  |
| **Operator**    | `OPERATOR`    | Staff. CRUD customers, consents, relationships. Cannot delete |
| **Viewer**      | `VIEWER`      | Auditor/compliance. Read-only access to all data              |

### Permission Matrix

| Action                             | SUPER_ADMIN | ADMIN | OPERATOR | VIEWER |
| ---------------------------------- | :---------: | :---: | :------: | :----: |
| **Customers** — View               |     ✅      |  ✅   |    ✅    |   ✅   |
| **Customers** — Create/Edit        |     ✅      |  ✅   |    ✅    |   ❌   |
| **Customers** — Delete/Restore     |     ✅      |  ✅   |    ❌    |   ❌   |
| **Customers** — Anonymize          |     ✅      |  ✅   |    ❌    |   ❌   |
| **Consents** — View                |     ✅      |  ✅   |    ✅    |   ✅   |
| **Consents** — Manage              |     ✅      |  ✅   |    ✅    |   ❌   |
| **Audit Logs** — View              |     ✅      |  ✅   |    ✅    |   ✅   |
| **Users** — View list              |     ✅      |  ✅   |    ❌    |   ❌   |
| **Users** — Create/Edit/Deactivate |     ✅      |  ❌   |    ❌    |   ❌   |
| **Users** — Assign roles           |     ✅      |  ❌   |    ❌    |   ❌   |

> [!IMPORTANT]
> **Naming convention**: Uppercase with underscores (`SUPER_ADMIN`, `ADMIN`, `OPERATOR`, `VIEWER`). Stored in the `role` column of the `users` table. Self-registration defaults to `OPERATOR`.

---

## Proposed Changes

### Go Backend — RBAC Middleware

#### [NEW] [rbac.go](file:///d:/GitHub/CIC/go/internal/middleware/rbac.go)

- `RequireRole(roles ...string)` middleware function
- Extracts role from JWT claims, returns 403 if not in allowed list
- Used to guard specific routes

---

### Go Backend — User CRUD Endpoints

#### [MODIFY] [handlers.go](file:///d:/GitHub/CIC/go/internal/api/handlers.go)

- Add `CreateUser`, `UpdateUser`, `DeactivateUser` handler methods
- `CreateUser` — SUPER_ADMIN only, sets role + supervisor_id
- `UpdateUser` — SUPER_ADMIN only, update email/role/supervisor/is_active
- `DeactivateUser` — SUPER_ADMIN only, soft disable (set `is_active = false`)
- Guard existing `ListUsers`/`GetUser` to ADMIN+
- Guard `Register` endpoint — change default role to `OPERATOR`
- Apply `RequireRole` middleware to routes

---

### Go Backend — Route Guards

#### [MODIFY] [handlers.go](file:///d:/GitHub/CIC/go/internal/api/handlers.go) (routes section)

Apply role guards:

```
POST   /api/v1/users          → SUPER_ADMIN only (CreateUser)
PUT    /api/v1/users/{id}     → SUPER_ADMIN only (UpdateUser)
DELETE /api/v1/users/{id}     → SUPER_ADMIN only (DeactivateUser)
GET    /api/v1/users          → ADMIN, SUPER_ADMIN
GET    /api/v1/users/{id}     → ADMIN, SUPER_ADMIN
DELETE /api/v1/customers/{id} → ADMIN, SUPER_ADMIN (already enforced)
```

---

### Frontend — Role-Aware Users Menu

#### [MODIFY] [users.tsx](file:///d:/GitHub/CIC/react-admin/src/resources/users.tsx)

- Add `UserCreate` and `UserEdit` forms (role dropdown, supervisor select, active toggle)
- Only show Create/Edit buttons when logged-in user is `SUPER_ADMIN`

#### [MODIFY] [App.tsx](file:///d:/GitHub/CIC/react-admin/src/App.tsx)

- Conditionally show Users menu based on role (ADMIN+ can see, SUPER_ADMIN gets full CRUD)
- Pass `options` to Resources for role-based visibility

---

### Database Cleanup

#### [MODIFY] [init-db.sql](file:///d:/GitHub/CIC/scripts/init-db.sql)

- Remove `posts` table and its index
- Update default roles to: `SUPER_ADMIN`, `ADMIN`, `OPERATOR`, `VIEWER`
- Add `role` column to users table if missing

#### [NEW] [000003_update_roles.up.sql](file:///d:/GitHub/CIC/go/migrations/000003_update_roles.up.sql)

- Update existing role values: `user` → `OPERATOR`, `admin` → `ADMIN`
- Insert new role seeds if using the junction table approach

---

## Verification Plan

### Automated Tests

- `go test ./...` — all existing + new tests pass
- New test: `TestRequireRole` middleware rejects wrong roles
- New test: `TestCreateUser_SuperAdminOnly` returns 403 for non-SUPER_ADMIN

### Manual Verification

```bash
# Rebuild Docker
docker-compose up -d --build

# Login as SUPER_ADMIN — should see full Users CRUD
# Login as ADMIN — should see Users list (read-only)
# Login as OPERATOR — should NOT see Users menu
# Login as VIEWER — read-only on everything
```
