# Customer Detail Pages — Walkthrough

## Changes Made

### Menu Labels

- `Individuals` → **All Individuals**
- `Juristic` → **All Juristics**

### Detail Page Layout (Individual & Juristic)

Replaced tabbed `Show` view with single-page card layout:

| Section              | Content                                                     |
| -------------------- | ----------------------------------------------------------- |
| **Profile Header**   | Name/Company, ID, Status badge, key fields in 4-column grid |
| **Action Bar**       | Export Data, Anonymize (PDPA) buttons                       |
| **Business Profile** | Membership, CLV, Points, Portfolio, Preferred Channel       |
| **Addresses**        | Existing `AddressList` in card                              |
| **Identities**       | ID documents card                                           |
| **Relationships**    | Related customers card                                      |
| **Consents (PDPA)**  | Consent records card                                        |
| **Recent Activity**  | Audit log filtered by customer ID (bottom section)          |

### Files Changed

**Backend:**

- [audit_repo.go](file:///d:/GitHub/CIC/go/internal/adapter/repository/audit_repo.go) — Dynamic WHERE clause supporting both `action` and `entity_id` filters
- [audit_handler.go](file:///d:/GitHub/CIC/go/internal/adapter/handler/audit_handler.go) — Added `entity_id` query param

**Frontend:**

- [ActivityLog.tsx](file:///d:/GitHub/CIC/react-admin/src/resources/customers/components/ActivityLog.tsx) — **[NEW]** Shared component with colored action chips
- [individuals.tsx](file:///d:/GitHub/CIC/react-admin/src/resources/individuals.tsx) — Card-based `IndividualShow`
- [juristic.tsx](file:///d:/GitHub/CIC/react-admin/src/resources/juristic.tsx) — Card-based `JuristicShow`
- [App.tsx](file:///d:/GitHub/CIC/react-admin/src/App.tsx) — Menu labels renamed

## Verification

- All Go tests pass (including RBAC middleware tests)
- Docker rebuilt: `cic-api`, `react-admin`, `nginx`, `keycloak` all running
- Health: `go-api: healthy` through nginx
