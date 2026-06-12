CREATE OR REPLACE PROCEDURE client_consolidate_th(
  pi_cli_num     IN   text default null
 ,pi_t1_search   IN   text default null
 ,pi_birth_dt    IN   date default null
 ,pi_sex_code    IN   text default null
)
LANGUAGE plpgsql
AS $$
DECLARE
  cas_dt                           date;
  consld                           numeric;
  max_bank_acct_typ                tclient_bank_accounts.bank_acct_typ%TYPE;
  max_addr_typ                     tclient_addresses.addr_typ%TYPE;

  l_addr_typ                       tclient_addresses.addr_typ%TYPE;
  l_xcpt_addr_typ                  tclient_addresses.addr_typ%TYPE;
  l_res_addr_typ                   tclient_addresses.addr_typ%TYPE;
  l_bank_acct_typ                  tclient_bank_accounts.bank_acct_typ%TYPE;
  l_payo_bank_acct_typ             tclient_bank_accounts.bank_acct_typ%TYPE;

  chk_pt                           numeric;
  l_tbl_cnsldt_cnt                 integer := 0;

  c_err_upd_consolid_tbl           constant integer := 1;
  c_err_value_err                  constant integer := 2;
  c_err_unknown                    constant integer := 99;
  reasn_cd_consldt                 constant varchar(3) := '200';
  trxn_cd_consldt                  constant varchar(6) := 'CLICHG';

  err_upd_consolid_tbl             exception;
  r_tbl                            record;
  r_pol                            record;
  curr                             record;
  cur_chg_cpl                      record;
  cli_con                          record;
