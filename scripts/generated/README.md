# CAS Oracle-to-PostgreSQL Migration - SQL Scripts Guide

## Overview

This directory contains automatically-generated SQL scripts to migrate the CAS (Core PAS) insurance database from Oracle to PostgreSQL. All scripts are ready to execute directly against a PostgreSQL database server.

## File Structure

```
scripts/generated/
├── 📘 DEPLOYMENT_GUIDE.md          ⭐ Quick reference guide
├── 📘 README.md                    Comprehensive documentation
│
├── 🚀 deploy_cas_schema.sql        Step 1: Database construction (0.75 MB)
├── 🚀 deploy_cas_data.sql          Step 2: Data insertion (15.88 MB)
├── 🚀 deploy_cas_full.sql          Alternative: All-in-one (16.47 MB)
│
├── 📊 cas_app_schema.tables.pg.sql Individual: Tables only (0.71 MB)
├── 📊 cas_app_schema.indexes.pg.sql Individual: Indexes only (0.03 MB)
├── 📊 cas_master_data_inserts.pg.sql Individual: Data only (15.72 MB)
│
├── 🔧 deploy_cas.ps1               PowerShell automation (Windows)
├── 🔧 deploy_cas.sh                Bash automation (Linux/Mac)
│
├── ✅ validate_cas_deployment.sql  Validation queries
└── 🗑️ cleanup_cas_database.sql     Database cleanup (destructive)
```

## Generated Files

### Schema & Data Files (individual components)

1. **cas_app_schema.tables.pg.sql** (747 KB)
   - Contains: 1,340 CREATE TABLE statements
   - All table columns with converted data types
   - Primary keys, constraints, and column definitions
   - Schema: `cas`

2. **cas_app_schema.indexes.pg.sql** (variable size)
   - Contains: 292 CREATE INDEX statements
   - All indexes from Oracle source converted to PostgreSQL syntax
   - Schema-qualified index names
   - Safe to re-run (uses CREATE INDEX IF NOT EXISTS)

3. **cas_master_data_inserts.pg.sql** (16.5 MB)
   - Contains: 80,312+ INSERT statements
   - All master data from Oracle source
   - Values formatted for PostgreSQL
   - Schema-qualified table names (cas.*)

### Comprehensive Deployment Scripts

4. **deploy_cas_schema.sql** ⭐ **RECOMMENDED - STEP 1**
   - Database and schema construction only
   - Creates database, schemas, tables, indexes
   - Creates helper functions and sequences
   - Initializes migration tracking table
   - **Safe to run multiple times** (uses IF NOT EXISTS)
   - Size: ~750 KB

5. **deploy_cas_data.sql** ⭐ **RECOMMENDED - STEP 2**
   - Data insertion only (80,312+ INSERT statements)
   - Requires deploy_cas_schema.sql to be run first
   - All master data from Oracle source
   - Size: ~16 MB

6. **deploy_cas_full.sql** (Alternative - All-in-One)
   - Single comprehensive script combining schema + data
   - Includes everything from schema and data scripts
   - Use this if you prefer a single-file deployment
   - Size: ~16.5 MB

7. **cleanup_cas_database.sql**
   - Drops the entire cas_db database
   - Use to reset/clean up before redeployment
   - **WARNING: Destructive - will delete all data**

6. **validate_cas_deployment.sql**
   - 12 comprehensive validation queries
   - Verifies table counts, indexes, data
   - Checks sizes and sample data
   - Generates deployment checklist
   - Non-destructive (read-only)

## Quick Start Guide

### Option 1: Two-Step Deployment (Recommended)

**Step 1: Deploy Schema**
```bash
# Using psql from command line
psql -U postgres -f scripts/generated/deploy_cas_schema.sql

# Or if you already have a PostgreSQL connection open
\i scripts/generated/deploy_cas_schema.sql
```

**Step 2: Insert Data**
```bash
# Using psql from command line
psql -U postgres -d cas_db -f scripts/generated/deploy_cas_data.sql

# Or if you already have a PostgreSQL connection open
\connect cas_db
\i scripts/generated/deploy_cas_data.sql
```

This two-step approach:
- ✓ Separates structure from data
- ✓ Easier to troubleshoot if issues occur
- ✓ Allows schema modifications before data insertion
- ✓ Can re-run data insertion independently

