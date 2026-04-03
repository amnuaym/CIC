CREATE OR REPLACE PROCEDURE client_consolidate_th(
  pi_cli_num     IN   VARCHAR2 default null
 ,pi_t1_search   IN   VARCHAR2 default null
 ,pi_birth_dt    IN   DATE default null
 ,pi_sex_code    IN   VARCHAR2 default null
)
IS
--------------------------------------------------------------
-- Mod. Date : 28-07-2008
-- Mod. Ref  : MTS000090_YGH
-- Mod. By   : Guan Hong
-- Mod. Desc : 1. To fix the bug where new columns in tcoverages, tcoverage_layers,
--                tclient_bank_accounts, tclient_addresses and tclient_policy_links
--                are not being reflected into the consolidated client record.
--             2. Add new consolidation tables.
--             3. Enable disable constraint during consolidation
--             4. Add trxn histories for each updated policy.
--             5. Due to the disabling and enabling constraint during consolidation, rollback
--                have to be done within the procedure itself.
--------------------------------------------------------------
-- Mod. Date : 20-01-2009
-- Mod. Ref  :  REQ NO. 5201_15
-- Mod. By   : Anchisa V.
-- Mod. Desc : 1. Fix the bug when no  policy found in  TCLIENT_POLICY_LINKS  ,
--               it can not insert  in TTRXN_HISTORIES .
--             2. Fine tune temp table creation to create only those that
--                require inserting into the temp table
--------------------------------------------------------------
--------------------------------------------------------------
-- Mod. By   :	Jerry Gan
-- Mod. Date :	2009-05-05
-- Mod. Ref  :	TH10gDB_Upgrade
-- Mod. Desc :	Add new variable to store the .count value and replace
--              the loop max limit with this new variable.
--------------------------------------------------------------

  CURSOR cco_red
  IS
    SELECT cli_num
    FROM   tclient_details
    WHERE  (   id_num = pi_t1_search
            OR (    cli_nm = pi_t1_search
                AND (   birth_dt = pi_birth_dt
                     OR pi_birth_dt IS NULL)
                AND
                    (   sex_code = pi_sex_code
                     OR pi_sex_code IS NULL
                    )
               )
           )
    AND    (   cli_cnsldt_ind = 'N'
            OR cli_cnsldt_ind IS NULL);


  CURSOR c_bank(pi_cli_cnsldt_num in tclient_details.cli_num%type)
  IS
    SELECT *
    FROM   tclient_bank_accounts
    WHERE  cli_num = pi_cli_cnsldt_num;


  CURSOR c_addr(pi_cli_cnsldt_num in tclient_details.cli_num%type)
  IS
    SELECT *
    FROM   tclient_addresses
    WHERE  cli_num = pi_cli_cnsldt_num;

  CURSOR c_cnsldt_cpl(pi_cli_cnsldt_num in tclient_details.cli_num%type)
  IS
    SELECT *
    FROM   tclient_policy_links
    WHERE  cli_num = pi_cli_cnsldt_num;

  CURSOR c_cli_cnsldt
  IS
    SELECT *
    FROM   tclient_consolidations
    WHERE  cnsldt_dt is null;

  --====================================
  -- Type declaration
  --====================================
  TYPE rec_addr_consolid IS RECORD(
    old_cli_num   tclient_details.cli_num%TYPE
   ,old_addr_typ  tclient_addresses.addr_typ%TYPE
   ,new_addr_typ  tclient_addresses.addr_typ%TYPE
  );

  TYPE rec_bank_consolid IS RECORD(
    old_cli_num   tclient_details.cli_num%TYPE
   ,old_bank_typ  tclient_bank_accounts.bank_acct_typ%TYPE
   ,new_bank_typ  tclient_bank_accounts.bank_acct_typ%TYPE
  );

  TYPE rec_tbl_cnsldt IS RECORD(
     tbl_nm       varchar2(100)
    ,col_nm       varchar2(100)
    ,where_cond   varchar2(1000)
    ,cnsldt_mthd  varchar2(10)
  );

  TYPE rec_pol IS RECORD(
     pol_num   tpolicys.pol_num%TYPE
  );

  TYPE cnsldt_addr_typ IS TABLE OF rec_addr_consolid
    INDEX BY BINARY_INTEGER;

  TYPE cnsldt_bank_typ IS TABLE OF rec_bank_consolid
    INDEX BY BINARY_INTEGER;

  TYPE tbl_cnsldt_typ IS TABLE OF rec_tbl_cnsldt
    INDEX BY BINARY_INTEGER;

  TYPE pol_typ IS TABLE OF rec_pol
    INDEX BY BINARY_INTEGER;


  --====================================
  -- Variable declaration
  --====================================
  pol_tbl                          pol_typ;
  tbl_cnsldt                       tbl_cnsldt_typ;
  cnsldt_addr_tbl                  cnsldt_addr_typ;
  cnsldt_bank_tbl                  cnsldt_bank_typ;

  l_bank_acct_typ                  tclient_bank_accounts.bank_acct_typ%TYPE;
  l_payo_bank_acct_typ             tclient_bank_accounts.bank_acct_typ%TYPE;
  l_addr_typ                       tclient_addresses.addr_typ%TYPE;
  l_xcpt_addr_typ                  tclient_addresses.addr_typ%TYPE;
  l_res_addr_typ                   tclient_addresses.addr_typ%TYPE;
 -- cli_con                          tclient_details.cli_num%TYPE;
  max_bank_acct_typ                tclient_bank_accounts.bank_acct_typ%TYPE;
  max_addr_typ                     tclient_addresses.addr_typ%TYPE;

  curr_bank                        tclient_bank_accounts%ROWTYPE;
  curr_addr                        tclient_addresses%ROWTYPE;
  cur_chg_cpl                      tclient_policy_links%ROWTYPE;
  cli_con                          tclient_consolidations%ROWTYPE;

  cas_dt                           DATE;
  consld                           NUMBER;
  l_idx                            BINARY_INTEGER;
  next_idx                         NUMBER;
  err_upd_consolid_tbl             EXCEPTION;
  chk_pt                           NUMBER;
  l_tbl_cnsldt_cnt                 NUMBER                                     := 0;                 --TH10gDB_Upgrade
  l_cnsldt_addr_tbl_cnt            NUMBER                                     := 0;                 --TH10gDB_Upgrade
  l_cnsldt_bank_tbl_cnt            NUMBER                                     := 0;                 --TH10gDB_Upgrade

  c_err_upd_consolid_tbl           CONSTANT INTEGER                           := 1;
  c_err_value_err                  CONSTANT INTEGER                           := 2;
  c_err_unknown                    CONSTANT INTEGER                           := 99;
  reasn_cd_consldt                 CONSTANT VARCHAR2(3)                       := '200';             -- MTS000090_YGH
  trxn_cd_consldt                  CONSTANT VARCHAR2(6)                       := 'CLICHG';          -- MTS000090_YGH


  --====================================
  -- Function & Procedure declaration
  --====================================
  FUNCTION get_index(
    p_cli_num        VARCHAR2
   ,p_bank_or_addr   VARCHAR2
  )
    RETURN NUMBER
  IS
    j  NUMBER := 0;
    i  NUMBER;
  BEGIN
    IF p_bank_or_addr = 'BANK' THEN
      j := cnsldt_bank_tbl.COUNT +
           1;
      cnsldt_bank_tbl(j).old_cli_num := p_cli_num;
      cnsldt_bank_tbl(j).old_bank_typ := NULL;
      cnsldt_bank_tbl(j).new_bank_typ := NULL;
    ELSIF p_bank_or_addr = 'ADDR' THEN
      j := cnsldt_addr_tbl.COUNT +
           1;
      cnsldt_addr_tbl(j).old_cli_num := p_cli_num;
      cnsldt_addr_tbl(j).old_addr_typ := NULL;
      cnsldt_addr_tbl(j).new_addr_typ := NULL;
    END IF;

    RETURN j;
  END;

  FUNCTION upd_cnsldt_tbl(
    p_ind   NUMBER
   ,p_typ   VARCHAR2
   ,p_old   NUMBER
   ,p_new   NUMBER
  )
    RETURN BOOLEAN
  IS
  BEGIN
    IF     p_typ = 'BANK'
       AND cnsldt_bank_tbl.EXISTS(p_ind) THEN
      cnsldt_bank_tbl(p_ind).old_bank_typ := p_old;
      cnsldt_bank_tbl(p_ind).new_bank_typ := p_new;
      RETURN TRUE;
    ELSIF     p_typ = 'ADDR'
          AND cnsldt_addr_tbl.EXISTS(p_ind) THEN
      cnsldt_addr_tbl(p_ind).old_addr_typ := p_old;
      cnsldt_addr_tbl(p_ind).new_addr_typ := p_new;
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    END IF;
  END;

  FUNCTION GET_HASH_KEY( PI_KEY IN VARCHAR2 )
  RETURN NUMBER
  IS
  BEGIN
      RETURN DBMS_UTILITY.GET_HASH_VALUE ( UPPER ( PI_KEY ), 1, 2147483647 );
  END;

  PROCEDURE add_table ( pi_tbl_nm in varchar2
                       ,pi_cli_col_nm in varchar2 default 'CLI_NUM'
                       ,pi_add_cond in varchar2 default null
                       ,pi_cnsldt_mthd in varchar2 default null)
  IS
    i binary_integer;
  BEGIN
       i := NVL(tbl_cnsldt.LAST,0);
       tbl_cnsldt(i+1).tbl_nm := pi_tbl_nm;
       tbl_cnsldt(i+1).col_nm := pi_cli_col_nm;
       tbl_cnsldt(i+1).where_cond := pi_add_cond;
       tbl_cnsldt(i+1).cnsldt_mthd := pi_cnsldt_mthd;
  END;

  PROCEDURE swap_record( pi_tbl_nm in varchar2
                        ,pi_cli_num in varchar2
                        ,pi_cli_cnsldt_num in varchar2
                        ,pi_cli_col_nm in varchar2
                        ,pi_add_cond in varchar2
                        ,pi_cnsldt_mthd in varchar2 DEFAULT 'UPDATE')
  IS
    l_temp_tbl_nm varchar2(100);
    l_sql         varchar2(8000);
  BEGIN
       --add_error_log_sg('swap record',pi_tbl_nm||' cli '||pi_cli_num);

       l_temp_tbl_nm := 'temp_'||pi_tbl_nm;
       l_sql :=  'begin ';
       if pi_cnsldt_mthd = 'INSERT' then
          l_sql :=  l_sql||'insert into %1 select * from %2 where %4 in (''%6'') %5;'||
                           'update %1 set %4 = ''%3'' where %4 in (''%6'');'||
                           'insert into %2 select * from %1;'||
                           'delete from %1;';
       elsif pi_cnsldt_mthd is null or pi_cnsldt_mthd = 'UPDATE' then
          l_sql :=  l_sql||'update %2 set %4 = ''%3'' where %4 in (''%6'');';
       end if;
       l_sql := l_sql||'end;';

       l_sql := replace(l_sql,'%1',l_temp_tbl_nm);
       l_sql := replace(l_sql,'%2',pi_tbl_nm);
       l_sql := replace(l_sql,'%3',pi_cli_num);
       l_sql := replace(l_sql,'%4',pi_cli_col_nm);
       l_sql := replace(l_sql,'%5',nvl(pi_add_cond,''));
       l_sql := replace(l_sql,'%6',pi_cli_cnsldt_num);

       execute immediate l_sql;
  END;

  PROCEDURE remove_record( pi_tbl_nm in varchar2
                          ,pi_cli_num in varchar2
                          ,pi_cli_cnsldt_num in varchar2
                          ,pi_cli_col_nm in varchar2
                          ,pi_add_cond  in varchar2
                          ,pi_cnsldt_mthd in varchar2 default 'UPDATE')
  IS
    l_sql varchar2(8000);
  BEGIN

    if pi_cnsldt_mthd = 'INSERT' then
      --add_error_log_sg('remove record',pi_tbl_nm||' cli '||pi_cli_num);

      l_sql := 'delete from %1 where %3 in (''%5'') %4';

      l_sql := replace(l_sql,'%1',pi_tbl_nm);
      l_sql := replace(l_sql,'%2',pi_cli_num);
      l_sql := replace(l_sql,'%3',pi_cli_col_nm);
      l_sql := replace(l_sql,'%4',nvl(pi_add_cond,''));
      l_sql := replace(l_sql,'%5',pi_cli_cnsldt_num);
      execute immediate l_sql;
    end if;
  END;

  PROCEDURE create_temp_tbl( pi_tbl_nm in varchar2
                            --,pi_col_nm in varchar2)     --5201_15
                            ,pi_col_nm in varchar2        --5201_15
                            ,pi_cnsldt_mthd in varchar2   --5201_15
                            )                             --5201_15
  IS
    l_sql varchar2(8000);
  BEGIN
    if pi_cnsldt_mthd = 'INSERT' then                     --5201_15
    --add_error_log_sg('create table',pi_tbl_nm);

    l_sql := 'create table temp_%1 as select * from %1 where 1=2';
    l_sql := replace(l_sql,'%1',pi_tbl_nm);
    l_sql := replace(l_sql,'%2',pi_col_nm);
    execute immediate l_sql;
    end if;                                               --5201_15
  END;

  --PROCEDURE drop_temp_tbl( pi_tbl_nm in varchar2)       --5201_15
  PROCEDURE drop_temp_tbl( pi_tbl_nm in varchar2          --5201_15
                         , pi_cnsldt_mthd in varchar2     --5201_15
                         )
  IS
    l_sql varchar2(8000);
  BEGIN
    if pi_cnsldt_mthd = 'INSERT' then                     --5201_15
    --add_error_log_sg('drop table',pi_tbl_nm);

    l_sql := 'drop table temp_%1';
    l_sql := replace(l_sql,'%1',pi_tbl_nm);
    execute immediate l_sql;
    end if;                                               --5201_15
  END;

