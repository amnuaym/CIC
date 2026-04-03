# CAS Database Deployment - Quick Reference

## Deployment Options

### ⭐ RECOMMENDED: Two-Step Deployment

**When to use:** Most situations - provides better control and easier troubleshooting

**Step 1: Deploy Schema**
```bash
psql -U postgres -f scripts/generated/deploy_cas_schema.sql
```
Creates:
- Database and schemas
- 1,340 tables
- 292 indexes
- 11 sequences
- Helper functions
- Migration tracking table

**Step 2: Insert Data**
```bash
psql -U postgres -d cas_db -f scripts/generated/deploy_cas_data.sql
```
Inserts:
- 80,312+ master data rows

**Advantages:**
- ✓ Easier to troubleshoot if errors occur
- ✓ Can verify schema before loading data
- ✓ Can modify schema or add custom objects before data insertion
- ✓ Can re-run data insertion independently if needed

---

### Alternative: Single-File Deployment

**When to use:** Simple deployments where you want everything in one go

**Command:**
```bash
psql -U postgres -f scripts/generated/deploy_cas_full.sql
```

**What it does:**
- Everything from both schema and data scripts in one execution

---

## Using PowerShell Automation Script (Windows)

### Two-Step Deployment (Default)
```powershell
.\scripts\generated\deploy_cas.ps1
```

### Single-File Deployment
```powershell
.\scripts\generated\deploy_cas.ps1 -SingleFile
```

### Advanced Options
```powershell
# Custom PostgreSQL connection
.\scripts\generated\deploy_cas.ps1 -DbUser myuser -DbHost 192.168.1.100 -DbPort 5433

# Skip validation
.\scripts\generated\deploy_cas.ps1 -SkipValidation

# Force without confirmation
.\scripts\generated\deploy_cas.ps1 -Force
```

---

## File Sizes Reference

| File | Size | Purpose |
|------|------|---------|
| deploy_cas_schema.sql | ~750 KB | Database structure |
| deploy_cas_data.sql | ~16 MB | Master data |
| deploy_cas_full.sql | ~16.5 MB | Complete (schema + data) |

---

## Common Commands

### Connect to Database
```bash
psql -U postgres -d cas_db
```

### Run Validation
```bash
psql -U postgres -d cas_db -f scripts/generated/validate_cas_deployment.sql
```

### Clean Up Database
```bash
psql -U postgres -f scripts/generated/cleanup_cas_database.sql
```

### Check Deployment Status
```sql
-- Connect to cas_db first
\c cas_db

-- Check table count (should be 1340)
SELECT COUNT(*) FROM pg_tables WHERE schemaname = 'cas';

-- Check index count (should be 292)
SELECT COUNT(*) FROM pg_indexes WHERE schemaname = 'cas';

-- Check data in control parameters table
SELECT * FROM cas.tcontrol_parameters;

-- Check migration backlog
SELECT * FROM cas.oracle_migration_backlog;
```

---

## Troubleshooting

### Problem: psql command not found
**Solution:** Add PostgreSQL bin directory to PATH or use full path:
```bash
# Windows (example)
"C:\Program Files\PostgreSQL\15\bin\psql.exe" -U postgres -f deploy_cas_schema.sql

# Linux/Mac
/usr/lib/postgresql/15/bin/psql -U postgres -f deploy_cas_schema.sql
```

### Problem: Database already exists
**Solution:** Either drop the existing database or connect to it:
```bash
# Drop existing (CAUTION: deletes all data)
psql -U postgres -c "DROP DATABASE cas_db;"

# Or skip database creation and just connect
psql -U postgres -d cas_db -f deploy_cas_data.sql
```

### Problem: Schema deployment succeeded but data insertion failed
**Solution:** Re-run only the data insertion script:
```bash
psql -U postgres -d cas_db -f scripts/generated/deploy_cas_data.sql
```

### Problem: Permission denied
**Solution:** Ensure your PostgreSQL user has sufficient privileges:
```bash
# Run as postgres superuser
psql -U postgres -f scripts/generated/deploy_cas_schema.sql
```

---

## Next Steps After Deployment

1. ✅ Run validation script to verify success
2. 🔄 Update application connection strings to point to PostgreSQL
3. 🧪 Test application functionality against new database
4. 📋 Review items in `oracle_migration_backlog` table
5. 🗑️ Decommission Oracle database once fully validated