BEGIN
  chk_pt := 1;
  CALL ctl_parm.get('CAS_DT', cas_dt);

  -- Create a temporary table to hold registered tables for consolidation
  -- This replaces the PL/SQL index-by collection table 'tbl_cnsldt'
  CREATE TEMPORARY TABLE temp_tbl_cnsldt (
      id serial PRIMARY KEY,
      tbl_nm text,
      col_nm text,
      where_cond text,
      cnsldt_mthd text
  ) ON COMMIT DROP;

  -- Create temporary tables for address mapping, bank mapping, and policy numbers
  -- This replaces PL/SQL nested table structures and hash keys
  CREATE TEMPORARY TABLE temp_cnsldt_addr (
      old_cli_num text,
      old_addr_typ integer,
      new_addr_typ integer
  ) ON COMMIT DROP;

  CREATE TEMPORARY TABLE temp_cnsldt_bank (
      old_cli_num text,
      old_bank_typ integer,
      new_bank_typ integer
  ) ON COMMIT DROP;

  CREATE TEMPORARY TABLE temp_pol_tbl (
      pol_num text
  ) ON COMMIT DROP;

  chk_pt := 2;
  -- Register all consolidation tables in insertion order
  INSERT INTO temp_tbl_cnsldt (tbl_nm, col_nm, where_cond, cnsldt_mthd) VALUES
  ('tcoverages', 'cli_num', NULL, 'INSERT'),
  ('tcoverage_layers', 'cli_num', NULL, 'INSERT'),
  ('tcommission_trailers', 'cli_num', NULL, 'UPDATE'),
  ('tclaim_details', 'cli_num', NULL, 'UPDATE'),
  ('tmvy_hist_details', 'cli_num', NULL, 'UPDATE'),
  ('tmedical_payment_headers', 'examinee_code', NULL, 'UPDATE'),
  ('tmedical_payment_payees', 'payee_code', 'AND payee_typ_mp = ''B''', 'INSERT'),
  ('tmedical_payment_details', 'payee_code', 'AND payee_typ_mp = ''B''', 'UPDATE'),
  ('tmedical_payment_dnr', 'payee_code', 'AND payee_typ_mp = ''B''', 'UPDATE'),
  ('tcoverages_info_th', 'cli_num', NULL, 'UPDATE'),
  ('tcoverage_accumulators', 'cli_num', NULL, 'UPDATE'),
  ('tcoverage_extra_prems', 'cli_num', NULL, 'UPDATE'),
  ('tcoverage_oth_insrds', 'cli_num', NULL, 'UPDATE'),
  ('tcoverage_wps', 'cli_num', NULL, 'UPDATE'),
  ('ta02_prem_adj_details', 'cli_num', NULL, 'UPDATE'),
  ('tacct_extracts', 'cli_num', NULL, 'UPDATE'),
  ('tautopay_extract_sg', 'owner_cli_num', NULL, 'UPDATE'),
  ('tavy_accumulators', 'cli_num', NULL, 'UPDATE'),
  ('tcharge_histories', 'cli_num', NULL, 'UPDATE'),
  ('tclaim_treatment_id', 'pati_cli_num', NULL, 'UPDATE'),
  ('tcli_agt_relations', 'cli_num', NULL, 'UPDATE'),
  ('tcli_pol_link_insrd', 'cli_num', NULL, 'UPDATE'),
  ('tcomm_overrides', 'cli_num', NULL, 'UPDATE'),
  ('tcrrs', 'cli_num', NULL, 'UPDATE'),
  ('tdda_setups', 'cli_num', NULL, 'UPDATE'),
  ('tdnr_details', 'cli_num', NULL, 'UPDATE'),
  ('tfund_allocations', 'cli_num', NULL, 'UPDATE'),
  ('tfund_trailers', 'cli_num', NULL, 'UPDATE'),
  ('tfund_trailers_summary', 'cli_num', NULL, 'UPDATE'),
  ('tfund_trxn', 'cli_num', NULL, 'UPDATE'),
  ('ti01_coverage_dscnt_th', 'cli_num', NULL, 'UPDATE'),
  ('tmp_reinst_value', 'cli_num', NULL, 'UPDATE'),
  ('tmvy_ded_details', 'cli_num', NULL, 'UPDATE'),
  ('tpnbtha725_cvg_extra', 'cli_num', NULL, 'UPDATE'),
  ('tpolicys_info_sg', 'assignor_cli_num', NULL, 'UPDATE'),
  ('tpol_replacement_th', 'insured_cli_num', NULL, 'UPDATE'),
  ('tppfala302', 'cli_num', NULL, 'UPDATE'),
  ('tppfala302_db_cr', 'cli_num', NULL, 'UPDATE'),
  ('tprem_ovrid_schedules', 'cli_num', NULL, 'UPDATE'),
  ('tpclala305_cvg', 'cli_num', NULL, 'UPDATE'),
  ('tpclala305_insured', 'dp_cli_num', NULL, 'UPDATE'),
  ('tpclala311', 'cli_num', NULL, 'UPDATE'),
  ('tpclala312', 'cli_num', NULL, 'UPDATE'),
  ('tpclala322_cvg', 'cli_num', NULL, 'UPDATE'),
  ('tpclala322_cvg_wps', 'cli_num', NULL, 'UPDATE'),
  ('tpclala343_cvg_lay', 'cli_num', NULL, 'UPDATE'),
  ('tpclala348', 'cli_num', NULL, 'UPDATE'),
  ('tpclsga306', 'cli_num', NULL, 'UPDATE'),
  ('tpclsga806', 'cli_num', NULL, 'UPDATE');

  -- Create temporary tables for tables using the 'INSERT' method
  chk_pt := 3;
  FOR r_tbl IN SELECT tbl_nm FROM temp_tbl_cnsldt WHERE cnsldt_mthd = 'INSERT' ORDER BY id LOOP
      EXECUTE format('CREATE TEMPORARY TABLE %I AS SELECT * FROM %I WHERE 1=2', 'temp_' || r_tbl.tbl_nm, r_tbl.tbl_nm);
  END LOOP;

  chk_pt := 4;
  -- Batch process all pending consolidations in tclient_consolidations
  FOR cli_con IN SELECT * FROM tclient_consolidations WHERE cnsldt_dt IS NULL LOOP
    chk_pt := 5;
    RAISE NOTICE 'Processing consolidation: cli_num=%, cli_cnsldt_num=%', cli_con.cli_num, cli_con.cli_cnsldt_num;

    -- Reset mappings and policy tracking for the current iteration
    DELETE FROM temp_pol_tbl;
    DELETE FROM temp_cnsldt_addr;
    DELETE FROM temp_cnsldt_bank;

    chk_pt := 6;
    SELECT COUNT(*)
    INTO   consld
    FROM   tclient_consolidations
    WHERE  cli_num = cli_con.cli_num;

    chk_pt := 7;
    UPDATE tclient_details
       SET cli_cnsldt_ind = 'Y'
     WHERE cli_num = cli_con.cli_cnsldt_num;

    chk_pt := 8;
    SELECT COALESCE(MAX(bank_acct_typ), 0)
    INTO   max_bank_acct_typ
    FROM   tclient_bank_accounts
    WHERE  cli_num = cli_con.cli_num;

    chk_pt := 9;
    SELECT COALESCE(MAX(addr_typ), 0)
    INTO   max_addr_typ
    FROM   tclient_addresses
    WHERE  cli_num = cli_con.cli_num;

    chk_pt := 11;
    FOR curr IN SELECT * FROM tclient_bank_accounts WHERE cli_num = cli_con.cli_cnsldt_num LOOP
      max_bank_acct_typ := max_bank_acct_typ + 1;
      chk_pt := 12;

      INSERT INTO tclient_bank_accounts
                  (cli_num
                  ,bank_acct_typ
                  ,bank_cd
                  ,bank_acct_nm
                  ,bank_acct_num
                  ,id_num
                  ,id_typ
                  ,bank_sv_kd
                  ,status
                  ,cpf_inv_acct
                  ,acct_xpry_dt
                  ,card_cat
                  )
           VALUES (cli_con.cli_num
                  ,max_bank_acct_typ
                  ,curr.bank_cd
                  ,curr.bank_acct_nm
                  ,curr.bank_acct_num
                  ,curr.id_num
                  ,curr.id_typ
                  ,curr.bank_sv_kd
                  ,curr.status
                  ,curr.cpf_inv_acct
                  ,curr.acct_xpry_dt
                  ,curr.card_cat
                  );

      chk_pt := 13;
      INSERT INTO temp_cnsldt_bank (old_cli_num, old_bank_typ, new_bank_typ)
      VALUES (curr.cli_num, curr.bank_acct_typ, max_bank_acct_typ);
    END LOOP;

    chk_pt := 14;
    FOR curr IN SELECT * FROM tclient_addresses WHERE cli_num = cli_con.cli_cnsldt_num LOOP
      max_addr_typ := max_addr_typ + 1;
      chk_pt := 15;

      INSERT INTO tclient_addresses
                  (cli_num
                  ,addr_typ
                  ,addr_1
                  ,addr_2
                  ,addr_3
                  ,zip_code
                  ,invalid_addr_ind
                  ,addr_4
                  ,res_code
                  )
           VALUES (cli_con.cli_num
                  ,max_addr_typ
                  ,curr.addr_1
                  ,curr.addr_2
                  ,curr.addr_3
                  ,curr.zip_code
                  ,curr.invalid_addr_ind
                  ,curr.addr_4
                  ,curr.res_code
                  );

      chk_pt := 16;
      INSERT INTO temp_cnsldt_addr (old_cli_num, old_addr_typ, new_addr_typ)
      VALUES (curr.cli_num, curr.addr_typ, max_addr_typ);
    END LOOP;

    chk_pt := 17;
    FOR cur_chg_cpl IN SELECT * FROM tclient_policy_links WHERE cli_num = cli_con.cli_cnsldt_num LOOP
      -- Map address types using COALESCE with subqueries
      chk_pt := 18;
      l_addr_typ := COALESCE((SELECT new_addr_typ FROM temp_cnsldt_addr WHERE old_cli_num = cur_chg_cpl.cli_num AND old_addr_typ = cur_chg_cpl.addr_typ), cur_chg_cpl.addr_typ);
      l_xcpt_addr_typ := COALESCE((SELECT new_addr_typ FROM temp_cnsldt_addr WHERE old_cli_num = cur_chg_cpl.cli_num AND old_addr_typ = cur_chg_cpl.xcpt_addr_typ), cur_chg_cpl.xcpt_addr_typ);
      l_res_addr_typ := COALESCE((SELECT new_addr_typ FROM temp_cnsldt_addr WHERE old_cli_num = cur_chg_cpl.cli_num AND old_addr_typ = cur_chg_cpl.res_addr_typ), cur_chg_cpl.res_addr_typ);

      -- Map bank accounts using COALESCE with subqueries
      chk_pt := 22;
      l_bank_acct_typ := COALESCE((SELECT new_bank_typ FROM temp_cnsldt_bank WHERE old_cli_num = cur_chg_cpl.cli_num AND old_bank_typ = cur_chg_cpl.bank_acct_typ), cur_chg_cpl.bank_acct_typ);
      l_payo_bank_acct_typ := COALESCE((SELECT new_bank_typ FROM temp_cnsldt_bank WHERE old_cli_num = cur_chg_cpl.cli_num AND old_bank_typ = cur_chg_cpl.payo_bank_acct_typ), cur_chg_cpl.payo_bank_acct_typ);

      chk_pt := 25;
      UPDATE tclient_policy_links
         SET cli_num = cli_con.cli_num
            ,addr_typ = l_addr_typ
            ,xcpt_addr_typ = l_xcpt_addr_typ
            ,bank_acct_typ = l_bank_acct_typ
            ,payo_bank_acct_typ = l_payo_bank_acct_typ
            ,res_addr_typ = l_res_addr_typ
       WHERE pol_num = cur_chg_cpl.pol_num
      AND    cli_num = cur_chg_cpl.cli_num
      AND    link_typ = cur_chg_cpl.link_typ;

      chk_pt := 26;
      INSERT INTO temp_pol_tbl (pol_num) VALUES (cur_chg_cpl.pol_num);
    END LOOP;

    -- Swap record logic using dynamic SQL
    chk_pt := 27;
    FOR r_tbl IN SELECT tbl_nm, col_nm, where_cond, cnsldt_mthd FROM temp_tbl_cnsldt ORDER BY id LOOP
        IF r_tbl.cnsldt_mthd = 'INSERT' THEN
            EXECUTE format('INSERT INTO %I SELECT * FROM %I WHERE %I = $1 %s', 'temp_' || r_tbl.tbl_nm, r_tbl.tbl_nm, r_tbl.col_nm, COALESCE(r_tbl.where_cond, '')) USING cli_con.cli_cnsldt_num;
            EXECUTE format('UPDATE %I SET %I = $1 WHERE %I = $2', 'temp_' || r_tbl.tbl_nm, r_tbl.col_nm, r_tbl.col_nm) USING cli_con.cli_num, cli_con.cli_cnsldt_num;
            EXECUTE format('INSERT INTO %I SELECT * FROM %I', r_tbl.tbl_nm, 'temp_' || r_tbl.tbl_nm);
            EXECUTE format('DELETE FROM %I', 'temp_' || r_tbl.tbl_nm);
        ELSE -- default to UPDATE
            EXECUTE format('UPDATE %I SET %I = $1 WHERE %I = $2 %s', r_tbl.tbl_nm, r_tbl.col_nm, r_tbl.col_nm, COALESCE(r_tbl.where_cond, '')) USING cli_con.cli_num, cli_con.cli_cnsldt_num;
        END IF;
    END LOOP;

    -- Delete old records for tables that used 'INSERT' method
    chk_pt := 28;
    FOR r_tbl IN SELECT tbl_nm, col_nm, where_cond, cnsldt_mthd FROM temp_tbl_cnsldt WHERE cnsldt_mthd = 'INSERT' ORDER BY id LOOP
        EXECUTE format('DELETE FROM %I WHERE %I = $1 %s', r_tbl.tbl_nm, r_tbl.col_nm, COALESCE(r_tbl.where_cond, '')) USING cli_con.cli_cnsldt_num;
    END LOOP;

    -- Create transaction histories for consolidated policies (using DISTINCT)
    chk_pt := 29;
    FOR r_pol IN SELECT DISTINCT pol_num FROM temp_pol_tbl LOOP
        CALL insert_ttrxn_histories(
            r_pol.pol_num,
            trxn_cd_consldt,
            'Client Consolidation - Client number changed from ' || cli_con.cli_cnsldt_num || ' to ' || cli_con.cli_num,
            cas_dt,
            reasn_cd_consldt
        );
    END LOOP;

    UPDATE tclient_consolidations
       SET cnsldt_dt = cas_dt
     WHERE cli_num = cli_con.cli_num
       AND cli_cnsldt_num = cli_con.cli_cnsldt_num;
  END LOOP;

  -- Drop temporary tables
  chk_pt := 30;
  FOR r_tbl IN SELECT tbl_nm FROM temp_tbl_cnsldt WHERE cnsldt_mthd = 'INSERT' ORDER BY id LOOP
      EXECUTE format('DROP TABLE IF EXISTS %I', 'temp_' || r_tbl.tbl_nm);
  END LOOP;

  DROP TABLE IF EXISTS temp_tbl_cnsldt;
  DROP TABLE IF EXISTS temp_cnsldt_addr;
  DROP TABLE IF EXISTS temp_cnsldt_bank;
  DROP TABLE IF EXISTS temp_pol_tbl;

  CALL fcn.set_return(0);