begin

  chk_pt := 1;
  ctl_parm.get('CAS_DT', cas_dt);
  tbl_cnsldt.delete;
  -- Table having foreign key reference will be using 'INSERT' while child
  -- table will be using 'UPDATE'. Child table is normally placed after the
  -- parent table(s).
  chk_pt := 2;
  add_table(pi_tbl_nm => 'tcoverages',pi_cnsldt_mthd => 'INSERT');
  add_table(pi_tbl_nm => 'tcoverage_layers',pi_cnsldt_mthd => 'INSERT');
  add_table(pi_tbl_nm => 'tcommission_trailers');
  add_table(pi_tbl_nm => 'tclaim_details');
  add_table(pi_tbl_nm => 'tmvy_hist_details');
  add_table(pi_tbl_nm => 'tmedical_payment_headers',pi_cli_col_nm => 'examinee_code');
  add_table(pi_tbl_nm => 'tmedical_payment_payees',pi_cnsldt_mthd => 'INSERT', pi_cli_col_nm => 'payee_code', pi_add_cond => 'AND payee_typ_mp = ''B''');
  add_table(pi_tbl_nm => 'tmedical_payment_details', pi_cli_col_nm => 'payee_code', pi_add_cond => 'AND payee_typ_mp = ''B''');
  add_table(pi_tbl_nm => 'tmedical_payment_dnr', pi_cli_col_nm => 'payee_code', pi_add_cond => 'AND payee_typ_mp = ''B''');
  add_table(pi_tbl_nm => 'tcoverages_info_th');
  add_table(pi_tbl_nm => 'tcoverage_accumulators');
  add_table(pi_tbl_nm => 'tcoverage_extra_prems');
  add_table(pi_tbl_nm => 'tcoverage_oth_insrds');
  add_table(pi_tbl_nm => 'tcoverage_wps');
  add_table(pi_tbl_nm => 'ta02_prem_adj_details');
  add_table(pi_tbl_nm => 'tacct_extracts');
  add_table(pi_tbl_nm => 'tautopay_extract_sg', pi_cli_col_nm => 'owner_cli_num');
  add_table(pi_tbl_nm => 'tavy_accumulators');
  add_table(pi_tbl_nm => 'tcharge_histories');
  add_table(pi_tbl_nm => 'tclaim_treatment_id', pi_cli_col_nm => 'pati_cli_num');
  add_table(pi_tbl_nm => 'tcli_agt_relations');
  add_table(pi_tbl_nm => 'tcli_pol_link_insrd');
  add_table(pi_tbl_nm => 'tcomm_overrides');
  add_table(pi_tbl_nm => 'tcrrs');
  add_table(pi_tbl_nm => 'tdda_setups');
  add_table(pi_tbl_nm => 'tdnr_details');
  add_table(pi_tbl_nm => 'tfund_allocations');
  add_table(pi_tbl_nm => 'tfund_trailers');
  add_table(pi_tbl_nm => 'tfund_trailers_summary');
  add_table(pi_tbl_nm => 'tfund_trxn');
  add_table(pi_tbl_nm => 'ti01_coverage_dscnt_th');
  add_table(pi_tbl_nm => 'tmp_reinst_value');
  add_table(pi_tbl_nm => 'tmvy_ded_details');
  add_table(pi_tbl_nm => 'tpnbtha725_cvg_extra');
  add_table(pi_tbl_nm => 'tpolicys_info_sg', pi_cli_col_nm => 'assignor_cli_num');
  add_table(pi_tbl_nm => 'tpol_replacement_th', pi_cli_col_nm => 'insured_cli_num');
  add_table(pi_tbl_nm => 'tppfala302');
  add_table(pi_tbl_nm => 'tppfala302_db_cr');
  add_table(pi_tbl_nm => 'tprem_ovrid_schedules');
  add_table(pi_tbl_nm => 'tpclala305_cvg');
  add_table(pi_tbl_nm => 'tpclala305_insured', pi_cli_col_nm => 'dp_cli_num');
  add_table(pi_tbl_nm => 'tpclala311');
  add_table(pi_tbl_nm => 'tpclala312');
  add_table(pi_tbl_nm => 'tpclala322_cvg');
  add_table(pi_tbl_nm => 'tpclala322_cvg_wps');
  add_table(pi_tbl_nm => 'tpclala343_cvg_lay');
  add_table(pi_tbl_nm => 'tpclala348');
  add_table(pi_tbl_nm => 'tpclsga306');
  add_table(pi_tbl_nm => 'tpclsga806');

  -- create temporary table has to be done next to avoid committing transaction
  chk_pt := 3;
  l_tbl_cnsldt_cnt := tbl_cnsldt.COUNT;         --TH10gDB_Upgrade
  --FOR i in 1 .. tbl_cnsldt.COUNT              --TH10gDB_Upgrade
  FOR i in 1 .. l_tbl_cnsldt_cnt                --TH10gDB_Upgrade
  LOOP
      create_temp_tbl(tbl_cnsldt(i).tbl_nm
                     --,tbl_cnsldt(i).col_nm); --5201_15
                     ,tbl_cnsldt(i).col_nm     --5201_15
                     ,tbl_cnsldt(i).cnsldt_mthd
                     );                        --5201_15
  END LOOP;

  chk_pt := 4;
  OPEN c_cli_cnsldt;
  LOOP
    FETCH c_cli_cnsldt INTO  cli_con;
    EXIT WHEN c_cli_cnsldt%NOTFOUND;

    chk_pt := 5;
    dbms_output.put_line( chk_pt);
    dbms_output.put_line(pol_tbl.count);
    pol_tbl.delete;
    dbms_output.put_line(pol_tbl.count);
    cnsldt_addr_tbl.DELETE;
    cnsldt_bank_tbl.DELETE;

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

    SELECT MAX(bank_acct_typ)
    INTO   max_bank_acct_typ
    FROM   tclient_bank_accounts
    WHERE  cli_num = cli_con.cli_num;

    chk_pt := 9;

    max_bank_acct_typ := NVL(max_bank_acct_typ, 0);

    SELECT MAX(addr_typ)
    INTO   max_addr_typ
    FROM   tclient_addresses
    WHERE  cli_num = cli_con.cli_num;

    chk_pt := 10;

    max_addr_typ := NVL(max_addr_typ, 0);

    chk_pt := 11;

    FOR curr IN c_bank(cli_con.cli_cnsldt_num)
    LOOP
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
      next_idx := get_index(curr.cli_num, 'BANK');

      IF NOT upd_cnsldt_tbl(next_idx
                           ,'BANK'
                           ,curr.bank_acct_typ
                           ,max_bank_acct_typ
                           ) THEN
        RAISE err_upd_consolid_tbl;
      END IF;
    END LOOP;

    chk_pt := 14;

    FOR curr IN c_addr(cli_con.cli_cnsldt_num)
    LOOP
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
      next_idx := get_index(curr.cli_num, 'ADDR');

      IF NOT upd_cnsldt_tbl(next_idx
                           ,'ADDR'
                           ,curr.addr_typ
                           ,max_addr_typ
                           ) THEN
        RAISE err_upd_consolid_tbl;
      END IF;
    END LOOP;

    chk_pt := 17;

    OPEN c_cnsldt_cpl(cli_con.cli_cnsldt_num);
    LOOP
      FETCH c_cnsldt_cpl INTO  cur_chg_cpl;
      EXIT WHEN c_cnsldt_cpl%NOTFOUND;

      l_cnsldt_addr_tbl_cnt := cnsldt_addr_tbl.COUNT;            --TH10gDB_Upgrade
      --FOR i IN 1 .. cnsldt_addr_tbl.COUNT                      --TH10gDB_Upgrade
      FOR i IN 1 .. l_cnsldt_addr_tbl_cnt                        --TH10gDB_Upgrade
      LOOP
        chk_pt := 18;

        IF cur_chg_cpl.cli_num = cnsldt_addr_tbl(i).old_cli_num THEN
          IF cur_chg_cpl.addr_typ = cnsldt_addr_tbl(i).old_addr_typ THEN
            chk_pt := 19;
            l_addr_typ := cnsldt_addr_tbl(i).new_addr_typ;
          END IF;

          IF cur_chg_cpl.xcpt_addr_typ = cnsldt_addr_tbl(i).old_addr_typ THEN
            chk_pt := 20;
            l_xcpt_addr_typ := cnsldt_addr_tbl(i).new_addr_typ;
          END IF;

          IF cur_chg_cpl.res_addr_typ = cnsldt_addr_tbl(i).old_addr_typ THEN
            chk_pt := 21;
            l_res_addr_typ := cnsldt_addr_tbl(i).new_addr_typ;
          END IF;
        END IF;
      END LOOP;

      l_cnsldt_bank_tbl_cnt := cnsldt_bank_tbl.COUNT;         --TH10gDB_Upgrade
      --FOR i IN 1 .. cnsldt_bank_tbl.COUNT                   --TH10gDB_Upgrade
      FOR i IN 1 .. l_cnsldt_bank_tbl_cnt                     --TH10gDB_Upgrade
      LOOP
        chk_pt := 22;

        IF cur_chg_cpl.cli_num = cnsldt_bank_tbl(i).old_cli_num THEN
          IF cur_chg_cpl.bank_acct_typ = cnsldt_bank_tbl(i).old_bank_typ THEN
            chk_pt := 23;
            l_bank_acct_typ := cnsldt_bank_tbl(i).new_bank_typ;                                                                   -- HK-1998V2-CH06-C.1
          END IF;

          IF cur_chg_cpl.payo_bank_acct_typ = cnsldt_bank_tbl(i).old_bank_typ THEN
            chk_pt := 24;
            l_payo_bank_acct_typ := cnsldt_bank_tbl(i).new_bank_typ;                                                              -- HK-1998V2-CH06-C.1
          END IF;
        END IF;
      END LOOP;

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

      l_idx := get_hash_key(cur_chg_cpl.pol_num);
      if not pol_tbl.exists(l_idx) then
         --add_error_log_sg('',pol_tbl(l_idx).pol_num);
         pol_tbl(l_idx).pol_num := cur_chg_cpl.pol_num;
      end if;
    END LOOP;
    CLOSE c_cnsldt_cpl;

    -- insert record into temporary table
    chk_pt := 27;
    l_tbl_cnsldt_cnt := tbl_cnsldt.COUNT;              --TH10gDB_Upgrade
    --FOR i IN 1 .. tbl_cnsldt.COUNT                   --TH10gDB_Upgrade
    FOR i IN 1 .. l_tbl_cnsldt_cnt                     --TH10gDB_Upgrade
    LOOP
        swap_record(tbl_cnsldt(i).tbl_nm
                   ,cli_con.cli_num
                   ,cli_con.cli_cnsldt_num
                   ,tbl_cnsldt(i).col_nm
                   ,tbl_cnsldt(i).where_cond
                   ,tbl_cnsldt(i).cnsldt_mthd
                   );
    END LOOP;

    -- delete record from original table
    chk_pt := 28;
    l_tbl_cnsldt_cnt := tbl_cnsldt.COUNT;              --TH10gDB_Upgrade
    --FOR i IN 1 .. tbl_cnsldt.COUNT                   --TH10gDB_Upgrade
    FOR i IN 1 .. l_tbl_cnsldt_cnt                     --TH10gDB_Upgrade
    LOOP
        remove_record(tbl_cnsldt(i).tbl_nm
                     ,cli_con.cli_num
                     ,cli_con.cli_cnsldt_num
                     ,tbl_cnsldt(i).col_nm
                     ,tbl_cnsldt(i).where_cond
                     ,tbl_cnsldt(i).cnsldt_mthd
                     );
    END LOOP;

    -- create transaction histories for consolidated policy
    chk_pt := 29;
    dbms_output.put_line(chk_pt);
    dbms_output.put_line(pol_tbl.count);
    l_idx := pol_tbl.first;
    if pol_tbl.exists(l_idx) then -- req no.  5201_15
    loop
        --add_error_log_sg('',l_idx);
        insert_ttrxn_histories(pol_tbl(l_idx).pol_num
                              ,trxn_cd_consldt
                              ,'Client Consolidation - Client number changed from '||cli_con.cli_cnsldt_num||' to '||cli_con.cli_num
                              ,cas_dt
                              ,reasn_cd_consldt
                              );
        exit when l_idx = pol_tbl.last;
        l_idx := pol_tbl.next(l_idx);
    end loop;
    end if;  -- req no.  5201_15
    update tclient_consolidations
    set    cnsldt_dt = cas_dt
    where  cli_num = cli_con.cli_num
    and    cli_cnsldt_num = cli_con.cli_cnsldt_num;

  end loop;
  CLOSE c_cli_cnsldt;

  -- drop temporary table
  chk_pt := 30;
  l_tbl_cnsldt_cnt := tbl_cnsldt.COUNT;            --TH10gDB_Upgrade
  --FOR i in 1 .. tbl_cnsldt.COUNT                 --TH10gDB_Upgrade
  FOR i in 1 .. l_tbl_cnsldt_cnt                   --TH10gDB_Upgrade
  LOOP
      --<< 5201_15
      --drop_temp_tbl(tbl_cnsldt(i).tbl_nm);
      drop_temp_tbl(tbl_cnsldt(i).tbl_nm
                   ,tbl_cnsldt(i).cnsldt_mthd
                   );
      -->> 5201_15
  END LOOP;

  fcn.set_return(0);