### Option 2: Single-File Deployment

```bash
# Using psql from command line
psql -U postgres -f scripts/generated/deploy_cas_full.sql

# Or if you already have a PostgreSQL connection open
\i scripts/generated/deploy_cas_full.sql
```

This single-file script will:
- Create `cas_db` database
- Create `cas` and `oracle_compat` schemas
- Create all 1,340 tables
- Create all 292 indexes
- Initialize all 11 sequences
- Deploy helper functions (sysdate, ctl_parm_get_text, etc.)
- Insert all 80,312 master data rows
- Establish migration backlog tracking

### Option 3: Component-by-Component Deployment

If you prefer maximum control over individual components:

```bash
# 1. Create database and schemas (manual - not in individual files)
psql -U postgres -c "CREATE DATABASE cas_db;"
psql -U postgres -d cas_db -c "CREATE SCHEMA cas; CREATE SCHEMA oracle_compat;"

# 2. Deploy tables only
psql -U postgres -d cas_db -f scripts/generated/cas_app_schema.tables.pg.sql

# 3. Deploy indexes
psql -U postgres -d cas_db -f scripts/generated/cas_app_schema.indexes.pg.sql

# 4. Deploy data
psql -U postgres -d cas_db -f scripts/generated/cas_master_data_inserts.pg.sql
```

**Note:** This approach requires manual setup of functions, sequences, and other infrastructure components.

### Option 4: Using PostgreSQL GUI (pgAdmin, DBeaver, etc.)

**For Two-Step Deployment:**
1. Open the SQL editor
2. Copy and execute the entire contents of `deploy_cas_schema.sql`
3. Copy and execute the entire contents of `deploy_cas_data.sql`
4. Monitor for completion

**For Single-File Deployment:**
1. Open the SQL editor
2. Copy the entire contents of `deploy_cas_full.sql`
3. Execute the script
4. Monitor for completion

## Validation

After deployment, verify success:

```bash
psql -U postgres -d cas_db -f scripts/generated/validate_cas_deployment.sql
```

Expected results from validation:
- ✓ 1,340 tables created
- ✓ 292 indexes created
- ✓ 11 sequences initialized
- ✓ Helper functions available
- ✓ 80,312+ data rows inserted

## Using Individual Scripts

### cas_app_schema.tables.pg.sql
Created: Table definitions only
Use when: You want to manage data separately or have pre-existing data

```sql
\set ON_ERROR_STOP on
\connect cas_db
SET search_path TO cas, public;
\i scripts/generated/cas_app_schema.tables.pg.sql
```

### cas_app_schema.indexes.pg.sql
Create: Indexes only (assumes tables already exist)
Use when: You want to defer index creation for performance reasons

```sql
\set ON_ERROR_STOP on
\connect cas_db
SET search_path TO cas, public;
\i scripts/generated/cas_app_schema.indexes.pg.sql
```

### cas_master_data_inserts.pg.sql
Create: INSERT statements only
Use when: Reloading data or running separate from schema creation

```sql
\set ON_ERROR_STOP on
\connect cas_db
SET search_path TO cas, public;
\i scripts/generated/cas_master_data_inserts.pg.sql
```

## Advanced Usage

### Connection String Examples

After deployment, connect using:

**psql (command line):**
```bash
psql -h localhost -U postgres -d cas_db
```

**Python:**
```python
import psycopg2
conn = psycopg2.connect(
    host="localhost",
    database="cas_db",
    user="postgres",
    password="your_password"
)
```

**Node.js:**
```javascript
const { Client } = require('pg');
const client = new Client({
    host: 'localhost',
    database: 'cas_db',
    user: 'postgres',
    password: 'your_password',
    port: 5432,
});
```

**Java (JDBC):**
```
jdbc:postgresql://localhost:5432/cas_db
```

### Working with the CAS Schema

All tables are in the `cas` schema. Set your search_path or qualify table names:

```sql
-- Option 1: Set search_path
SET search_path TO cas, public;
SELECT * FROM tplan_prem_grp_mappings;

-- Option 2: Fully qualify
SELECT * FROM cas.tplan_prem_grp_mappings;
```

### Helper Functions

Several Oracle compatibility functions are included:

