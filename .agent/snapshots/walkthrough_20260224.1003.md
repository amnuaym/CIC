# Phase 5–6: Detail Page & Sub-Resource Fixes

## Bug 1: NULL Column Scan (Backend — Phase 5)

**Error:** `sql: Scan error on column "first_name": converting NULL to string is unsupported`

**Root cause:** Juristic customers have NULL `first_name`/`last_name`, Personal have NULL `company_name`. Go's `database/sql` can't scan SQL NULL into plain `string`.

**Fix in** [customer_repo.go](file:///d:/GitHub/CIC/go/internal/adapter/repository/customer_repo.go):

- `GetByID` — all nullable columns now use `sql.NullString`, `sql.NullFloat64`, `sql.NullBool`
- `List`, `ListDeleted`, `Search` — `firstName`, `lastName`, `companyName` use `sql.NullString`

---

## Bug 2: Missing JWT Auth Headers (Frontend — Phase 6)

**Error:** "Error loading addresses/identities/relationships/consents"

**Root cause:** 4 sub-resource components used raw `fetch()` **without** the JWT Authorization header. The Go middleware returned 401 Unauthorized.

**Fixed files:**

| Component                                                                                                         | File                                 |
| ----------------------------------------------------------------------------------------------------------------- | ------------------------------------ |
| [AddressList.tsx](file:///d:/GitHub/CIC/react-admin/src/resources/customers/components/AddressList.tsx)           | Added `Authorization: Bearer` header |
| [IdentityList.tsx](file:///d:/GitHub/CIC/react-admin/src/resources/customers/components/IdentityList.tsx)         | Added `Authorization: Bearer` header |
| [RelationshipList.tsx](file:///d:/GitHub/CIC/react-admin/src/resources/customers/components/RelationshipList.tsx) | Added `Authorization: Bearer` header |
| [ConsentList.tsx](file:///d:/GitHub/CIC/react-admin/src/resources/customers/components/ConsentList.tsx)           | Added `Authorization: Bearer` header |
| [individuals.tsx](file:///d:/GitHub/CIC/react-admin/src/resources/individuals.tsx)                                | AnonymizeButton + ExportDataButton   |
| [juristic.tsx](file:///d:/GitHub/CIC/react-admin/src/resources/juristic.tsx)                                      | AnonymizeButton + ExportDataButton   |

> [!NOTE]
> `ActivityLog.tsx` already had the JWT header — it was the only component that worked correctly before.

---

## Regression Test Results

| Customer     | Detail | Addresses | Identities | Relationships | Consents |
| ------------ | ------ | --------- | ---------- | ------------- | -------- |
| Somchai      | ✅     | ✅ 2      | ✅ 2       | ✅ 3          | ✅ 3     |
| Preecha      | ✅     | ✅ 1      | ✅ 2       | ✅ 1          | ✅ 1     |
| Tanaka       | ✅     | ✅ 2      | ✅ 2       | ✅ 1          | ✅ 3     |
| Siam Digital | ✅     | ✅ 2      | ✅ 1       | ✅ 1          | ✅ 2     |

- **Go tests:** all pass
- **API error logs:** zero errors
- **Audit logs:** 38 entries verified
