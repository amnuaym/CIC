# Customer Detail Pages Redesign

## Overview

Rename list menus to "All Individuals" / "All Juristics" and redesign the Show (detail) pages into a **user-friendly card layout** with a transaction history section at the bottom.

## Proposed Changes

### Menu Rename

#### [MODIFY] [App.tsx](file:///d:/GitHub/CIC/react-admin/src/App.tsx)

- `Individuals` → `All Individuals`
- `Juristic` → `All Juristics`

---

### Individual Detail Page

#### [MODIFY] [individuals.tsx](file:///d:/GitHub/CIC/react-admin/src/resources/individuals.tsx)

Replace the current tabbed `IndividualShow` with a single-page card-based layout:

**Top section** — Profile card:

- Name (Title + First + Last), Nationality, DOB, Status badge
- Laid out in a grid, not a form — clean, scannable

**Middle section** — Info cards side-by-side:

- Business Profile card (Membership Tier, CLV, Points, Portfolio)
- Addresses, Identities, Relationships, Consents (collapsed lists)

**Bottom section** — "Recent Activity" (Audit logs filtered by this customer's ID):

- Datagrid showing: Action, Performed By, Timestamp, Changes
- Fetched via `GET /api/v1/audit-logs?entity_id={customer_id}`

---

### Juristic Detail Page

#### [MODIFY] [juristic.tsx](file:///d:/GitHub/CIC/react-admin/src/resources/juristic.tsx)

Same layout pattern as Individual, but with juristic-specific fields:

**Top section** — Company card:

- Company Name, Industry Code, Registration Date, Status badge

**Middle section** — Info cards:

- Business Profile, Addresses, Identities, Related Individuals, Consents

**Bottom section** — "Recent Activity" (same audit log component)

---

### Shared Transaction/Activity Component

#### [NEW] [ActivityLog.tsx](file:///d:/GitHub/CIC/react-admin/src/resources/customers/components/ActivityLog.tsx)

Reusable component fetching audit logs filtered by `entity_id`:

- Uses `useGetList` with filter `{ entity_id: record.id }`
- Displays: Action, Performed By, Date/Time, IP Address, Changes (expandable)

---

### Backend: Audit Log Filtering

#### [MODIFY] [audit_handler.go](file:///d:/GitHub/CIC/go/internal/adapter/handler/audit_handler.go)

- Add `entity_id` query parameter support to `ListAuditLogs`
- Filter SQL: `WHERE entity_id = $1` when provided

## Verification Plan

### Manual Verification

- Rebuild Docker, navigate to Individual detail → verify card layout + activity log
- Navigate to Juristic detail → verify company card + activity log
- Verify menu labels show "All Individuals" / "All Juristics"