```sql
-- Get current timestamp (like Oracle SYSDATE)
SELECT oracle_compat.sysdate();

-- Get CAS system datetime
SELECT cas.get_cas_sys_dt();

-- Get control parameter (text)
SELECT cas.ctl_parm_get_text('PARAMETER_NAME');

-- Get control parameter (numeric)
SELECT cas.ctl_parm_get_num('NUMERIC_PARAM');
```

## Troubleshooting

### Issue: "CREATE DATABASE IF NOT EXISTS" errors

PostgreSQL doesn't support IF NOT EXISTS for CREATE DATABASE directly in transaction blocks.

**Solution:** Use the full `deploy_cas_full.sql` which handles this correctly.

### Issue: psql: FATAL: database "cas_db" does not exist

**Solution:** The database creation step failed. Run:
```bash
psql -U postgres -c "CREATE DATABASE cas_db;"
```

### Issue: Permission denied errors

**Solution:** Ensure your PostgreSQL user has sufficient privileges:
```bash
# Connect as superuser first
psql -U postgres -d cas_db -f scripts/generated/deploy_cas_full.sql
```

### Issue: Encoding errors on INSERT statements

**Solution:** All script files are UTF-8 encoded. Ensure your PostgreSQL database uses UTF-8:
```sql
-- Check encoding
SELECT datname, pg_encoding_to_char(encoding) as encoding FROM pg_database WHERE datname='cas_db';

-- Should show: UTF8
```

## Data Type Mapping Reference

These conversions were applied automatically:

| Oracle Type | PostgreSQL Equivalent |
|-------------|----------------------|
| VARCHAR2(n) | varchar(n) |
| NUMBER(p,s) | numeric(p,s) |
| NUMBER(p) | numeric(p) |
| CLOB | text |
| BLOB | bytea |
| RAW(n) | bytea |
| DATE | timestamp |
| TIMESTAMP | timestamp |
| ROWID | text |
| *SYSDATE* | CURRENT_TIMESTAMP |

## Migration Backlog

Items requiring additional attention are tracked in `cas.oracle_migration_backlog` table:

```sql
SELECT * FROM cas.oracle_migration_backlog;
```

Current items:
- CTL_PARM package - may need refactoring if application calls directly
- PKG_MIT#TH package - conversion pending
- CSMS_PROC_DUMMY synonym - check if procedure redirection needed
- TPLAN_TERM_MAPPINGS - table creation may be prioritized

## Cleanup/Reset

To remove the CAS database (careful!):

```bash
psql -U postgres -f scripts/generated/cleanup_cas_database.sql
```

Or manually:
```bash
psql -U postgres -c "DROP DATABASE IF EXISTS cas_db;"
```

## Performance Tips

1. **Disable indexes during initial load** (if redeploying):
   ```sql
   -- Disable all indexes before large INSERT
   ALTER TABLE cas.large_table DISABLE TRIGGER ALL;
   ```

2. **Create indexes after data load** if performance is critical:
   - Skip the indexes file initially
   - Load data first
   - Run index creation separately

3. **Analyze tables after load:**
   ```sql
   ANALYZE cas;
   ```

## Support & Notes

- All scripts use `SET ON_ERROR_STOP on` for strict error handling
- Scripts are idempotent (safe to run multiple times)
- All tables in `cas` schema, searchable via search_path
- 11 sequences created: acct_link_seq, aex_seq, alpha_search_seq, case_seq, cas_log_id, cli_seq, clm_seq, pol_num_seq, req_num_seq, trxn_num_seq, zap_log_seq

## Generated Information

- **Generation Date:** Generated during Oracle migration
- **Source:** Oracle CAS_App_Schema.sql (30 MB) + CAS master_data_inserts.sql (16 MB)
- **Tables:** 1,340 converted tables
- **Indexes:** 292 converted indexes
- **Data Rows:** 80,312+ inserted
- **Conversion Tool:** PowerShell-based Oracle→PostgreSQL converter

## Next Steps After Deployment

1. ✅ Run validation: `validate_cas_deployment.sql`
2. 🔄 Update application connection strings to PostgreSQL
3. 🧪 Test application functionality
4. 📋 Review and address items in `oracle_migration_backlog` table
5. 🗑️ Decommission Oracle database once validation complete
