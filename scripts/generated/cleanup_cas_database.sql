-- CAS DATABASE CLEANUP SCRIPT
-- WARNING: This script will DROP all CAS database objects
-- Use with caution - this will delete all data!
--
-- Usage: psql -U postgres -f cleanup_cas_database.sql
-- Or in PostgreSQL shell: \i cleanup_cas_database.sql

\set ON_ERROR_STOP on

-- ============================================================================
-- SECTION 1: DROP ALL TABLE DATA (if you want to keep tables)
-- ============================================================================
-- Uncomment this section if you want to keep the schema but delete all data

/*
SET search_path TO cas, public;

SELECT 'TRUNCATING ' || tablename FROM pg_tables WHERE schemaname = 'cas';

DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'cas')
    LOOP
        EXECUTE 'TRUNCATE TABLE cas.' || quote_ident(r.tablename) || ' CASCADE';
    END LOOP;
END $$;
*/

-- ============================================================================
-- SECTION 2: DROP ENTIRE CAS DATABASE
-- ============================================================================
-- This section drops the entire database with all schemas and objects

-- Disconnect from cas_db first
\connect postgres

-- Drop the database (with CASCADE to remove all objects)
DROP DATABASE IF EXISTS cas_db;

-- ============================================================================
-- OPTIONAL: DROP EXTENSIONS (if they were only used for cas_db)
-- ============================================================================
-- Uncomment if needed:
-- DROP EXTENSION IF EXISTS pgcrypto CASCADE;

-- ============================================================================
-- CLEANUP COMPLETE
-- ============================================================================
-- The cas_db database and all associated schemas, tables, and objects have been removed.
-- To restore, run: psql -f deploy_cas_full.sql
