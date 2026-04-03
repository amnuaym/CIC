-- CAS PostgreSQL bootstrap script
-- Source references:
-- 1) CAS_App_Schema.sql (Oracle DDL, sequences, packages/functions)
-- 2) CAS master_data_inserts.sql (Oracle seed inserts)
--
-- Run with:
--   psql -U postgres -f scripts/init-cas-db-postgres.sql
--
-- Notes:
-- - This script uses psql meta-commands (\gexec, \connect).
-- - Generate full-table and full-insert conversion files first via:
--   powershell -File scripts/convert-cas-oracle-to-postgres.ps1 \
--     -OracleSchemaPath "d:\GitHub\PersonalTech\Insurance\CorePAS\KWI CAS\CAS_App_Schema.sql" \
--     -OracleDataPath "d:\GitHub\PersonalTech\Insurance\CorePAS\KWI CAS\CAS master_data_inserts.sql"
-- - This bootstrap will then include those generated SQL files.

\set ON_ERROR_STOP on

-- 1) Create database if missing.
SELECT 'CREATE DATABASE cas_db TEMPLATE template0 ENCODING ''UTF8''' 
WHERE NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = 'cas_db')
\gexec

\connect cas_db

-- 2) Base schemas and extensions.
CREATE SCHEMA IF NOT EXISTS cas;
CREATE SCHEMA IF NOT EXISTS oracle_compat;

CREATE EXTENSION IF NOT EXISTS pgcrypto;

SET search_path TO cas, public;

-- 2.1) Load converted full schema/data generated from Oracle files.
\ir generated/cas_app_schema.tables.pg.sql
\ir generated/cas_master_data_inserts.pg.sql

-- 3) Oracle compatibility helpers.
CREATE OR REPLACE FUNCTION oracle_compat.sysdate()
RETURNS timestamp
LANGUAGE sql
STABLE
AS $$
    SELECT clock_timestamp();
$$;

CREATE OR REPLACE FUNCTION cas.get_cas_sys_dt()
RETURNS date
LANGUAGE sql
STABLE
AS $$
    -- Placeholder behavior for Oracle GET_CAS_SYS_DT function.
    SELECT CURRENT_DATE;
$$;

-- 4) Minimal parameter store emulating PACKAGE CTL_PARM usage.
CREATE TABLE IF NOT EXISTS cas.tcontrol_parameters (
    parm_typ      varchar(100) NOT NULL,
    crcy_code     varchar(10)  NOT NULL DEFAULT '*',
    plan_code     varchar(50)  NOT NULL DEFAULT '*',
    vers_num      varchar(20)  NOT NULL DEFAULT '*',
    eff_dt        date         NOT NULL DEFAULT DATE '1900-01-01',
    valu_txt      text,
    valu_num      numeric,
    valu_dt       date,
    updated_at    timestamp    NOT NULL DEFAULT clock_timestamp(),
    CONSTRAINT pk_tcontrol_parameters PRIMARY KEY (parm_typ, crcy_code, plan_code, vers_num, eff_dt)
);

CREATE OR REPLACE FUNCTION cas.ctl_parm_get_text(
    pi_parm_typ varchar,
    pi_crcy_code varchar DEFAULT '*',
    pi_plan_code varchar DEFAULT '*',
    pi_vers_num varchar DEFAULT '*',
    pi_eff_dt date DEFAULT CURRENT_DATE
)
RETURNS text
LANGUAGE plpgsql
STABLE
AS $$
DECLARE
    v_result text;
BEGIN
    SELECT cp.valu_txt
      INTO v_result
      FROM cas.tcontrol_parameters cp
     WHERE cp.parm_typ = pi_parm_typ
       AND cp.crcy_code IN (pi_crcy_code, '*')
       AND cp.plan_code IN (pi_plan_code, '*')
       AND cp.vers_num IN (pi_vers_num, '*')
       AND cp.eff_dt <= pi_eff_dt
     ORDER BY
       CASE WHEN cp.crcy_code = pi_crcy_code THEN 0 ELSE 1 END,
       CASE WHEN cp.plan_code = pi_plan_code THEN 0 ELSE 1 END,
       CASE WHEN cp.vers_num = pi_vers_num THEN 0 ELSE 1 END,
       cp.eff_dt DESC
     LIMIT 1;

    RETURN v_result;
END;
$$;

