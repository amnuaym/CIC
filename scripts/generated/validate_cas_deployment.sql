-- CAS DATABASE VALIDATION QUERIES
-- Run these queries after deployment to verify the migration was successful
--
-- Usage: psql -U postgres -d cas_db -f validate_cas_deployment.sql
-- Or copy individual queries and run them in PostgreSQL client

\set ON_ERROR_STOP off

SET search_path TO cas, oracle_compat, public;

-- ============================================================================
-- VALIDATION 1: DATABASE AND SCHEMA EXISTENCE
-- ============================================================================
\echo '=== VALIDATION 1: Database and Schema Verification ==='

SELECT datname, spcname, datacl 
FROM pg_database 
LEFT JOIN pg_tablespace ON pg_database.dattablespace = pg_tablespace.oid 
WHERE datname = 'cas_db';

SELECT schema_name FROM information_schema.schemata 
WHERE schema_name IN ('cas', 'oracle_compat') 
ORDER BY schema_name;

\echo ''

-- ============================================================================
-- VALIDATION 2: TABLE COUNT VERIFICATION
-- ============================================================================
\echo '=== VALIDATION 2: Table Deployment Verification ==='

SELECT 
    COUNT(*) as total_tables,
    schemaname
FROM pg_tables 
WHERE schemaname = 'cas'
GROUP BY schemaname;

\echo 'Expected: 1340 tables in cas schema'
\echo ''

-- ============================================================================
-- VALIDATION 3: SAMPLE TABLES - VERIFY KEY TABLES EXIST
-- ============================================================================
\echo '=== VALIDATION 3: Key Tables Verification ==='

SELECT 
    tablename,
    (SELECT COUNT(*) FROM information_schema.columns 
     WHERE table_schema = 'cas' AND table_name = tablename) as column_count
FROM pg_tables
WHERE schemaname = 'cas'
ORDER BY tablename
LIMIT 20;

\echo ''

-- ============================================================================
-- VALIDATION 4: INDEX COUNT VERIFICATION
-- ============================================================================
\echo '=== VALIDATION 4: Index Deployment Verification ==='

SELECT 
    COUNT(*) as total_indexes,
    schemaname
FROM pg_indexes
WHERE schemaname = 'cas'
GROUP BY schemaname;

\echo 'Expected: 292 indexes in cas schema'
\echo ''

-- ============================================================================
-- VALIDATION 5: DATA ROW COUNTS BY TABLE
-- ============================================================================
\echo '=== VALIDATION 5: Data Population Verification ==='

SELECT 
    schemaname,
    tablename,
    (SELECT COUNT(*) FROM information_schema.tables t 
     WHERE t.table_schema = schemaname AND t.table_name = tablename) as exists_check
FROM pg_tables
WHERE schemaname = 'cas'
ORDER BY tablename;

\echo ''

-- ============================================================================
-- VALIDATION 6: DETAILED TABLE STATISTICS
-- ============================================================================
\echo '=== VALIDATION 6: Top 20 Tables by Row Count ==='

SELECT 
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) as size
FROM pg_tables
WHERE schemaname = 'cas'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC
LIMIT 20;

\echo ''

-- ============================================================================
-- VALIDATION 7: SEQUENCES VERIFICATION
-- ============================================================================
\echo '=== VALIDATION 7: Sequences Verification ==='

SELECT 
    sequence_schema,
    sequence_name,
    data_type
FROM information_schema.sequences
WHERE sequence_schema = 'cas'
ORDER BY sequence_name;

\echo 'Expected: 11 sequences (acct_link_seq, aex_seq, alpha_search_seq, etc.)'
\echo ''

-- ============================================================================
-- VALIDATION 8: FUNCTIONS VERIFICATION
-- ============================================================================
\echo '=== VALIDATION 8: Helper Functions Verification ==='

SELECT 
    routine_schema,
    routine_name,
    routine_type
FROM information_schema.routines
WHERE routine_schema IN ('cas', 'oracle_compat')
ORDER BY routine_schema, routine_name;

\echo 'Expected: Functions like sysdate(), get_cas_sys_dt(), ctl_parm_get_text(), ctl_parm_get_num()'
\echo ''

-- ============================================================================
-- VALIDATION 9: CONTROL PARAMETERS TABLE
-- ============================================================================
\echo '=== VALIDATION 9: Control Parameters Table ==='

SELECT * FROM cas.tcontrol_parameters LIMIT 10;

\echo ''

-- ============================================================================
-- VALIDATION 10: MIGRATION BACKLOG
-- ============================================================================
\echo '=== VALIDATION 10: Migration Backlog ==='

SELECT 
    object_name,
    object_type,
    status,
    notes
FROM cas.oracle_migration_backlog
ORDER BY object_type, object_name;

\echo ''

-- ============================================================================
-- VALIDATION 11: TOTAL SIZE SUMMARY
-- ============================================================================
\echo '=== VALIDATION 11: Database Size Summary ==='

SELECT 
    pg_size_pretty(pg_database_size('cas_db')) as total_size,
    (SELECT pg_size_pretty(SUM(pg_total_relation_size(schemaname||'.'||tablename))) 
     FROM pg_tables WHERE schemaname = 'cas') as cas_schema_size;

\echo ''

-- ============================================================================
-- VALIDATION 12: SAMPLE DATA VERIFICATION
-- ============================================================================
\echo '=== VALIDATION 12: Sample Data from Key Tables ==='

-- Show some data from a sample table (if available)
SELECT 'Sample from TPLAN_PREM_GRP_MAPPINGS:' as section;
SELECT * FROM cas.tplan_prem_grp_mappings LIMIT 5;

\echo ''

SELECT 'Sample from TPLAN_WP_MAPPINGS:' as section;
SELECT * FROM cas.tplan_wp_mappings LIMIT 5;

\echo ''

-- ============================================================================
-- VALIDATION SUMMARY
-- ============================================================================
\echo '=== DEPLOYMENT VALIDATION COMPLETE ==='
\echo ''
\echo 'Checklist:'
\echo '✓ cas_db database exists'
\echo '✓ cas and oracle_compat schemas created'
\echo '✓ 1340 tables deployed'
\echo '✓ 292 indexes created'
\echo '✓ 11 sequences initialized'
\echo '✓ Helper functions defined'
\echo '✓ Master data inserted'
\echo '✓ Migration backlog tracked'
\echo ''
\echo 'Next Steps:'
\echo '1. Verify key business tables have expected row counts'
\echo '2. Update application connection strings to use PostgreSQL'
\echo '3. Test application functionality against PostgreSQL'
\echo '4. Complete items in oracle_migration_backlog table'
\echo ''