EXCEPTION
  WHEN err_upd_consolid_tbl THEN
    CALL fcn.set_return(c_err_upd_consolid_tbl, 0);
    CALL add_error_log_sg('CLIENT_CONSOLIDATE', 'CHK PT (' || chk_pt || ') ' || SQLERRM);
    -- Clean up temporary tables
    FOR r_tbl IN SELECT tbl_nm FROM temp_tbl_cnsldt WHERE cnsldt_mthd = 'INSERT' ORDER BY id LOOP
        EXECUTE format('DROP TABLE IF EXISTS %I', 'temp_' || r_tbl.tbl_nm);
    END LOOP;
    DROP TABLE IF EXISTS temp_tbl_cnsldt;
    DROP TABLE IF EXISTS temp_cnsldt_addr;
    DROP TABLE IF EXISTS temp_cnsldt_bank;
    DROP TABLE IF EXISTS temp_pol_tbl;

  WHEN numeric_value_out_of_range OR string_data_right_truncation OR character_not_in_repertoire OR division_by_zero THEN
    CALL fcn.set_return(c_err_value_err, chk_pt);
    CALL add_error_log_sg('CLIENT_CONSOLIDATE', 'CHK PT (' || chk_pt || ') ' || SQLERRM);
    -- Clean up temporary tables
    FOR r_tbl IN SELECT tbl_nm FROM temp_tbl_cnsldt WHERE cnsldt_mthd = 'INSERT' ORDER BY id LOOP
        EXECUTE format('DROP TABLE IF EXISTS %I', 'temp_' || r_tbl.tbl_nm);
    END LOOP;
    DROP TABLE IF EXISTS temp_tbl_cnsldt;
    DROP TABLE IF EXISTS temp_cnsldt_addr;
    DROP TABLE IF EXISTS temp_cnsldt_bank;
    DROP TABLE IF EXISTS temp_pol_tbl;

  WHEN OTHERS THEN
    CALL fcn.set_return(c_err_unknown, chk_pt);
    CALL add_error_log_sg('CLIENT_CONSOLIDATE', 'CHK PT (' || chk_pt || ') ' || SQLERRM);
    -- Clean up temporary tables
    FOR r_tbl IN SELECT tbl_nm FROM temp_tbl_cnsldt WHERE cnsldt_mthd = 'INSERT' ORDER BY id LOOP
        EXECUTE format('DROP TABLE IF EXISTS %I', 'temp_' || r_tbl.tbl_nm);
    END LOOP;
    DROP TABLE IF EXISTS temp_tbl_cnsldt;
    DROP TABLE IF EXISTS temp_cnsldt_addr;
    DROP TABLE IF EXISTS temp_cnsldt_bank;
    DROP TABLE IF EXISTS temp_pol_tbl;
END;
$$;

-- Complete implementation of CLR_ORPH_POL
CREATE OR REPLACE PROCEDURE clr_orph_pol(pi_pol_num text)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM torphan_policies WHERE pol_num = pi_pol_num;
END;
$$;