CREATE OR REPLACE FUNCTION cas.ctl_parm_get_num(
    pi_parm_typ varchar,
    pi_crcy_code varchar DEFAULT '*',
    pi_plan_code varchar DEFAULT '*',
    pi_vers_num varchar DEFAULT '*',
    pi_eff_dt date DEFAULT CURRENT_DATE
)
RETURNS numeric
LANGUAGE plpgsql
STABLE
AS $$
DECLARE
    v_result numeric;
BEGIN
    SELECT cp.valu_num
      INTO v_result
      FROM cas.tcontrol_parameters cp
     WHERE cp.parm_typ = pi_parm_typ
       AND cp.crcy_code IN (pi_crcy_code, '*')
       AND cp.plan_code IN (pi_plan_code, '*')
       AND cp.vers_num IN (pi_vers_num, '*')
       AND cp.eff_dt <= pi_eff_dt
     ORDER BY
       CASE WHEN cp.crcy_code = pi_crcy_code THEN 0 ELSE 1 END,
       CASE WHEN cp.plan_code = pi_plan_code THEN 0 ELSE 1 END,
       CASE WHEN cp.vers_num = pi_vers_num THEN 0 ELSE 1 END,
       cp.eff_dt DESC
     LIMIT 1;

    RETURN v_result;
END;
$$;

-- 5) Representative sequence migration from CAS_App_Schema.sql.
-- Oracle sequences with very large maxvalue were adapted to PostgreSQL bigint defaults.
CREATE SEQUENCE IF NOT EXISTS cas.acct_link_seq START 5 INCREMENT 1 MINVALUE 1 CACHE 5 CYCLE;
CREATE SEQUENCE IF NOT EXISTS cas.aex_seq START 21945317 INCREMENT 1 MINVALUE 1 CACHE 20 CYCLE;
CREATE SEQUENCE IF NOT EXISTS cas.alpha_search_seq START 17376 INCREMENT 1 MINVALUE 1 CACHE 20 CYCLE;
CREATE SEQUENCE IF NOT EXISTS cas.case_seq START 1341 INCREMENT 1 MINVALUE 1 NO CYCLE;
CREATE SEQUENCE IF NOT EXISTS cas.cas_log_id START 1 INCREMENT 1 MINVALUE 1 CACHE 20 NO CYCLE;
CREATE SEQUENCE IF NOT EXISTS cas.cli_seq START 44657 INCREMENT 1 MINVALUE 1 NO CYCLE;
CREATE SEQUENCE IF NOT EXISTS cas.clm_seq START 52020 INCREMENT 1 MINVALUE 1 NO CYCLE;
CREATE SEQUENCE IF NOT EXISTS cas.pol_num_seq START 27996 INCREMENT 1 MINVALUE 1 NO CYCLE;
CREATE SEQUENCE IF NOT EXISTS cas.req_num_seq START 10652 INCREMENT 1 MINVALUE 1 NO CYCLE;
CREATE SEQUENCE IF NOT EXISTS cas.trxn_num_seq START 29559 INCREMENT 1 MINVALUE 1 CACHE 20 NO CYCLE;
CREATE SEQUENCE IF NOT EXISTS cas.zap_log_seq START 64450 INCREMENT 1 MINVALUE 1 CACHE 20 CYCLE;


-- 8) Migration tracking table for follow-up object conversion.
CREATE TABLE IF NOT EXISTS cas.oracle_migration_backlog (
    object_name      varchar(256) NOT NULL,
    object_type      varchar(50)  NOT NULL,
    source_file      varchar(512),
    status           varchar(30)  NOT NULL DEFAULT 'pending',
    notes            text,
    created_at       timestamp    NOT NULL DEFAULT clock_timestamp(),
    CONSTRAINT pk_oracle_migration_backlog PRIMARY KEY (object_name, object_type)
);

INSERT INTO cas.oracle_migration_backlog (object_name, object_type, source_file, notes)
VALUES
('CTL_PARM', 'PACKAGE', 'CAS_App_Schema.sql', 'Convert remaining overloaded package procedures to PostgreSQL functions/procedures as needed by application.'),
('PKG_MIT#TH', 'PACKAGE', 'CAS_App_Schema.sql', 'Rebuild package API in schema cas_pkg_mit_th; review all report helper functions and BLOB outputs.'),
('CSMS_PROC_DUMMY', 'SYNONYM', 'CAS_App_Schema.sql', 'Replace synonym with view or search_path strategy.'),
('TPLAN_TERM_MAPPINGS', 'TABLE', 'CAS master_data_inserts.sql', 'Referenced by source script and raised ORA-00942; create and load before dependent data scripts.')
ON CONFLICT DO NOTHING;