EXCEPTION
  WHEN err_upd_consolid_tbl THEN
    rollback;
    fcn.set_return(c_err_upd_consolid_tbl, 0);
    add_error_log_sg('CLIENT_CONSOLIDATE','CHK PT ('||chk_pt||') '||sqlerrm);

    l_tbl_cnsldt_cnt := tbl_cnsldt.COUNT;            --TH10gDB_Upgrade
    --FOR i in 1 .. tbl_cnsldt.COUNT                 --TH10gDB_Upgrade
    FOR i in 1 .. l_tbl_cnsldt_cnt                   --TH10gDB_Upgrade
    LOOP
        --<< 5201_15
      --drop_temp_tbl(tbl_cnsldt(i).tbl_nm);
      drop_temp_tbl(tbl_cnsldt(i).tbl_nm
                   ,tbl_cnsldt(i).cnsldt_mthd
                   );
      -->> 5201_15
    END LOOP;

  WHEN VALUE_ERROR THEN
    rollback;
    fcn.set_return(c_err_value_err, chk_pt);
    add_error_log_sg('CLIENT_CONSOLIDATE','CHK PT ('||chk_pt||') '||sqlerrm);

    l_tbl_cnsldt_cnt := tbl_cnsldt.COUNT;         --TH10gDB_Upgrade
    --FOR i in 1 .. tbl_cnsldt.COUNT              --TH10gDB_Upgrade
    FOR i in 1 .. l_tbl_cnsldt_cnt                --TH10gDB_Upgrade
    LOOP
        --<< 5201_15
      --drop_temp_tbl(tbl_cnsldt(i).tbl_nm);
      drop_temp_tbl(tbl_cnsldt(i).tbl_nm
                   ,tbl_cnsldt(i).cnsldt_mthd
                   );
      -->> 5201_15
    END LOOP;

  WHEN OTHERS THEN
    rollback;
    fcn.set_return(c_err_unknown, chk_pt);
    add_error_log_sg('CLIENT_CONSOLIDATE','CHK PT ('||chk_pt||') '||sqlerrm);

    l_tbl_cnsldt_cnt := tbl_cnsldt.COUNT;         --TH10gDB_Upgrade
    --FOR i in 1 .. tbl_cnsldt.COUNT              --TH10gDB_Upgrade
    FOR i in 1 .. l_tbl_cnsldt_cnt                --TH10gDB_Upgrade
    LOOP
        --<< 5201_15
      --drop_temp_tbl(tbl_cnsldt(i).tbl_nm);
      drop_temp_tbl(tbl_cnsldt(i).tbl_nm
                   ,tbl_cnsldt(i).cnsldt_mthd
                   );
      -->> 5201_15
    END LOOP;

end;
/

prompt
prompt Creating procedure CLR_ORPH_POL
prompt ===============================
prompt
CREATE OR REPLACE PROCEDURE CLR_ORPH_POL (pi_pol_num IN TORPHAN_POLICIES.POL_NUM%TYPE) IS
BEGIN
  DELETE TORPHAN_POLICIES
