CREATE OR REPLACE PROCEDURE client_consolidate(
  pi_cli_num     IN   VARCHAR2
 ,pi_t1_search   IN   VARCHAR2
 ,pi_birth_dt    IN   DATE
 ,pi_sex_code    IN   VARCHAR2
)
IS
/*----------------------------------------------------------------------------------------
 Modification on 1999-04-27 by Chris Lam
 - Error in overwriting the address type and bank account type in tclient_policy_links
 - Remove the commit statement
 - Remove the rollback statement. The rollback is handled by Form level.
 (HK-1998V2-CH06-C.1)

----------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------
 Modification on 1998-07-31 by Chris Lam
 - The destination client will carry all the addresses and bank accounts of source clients.
   The corresponding records in tclient_policy_links will be updated.
 (HK-1998V2-CH06-C)

----------------------------------------------------------------------------------------*/
--------------------------------------------------------------
-- Mod. Date : 1998-08-25
-- Mod. Desc : HK-1998V2-AC04-C
-- Mod. By   : Albert Lam
-- Mod. Desc : Add new column INIT_CHG_IND to TCOVERAGES
--------------------------------------------------------------
--------------------------------------------------------------
-- Mod. Date : 1998-10-21
-- Mod. Desc : HK-1998V2-hi02-C
-- Mod. By   : Albert Lam
-- Mod. Desc : Add new column prev_dth_bnft_amt to TCOVERAGES
--------------------------------------------------------------
--------------------------------------------------------------
-- Mod. Date : 2000-AUG-09
-- Mod. Ref  : Singapore retrofit
-- Mod. By   : Andrew Lo
-- Mod. Desc : Align to the new structure
--------------------------------------------------------------
--------------------------------------------------------------
-- Mod. Date : 16-NOV-2000
-- Mod. Ref  : SG-UAT20001115-01
-- Mod. By   : Chris Lam
-- Mod. Desc : client consolidation by name only (without sex and birth date)
--------------------------------------------------------------
--------------------------------------------------------------
-- Mod. Date : 31-07-2002
-- Mod. Ref  : SG-RPULII-PROD-003
-- Mod. By   : Gayathri Sreekanth
-- Mod. Desc : client consolidation at tcoverage_layers
--------------------------------------------------------------
--------------------------------------------------------------
-- Mod. Date : 12-02-2004
-- Mod. Ref  : SG20040212
-- Mod. By   : Ray Chow
-- Mod. Desc : update cli_num to tmvy_hist_details when client consolidation
--------------------------------------------------------------
-- Retrofit  : Ivan (NPH20030219/JHSG-retrofit)
-- Mod. Date : 19-FEB-2003
-- Mod. Ref  : NPH20030219
-- Mod. By   : Kim Wong
-- Mod. Desc : Update tcoverage_layers cli_num as well.
--------------------------------------------------------------
-- Retrofit  : Ivan (PH-PRD-20040811/JHSG-retrofit)
-- Mod. Date : 11-08-2004
-- Mod. Ref  : PH-PRD-20040811
-- Mod. By   : Joe Chu
-- Mod. Desc : Avoid duplicate key update in tcoverage_layers
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
                AND                                                                                                               -- SG-UAT20001115-01
                    (   sex_code = pi_sex_code
                     OR pi_sex_code IS NULL
                    )
               )                                                                                                                  -- SG-UAT20001115-01
           -- SG-UAT20001115-01 birth_dt = pi_birth_dt  and
           -- SG-UAT20001115-01 sex_code = pi_sex_code)
           )
    AND    (   cli_cnsldt_ind = 'N'
            OR cli_cnsldt_ind IS NULL);

  cli_con                          tclient_details.cli_num%TYPE;
  cas_dt                           DATE;
  consld                           NUMBER;
  curr_bank                        tclient_bank_accounts%ROWTYPE;
  curr_addr                        tclient_addresses%ROWTYPE;
  l_cnsldt_addr_tbl_cnt            NUMBER                    := 0;    --TH10gDB_Upgrade
  l_cnsldt_bank_tbl_cnt            NUMBER                    := 0;    --TH10gDB_Upgrade
  /***************** HK-1998V2-CH06-C  BEGIN   *******************/
  max_bank_acct_typ                tclient_bank_accounts.bank_acct_typ%TYPE;
  max_addr_typ                     tclient_addresses.addr_typ%TYPE;
  next_idx                         NUMBER;
  err_upd_consolid_tbl             EXCEPTION;
  c_err_upd_consolid_tbl  CONSTANT INTEGER                                    := 1;
  c_err_value_err         CONSTANT INTEGER                                    := 2;
  c_err_unknown           CONSTANT INTEGER                                    := 99;
  cur_chg_cpl                      tclient_policy_links%ROWTYPE;
  chk_pt                           NUMBER                                     := 0;

  /***************** HK-1998V2-CH06-C  END   *******************/
  CURSOR c_bank
  IS
    SELECT *
    FROM   tclient_bank_accounts
    WHERE  cli_num IN(SELECT cli_cnsldt_num
                      FROM   tclient_consolidations
                      WHERE  cli_num = pi_cli_num);

  CURSOR c_addr
  IS
    SELECT *
    FROM   tclient_addresses
    WHERE  cli_num IN(SELECT cli_cnsldt_num
                      FROM   tclient_consolidations
                      WHERE  cli_num = pi_cli_num);

  /***************** HK-1998V2-CH06-C  BEGIN   *******************/
  CURSOR c_cnsldt_cpl
  IS
    SELECT *
    FROM   tclient_policy_links
    WHERE  cli_num IN(SELECT cli_cnsldt_num
                      FROM   tclient_consolidations
                      WHERE  cli_num = pi_cli_num);

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

  TYPE cnsldt_addr_typ IS TABLE OF rec_addr_consolid
    INDEX BY BINARY_INTEGER;

  TYPE cnsldt_bank_typ IS TABLE OF rec_bank_consolid
    INDEX BY BINARY_INTEGER;

  cnsldt_addr_tbl                  cnsldt_addr_typ;
  cnsldt_bank_tbl                  cnsldt_bank_typ;
  l_bank_acct_typ                  tclient_bank_accounts.bank_acct_typ%TYPE;                                                     -- HK-1998V2-CH06-C.1
  l_payo_bank_acct_typ             tclient_bank_accounts.bank_acct_typ%TYPE;                                                     -- HK-1998V2-CH06-C.1
  l_addr_typ                       tclient_addresses.addr_typ%TYPE;                                                              -- HK-1998V2-CH06-C.1
  l_xcpt_addr_typ                  tclient_addresses.addr_typ%TYPE;                                                              -- HK-1998V2-CH06-C.1

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
/*****************  HK-1998V2-CH06-C  END   *******************/
BEGIN
  ctl_parm.get('CAS_DT', cas_dt);
  chk_pt := 1;

  OPEN cco_red;

  LOOP
    FETCH cco_red
    INTO  cli_con;

    EXIT WHEN cco_red%NOTFOUND;

    IF pi_cli_num <> cli_con THEN
      INSERT INTO tclient_consolidations
           VALUES (pi_cli_num
                  ,cli_con
                  ,cas_dt
                  ,'A'
                  );
    -- commit; -- HK-1998V2-CH06-C.1
    END IF;
  END LOOP;

  CLOSE cco_red;

  SELECT COUNT(*)
  INTO   consld
  FROM   tclient_consolidations
  WHERE  cli_num = pi_cli_num;

  chk_pt := 2;

  UPDATE tclient_details
     SET cli_cnsldt_ind = 'Y'
   WHERE cli_num IN(SELECT cli_cnsldt_num
                    FROM   tclient_consolidations
                    WHERE  cli_num = pi_cli_num);

  chk_pt := 3;

  /*****************  HK-1998V2-CH06-C  Comment    BEGIN    *******************/
  /*
   select count(*) into consld_bank
   from tclient_bank_accounts
   where cli_num=pi_cli_num;
   if consld_bank = 0 then
                           OPEN c_bank;
                           LOOP
                            FETCH c_bank INTO curr_bank ;
                        IF  c_bank%NOTFOUND THEN EXIT;
                       ELSE
                                     insert into tclient_bank_accounts
                                       (cli_num,
                                        bank_acct_typ,
                                        bank_cd,
                                        bank_acct_nm,
                                        bank_acct_num,
                                                    id_num,
                                                    id_typ,
                    bank_sv_kd)
                              values
                                 (pi_cli_num,
                                    curr_bank.bank_acct_typ,
                                  curr_bank.bank_cd,
                                  curr_bank.bank_acct_nm,
                                  curr_bank.bank_acct_num,
                                              curr_bank.id_num,
                                              curr_bank.id_typ,
                                              curr_bank.bank_sv_kd
                                              );
              exit;
                               end if;
           END LOOP ;
                           CLOSE c_bank;

  end if;

  -- Man 05/25/98 handling Addresses <<start>>
   select count(*) into consld_addr
   from tclient_addresses
   where cli_num = pi_cli_num;

   if consld_addr = 0 then
                           OPEN c_addr;
                           LOOP
                            FETCH c_addr INTO curr_addr ;
                        IF  c_addr%NOTFOUND THEN EXIT;
                       ELSE
                                     insert into tclient_addresses
                                       (cli_num,
                                        addr_typ,
                                        addr_1,
                                        addr_2,
                                        addr_3,
                                                      zip_code,
                  invalid_addr_ind)
                              values
                                 (pi_cli_num,
                                    curr_addr.addr_typ,
                                  curr_addr.addr_1,
                                  curr_addr.addr_2,
                                  curr_addr.addr_3,
                                                curr_addr.zip_code,
                                                curr_addr.invalid_addr_ind
                                              );
              exit;
                               end if;
           END LOOP ;
                           CLOSE c_addr;

   end if;
  --- man 05/25/98 <<End>>
  /*****************  HK-1998V2-CH06-C  Comment    END    *******************/

  /***************** HK-1998V2-CH06-C  BEGIN   *******************/
  SELECT MAX(bank_acct_typ)
  INTO   max_bank_acct_typ
  FROM   tclient_bank_accounts
  WHERE  cli_num = pi_cli_num;

  chk_pt := 4;
  max_bank_acct_typ := NVL(max_bank_acct_typ, 0);

  SELECT MAX(addr_typ)
  INTO   max_addr_typ
  FROM   tclient_addresses
  WHERE  cli_num = pi_cli_num;

  chk_pt := 5;
  max_addr_typ := NVL(max_addr_typ, 0);
  cnsldt_addr_tbl.DELETE;
  cnsldt_bank_tbl.DELETE;
  chk_pt := 6;

  FOR curr IN c_bank
  LOOP
    max_bank_acct_typ := max_bank_acct_typ +
                         1;
    chk_pt := 7;

    INSERT INTO tclient_bank_accounts
                (cli_num
                ,bank_acct_typ
                ,bank_cd
                ,bank_acct_nm
                ,bank_acct_num
                ,id_num
                ,id_typ
                ,bank_sv_kd
                )
         VALUES (pi_cli_num
                ,max_bank_acct_typ
                ,curr.bank_cd
                ,curr.bank_acct_nm
                ,curr.bank_acct_num
                ,curr.id_num
                ,curr.id_typ
                ,curr.bank_sv_kd
                );

    chk_pt := 8;
    next_idx := get_index(curr.cli_num, 'BANK');

    IF NOT upd_cnsldt_tbl(next_idx
                         ,'BANK'
                         ,curr.bank_acct_typ
                         ,max_bank_acct_typ
                         ) THEN
      RAISE err_upd_consolid_tbl;
    END IF;
  END LOOP;

  chk_pt := 9;

  FOR curr IN c_addr
  LOOP
    max_addr_typ := max_addr_typ +
                    1;
    chk_pt := 10;

    INSERT INTO tclient_addresses
                (cli_num
                ,addr_typ
                ,addr_1
                ,addr_2
                ,addr_3
                ,zip_code
                ,invalid_addr_ind
                )
         VALUES (pi_cli_num
                ,max_addr_typ
                ,curr.addr_1
                ,curr.addr_2
                ,curr.addr_3
                ,curr.zip_code
                ,curr.invalid_addr_ind
                );

    chk_pt := 10;
    next_idx := get_index(curr.cli_num, 'ADDR');

    IF NOT upd_cnsldt_tbl(next_idx
                         ,'ADDR'
                         ,curr.addr_typ
                         ,max_addr_typ
                         ) THEN
      RAISE err_upd_consolid_tbl;
    END IF;
  END LOOP;

  chk_pt := 11;

  OPEN c_cnsldt_cpl;

  LOOP
    FETCH c_cnsldt_cpl
    INTO  cur_chg_cpl;

    EXIT WHEN c_cnsldt_cpl%NOTFOUND;

    l_cnsldt_addr_tbl_cnt := cnsldt_addr_tbl.COUNT;    --TH10gDB_Upgrade
    --FOR i IN 1 .. cnsldt_addr_tbl.COUNT              --TH10gDB_Upgrade
    FOR i IN 1 .. l_cnsldt_addr_tbl_cnt                --TH10gDB_Upgrade
    LOOP
      chk_pt := 12;

      IF cur_chg_cpl.cli_num = cnsldt_addr_tbl(i).old_cli_num THEN
        IF cur_chg_cpl.addr_typ = cnsldt_addr_tbl(i).old_addr_typ THEN
          chk_pt := 13;
          -- cur_chg_cpl.addr_typ := cnsldt_addr_tbl(i).new_addr_typ;
          l_addr_typ := cnsldt_addr_tbl(i).new_addr_typ;
        END IF;

        IF cur_chg_cpl.xcpt_addr_typ = cnsldt_addr_tbl(i).old_addr_typ THEN
          chk_pt := 14;
          -- cur_chg_cpl.xcpt_addr_typ := cnsldt_addr_tbl(i).new_addr_typ;
          l_xcpt_addr_typ := cnsldt_addr_tbl(i).new_addr_typ;
        END IF;
      END IF;
    END LOOP;

    l_cnsldt_bank_tbl_cnt := cnsldt_bank_tbl.COUNT;    --TH10gDB_Upgrade
    --FOR i IN 1 .. cnsldt_bank_tbl.COUNT              --TH10gDB_Upgrade
    FOR i IN 1 .. l_cnsldt_bank_tbl_cnt                --TH10gDB_Upgrade
    LOOP
      chk_pt := 15;

      IF cur_chg_cpl.cli_num = cnsldt_bank_tbl(i).old_cli_num THEN
        IF cur_chg_cpl.bank_acct_typ = cnsldt_bank_tbl(i).old_bank_typ THEN
          chk_pt := 16;
          -- cur_chg_cpl.bank_acct_typ := cnsldt_bank_tbl(i).new_bank_typ;-- HK-1998V2-CH06-C.1
          l_bank_acct_typ := cnsldt_bank_tbl(i).new_bank_typ;                                                                   -- HK-1998V2-CH06-C.1
        END IF;

        IF cur_chg_cpl.payo_bank_acct_typ = cnsldt_bank_tbl(i).old_bank_typ THEN
          chk_pt := 17;
          -- cur_chg_cpl.payo_bank_acct_typ := cnsldt_bank_tbl(i).new_bank_typ;-- HK-1998V2-CH06-C.1
          l_payo_bank_acct_typ := cnsldt_bank_tbl(i).new_bank_typ;                                                              -- HK-1998V2-CH06-C.1
        END IF;
      END IF;
    END LOOP;

    chk_pt := 18;

    /*************** begin  HK-1998V2-CH06-C.1 **********************/
        --  update tclient_policy_links
        --     set cli_num = pi_cli_num,
        --       addr_typ = cur_chg_cpl.addr_typ,
        --       xcpt_addr_typ = cur_chg_cpl.xcpt_addr_typ,
        --       bank_acct_typ = cur_chg_cpl.bank_acct_typ,
        --       payo_bank_acct_typ = cur_chg_cpl.payo_bank_acct_typ
        --   where pol_num = cur_chg_cpl.pol_num and
        --         cli_num = cur_chg_cpl.cli_num and
        --         link_typ = cur_chg_cpl.link_typ;
    UPDATE tclient_policy_links
       SET cli_num = pi_cli_num
          ,addr_typ = l_addr_typ
          ,xcpt_addr_typ = l_xcpt_addr_typ
          ,bank_acct_typ = l_bank_acct_typ
          ,payo_bank_acct_typ = l_payo_bank_acct_typ
     WHERE pol_num = cur_chg_cpl.pol_num
    AND    cli_num = cur_chg_cpl.cli_num
    AND    link_typ = cur_chg_cpl.link_typ;

    /*************** End  HK-1998V2-CH06-C.1 **********************/
    chk_pt := 19;
  END LOOP;

  /***************** HK-1998V2-CH06-C  END   *******************/

  /***************** HK-1998V2-CH06-C  Comment   BEGIN   *******************/
  /*
    update tclient_policy_links
       set cli_num=pi_cli_num
     where cli_num in (select cli_cnsldt_num
                         from tclient_consolidations
                        where cli_num=pi_cli_num);
  */
  /***************** HK-1998V2-CH06-C  Comment   END   *******************/
  chk_pt := 20;

  INSERT INTO tcoverages
              (pol_num
              ,cli_num
              ,plan_code
              ,vers_num
              ,cvg_eff_dt
              ,cvg_typ
              ,cvg_reasn
              ,occp_clas
              ,par_code
              ,bnft_dur
              ,prem_dur
              ,pua_tot_amt
              ,rel_to_insrd
              ,smkr_code
              ,sex_code
              ,cvg_prem
              ,cvg_stat_cd
              ,comm_ctl
              ,comm_vers
              ,cvg_clas
              ,dscnt_pct
              ,dscnt_prem
              ,dth_bnft_amt
              ,face_amt
              ,band_face_amt
              ,face_ratg
              ,ins_typ
              ,cvg_eff_age
              ,cvg_iss_dt
              ,xpry_dt
              ,nyr_cvg_prem
              ,nyr_dscnt_prem
              ,pua_crnt_amt
              ,prem_vers
              ,pol_val_vers
              ,prem_ovrid_end_date
              ,div_crnt_amt
              ,joint_cli_num
              ,joint_rel_insrd
              ,temp_flat_dur
              ,temp_flat_unit_prem
              ,temp_flat_prem
              ,perm_flat_unit_prem
              ,perm_flat_prem
              ,temp_mort_dur
              ,temp_mort_unit_prem
              ,temp_mort_prem
              ,perm_mort_unit_prem
              ,perm_mort_prem
              ,eti_endow
              ,xtra_cat_cd
              ,perm_mort_ratg
              ,temp_mort_ratg
              ,cvg_del_dt
              ,adj_prem
              ,adj_start_dt
              ,adj_end_dt
              ,nxt_eff_cvg_prem
              ,nxt_eff_dscnt_prem
              ,init_chg_ind                                                                                                        -- HK-1998V2-AC04-C
              ,prev_dth_bnft_amt                                                                                                   -- HK-1998V2-HI02-C
              ,ctr_prem                                                                                                            -- HK-1998V2-PM01-C
              ,nxt_eff_ctr_prem
              ,                                                                                                                    -- HK-1998V2-PM01-C
               risk_prem
              ,                                                                                                                  -- Singapore retrofit
               cntr_price
              ,                                                                                                                  -- Singapore retrofit
               adj_prem_pct
              ,                                                                                                                  -- Singapore retrofit
               int_rt
              ,                                                                                                                  -- Singapore retrofit
               nyr_wp_prem
              ,                                                                                                                  -- Singapore retrofit
               wp_eff_age
              ,                                                                                                                  -- Singapore retrofit
               wp_eff_dt
              ,                                                                                                                  -- Singapore retrofit
               wp_option
              ,                                                                                                                  -- Singapore retrofit
               wp_prem
              ,                                                                                                                  -- Singapore retrofit
               wp_prem_age_basis
              ,                                                                                                                  -- Singapore retrofit
               wp_prem_vers
              ,                                                                                                                  -- Singapore retrofit
               orig_face_amt
              ,                                                                                                                  -- Singapore retrofit
               orig_death_bnft
              ,                                                                                                                  -- Singapore retrofit
               orig_pua_amt
              ,                                                                                                                  -- Singapore retrofit
               joint_cli_eff_age
              ,                                                                                                                  -- Singapore retrofit
               substd_cd                                                                                                         -- Singapore retrofit
              )
    SELECT pol_num
          ,pi_cli_num
          ,plan_code
          ,vers_num
          ,cvg_eff_dt
          ,cvg_typ
          ,cvg_reasn
          ,occp_clas
          ,par_code
          ,bnft_dur
          ,prem_dur
          ,pua_tot_amt
          ,rel_to_insrd
          ,smkr_code
          ,sex_code
          ,cvg_prem
          ,cvg_stat_cd
          ,comm_ctl
          ,comm_vers
          ,cvg_clas
          ,dscnt_pct
          ,dscnt_prem
          ,dth_bnft_amt
          ,face_amt
          ,band_face_amt
          ,face_ratg
          ,ins_typ
          ,cvg_eff_age
          ,cvg_iss_dt
          ,xpry_dt
          ,nyr_cvg_prem
          ,nyr_dscnt_prem
          ,pua_crnt_amt
          ,prem_vers
          ,pol_val_vers
          ,prem_ovrid_end_date
          ,div_crnt_amt
          ,joint_cli_num
          ,joint_rel_insrd
          ,temp_flat_dur
          ,temp_flat_unit_prem
          ,temp_flat_prem
          ,perm_flat_unit_prem
          ,perm_flat_prem
          ,temp_mort_dur
          ,temp_mort_unit_prem
          ,temp_mort_prem
          ,perm_mort_unit_prem
          ,perm_mort_prem
          ,eti_endow
          ,xtra_cat_cd
          ,perm_mort_ratg
          ,temp_mort_ratg
          ,cvg_del_dt
          ,adj_prem
          ,adj_start_dt
          ,adj_end_dt
          ,nxt_eff_cvg_prem
          ,nxt_eff_dscnt_prem
          ,init_chg_ind                                                                                                            -- HK-1998V2-AC04-C
          ,prev_dth_bnft_amt                                                                                                       -- HK-1998V2-HI02-C
          ,ctr_prem                                                                                                                -- HK-1998V2-PM01-C
          ,nxt_eff_ctr_prem
          ,                                                                                                                        -- HK-1998V2-PM01-C
           risk_prem
          ,                                                                                                                      -- Singapore retrofit
           cntr_price
          ,                                                                                                                      -- Singapore retrofit
           adj_prem_pct
          ,                                                                                                                      -- Singapore retrofit
           int_rt
          ,                                                                                                                      -- Singapore retrofit
           nyr_wp_prem
          ,                                                                                                                      -- Singapore retrofit
           wp_eff_age
          ,                                                                                                                      -- Singapore retrofit
           wp_eff_dt
          ,                                                                                                                      -- Singapore retrofit
           wp_option
          ,                                                                                                                      -- Singapore retrofit
           wp_prem
          ,                                                                                                                      -- Singapore retrofit
           wp_prem_age_basis
          ,                                                                                                                      -- Singapore retrofit
           wp_prem_vers
          ,                                                                                                                      -- Singapore retrofit
           orig_face_amt
          ,                                                                                                                      -- Singapore retrofit
           orig_death_bnft
          ,                                                                                                                      -- Singapore retrofit
           orig_pua_amt
          ,                                                                                                                      -- Singapore retrofit
           joint_cli_eff_age
          ,                                                                                                                      -- Singapore retrofit
           substd_cd                                                                                                             -- Singapore retrofit
    FROM   tcoverages
    WHERE  cli_num IN(SELECT cli_cnsldt_num
                      FROM   tclient_consolidations
                      WHERE  cli_num = pi_cli_num);

  chk_pt := 21;

  -- HK-1998V2-CH06-C add the fields ADJ_PREM,ADJ_START_DT,ADJ_END_DT,NXT_EFF_CVG_PREM,NXT_EFF_DSCNT_PREM
  -- in the insert tcoverages statement
     -- SG-RPULII-PROD-003
  INSERT INTO tcoverage_layers
              (pol_num
              ,cli_num
              ,plan_code
              ,vers_num
              ,cvg_eff_dt
              ,layer_eff_dt
              ,stat_cd
              ,layer_prem
              ,layer_dscnt_prem
              ,mpre
              ,old_face_amt
              ,new_face_amt
              ,old_cvg_clas
              ,new_cvg_clas
              ,wp_fa
              ,wp_prem
              ,wp_mpre
              ,cvg_lay_typ
              ,old_prem_vers
              ,new_prem_vers
              ,occp_clas
              ,bnft_dur
              ,prem_dur
              ,pua_tot_amt
              ,smkr_code
              ,dth_bnft_amt
              ,band_face_amt
              ,face_ratg
              ,layer_eff_age
              ,nyr_layer_prem
              ,nyr_layer_dscnt_prem
              ,pua_crnt_amt
              ,div_crnt_amt
              ,temp_flat_dur
              ,temp_flat_unit_prem
              ,temp_flat_prem
              ,perm_flat_unit_prem
              ,perm_flat_prem
              ,temp_mort_dur
              ,temp_mort_unit_prem
              ,temp_mort_prem
              ,perm_mort_unit_prem
              ,perm_mort_prem
              ,eti_endow
              ,xtra_cat_cd
              ,perm_mort_ratg
              ,temp_mort_ratg
              ,adj_prem
              ,adj_start_dt
              ,adj_end_dt
              ,nxt_eff_cvg_prem
              ,nxt_eff_dscnt_prem
              ,risk_prem
              ,prev_dth_bnft_amt
              ,endow_acru
              ,adj_prem_pct
              ,nyr_wp_prem
              ,wp_eff_age
              ,wp_eff_dt
              ,joint_cli_eff_age
              ,substd_cd
              ,excl_code1
              ,excl_code2
              ,excl_code3
              ,excl_end_dt
              ,excl_clause
              ,xfer_rider
              ,cvg_del_reasn
              ,layer_typ
              )
    SELECT pol_num
          ,pi_cli_num
          ,plan_code
          ,vers_num
          ,cvg_eff_dt
          ,layer_eff_dt
          ,stat_cd
          ,layer_prem
          ,layer_dscnt_prem
          ,mpre
          ,old_face_amt
          ,new_face_amt
          ,old_cvg_clas
          ,new_cvg_clas
          ,wp_fa
          ,wp_prem
          ,wp_mpre
          ,cvg_lay_typ
          ,old_prem_vers
          ,new_prem_vers
          ,occp_clas
          ,bnft_dur
          ,prem_dur
          ,pua_tot_amt
          ,smkr_code
          ,dth_bnft_amt
          ,band_face_amt
          ,face_ratg
          ,layer_eff_age
          ,nyr_layer_prem
          ,nyr_layer_dscnt_prem
          ,pua_crnt_amt
          ,div_crnt_amt
          ,temp_flat_dur
          ,temp_flat_unit_prem
          ,temp_flat_prem
          ,perm_flat_unit_prem
          ,perm_flat_prem
          ,temp_mort_dur
          ,temp_mort_unit_prem
          ,temp_mort_prem
          ,perm_mort_unit_prem
          ,perm_mort_prem
          ,eti_endow
          ,xtra_cat_cd
          ,perm_mort_ratg
          ,temp_mort_ratg
          ,adj_prem
          ,adj_start_dt
          ,adj_end_dt
          ,nxt_eff_cvg_prem
          ,nxt_eff_dscnt_prem
          ,risk_prem
          ,prev_dth_bnft_amt
          ,endow_acru
          ,adj_prem_pct
          ,nyr_wp_prem
          ,wp_eff_age
          ,wp_eff_dt
          ,joint_cli_eff_age
          ,substd_cd
          ,excl_code1
          ,excl_code2
          ,excl_code3
          ,excl_end_dt
          ,excl_clause
          ,xfer_rider
          ,cvg_del_reasn
          ,layer_typ
    FROM   tcoverage_layers
    WHERE  cli_num IN(SELECT cli_cnsldt_num
                      FROM   tclient_consolidations
                      WHERE  cli_num = pi_cli_num);

  -- SG-RPULII-PROD-003
  BEGIN                                                                                                               -- PH-PRD-20040811/JHSG-retrofit
    chk_pt := 21.5;                                                                                                  -- PH-PRD-20040811/JHSG-retrofit

    --<< NPH20030219/JHSG-retrofit
    UPDATE tcoverage_layers
       SET cli_num = pi_cli_num
     WHERE cli_num IN(SELECT cli_cnsldt_num
                      FROM   tclient_consolidations
                      WHERE  cli_num = pi_cli_num);
     -->> NPH20030219/JHSG-retrofit
  --<< PH-PRD-20040811/JHSG-retrofit
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END;

  -->> PH-PRD-20040811/JHSG-retrofit
  chk_pt := 21.8;

  UPDATE tcommission_trailers
     SET cli_num = pi_cli_num
   WHERE cli_num IN(SELECT cli_cnsldt_num
                    FROM   tclient_consolidations
                    WHERE  cli_num = pi_cli_num);

  chk_pt := 22;

  -- SG-RPULII-PROD-003
  DELETE FROM tcoverage_layers
        WHERE cli_num IN(SELECT cli_cnsldt_num
                         FROM   tclient_consolidations
                         WHERE  cli_num = pi_cli_num);

  -- SG-RPULII-PROD-003
  DELETE FROM tcoverages
        WHERE cli_num IN(SELECT cli_cnsldt_num
                         FROM   tclient_consolidations
                         WHERE  cli_num = pi_cli_num);

  chk_pt := 23;

  UPDATE tclaim_details
     SET cli_num = pi_cli_num
   WHERE cli_num IN(SELECT cli_cnsldt_num
                    FROM   tclient_consolidations
                    WHERE  cli_num = pi_cli_num);

  chk_pt := 24;

  --<< SG20040212
  UPDATE tmvy_hist_details
     SET cli_num = pi_cli_num
   WHERE cli_num IN(SELECT cli_cnsldt_num
                    FROM   tclient_consolidations
                    WHERE  cli_num = pi_cli_num);

  chk_pt := 25;
  -->> SG20040212
  fcn.set_return(0);                                                                                                             --   HK-1998V2-CH06-C
/***************** HK-1998V2-CH06-C  BEGIN   *******************/
EXCEPTION
  WHEN err_upd_consolid_tbl THEN
    --rollback; -- HK-1998V2-CH06-C.1
    fcn.set_return(c_err_upd_consolid_tbl, 0);                                                                                     -- message id 5102
  WHEN VALUE_ERROR THEN
    --rollback; -- HK-1998V2-CH06-C.1
    fcn.set_return(c_err_value_err, chk_pt);                                                                                        --message id 5103
  WHEN OTHERS THEN
    --rollback; -- HK-1998V2-CH06-C.1
    fcn.set_return(c_err_unknown, chk_pt);                                                                                         -- message id 5104
/***************** HK-1998V2-CH06-C  END   *******************/
END;
