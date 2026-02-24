# Navigation Fix & Mock Data — Walkthrough

## Changes Made

### Navigation

- Added **"Back to List"** + **"Edit"** buttons to top toolbar on both `IndividualShow` and `JuristicShow` detail pages

### Mock Data Scripts

| Script                                                             | Purpose                                 | Command                                                                                                    |
| ------------------------------------------------------------------ | --------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| [seed-data.sql](file:///d:/GitHub/CIC/scripts/seed-data.sql)       | Insert 9 customers + full sub-resources | `Get-Content scripts/seed-data.sql \| docker exec -i my-postgres-container psql -U postgres -d cic_dev`    |
| [cleanup-data.sql](file:///d:/GitHub/CIC/scripts/cleanup-data.sql) | Remove all seeded data (FK-safe)        | `Get-Content scripts/cleanup-data.sql \| docker exec -i my-postgres-container psql -U postgres -d cic_dev` |

### Seeded Data Summary

| Entity        | Count | Details                              |
| ------------- | ----- | ------------------------------------ |
| Individuals   | 5     | Thai + Japanese names, various tiers |
| Juristic      | 4     | IT, Food, Energy, Trade industries   |
| Addresses     | 10    | Bangkok, Chiang Mai, Tokyo           |
| Identities    | 11    | Passport, National ID, Tax ID        |
| Relationships | 5     | Director, Shareholder, Spouse        |
| Consents      | 12    | Marketing, Analytics, Third-party    |
| Audit Logs    | 15    | CREATE, UPDATE activity history      |

## Files Changed

- [individuals.tsx](file:///d:/GitHub/CIC/react-admin/src/resources/individuals.tsx) — Added `IndividualShowActions` toolbar
- [juristic.tsx](file:///d:/GitHub/CIC/react-admin/src/resources/juristic.tsx) — Added `JuristicShowActions` toolbar
- [seed-data.sql](file:///d:/GitHub/CIC/scripts/seed-data.sql) — **[NEW]**
- [cleanup-data.sql](file:///d:/GitHub/CIC/scripts/cleanup-data.sql) — **[NEW]**

## Verification

- All Go tests pass
- Docker rebuilt, nginx restarted, health: `go-api: healthy`
- Mock data seeded: `INSERT 0 5`, `INSERT 0 4`, `INSERT 0 10`, `INSERT 0 11`, `INSERT 0 5`, `INSERT 0 12`, `INSERT 0 15`
