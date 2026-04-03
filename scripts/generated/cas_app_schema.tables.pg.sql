-- Generated from Oracle CAS_App_Schema.sql
SET search_path TO cas, public;

CREATE TABLE IF NOT EXISTS cas.bk_tbiannual_statement_pol_sg (
    pol_num varchar(10),
    plan_desc varchar(60),
    owner varchar(60),
    addr_1 varchar(100),
    addr_2 varchar(100),
    addr_3 varchar(100),
    addr_4 varchar(100),
    agent varchar(80),
    unit varchar(80),
    insured varchar(100),
    seq_num numeric(5),
    tot_prem numeric(13,2),
    tot_with numeric(11,2),
    tot_loan numeric(13,2),
    tot_si numeric(13,2),
    tot_admin_chrg numeric(11,2),
    tot_other_chrg numeric(11,2),
    tot_unpaid_chrg numeric(11,2),
    fnd_1 varchar(5),
    fnd_1_desc varchar(200),
    fnd_1_open_bal numeric(20,5),
    fnd_1_tot_sales numeric(20,5),
    fnd_1_tot_pur numeric(20,5),
    fnd_1_closing_bal numeric(20,5),
    fnd_1_bid_pric numeric(20,10),
    fnd_2 varchar(5),
    fnd_2_desc varchar(200),
    fnd_2_open_bal numeric(20,5),
    fnd_2_tot_sales numeric(20,5),
    fnd_2_tot_pur numeric(20,5),
    fnd_2_closing_bal numeric(20,5),
    fnd_2_bid_pric numeric(20,10),
    fnd_3 varchar(5),
    fnd_3_desc varchar(200),
    fnd_3_open_bal numeric(20,5),
    fnd_3_tot_sales numeric(20,5),
    fnd_3_tot_pur numeric(20,5),
    fnd_3_closing_bal numeric(20,5),
    fnd_3_bid_pric numeric(20,10),
    fnd_4 varchar(5),
    fnd_4_desc varchar(200),
    fnd_4_open_bal numeric(20,5),
    fnd_4_tot_sales numeric(20,5),
    fnd_4_tot_pur numeric(20,5),
    fnd_4_closing_bal numeric(20,5),
    fnd_4_bid_pric numeric(20,10),
    fnd_5 varchar(5),
    fnd_5_desc varchar(200),
    fnd_5_open_bal numeric(20,5),
    fnd_5_tot_sales numeric(20,5),
    fnd_5_tot_pur numeric(20,5),
    fnd_5_closing_bal numeric(20,5),
    fnd_5_bid_pric numeric(20,10),
    fnd_6 varchar(5),
    fnd_6_desc varchar(200),
    fnd_6_open_bal numeric(20,5),
    fnd_6_tot_sales numeric(20,5),
    fnd_6_tot_pur numeric(20,5),
    fnd_6_closing_bal numeric(20,5),
    fnd_6_bid_pric numeric(20,10),
    fnd_7 varchar(5),
    fnd_7_desc varchar(200),
    fnd_7_open_bal numeric(20,5),
    fnd_7_tot_sales numeric(20,5),
    fnd_7_tot_pur numeric(20,5),
    fnd_7_closing_bal numeric(20,5),
    fnd_7_bid_pric numeric(20,10),
    fnd_8 varchar(5),
    fnd_8_desc varchar(200),
    fnd_8_open_bal numeric(20,5),
    fnd_8_tot_sales numeric(20,5),
    fnd_8_tot_pur numeric(20,5),
    fnd_8_closing_bal numeric(20,5),
    fnd_8_bid_pric numeric(20,10),
    fnd_9 varchar(5),
    fnd_9_desc varchar(200),
    fnd_9_open_bal numeric(20,5),
    fnd_9_tot_sales numeric(20,5),
    fnd_9_tot_pur numeric(20,5),
    fnd_9_closing_bal numeric(20,5),
    fnd_9_bid_pric numeric(20,10),
    fnd_10 varchar(5),
    fnd_10_desc varchar(200),
    fnd_10_open_bal numeric(20,5),
    fnd_10_tot_sales numeric(20,5),
    fnd_10_tot_pur numeric(20,5),
    fnd_10_closing_bal numeric(20,5),
    fnd_10_bid_pric numeric(20,10),
    fnd_11 varchar(5),
    fnd_11_desc varchar(200),
    fnd_11_open_bal numeric(20,5),
    fnd_11_tot_sales numeric(20,5),
    fnd_11_tot_pur numeric(20,5),
    fnd_11_closing_bal numeric(20,5),
    fnd_11_bid_pric numeric(20,10),
    fnd_12 varchar(5),
    fnd_12_desc varchar(200),
    fnd_12_open_bal numeric(20,5),
    fnd_12_tot_sales numeric(20,5),
    fnd_12_tot_pur numeric(20,5),
    fnd_12_closing_bal numeric(20,5),
    fnd_12_bid_pric numeric(20,10),
    surr_valu numeric(20,5),
    start_dt timestamp,
    end_dt timestamp,
    page_num numeric(10)
);

CREATE TABLE IF NOT EXISTS cas.cas_la_plan_map (
    la_cnttype varchar(3),
    la_crtable varchar(4),
    cas_plan_code varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.chained_rows (
    owner_name varchar(30),
    table_name varchar(30),
    cluster_name varchar(30),
    partition_name varchar(30),
    subpartition_name varchar(30),
    head_rowid text,
    analyze_timestamp timestamp
);

CREATE TABLE IF NOT EXISTS cas.clmout_temp (
    case_no varchar(100),
    submit_date timestamp
);

CREATE TABLE IF NOT EXISTS cas.complete_pol_list_cas (
    pol_num varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.cpf_bill_rpt_sg (
    fran_num varchar(4),
    bill_dt timestamp,
    batch_no numeric(6),
    bank_cd varchar(13),
    bank_acct_num varchar(20),
    cpf_inv_acc_num varchar(20),
    cust_nm varchar(40),
    nric_num varchar(20),
    prem_bill numeric(11,2),
    pol_num varchar(10),
    pd_to_dt timestamp,
    plan_lng_desc varchar(50),
    cpf_prod_code varchar(6),
    src_typ varchar(2),
    user_id varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.cpf_rfnd_rpt_sg (
    fran_num varchar(4),
    bill_dt timestamp,
    batch_no numeric(6),
    bank_cd varchar(13),
    bank_acct_num varchar(20),
    cpf_inv_acc_num varchar(20),
    cust_nm varchar(40),
    nric_num varchar(20),
    prem_bill numeric(11,2),
    pol_num varchar(10),
    plan_code varchar(5),
    tot_cpf_prem numeric(11,2),
    net_profit numeric(11,2),
    net_loss numeric(11,2),
    reasn_cde varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.db_backup_dtls (
    session_key numeric,
    session_recid numeric,
    session_stamp numeric,
    command_id varchar(33),
    start_time timestamp,
    end_time timestamp,
    input_bytes numeric,
    output_bytes numeric,
    status_weight numeric,
    optimized_weight numeric,
    object_type_weight numeric,
    output_device_type varchar(17),
    autobackup_count numeric,
    backed_by_osb varchar(3),
    autobackup_done varchar(3),
    status varchar(23),
    input_type varchar(13),
    optimized varchar(3),
    elapsed_seconds numeric,
    compression_ratio numeric,
    input_bytes_per_sec numeric,
    output_bytes_per_sec numeric,
    input_bytes_display varchar(4000),
    output_bytes_display varchar(4000),
    input_bytes_per_sec_display varchar(4000),
    output_bytes_per_sec_display varchar(4000),
    time_taken_display varchar(4000)
);

CREATE TABLE IF NOT EXISTS cas.db_backup_subjob_dtls (
    session_key numeric,
    session_recid numeric,
    session_stamp numeric,
    operation varchar(33),
    command_id varchar(33),
    start_time timestamp,
    end_time timestamp,
    input_bytes numeric,
    output_bytes numeric,
    status_weight numeric,
    object_type_weight numeric,
    optimized_weight numeric,
    output_device_type varchar(17),
    backed_by_osb varchar(3),
    autobackup_done varchar(3),
    status varchar(23),
    input_type varchar(13),
    optimized varchar(3),
    autobackup_count numeric,
    compression_ratio numeric,
    input_bytes_display varchar(4000),
    output_bytes_display varchar(4000)
);

CREATE TABLE IF NOT EXISTS cas.db_script_chk (
    name varchar(50),
    bft_cnt numeric,
    aft_cnt numeric,
    description varchar(100)
);

CREATE TABLE IF NOT EXISTS cas.endors_let_sg (
    request_id numeric(10),
    trxn_typ varchar(2),
    remarks varchar(500),
    fcn_id varchar(20),
    pol_num varchar(10),
    trxn_id varchar(15),
    plan_code varchar(5),
    provision_num varchar(40)
);

CREATE TABLE IF NOT EXISTS cas.ext_ttm_lead_file_dt_tmp (
    first_name varchar(100),
    sur_name varchar(100),
    phone1 varchar(50),
    phone2 varchar(50),
    phone3 varchar(50),
    msg varchar(500),
    ref_row varchar(50),
    chk_status varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.fund_summary (
    pol_num varchar(10),
    fnd_id varchar(5),
    unt_typ varchar(1),
    fund_bal numeric(20,10)
);

CREATE TABLE IF NOT EXISTS cas.fund_trxn_histories (
    pol_num varchar(10),
    unit_virtual_fund varchar(5),
    unit_type varchar(1),
    tranno numeric(4),
    transaction_date varchar(10),
    batctrcde varchar(5),
    monies_date varchar(10),
    price_date_used varchar(10),
    crtable varchar(5),
    fund_amount numeric(12,2),
    contract_type varchar(5),
    now_defer_ind varchar(1),
    nof_units numeric(15,5),
    price_used numeric(12,5),
    sacscode varchar(3),
    sacstyp varchar(3),
    genlcde varchar(25),
    tran_date timestamp,
    price_dt timestamp,
    monies_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.gs_tauto_feed_files (
    bank_code varchar(13),
    file_name varchar(20),
    dataline varchar(200),
    result_cd varchar(5),
    pol_num varchar(17),
    trxn_amt numeric(11,2),
    trxn_dt timestamp,
    file_num varchar(5),
    feed_date timestamp,
    acct_num varchar(20),
    off_loc_cd varchar(5),
    dist_chnl_cd varchar(2),
    crcy_code varchar(2),
    c_cpf_inv_acct varchar(20),
    c_nric_no varchar(20),
    c_cust_name varchar(40),
    c_authorise varchar(1),
    c_pol_name varchar(40),
    c_collect_ind varchar(1),
    c_batch_serial varchar(6),
    c_internal_ref varchar(6),
    h_cpf_acct varchar(9),
    h_house_ref varchar(12),
    h_name varchar(66),
    h_coy_cde varchar(2),
    reject_cd varchar(10),
    bank_cd varchar(13),
    bank_deb_dt timestamp,
    pac_upd varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.hc_tdates_control (
    ctrl_type varchar(30) not null,
    ctrl_date timestamp not null
);

CREATE TABLE IF NOT EXISTS cas.ipo_nonac_list_sg (
    pol_num varchar(10) not null,
    crr_trxn_dt timestamp not null,
    trxn_id varchar(15),
    prem_amt numeric(11,2) not null,
    comm_amt numeric(11,2) not null,
    pc_amt numeric(9) not null
);

CREATE TABLE IF NOT EXISTS cas.jh_plan_map (
    pics_crcy varchar(2),
    pics_plan_code varchar(6),
    cas_plan_code varchar(5),
    cas_vers_num varchar(2),
    name_index varchar(2),
    cpf_mthd varchar(2),
    comm_eff_dt timestamp,
    renw_ind varchar(1),
    pub_life_ind varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.jh_plan_ncomm (
    cas_plan_code varchar(5),
    pics_plan_code varchar(6),
    remark varchar(400)
);

CREATE TABLE IF NOT EXISTS cas.jh_plan_nprem (
    cas_plan_code varchar(5),
    pics_plan_code varchar(6),
    remark varchar(200)
);

CREATE TABLE IF NOT EXISTS cas.la_giro_man (
    man_num varchar(12),
    pol_num varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.mantouch (
    pol_nbr varchar(10),
    pol_curr varchar(2),
    iss_age numeric(3),
    iss_date timestamp,
    r1_iss_dt timestamp,
    r2_iss_dt timestamp,
    r3_iss_dt timestamp,
    r4_iss_dt timestamp,
    r5_iss_dt timestamp,
    r6_iss_dt timestamp,
    r7_iss_dt timestamp,
    r8_iss_dt timestamp,
    r9_iss_dt timestamp,
    ra_iss_dt timestamp,
    pol_stat varchar(10),
    birth_date timestamp,
    sex varchar(1),
    smoker varchar(1),
    base_plan varchar(5),
    rider_1 varchar(5),
    rider_2 varchar(5),
    rider_3 varchar(5),
    rider_4 varchar(5),
    rider_5 varchar(5),
    rider_6 varchar(5),
    rider_7 varchar(5),
    rider_8 varchar(5),
    rider_9 varchar(5),
    rider_a varchar(5),
    bp_amount numeric(10),
    r1_amount numeric(10),
    r2_amount numeric(10),
    r3_amount numeric(10),
    r4_amount numeric(10),
    r5_amount numeric(10),
    r6_amount numeric(10),
    r7_amount numeric(10),
    r8_amount numeric(10),
    r9_amount numeric(10),
    ra_amount numeric(10),
    bp_premium numeric(10,2),
    r1_premium numeric(10,2),
    r2_premium numeric(10,2),
    r3_premium numeric(10,2),
    r4_premium numeric(10,2),
    r5_premium numeric(10,2),
    r6_premium numeric(10,2),
    r7_premium numeric(10,2),
    r8_premium numeric(10,2),
    r9_premium numeric(10,2),
    ra_premium numeric(10,2),
    extra_prem numeric(10,2),
    bp_pflat numeric(7,2),
    r1_pflat numeric(7,2),
    r2_pflat numeric(7,2),
    r3_pflat numeric(7,2),
    r4_pflat numeric(7,2),
    r5_pflat numeric(7,2),
    r6_pflat numeric(7,2),
    r7_pflat numeric(7,2),
    r8_pflat numeric(7,2),
    r9_pflat numeric(7,2),
    ra_pflat numeric(7,2),
    bp_pface numeric(4),
    r1_pface numeric(4),
    r2_pface numeric(4),
    r3_pface numeric(4),
    r4_pface numeric(4),
    r5_pface numeric(4),
    r6_pface numeric(4),
    r7_pface numeric(4),
    r8_pface numeric(4),
    r9_pface numeric(4),
    ra_pface numeric(4),
    bp_tflat numeric(7,2),
    r1_tflat numeric(7,2),
    r2_tflat numeric(7,2),
    r3_tflat numeric(7,2),
    r4_tflat numeric(7,2),
    r5_tflat numeric(7,2),
    r6_tflat numeric(7,2),
    r7_tflat numeric(7,2),
    r8_tflat numeric(7,2),
    r9_tflat numeric(7,2),
    ra_tflat numeric(7,2),
    bp_tface numeric(4),
    r1_tface numeric(4),
    r2_tface numeric(4),
    r3_tface numeric(4),
    r4_tface numeric(4),
    r5_tface numeric(4),
    r6_tface numeric(4),
    r7_tface numeric(4),
    r8_tface numeric(4),
    r9_tface numeric(4),
    ra_tface numeric(4),
    bill_mode varchar(12),
    bill_meth varchar(10),
    franc_no varchar(4),
    serv_agent varchar(6),
    paidtodate timestamp,
    expirdate timestamp,
    freeze_cd varchar(1),
    distric_cd varchar(3),
    ssn varchar(24),
    holder_nm varchar(50),
    holder_ad1 varchar(40),
    holder_ad2 varchar(40),
    holder_ad3 varchar(40),
    holder_ad4 varchar(40),
    holder_ad5 varchar(30),
    holder_pos varchar(10),
    holder_phn varchar(10),
    ins_name varchar(50),
    ins_ad1 varchar(40),
    ins_ad2 varchar(40),
    ins_ad3 varchar(40),
    ins_ad4 varchar(40),
    ins_phn varchar(10),
    payor_name varchar(40),
    payor_sex varchar(1),
    payor_dob timestamp,
    payor_age numeric(2),
    div_opt varchar(1),
    death_ben numeric(13,2),
    div_bal numeric(13,2),
    total_pua numeric(10),
    loan_bal numeric(13,2),
    loan_date timestamp,
    pol_susp numeric(11,2),
    pay_susp numeric(11,2),
    np_paytdur numeric(2),
    np_disc numeric(9,2),
    div_uto_yr numeric(4),
    cp_bal numeric(13,2),
    cp_acc_int numeric(11,2),
    l_avy_yr numeric(4),
    nxt_t_pua numeric(10),
    serv_unit varchar(6),
    serv_bran varchar(5),
    serv_name varchar(30),
    bp_wrt_agt varchar(6),
    bp_wrt_unt varchar(5),
    bp_wrt_nam varchar(30),
    bp_com_agt varchar(6),
    bp_com_unt varchar(5),
    bp_com_nam varchar(30),
    mode_prem numeric(10,2),
    reissue_dt timestamp,
    basic_cv numeric(13,2),
    bonus_cv numeric(13,2),
    loan_int numeric(13,2),
    tot_loan numeric(13,2),
    coupon_int numeric(13,2),
    tot_coupon numeric(13,2),
    pol_type varchar(1),
    singl_prem numeric(10,2)
);

CREATE TABLE IF NOT EXISTS cas.patch_tmvy_hist_headers (
    pol_num varchar(10) not null
);

CREATE TABLE IF NOT EXISTS cas.pics_conv_err_log (
    pics_table varchar(20),
    cas_table varchar(30),
    pol_num varchar(20),
    pics_pers varchar(10),
    cas_cli_num varchar(20),
    msg_typ varchar(1),
    message varchar(300),
    pgm_id varchar(50),
    conv_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.pics_repl_plan (
    cas_pol_num varchar(10),
    cas_plan_code varchar(5),
    cas_vers_num varchar(2),
    cas_cli_num varchar(10),
    cas_cvg_eff_dt timestamp,
    pics_poln numeric(8),
    pics_rwno numeric(2),
    pics_seri numeric(2)
);

CREATE TABLE IF NOT EXISTS cas.plan_ph1_3 (
    phase char(5),
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    valn_code varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.plan_ph3 (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    valn_code varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.plan_table (
    statement_id varchar(30),
    timestamp timestamp,
    remarks varchar(80),
    operation varchar(30),
    options varchar(30),
    object_node varchar(128),
    object_owner varchar(30),
    object_name varchar(30),
    object_instance numeric(38),
    object_type varchar(30),
    optimizer varchar(255),
    search_columns numeric,
    id numeric(38),
    parent_id numeric(38),
    position numeric(38),
    cost numeric(38),
    cardinality numeric(38),
    bytes numeric(38),
    other_tag varchar(255),
    partition_start varchar(255),
    partition_stop varchar(255),
    partition_id numeric(38),
    other text,
    distribution varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.pol_list_cas (
    pol_num varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.prem_stmnt_img_sg (
    fcn_id varchar(20),
    fcn_vers varchar(2),
    pol_num varchar(10),
    sa_cd_1 varchar(6),
    sa_cd_2 varchar(6),
    ca_cd_1 varchar(6),
    ca_cd_2 varchar(6),
    wa_cd_1 varchar(6),
    wa_cd_2 varchar(6),
    ins_cli_num varchar(10),
    own_cli_num varchar(10),
    payor_cli_num varchar(10),
    cas_dt timestamp,
    dept varchar(10),
    gen_dt timestamp,
    path varchar(50),
    fil_nm varchar(50),
    version varchar(5),
    file_status varchar(2),
    request_id numeric(10),
    seq_num numeric not null,
    carton_num varchar(15)
);

CREATE TABLE IF NOT EXISTS cas.receipt_histories (
    pol_num varchar(10),
    eff_dt varchar(10),
    rcpt_desc varchar(20),
    rcpt_amt numeric(20,10),
    rcpt_typ varchar(1),
    eff_dt1 timestamp
);

CREATE TABLE IF NOT EXISTS cas.rider_active (
    plan_code varchar(5),
    vers_num varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.rider_all (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    grp_desc char(29),
    product_spec char(1)
);

CREATE TABLE IF NOT EXISTS cas.rider_no_active (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null
);

CREATE TABLE IF NOT EXISTS cas.rider_ph1_2 (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    component_code varchar(30),
    phase varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.rider_ph1_3 (
    plan_code varchar(5),
    vers_num varchar(2),
    component_code char(1),
    phase char(3)
);

CREATE TABLE IF NOT EXISTS cas.rider_ph3 (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    grp_desc varchar(20),
    new_plan varchar(4)
);

CREATE TABLE IF NOT EXISTS cas.ri_claim (
    clm_claim_no varchar(10),
    clm_pol_no varchar(10),
    clm_rec_date timestamp,
    clm_insured varchar(60),
    clm_typ varchar(2),
    clm_status varchar(8),
    clm_incident_age numeric(3),
    clm_incident_date timestamp,
    clm_death_code varchar(9),
    clm_death_cause varchar(500),
    clm_assess_date timestamp,
    clm_decision varchar(4000),
    clm_decis_code varchar(4),
    clm_amt_reinsured numeric(14,2),
    clm_paid_date timestamp,
    clm_reg_code varchar(2),
    clm_tbl_curr varchar(3),
    clm_amt_recovered numeric(14,2),
    clm_interest numeric(14,2),
    clm_birth_date timestamp,
    clm_curr varchar(3),
    clm_code varchar(3),
    clm_cov_plan varchar(11),
    clm_payee_name varchar(60),
    clm_claim_rec numeric(2),
    clm_payee_dob timestamp,
    clm_sex varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.ri_feed_cvg (
    pol_num varchar(10),
    plan_code varchar(5),
    issue_date timestamp,
    coverage_type varchar(3),
    record_typ varchar(2),
    prem_mode numeric(2),
    prem_period numeric(3),
    bnft_period numeric(3),
    cvg_eff_age numeric(3),
    orig_face_amt numeric(13,2),
    curr_face_amt numeric(13,2),
    last_avy_cv numeric(13,2),
    nxt_avy_cv numeric(13,2),
    cov_modal_prem numeric(11,2),
    perm_flat_prem numeric(11,2),
    temp_flat_prem numeric(11,2),
    temp_mort_dur numeric(2),
    perm_mort_prem numeric(11,2),
    temp_mort_prem numeric(11,2),
    face_ratg numeric(3),
    cvg_stat_cd varchar(1),
    smkr_code varchar(1),
    occp_clas varchar(1),
    substd_cd varchar(3),
    cvg_trmn_dt timestamp,
    insured_id varchar(20),
    insured_surname varchar(30),
    insured_given_nm varchar(30),
    birth_dt timestamp,
    insured_sex varchar(1),
    insured_legal_id varchar(20),
    plan_vers varchar(2),
    cov_group varchar(2),
    layer_num varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.ri_feed_err (
    remarks varchar(500)
);

CREATE TABLE IF NOT EXISTS cas.ri_feed_pol (
    pol_num varchar(10),
    plan_code varchar(5),
    issue_date timestamp,
    filler varchar(3),
    record_typ varchar(2),
    business_block varchar(1),
    medical_code varchar(1),
    risk_type varchar(3),
    joint_life_ind varchar(1),
    transaction_code varchar(3),
    last_trans_dt timestamp,
    last_bill_prem numeric(11,2),
    last_avy_dt timestamp,
    policy_crcy varchar(3),
    pol_stat_cd varchar(1),
    pol_trmn_dt timestamp,
    insured_mort numeric(3),
    uw_code varchar(2),
    manual_code varchar(3),
    plan_type varchar(1),
    pua_tot_amt numeric(13,2),
    pd_to_dt timestamp,
    par_ind varchar(1),
    ceded_code varchar(1),
    mli_ln_bus varchar(2),
    resident_code varchar(2),
    trmn_cause varchar(3),
    gl_corp_id varchar(5),
    gl_legal_id varchar(4),
    gl_fund_id varchar(1),
    gl_ln_bus varchar(2),
    gl_terr_code varchar(2),
    gl_currency varchar(3),
    gl_par_ind varchar(1),
    product_code varchar(5),
    dth_bnft_opt varchar(1),
    dth_bnft numeric(13,2),
    tot_fund_bal numeric(11,2),
    term_div_amt numeric(13,2),
    occp_code varchar(2),
    policy_fee numeric(5,2),
    ipo_flag varchar(1),
    owner_id varchar(20),
    cam_dis_rate varchar(4),
    ri_dis_ind varchar(1),
    dist_chnl_cd varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.rw_jobs (
    jobid numeric not null,
    servername varchar(100) not null,
    job bytea,
    owner varchar(25),
    id numeric,
    status numeric(1,1),
    queue numeric(1),
    masterjob numeric,
    cachekey varchar(500),
    expiration numeric
);

CREATE TABLE IF NOT EXISTS cas.rw_server_job_queue (
    job_queue varchar(30),
    job_id numeric,
    job_type varchar(30),
    job_name varchar(4000),
    status_code numeric,
    status_message varchar(4000),
    command_line varchar(4000),
    owner varchar(30),
    destype varchar(80),
    desname varchar(4000),
    server varchar(80),
    queued timestamp,
    started timestamp,
    finished timestamp,
    run_elapse numeric,
    total_elapse numeric,
    last_run timestamp,
    next_run timestamp,
    repeat_interval numeric,
    repeat_pattern numeric,
    cache_key varchar(4000),
    cache_hit numeric
);

CREATE TABLE IF NOT EXISTS cas.su (
    pol_num varchar(10) not null
);

CREATE TABLE IF NOT EXISTS cas.surrpayment_histories (
    pol_num varchar(10),
    eff_dt varchar(10),
    rcpt_desc varchar(20),
    rcpt_amt numeric(20,10),
    rcpt_typ varchar(1),
    eff_dt1 timestamp
);

CREATE TABLE IF NOT EXISTS cas.t05_crr_reasn_year_map_th (
    reasn_cd varchar(3) not null,
    pol_yr_ind varchar(1),
    pol_yr numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.t3cd_mappings_th (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    sun_t3cd varchar(10),
    fnd_id varchar(5),
    fnd_vers varchar(6)
);

CREATE TABLE IF NOT EXISTS cas.tuser_profiles (
    user_id varchar(30) not null,
    user_role varchar(30) not null,
    rec_status varchar(1) not null,
    team_id varchar(2),
    user_name varchar(40),
    def_printer varchar(10),
    oper_id varchar(2),
    nxt_cmp_seq numeric(5),
    pwd_exp_dt timestamp not null,
    print_access varchar(1),
    curr_fcn varchar(20),
    ext_no varchar(6),
    designation varchar(20),
    signer varchar(10),
    ur_dur_lmt numeric(3),
    ur_dur_lmt_unit varchar(1),
    ur_incls varchar(1),
    dept_code varchar(3),
    user_level numeric(1)
);

CREATE TABLE IF NOT EXISTS cas.tfranchise_addresses (
    fran_num varchar(4) not null,
    cntct_nm varchar(60) not null,
    bill_day numeric(2) not null,
    addr_1 varchar(60) not null,
    addr_2 varchar(60),
    addr_3 varchar(60),
    dscnt_pct numeric(5,2) not null,
    dscnt_ceiling_amt numeric(11,2) default 0 not null,
    zip_code varchar(6),
    addr_4 varchar(60),
    proc_fee_ind varchar(1) default 'N',
    bill_day_typ varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpolicys (
    pol_num varchar(10) not null,
    mode_prem numeric(11,2) not null,
    ovr_loan_ind varchar(1) not null,
    frez_code varchar(1) not null,
    ipo_ind varchar(1) not null,
    vp_ind varchar(1) not null,
    reins_ind varchar(1) not null,
    bill_mthd varchar(1) not null,
    crcy_code varchar(2) not null,
    last_avy_dt timestamp not null,
    last_pd_to_dt timestamp not null,
    pd_to_dt timestamp not null,
    pol_eff_dt timestamp not null,
    pol_iss_dt timestamp,
    pol_reiss_dt timestamp,
    cnfrm_acpt_dt timestamp,
    pol_rlse_dt timestamp,
    sbmt_dt timestamp not null,
    pol_stat_cd varchar(1) not null,
    state_cd varchar(2) not null,
    pol_trmn_dt timestamp,
    div_opt varchar(1) not null,
    terr_cd varchar(2) not null,
    dscnt_prem numeric(11,2) not null,
    pol_susp numeric(13,2) not null,
    pmt_susp numeric(11,2) not null,
    ipo_last_refu_yr numeric(4),
    pmt_mode varchar(5) not null,
    bill_prem numeric(11,2) not null,
    bill_to_dt timestamp not null,
    pac_loan_repy numeric(11,2),
    pac_bk_ctr varchar(1),
    pac_eff_dt timestamp,
    medic_code varchar(10),
    medic_dt timestamp,
    incmplt_cd varchar(2),
    pend_cd varchar(2),
    subj_to_cd varchar(2),
    uwg_clas varchar(30),
    fran_num varchar(4),
    agt_code varchar(6),
    nfo_opt varchar(1) not null,
    nfo_eff_dt timestamp,
    zap_ind varchar(1),
    aea_ind varchar(1) not null,
    lnb_ind varchar(1) not null,
    hiv_ind varchar(1) not null,
    pol_rmrk varchar(500),
    apl_laps_dt timestamp,
    pc_typ varchar(10),
    pc_recv_dt timestamp,
    pc_pend_reasn varchar(10),
    pc_efft_date timestamp,
    apl_ext_days numeric(3),
    nyr_mode_prem numeric(11,2) not null,
    nyr_dscnt_prem numeric(11,2) not null,
    renw_yr numeric(3) not null,
    run_num numeric(2),
    pol_app_dt timestamp,
    tlia_code_1 varchar(10),
    tlia_code_2 varchar(10),
    tlia_code_3 varchar(10),
    disab_clas varchar(3),
    restr_case_cnt_ind varchar(1) not null,
    comm_wthld_dt timestamp,
    nb_user_id varchar(30) not null,
    last_actv_dt timestamp,
    joint_cli_dth_ind varchar(1) not null,
    comprop_prem numeric(11,2),
    resv_dnr_amt numeric(13,2),
    xcpt_bill_cd varchar(1),
    nb_pc_pol_tot numeric(9),
    cnfrm_prt_dt timestamp,
    os_anty_susp numeric(13,2),
    payo_mthd varchar(1),
    anty_stat_cd varchar(1),
    nxt_eff_mode_prem numeric(11,2),
    nxt_eff_dscnt_prem numeric(11,2),
    nxt_eff_prem_dt timestamp,
    ctr_prem numeric(11,2),
    nxt_eff_ctr_prem numeric(11,2),
    lump_sum_ind varchar(1),
    lump_sum_pmt_amt numeric(11,2),
    proc_fee_ind varchar(1),
    dist_chnl_cd varchar(2),
    tot_prem_appy numeric(15,2),
    prefix_cd varchar(3),
    oth_rqmts_text varchar(60),
    mort_cd varchar(6),
    chg_insrd_opt varchar(1),
    convrt_fr_pol varchar(10),
    apl_lapse_ind varchar(1),
    div_upto_dt timestamp,
    endow_ctl varchar(1),
    sa_cd_2 varchar(6),
    wa_cd_1 varchar(6),
    wa_cd_2 varchar(6),
    vp_point timestamp,
    override_bill_day numeric(2),
    plan_code_base varchar(5),
    vers_num_base varchar(2),
    bnh_code varchar(5),
    corridor_pct numeric(3),
    curr_debit_day numeric(2),
    db_opt varchar(1),
    disable_dt timestamp,
    dth_susp numeric(13,2),
    fnd_switch_ctr numeric(3),
    fnd_wthdr_ctr numeric(3),
    iio_opt varchar(1),
    iio_pct numeric(3),
    insrd_mort varchar(4),
    ins_typ_base varchar(1),
    lst_fnd_valn_dt timestamp,
    mvy_ded_to_dt timestamp,
    nb_update_date timestamp,
    no_lapse_gurt_ind varchar(1),
    nxt_debit_day numeric(2),
    nxt_pac_eff_dt timestamp,
    nxt_rebal_date timestamp,
    occ_cd varchar(6),
    open_flag varchar(5),
    pickup_debit_day numeric(2),
    pickup_eff_dt timestamp,
    plan_prem numeric(11,2),
    pol_clm_dt timestamp,
    pric_rsrv_dt timestamp,
    rebal_ind varchar(1),
    recurr_bill_ind varchar(1),
    recurr_bill_st_dt timestamp,
    reins_cd varchar(3),
    reins_mthd varchar(1),
    restrict_cd_1 varchar(5),
    restrict_cd_2 varchar(5),
    restrict_cd_3 varchar(5),
    special_clas varchar(2),
    wrk_area varchar(4),
    non_lapse_ind varchar(1),
    lro_eff_dt timestamp,
    bbr_flag varchar(1),
    ph_ind varchar(1),
    ph_strt_dt timestamp,
    ph_end_dt timestamp,
    ph_eff_typ varchar(1),
    ph_pd_to_dt timestamp,
    ph_last_pd_to_dt timestamp,
    ph_autopay_ind varchar(1),
    anty_wthdr numeric(13,2),
    anty_dur numeric(2),
    anty_freq numeric(2),
    anty_int_rt numeric(7,5),
    anty_opt varchar(2),
    anty_payo_amt numeric(13,2),
    anty_start_dt timestamp,
    loan_ovr_int_rt numeric(7,5),
    conv_dt timestamp,
    pdf_strt_dt timestamp,
    pdf_end_dt timestamp,
    instl_strt_dt timestamp,
    instl_end_dt timestamp,
    instl_amt numeric(13,2),
    edw_loan varchar(1),
    loyal_bns_ind varchar(1),
    bank_fee_ind varchar(1),
    anty_ref_dt timestamp,
    anty_end_dt timestamp,
    gurt_bnft numeric(13,2),
    gurt_amt numeric(13,2),
    life_incm numeric(13,2),
    rmn_gurt_amt numeric(13,2),
    rmn_life_incm numeric(13,2),
    nxt_payo_dt timestamp,
    last_fnd_avy_dt timestamp,
    anty_min_payo_amt numeric(13,2),
    ins_birth_dt timestamp,
    last_tcomm_calc_dt timestamp,
    waive_end_dt timestamp,
    set_eff_dt timestamp,
    set_last_avy_dt timestamp,
    set_stat_cd varchar(1),
    anty_payo_base numeric(11,2),
    anty_payo_rt numeric(12,6),
    anty_crtn_dur numeric(2),
    loyal_bns_opt varchar(1),
    last_lbns_decla_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.ta01_prem_adj_headers (
    ta01_req_seq varchar(8) not null,
    pol_num varchar(10) not null,
    req_status varchar(1) not null,
    reasn_code varchar(3),
    adj_prem_ind varchar(1),
    adj_comm_ind varchar(1),
    prem_adj_amt numeric(13,2),
    comm_adj_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.ta02_prem_adj_details (
    ta01_req_seq varchar(8) not null,
    pol_num varchar(10) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cli_num varchar(13) not null,
    cvg_eff_dt timestamp not null,
    pd_to_dt_bef timestamp not null,
    pd_to_dt_aft timestamp,
    prem_yr numeric(3),
    agt_code varchar(6) not null,
    prem_adj_amt numeric(13,2),
    comm_adj_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.ta10_prst_snapshot_prem_th (
    pol_num varchar(10),
    prod_mo timestamp,
    anp_pol numeric(11,2),
    anp_pol_no_xtra numeric(11,2),
    anp_base_no_xtra numeric(11,2),
    anp_base numeric(11,2),
    anp_div numeric(11,2),
    anp_rb numeric(11,2),
    anp_npar numeric(11,2),
    frez_code varchar(1),
    pol_stat_cd varchar(1),
    pd_to_dt timestamp,
    stat_xpry_dt timestamp,
    stat_eff_dt timestamp,
    pmt_mode varchar(2),
    last_pd_to_dt timestamp,
    ph_ind varchar(1),
    ph_end_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.ta11_prst_snapshot_pln_th (
    pol_num varchar(10) not null,
    prod_mo timestamp not null,
    pol_iss_dt timestamp not null,
    case_ctr numeric(7,4) not null,
    dist_chnl_cd varchar(2),
    loc_cd varchar(5),
    mgr_cd_am varchar(6),
    mgr_cd_um varchar(6),
    agt_code varchar(6),
    pol_eff_dt timestamp not null,
    ins_typ varchar(3) not null,
    sex_code_owner varchar(1),
    sex_code_insrd varchar(1),
    face_amt_base numeric(13,2) not null,
    cvg_eff_age_base numeric(3) not null,
    occp_code_owner varchar(10),
    occp_code_insrd varchar(10),
    plan_code_base varchar(5) not null,
    vers_num_base varchar(2) not null,
    lapse_day numeric(3) not null,
    prod_cat varchar(5),
    sngl_prem_ind varchar(1) not null,
    crcy_code varchar(2) not null,
    bnft_dur_base numeric(3) not null,
    prem_dur_base numeric(3) not null
);

CREATE TABLE IF NOT EXISTS cas.ta12_prst_snapshot_idx_th (
    prod_mo timestamp,
    pol_num varchar(10),
    prod_mo_pln timestamp,
    prod_mo_prem timestamp
);

CREATE TABLE IF NOT EXISTS cas.ta13_prst_policys_work_th (
    pol_num varchar(10) not null,
    prst_ind varchar(1) not null,
    insrd_nm varchar(60) not null,
    anp_prst numeric(11,2) not null,
    anp_div numeric(11,2) not null,
    anp_rb numeric(11,2) not null,
    frez_code varchar(1) not null,
    pol_stat_cd varchar(1) not null,
    pd_to_dt timestamp not null,
    stat_xpry_dt timestamp,
    pol_iss_mo timestamp not null,
    case_ctr numeric(7,4) not null,
    dist_chnl_cd varchar(2),
    loc_cd varchar(5),
    mgr_cd_am varchar(6),
    mgr_cd_um varchar(6),
    agt_code varchar(6) not null,
    agt_nm varchar(60),
    pol_eff_dt timestamp not null,
    ins_typ varchar(3) not null,
    pmt_mode varchar(2) not null,
    sex_code_payor varchar(1),
    sex_code_insrd varchar(1),
    face_amt_base numeric(13,2) not null,
    cvg_eff_age_base numeric(3) not null,
    occp_code_payor varchar(10),
    occp_code_insrd varchar(10),
    plan_code_base varchar(5) not null,
    vers_num_base varchar(2) not null,
    lapse_day numeric(3),
    pol_trmn_dt timestamp,
    stat_eff_dt timestamp not null,
    prod_cat varchar(5) not null,
    crcy_code varchar(2) not null,
    prst_typ varchar(5) not null,
    prod_mo timestamp not null,
    br_code varchar(5),
    insrd_title varchar(20),
    agt_title varchar(20),
    bnft_dur_base numeric(3),
    prem_dur_base numeric(3),
    prst_rpt_mo timestamp not null,
    anp_initial numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.ta14_prst_types_th (
    crcy_code varchar(2) not null,
    prst_typ varchar(5) not null,
    prst_desc varchar(60) not null,
    prst_mo_req numeric(3) not null,
    prst_mo_avg numeric(3) not null,
    prst_anp_ind varchar(1) not null,
    prst_grace_mo numeric(3) not null
);

CREATE TABLE IF NOT EXISTS cas.ta15_plan_prst_formulae_th (
    crcy_code varchar(2) not null,
    prst_typ varchar(5) not null,
    prod_cat varchar(5) default '*' not null,
    plan_code varchar(5) default '*' not null,
    vers_num varchar(2) default '*' not null,
    prst_ptd_ind varchar(1) not null,
    prst_incl_ind varchar(1) not null,
    prst_fct_case numeric(5,2) not null,
    prst_fct_anp numeric(5,2) not null
);

CREATE TABLE IF NOT EXISTS cas.ta16_prst_feed_source_th (
    pol_num varchar(10) not null,
    pol_stat_cd varchar(1) not null,
    agt_code varchar(6),
    mgr_cd_um varchar(6),
    br_code varchar(5),
    pol_eff_dt timestamp not null,
    face_amt_base numeric(13,2) not null,
    pmt_mode varchar(2) not null,
    anp_amt numeric(13,2) not null,
    anp_amt_srce numeric(13,2) not null,
    case_ctr_srce numeric(7,4) not null,
    prst_typ varchar(5) not null,
    prod_mo timestamp not null,
    prst_rpt_mo timestamp not null
);

CREATE TABLE IF NOT EXISTS cas.ta17_prst_feed_inforce_th (
    pol_num varchar(10) not null,
    pol_stat_cd varchar(1) not null,
    agt_code varchar(6),
    mgr_cd_um varchar(6),
    br_code varchar(5),
    pol_eff_dt timestamp not null,
    face_amt_base numeric(13,2) not null,
    pmt_mode varchar(2) not null,
    anp_prst numeric(13,2) not null,
    prev_pd_to_dt timestamp not null,
    pol_yr numeric(3) not null,
    mod_period numeric(3) not null,
    pd_to_dt timestamp not null,
    anp_amt numeric(13,2) not null,
    case_ctr numeric(7,4) not null,
    prst_typ varchar(5) not null,
    prod_mo timestamp not null,
    prst_rpt_mo timestamp not null
);

CREATE TABLE IF NOT EXISTS cas.ta18_prst_feed_combined_th (
    pol_num varchar(10) not null,
    pol_stat_cd varchar(1) not null,
    agt_code varchar(6),
    mgr_cd_um varchar(6),
    br_code varchar(5),
    pol_eff_dt timestamp not null,
    face_amt_base numeric(13,2) not null,
    benf_dur_base numeric(3) not null,
    prem_dur_base numeric(3) not null,
    pmt_mode varchar(2) not null,
    prev_pd_to_dt timestamp not null,
    pol_yr numeric(3) not null,
    mod_period numeric(3) not null,
    pd_to_dt timestamp not null,
    reinst_dt timestamp,
    reinst_cd varchar(1),
    anp_amt_inf numeric(13,2) not null,
    case_ctr_inf numeric(7,4) not null,
    anp_amt_srce numeric(13,2) not null,
    case_ctr_srce numeric(7,4) not null,
    anp_amt_calc numeric(13,2) not null,
    case_ctr_calc numeric(7,4) not null,
    prst_typ varchar(5) not null,
    prod_mo timestamp not null,
    prst_rpt_mo timestamp not null
);

CREATE TABLE IF NOT EXISTS cas.ta19_prst_feed_summary_th (
    prst_typ varchar(5) not null,
    prod_mo timestamp not null,
    prod_cat varchar(5) default '*' not null,
    agt_code varchar(6) not null,
    prst_rpt_mo timestamp not null,
    pol_eff_dt_str timestamp,
    pol_eff_dt_end timestamp,
    case_ctr numeric(8,2),
    anp_amt numeric(13,2),
    case_ctr_inf numeric(8,2),
    anp_amt_inf numeric(13,2),
    prst_pct_case numeric(7,4),
    prst_pct_anp numeric(7,4),
    case_ctr_tot numeric(8,2),
    anp_amt_tot numeric(13,2),
    case_ctr_tot_inf numeric(8,2),
    anp_amt_tot_inf numeric(13,2),
    prst_pct_case_avg numeric(7,4),
    prst_pct_anp_avg numeric(7,4)
);

CREATE TABLE IF NOT EXISTS cas.ta20_prst_summary_by_agt_th (
    agt_code varchar(6) not null,
    rank_cd varchar(5) default '*' not null,
    prst_rpt_mo timestamp not null,
    prst_typ varchar(5) not null,
    case_ctr numeric(11,4) not null,
    anp_amt numeric(13,2) not null,
    case_ctr_inf numeric(11,4) not null,
    anp_amt_inf numeric(13,2) not null,
    prst_pct_case numeric(5,2) not null,
    prst_pct_anp numeric(5,2) not null,
    prod_cat varchar(5) default '*' not null
);

CREATE TABLE IF NOT EXISTS cas.ta21_re_prst_pol_wrk_th (
    pol_num varchar(10) not null,
    prst_ind varchar(1) not null,
    insrd_nm varchar(60) not null,
    anp_prst numeric(11,2) not null,
    anp_div numeric(11,2) not null,
    rein_typ varchar(1) not null,
    anp_rb numeric(11,2) not null,
    frez_code varchar(1) not null,
    pol_stat_cd varchar(1) not null,
    pd_to_dt timestamp not null,
    stat_xpry_dt timestamp,
    pol_iss_mo timestamp not null,
    case_ctr numeric(7,4) not null,
    dist_chnl_cd varchar(2),
    loc_cd varchar(5),
    mgr_cd_am varchar(6),
    mgr_cd_um varchar(6),
    agt_code varchar(6) not null,
    agt_nm varchar(60),
    pol_eff_dt timestamp not null,
    ins_typ varchar(3) not null,
    pmt_mode varchar(2) not null,
    sex_code_payor varchar(1),
    sex_code_insrd varchar(1),
    face_amt_base numeric(13,2) not null,
    cvg_eff_age_base numeric(3) not null,
    occp_code_payor varchar(10),
    occp_code_insrd varchar(10),
    plan_code_base varchar(5) not null,
    vers_num_base varchar(2) not null,
    lapse_day numeric(3),
    pol_trmn_dt timestamp,
    stat_eff_dt timestamp not null,
    prod_cat varchar(5) not null,
    crcy_code varchar(2) not null,
    prst_typ varchar(5) not null,
    prod_mo timestamp not null,
    br_code varchar(5),
    insrd_title varchar(20),
    agt_title varchar(20),
    bnft_dur_base numeric(3),
    prem_dur_base numeric(3),
    prst_rpt_mo timestamp not null,
    anp_initial numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tacct_cradv (
    btch_num varchar(5) not null,
    btch_role varchar(2) not null,
    btch_typ varchar(4) not null,
    pol_num varchar(10) not null,
    trxn_dt timestamp not null,
    eff_dt timestamp not null,
    trxn_cd varchar(8) not null,
    reasn_code varchar(3) not null,
    trxn_amt numeric(11,2) not null,
    aex_num numeric(8) not null,
    acct_trxn_dt timestamp not null,
    acct_gen_amt numeric(13,2) not null,
    acct_eff_dt timestamp not null,
    acct_mne_cd varchar(8),
    acct_reasn_code varchar(3) not null,
    cr_or_dr varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tacct_extracts (
    pol_num varchar(10) not null,
    trxn_dt timestamp not null,
    aex_num numeric(8) not null,
    trxn_cd varchar(8) not null,
    acct_mne_cd varchar(8),
    cr_or_dr varchar(1) not null,
    acct_gen_amt numeric(13,2) not null,
    reasn_code varchar(3) not null,
    eff_dt timestamp not null,
    crcy_code varchar(2) not null,
    acct_num varchar(8),
    plan_code varchar(5),
    vers_num varchar(2),
    prod_code varchar(5),
    extract_typ varchar(1) not null,
    feed_ind varchar(1) not null,
    fund_id varchar(2),
    jrnl_typ varchar(5),
    legal_id varchar(4),
    lob varchar(2),
    par_ind varchar(1),
    reins_ind varchar(1),
    terr_cd varchar(2),
    wrk_area varchar(4),
    cli_num varchar(13),
    thi_aex_num numeric(4),
    fnd_id varchar(5),
    fnd_vers varchar(6),
    report_no numeric(3),
    trxn_id varchar(15),
    undo_trxn_id varchar(15),
    user_id varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.tacct_extracts_histories (
    pol_num varchar(10) not null,
    trxn_dt timestamp not null,
    aex_num numeric(8) not null,
    trxn_cd varchar(8) not null,
    acct_mne_cd varchar(8),
    cr_or_dr varchar(1) not null,
    acct_gen_amt numeric(13,2) not null,
    reasn_code varchar(3) not null,
    eff_dt timestamp not null,
    crcy_code varchar(2) not null,
    acct_num varchar(8),
    plan_code varchar(5),
    vers_num varchar(2),
    prod_code varchar(5),
    extract_typ varchar(1) not null,
    feed_ind varchar(1) not null,
    fund_id varchar(2),
    jrnl_typ varchar(1),
    legal_id varchar(4),
    lob varchar(2),
    par_ind varchar(1),
    reins_ind varchar(1),
    terr_cd varchar(2),
    wrk_area varchar(4),
    cli_num varchar(13)
);

CREATE TABLE IF NOT EXISTS cas.tacct_extracts_info (
    pol_num varchar(10) not null,
    trxn_dt timestamp not null,
    aex_num numeric(8) not null,
    payee varchar(100),
    claimant varchar(100),
    clmout_case_no varchar(10),
    acct_gen_amt numeric,
    reasn_code varchar(10),
    plan_code varchar(10),
    vers_num varchar(10),
    trxn_cd varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tacct_extracts_mp_th (
    aex_num_mp numeric(8) not null,
    trxn_dt timestamp not null,
    cr_or_dr varchar(1) not null,
    acct_mne_cd varchar(8) not null,
    acct_gen_amt numeric(13,2) not null,
    reasn_code varchar(3) not null,
    pol_ind varchar(3),
    pol_num varchar(10),
    plan_code varchar(5),
    vers_num varchar(2),
    ref_num varchar(10),
    trxn_id varchar(15),
    legal_id varchar(4),
    fund_id varchar(2),
    lob varchar(2),
    prod_code varchar(5),
    terr_cd varchar(2),
    reins_ind varchar(1),
    wrk_area varchar(4),
    par_ind varchar(1),
    sun_acct_num varchar(10) not null,
    t0 varchar(10),
    t1 varchar(10),
    t2 varchar(10),
    t3 varchar(10),
    t4 varchar(10),
    t5 varchar(10),
    t6 varchar(10),
    t7 varchar(10),
    t8 varchar(10),
    t9 varchar(10),
    src_ref_typ varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tacct_extracts_th (
    pol_num varchar(10) not null,
    trxn_dt timestamp not null,
    aex_num numeric(8) not null,
    cr_or_dr varchar(1) not null,
    acct_gen_amt numeric(13,2) not null,
    sun_acct_num varchar(10) not null,
    t0 varchar(10),
    t1 varchar(10),
    t2 varchar(10),
    t3 varchar(10),
    t4 varchar(10),
    t5 varchar(10),
    t6 varchar(10),
    t7 varchar(10),
    t8 varchar(10),
    t9 varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tacct_link_setups (
    acct_link_typ varchar(10) not null,
    acct_typ varchar(2) not null,
    seq_num numeric(5) not null,
    dr_acct_mne_cd varchar(8),
    cr_acct_mne_cd varchar(8)
);

CREATE TABLE IF NOT EXISTS cas.tacct_pallm_cas (
    pallm_pol_num varchar(10),
    pallm_trxn_dt timestamp,
    pallm_acct_num varchar(20),
    pallm_acct_desc varchar(50),
    pallm_acct_credit numeric(15,2),
    pallm_acct_debit numeric(15,2),
    cas_pol_num varchar(10),
    cas_trxn_dt timestamp,
    cas_acct_num varchar(20),
    cas_acct_credit numeric(15,2),
    cas_acct_debit numeric(15,2),
    cas_acct_desc varchar(50),
    cas_eff_dt timestamp,
    cas_aex_num numeric(10),
    cas_plan_code varchar(5),
    cas_trxn_cd varchar(10),
    cas_acct_mne_cd varchar(10),
    cas_reasn_code varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.tactivity_logs (
    pol_num varchar(10) not null,
    actv_dt timestamp not null,
    asc_num numeric(4) not null,
    actv_reasn varchar(10) not null,
    actv_typ varchar(3) not null,
    trxn_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tactivity_schedules (
    pol_num varchar(10) not null,
    actv_dt timestamp not null,
    asc_num numeric(4) not null,
    actv_reasn varchar(10) not null,
    actv_typ varchar(3) not null,
    actv_seq numeric(2),
    proc_dt timestamp,
    ref_date varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.tactivity_schedules_all (
    pol_num varchar(10) not null,
    actv_dt timestamp not null,
    asc_num numeric(4) not null,
    actv_reasn varchar(10) not null,
    actv_typ varchar(3) not null
);

CREATE TABLE IF NOT EXISTS cas.tactivity_schedules_backup (
    pol_num varchar(10) not null,
    actv_dt timestamp not null,
    asc_num numeric(4) not null,
    actv_reasn varchar(10) not null,
    actv_typ varchar(3) not null,
    actv_seq numeric(2),
    proc_dt timestamp,
    ref_date varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.tactivity_schedules_before (
    pol_num varchar(10) not null,
    actv_dt timestamp not null,
    asc_num numeric(4) not null,
    actv_reasn varchar(10) not null,
    actv_typ varchar(3) not null,
    actv_seq numeric(2),
    proc_dt timestamp,
    ref_date varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.taddress_change_pol_sg (
    batch_request numeric(10) not null,
    chng_request numeric(10) not null,
    cli_num varchar(10) not null,
    pol_num varchar(10) not null,
    addr_typ numeric(2) not null,
    addr_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.taddress_change_sg (
    batch_request numeric(10) not null,
    chng_request numeric(10) not null,
    cli_num varchar(10) not null,
    addr_typ varchar(1) not null,
    addr_1 varchar(60),
    addr_2 varchar(60),
    addr_3 varchar(60),
    addr_4 varchar(60),
    zip_code varchar(6)
);

CREATE TABLE IF NOT EXISTS cas.tclient_details (
    cli_num varchar(13) not null,
    terr_cd varchar(2) not null,
    state_cd varchar(2) not null,
    cli_nm varchar(60) not null,
    smkr_code varchar(1) not null,
    addr_typ numeric(2),
    birth_dt timestamp,
    fax_num varchar(20),
    id_num varchar(20),
    othr_phon_num varchar(20),
    prim_phon_num varchar(20),
    cli_rmrk varchar(500),
    sex_code varchar(1),
    cli_cnsldt_ind varchar(1),
    id_typ varchar(1),
    occp_code varchar(10),
    offce_addr_typ numeric(2),
    bill_addr_typ numeric(2),
    reg_addr_typ numeric(2),
    soldier_ind varchar(1) not null,
    res_addr_typ numeric(2),
    email_add varchar(40),
    hp_num varchar(20),
    cli_title varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.tadd_client_info (
    cli_num varchar(13) not null,
    field1 varchar(100),
    field2 varchar(100),
    field3 varchar(100),
    field4 varchar(100),
    field5 varchar(100),
    field6 varchar(100),
    field7 varchar(100),
    field8 varchar(100),
    field9 varchar(100),
    field10 varchar(100),
    field11 varchar(100),
    field12 varchar(100),
    field13 varchar(100),
    field14 varchar(100),
    field15 varchar(100),
    field16 varchar(100),
    field17 varchar(100),
    field18 varchar(100),
    field19 varchar(100),
    field20 varchar(100)
);

CREATE TABLE IF NOT EXISTS cas.tadd_client_labels (
    label1 varchar(30),
    label2 varchar(30),
    label3 varchar(30),
    label4 varchar(30),
    label5 varchar(30),
    label6 varchar(30),
    label7 varchar(30),
    label8 varchar(30),
    label9 varchar(30),
    label10 varchar(30),
    label11 varchar(30),
    label12 varchar(30),
    label13 varchar(30),
    label14 varchar(30),
    label15 varchar(30),
    label16 varchar(30),
    label17 varchar(30),
    label18 varchar(30),
    label19 varchar(30),
    label20 varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.tadd_policy_info (
    pol_num varchar(10) not null,
    field1 timestamp,
    field2 varchar(100),
    field3 varchar(100),
    field4 varchar(100),
    field5 varchar(100),
    field6 varchar(100),
    field7 varchar(100),
    field8 varchar(100),
    field9 varchar(100),
    field10 varchar(100),
    field11 varchar(100),
    field12 varchar(100),
    field13 varchar(100),
    field14 varchar(100),
    field15 varchar(100),
    field16 varchar(100),
    field17 varchar(100),
    field18 varchar(100),
    field19 varchar(100),
    field20 varchar(100)
);

CREATE TABLE IF NOT EXISTS cas.tadv_acct_coa_th (
    acct_mne_cd varchar(8) not null,
    cr_or_dr varchar(1) not null,
    dr_adv_mne_cd varchar(8),
    cr_adv_mne_cd varchar(8),
    prorate_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tadv_acct_ext_th (
    pol_num varchar(10) not null,
    trxn_dt timestamp not null,
    aex_num numeric(8) not null,
    trxn_cd varchar(8) not null,
    acct_mne_cd varchar(8),
    cr_or_dr varchar(1) not null,
    acct_gen_amt numeric(13,2) not null,
    reasn_code varchar(3) not null,
    eff_dt timestamp not null,
    crcy_code varchar(2) not null,
    acct_num varchar(8),
    plan_code varchar(5),
    vers_num varchar(2),
    prod_code varchar(5),
    extract_typ varchar(1) not null,
    feed_ind varchar(1) not null,
    fund_id varchar(2),
    jrnl_typ varchar(5),
    legal_id varchar(4),
    lob varchar(2),
    par_ind varchar(1),
    reins_ind varchar(1),
    terr_cd varchar(2),
    wrk_area varchar(4),
    cli_num varchar(13),
    thi_aex_num numeric(4),
    fnd_id varchar(5),
    fnd_vers varchar(6),
    report_no numeric(3),
    trxn_id varchar(15),
    undo_trxn_id varchar(15),
    user_id varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.tagency_contest_sg (
    pol_num varchar(10),
    pol_stat_cd varchar(1),
    plan_code varchar(5),
    plan_code_base varchar(5),
    agt_code varchar(5),
    rank_cd varchar(5),
    agt_status varchar(1),
    orig_agt_cde varchar(6),
    owner_stat varchar(1),
    reasn_cd varchar(3),
    splt_rt numeric(6,2),
    insrd_nm varchar(60),
    submt_dt timestamp,
    crr_trxn_dt timestamp,
    fran_num varchar(5),
    pmt_mode varchar(2),
    nac numeric(9),
    double_nac numeric(9),
    contest_nac numeric(9),
    unit_code varchar(5),
    br_code varchar(5),
    comp_prvd_num varchar(3),
    prvd_desc varchar(50),
    date_cr timestamp,
    date_am timestamp,
    user_cr varchar(50),
    user_am varchar(50),
    contest_type varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.tagent_connection (
    agt_code varchar(6) not null,
    agt_pw varchar(10) not null,
    rank varchar(3) not null,
    rec_status varchar(1) not null,
    pwd_exp_dt timestamp not null,
    lock_status varchar(1) default 'N',
    lst_trxn_dt timestamp,
    invalid_login_cnt numeric(2)
);

CREATE TABLE IF NOT EXISTS cas.tagent_info_th (
    agt_code varchar(5) not null,
    agt_occp_cd varchar(2),
    agt_lic_eff_dt timestamp,
    agt_lic_xpry_dt timestamp,
    agt_lic_num varchar(20),
    agt_lic_dur numeric(2),
    agt_nmed_eff_dt timestamp,
    agt_nmed_xpry_dt timestamp,
    agt_nmed_lic_num varchar(20),
    agt_titl varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.tagent_notices (
    pol_num varchar(10) not null,
    agt_code varchar(6) not null,
    notice_cd varchar(6) not null,
    notice_dt timestamp not null,
    seq_num numeric not null,
    owner_nm varchar(60) not null,
    send_to varchar(1) not null,
    query_cd_1 varchar(2),
    query_cd_2 varchar(2),
    query_cd_3 varchar(2),
    query_cd_4 varchar(2),
    query_cd_5 varchar(2),
    query_cd_6 varchar(2),
    query_cd_7 varchar(2),
    query_cd_8 varchar(2),
    query_cd_9 varchar(2),
    query_cd_10 varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tagent_notice_messages (
    notice_cd varchar(6) not null,
    msg_seq numeric(2) not null,
    send_to varchar(6) not null,
    msg_text varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.tagent_notice_parameters (
    pol_num varchar(10) not null,
    agt_code varchar(6) not null,
    notice_cd varchar(6) not null,
    notice_dt timestamp not null,
    seq_num numeric not null,
    msg_seq numeric(2) not null,
    msg_parm varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.tagent_profiles_sh (
    agt_code varchar(5) not null,
    agt_user varchar(30) not null,
    rec_status varchar(1) not null,
    def_printer varchar(10),
    pwd_exp_dt timestamp,
    agt_pwd varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tagt_misc_charges (
    agt_code varchar(6) not null,
    pol_num varchar(10),
    pd_to_dt timestamp,
    acct_mne_cd varchar(8) not null,
    trxn_dt timestamp not null,
    trxn_amt numeric(11,2),
    proc_amt numeric(11,2),
    reasn_code varchar(3) not null,
    ref_typ varchar(1) not null,
    ref_num numeric(9) not null,
    trxn_status varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tagt_nb_case_tw (
    trxn_dt timestamp,
    agt_code varchar(5),
    nb_case numeric(8,2) default 0,
    self_case numeric(8,2) default 0,
    rel_case numeric(8,2) default 0
);

CREATE TABLE IF NOT EXISTS cas.talpha_search_config (
    terr_cd varchar(2) not null,
    config_typ varchar(2) not null,
    fld_nm varchar(50) not null,
    config_id varchar(100) not null,
    config_valu varchar(255),
    include_lower varchar(1),
    lower_limit varchar(255),
    include_upper varchar(1),
    upper_limit varchar(255),
    output_result varchar(255) not null,
    msg_id varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.talpha_search_log (
    request_id varchar(15) not null,
    log_seq numeric not null,
    log_msg varchar(1000),
    log_date timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS cas.tams_clr_case (
    sbmt_dt timestamp,
    pol_iss_dt timestamp,
    pol_eff_dt timestamp,
    pol_stat_cd varchar(1),
    plan_code_base varchar(5),
    pol_num varchar(10),
    agt_nm varchar(40),
    wa_cd_1 varchar(6),
    rank_cd varchar(5),
    pol_trmn_dt timestamp,
    rescission_dt timestamp,
    cntrct_sign_dt timestamp,
    agt_term_dt timestamp,
    trmn_reasn varchar(5),
    cli_nm varchar(60),
    pol_stat varchar(20),
    cntrct_eff_dt timestamp,
    cur_prodn_mth numeric(38),
    prod_mth_1 numeric(38),
    prod_mth_2 numeric(38),
    prod_mth_3 numeric(38),
    prod_mth_4 numeric(38),
    prod_mth_5 numeric(38),
    prod_mth_6 numeric(38),
    prod_mth_7 numeric(38),
    prod_mth_8 numeric(38),
    prod_mth_9 numeric(38),
    prod_mth_10 numeric(38),
    prod_mth_11 numeric(38),
    prod_mth_12 numeric(38),
    recis_mth_1 numeric(38),
    recis_mth_2 numeric(38),
    recis_mth_3 numeric(38),
    recis_mth_4 numeric(38),
    recis_mth_5 numeric(38),
    recis_mth_6 numeric(38),
    recis_mth_7 numeric(38),
    recis_mth_8 numeric(38),
    recis_mth_9 numeric(38),
    recis_mth_10 numeric(38),
    recis_mth_11 numeric(38),
    recis_mth_12 numeric(38),
    um_nm varchar(40),
    um_cd varchar(5),
    amt_payable_mgr char(1),
    unit_cd varchar(5),
    branch_cd varchar(5),
    branch varchar(40),
    rfr_nm varchar(40),
    rfr_cd varchar(5),
    rfr_term_dt timestamp,
    amt_payable_rfr char(1),
    rpt_mth varchar(4),
    comp_prvd_num varchar(3),
    prvd_desc varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.tams_clr_case_03 (
    sbmt_dt timestamp,
    pol_iss_dt timestamp,
    pol_eff_dt timestamp,
    pol_stat_cd varchar(1),
    plan_code_base varchar(5),
    pol_num varchar(10),
    agt_nm varchar(40),
    wa_cd_1 varchar(6),
    rank_cd varchar(5),
    pol_trmn_dt timestamp,
    rescission_dt timestamp,
    cntrct_sign_dt timestamp,
    agt_term_dt timestamp,
    trmn_reasn varchar(5),
    cli_nm varchar(60),
    pol_stat varchar(20),
    cntrct_eff_dt timestamp,
    comp_prvd_num varchar(3),
    prvd_desc varchar(50),
    cur_prodn_mth numeric(38),
    prod_mth_1 numeric(6,2),
    prod_mth_2 numeric(6,2),
    prod_mth_3 numeric(6,2),
    prod_mth_4 numeric(6,2),
    prod_mth_5 numeric(6,2),
    prod_mth_6 numeric(6,2),
    prod_mth_7 numeric(6,2),
    prod_mth_8 numeric(6,2),
    prod_mth_9 numeric(6,2),
    prod_mth_10 numeric(6,2),
    prod_mth_11 numeric(6,2),
    prod_mth_12 numeric(6,2),
    recis_mth_1 numeric(6,2),
    recis_mth_2 numeric(6,2),
    recis_mth_3 numeric(6,2),
    recis_mth_4 numeric(6,2),
    recis_mth_5 numeric(6,2),
    recis_mth_6 numeric(6,2),
    recis_mth_7 numeric(6,2),
    recis_mth_8 numeric(6,2),
    recis_mth_9 numeric(6,2),
    recis_mth_10 numeric(6,2),
    recis_mth_11 numeric(6,2),
    recis_mth_12 numeric(6,2),
    um_nm varchar(40),
    um_cd varchar(5),
    amt_payable_mgr char(1),
    unit_cd varchar(5),
    branch_cd varchar(5),
    branch varchar(40),
    rfr_nm varchar(40),
    rfr_cd varchar(5),
    rfr_term_dt timestamp,
    amt_payable_rfr char(1),
    rpt_mth varchar(4)
);

CREATE TABLE IF NOT EXISTS cas.tanty_mvmt_histories (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    eff_dt timestamp not null,
    trxn_dt timestamp not null,
    seq_num numeric(5) not null,
    trxn_typ varchar(8),
    trxn_amt numeric(13,2),
    gurt_bnft numeric(13,2),
    gurt_amt numeric(13,2),
    life_incm numeric(13,2),
    fnd_valu numeric(13,2),
    bns_amt numeric(13,2),
    chrg_amt numeric(13,2),
    rmn_gurt_amt numeric(13,2),
    rmn_life_incm numeric(13,2),
    anty_wthdr numeric(13,2),
    intl_cd varchar(2),
    dth_bnft_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tanty_surr_charges (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    eff_dt timestamp not null,
    payo_term numeric(2) not null,
    fr_eff_age numeric(3) not null,
    to_eff_age numeric(3) not null,
    eff_dur numeric(3) not null,
    payo_freq numeric(2),
    chrg_basis_nm varchar(30),
    chrg_rt numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.tanty_values (
    plan_grp_nm varchar(20) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    set_opt varchar(2) not null,
    eff_dur numeric(2) not null,
    anty_bnft_typ varchar(2) not null,
    anty_base varchar(2),
    anty_rt numeric(12,6),
    anty_rt_base numeric(10)
);

CREATE TABLE IF NOT EXISTS cas.tapl_rules_th (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    rule_code varchar(2),
    rule_eff_dt timestamp not null,
    max_apl_cnt numeric(4),
    reset_apl_cnt varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tassignee_details (
    pol_num varchar(10) not null,
    ade_num numeric(4) not null,
    asign_nm varchar(60) not null,
    id_num varchar(20) not null,
    asign_dt timestamp not null,
    addr_1 varchar(60),
    addr_2 varchar(60),
    addr_3 varchar(60),
    addr_4 varchar(60),
    zip_code varchar(6),
    asign_amt numeric(11,2),
    asign_title varchar(20),
    payo_bank_cd varchar(13),
    bank_acct_nm varchar(40),
    bank_acct_num varchar(20),
    bank_acct_id_num varchar(20),
    bank_acct_id_typ varchar(1),
    bank_acct_title varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.taudit_trail (
    trxn_dt timestamp not null,
    audit_type varchar(40),
    atr_num numeric(8) not null,
    trxn_tbl varchar(1),
    plan_code varchar(5),
    pol_cli_num varchar(13) not null,
    fld_nm varchar(30),
    old_valu varchar(60),
    new_valu varchar(60),
    user_name varchar(20),
    cas_dt timestamp,
    vers_num varchar(2),
    cli_num varchar(13),
    cvg_eff_dt timestamp,
    face_amt numeric(13,2),
    dth_bnft_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.taudit_trail_histories (
    trxn_dt timestamp not null,
    audit_type varchar(40),
    atr_num numeric(8) not null,
    trxn_tbl varchar(1),
    plan_code varchar(5),
    pol_cli_num varchar(10),
    fld_nm varchar(30),
    old_valu varchar(30),
    new_valu varchar(30),
    user_name varchar(20),
    cas_dt timestamp,
    vers_num varchar(2),
    cli_num varchar(13),
    cvg_eff_dt timestamp,
    face_amt numeric(13,2),
    dth_bnft_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tautofeed_hdrctl_layout_sg (
    bank_code varchar(6),
    file_name varchar(20),
    scheme_type_pos numeric(3),
    scheme_type_len numeric(3),
    trxn_cd_pos numeric(3),
    trxn_cd_len numeric(3),
    co_cd_pos numeric(3),
    co_cd_len numeric(3),
    trxn_dt_pos numeric(3),
    trxn_dt_len numeric(3),
    trxn_dt_format varchar(10),
    trxn_time_pos numeric(3),
    trxn_time_len numeric(3),
    trxn_time_format varchar(10),
    trxn_sn_pos numeric(3),
    trxn_sn_len numeric(3),
    app_dt_pos numeric(3),
    app_dt_len numeric(3),
    app_dt_format varchar(10),
    eff_pay_dt_pos numeric(3),
    eff_pay_dt_len numeric(3),
    eff_pay_dt_format varchar(10),
    tot_rec_pos numeric(3),
    tot_rec_len numeric(3),
    hash_total_pos numeric(3),
    hash_total_len numeric(3),
    tot_amt_approved_pos numeric(3),
    tot_amt_approved_len numeric(3),
    tot_amt_approved_dec numeric(3),
    tot_qty_approved_pos numeric(3),
    tot_qty_approved_dec numeric(3),
    tot_qty_approved_len numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tautofeed_hdrctl_sg (
    bank_code varchar(6),
    file_name varchar(20),
    scheme_type varchar(6),
    trxn_cd varchar(6),
    co_cd varchar(10),
    trxn_dt timestamp,
    trxn_time varchar(10),
    trxn_sn varchar(8),
    app_dt timestamp,
    eff_pay_dt timestamp,
    tot_rec varchar(7),
    hash_total varchar(15),
    tot_amt_approved numeric(15,2),
    tot_qty_approved numeric(14,4)
);

CREATE TABLE IF NOT EXISTS cas.tautopay_day (
    run_dt timestamp not null,
    fr_dt timestamp not null,
    to_dt timestamp not null,
    run_num numeric(2) not null,
    bank_deb_dt timestamp not null,
    clr_pac_ind varchar(1),
    plan_code varchar(5) not null,
    file_rtn_dt timestamp,
    bill_mthd varchar(1) not null,
    fran_num varchar(4) not null,
    ap_status varchar(1),
    ap_tot_rec numeric(6),
    ap_tot_prem numeric(13,2),
    date_cr timestamp,
    date_am timestamp,
    user_cr varchar(15),
    user_am varchar(15)
);

CREATE TABLE IF NOT EXISTS cas.tautopay_day_tm (
    run_dt timestamp not null,
    fr_dt timestamp,
    to_dt timestamp,
    run_num numeric(2) not null,
    bank_deb_dt timestamp not null,
    clr_pac_ind varchar(1),
    plan_code varchar(5) not null,
    file_rtn_dt timestamp,
    bill_mthd varchar(1) not null,
    fran_num varchar(4) not null,
    ap_status varchar(1),
    ap_tot_rec numeric(6),
    ap_tot_prem numeric(13,2),
    date_cr timestamp,
    date_am timestamp,
    user_cr varchar(15),
    user_am varchar(15)
);

CREATE TABLE IF NOT EXISTS cas.tautopay_extract_sg (
    trxn_dt timestamp,
    pol_num varchar(10),
    pd_to_dt timestamp,
    prem numeric(11,2),
    bank_cd varchar(13),
    bank_acct_num varchar(20),
    bank_sv_kd varchar(1),
    id_num varchar(20),
    pac_bk_ctr varchar(1),
    client_nm varchar(80),
    bank_acct_nm varchar(60),
    div_amt numeric(11,2),
    exchg_rt numeric(18,8),
    owner_cli_num varchar(10),
    owner_cli_nm varchar(40),
    pol_crcy_code varchar(2),
    pol_crcy_prem numeric(11,2),
    run_dt timestamp,
    bank_fee_ind varchar(1),
    bank_fee_amt numeric(11,4),
    bill_amt numeric(11,2),
    bank_debit_dt timestamp,
    fran_num varchar(4)
);

CREATE TABLE IF NOT EXISTS cas.tautopay_histories (
    trxn_dt timestamp,
    pol_num varchar(10),
    pd_to_dt timestamp,
    prem numeric(11,2),
    bank_cd varchar(13),
    bank_acct_num varchar(20),
    bank_sv_kd varchar(1),
    id_num varchar(20),
    pac_bk_ctr varchar(1),
    client_nm varchar(60),
    pol_crcy_code varchar(2),
    pol_crcy_prem numeric(11,2),
    exchg_rt numeric(18,8),
    run_dt timestamp,
    autopay_status varchar(1),
    reject_reasn numeric(2),
    trxn_id varchar(15),
    autopay_col_dt timestamp,
    autopay_reject_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tautopay_histories_th (
    trxn_dt timestamp,
    pol_num varchar(10),
    pd_to_dt timestamp,
    prem numeric(11,2),
    bank_cd varchar(13),
    bank_acct_num varchar(20),
    bank_sv_kd varchar(1),
    id_num varchar(20),
    pac_bk_ctr varchar(1),
    client_nm varchar(80),
    pol_crcy_code varchar(2),
    pol_crcy_prem numeric(11,2),
    exchg_rt numeric(18,8),
    run_dt timestamp,
    autopay_status varchar(1),
    reject_reasn_cd varchar(10),
    trxn_id varchar(15),
    autopay_col_dt timestamp,
    autopay_reject_dt timestamp,
    bank_debit_dt timestamp,
    trxn_amt numeric(11,2),
    bank_fee_ind varchar(1),
    bank_fee_amt numeric(11,4),
    bill_mthd varchar(1),
    fran_num varchar(4),
    acct_typ varchar(1),
    acct_xpry_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tautopay_reject_day (
    reject_day timestamp not null
);

CREATE TABLE IF NOT EXISTS cas.tautopay_setup (
    run_num numeric(2) not null,
    bill_day numeric(2) not null,
    end_day numeric(2) not null,
    start_day numeric(2) not null,
    catchup_run_num numeric(2) not null,
    open_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tauto_feed_files (
    bank_code varchar(13),
    file_name varchar(35),
    dataline varchar(2000),
    result_cd varchar(5),
    pol_num varchar(20),
    trxn_amt numeric(11,2),
    trxn_dt timestamp,
    file_num varchar(5),
    feed_date timestamp,
    acct_num varchar(30),
    off_loc_cd varchar(5),
    dist_chnl_cd varchar(2),
    crcy_code varchar(2),
    c_cpf_inv_acct varchar(20),
    c_nric_no varchar(20),
    c_cust_name varchar(80),
    c_authorise varchar(1),
    c_pol_name varchar(40),
    c_collect_ind varchar(1),
    c_batch_serial varchar(6),
    c_internal_ref varchar(20),
    h_cpf_acct varchar(9),
    h_house_ref varchar(30),
    h_name varchar(66),
    h_coy_cde varchar(2),
    reject_cd varchar(10),
    bank_cd varchar(13),
    bank_deb_dt timestamp,
    pac_upd varchar(1),
    prem_amt numeric(11,2),
    bank_fee_ind varchar(1),
    bank_fee_amt numeric(11,4),
    pd_to_dt timestamp,
    bill_mthd varchar(1),
    fran_num varchar(4),
    acct_typ varchar(5),
    acct_xpry_dt timestamp,
    branch_cd varchar(20),
    payment_ref varchar(200),
    batch_seq numeric(10),
    deposit_slip_num varchar(30),
    reasn_code varchar(3),
    status_cd varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tauto_feed_files_bk_2024 (
    bank_code varchar(13),
    file_name varchar(35),
    dataline varchar(2000),
    result_cd varchar(5),
    pol_num varchar(20),
    trxn_amt numeric(11,2),
    trxn_dt timestamp,
    file_num varchar(5),
    feed_date timestamp,
    acct_num varchar(30),
    off_loc_cd varchar(5),
    dist_chnl_cd varchar(2),
    crcy_code varchar(2),
    c_cpf_inv_acct varchar(20),
    c_nric_no varchar(20),
    c_cust_name varchar(80),
    c_authorise varchar(1),
    c_pol_name varchar(40),
    c_collect_ind varchar(1),
    c_batch_serial varchar(6),
    c_internal_ref varchar(20),
    h_cpf_acct varchar(9),
    h_house_ref varchar(30),
    h_name varchar(66),
    h_coy_cde varchar(2),
    reject_cd varchar(10),
    bank_cd varchar(13),
    bank_deb_dt timestamp,
    pac_upd varchar(1),
    prem_amt numeric(11,2),
    bank_fee_ind varchar(1),
    bank_fee_amt numeric(11,4),
    pd_to_dt timestamp,
    bill_mthd varchar(1),
    fran_num varchar(4),
    acct_typ varchar(5),
    acct_xpry_dt timestamp,
    branch_cd varchar(20),
    payment_ref varchar(200),
    batch_seq numeric(10),
    deposit_slip_num varchar(30),
    reasn_code varchar(3),
    status_cd varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tauto_feed_layout (
    bank_code varchar(6),
    file_name varchar(35),
    result_cd_pos numeric(3),
    result_cd_len numeric(3),
    accept_cd varchar(5),
    reject_cd varchar(5),
    trxn_dt_pos numeric(3),
    trxn_dt_len numeric(3),
    trxn_dt_fmt varchar(15),
    trxn_amt_pos numeric(3),
    trxn_amt_len numeric(3),
    pol_num_pos numeric(3),
    pol_num_len numeric(3),
    file_num_pos numeric(3),
    file_num_len numeric(3),
    trxn_amt_dec_len numeric(1),
    acct_num_pos numeric(3),
    acct_num_len numeric(3),
    hdr_rcd_row numeric(3),
    tlr_rcd_row numeric(3),
    feed_typ varchar(1),
    clr_cd_pos numeric(3),
    clr_cd_len numeric(3),
    bank_cd_pos numeric(3),
    bank_cd_len numeric(3),
    chq_no_text_pos numeric(3),
    chq_no_text_len numeric(3),
    chq_dt_pos numeric(3),
    chq_dt_len numeric(3),
    off_rcpt_num_pos numeric(3),
    off_rcpt_num_len numeric(3),
    chnl_cd_pos numeric(3),
    chnl_cd_len numeric(3),
    loc_cd_pos numeric(3),
    loc_cd_len numeric(3),
    reasn_code_pos numeric(3),
    reasn_code_len numeric(3),
    crcy_code varchar(2),
    c_cpf_inv_acct_pos numeric(3),
    c_cpf_inv_acct_len numeric(3),
    c_nric_no_pos numeric(3),
    c_nric_no_len numeric(3),
    c_cust_name_pos numeric(3),
    c_cust_name_len numeric(3),
    c_authorise_pos numeric(3),
    c_authorise_len numeric(3),
    c_pol_name_len numeric(3),
    c_pol_name_pos numeric(3),
    c_batch_serial_pos numeric(3),
    c_batch_serial_len numeric(3),
    c_internal_ref_pos numeric(3),
    c_internal_ref_len numeric(3),
    h_cpf_acct_pos numeric(3),
    h_cpf_acct_len numeric(3),
    h_house_ref_pos numeric(3),
    h_house_ref_len numeric(3),
    h_name_pos numeric(3),
    h_name_len numeric(3),
    h_coy_cde_pos numeric(3),
    h_coy_cde_len numeric(3),
    org_amt_pos numeric(3),
    org_amt_len numeric(3),
    org_amt_dec_len numeric(3),
    reject_cd_pos numeric(3),
    reject_cd_len numeric(3),
    header_chk varchar(10),
    header_chk_pos numeric(3),
    header_chk_len numeric(3),
    print_report varchar(1),
    report_name varchar(20),
    feed_typ_pos numeric(3),
    feed_typ_len numeric(3),
    bank_typ_pos numeric(3),
    bank_typ_len numeric(3),
    brch_id_pos numeric(3),
    brch_id_len numeric(3),
    detail_accept_value varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tavail_cvgs (
    pol_num varchar(10),
    avail_cvg varchar(5),
    vers_num varchar(2),
    avail_cvg_desc varchar(50),
    fmly_cvg_ind varchar(1),
    cvg_typ varchar(1),
    mult_base_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tavail_plans (
    pol_num varchar(10),
    avail_plan_code varchar(5),
    vers_num varchar(2),
    avail_plan_desc varchar(50),
    fmly_cvg_ind varchar(1),
    cvg_typ varchar(1),
    mult_base_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tavy_accumulators (
    pol_num varchar(10) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cli_num varchar(13) not null,
    cvg_eff_dt timestamp not null,
    cvg_dur varchar(3) not null,
    seq_num numeric(3) not null,
    acum_cd varchar(20) not null,
    acum_bal numeric(20,10) not null,
    eff_dt timestamp,
    face_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tavy_lap (
    pol_num varchar(10) not null,
    endow_actv_dt timestamp,
    endow_int_acru numeric(9,2) not null,
    endow_bal numeric(13,2) not null,
    acum_actv_dt timestamp,
    acum_int_acru numeric(9,2) not null,
    acum_bal numeric(11,2) not null,
    prev_yr_accum_bal numeric(13,2) not null,
    prev_yr_endow_bal numeric(13,2) not null,
    anty_payo_amt numeric(13,2),
    anty_bal numeric(13,2),
    anty_int_acru numeric(9,2),
    anty_actv_dt timestamp,
    lump_sum_bal numeric(13,2),
    lump_sum_actv_dt timestamp,
    lump_sum_int_acru numeric(9,2),
    accum_trxn_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tavy_value_dtls (
    pol_num varchar(10) not null,
    endow_actv_dt timestamp,
    endow_int_acru numeric(9,2) default 0 not null,
    endow_bal numeric(13,2) default 0 not null,
    acum_actv_dt timestamp,
    acum_int_acru numeric(9,2) default 0 not null,
    acum_bal numeric(11,2) default 0 not null,
    prev_yr_accum_bal numeric(13,2) not null,
    prev_yr_endow_bal numeric(13,2) not null,
    anty_payo_amt numeric(13,2),
    anty_bal numeric(13,2),
    anty_int_acru numeric(9,2),
    anty_actv_dt timestamp,
    lump_sum_bal numeric(13,2),
    lump_sum_actv_dt timestamp,
    lump_sum_int_acru numeric(9,2),
    accum_trxn_dt timestamp,
    endow_adv numeric(11,2),
    endow_adv_dt timestamp,
    svg_actv_dt timestamp,
    svg_int_acru numeric(13,2),
    svg_bal numeric(13,2),
    csa_actv_dt timestamp,
    csa_int_acru numeric(9,2),
    csa_bal numeric(13,2),
    anty_payo_base numeric(13,2),
    anty_surr_chrg numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tavy_value_dtls_bf_re (
    pol_num varchar(10) not null,
    endow_actv_dt timestamp,
    endow_int_acru numeric(9,2) not null,
    endow_bal numeric(13,2) not null,
    acum_actv_dt timestamp,
    acum_int_acru numeric(9,2) not null,
    acum_bal numeric(11,2) not null,
    prev_yr_accum_bal numeric(13,2) not null,
    prev_yr_endow_bal numeric(13,2) not null,
    anty_payo_amt numeric(13,2),
    anty_bal numeric(13,2),
    anty_int_acru numeric(9,2),
    anty_actv_dt timestamp,
    lump_sum_bal numeric(13,2),
    lump_sum_actv_dt timestamp,
    lump_sum_int_acru numeric(9,2),
    accum_trxn_dt timestamp,
    endow_adv numeric(11,2),
    endow_adv_dt timestamp,
    svg_actv_dt timestamp,
    svg_int_acru numeric(13,2),
    svg_bal numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tbank_br_th (
    bank_cd varchar(13) not null,
    ct_asign_bank_cd varchar(10),
    ct_asign_br_cd varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tbank_cr_dr_card (
    bank_cd varchar(15),
    bu_bank_desc varchar(50),
    card_typ varchar(6),
    cr_dr_card varchar(5),
    prefix_card varchar(10),
    bank_allow varchar(5),
    bank_remrk varchar(100)
);

CREATE TABLE IF NOT EXISTS cas.tbank_details (
    bank_cd varchar(13) not null,
    bank_desc varchar(50) not null,
    company_id varchar(30),
    last_usd_btch_num varchar(3),
    otpt_file_name varchar(30),
    accept_fee numeric(11,4),
    acct_num_len numeric(2),
    reject_fee numeric(11,4)
);

CREATE TABLE IF NOT EXISTS cas.tbank_pol_bf_assign (
    pol_num varchar(10) not null,
    assign_dt timestamp,
    agt_code varchar(5),
    orig_agt_cde varchar(6),
    query_type varchar(1),
    old_agt_code varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.tbank_recon_sg (
    pol_num varchar(10) not null,
    trxn_dt timestamp,
    aex_num numeric(8),
    trxn_cd varchar(8),
    acct_mne_cd varchar(8),
    cr_or_dr varchar(1) not null,
    acct_gen_amt numeric(13,2),
    reasn_code varchar(3),
    eff_dt timestamp,
    crcy_code varchar(2) not null,
    acct_num varchar(8),
    btch_num varchar(5),
    btch_role varchar(2),
    btch_typ varchar(4),
    col_dis_trxn_dt timestamp,
    col_dis_trxn_cd varchar(8),
    col_dis_reasn_code varchar(3),
    col_dis_amt numeric(11,2),
    col_dis_eff_dt timestamp,
    col_dis_remarks varchar(100),
    chq_no_text varchar(20),
    chq_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tbank_staff_details_th (
    agt_code varchar(6) not null,
    bank_cd varchar(5) not null,
    brn_cd varchar(10) not null,
    staff_cd varchar(15) not null,
    staff_name varchar(50) not null,
    stat_cd varchar(1) not null,
    user_id varchar(30),
    create_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tbatch_print_jobs_sg (
    fcn_id varchar(20),
    fcn_desc varchar(60),
    request_date timestamp,
    output_opt varchar(1),
    prn_qty numeric(2),
    paper_typ varchar(2),
    fcn_count varchar(10),
    recvr_job varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tbeneficiary_details (
    pol_num varchar(10) not null,
    bde_num numeric(4) not null,
    bnfy_typ varchar(3) not null,
    bnfy_code varchar(3) not null,
    bnfy_nm varchar(60),
    birth_dt timestamp,
    id_num varchar(20),
    sex_code varchar(1),
    bnfy_pct numeric(5,2),
    bnfy_prty varchar(1),
    addr_1 varchar(60),
    addr_2 varchar(60),
    addr_3 varchar(60),
    addr_4 varchar(60),
    zip_code varchar(6),
    trustee_nm varchar(60),
    bnfy_title varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.tbeneficiary_details_bak_sg (
    pol_num varchar(10) not null,
    bde_num numeric(4) not null,
    bnfy_typ varchar(3) not null,
    bnfy_code varchar(3) not null,
    bnfy_nm varchar(60),
    birth_dt timestamp,
    id_num varchar(20),
    sex_code varchar(1),
    bnfy_pct numeric(5,2),
    bnfy_prty varchar(1),
    addr_1 varchar(60),
    addr_2 varchar(60),
    addr_3 varchar(60),
    addr_4 varchar(60),
    zip_code varchar(6),
    trustee_nm varchar(60)
);

CREATE TABLE IF NOT EXISTS cas.tbeneficiary_prt_seq (
    bnfy_prty varchar(1) not null,
    bnfy_code varchar(3) not null,
    bnfy_preset_desc varchar(30),
    seq_num numeric(10)
);

CREATE TABLE IF NOT EXISTS cas.tbiannual_statement_pol_sg (
    pol_num varchar(10),
    plan_desc varchar(60),
    owner varchar(60),
    addr_1 varchar(100),
    addr_2 varchar(100),
    addr_3 varchar(100),
    addr_4 varchar(100),
    agent varchar(80),
    unit varchar(80),
    insured varchar(100),
    seq_num numeric(5),
    tot_prem numeric(13,2),
    tot_with numeric(11,2),
    tot_loan numeric(13,2),
    tot_si numeric(13,2),
    tot_admin_chrg numeric(11,2),
    tot_other_chrg numeric(11,2),
    tot_unpaid_chrg numeric(11,2),
    fnd_1 varchar(5),
    fnd_1_desc varchar(200),
    fnd_1_open_bal numeric(20,5),
    fnd_1_tot_sales numeric(20,5),
    fnd_1_tot_pur numeric(20,5),
    fnd_1_closing_bal numeric(20,5),
    fnd_1_bid_pric numeric(20,10),
    fnd_2 varchar(5),
    fnd_2_desc varchar(200),
    fnd_2_open_bal numeric(20,5),
    fnd_2_tot_sales numeric(20,5),
    fnd_2_tot_pur numeric(20,5),
    fnd_2_closing_bal numeric(20,5),
    fnd_2_bid_pric numeric(20,10),
    fnd_3 varchar(5),
    fnd_3_desc varchar(200),
    fnd_3_open_bal numeric(20,5),
    fnd_3_tot_sales numeric(20,5),
    fnd_3_tot_pur numeric(20,5),
    fnd_3_closing_bal numeric(20,5),
    fnd_3_bid_pric numeric(20,10),
    fnd_4 varchar(5),
    fnd_4_desc varchar(200),
    fnd_4_open_bal numeric(20,5),
    fnd_4_tot_sales numeric(20,5),
    fnd_4_tot_pur numeric(20,5),
    fnd_4_closing_bal numeric(20,5),
    fnd_4_bid_pric numeric(20,10),
    fnd_5 varchar(5),
    fnd_5_desc varchar(200),
    fnd_5_open_bal numeric(20,5),
    fnd_5_tot_sales numeric(20,5),
    fnd_5_tot_pur numeric(20,5),
    fnd_5_closing_bal numeric(20,5),
    fnd_5_bid_pric numeric(20,10),
    fnd_6 varchar(5),
    fnd_6_desc varchar(200),
    fnd_6_open_bal numeric(20,5),
    fnd_6_tot_sales numeric(20,5),
    fnd_6_tot_pur numeric(20,5),
    fnd_6_closing_bal numeric(20,5),
    fnd_6_bid_pric numeric(20,10),
    fnd_7 varchar(5),
    fnd_7_desc varchar(200),
    fnd_7_open_bal numeric(20,5),
    fnd_7_tot_sales numeric(20,5),
    fnd_7_tot_pur numeric(20,5),
    fnd_7_closing_bal numeric(20,5),
    fnd_7_bid_pric numeric(20,10),
    fnd_8 varchar(5),
    fnd_8_desc varchar(200),
    fnd_8_open_bal numeric(20,5),
    fnd_8_tot_sales numeric(20,5),
    fnd_8_tot_pur numeric(20,5),
    fnd_8_closing_bal numeric(20,5),
    fnd_8_bid_pric numeric(20,10),
    fnd_9 varchar(5),
    fnd_9_desc varchar(200),
    fnd_9_open_bal numeric(20,5),
    fnd_9_tot_sales numeric(20,5),
    fnd_9_tot_pur numeric(20,5),
    fnd_9_closing_bal numeric(20,5),
    fnd_9_bid_pric numeric(20,10),
    fnd_10 varchar(5),
    fnd_10_desc varchar(200),
    fnd_10_open_bal numeric(20,5),
    fnd_10_tot_sales numeric(20,5),
    fnd_10_tot_pur numeric(20,5),
    fnd_10_closing_bal numeric(20,5),
    fnd_10_bid_pric numeric(20,10),
    fnd_11 varchar(5),
    fnd_11_desc varchar(200),
    fnd_11_open_bal numeric(20,5),
    fnd_11_tot_sales numeric(20,5),
    fnd_11_tot_pur numeric(20,5),
    fnd_11_closing_bal numeric(20,5),
    fnd_11_bid_pric numeric(20,10),
    fnd_12 varchar(5),
    fnd_12_desc varchar(200),
    fnd_12_open_bal numeric(20,5),
    fnd_12_tot_sales numeric(20,5),
    fnd_12_tot_pur numeric(20,5),
    fnd_12_closing_bal numeric(20,5),
    fnd_12_bid_pric numeric(20,10),
    surr_valu numeric(20,5),
    start_dt timestamp,
    end_dt timestamp,
    page_num numeric(10)
);

CREATE TABLE IF NOT EXISTS cas.tbixg_parameters (
    para_type varchar(40) not null,
    para_value varchar(500) not null,
    para_typ_desc varchar(100) not null,
    para_data_type varchar(40) not null
);

CREATE TABLE IF NOT EXISTS cas.tbonus_revision_plans (
    plan_code varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.tbonus_revision_pol_sg (
    pol_num varchar(10),
    cli_num varchar(10),
    addr_typ numeric(2),
    last_avy_dt timestamp,
    run_date timestamp
);

CREATE TABLE IF NOT EXISTS cas.tbonus_revision_run_month (
    run_mth numeric
);

CREATE TABLE IF NOT EXISTS cas.tbranches (
    br_code varchar(5) not null,
    br_nm varchar(40) not null,
    br_stat_code varchar(1) not null,
    br_phone varchar(20),
    loc_code varchar(10),
    agt_code varchar(6),
    br_addr varchar(90)
);

CREATE TABLE IF NOT EXISTS cas.tbranches_wk (
    br_code varchar(5) not null,
    br_nm varchar(40) not null,
    br_stat_code varchar(1) not null,
    br_phone varchar(20) not null,
    loc_code varchar(10),
    agt_code varchar(5),
    br_addr varchar(90)
);

CREATE TABLE IF NOT EXISTS cas.tbranches_wk_sh (
    br_code varchar(5) not null,
    br_nm varchar(40) not null,
    br_stat_code varchar(1) not null,
    br_phone varchar(20) not null,
    loc_code varchar(10),
    agt_code varchar(5),
    br_addr varchar(90)
);

CREATE TABLE IF NOT EXISTS cas.tbranch_coll_acct_th (
    srvc_ctr varchar(5) not null,
    btch_role varchar(1) not null,
    btch_typ varchar(4) not null,
    bank_cd varchar(13) not null,
    reasn_code varchar(4) not null,
    prod_cat varchar(1) not null,
    dr_or_cr varchar(1) not null,
    acct_mne_cd varchar(8)
);

CREATE TABLE IF NOT EXISTS cas.tbranch_office_th (
    br_code varchar(5) not null,
    br_off_code varchar(5) not null,
    adm_code varchar(6)
);

CREATE TABLE IF NOT EXISTS cas.tbr_nb_case_tw (
    trxn_dt timestamp not null,
    br_code varchar(5) not null,
    issue_case numeric(4),
    issue_prem numeric(11,2),
    unissue_case numeric(4),
    unissue_prem numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tcalendar (
    cas_dt timestamp,
    day_type varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tcampaigns (
    cmpn_code varchar(10) not null,
    cmpn_desc varchar(50),
    cmpn_strt_dt timestamp,
    cmpn_end_dt timestamp,
    acct_mne_cd_dr varchar(8),
    acct_mne_cd_cr varchar(8),
    cmpn_by_dist_chnl varchar(1) default 'N',
    ctl_lvl varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tcampaign_bonuses (
    cmpn_code varchar(10) not null,
    plan_code varchar(5) not null,
    plan_vers varchar(2) not null,
    crcy_code varchar(2) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    bonus_method numeric(1),
    bonus_pct numeric(5,2),
    band_fr numeric(13,2) not null,
    band_to numeric(13,2) not null,
    dur_fr numeric(3) not null,
    dur_to numeric(3) not null,
    acct_mne_cd varchar(8),
    to_age numeric(3) default -1 not null,
    fr_age numeric(3) default -1 not null,
    payo_freq numeric(2),
    dist_chnl_cd varchar(2) default '*' not null,
    spec_ctl_nm varchar(10),
    acct_mne_cd_cr varchar(8)
);

CREATE TABLE IF NOT EXISTS cas.tcampaign_discounts (
    cmpn_code varchar(10) not null,
    plan_code varchar(5) not null,
    plan_vers varchar(2) not null,
    crcy_code varchar(2) not null,
    chrg_cat varchar(10) not null,
    chrg_typ varchar(10) not null,
    duration numeric(3),
    dscnt_factor_k numeric(5,2),
    dscnt_constant_k numeric(5),
    dscnt_factor_c numeric(5,2),
    dscnt_constant_c numeric(5),
    dist_chnl_cd varchar(2) default '*'
);

CREATE TABLE IF NOT EXISTS cas.tcascpthr0001 (
    request_id numeric,
    proc_dt timestamp,
    rpt_mode varchar(1),
    cli_nm varchar(101),
    birth_dt timestamp,
    sex_code varchar(1),
    cli_num varchar(13),
    id_num varchar(30),
    trxn_dt timestamp,
    pol_num varchar(10),
    plan_code_base varchar(5),
    agt_code varchar(6),
    agt_nm varchar(60),
    btch_typ varchar(4),
    btch_num varchar(20),
    reasn_code varchar(3),
    col_crcy_code varchar(2),
    col_trxn_amt numeric(13,2),
    local_crcy_code varchar(2),
    local_trxn_amt numeric(13,2),
    exh_rt numeric(18,8)
);

CREATE TABLE IF NOT EXISTS cas.tcascpthr0001_hdr (
    request_id numeric,
    proc_dt timestamp,
    rpt_mode varchar(1),
    period numeric,
    fr_dt timestamp,
    to_dt timestamp,
    local_crcy_code varchar(2),
    threshold numeric(10),
    country_cd varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tcash_batch_details (
    btch_num varchar(20) not null,
    btch_role varchar(2) not null,
    pol_num varchar(10) not null,
    cbd_num numeric(4) not null,
    eff_dt timestamp not null,
    trxn_dt timestamp not null,
    trxn_cd varchar(8) not null,
    reasn_code varchar(3) not null,
    trxn_amt numeric(11,2) not null,
    remarks varchar(100),
    btch_dtl_stat_cd varchar(1),
    result_cd varchar(5),
    clr_cd varchar(2),
    bank_cd varchar(13),
    chq_no_text varchar(20),
    chq_dt timestamp,
    off_rcpt_num numeric(10),
    acct_mne_cd varchar(8),
    card_xpry_dt varchar(4),
    check_amt numeric(13,2),
    check_num varchar(8),
    collect_dt timestamp,
    col_crcy_code varchar(2),
    col_trxn_amt numeric(11,2),
    credit_num varchar(16),
    dnr_reasn_code varchar(10),
    exchg_rt numeric(18,8),
    indirect varchar(1),
    iss_bank varchar(30),
    pd_to_dt timestamp,
    pmt_mode varchar(5),
    receipt_num varchar(7),
    report_no numeric(3),
    trxn_id varchar(15),
    auto_ur_fail_ind varchar(1),
    no_pol_crcy_ind varchar(1),
    card_typ varchar(1),
    card_cat varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tcash_batch_headers (
    btch_num varchar(20) not null,
    btch_role varchar(2) not null,
    btch_dt timestamp,
    btch_typ varchar(4) not null,
    btch_tot numeric(13,2) not null,
    crcy_code varchar(2) not null,
    btch_stat_code varchar(1) not null,
    recpt_stat_code varchar(1) not null,
    trxn_dt timestamp not null,
    user_id varchar(30) default user,
    dist_chnl_cd varchar(2),
    off_loc_cd varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.tcas_ap_bill (
    bill_mth varchar(1) not null,
    fran_num varchar(4) not null,
    bill_dt timestamp not null,
    batch_no varchar(6),
    bank_cd varchar(13),
    bank_acct_num varchar(20),
    prem_bill numeric(11,2),
    pol_num varchar(10) not null,
    pd_to_dt timestamp not null,
    bill_to_dt timestamp,
    plan_code varchar(5) not null,
    prod_code varchar(10),
    pol_yr numeric(3),
    comm_amt numeric(6,4),
    result_cd varchar(5),
    date_cr timestamp,
    date_am timestamp,
    user_cr varchar(15),
    user_am varchar(15)
);

CREATE TABLE IF NOT EXISTS cas.tcas_mdrt_detailed_report (
    agent_id varchar(6),
    agent_name varchar(100),
    unit_code varchar(6),
    unit_name varchar(50),
    branch_code varchar(6),
    branch_name varchar(50),
    pol_number varchar(10),
    insured_name varchar(100),
    pol_plan_code varchar(7),
    effective_date timestamp,
    pol_pymt_mode varchar(2),
    ytd_actual_fyp numeric(11,2),
    ytd_actual_fyc numeric(11,2),
    ytd_mdrt_fyp numeric(11,2),
    ytd_mdrt_fyc numeric(11,2),
    proj_mdrt_fyp numeric(11,2),
    proj_mdrt_fyc numeric(11,2),
    reasn_cd varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tcas_mdrt_detailed_report_1103 (
    agent_id varchar(6),
    agent_name varchar(100),
    unit_code varchar(6),
    unit_name varchar(50),
    branch_code varchar(6),
    branch_name varchar(50),
    pol_number varchar(10),
    insured_name varchar(100),
    pol_plan_code varchar(7),
    effective_date timestamp,
    pol_pymt_mode varchar(2),
    ytd_actual_fyp numeric(11,2),
    ytd_actual_fyc numeric(11,2),
    ytd_mdrt_fyp numeric(11,2),
    ytd_mdrt_fyc numeric(11,2),
    proj_mdrt_fyp numeric(11,2),
    proj_mdrt_fyc numeric(11,2),
    reasn_cd varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tcas_mdrt_details_sg (
    run_num varchar(6),
    reasn_cd varchar(3),
    agt_cd varchar(6),
    agt_nm varchar(100),
    unit_cd varchar(5),
    unit_nm varchar(50),
    br_cd varchar(5),
    br_nm varchar(50),
    pol_num varchar(10),
    insrd_nm varchar(100),
    stat_cd varchar(5),
    stat_desc varchar(100),
    plan_code varchar(5),
    eff_dt timestamp,
    pmt_mode varchar(2),
    ytd_act_fyp numeric(13,2),
    ytd_act_fyc numeric(13,2),
    ytd_mdrt_fyp numeric(13,2),
    ytd_mdrt_fyc numeric(13,2),
    proj_mdrt_fyp numeric(13,2),
    proj_mdrt_fyc numeric(13,2),
    acum_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tcas_mdrt_error_policy (
    agent_id varchar(6),
    agent_name varchar(100),
    pol_number varchar(10),
    vers_num varchar(2),
    client_num varchar(13),
    insured_name varchar(100),
    effective_date timestamp,
    issue_date timestamp,
    paid_to_date timestamp,
    exit_date timestamp,
    pol_status varchar(1),
    pol_premium numeric(11,2),
    pol_comm numeric(11,2),
    pol_pymt_mode varchar(2),
    pol_plan_code varchar(7),
    pol_bill_mode varchar(1),
    insured_age numeric(3),
    comm_agent varchar(6),
    write_agent varchar(6),
    unit_code varchar(6),
    unit_name varchar(50),
    branch_code varchar(6),
    branch_name varchar(50),
    pol_shared_percent numeric(3),
    base_plan_flag varchar(1),
    sngl_plan_flag varchar(1),
    pol_trxn_date timestamp,
    reasn_cd varchar(3),
    ytd_actual_fyp numeric(11,2),
    ytd_actual_fyc numeric(11,2),
    ytd_mdrt_fyp numeric(11,2),
    ytd_mdrt_fyc numeric(11,2),
    proj_mdrt_fyp numeric(11,2),
    proj_mdrt_fyc numeric(11,2),
    comm_rt numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.tcas_mdrt_plans (
    pol_plan_code varchar(6),
    pol_plan_name varchar(60),
    insured_start_age numeric(3),
    insured_end_age numeric(3),
    pol_mode varchar(2),
    pol_fee numeric(3),
    pol_mdrt_fac numeric(11,4),
    mdrt_ctl varchar(2),
    vers_num varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tcas_mdrt_policy (
    agent_id varchar(6),
    agent_name varchar(100),
    pol_number varchar(10),
    vers_num varchar(2),
    client_num varchar(13),
    insured_name varchar(100),
    effective_date timestamp,
    issue_date timestamp,
    paid_to_date timestamp,
    exit_date timestamp,
    pol_status varchar(1),
    pol_premium numeric(11,2),
    pol_comm numeric(11,2),
    pol_pymt_mode varchar(2),
    pol_plan_code varchar(7),
    pol_bill_mode varchar(1),
    insured_age numeric(3),
    comm_agent varchar(6),
    write_agent varchar(6),
    unit_code varchar(6),
    unit_name varchar(50),
    branch_code varchar(6),
    branch_name varchar(50),
    pol_shared_percent numeric(3),
    base_plan_flag varchar(1),
    sngl_plan_flag varchar(1),
    pol_trxn_date timestamp,
    reasn_cd varchar(3),
    ytd_actual_fyp numeric(11,2),
    ytd_actual_fyc numeric(11,2),
    ytd_mdrt_fyp numeric(11,2),
    ytd_mdrt_fyc numeric(11,2),
    proj_mdrt_fyp numeric(11,2),
    proj_mdrt_fyc numeric(11,2),
    comm_rt numeric(5,2),
    reasn_cd_desc varchar(80),
    wa_cd_2 varchar(20),
    cvg_eff_dt timestamp,
    cvg_stat_cd varchar(20),
    distribution varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.tcas_opcif_cli_id (
    cli_num varchar(40),
    opcif_cli_id numeric(9),
    surname varchar(50),
    given_name varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.tcbd_fund_alloc (
    btch_num varchar(20) not null,
    btch_role varchar(2) not null,
    trxn_dt timestamp not null,
    pol_num varchar(10) not null,
    cbd_num numeric(4) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    deal_basis varchar(1),
    deal_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tcbd_others (
    btch_num varchar(3),
    trxn_dt timestamp,
    btch_typ varchar(4),
    col_crcy_code varchar(2),
    col_trxn_amt numeric(11,2),
    btch_seq_no numeric(5),
    pol_num varchar(10),
    eff_dt timestamp,
    reasn_code varchar(3),
    crcy_code varchar(2),
    trxn_amt numeric(11,2),
    exchg_rt numeric(18,8),
    chq_no_text varchar(20),
    chq_dt timestamp,
    card_xpry_dt varchar(4),
    remarks varchar(100),
    acct_mne_cd varchar(8),
    report_no numeric(3),
    medic_fee_ind varchar(1),
    nb_trxn_map_no numeric(5),
    last_update_user varchar(30),
    last_update_date timestamp,
    cas_btch_num varchar(20),
    trxn_seq_no numeric(5),
    cbo_seq numeric(4),
    no_pol_crcy_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tcharges (
    chrg_cat varchar(10) not null,
    chrg_typ varchar(10) not null,
    eff_dt timestamp not null,
    fr_prem_dur numeric(3) not null,
    to_prem_dur numeric(3) not null,
    chrg_lvl varchar(1) not null,
    plan_code varchar(5) not null,
    plan_vers varchar(2) not null,
    plan_crcy varchar(2) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    fnd_crcy varchar(2) not null,
    chrg_desc varchar(30),
    pmt_mode varchar(2) not null,
    bill_mthd varchar(1) not null,
    chrg_seq numeric(2),
    band_low numeric(13,2) not null,
    band_high numeric(13,2) not null,
    chrg_pct numeric(11,8),
    flat_chrg_amt numeric(13,2),
    comm_ind numeric(1),
    chrg_opt varchar(1),
    chrg_lyr varchar(1) not null,
    acct_mne_cd varchar(8),
    fr_pol_yr numeric(3) not null,
    to_pol_yr numeric(3) not null,
    chrg_basis_nm varchar(20) not null,
    chrg_accmr_nm varchar(20),
    fr_mth numeric(5) not null,
    to_mth numeric(5) not null,
    max_chk_mthd varchar(1),
    pol_ctr_nm varchar(20),
    max_free_ctr numeric(3),
    rdr_plan_code varchar(5) not null,
    rdr_plan_vers varchar(2) not null,
    enquiry_flag varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tcharges_sg (
    chrg_typ varchar(10) not null,
    eff_dt timestamp not null,
    plan_code varchar(5) not null,
    plan_vers varchar(2) not null,
    plan_crcy varchar(2) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    fnd_crcy varchar(2) not null,
    chrg_desc varchar(30),
    pmt_mode varchar(2),
    bill_mthd varchar(1),
    flat_chrg_amt varchar(100),
    fr_pol_yr numeric(3) not null,
    to_pol_yr numeric(3) not null
);

CREATE TABLE IF NOT EXISTS cas.tcharge_discounts (
    plan_code varchar(5) not null,
    plan_vers varchar(2) not null,
    crcy_code varchar(2) not null,
    chrg_cat varchar(10) not null,
    chrg_typ varchar(10) not null,
    fr_eff_dt timestamp not null,
    to_eff_dt timestamp not null,
    fr_dur numeric(3) not null,
    to_dur numeric(3) not null,
    dscnt_factor_k numeric(5,2),
    dscnt_constant_k numeric(5),
    dscnt_factor_c numeric(5,2),
    dscnt_constant_c numeric(5),
    acct_mne_cd_dr varchar(8),
    acct_mne_cd_cr varchar(8)
);

CREATE TABLE IF NOT EXISTS cas.tcharge_histories (
    pol_num varchar(10) not null,
    chrg_cat varchar(10) not null,
    chrg_typ varchar(10) not null,
    chi_num varchar(4) not null,
    trxn_dt timestamp not null,
    eff_dt timestamp,
    pol_yr numeric(3),
    prem_dur numeric(3),
    chrg_lyr varchar(1),
    chrg_lvl varchar(1),
    chrg_mth numeric(5),
    plan_code varchar(5),
    plan_vers varchar(2),
    plan_crcy varchar(2),
    fnd_id varchar(5),
    fnd_vers varchar(6),
    layer_eff_dt timestamp,
    cvg_eff_dt timestamp,
    wthdr_amt numeric(13,2),
    chrg_amt numeric(13,2),
    dscnt_chrg_amt numeric(13,2),
    buy_pric numeric(20,10),
    sell_pric numeric(20,10),
    dscnt_buy_pric numeric(20,10),
    bs_dftl_pct numeric(5,2),
    cli_num varchar(13),
    user_id varchar(30),
    trxn_cd varchar(8),
    trxn_id varchar(15) not null,
    crcy_code varchar(2),
    enquiry_flag varchar(1),
    undo_trxn_id varchar(15)
);

CREATE TABLE IF NOT EXISTS cas.tchart_of_accounts (
    acct_mne_cd varchar(8) not null,
    acct_num varchar(8) not null,
    acct_desc varchar(100) not null,
    invnty_ctl_typ varchar(8),
    prod_rel_ind varchar(1) not null,
    dflt_mne_cd varchar(8),
    prem_inc_ac varchar(1),
    plan_code varchar(5) not null,
    acct_typ varchar(10),
    fnd_xfer_ind varchar(1),
    acct_lvl varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tchart_of_accounts_th (
    acct_link_cd varchar(8) not null,
    sun_acct_num varchar(10) not null,
    t0 varchar(1) not null,
    t0_cd varchar(10),
    t1 varchar(1) not null,
    t1_cd varchar(10),
    t2 varchar(1) not null,
    t2_cd varchar(10),
    t3 varchar(1) not null,
    t3_cd varchar(10),
    t4 varchar(1) not null,
    t4_cd varchar(10),
    t5 varchar(1) not null,
    t5_cd varchar(10),
    t6 varchar(1) not null,
    t6_cd varchar(10),
    t7 varchar(1) not null,
    t7_cd varchar(10),
    t8 varchar(1) not null,
    t8_cd varchar(10),
    t9 varchar(1) not null,
    t9_cd varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tcheques (
    id numeric(10) not null,
    d_clearing_code numeric(3) default 20 not null,
    ban_code_ varchar(4) not null,
    number_text varchar(25) not null,
    branch_name varchar(25),
    date_ timestamp not null,
    amt_ numeric(15,2) not null,
    col_id numeric(10) not null,
    created_by varchar(10) not null,
    date_created timestamp not null,
    date_modified timestamp,
    modified_by varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tchk_acct_extracts_new (
    ref_num varchar(30) not null,
    pol_num varchar(20) not null,
    cr_or_dr varchar(2) not null,
    acct_gen_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tchk_acct_extracts_old (
    ref_num varchar(30) not null,
    pol_num varchar(20) not null,
    cr_or_dr varchar(2) not null,
    acct_gen_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tchk_commission_trailers_new (
    ref_num varchar(15) not null,
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    agt_code varchar(6) not null,
    comm_dt timestamp not null,
    comm_stat_cd varchar(1) not null,
    pct_splt numeric(3) not null,
    comm_earn numeric(9,2) not null,
    pc_chrg_bck numeric(9) not null,
    pc_earn numeric(9) not null,
    comm_rest_dur numeric(3),
    comm_rest_ind varchar(1) not null,
    comm_rest_rt numeric(5,2),
    orph_asign_ind varchar(1) not null,
    fa_ratio numeric(7,5),
    pc_chrg_bck_2nd numeric(9),
    layer_eff_dt timestamp not null,
    pc_earn_ep numeric(9),
    pc_chrg_bck_ep numeric(9),
    pc_chrg_bck_ep_2nd numeric(9),
    cvg_lay_typ varchar(5) not null,
    pc_stat_cd varchar(5),
    comm_earn_1st numeric(13,2),
    layer_typ varchar(1) not null,
    mvy_cp_pc_chrg_bck numeric(9),
    pc_pct_splt numeric(3),
    comm_earn_csh numeric(9,2),
    comm_earn_serv numeric(9,2),
    comm_earn_mvy numeric(9,2),
    pc_base numeric(9)
);

CREATE TABLE IF NOT EXISTS cas.tchk_commission_trailers_old (
    ref_num varchar(15) not null,
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    agt_code varchar(6) not null,
    comm_dt timestamp not null,
    comm_stat_cd varchar(1) not null,
    pct_splt numeric(3) not null,
    comm_earn numeric(9,2) not null,
    pc_chrg_bck numeric(9) not null,
    pc_earn numeric(9) not null,
    comm_rest_dur numeric(3),
    comm_rest_ind varchar(1) not null,
    comm_rest_rt numeric(5,2),
    orph_asign_ind varchar(1) not null,
    fa_ratio numeric(7,5),
    pc_chrg_bck_2nd numeric(9),
    layer_eff_dt timestamp not null,
    pc_earn_ep numeric(9),
    pc_chrg_bck_ep numeric(9),
    pc_chrg_bck_ep_2nd numeric(9),
    cvg_lay_typ varchar(5) not null,
    pc_stat_cd varchar(5),
    comm_earn_1st numeric(13,2),
    layer_typ varchar(1) not null,
    mvy_cp_pc_chrg_bck numeric(9),
    pc_pct_splt numeric(3),
    comm_earn_csh numeric(9,2),
    comm_earn_serv numeric(9,2),
    comm_earn_mvy numeric(9,2),
    pc_base numeric(9)
);

CREATE TABLE IF NOT EXISTS cas.tchk_coverages_new (
    ref_num varchar(15) not null,
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    cvg_typ varchar(1) not null,
    cvg_reasn varchar(1) not null,
    occp_clas varchar(1) not null,
    par_code varchar(1) not null,
    bnft_dur numeric(3) not null,
    prem_dur numeric(3) not null,
    pua_tot_amt numeric(13,2) not null,
    rel_to_insrd varchar(2) not null,
    smkr_code varchar(1) not null,
    sex_code varchar(1) not null,
    cvg_prem numeric(11,2) not null,
    cvg_stat_cd varchar(1) not null,
    comm_ctl varchar(1) not null,
    comm_vers varchar(2) not null,
    cvg_clas varchar(3) not null,
    dscnt_pct numeric(5,2) not null,
    dscnt_prem numeric(11,2) not null,
    dth_bnft_amt numeric(13,2) not null,
    face_amt numeric(13,2) not null,
    band_face_amt numeric(13,2) not null,
    face_ratg numeric(5,2) not null,
    ins_typ varchar(1) not null,
    cvg_eff_age numeric(3) not null,
    cvg_iss_dt timestamp,
    xpry_dt timestamp not null,
    nyr_cvg_prem numeric(11,2) not null,
    nyr_dscnt_prem numeric(11,2) not null,
    pua_crnt_amt numeric(13,2) not null,
    prem_vers varchar(2) not null,
    pol_val_vers varchar(2) not null,
    prem_ovrid_end_date timestamp,
    div_crnt_amt numeric(11,2) not null,
    joint_cli_num varchar(13),
    joint_rel_insrd varchar(2),
    temp_flat_dur numeric(3) not null,
    temp_flat_unit_prem numeric(10,3) not null,
    temp_flat_prem numeric(11,2) not null,
    perm_flat_unit_prem numeric(10,3) not null,
    perm_flat_prem numeric(11,2) not null,
    temp_mort_dur numeric(3) not null,
    temp_mort_unit_prem numeric(10,3) not null,
    temp_mort_prem numeric(11,2) not null,
    perm_mort_unit_prem numeric(10,3) not null,
    perm_mort_prem numeric(11,2) not null,
    eti_endow numeric(13,2) not null,
    xtra_cat_cd varchar(1),
    perm_mort_ratg numeric(5),
    temp_mort_ratg numeric(5),
    cvg_del_dt timestamp,
    adj_prem numeric(11,2),
    adj_start_dt timestamp,
    adj_end_dt timestamp,
    nxt_eff_cvg_prem numeric(11,2),
    nxt_eff_dscnt_prem numeric(11,2),
    ctr_prem numeric(11,2),
    nxt_eff_ctr_prem numeric(11,2),
    prev_dth_bnft_amt numeric(13,2),
    risk_prem numeric(11,2),
    init_chg_ind varchar(1),
    cntr_price numeric(13,2),
    adj_prem_pct numeric(3),
    int_rt numeric(5,3),
    nyr_wp_prem numeric(11,2),
    wp_eff_age numeric(3),
    wp_eff_dt timestamp,
    wp_option varchar(1),
    wp_prem numeric(11,2),
    wp_prem_age_basis varchar(1),
    wp_prem_vers varchar(2),
    orig_face_amt numeric(13,2),
    orig_death_bnft numeric(13,2),
    orig_pua_amt numeric(13,2),
    joint_cli_eff_age numeric(3),
    substd_cd varchar(3),
    joint_cli_smkr_code varchar(1),
    joint_cli_sex_code varchar(1),
    cvg_del_reasn varchar(1),
    endow_acru numeric(13,2),
    nb_seq numeric(5),
    no_of_insrd numeric(2),
    rcc_ind varchar(1),
    face_ratg_start_dt timestamp,
    face_ratg_end_dt timestamp,
    lien_pct numeric(5,2),
    pkg_plan_code varchar(5),
    nc_face_ratg numeric(5,2) default 0 not null,
    nc_temp_flat_unit_prem numeric(10,3) default 0 not null,
    nc_perm_flat_unit_prem numeric(10,3) default 0 not null,
    nc_prem numeric(13,2) default 0 not null,
    nyr_nc_prem numeric(13,2) default 0 not null,
    wp_nc_prem numeric(13,2),
    eff_age_ovrid varchar(1),
    wp_plan_code varchar(5),
    wp_vers_num varchar(2),
    face_ratg_prem numeric(11,2),
    perm_prem_ovrid_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tchk_coverages_old (
    ref_num varchar(15) not null,
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    cvg_typ varchar(1) not null,
    cvg_reasn varchar(1) not null,
    occp_clas varchar(1) not null,
    par_code varchar(1) not null,
    bnft_dur numeric(3) not null,
    prem_dur numeric(3) not null,
    pua_tot_amt numeric(13,2) not null,
    rel_to_insrd varchar(2) not null,
    smkr_code varchar(1) not null,
    sex_code varchar(1) not null,
    cvg_prem numeric(11,2) not null,
    cvg_stat_cd varchar(1) not null,
    comm_ctl varchar(1) not null,
    comm_vers varchar(2) not null,
    cvg_clas varchar(3) not null,
    dscnt_pct numeric(5,2) not null,
    dscnt_prem numeric(11,2) not null,
    dth_bnft_amt numeric(13,2) not null,
    face_amt numeric(13,2) not null,
    band_face_amt numeric(13,2) not null,
    face_ratg numeric(5,2) not null,
    ins_typ varchar(1) not null,
    cvg_eff_age numeric(3) not null,
    cvg_iss_dt timestamp,
    xpry_dt timestamp not null,
    nyr_cvg_prem numeric(11,2) not null,
    nyr_dscnt_prem numeric(11,2) not null,
    pua_crnt_amt numeric(13,2) not null,
    prem_vers varchar(2) not null,
    pol_val_vers varchar(2) not null,
    prem_ovrid_end_date timestamp,
    div_crnt_amt numeric(11,2) not null,
    joint_cli_num varchar(13),
    joint_rel_insrd varchar(2),
    temp_flat_dur numeric(3) not null,
    temp_flat_unit_prem numeric(10,3) not null,
    temp_flat_prem numeric(11,2) not null,
    perm_flat_unit_prem numeric(10,3) not null,
    perm_flat_prem numeric(11,2) not null,
    temp_mort_dur numeric(3) not null,
    temp_mort_unit_prem numeric(10,3) not null,
    temp_mort_prem numeric(11,2) not null,
    perm_mort_unit_prem numeric(10,3) not null,
    perm_mort_prem numeric(11,2) not null,
    eti_endow numeric(13,2) not null,
    xtra_cat_cd varchar(1),
    perm_mort_ratg numeric(5),
    temp_mort_ratg numeric(5),
    cvg_del_dt timestamp,
    adj_prem numeric(11,2),
    adj_start_dt timestamp,
    adj_end_dt timestamp,
    nxt_eff_cvg_prem numeric(11,2),
    nxt_eff_dscnt_prem numeric(11,2),
    ctr_prem numeric(11,2),
    nxt_eff_ctr_prem numeric(11,2),
    prev_dth_bnft_amt numeric(13,2),
    risk_prem numeric(11,2),
    init_chg_ind varchar(1),
    cntr_price numeric(13,2),
    adj_prem_pct numeric(3),
    int_rt numeric(5,3),
    nyr_wp_prem numeric(11,2),
    wp_eff_age numeric(3),
    wp_eff_dt timestamp,
    wp_option varchar(1),
    wp_prem numeric(11,2),
    wp_prem_age_basis varchar(1),
    wp_prem_vers varchar(2),
    orig_face_amt numeric(13,2),
    orig_death_bnft numeric(13,2),
    orig_pua_amt numeric(13,2),
    joint_cli_eff_age numeric(3),
    substd_cd varchar(3),
    joint_cli_smkr_code varchar(1),
    joint_cli_sex_code varchar(1),
    cvg_del_reasn varchar(1),
    endow_acru numeric(13,2),
    nb_seq numeric(5),
    no_of_insrd numeric(2),
    rcc_ind varchar(1),
    face_ratg_start_dt timestamp,
    face_ratg_end_dt timestamp,
    lien_pct numeric(5,2),
    pkg_plan_code varchar(5),
    nc_face_ratg numeric(5,2) default 0 not null,
    nc_temp_flat_unit_prem numeric(10,3) default 0 not null,
    nc_perm_flat_unit_prem numeric(10,3) default 0 not null,
    nc_prem numeric(13,2) default 0 not null,
    nyr_nc_prem numeric(13,2) default 0 not null,
    wp_nc_prem numeric(13,2),
    eff_age_ovrid varchar(1),
    wp_plan_code varchar(5),
    wp_vers_num varchar(2),
    face_ratg_prem numeric(11,2),
    perm_prem_ovrid_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tchk_coverage_layers_new (
    ref_num varchar(15) not null,
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    layer_eff_dt timestamp not null,
    stat_cd varchar(1),
    layer_prem numeric(11,2),
    layer_dscnt_prem numeric(11,2),
    mpre numeric(11,2),
    old_face_amt numeric(13,2),
    new_face_amt numeric(13,2),
    old_cvg_clas varchar(3),
    new_cvg_clas varchar(3),
    wp_fa numeric(11,2),
    wp_prem numeric(11,2),
    wp_mpre numeric(11,2),
    cvg_lay_typ varchar(5) not null,
    old_prem_vers varchar(2),
    new_prem_vers varchar(2),
    occp_clas varchar(1),
    bnft_dur numeric(3),
    prem_dur numeric(3),
    pua_tot_amt numeric(13,2),
    smkr_code varchar(1),
    dth_bnft_amt numeric(13,2),
    band_face_amt numeric(13,2),
    face_ratg numeric(5,2),
    layer_eff_age numeric(3),
    nyr_layer_prem numeric(11,2),
    nyr_layer_dscnt_prem numeric(11,2),
    pua_crnt_amt numeric(13,2),
    div_crnt_amt numeric(11,2),
    temp_flat_dur numeric(3),
    temp_flat_unit_prem numeric(10,3),
    temp_flat_prem numeric(11,2),
    perm_flat_unit_prem numeric(10,3),
    perm_flat_prem numeric(11,2),
    temp_mort_dur numeric(3),
    temp_mort_unit_prem numeric(10,3),
    temp_mort_prem numeric(11,2),
    perm_mort_unit_prem numeric(10,3),
    perm_mort_prem numeric(11,2),
    eti_endow numeric(13,2),
    xtra_cat_cd varchar(1),
    perm_mort_ratg numeric(5),
    temp_mort_ratg numeric(5),
    adj_prem numeric(11,2),
    adj_start_dt timestamp,
    adj_end_dt timestamp,
    nxt_eff_cvg_prem numeric(11,2),
    nxt_eff_dscnt_prem numeric(11,2),
    risk_prem numeric(11,2),
    prev_dth_bnft_amt numeric(13,2),
    endow_acru numeric(13,2),
    adj_prem_pct numeric(3),
    nyr_wp_prem numeric(11,2),
    wp_eff_age numeric(3),
    wp_eff_dt timestamp,
    joint_cli_eff_age numeric(3),
    substd_cd varchar(3),
    excl_code1 varchar(5),
    excl_code2 varchar(5),
    excl_code3 varchar(5),
    excl_end_dt timestamp,
    excl_clause varchar(200),
    xfer_rider varchar(1),
    cvg_del_reasn varchar(1),
    layer_typ varchar(1) not null,
    face_ratg_start_dt timestamp,
    face_ratg_end_dt timestamp,
    lien_pct numeric(5,2),
    nc_face_ratg numeric(5,2) default 0 not null,
    nc_temp_flat_unit_prem numeric(10,3) default 0 not null,
    nc_perm_flat_unit_prem numeric(10,3) default 0 not null,
    nc_prem numeric(13,2) default 0 not null,
    nyr_nc_prem numeric(13,2) default 0 not null,
    wp_nc_prem numeric(13,2),
    face_ratg_prem numeric(11,2),
    temp_flat_ratg numeric(5,2),
    perm_flat_ratg numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.tchk_coverage_layers_old (
    ref_num varchar(15) not null,
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    layer_eff_dt timestamp not null,
    stat_cd varchar(1),
    layer_prem numeric(11,2),
    layer_dscnt_prem numeric(11,2),
    mpre numeric(11,2),
    old_face_amt numeric(13,2),
    new_face_amt numeric(13,2),
    old_cvg_clas varchar(3),
    new_cvg_clas varchar(3),
    wp_fa numeric(11,2),
    wp_prem numeric(11,2),
    wp_mpre numeric(11,2),
    cvg_lay_typ varchar(5) not null,
    old_prem_vers varchar(2),
    new_prem_vers varchar(2),
    occp_clas varchar(1),
    bnft_dur numeric(3),
    prem_dur numeric(3),
    pua_tot_amt numeric(13,2),
    smkr_code varchar(1),
    dth_bnft_amt numeric(13,2),
    band_face_amt numeric(13,2),
    face_ratg numeric(5,2),
    layer_eff_age numeric(3),
    nyr_layer_prem numeric(11,2),
    nyr_layer_dscnt_prem numeric(11,2),
    pua_crnt_amt numeric(13,2),
    div_crnt_amt numeric(11,2),
    temp_flat_dur numeric(3),
    temp_flat_unit_prem numeric(10,3),
    temp_flat_prem numeric(11,2),
    perm_flat_unit_prem numeric(10,3),
    perm_flat_prem numeric(11,2),
    temp_mort_dur numeric(3),
    temp_mort_unit_prem numeric(10,3),
    temp_mort_prem numeric(11,2),
    perm_mort_unit_prem numeric(10,3),
    perm_mort_prem numeric(11,2),
    eti_endow numeric(13,2),
    xtra_cat_cd varchar(1),
    perm_mort_ratg numeric(5),
    temp_mort_ratg numeric(5),
    adj_prem numeric(11,2),
    adj_start_dt timestamp,
    adj_end_dt timestamp,
    nxt_eff_cvg_prem numeric(11,2),
    nxt_eff_dscnt_prem numeric(11,2),
    risk_prem numeric(11,2),
    prev_dth_bnft_amt numeric(13,2),
    endow_acru numeric(13,2),
    adj_prem_pct numeric(3),
    nyr_wp_prem numeric(11,2),
    wp_eff_age numeric(3),
    wp_eff_dt timestamp,
    joint_cli_eff_age numeric(3),
    substd_cd varchar(3),
    excl_code1 varchar(5),
    excl_code2 varchar(5),
    excl_code3 varchar(5),
    excl_end_dt timestamp,
    excl_clause varchar(200),
    xfer_rider varchar(1),
    cvg_del_reasn varchar(1),
    layer_typ varchar(1) not null,
    face_ratg_start_dt timestamp,
    face_ratg_end_dt timestamp,
    lien_pct numeric(5,2),
    nc_face_ratg numeric(5,2) default 0 not null,
    nc_temp_flat_unit_prem numeric(10,3) default 0 not null,
    nc_perm_flat_unit_prem numeric(10,3) default 0 not null,
    nc_prem numeric(13,2) default 0 not null,
    nyr_nc_prem numeric(13,2) default 0 not null,
    wp_nc_prem numeric(13,2),
    face_ratg_prem numeric(11,2),
    temp_flat_ratg numeric(5,2),
    perm_flat_ratg numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.tchk_crrs_new (
    ref_num varchar(30) not null,
    pol_num varchar(20) not null,
    comm_amt numeric(11,2),
    pc_amt numeric(9),
    case_ctr numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.tchk_crrs_old (
    ref_num varchar(30) not null,
    pol_num varchar(20) not null,
    comm_amt numeric(11,2),
    pc_amt numeric(9),
    case_ctr numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.tchk_fund_summary_new (
    ref_num varchar(15) not null,
    pol_num varchar(10) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    fnd_strt_dt timestamp not null,
    fnd_bal numeric(20,10) not null,
    guar_int_fnd_bal numeric(11,2),
    last_fnd_mvm_dt timestamp,
    avg_fnd_valu_ratio numeric(13,2),
    loan_bal numeric(13,2),
    pol_crcy_cd varchar(2) not null,
    tot_psu_amt numeric(13,2),
    prem_grp varchar(3) not null
);

CREATE TABLE IF NOT EXISTS cas.tchk_fund_summary_old (
    ref_num varchar(15) not null,
    pol_num varchar(10) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    fnd_strt_dt timestamp not null,
    fnd_bal numeric(20,10) not null,
    guar_int_fnd_bal numeric(11,2),
    last_fnd_mvm_dt timestamp,
    avg_fnd_valu_ratio numeric(13,2),
    loan_bal numeric(13,2),
    pol_crcy_cd varchar(2) not null,
    tot_psu_amt numeric(13,2),
    prem_grp varchar(3) not null
);

CREATE TABLE IF NOT EXISTS cas.tchk_layers_new (
    ref_num varchar(15) not null,
    pol_num varchar(10) not null,
    layer_eff_dt timestamp not null,
    layer_typ varchar(1) not null,
    layer_stat_cd varchar(1),
    mpre numeric(11,2),
    xces_prem numeric(11,2),
    layer_trmn_dt timestamp,
    tot_prem_pd numeric(11,2),
    mpre_pd numeric(11,2),
    last_ryc_dt timestamp,
    mpre_rc_ind varchar(1),
    layer_prem_amt numeric(11,2),
    hwm_ann numeric(11,2),
    hwm_ann_xpry_dt timestamp,
    pd_to_dt timestamp,
    partial_pay_amt numeric(11,2),
    layer_prem_pct numeric(5,2),
    surr_chrg_pd numeric(13,2),
    asof_tot_prem_pd numeric(11,2),
    orig_mpre numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tchk_layers_old (
    ref_num varchar(15) not null,
    pol_num varchar(10) not null,
    layer_eff_dt timestamp not null,
    layer_typ varchar(1) not null,
    layer_stat_cd varchar(1),
    mpre numeric(11,2),
    xces_prem numeric(11,2),
    layer_trmn_dt timestamp,
    tot_prem_pd numeric(11,2),
    mpre_pd numeric(11,2),
    last_ryc_dt timestamp,
    mpre_rc_ind varchar(1),
    layer_prem_amt numeric(11,2),
    hwm_ann numeric(11,2),
    hwm_ann_xpry_dt timestamp,
    pd_to_dt timestamp,
    partial_pay_amt numeric(11,2),
    layer_prem_pct numeric(5,2),
    surr_chrg_pd numeric(13,2),
    asof_tot_prem_pd numeric(11,2),
    orig_mpre numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tchk_policys_new (
    ref_num varchar(15) not null,
    pol_num varchar(10) not null,
    mode_prem numeric(11,2) not null,
    ovr_loan_ind varchar(1) not null,
    frez_code varchar(1) not null,
    ipo_ind varchar(1) not null,
    vp_ind varchar(1) not null,
    reins_ind varchar(1) not null,
    bill_mthd varchar(1) not null,
    crcy_code varchar(2) not null,
    last_avy_dt timestamp not null,
    last_pd_to_dt timestamp not null,
    pd_to_dt timestamp not null,
    pol_eff_dt timestamp not null,
    pol_iss_dt timestamp,
    pol_reiss_dt timestamp,
    cnfrm_acpt_dt timestamp,
    pol_rlse_dt timestamp,
    sbmt_dt timestamp not null,
    pol_stat_cd varchar(1) not null,
    state_cd varchar(2) not null,
    pol_trmn_dt timestamp,
    div_opt varchar(1) not null,
    terr_cd varchar(2) not null,
    dscnt_prem numeric(11,2) not null,
    pol_susp numeric(13,2) not null,
    pmt_susp numeric(11,2) not null,
    ipo_last_refu_yr numeric(4),
    pmt_mode varchar(5) not null,
    bill_prem numeric(11,2) not null,
    bill_to_dt timestamp not null,
    pac_loan_repy numeric(11,2),
    pac_bk_ctr varchar(1),
    pac_eff_dt timestamp,
    medic_code varchar(10),
    medic_dt timestamp,
    incmplt_cd varchar(2),
    pend_cd varchar(2),
    subj_to_cd varchar(2),
    uwg_clas varchar(30),
    fran_num varchar(4),
    agt_code varchar(6),
    nfo_opt varchar(1) not null,
    nfo_eff_dt timestamp,
    zap_ind varchar(1),
    aea_ind varchar(1) not null,
    lnb_ind varchar(1) not null,
    hiv_ind varchar(1) not null,
    pol_rmrk varchar(500),
    apl_laps_dt timestamp,
    pc_typ varchar(10),
    pc_recv_dt timestamp,
    pc_pend_reasn varchar(10),
    pc_efft_date timestamp,
    apl_ext_days numeric(3),
    nyr_mode_prem numeric(11,2) not null,
    nyr_dscnt_prem numeric(11,2) not null,
    renw_yr numeric(3) not null,
    run_num numeric(2),
    pol_app_dt timestamp,
    tlia_code_1 varchar(10),
    tlia_code_2 varchar(10),
    tlia_code_3 varchar(10),
    disab_clas varchar(3),
    restr_case_cnt_ind varchar(1) not null,
    comm_wthld_dt timestamp,
    nb_user_id varchar(30) not null,
    last_actv_dt timestamp,
    joint_cli_dth_ind varchar(1) not null,
    comprop_prem numeric(11,2),
    resv_dnr_amt numeric(13,2),
    xcpt_bill_cd varchar(1),
    nb_pc_pol_tot numeric(9),
    cnfrm_prt_dt timestamp,
    os_anty_susp numeric(13,2),
    payo_mthd varchar(1),
    anty_stat_cd varchar(1),
    nxt_eff_mode_prem numeric(11,2),
    nxt_eff_dscnt_prem numeric(11,2),
    nxt_eff_prem_dt timestamp,
    ctr_prem numeric(11,2),
    nxt_eff_ctr_prem numeric(11,2),
    lump_sum_ind varchar(1),
    lump_sum_pmt_amt numeric(11,2),
    proc_fee_ind varchar(1),
    dist_chnl_cd varchar(2),
    tot_prem_appy numeric(15,2),
    prefix_cd varchar(3),
    oth_rqmts_text varchar(60),
    mort_cd varchar(6),
    chg_insrd_opt varchar(1),
    convrt_fr_pol varchar(10),
    apl_lapse_ind varchar(1),
    div_upto_dt timestamp,
    endow_ctl varchar(1),
    sa_cd_2 varchar(6),
    wa_cd_1 varchar(6),
    wa_cd_2 varchar(6),
    vp_point timestamp,
    override_bill_day numeric(2),
    plan_code_base varchar(5),
    vers_num_base varchar(2),
    bnh_code varchar(5),
    corridor_pct numeric(3),
    curr_debit_day numeric(2),
    db_opt varchar(1),
    disable_dt timestamp,
    dth_susp numeric(13,2),
    fnd_switch_ctr numeric(3),
    fnd_wthdr_ctr numeric(3),
    iio_opt varchar(1),
    iio_pct numeric(3),
    insrd_mort varchar(4),
    ins_typ_base varchar(1),
    lst_fnd_valn_dt timestamp,
    mvy_ded_to_dt timestamp,
    nb_update_date timestamp,
    no_lapse_gurt_ind varchar(1),
    nxt_debit_day numeric(2),
    nxt_pac_eff_dt timestamp,
    nxt_rebal_date timestamp,
    occ_cd varchar(6),
    open_flag varchar(5),
    pickup_debit_day numeric(2),
    pickup_eff_dt timestamp,
    plan_prem numeric(11,2),
    pol_clm_dt timestamp,
    pric_rsrv_dt timestamp,
    rebal_ind varchar(1),
    recurr_bill_ind varchar(1),
    recurr_bill_st_dt timestamp,
    reins_cd varchar(3),
    reins_mthd varchar(1),
    restrict_cd_1 varchar(5),
    restrict_cd_2 varchar(5),
    restrict_cd_3 varchar(5),
    special_clas varchar(2),
    wrk_area varchar(4),
    non_lapse_ind varchar(1),
    lro_eff_dt timestamp,
    bbr_flag varchar(1),
    ph_ind varchar(1),
    ph_strt_dt timestamp,
    ph_end_dt timestamp,
    ph_eff_typ varchar(1),
    ph_pd_to_dt timestamp,
    ph_last_pd_to_dt timestamp,
    ph_autopay_ind varchar(1),
    anty_wthdr numeric(13,2),
    anty_dur numeric(2),
    anty_freq numeric(2),
    anty_int_rt numeric(7,5),
    anty_opt varchar(2),
    anty_payo_amt numeric(13,2),
    anty_start_dt timestamp,
    loan_ovr_int_rt numeric(7,5),
    conv_dt timestamp,
    pdf_strt_dt timestamp,
    pdf_end_dt timestamp,
    instl_strt_dt timestamp,
    instl_end_dt timestamp,
    instl_amt numeric(13,2),
    edw_loan varchar(1),
    loyal_bns_ind varchar(1),
    bank_fee_ind varchar(1),
    anty_payo_base numeric(11,2),
    anty_payo_rt numeric(12,6),
    anty_crtn_dur numeric(2),
    waive_end_dt timestamp,
    anty_ref_dt timestamp,
    anty_end_dt timestamp,
    gurt_bnft numeric(13,2),
    gurt_amt numeric(13,2),
    life_incm numeric(13,2),
    rmn_gurt_amt numeric(13,2),
    rmn_life_incm numeric(13,2),
    nxt_payo_dt timestamp,
    last_fnd_avy_dt timestamp,
    anty_min_payo_amt numeric(13,2),
    ins_birth_dt timestamp,
    last_tcomm_calc_dt timestamp,
    loyal_bns_opt varchar(1),
    last_lbns_decla_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tchk_policys_old (
    ref_num varchar(15) not null,
    pol_num varchar(10) not null,
    mode_prem numeric(11,2) not null,
    ovr_loan_ind varchar(1) not null,
    frez_code varchar(1) not null,
    ipo_ind varchar(1) not null,
    vp_ind varchar(1) not null,
    reins_ind varchar(1) not null,
    bill_mthd varchar(1) not null,
    crcy_code varchar(2) not null,
    last_avy_dt timestamp not null,
    last_pd_to_dt timestamp not null,
    pd_to_dt timestamp not null,
    pol_eff_dt timestamp not null,
    pol_iss_dt timestamp,
    pol_reiss_dt timestamp,
    cnfrm_acpt_dt timestamp,
    pol_rlse_dt timestamp,
    sbmt_dt timestamp not null,
    pol_stat_cd varchar(1) not null,
    state_cd varchar(2) not null,
    pol_trmn_dt timestamp,
    div_opt varchar(1) not null,
    terr_cd varchar(2) not null,
    dscnt_prem numeric(11,2) not null,
    pol_susp numeric(13,2) not null,
    pmt_susp numeric(11,2) not null,
    ipo_last_refu_yr numeric(4),
    pmt_mode varchar(5) not null,
    bill_prem numeric(11,2) not null,
    bill_to_dt timestamp not null,
    pac_loan_repy numeric(11,2),
    pac_bk_ctr varchar(1),
    pac_eff_dt timestamp,
    medic_code varchar(10),
    medic_dt timestamp,
    incmplt_cd varchar(2),
    pend_cd varchar(2),
    subj_to_cd varchar(2),
    uwg_clas varchar(30),
    fran_num varchar(4),
    agt_code varchar(6),
    nfo_opt varchar(1) not null,
    nfo_eff_dt timestamp,
    zap_ind varchar(1),
    aea_ind varchar(1) not null,
    lnb_ind varchar(1) not null,
    hiv_ind varchar(1) not null,
    pol_rmrk varchar(500),
    apl_laps_dt timestamp,
    pc_typ varchar(10),
    pc_recv_dt timestamp,
    pc_pend_reasn varchar(10),
    pc_efft_date timestamp,
    apl_ext_days numeric(3),
    nyr_mode_prem numeric(11,2) not null,
    nyr_dscnt_prem numeric(11,2) not null,
    renw_yr numeric(3) not null,
    run_num numeric(2),
    pol_app_dt timestamp,
    tlia_code_1 varchar(10),
    tlia_code_2 varchar(10),
    tlia_code_3 varchar(10),
    disab_clas varchar(3),
    restr_case_cnt_ind varchar(1) not null,
    comm_wthld_dt timestamp,
    nb_user_id varchar(30) not null,
    last_actv_dt timestamp,
    joint_cli_dth_ind varchar(1) not null,
    comprop_prem numeric(11,2),
    resv_dnr_amt numeric(13,2),
    xcpt_bill_cd varchar(1),
    nb_pc_pol_tot numeric(9),
    cnfrm_prt_dt timestamp,
    os_anty_susp numeric(13,2),
    payo_mthd varchar(1),
    anty_stat_cd varchar(1),
    nxt_eff_mode_prem numeric(11,2),
    nxt_eff_dscnt_prem numeric(11,2),
    nxt_eff_prem_dt timestamp,
    ctr_prem numeric(11,2),
    nxt_eff_ctr_prem numeric(11,2),
    lump_sum_ind varchar(1),
    lump_sum_pmt_amt numeric(11,2),
    proc_fee_ind varchar(1),
    dist_chnl_cd varchar(2),
    tot_prem_appy numeric(15,2),
    prefix_cd varchar(3),
    oth_rqmts_text varchar(60),
    mort_cd varchar(6),
    chg_insrd_opt varchar(1),
    convrt_fr_pol varchar(10),
    apl_lapse_ind varchar(1),
    div_upto_dt timestamp,
    endow_ctl varchar(1),
    sa_cd_2 varchar(6),
    wa_cd_1 varchar(6),
    wa_cd_2 varchar(6),
    vp_point timestamp,
    override_bill_day numeric(2),
    plan_code_base varchar(5),
    vers_num_base varchar(2),
    bnh_code varchar(5),
    corridor_pct numeric(3),
    curr_debit_day numeric(2),
    db_opt varchar(1),
    disable_dt timestamp,
    dth_susp numeric(13,2),
    fnd_switch_ctr numeric(3),
    fnd_wthdr_ctr numeric(3),
    iio_opt varchar(1),
    iio_pct numeric(3),
    insrd_mort varchar(4),
    ins_typ_base varchar(1),
    lst_fnd_valn_dt timestamp,
    mvy_ded_to_dt timestamp,
    nb_update_date timestamp,
    no_lapse_gurt_ind varchar(1),
    nxt_debit_day numeric(2),
    nxt_pac_eff_dt timestamp,
    nxt_rebal_date timestamp,
    occ_cd varchar(6),
    open_flag varchar(5),
    pickup_debit_day numeric(2),
    pickup_eff_dt timestamp,
    plan_prem numeric(11,2),
    pol_clm_dt timestamp,
    pric_rsrv_dt timestamp,
    rebal_ind varchar(1),
    recurr_bill_ind varchar(1),
    recurr_bill_st_dt timestamp,
    reins_cd varchar(3),
    reins_mthd varchar(1),
    restrict_cd_1 varchar(5),
    restrict_cd_2 varchar(5),
    restrict_cd_3 varchar(5),
    special_clas varchar(2),
    wrk_area varchar(4),
    non_lapse_ind varchar(1),
    lro_eff_dt timestamp,
    bbr_flag varchar(1),
    ph_ind varchar(1),
    ph_strt_dt timestamp,
    ph_end_dt timestamp,
    ph_eff_typ varchar(1),
    ph_pd_to_dt timestamp,
    ph_last_pd_to_dt timestamp,
    ph_autopay_ind varchar(1),
    anty_wthdr numeric(13,2),
    anty_dur numeric(2),
    anty_freq numeric(2),
    anty_int_rt numeric(7,5),
    anty_opt varchar(2),
    anty_payo_amt numeric(13,2),
    anty_start_dt timestamp,
    loan_ovr_int_rt numeric(7,5),
    conv_dt timestamp,
    pdf_strt_dt timestamp,
    pdf_end_dt timestamp,
    instl_strt_dt timestamp,
    instl_end_dt timestamp,
    instl_amt numeric(13,2),
    edw_loan varchar(1),
    loyal_bns_ind varchar(1),
    bank_fee_ind varchar(1),
    anty_payo_base numeric(11,2),
    anty_payo_rt numeric(12,6),
    anty_crtn_dur numeric(2),
    waive_end_dt timestamp,
    anty_ref_dt timestamp,
    anty_end_dt timestamp,
    gurt_bnft numeric(13,2),
    gurt_amt numeric(13,2),
    life_incm numeric(13,2),
    rmn_gurt_amt numeric(13,2),
    rmn_life_incm numeric(13,2),
    nxt_payo_dt timestamp,
    last_fnd_avy_dt timestamp,
    anty_min_payo_amt numeric(13,2),
    ins_birth_dt timestamp,
    last_tcomm_calc_dt timestamp,
    loyal_bns_opt varchar(1),
    last_lbns_decla_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tcis_cm01 (
    br_code varchar(5),
    unit_code varchar(5),
    loc_code varchar(10),
    agt_code varchar(5),
    agt_nm varchar(40),
    fran_num varchar(4),
    pol_num varchar(10),
    owner varchar(40),
    insured varchar(40),
    birth_dt timestamp,
    cntct_dt timestamp,
    cntct_reasn varchar(30),
    address varchar(200),
    prim_phone varchar(20),
    othr_phone varchar(20),
    pol_eff_dt timestamp,
    face_amt numeric(13,2),
    base_plan varchar(5),
    has_rider varchar(1),
    pmt_mthd varchar(20),
    dscnt_prem numeric(11,2),
    pmt_mode varchar(20),
    pd_to_dt timestamp,
    has_loan varchar(1),
    orph_asign_ind varchar(1),
    tran_dt timestamp,
    cnfrm_dt timestamp,
    reinstat_ind varchar(1),
    pol_trmn_dt timestamp,
    reinstat_prem numeric,
    reinstat_dt timestamp,
    agt_comm numeric
);

CREATE TABLE IF NOT EXISTS cas.tcis_cm02 (
    pol_num varchar(10) not null,
    agt_code varchar(5) not null,
    cntct_dt timestamp not null,
    cntct_manner varchar(1),
    importer varchar(20),
    ques1_1 varchar(1),
    ques1_2 varchar(1),
    ques1_3 varchar(1),
    ques1_3_1 varchar(1),
    ques1_3_2 varchar(1),
    ques1_3_3 varchar(1),
    ques1_3_4 varchar(1),
    ques1_3_5 varchar(1),
    ques1_3_6 varchar(1),
    ques2_1 varchar(1),
    ques2_2 varchar(1),
    ques2_3 varchar(1),
    ques2_4 varchar(1),
    ques2_5 varchar(1),
    ques2_6_1 varchar(1),
    ques2_6_2 varchar(1),
    ques2_6_3 varchar(1),
    ques2_6_4 varchar(1),
    ques2_6_5 varchar(1),
    ques2_6_6 varchar(1),
    ques2_6_7 varchar(1),
    ques3_1_1 varchar(1),
    ques3_1_2 varchar(1),
    ques3_1_3 varchar(1),
    ques3_1_4 varchar(1),
    ques3_1_5 varchar(1),
    ques3_1_6 varchar(1),
    ques3_1_7 varchar(1),
    ques3_1_8 varchar(1),
    ques3_1_9 varchar(1),
    ques3_2 varchar(1),
    ques3_3 varchar(1),
    ques4_1 varchar(1),
    ques4_2 varchar(1),
    ques4_3 varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tcis_cm06 (
    agt_code varchar(5),
    plan numeric,
    actual numeric,
    ytd timestamp,
    plan_case_count numeric,
    actual_case_count numeric,
    yearly_case_count numeric,
    yearly_plan numeric
);

CREATE TABLE IF NOT EXISTS cas.tcis_contact_histories (
    pol_num varchar(10) not null,
    trxn_dt timestamp not null,
    orph_asign_ind varchar(1) not null,
    reinstat_ind varchar(1) not null,
    cli_num varchar(10) not null,
    agt_code varchar(5) not null,
    cntct_dt timestamp,
    cntct_reasn varchar(30),
    old_pd_to_dt timestamp,
    cnfrm_dt timestamp,
    fran_num varchar(4)
);

CREATE TABLE IF NOT EXISTS cas.tcis_trxn_log (
    agt_code varchar(5) not null,
    trxn_dt timestamp not null,
    tlo_num numeric(4) not null,
    trxn_cd varchar(8) not null,
    trxn_desc varchar(200) not null,
    pol_num varchar(10),
    cli_num varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tclaim_auth_limit (
    role_id varchar(10) not null,
    clm_code varchar(2) not null,
    clm_decision varchar(1) not null,
    pol_yr_fr numeric(4) not null,
    pol_yr_to numeric(4) not null,
    low_limit numeric(17,2),
    high_limit numeric(17,2),
    stat_cd varchar(1),
    create_by varchar(30),
    create_dt timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS cas.tclaim_auth_role (
    user_id varchar(30) not null,
    role_id varchar(10) not null,
    committee varchar(1),
    stat_cd varchar(1),
    auth_level numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tclaim_ci_bene_id_th (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    clm_code varchar(2) not null,
    sex_code varchar(1) not null,
    ci_code varchar(2) not null,
    max_pct numeric,
    max_amt numeric,
    accum varchar(3),
    exp_pol varchar(1),
    ci_desc varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.tclaim_ci_client_th (
    cli_num varchar(13) not null,
    pol_num varchar(10) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    seq_num numeric(4) not null,
    clm_code varchar(2) not null,
    ci_code varchar(2),
    claim_amt numeric(17,2)
);

CREATE TABLE IF NOT EXISTS cas.tclaim_clmants (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    seq_num numeric(4) not null,
    clm_eff_dt timestamp not null,
    clmant_typ varchar(10) not null,
    clmant varchar(40) not null,
    pct_splt numeric(3) not null,
    crcy_code varchar(2) not null,
    exchg_rt numeric(18,8) not null,
    payo_mthd varchar(1) not null,
    payo_channel varchar(10) not null
);

CREATE TABLE IF NOT EXISTS cas.tclaim_contest_th (
    pol_num varchar(10),
    seq_num numeric,
    clm_code varchar(2),
    plan_code varchar(5),
    vers_num varchar(2),
    cvg_eff_dt timestamp,
    dnr_num numeric,
    contest_dt timestamp,
    payo_amt numeric,
    contest_remark varchar(100)
);

CREATE TABLE IF NOT EXISTS cas.tclaim_details (
    pol_num varchar(10) not null,
    cli_num varchar(13),
    clm_eff_dt timestamp not null,
    clm_recv_dt timestamp not null,
    clm_stat_code varchar(1),
    clm_prvd_amt numeric(17,2),
    clm_aprov_amt numeric(17,2),
    clm_aprov_dt timestamp,
    clm_code varchar(2),
    clm_pend_cd varchar(2),
    clm_folwup_dt timestamp,
    clm_rmrk varchar(100),
    clm_reasn_cd varchar(2),
    clm_tracking_num numeric(2),
    clm_hosp_begin_dt timestamp,
    clm_hosp_end_dt timestamp,
    clm_medic_fee numeric(2),
    cmd_num numeric(10),
    seq_num numeric(4) not null,
    event_dt timestamp,
    stat_chg_dt timestamp,
    clm_num varchar(10),
    clmant varchar(40) not null,
    clm_report_dt timestamp,
    recv_pol_file timestamp,
    first_eval_dt timestamp,
    close_case_dt timestamp,
    reopen_case_dt timestamp,
    calc_dt timestamp,
    info_to_client timestamp,
    compl_doc_dt timestamp,
    sent_to_fin timestamp,
    settled_dt timestamp,
    clm_lett_sent_dt timestamp,
    clm_lett_sent_by varchar(2),
    pol_value numeric(17,2),
    others_amt1 numeric(17,2),
    others_amt2 numeric(17,2),
    others_amt3 numeric(17,2),
    others_amt4 numeric(17,2),
    others_desc1 varchar(500),
    others_desc2 varchar(500),
    others_desc3 varchar(500),
    others_desc4 varchar(500),
    crcy_code varchar(2),
    exchg_rt numeric,
    pol_susp numeric(17,2),
    pmt_susp numeric(17,2),
    outst_prem numeric(17,2),
    cash_value numeric(17,2),
    cash_coupon numeric(17,2),
    dividend numeric(17,2),
    pol_loan numeric(17,2),
    apl_loan numeric(17,2),
    prem_refund numeric(17,2),
    others_amt5 numeric(17,2),
    others_amt6 numeric(17,2),
    others_amt7 numeric(17,2),
    others_amt8 numeric(17,2),
    others_amt9 numeric(17,2),
    pdf_amount numeric(17,2),
    svg_valu numeric(17,2),
    bnkasrnc_svg numeric(17,2),
    pua_amount numeric(17,2),
    study_reward numeric(17,2),
    int_amt numeric(6,2),
    topup_amt numeric(17,2),
    base_amt numeric(17,2),
    increase_amt numeric(17,2)
);

CREATE TABLE IF NOT EXISTS cas.tclaim_incident_id (
    pol_num varchar(10) not null,
    seq_num numeric(4) not null,
    clm_code varchar(2) not null,
    clm_stat_code varchar(1) not null,
    cause_code varchar(9),
    stat_chg_dt timestamp,
    event_date timestamp,
    age_at_event numeric(3),
    body_part varchar(500),
    waived_from timestamp,
    waived_until timestamp,
    plan_code varchar(5) not null,
    max_bene numeric(17,2),
    claimed_amt numeric(17,2),
    aprov_amt numeric(17,2),
    clm_aprov_user varchar(30),
    aprov_dt timestamp,
    reins_amt_risk numeric(17,2),
    reins_retent_amt numeric(17,2),
    reins_reins_amt numeric(17,2),
    reins_confirm_dt timestamp,
    reins_num varchar(10),
    reins_risk_dth numeric(17,2),
    reins_real_pmt numeric(17,2),
    reins_manu_ref numeric(17,2),
    reins_ref_num numeric(17,2),
    reins_pmt_dt timestamp,
    aprov_orig_amt numeric(17,2),
    elig_period_year numeric(3),
    elig_period_month numeric(2),
    elig_period_days numeric(2),
    elimination_period numeric(4),
    last_addendum_dt timestamp,
    outst_prem_flag varchar(1),
    int_transfer numeric(17,2),
    company_cd varchar(1),
    cvg_typ varchar(1),
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    ltr_bnfy_nm varchar(60),
    ltr_trustee_nm varchar(60),
    ltr_addr1 varchar(60),
    ltr_addr2 varchar(60),
    ltr_addr3 varchar(60),
    ltr_addr4 varchar(60),
    ltr_zip_code varchar(6),
    waiting_period numeric(4),
    wait_peri_end timestamp,
    elimination_end timestamp,
    pol_loan_flag varchar(1),
    apl_loan_flag varchar(1),
    prem_rfnd_flag varchar(1),
    clm_remark varchar(4000),
    ltr_phon_num varchar(60),
    ltr_rel_to_insrd varchar(3),
    disab_date timestamp,
    death_date timestamp,
    ovrloan_flag varchar(1),
    peri_incm_cd varchar(2),
    peri_incm_mth numeric(3),
    tpd_real_amt numeric(17,2),
    ins_sex_code varchar(1),
    calc_crcy_code varchar(2),
    calc_exchg_rt numeric,
    fax_claim varchar(1),
    contest_flg varchar(1),
    contest_orig_seq_num numeric(4),
    contest_dt timestamp,
    contest_remark varchar(500),
    ci_extra_reasn varchar(50),
    ci_extra_pct numeric(5,2),
    hs_dscnt_prem numeric(11,2),
    hosp_disc numeric(11,2),
    pv_num numeric(10),
    pv_date timestamp,
    bill_num numeric(10),
    interest_amt numeric(11,2),
    ori_cvg_stat_cd varchar(1),
    clmout_case_no varchar(10),
    clmout_case_source varchar(10),
    clmout_claim_type varchar(10),
    clmout_inv_no varchar(20),
    clmout_value_dt timestamp,
    clm_fraud_cd varchar(10),
    clm_fraud_dt timestamp,
    exgratia varchar(1),
    committee varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tclaim_disability_id (
    pol_num varchar(10) not null,
    seq_num numeric(4) not null,
    clm_code varchar(2) not null,
    disab_id varchar(2) not null,
    disfunc_pct numeric(5,2) not null,
    perm_pct numeric(5,2) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    num_days_disab numeric(5),
    extra_bene_code varchar(3),
    extra_pct numeric(5,2),
    calc_clm_amt numeric(17,2)
);

CREATE TABLE IF NOT EXISTS cas.tclaim_disab_area_id (
    disab_id varchar(2) not null,
    disab_desc varchar(100),
    perm_pct numeric(5,2),
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    num_days_disab_ind varchar(1),
    extra_bene_code varchar(3),
    extra_pct numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.tclaim_dnr_clinic_th (
    pol_num varchar(10),
    seq_num numeric(4),
    clm_code varchar(2),
    plan_code varchar(5),
    vers_num varchar(2),
    dnr_num numeric(4),
    payee_code varchar(13),
    gross_amt numeric(17,2),
    tax_amt numeric(17,2)
);

CREATE TABLE IF NOT EXISTS cas.tclaim_dnr_id (
    pol_num varchar(10) not null,
    seq_num numeric(4) not null,
    clm_code varchar(2) not null,
    dnr_num numeric(4) not null,
    clearance_dt timestamp,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    bank_cd varchar(13),
    payee_typ varchar(1),
    payee_code varchar(13),
    bnfy_typ varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tclaim_doc_tracking_id (
    pol_num varchar(10) not null,
    seq_num numeric(4) not null,
    sent_date timestamp not null,
    sent_to varchar(30) not null,
    user_id varchar(30) not null,
    doc_seq_num numeric(3) not null
);

CREATE TABLE IF NOT EXISTS cas.tclaim_dtl_histories_tw (
    trxn_dt timestamp not null,
    cdh_num numeric(6) not null,
    pol_num varchar(10) not null,
    cli_num varchar(10) not null,
    clm_eff_dt timestamp not null,
    seq_num numeric(4) not null,
    user_id varchar(30) not null,
    fld_nm varchar(20) not null,
    old_valu varchar(20),
    new_valu varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.tclaim_ext (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    clm_eff_dt timestamp not null,
    paid_code varchar(5),
    iss_job varchar(10),
    claim_job varchar(10),
    add_job varchar(10),
    claim_age numeric(3),
    death_date timestamp,
    death_code varchar(3),
    cause_code varchar(9) not null,
    dd_code varchar(2),
    hospital_code varchar(7),
    invesgate timestamp,
    days_hos numeric(3),
    days_icu numeric(3),
    disab_grade varchar(1),
    disab_item varchar(1),
    si_grade varchar(1),
    claim_sum varchar(8),
    reci_date timestamp,
    seq_num numeric(4) not null,
    clm_reason varchar(3),
    days_burn numeric(3),
    op_freq numeric(2),
    ev_freq numeric(2),
    at_freq numeric(2)
);

CREATE TABLE IF NOT EXISTS cas.tclaim_extra_benefit_th (
    clm_code varchar(2) not null,
    extra_bene_code varchar(3) not null,
    extra_bene_desc varchar(60)
);

CREATE TABLE IF NOT EXISTS cas.tclaim_ext_dtls (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    clm_eff_dt timestamp not null,
    seq_num numeric(4) not null,
    plan_code varchar(5),
    aprov_amt numeric(13,2),
    rec_num numeric(5) not null,
    claimed_amt numeric(13,2),
    aprov_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tclaim_history_conv_th (
    claim_num numeric,
    pol_num numeric,
    claim_stat numeric,
    serial_num numeric,
    plan_cod varchar(6),
    claim_dt timestamp,
    incident_dt timestamp,
    claim_cause varchar(30),
    admission_dt timestamp,
    day_num numeric,
    sum_insured numeric,
    type_claim varchar(3),
    claim_amt numeric,
    remark varchar(60),
    benefit_item varchar(30),
    percentage numeric,
    day_num_aproved numeric,
    expenses numeric,
    max_benefit numeric,
    approved_amount numeric,
    sharing_amount numeric,
    insured_nm varchar(100),
    payment_type varchar(2),
    clinic_code varchar(6),
    trans_num numeric,
    pv_num numeric,
    pv_dt timestamp,
    hospital_nm varchar(32),
    pol_num1 varchar(10),
    cli_num varchar(13)
);

CREATE TABLE IF NOT EXISTS cas.tclaim_hosp_benefit_id (
    pol_num varchar(10) not null,
    seq_num numeric(4) not null,
    clm_code varchar(2) not null,
    class_code varchar(3) not null,
    room_board_days numeric(4),
    room_board_max numeric(17,2),
    room_board_clm numeric(17,2),
    room_board_paid numeric(17,2),
    intens_care_days numeric(4),
    intens_care_max numeric(17,2),
    intens_care_clm numeric(17,2),
    intens_care_paid numeric(17,2),
    doctor_visit_days numeric(4),
    doctor_visit_max numeric(17,2),
    doctor_visit_clm numeric(17,2),
    doctor_visit_paid numeric(17,2),
    hosp_expens_max numeric(17,2),
    hosp_expens_clm numeric(17,2),
    hosp_expens_paid numeric(17,2),
    surgeon_fee_pct numeric(5,2),
    surgeon_fee_max numeric(17,2),
    surgeon_fee_clm numeric(17,2),
    surgeon_fee_paid numeric(17,2),
    speclst_fee_max numeric(17,2),
    speclst_fee_clm numeric(17,2),
    speclst_fee_paid numeric(17,2),
    anaesth_fee_max numeric(17,2),
    anaesth_fee_clm numeric(17,2),
    anaesth_fee_paid numeric(17,2),
    op_theatre_max numeric(17,2),
    op_theatre_clm numeric(17,2),
    op_theatre_paid numeric(17,2),
    emer_outpati_max numeric(17,2),
    emer_outpati_clm numeric(17,2),
    emer_outpati_paid numeric(17,2),
    death_bene_max numeric(17,2),
    death_bene_clm numeric(17,2),
    death_bene_paid numeric(17,2),
    oth_bene_cd varchar(2),
    plan_code varchar(5) not null,
    emgncy_dentl_max numeric(17,2),
    emgncy_dentl_clm numeric(17,2),
    emgncy_dentl_paid numeric(17,2),
    private_nurse_days numeric(4),
    private_nurse_max numeric(17,2),
    private_nurse_clm numeric(17,2),
    private_nurse_paid numeric(17,2),
    ambulance_max numeric(17,2),
    ambulance_clm numeric(17,2),
    ambulance_paid numeric(17,2),
    instrm_rental_max numeric(17,2),
    instrm_rental_clm numeric(17,2),
    instrm_rental_paid numeric(17,2),
    post_hospital_max numeric(17,2),
    post_hospital_clm numeric(17,2),
    post_hospital_paid numeric(17,2),
    surgy_class varchar(3),
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    ot_room_board_max numeric(17,2),
    ot_room_board_clm numeric(17,2),
    ot_room_board_paid numeric(17,2),
    ot_intens_care_max numeric(17,2),
    ot_intens_care_clm numeric(17,2),
    ot_intens_care_paid numeric(17,2),
    ot_doctor_visit_max numeric(17,2),
    ot_doctor_visit_clm numeric(17,2),
    ot_doctor_visit_paid numeric(17,2),
    ot_hosp_expens_max numeric(17,2),
    ot_hosp_expens_clm numeric(17,2),
    ot_hosp_expens_paid numeric(17,2),
    ot_surgeon_fee_max numeric(17,2),
    ot_surgeon_fee_clm numeric(17,2),
    ot_surgeon_fee_paid numeric(17,2),
    ot_speclst_fee_max numeric(17,2),
    ot_speclst_fee_clm numeric(17,2),
    ot_speclst_fee_paid numeric(17,2),
    ot_anaesth_fee_max numeric(17,2),
    ot_anaesth_fee_clm numeric(17,2),
    ot_anaesth_fee_paid numeric(17,2),
    ot_op_theatre_max numeric(17,2),
    ot_op_theatre_clm numeric(17,2),
    ot_op_theatre_paid numeric(17,2),
    ot_emer_outpati_max numeric(17,2),
    ot_emer_outpati_clm numeric(17,2),
    ot_emer_outpati_paid numeric(17,2),
    ot_death_bene_max numeric(17,2),
    ot_death_bene_clm numeric(17,2),
    ot_death_bene_paid numeric(17,2),
    ot_emgncy_dentl_max numeric(17,2),
    ot_emgncy_dentl_clm numeric(17,2),
    ot_emgncy_dentl_paid numeric(17,2),
    ot_private_nurse_max numeric(17,2),
    ot_private_nurse_clm numeric(17,2),
    ot_private_nurse_paid numeric(17,2),
    ot_ambulance_max numeric(17,2),
    ot_ambulance_clm numeric(17,2),
    ot_ambulance_paid numeric(17,2),
    ot_instrm_rental_max numeric(17,2),
    ot_instrm_rental_clm numeric(17,2),
    ot_instrm_rental_paid numeric(17,2),
    ot_post_hospital_max numeric(17,2),
    ot_post_hospital_clm numeric(17,2),
    ot_post_hospital_paid numeric(17,2),
    small_ope_pct numeric(5,2),
    small_ope_max numeric(17,2),
    small_ope_clm numeric(17,2),
    small_ope_paid numeric(17,2),
    xray_labs_max numeric(17,2),
    xray_labs_clm numeric(17,2),
    xray_labs_paid numeric(17,2),
    hosp_benefit_days numeric(4),
    hosp_benefit_max numeric(17,2),
    hosp_benefit_clm numeric(17,2),
    hosp_benefit_paid numeric(17,2),
    anaesth_fee_pct numeric(5,2),
    total_amt_fax_claim numeric(17,2)
);

CREATE TABLE IF NOT EXISTS cas.tclaim_hosp_max_bene_id (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    crcy_code varchar(2) not null,
    class_code varchar(3) not null,
    benefit_id varchar(10) not null,
    max_benefit numeric not null,
    max_days numeric(5)
);

CREATE TABLE IF NOT EXISTS cas.tclaim_icd10_id (
    icd_code varchar(9) not null,
    icd_name varchar(255),
    icd_eng_name varchar(255)
);

CREATE TABLE IF NOT EXISTS cas.tclaim_letters_id (
    pol_num varchar(10) not null,
    seq_num numeric(4) not null,
    lett_print_dt timestamp not null,
    lett_no varchar(25) not null
);

CREATE TABLE IF NOT EXISTS cas.tclaim_pending_process_id (
    pol_num varchar(10) not null,
    seq_num numeric(4) not null,
    clm_pend_cd varchar(3) not null,
    notes varchar(500) not null,
    folwup_from timestamp not null,
    folwup_until timestamp
);

CREATE TABLE IF NOT EXISTS cas.tclaim_pending_comments_id (
    pol_num varchar(10) not null,
    seq_num numeric(4) not null,
    clm_pend_cd varchar(3) not null,
    comments_dt timestamp not null,
    user_id varchar(30) not null,
    comments varchar(1000) not null,
    comnt_seq_num numeric(10) not null
);

CREATE TABLE IF NOT EXISTS cas.tclaim_period_chk_id (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    clm_code varchar(2) not null,
    provision_cd varchar(3) not null,
    peri_begin_item varchar(100) not null,
    peri_end_item varchar(100) not null,
    eff_from timestamp not null,
    eff_until timestamp not null,
    peri_dy_from numeric(4),
    peri_dy_until numeric(4),
    peri_mo_from numeric(4),
    peri_mo_until numeric(4),
    othr_cond varchar(100) not null
);

CREATE TABLE IF NOT EXISTS cas.tclaim_plans_id (
    clm_code varchar(2) not null,
    plan_code varchar(5) not null,
    company_cd varchar(1),
    claim_avail varchar(1),
    sum_with_base varchar(1),
    vers_num varchar(2) not null,
    pol_exp varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tclaim_provision_id (
    clm_code varchar(2) not null,
    provision_cd varchar(3) not null,
    paragraph varchar(10) not null,
    verse varchar(10) not null,
    descript varchar(4000) not null,
    from_date timestamp not null,
    until_date timestamp not null,
    othr_cond varchar(100),
    plan_code varchar(5) not null,
    vers_num varchar(2) not null
);

CREATE TABLE IF NOT EXISTS cas.tclaim_prvd_accts (
    clm_code varchar(2) not null,
    acct_mne_cd varchar(8) not null,
    prvd_or_expnse varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tclaim_quota_edit (
    clm_code varchar(2) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_clas varchar(3) not null,
    daily_income numeric(5),
    max_days numeric(5),
    max_reimburse numeric(9),
    dscnt_pct numeric(5,2),
    crcy_code varchar(2) default '*' not null
);

CREATE TABLE IF NOT EXISTS cas.tclaim_rejection_id (
    pol_num varchar(10) not null,
    seq_num numeric(4) not null,
    clm_code varchar(2) not null,
    plan_code varchar(5) not null,
    reject_cd varchar(3) not null,
    paragraph varchar(10) not null,
    verse varchar(10) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null
);

CREATE TABLE IF NOT EXISTS cas.tclaim_spcl_bnft_id (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    sex_code varchar(1) not null,
    spcl_bnft_id varchar(2) not null,
    spcl_bnft_desc varchar(100) not null,
    bnft_max_pct numeric(3) not null,
    bnft_max_amt numeric(17,2) not null,
    is_bnft_locked varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tclaim_spcl_bnft_trxn_id (
    pol_num varchar(10) not null,
    seq_num numeric(4) not null,
    clm_code varchar(2) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    spcl_bnft_id varchar(2) not null,
    spcl_bnft_amt numeric(17,2) not null
);

CREATE TABLE IF NOT EXISTS cas.tclaim_surgeon_pct_id (
    surgeon_code varchar(4) not null,
    surgeon_group varchar(250) not null,
    surgeon_group_eng varchar(250) not null,
    surgeon_name varchar(500) not null,
    surgeon_name_eng varchar(500) not null,
    surgeon_pct numeric(5,2) not null,
    surgy_set_cd varchar(3) not null,
    surgy_class varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tclaim_surgy_set_id (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    surgy_set_cd varchar(3) not null
);

CREATE TABLE IF NOT EXISTS cas.tclaim_tpa_bene_map (
    plan_code varchar(20) not null,
    vers_num varchar(2) not null,
    benefit_id varchar(2),
    main_benefit_code varchar(10),
    main_benefit_name varchar(20),
    insurer_main_benefit_code varchar(10),
    benefit_code varchar(10),
    benefit_name varchar(100),
    insurer_benefit_code varchar(10),
    sub_benefit_code varchar(10),
    sub_benefit_name varchar(100),
    insurer_sub_benefit_code varchar(2),
    benefit_long_name varchar(100)
);

CREATE TABLE IF NOT EXISTS cas.tclaim_treatment_id (
    pol_num varchar(10) not null,
    seq_num numeric(4) not null,
    pati_cli_num varchar(13) not null,
    pati_age numeric(3) not null,
    clm_hosp_begin_dt timestamp not null,
    clm_hosp_end_dt timestamp not null,
    anamnesa varchar(1000),
    fst_symptoms_dt timestamp,
    fst_consult_dt timestamp,
    referred_doctor varchar(40),
    physical_exam varchar(500),
    rel_to_congenital varchar(1) not null,
    rel_to_pregnancy varchar(1) not null,
    rel_to_accident varchar(1) not null,
    permanent_disable varchar(1),
    time_for_recovery numeric(4),
    diagnose varchar(500) not null,
    disease_code varchar(9) not null,
    therapy varchar(500),
    hospital_name varchar(100) not null,
    doctor_name varchar(40),
    prev_treat_begin timestamp,
    prev_treat_end timestamp,
    prev_diagnose varchar(500),
    prev_hosp_name varchar(100),
    days_of_treat_curr numeric(5),
    days_of_treat_prev numeric(5),
    birth varchar(1),
    miscarriage varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tclient_addresses (
    cli_num varchar(13) not null,
    addr_typ numeric(2) not null,
    addr_1 varchar(60) not null,
    addr_2 varchar(60),
    addr_3 varchar(60),
    zip_code varchar(6),
    invalid_addr_ind varchar(1) default 'N' not null,
    addr_4 varchar(60),
    res_code varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tclient_addresses_bf_re (
    cli_num varchar(13) not null,
    addr_typ numeric(2) not null,
    addr_1 varchar(60) not null,
    addr_2 varchar(60),
    addr_3 varchar(60),
    zip_code varchar(6),
    invalid_addr_ind varchar(1) not null,
    addr_4 varchar(60),
    res_code varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tclient_addresses_rtnmail (
    cli_num varchar(10) not null,
    addr_typ numeric(2) not null,
    addr_1 varchar(60) not null,
    addr_2 varchar(60),
    addr_3 varchar(60),
    zip_code varchar(6),
    invalid_addr_ind varchar(1) not null,
    addr_4 varchar(60)
);

CREATE TABLE IF NOT EXISTS cas.tclient_address_log (
    cli_num varchar(13) not null,
    addr_typ numeric(2) not null,
    addr_1 varchar(60) not null,
    addr_2 varchar(60),
    addr_3 varchar(60),
    addr_4 varchar(60),
    zip_code varchar(6),
    invalid_addr_ind varchar(1) not null,
    crt_date timestamp,
    exp_date timestamp
);

CREATE TABLE IF NOT EXISTS cas.tclient_bank_accounts (
    cli_num varchar(13) not null,
    bank_acct_typ numeric(2) not null,
    bank_cd varchar(13) not null,
    bank_acct_nm varchar(40) not null,
    bank_acct_num varchar(20) not null,
    id_num varchar(20),
    id_typ varchar(1),
    bank_sv_kd varchar(1),
    status varchar(2),
    cpf_inv_acct varchar(20),
    acct_xpry_dt timestamp,
    bank_acct_title varchar(20),
    card_cat varchar(1),
    closing_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tclient_bank_kbs (
    cli_num varchar(10) not null,
    bank_acct_typ numeric(2) not null,
    bank_cd varchar(13) not null,
    bank_acct_nm varchar(40) not null,
    bank_acct_num varchar(20) not null,
    id_num varchar(20),
    id_typ varchar(1),
    bank_sv_kd varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tclient_consolidations (
    cli_num varchar(13) not null,
    cli_cnsldt_num varchar(10) not null,
    cnsldt_dt timestamp,
    rec_status varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tclient_details_bf_re (
    cli_num varchar(13) not null,
    terr_cd varchar(2) not null,
    state_cd varchar(2) not null,
    cli_nm varchar(60) not null,
    smkr_code varchar(1) not null,
    addr_typ numeric(2),
    birth_dt timestamp,
    fax_num varchar(20),
    id_num varchar(20),
    othr_phon_num varchar(20),
    prim_phon_num varchar(20),
    cli_rmrk varchar(500),
    sex_code varchar(1),
    cli_cnsldt_ind varchar(1),
    id_typ varchar(1),
    occp_code varchar(10),
    offce_addr_typ numeric(2),
    bill_addr_typ numeric(2),
    reg_addr_typ numeric(2),
    soldier_ind varchar(1) not null,
    res_addr_typ numeric(2),
    email_add varchar(40),
    hp_num varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.tclient_detail_fatca (
    cli_num varchar(13) not null,
    privacy_waiv varchar(1),
    all_no_us varchar(1),
    us_citizen varchar(1),
    us_perm_res varchar(1),
    us_res varchar(1),
    country varchar(80) default '1',
    nationality varchar(80) default '1',
    pol_fatca_stat varchar(2) default 'N',
    update_dt timestamp DEFAULT CURRENT_TIMESTAMP,
    relevance_upd_dt timestamp DEFAULT CURRENT_TIMESTAMP,
    cli_fatca_stat varchar(2) default 'N',
    birth_country_cd varchar(5) default '1'
);

CREATE TABLE IF NOT EXISTS cas.tclient_detail_log (
    cli_num varchar(13) not null,
    id_num varchar(20),
    cli_title varchar(20),
    cli_nm varchar(60) not null,
    addr_typ numeric(2),
    sex_code varchar(1),
    occp_code varchar(10),
    smkr_code varchar(1) not null,
    prim_phon_num varchar(20),
    hp_num varchar(20),
    othr_phon_num varchar(20),
    email_add varchar(40),
    crt_date timestamp,
    exp_date timestamp
);

CREATE TABLE IF NOT EXISTS cas.tclient_family_links (
    fmly_num varchar(10) not null,
    cli_num varchar(10) not null,
    hld_cli_num varchar(10) not null,
    link_typ varchar(2) not null,
    rec_status varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tclient_policy_links (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    link_typ varchar(1) not null,
    rec_status varchar(1) not null,
    rel_to_insrd varchar(2),
    addr_typ numeric(2),
    bank_acct_typ numeric(2),
    xcpt_addr_typ numeric(2),
    payo_bank_acct_typ numeric(2),
    res_addr_typ numeric(2)
);

CREATE TABLE IF NOT EXISTS cas.tclient_policy_links_bf_re (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    link_typ varchar(1) not null,
    rec_status varchar(1) not null,
    rel_to_insrd varchar(2),
    addr_typ numeric(2),
    bank_acct_typ numeric(2),
    xcpt_addr_typ numeric(2),
    payo_bank_acct_typ numeric(2),
    res_addr_typ numeric(2)
);

CREATE TABLE IF NOT EXISTS cas.tclient_policy_links_log (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    link_typ varchar(1) not null,
    rec_status varchar(1) not null,
    rel_to_insrd varchar(2),
    addr_typ numeric(2),
    bank_acct_typ numeric(2),
    xcpt_addr_typ numeric(2),
    payo_bank_acct_typ numeric(2),
    res_addr_typ numeric(2),
    crt_date timestamp,
    exp_date timestamp
);

CREATE TABLE IF NOT EXISTS cas.tclient_recruit_details_sh (
    pol_num varchar(10),
    cli_num varchar(10),
    cli_nm varchar(40),
    seq_num numeric,
    loc_code varchar(10),
    br_code varchar(10),
    unit_code varchar(10),
    agt_code varchar(5),
    agt_nm varchar(40),
    ref_nm varchar(40),
    ref_addr varchar(60),
    zip_code varchar(6),
    phone varchar(30),
    sex_code varchar(1),
    interview varchar(1),
    gift_released_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tclient_recruit_headers_sh (
    cli_num varchar(10) not null,
    cli_nm varchar(40) not null,
    sex_code varchar(1),
    id_num varchar(20),
    addr_1 varchar(60) not null,
    addr_2 varchar(60),
    addr_3 varchar(60),
    invalid_addr_ind varchar(1) not null,
    zip_code varchar(6),
    prim_phon_num varchar(20),
    othr_phon_num varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.tclient_telephone_details (
    cli_num varchar(10) not null,
    addr_typ numeric(2),
    fax_num varchar(20),
    othr_phon_num varchar(20),
    prim_phon_num varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.tclinic (
    clinic_code varchar(6) not null,
    clinic_name varchar(100),
    addr_1 varchar(60),
    addr_2 varchar(60),
    addr_3 varchar(60),
    addr_4 varchar(60),
    zip_code varchar(6),
    phon_num varchar(30),
    contact_nm varchar(70),
    contact_pos varchar(50),
    fax_num varchar(20),
    email varchar(40),
    bank_cd varchar(13),
    bank_ac_num varchar(20),
    wht_tax numeric(5,2),
    vat_rate numeric(5,2),
    loc_latitude numeric(9,6),
    loc_longtitude numeric(9,6),
    contract varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tclinic_payment_note_detail (
    set_num numeric(3) not null,
    ltr_line numeric(3) not null,
    ltr_detail varchar(100)
);

CREATE TABLE IF NOT EXISTS cas.tcli_addr_histories_tw (
    cli_num varchar(10) not null,
    addr_typ numeric(2) not null,
    invalid_addr_ind varchar(1) not null,
    trxn_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tcli_agt_relations (
    cli_num varchar(13),
    agt_code varchar(6),
    related varchar(1),
    addr_match varchar(2),
    relation varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tcli_agt_relations_bk (
    cli_num varchar(13),
    agt_code varchar(6)
);

CREATE TABLE IF NOT EXISTS cas.tcli_pol_link_hist (
    pol_num varchar(10),
    link_typ varchar(1),
    old_cli_num varchar(10),
    new_cli_num varchar(10),
    assign_dt timestamp,
    trxn_cd varchar(8),
    reasn_code varchar(3),
    last_mode_prem numeric(11,2),
    last_face_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tcli_pol_link_insrd (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    link_typ varchar(1) not null,
    rel_to_insrd varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tcli_pol_link_thrdprty_sg (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    link_typ varchar(1) default 'T',
    prty_ind varchar(1) not null,
    rec_status varchar(1) not null,
    nationality varchar(5),
    busi_rel varchar(5),
    nat_of_busi varchar(2),
    country_of_reg varchar(2),
    cmpy_nm varchar(100),
    addr_typ numeric(2),
    res_addr_typ numeric(2)
);

CREATE TABLE IF NOT EXISTS cas.tclmout_clm_code_mapping (
    clmout_plan_code varchar(20) not null,
    event_type varchar(10) not null,
    mit_clm_code varchar(5) not null
);

CREATE TABLE IF NOT EXISTS cas.tclmout_detail (
    file_id varchar(10) not null,
    case_no varchar(20) not null,
    plan_code varchar(10) not null,
    benefit_code varchar(10) not null,
    claim_period numeric(5,2),
    incurred_amount numeric(12,2),
    payable_amount numeric(12,2) not null,
    declined_amount numeric(12,2) default 0 not null,
    claim_status varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tclmout_file_ctrl (
    file_id varchar(10) not null,
    cas_date timestamp,
    load_date timestamp,
    total_header numeric,
    total_detail numeric,
    loaded varchar(10) default 'N',
    load_pass numeric default 0,
    load_fail numeric default 0
);

CREATE TABLE IF NOT EXISTS cas.tclmout_header (
    file_id varchar(10) not null,
    case_no varchar(20) not null,
    policy_no varchar(20) not null,
    event_type varchar(3) not null,
    case_source varchar(10) not null,
    claim_type varchar(10) not null,
    accident_date timestamp not null,
    start_date timestamp,
    discharge_date timestamp,
    continuous_case varchar(20),
    total_incurred_amount numeric(12,2),
    total_payable_amount numeric(12,2) not null,
    total_declined_amount numeric(12,2) default 0 not null,
    provider_code varchar(10),
    diagnosis_code varchar(50) not null,
    diagnosis varchar(500) not null,
    icd9code varchar(50),
    icd9 varchar(500),
    claim_status varchar(10) not null,
    decision_date timestamp,
    value_date timestamp,
    batch_regis_no varchar(30),
    payee_name varchar(150),
    payee_mode varchar(2),
    account_no varchar(30),
    invoice_no varchar(30),
    reject_reason_code varchar(255),
    withholding_tax numeric(12,2),
    withholding_date timestamp,
    wht_reffno numeric(12,2),
    discount numeric(12,2),
    bankcode varchar(14),
    surgery_percent varchar(14),
    change_flag varchar(10),
    adjustamount numeric(12,2),
    pending_cd varchar(255),
    remark varchar(255),
    load_date timestamp,
    load_status varchar(1),
    submit_date timestamp
);

CREATE TABLE IF NOT EXISTS cas.tclmout_plan_mapping (
    clmout_plan_code varchar(10),
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_typ varchar(1) not null,
    class_code varchar(3) not null,
    benefit_id varchar(10) not null,
    max_benefit numeric not null,
    max_days numeric(5)
);

CREATE TABLE IF NOT EXISTS cas.tclmout_tpa_import_member (
    file_dt varchar(20),
    seq varchar(10),
    company_name char(8),
    member_code varchar(17),
    title varchar(20),
    name_thai varchar(60),
    surname_thai varchar(10),
    name_eng varchar(10),
    surname_eng varchar(10),
    member_type char(1),
    principle_ref_no varchar(10),
    gender varchar(1),
    marital_status varchar(10),
    nationality varchar(10),
    citizen_id varchar(20),
    other_id varchar(20),
    date_of_birth timestamp,
    age varchar(10),
    building_no varchar(60),
    village_no varchar(60),
    lane_alley varchar(60),
    road varchar(60),
    sub_district varchar(10),
    district varchar(10),
    province varchar(10),
    post_code varchar(6),
    country varchar(10),
    contact_person_name varchar(10),
    office_tel_no varchar(10),
    home_tel_no varchar(10),
    mobile_no varchar(10),
    email varchar(10),
    fax_no varchar(20),
    staff_no varchar(10),
    join_date varchar(10),
    employment_date varchar(10),
    policy_number varchar(14),
    application_number varchar(10),
    certificate_no varchar(10),
    insurer_card_no varchar(10),
    insurer_prev_card_no varchar(10),
    policy_year numeric,
    life_pol_issue_date varchar(10),
    validity_date varchar(10),
    life_contract_date timestamp,
    plan_code varchar(8),
    plan_issue_date timestamp,
    plan_contract_date varchar(10),
    plan_eff_from_date timestamp,
    plan_eff_to_date timestamp,
    plan_paid_date varchar(10),
    plan_paid_to_date varchar(10),
    plan_next_due_date varchar(10),
    policy_expired_date varchar(10),
    renewal_date varchar(10),
    plan_suspen_date varchar(10),
    plan_suspen_to_date varchar(10),
    plan_rider varchar(8),
    rider_issue_date timestamp,
    rider_contract_date varchar(10),
    rider_eff_from_date timestamp,
    rider_eff_to_date timestamp,
    rider_paid_date varchar(10),
    rider_paid_to_date varchar(10),
    rider_next_due_date varchar(10),
    rider_term_date varchar(10),
    rider_reins_date varchar(10),
    rider_suspen_date varchar(10),
    condition_detail varchar(1000),
    bank varchar(13),
    bank_account_no varchar(20),
    payee_name varchar(200),
    payee_citizen_id varchar(10),
    bu varchar(10),
    branch varchar(10),
    cost_center varchar(10),
    agent_code varchar(6),
    agent_leader_code varchar(10),
    broker varchar(10),
    vip char(1),
    premium_frequency varchar(5),
    member_premium varchar(10),
    premium_ipd varchar(10),
    premium_opd varchar(10),
    sum_insured varchar(10),
    social_secu_hospital varchar(10),
    remark_1 numeric,
    remark_2 timestamp,
    remark_3 numeric,
    remark_4 varchar(10),
    remark_5 varchar(10),
    remark_6 varchar(10),
    remark_7 varchar(10),
    remark_8 varchar(10),
    remark_9 varchar(10),
    remark_10 varchar(100),
    transtype char(1),
    reason varchar(10),
    note varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tcmp_client_details (
    cli_num varchar(13) not null,
    terr_cd varchar(2) not null,
    state_cd varchar(2) not null,
    cli_nm varchar(60) not null,
    smkr_code varchar(1) not null,
    addr_typ numeric(2),
    birth_dt timestamp,
    fax_num varchar(20),
    id_num varchar(20),
    othr_phon_num varchar(20),
    prim_phon_num varchar(20),
    cli_rmrk varchar(500),
    sex_code varchar(1),
    cli_cnsldt_ind varchar(1),
    id_typ varchar(1),
    occp_code varchar(10),
    offce_addr_typ numeric(2),
    bill_addr_typ numeric(2),
    reg_addr_typ numeric(2),
    soldier_ind varchar(1) not null,
    res_addr_typ numeric(2),
    email_add varchar(40),
    hp_num varchar(20),
    bnfy_title varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.tcmp_policys (
    pol_num varchar(10) not null,
    mode_prem numeric(11,2) not null,
    ovr_loan_ind varchar(1) not null,
    frez_code varchar(1) not null,
    ipo_ind varchar(1) not null,
    vp_ind varchar(1) not null,
    reins_ind varchar(1) not null,
    bill_mthd varchar(1) not null,
    crcy_code varchar(2) not null,
    last_avy_dt timestamp not null,
    last_pd_to_dt timestamp not null,
    pd_to_dt timestamp not null,
    pol_eff_dt timestamp not null,
    pol_iss_dt timestamp,
    pol_reiss_dt timestamp,
    cnfrm_acpt_dt timestamp,
    pol_rlse_dt timestamp,
    sbmt_dt timestamp not null,
    pol_stat_cd varchar(1) not null,
    state_cd varchar(2) not null,
    pol_trmn_dt timestamp,
    div_opt varchar(1) not null,
    terr_cd varchar(2) not null,
    dscnt_prem numeric(11,2) not null,
    pol_susp numeric(13,2) not null,
    pmt_susp numeric(11,2) not null,
    ipo_last_refu_yr numeric(4),
    pmt_mode varchar(5) not null,
    bill_prem numeric(11,2) not null,
    bill_to_dt timestamp not null,
    pac_loan_repy numeric(11,2),
    pac_bk_ctr varchar(1),
    pac_eff_dt timestamp,
    medic_code varchar(10),
    medic_dt timestamp,
    incmplt_cd varchar(2),
    pend_cd varchar(2),
    subj_to_cd varchar(2),
    uwg_clas varchar(30),
    fran_num varchar(4),
    agt_code varchar(6),
    nfo_opt varchar(1) not null,
    nfo_eff_dt timestamp,
    zap_ind varchar(1),
    aea_ind varchar(1) not null,
    lnb_ind varchar(1) not null,
    hiv_ind varchar(1) not null,
    pol_rmrk varchar(500),
    apl_laps_dt timestamp,
    pc_typ varchar(10),
    pc_recv_dt timestamp,
    pc_pend_reasn varchar(10),
    pc_efft_date timestamp,
    apl_ext_days numeric(3),
    nyr_mode_prem numeric(11,2) not null,
    nyr_dscnt_prem numeric(11,2) not null,
    renw_yr numeric(3) not null,
    run_num numeric(2),
    pol_app_dt timestamp,
    tlia_code_1 varchar(10),
    tlia_code_2 varchar(10),
    tlia_code_3 varchar(10),
    disab_clas varchar(3),
    restr_case_cnt_ind varchar(1) not null,
    comm_wthld_dt timestamp,
    nb_user_id varchar(30) not null,
    last_actv_dt timestamp,
    joint_cli_dth_ind varchar(1) not null,
    comprop_prem numeric(11,2),
    resv_dnr_amt numeric(13,2),
    xcpt_bill_cd varchar(1),
    nb_pc_pol_tot numeric(9),
    cnfrm_prt_dt timestamp,
    os_anty_susp numeric(13,2),
    payo_mthd varchar(1),
    anty_stat_cd varchar(1),
    nxt_eff_mode_prem numeric(11,2),
    nxt_eff_dscnt_prem numeric(11,2),
    nxt_eff_prem_dt timestamp,
    ctr_prem numeric(11,2),
    nxt_eff_ctr_prem numeric(11,2),
    lump_sum_ind varchar(1),
    lump_sum_pmt_amt numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tcmp_client_policy_links (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    link_typ varchar(1) not null,
    rec_status varchar(1) not null,
    rel_to_insrd varchar(2),
    addr_typ numeric(2),
    bank_acct_typ numeric(2),
    xcpt_addr_typ numeric(2),
    res_addr_typ numeric(2)
);

CREATE TABLE IF NOT EXISTS cas.tplans (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    loan_int_typ varchar(1) not null,
    loan_dflt_int numeric(7,5) not null,
    loan_max_pct numeric(5,2) not null,
    mli_prem_prd numeric(3) not null,
    mli_bnft_prd numeric(3) not null,
    mli_ln_bus varchar(2) not null,
    par_code varchar(1) not null,
    assum_int_rt numeric(7,5) not null,
    comm_by_age varchar(1) not null,
    comm_by_band varchar(1) not null,
    comm_by_crcy varchar(1) not null,
    comm_by_dur varchar(1) not null,
    comm_ctl varchar(1) not null,
    mli_fnd_code varchar(2) not null,
    mli_mnl_code varchar(3) not null,
    plan_lng_desc varchar(50) not null,
    plan_shrt_desc varchar(20) not null,
    mli_plan_type varchar(1) not null,
    mli_sub_type varchar(3) not null,
    ins_typ varchar(3) not null,
    mult_base_ind varchar(1) not null,
    mode_fct_mo numeric(6,5) not null,
    mode_fct_semi numeric(6,5) not null,
    mode_fct_qtr numeric(6,5) not null,
    nfo_dflt varchar(1) not null,
    nfo_apl_cd varchar(1) not null,
    nfo_rpu_ok varchar(1) not null,
    nfo_eti_ok varchar(1) not null,
    renw_prd numeric(3) not null,
    renw_cntct_ind varchar(1) not null,
    spec_fcn_ind varchar(1) not null,
    cv_avail_ind varchar(1) not null,
    cvg_typ varchar(1) not null,
    dscnt_cv_rt numeric(5,5) not null,
    dth_bnft_ind varchar(1) not null,
    sngl_prem_ind varchar(1) not null,
    div_dflt varchar(1) not null,
    eff_fr_dt timestamp not null,
    endow_ctl varchar(1) not null,
    fmly_cvg_ind varchar(1) not null,
    ipo_pct numeric(5,2) not null,
    ipo_trmn_age numeric(3) not null,
    ipo_trmn_yr numeric(3) not null,
    prem_age_basis varchar(1) not null,
    prem_by_sex varchar(1) not null,
    prem_by_band varchar(1) not null,
    prem_by_clas varchar(1) not null,
    prem_by_smkr varchar(1) not null,
    prem_by_occp varchar(1) not null,
    pc_fct_ann numeric(7,5) not null,
    pc_fct_semi numeric(7,5) not null,
    pc_fct_qtr numeric(7,5) not null,
    pc_fct_mo numeric(7,5) not null,
    eff_to_dt timestamp,
    mkt_plan_nm varchar(50) not null,
    prem_by_ppp varchar(1) not null,
    ppp_typ varchar(1) not null,
    bpp_typ varchar(1) not null,
    ipo_max_fa numeric(13,2) not null,
    off_incep_typ varchar(1),
    prod_code varchar(5),
    vp_dflt varchar(1) not null,
    prem_by_age varchar(1) not null,
    cntrct_pg_int_rt numeric(7,5) not null,
    md_key varchar(6),
    div_fct_k1 numeric(7,3),
    div_fct_k2 numeric(7,3),
    div_fct_k3 numeric(7,3),
    ipo_max_fa_me numeric(5,2),
    plan_avail_cd varchar(1) not null,
    ipo_avail_ind varchar(1) not null,
    cmp_page2_frmt numeric(2) not null,
    anty_ctl varchar(1),
    anty_freq numeric(2),
    no_grp_dscnt_ind varchar(1) not null,
    sell_as_rdr_ind varchar(1) not null,
    rst_prem_ind varchar(1),
    lump_sum_int_rt numeric(7,5),
    band_like_base_ind varchar(1) not null,
    band_prem_prd numeric(3),
    eti_factor numeric(4,3) not null,
    comm_by_dc varchar(1),
    ret_prem_ind varchar(1),
    pkg_plan_ind varchar(1),
    age_calc_rule varchar(1),
    cb_pct_1st numeric(3),
    cb_pct_2nd numeric(3),
    cv_payo_mth numeric(3),
    crcy_code varchar(2) not null,
    maturity_ind varchar(1),
    mode_fct_mo_auto numeric(6,5),
    prem_by_int_rt varchar(1),
    pua_payo_mth numeric(3),
    tb_ctl varchar(1),
    wp_typ varchar(1),
    rpu_par_code varchar(1),
    eti_par_code varchar(1),
    eti_endow_ind varchar(1),
    sec_age_typ varchar(1),
    prem_by_dist_chnl varchar(1),
    prem_by_dur varchar(1) not null,
    prem_by_sec_sex varchar(1) not null,
    add_rt_basis varchar(5),
    add_rt_factor_asp numeric(13,2),
    add_rt_factor_cp numeric(13,2),
    add_rt_factor_ind varchar(1),
    cb_months_comm numeric(2),
    cb_months_pc numeric(2),
    corridor_ctl varchar(1),
    corridor_pct numeric(3),
    cu_months_comm numeric(2),
    cu_months_pc numeric(2),
    db_adjust varchar(5),
    display_cat varchar(1),
    dth_bnft_pct_x numeric(6,2),
    dth_bnft_pct_y numeric(6,2),
    dth_bnft_ref_amt numeric(13,2),
    ep_cap numeric(3),
    ep_pc_fct numeric(7,5),
    fa_rnd numeric(1),
    fnd_deal_mthd varchar(5),
    fnd_surr_rule varchar(5),
    invst_prd numeric(3),
    max_psu_pct numeric(5,2),
    min_loan_amt numeric(11,2),
    min_nar numeric(13,2),
    min_psu_amt numeric(11,2),
    mode_fct_ctl varchar(1),
    no_lapse_gurt_ind varchar(1),
    plan_native_desc varchar(200),
    prem_by_rcc_ind varchar(1),
    realloc_ind varchar(1),
    recurr_bill_ind varchar(1),
    recurr_rsp_mo numeric(11,2),
    recurr_rsp_qtr numeric(11,2),
    recurr_rsp_semi numeric(11,2),
    recurr_rsp_yr numeric(11,2),
    rpt_layout_mthd varchar(5),
    surr_pv_typ varchar(1),
    xces_prem_mpre_factor numeric(3),
    arrear_calc_mthd varchar(5),
    comm_by_add_rt_basis varchar(1),
    prem_app_mthd varchar(5),
    prem_by_crcy varchar(1),
    prem_by_no_of_insrd varchar(1),
    prem_calc_mthd varchar(5),
    prod_cat varchar(5),
    min_tro_amt numeric(13,3),
    min_topup_amt numeric(13,2),
    rider_typ varchar(2),
    min_pol_prem numeric(13,2),
    lien_ind varchar(1),
    sa_tup_pct numeric(5,2),
    chg_insrd_ind varchar(1),
    ph_opt varchar(1),
    ph_avail_mth numeric(3),
    rst_mthd varchar(6),
    coi_age_basis varchar(1),
    endow_payo_mth numeric(3),
    eti_endow_ctl varchar(1),
    rpu_endow_ctl varchar(1),
    nsp_by_bpp varchar(1) default 'N' not null,
    nsp_by_band varchar(1) default 'N' not null,
    dv_by_ppp varchar(1) default 'N' not null,
    pua_div_opt varchar(1),
    db_by_ppp varchar(1) default 'N' not null,
    rv_fct_pmt numeric(1),
    max_ln_fct_div numeric(1),
    rv_fct_div numeric(1),
    anty_mature_yr numeric(2),
    db_opt varchar(1),
    int_snstv_ind varchar(1),
    no_band_pct_extra varchar(1),
    plan_cpny varchar(1),
    wp_mthd varchar(1),
    db_by_dth_typ varchar(1),
    div_payo_mth numeric(3),
    sep_loan_ind varchar(1),
    sa_fct_ind varchar(1),
    pv_by_sec_age varchar(1) default 'N' not null,
    pv_by_ppp varchar(1) default 'N' not null,
    pv_by_band varchar(1) default 'N' not null,
    prem_by_bpp varchar(1) default 'N' not null,
    pdf_cap_opt varchar(5),
    pc_ctl varchar(2),
    nsp_by_ppp varchar(1) default 'N' not null,
    dv_by_bpp varchar(1) default 'N' not null,
    db_by_bpp varchar(1) default 'N' not null,
    dscnt_by_bill_mthd varchar(1),
    dscnt_by_prem_band varchar(1),
    sa_wthdr_pct numeric(5,2),
    pv_by_bpp varchar(1) default 'N' not null,
    comm_by_bpp varchar(1) default 'N' not null,
    prem_fa_opt varchar(1) default '0' not null,
    fnd_lay_ind varchar(1),
    sio_ind_dflt varchar(1),
    anty_mature_age numeric(3),
    div_calc_mthd varchar(1) default '0' not null,
    valn_code varchar(5),
    comm_by_bnft_dur varchar(1) default 'N' not null,
    comm_by_anp varchar(1),
    eti_fa_ind varchar(1),
    eti_dth_bnft_ind varchar(1) default '1' not null,
    rpu_dth_bnft_ind varchar(1) default '1' not null,
    set_ctl varchar(2),
    set_opt_dflt varchar(5),
    ph_mthd varchar(1),
    gen_renw_pc_ind varchar(1),
    plan_shrt_cd varchar(5),
    mis_prod_cat varchar(1),
    loyal_bns_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tcmp_coverages (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    cvg_typ varchar(1) not null,
    cvg_reasn varchar(1) not null,
    occp_clas varchar(1) not null,
    par_code varchar(1) not null,
    bnft_dur numeric(3) not null,
    prem_dur numeric(3) not null,
    pua_tot_amt numeric(13,2) not null,
    rel_to_insrd varchar(2) not null,
    smkr_code varchar(1) not null,
    sex_code varchar(1) not null,
    cvg_prem numeric(11,2) not null,
    cvg_stat_cd varchar(1) not null,
    comm_ctl varchar(1) not null,
    comm_vers varchar(2) not null,
    cvg_clas varchar(3) not null,
    dscnt_pct numeric(5,2) not null,
    dscnt_prem numeric(11,2) not null,
    dth_bnft_amt numeric(13,2) not null,
    face_amt numeric(13,2) not null,
    band_face_amt numeric(13,2) not null,
    face_ratg numeric(5,2) not null,
    ins_typ varchar(1) not null,
    cvg_eff_age numeric(3) not null,
    cvg_iss_dt timestamp,
    xpry_dt timestamp not null,
    nyr_cvg_prem numeric(11,2) not null,
    nyr_dscnt_prem numeric(11,2) not null,
    pua_crnt_amt numeric(13,2) not null,
    prem_vers varchar(2) not null,
    pol_val_vers varchar(2) not null,
    prem_ovrid_end_date timestamp,
    div_crnt_amt numeric(11,2) not null,
    joint_cli_num varchar(10),
    joint_rel_insrd varchar(2),
    temp_flat_dur numeric(3) not null,
    temp_flat_unit_prem numeric(7,3) not null,
    temp_flat_prem numeric(11,2) not null,
    perm_flat_unit_prem numeric(7,3) not null,
    perm_flat_prem numeric(11,2) not null,
    temp_mort_dur numeric(3) not null,
    temp_mort_unit_prem numeric(7,3) not null,
    temp_mort_prem numeric(11,2) not null,
    perm_mort_unit_prem numeric(7,3) not null,
    perm_mort_prem numeric(11,2) not null,
    eti_endow numeric(13,2) not null,
    xtra_cat_cd varchar(1),
    perm_mort_ratg numeric(5),
    temp_mort_ratg numeric(5),
    cvg_del_dt timestamp,
    adj_prem numeric(11,2),
    adj_start_dt timestamp,
    adj_end_dt timestamp,
    nxt_eff_cvg_prem numeric(11,2),
    nxt_eff_dscnt_prem numeric(11,2),
    ctr_prem numeric(11,2),
    nxt_eff_ctr_prem numeric(11,2),
    prev_dth_bnft_amt numeric(13,2),
    risk_prem numeric(11,2),
    init_chg_ind varchar(1),
    adj_prem_pct numeric(3),
    joint_cli_smkr_code varchar(1),
    joint_cli_sex_code varchar(1),
    crcy_code varchar(2) default '*' not null
);

CREATE TABLE IF NOT EXISTS cas.tcmp_cvg (
    pol_num varchar(20),
    cli_num varchar(20),
    plan_code varchar(20),
    vers_num varchar(20),
    cvg_eff_dt varchar(20),
    cvg_typ varchar(20),
    cvg_reasn varchar(20),
    occp_clas varchar(20),
    par_code varchar(20),
    bnft_dur varchar(20),
    prem_dur varchar(20),
    pua_tot_amt varchar(20),
    rel_to_insrd varchar(20),
    smkr_code varchar(20),
    sex_code varchar(20),
    cvg_prem varchar(20),
    cvg_stat_cd varchar(20),
    comm_ctl varchar(20),
    comm_vers varchar(20),
    cvg_clas varchar(20),
    dscnt_pct varchar(20),
    dscnt_prem varchar(20),
    dth_bnft_amt varchar(20),
    face_amt varchar(20),
    band_face_amt varchar(20),
    face_ratg varchar(20),
    ins_typ varchar(20),
    cvg_eff_age varchar(20),
    cvg_iss_dt varchar(20),
    xpry_dt varchar(20),
    nyr_cvg_prem varchar(20),
    nyr_dscnt_prem varchar(20),
    pua_crnt_amt varchar(20),
    prem_vers varchar(20),
    pol_val_vers varchar(20),
    prem_ovrid_end_date varchar(20),
    div_crnt_amt varchar(20),
    joint_cli_num varchar(20),
    joint_rel_insrd varchar(20),
    temp_flat_dur varchar(20),
    temp_flat_unit_prem varchar(20),
    temp_flat_prem varchar(20),
    perm_flat_unit_prem varchar(20),
    perm_flat_prem varchar(20),
    temp_mort_dur varchar(20),
    temp_mort_unit_prem varchar(20),
    temp_mort_prem varchar(20),
    perm_mort_unit_prem varchar(20),
    perm_mort_prem varchar(20),
    eti_endow varchar(20),
    xtra_cat_cd varchar(20),
    perm_mort_ratg varchar(20),
    temp_mort_ratg varchar(20),
    cvg_del_dt varchar(20),
    adj_prem varchar(20),
    adj_start_dt varchar(20),
    adj_end_dt varchar(20),
    nxt_eff_cvg_prem varchar(20),
    nxt_eff_dscnt_prem varchar(20),
    ctr_prem varchar(20),
    nxt_eff_ctr_prem varchar(20),
    prev_dth_bnft_amt varchar(20),
    risk_prem varchar(20),
    init_chg_ind varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.tcollections (
    id numeric(10) not null,
    dist_chnl_cd varchar(2) default 'AG' not null,
    bank_cd varchar(6),
    crncy_cd varchar(2) default '14' not null,
    coll_dt timestamp not null,
    deposit_dt timestamp,
    misc_payor_nm varchar(60),
    adv_comm_amt numeric(12,2),
    remarks varchar(60),
    off_loc_cd varchar(5) not null,
    delete_ind varchar(1) default 'N' not null,
    created_by varchar(10) not null,
    date_created timestamp not null,
    date_modified timestamp,
    modified_by varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tcoll_dtls_hist_sg (
    crcy_code varchar(2) not null,
    trxn_num numeric(10) not null,
    town_nm varchar(30),
    state_nm varchar(20),
    chq_num varchar(20),
    chq_amt numeric(12,2),
    trxn_amt numeric(11,2),
    bank_nm varchar(20),
    coll_typ varchar(20),
    created_by varchar(6),
    date_created timestamp,
    amended_by varchar(6),
    date_amended timestamp
);

CREATE TABLE IF NOT EXISTS cas.tcoll_hdr_hist_sg (
    crcy_code varchar(2) not null,
    pol_num varchar(10),
    batch_num varchar(10),
    trxn_num numeric(10) not null,
    trxn_ind varchar(1),
    rcpt_prt_dt timestamp,
    rcpt_num numeric(10),
    autopost varchar(20),
    coll_rcv_dt timestamp,
    coll_rcv_time varchar(8),
    trxn_amt numeric(11,2),
    coll_amt numeric(11,2),
    remarks varchar(30),
    sup_trxn_ind varchar(1),
    trxn_typ varchar(20),
    notice_cd varchar(2),
    notice_prt_ind varchar(1),
    trxn_stat varchar(20),
    proc_cycle varchar(10),
    prod_cycle varchar(10),
    ptd_before timestamp,
    force_proc_ind varchar(1),
    ini_proc_cycle varchar(10),
    rcpt_cd varchar(1),
    srv_ctr varchar(4),
    coll_cd varchar(20),
    bank_in_ind varchar(1),
    auto_prem_dscnt varchar(1),
    created_by varchar(6),
    date_created timestamp,
    amended_by varchar(6),
    date_amended timestamp
);

CREATE TABLE IF NOT EXISTS cas.tcoll_postings_hist_sg (
    crcy_code varchar(2) not null,
    trxn_num numeric(10) not null,
    item_cd varchar(4) not null,
    item_desc varchar(30),
    item_amt numeric(10,2),
    cr_or_dr varchar(1) not null,
    int_dt timestamp,
    proc_msg varchar(50),
    created_by varchar(6),
    date_created timestamp,
    amended_by varchar(6),
    date_amended timestamp
);

CREATE TABLE IF NOT EXISTS cas.tcoll_prem_postings_hist_sg (
    crcy_code varchar(2) not null,
    trxn_typ varchar(20) not null,
    trxn_num numeric(10) not null,
    plan_num numeric(2) not null,
    plan_code varchar(6),
    plan_name varchar(40),
    cvg_eff_dt timestamp,
    prem_applied numeric(10,2),
    ptd_before timestamp,
    ptd_after timestamp,
    created_by varchar(6),
    date_created timestamp,
    amended_by varchar(6),
    date_amended timestamp
);

CREATE TABLE IF NOT EXISTS cas.tcommission_rates (
    plan_code varchar(5) not null,
    comm_vers varchar(2) not null,
    crcy_code varchar(2) not null,
    fr_dur numeric(3) not null,
    to_dur numeric(3) not null,
    age_low numeric(3) not null,
    age_high numeric(3) not null,
    band_low numeric(13,2) not null,
    band_high numeric(13,2) not null,
    comm_fr_yr numeric(3) not null,
    comm_to_yr numeric(3) not null,
    comm_rt_ann numeric(5,2) not null,
    comm_rt_mo numeric(5,2) not null,
    comm_rt_qtr numeric(5,2) not null,
    comm_rt_semi numeric(5,2) not null,
    comm_rt_orph_ann numeric(5,2) not null,
    comm_rt_orph_mo numeric(5,2) not null,
    comm_rt_orph_qtr numeric(5,2) not null,
    comm_rt_orph_semi numeric(5,2) not null,
    dist_chnl_cd varchar(2) not null,
    add_rt_factor_fr numeric(13,2) not null,
    add_rt_factor_to numeric(13,2) not null,
    comm_typ varchar(5) not null,
    to_bnft_dur numeric(3) default -1 not null,
    fr_bnft_dur numeric(3) default -1 not null,
    anp_band_low numeric(13,2) not null,
    anp_band_high numeric(13,2) not null,
    pc_rt_ann numeric(8,5),
    pc_rt_mo numeric(8,5),
    pc_rt_qtr numeric(8,5),
    pc_rt_semi numeric(8,5),
    pc_rt_orph_ann numeric(8,5),
    pc_rt_orph_mo numeric(8,5),
    pc_rt_orph_qtr numeric(8,5),
    pc_rt_orph_semi numeric(8,5)
);

CREATE TABLE IF NOT EXISTS cas.tcommission_rates_layout (
    plan_code_pos numeric(3),
    plan_code_len numeric(3),
    comm_vers_pos numeric(3),
    comm_vers_len numeric(3),
    crcy_code_pos numeric(3),
    crcy_code_len numeric(3),
    fr_dur_pos numeric(3),
    fr_dur_len numeric(3),
    to_dur_pos numeric(3),
    to_dur_len numeric(3),
    age_low_pos numeric(3),
    age_low_len numeric(3),
    age_high_pos numeric(3),
    age_high_len numeric(3),
    band_low_pos numeric(3),
    band_low_len numeric(3),
    band_high_pos numeric(3),
    band_high_len numeric(3),
    comm_fr_yr_pos numeric(3),
    comm_fr_yr_len numeric(3),
    comm_to_yr_pos numeric(3),
    comm_to_yr_len numeric(3),
    comm_rt_ann_pos numeric(3),
    comm_rt_ann_len numeric(3),
    comm_rt_mo_pos numeric(3),
    comm_rt_mo_len numeric(3),
    comm_rt_qtr_pos numeric(3),
    comm_rt_qtr_len numeric(3),
    comm_rt_semi_pos numeric(3),
    comm_rt_semi_len numeric(3),
    comm_rt_orph_ann_pos numeric(3),
    comm_rt_orph_ann_len numeric(3),
    comm_rt_orph_mo_pos numeric(3),
    comm_rt_orph_mo_len numeric(3),
    comm_rt_orph_qtr_pos numeric(3),
    comm_rt_orph_qtr_len numeric(3),
    comm_rt_orph_semi_pos numeric(3),
    comm_rt_orph_semi_len numeric(3),
    dist_chnl_cd_pos numeric(3),
    dist_chnl_cd_len numeric(3),
    comm_typ_len numeric(3),
    comm_typ_pos numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tcommission_rates_load (
    plan_code varchar(5),
    comm_vers varchar(2),
    crcy_code varchar(2),
    fr_dur numeric(3),
    to_dur numeric(3),
    age_low numeric(3),
    age_high numeric(3),
    band_low numeric(13,2),
    band_high numeric(13,2),
    comm_fr_yr numeric(3),
    comm_to_yr numeric(3),
    comm_rt_ann numeric(5,2),
    comm_rt_mo numeric(5,2),
    comm_rt_qtr numeric(5,2),
    comm_rt_semi numeric(5,2),
    comm_rt_orph_ann numeric(5,2),
    comm_rt_orph_mo numeric(5,2),
    comm_rt_orph_qtr numeric(5,2),
    comm_rt_orph_semi numeric(5,2),
    dist_chnl_cd varchar(2),
    add_rt_factor_fr numeric(13,2),
    add_rt_factor_to numeric(13,2),
    comm_typ varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.tcoverages (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    cvg_typ varchar(1) not null,
    cvg_reasn varchar(1) not null,
    occp_clas varchar(1) not null,
    par_code varchar(1) not null,
    bnft_dur numeric(3) not null,
    prem_dur numeric(3) not null,
    pua_tot_amt numeric(13,2) not null,
    rel_to_insrd varchar(2) not null,
    smkr_code varchar(1) not null,
    sex_code varchar(1) not null,
    cvg_prem numeric(11,2) not null,
    cvg_stat_cd varchar(1) not null,
    comm_ctl varchar(1) not null,
    comm_vers varchar(2) not null,
    cvg_clas varchar(3) not null,
    dscnt_pct numeric(5,2) not null,
    dscnt_prem numeric(11,2) not null,
    dth_bnft_amt numeric(13,2) not null,
    face_amt numeric(13,2) not null,
    band_face_amt numeric(13,2) not null,
    face_ratg numeric(5,2) not null,
    ins_typ varchar(1) not null,
    cvg_eff_age numeric(3) not null,
    cvg_iss_dt timestamp,
    xpry_dt timestamp not null,
    nyr_cvg_prem numeric(11,2) default 0 not null,
    nyr_dscnt_prem numeric(11,2) default 0 not null,
    pua_crnt_amt numeric(13,2) not null,
    prem_vers varchar(2) not null,
    pol_val_vers varchar(2) not null,
    prem_ovrid_end_date timestamp,
    div_crnt_amt numeric(11,2) not null,
    joint_cli_num varchar(13),
    joint_rel_insrd varchar(2),
    temp_flat_dur numeric(3) default 0 not null,
    temp_flat_unit_prem numeric(10,3) default 0 not null,
    temp_flat_prem numeric(11,2) default 0 not null,
    perm_flat_unit_prem numeric(10,3) default 0 not null,
    perm_flat_prem numeric(11,2) default 0 not null,
    temp_mort_dur numeric(3) default 0 not null,
    temp_mort_unit_prem numeric(10,3) default 0 not null,
    temp_mort_prem numeric(11,2) default 0 not null,
    perm_mort_unit_prem numeric(10,3) default 0 not null,
    perm_mort_prem numeric(11,2) default 0 not null,
    eti_endow numeric(13,2) default 0 not null,
    xtra_cat_cd varchar(1),
    perm_mort_ratg numeric(5),
    temp_mort_ratg numeric(5),
    cvg_del_dt timestamp,
    adj_prem numeric(11,2),
    adj_start_dt timestamp,
    adj_end_dt timestamp,
    nxt_eff_cvg_prem numeric(11,2),
    nxt_eff_dscnt_prem numeric(11,2),
    ctr_prem numeric(11,2),
    nxt_eff_ctr_prem numeric(11,2),
    prev_dth_bnft_amt numeric(13,2),
    risk_prem numeric(11,2),
    init_chg_ind varchar(2),
    cntr_price numeric(13,2),
    adj_prem_pct numeric(3),
    int_rt numeric(5,3),
    nyr_wp_prem numeric(11,2),
    wp_eff_age numeric(3),
    wp_eff_dt timestamp,
    wp_option varchar(1),
    wp_prem numeric(11,2),
    wp_prem_age_basis varchar(1),
    wp_prem_vers varchar(2),
    orig_face_amt numeric(13,2),
    orig_death_bnft numeric(13,2),
    orig_pua_amt numeric(13,2),
    joint_cli_eff_age numeric(3),
    substd_cd varchar(3),
    joint_cli_smkr_code varchar(1),
    joint_cli_sex_code varchar(1),
    cvg_del_reasn varchar(1),
    endow_acru numeric(13,2),
    nb_seq numeric(5),
    no_of_insrd numeric(2),
    rcc_ind varchar(1),
    face_ratg_start_dt timestamp,
    face_ratg_end_dt timestamp,
    lien_pct numeric(5,2),
    pkg_plan_code varchar(5),
    nc_face_ratg numeric(5,2) default 0 not null,
    nc_temp_flat_unit_prem numeric(10,3) default 0 not null,
    nc_perm_flat_unit_prem numeric(10,3) default 0 not null,
    nc_prem numeric(13,2) default 0 not null,
    nyr_nc_prem numeric(13,2) default 0 not null,
    wp_nc_prem numeric(13,2),
    eff_age_ovrid varchar(1),
    wp_plan_code varchar(5),
    wp_vers_num varchar(2),
    face_ratg_prem numeric(11,2),
    perm_prem_ovrid_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tlayers (
    pol_num varchar(10) not null,
    layer_eff_dt timestamp not null,
    layer_typ varchar(1) not null,
    layer_stat_cd varchar(1),
    mpre numeric(11,2),
    xces_prem numeric(11,2),
    layer_trmn_dt timestamp,
    tot_prem_pd numeric(11,2),
    mpre_pd numeric(11,2),
    last_ryc_dt timestamp,
    mpre_rc_ind varchar(1),
    layer_prem_amt numeric(11,2),
    hwm_ann numeric(11,2),
    hwm_ann_xpry_dt timestamp,
    pd_to_dt timestamp,
    partial_pay_amt numeric(11,2),
    layer_prem_pct numeric(5,2),
    surr_chrg_pd numeric(13,2),
    asof_tot_prem_pd numeric(11,2),
    orig_mpre numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tcoverage_layers (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    layer_eff_dt timestamp not null,
    stat_cd varchar(1),
    layer_prem numeric(11,2),
    layer_dscnt_prem numeric(11,2),
    mpre numeric(11,2),
    old_face_amt numeric(13,2),
    new_face_amt numeric(13,2),
    old_cvg_clas varchar(3),
    new_cvg_clas varchar(3),
    wp_fa numeric(11,2),
    wp_prem numeric(11,2),
    wp_mpre numeric(11,2),
    cvg_lay_typ varchar(5) not null,
    old_prem_vers varchar(2),
    new_prem_vers varchar(2),
    occp_clas varchar(1),
    bnft_dur numeric(3),
    prem_dur numeric(3),
    pua_tot_amt numeric(13,2),
    smkr_code varchar(1),
    dth_bnft_amt numeric(13,2),
    band_face_amt numeric(13,2),
    face_ratg numeric(5,2),
    layer_eff_age numeric(3),
    nyr_layer_prem numeric(11,2),
    nyr_layer_dscnt_prem numeric(11,2),
    pua_crnt_amt numeric(13,2),
    div_crnt_amt numeric(11,2),
    temp_flat_dur numeric(3),
    temp_flat_unit_prem numeric(10,3),
    temp_flat_prem numeric(11,2),
    perm_flat_unit_prem numeric(10,3),
    perm_flat_prem numeric(11,2),
    temp_mort_dur numeric(3),
    temp_mort_unit_prem numeric(10,3),
    temp_mort_prem numeric(11,2),
    perm_mort_unit_prem numeric(10,3),
    perm_mort_prem numeric(11,2),
    eti_endow numeric(13,2),
    xtra_cat_cd varchar(1),
    perm_mort_ratg numeric(5),
    temp_mort_ratg numeric(5),
    adj_prem numeric(11,2),
    adj_start_dt timestamp,
    adj_end_dt timestamp,
    nxt_eff_cvg_prem numeric(11,2),
    nxt_eff_dscnt_prem numeric(11,2),
    risk_prem numeric(11,2),
    prev_dth_bnft_amt numeric(13,2),
    endow_acru numeric(13,2),
    adj_prem_pct numeric(3),
    nyr_wp_prem numeric(11,2),
    wp_eff_age numeric(3),
    wp_eff_dt timestamp,
    joint_cli_eff_age numeric(3),
    substd_cd varchar(3),
    excl_code1 varchar(5),
    excl_code2 varchar(5),
    excl_code3 varchar(5),
    excl_end_dt timestamp,
    excl_clause varchar(200),
    xfer_rider varchar(1),
    cvg_del_reasn varchar(1),
    layer_typ varchar(1) not null,
    face_ratg_start_dt timestamp,
    face_ratg_end_dt timestamp,
    lien_pct numeric(5,2),
    nc_face_ratg numeric(5,2) default 0 not null,
    nc_temp_flat_unit_prem numeric(10,3) default 0 not null,
    nc_perm_flat_unit_prem numeric(10,3) default 0 not null,
    nc_prem numeric(13,2) default 0 not null,
    nyr_nc_prem numeric(13,2) default 0 not null,
    wp_nc_prem numeric(13,2),
    face_ratg_prem numeric(11,2),
    temp_flat_ratg numeric(5,2),
    perm_flat_ratg numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.tcommission_trailers (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    agt_code varchar(6) not null,
    comm_dt timestamp not null,
    comm_stat_cd varchar(1) not null,
    pct_splt numeric(3) not null,
    comm_earn numeric(11,2) not null,
    pc_chrg_bck numeric(9) not null,
    pc_earn numeric(9) not null,
    comm_rest_dur numeric(3),
    comm_rest_ind varchar(1) default 'N' not null,
    comm_rest_rt numeric(5,2),
    orph_asign_ind varchar(1) default 'N' not null,
    fa_ratio numeric(7,5),
    pc_chrg_bck_2nd numeric(9),
    comm_earn_1st numeric(13,2),
    comm_earn_csh numeric(9,2),
    comm_earn_mvy numeric(9,2),
    comm_earn_serv numeric(9,2),
    cvg_lay_typ varchar(5) not null,
    layer_eff_dt timestamp not null,
    layer_typ varchar(1) not null,
    mvy_cp_pc_chrg_bck numeric(9),
    pc_chrg_bck_ep numeric(9),
    pc_chrg_bck_ep_2nd numeric(9),
    pc_earn_ep numeric(9),
    pc_pct_splt numeric(3),
    pc_stat_cd varchar(5),
    pc_base numeric(9),
    last_pc_gen_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tcommission_trailers_bf_re (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    agt_code varchar(6) not null,
    comm_dt timestamp not null,
    comm_stat_cd varchar(1) not null,
    pct_splt numeric(3) not null,
    comm_earn numeric(11,2) not null,
    pc_chrg_bck numeric(9) not null,
    pc_earn numeric(9) not null,
    comm_rest_dur numeric(3),
    comm_rest_ind varchar(1) not null,
    comm_rest_rt numeric(5,2),
    orph_asign_ind varchar(1) not null,
    fa_ratio numeric(7,5),
    pc_chrg_bck_2nd numeric(9),
    comm_earn_1st numeric(13,2),
    comm_earn_csh numeric(9,2),
    comm_earn_mvy numeric(9,2),
    comm_earn_serv numeric(9,2),
    cvg_lay_typ varchar(5) not null,
    layer_eff_dt timestamp not null,
    layer_typ varchar(1) not null,
    mvy_cp_pc_chrg_bck numeric(9),
    pc_chrg_bck_ep numeric(9),
    pc_chrg_bck_ep_2nd numeric(9),
    pc_earn_ep numeric(9),
    pc_pct_splt numeric(3),
    pc_stat_cd varchar(5),
    pc_base numeric(9)
);

CREATE TABLE IF NOT EXISTS cas.tcomm_acct_mappings (
    comm_typ varchar(5) not null,
    sngl_prem_ind varchar(1) not null,
    comm_fr_yr numeric(3) not null,
    comm_to_yr numeric(3) not null,
    cr_or_dr varchar(1) not null,
    acct_mne_cd varchar(8)
);

CREATE TABLE IF NOT EXISTS cas.tcomm_hist_sg (
    crcy_code varchar(2) not null,
    pol_num varchar(10) not null,
    trxn_num numeric(8) not null,
    agt_id_typ varchar(1),
    agt_id_num varchar(13),
    agt_nm varchar(32),
    agt_num varchar(6),
    um_id_typ varchar(1),
    um_id_num varchar(13),
    um_nm varchar(32),
    am_id_typ varchar(1),
    am_id_num varchar(13),
    am_nm varchar(32),
    da_id_typ varchar(1),
    da_id_num varchar(13),
    da_nm varchar(32),
    prod_line varchar(10),
    plan_num numeric(2),
    plan_code varchar(6),
    plan_name varchar(40),
    cvg_eff_dt timestamp,
    prem_dur numeric(2),
    par_code varchar(7),
    trxn_prd_cyc varchar(10),
    trxn_fin_cyc varchar(10),
    comm_typ varchar(15),
    trxn_typ varchar(40),
    comm_status varchar(10),
    trxn_status varchar(30),
    ptd_before timestamp,
    ptd_after timestamp,
    plan_year numeric(3),
    prem_amt numeric(10,2),
    comm_amt numeric(10,2),
    shared_comm_amt numeric(10,2),
    comm_amt_pd numeric(10,2),
    comm_ovrid_mthd varchar(7),
    comm_ovrid_amt numeric(10,2),
    shared_case varchar(1),
    prt_on_stmt varchar(1),
    taxable_item varchar(1),
    created_by varchar(6),
    date_created timestamp,
    amended_by varchar(6),
    date_amended timestamp
);

CREATE TABLE IF NOT EXISTS cas.tcomm_overrides (
    pol_num varchar(10) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    cli_num varchar(13) not null,
    agt_code varchar(6) not null,
    override_rates numeric(5,2) not null,
    override_yr_from numeric(3) not null,
    override_yr_to numeric(3) not null,
    comp_typ varchar(5) not null,
    cvg_lay_typ varchar(5) not null,
    layer_eff_dt timestamp not null,
    layer_typ varchar(5) not null
);

CREATE TABLE IF NOT EXISTS cas.tcomm_recon_sg (
    pol_num varchar(10) not null,
    trxn_dt timestamp,
    aex_num numeric(8),
    trxn_cd varchar(8),
    acct_mne_cd varchar(8),
    cr_or_dr varchar(1),
    acct_gen_amt numeric(13,2),
    reasn_code varchar(3),
    eff_dt timestamp,
    crcy_code varchar(2),
    acct_num varchar(8),
    plan_code varchar(8),
    prod_code varchar(8),
    crr_num numeric(15),
    crr_reasn_code varchar(3),
    crr_prem_amt numeric(13,2),
    crr_comm_amt numeric(13,2),
    crr_colct_dt timestamp,
    crr_plan_code varchar(8),
    crr_prod_code varchar(8),
    crr_trxn_dt timestamp,
    crr_crcy_cd varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tcontest02 (
    br_code varchar(5),
    br_mgr_cd varchar(5),
    un_code varchar(5),
    un_mgr_cd varchar(5),
    agt_code varchar(5),
    agt_name varchar(20),
    agt_stat_cd varchar(2),
    mkt_case numeric(5,1),
    comm_earn numeric(9,2)
);

CREATE TABLE IF NOT EXISTS cas.tcontrol_parameters (
    terr_cd varchar(2) not null,
    state_cd varchar(2) not null,
    parm_typ varchar(30) not null,
    parm_valu varchar(60) not null,
    rec_status varchar(1) not null,
    parm_desc varchar(50),
    glob_ind varchar(1),
    data_typ varchar(10),
    app_cd varchar(3),
    crcy_code varchar(2) not null
);

CREATE TABLE IF NOT EXISTS cas.tcoverages_bf_re (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    cvg_typ varchar(1) not null,
    cvg_reasn varchar(1) not null,
    occp_clas varchar(1) not null,
    par_code varchar(1) not null,
    bnft_dur numeric(3) not null,
    prem_dur numeric(3) not null,
    pua_tot_amt numeric(13,2) not null,
    rel_to_insrd varchar(2) not null,
    smkr_code varchar(1) not null,
    sex_code varchar(1) not null,
    cvg_prem numeric(11,2) not null,
    cvg_stat_cd varchar(1) not null,
    comm_ctl varchar(1) not null,
    comm_vers varchar(2) not null,
    cvg_clas varchar(3) not null,
    dscnt_pct numeric(5,2) not null,
    dscnt_prem numeric(11,2) not null,
    dth_bnft_amt numeric(13,2) not null,
    face_amt numeric(13,2) not null,
    band_face_amt numeric(13,2) not null,
    face_ratg numeric(5,2) not null,
    ins_typ varchar(1) not null,
    cvg_eff_age numeric(3) not null,
    cvg_iss_dt timestamp,
    xpry_dt timestamp not null,
    nyr_cvg_prem numeric(11,2) not null,
    nyr_dscnt_prem numeric(11,2) not null,
    pua_crnt_amt numeric(13,2) not null,
    prem_vers varchar(2) not null,
    pol_val_vers varchar(2) not null,
    prem_ovrid_end_date timestamp,
    div_crnt_amt numeric(11,2) not null,
    joint_cli_num varchar(13),
    joint_rel_insrd varchar(2),
    temp_flat_dur numeric(3) not null,
    temp_flat_unit_prem numeric(10,3) not null,
    temp_flat_prem numeric(11,2) not null,
    perm_flat_unit_prem numeric(10,3) not null,
    perm_flat_prem numeric(11,2) not null,
    temp_mort_dur numeric(3) not null,
    temp_mort_unit_prem numeric(10,3) not null,
    temp_mort_prem numeric(11,2) not null,
    perm_mort_unit_prem numeric(10,3) not null,
    perm_mort_prem numeric(11,2) not null,
    eti_endow numeric(13,2) not null,
    xtra_cat_cd varchar(1),
    perm_mort_ratg numeric(5),
    temp_mort_ratg numeric(5),
    cvg_del_dt timestamp,
    adj_prem numeric(11,2),
    adj_start_dt timestamp,
    adj_end_dt timestamp,
    nxt_eff_cvg_prem numeric(11,2),
    nxt_eff_dscnt_prem numeric(11,2),
    ctr_prem numeric(11,2),
    nxt_eff_ctr_prem numeric(11,2),
    prev_dth_bnft_amt numeric(13,2),
    risk_prem numeric(11,2),
    init_chg_ind varchar(2),
    cntr_price numeric(13,2),
    adj_prem_pct numeric(3),
    int_rt numeric(5,3),
    nyr_wp_prem numeric(11,2),
    wp_eff_age numeric(3),
    wp_eff_dt timestamp,
    wp_option varchar(1),
    wp_prem numeric(11,2),
    wp_prem_age_basis varchar(1),
    wp_prem_vers varchar(2),
    orig_face_amt numeric(13,2),
    orig_death_bnft numeric(13,2),
    orig_pua_amt numeric(13,2),
    joint_cli_eff_age numeric(3),
    substd_cd varchar(3),
    joint_cli_smkr_code varchar(1),
    joint_cli_sex_code varchar(1),
    cvg_del_reasn varchar(1),
    endow_acru numeric(13,2),
    nb_seq numeric(5),
    no_of_insrd numeric(2),
    rcc_ind varchar(1),
    face_ratg_start_dt timestamp,
    face_ratg_end_dt timestamp,
    lien_pct numeric(5,2),
    pkg_plan_code varchar(5),
    nc_face_ratg numeric(5,2) not null,
    nc_temp_flat_unit_prem numeric(10,3) not null,
    nc_perm_flat_unit_prem numeric(10,3) not null,
    nc_prem numeric(13,2) not null,
    nyr_nc_prem numeric(13,2) not null,
    wp_nc_prem numeric(13,2),
    eff_age_ovrid varchar(1),
    wp_plan_code varchar(5),
    wp_vers_num varchar(2),
    face_ratg_prem numeric(11,2),
    perm_prem_ovrid_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tcoverages_info_th (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    xtra_typ_page3 varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tcoverage_accumulators (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    cvg_dur numeric(3) not null,
    tot_prem_pd numeric(13,2),
    mode_prem_pd numeric(13,2),
    dump_in numeric(13,2),
    load_amt numeric(13,2),
    init_chrg numeric(13,2),
    comm_earn numeric(13,2),
    comm_earn_csh numeric(13,2),
    layer_eff_dt timestamp not null,
    comm_typ varchar(1) not null,
    cvg_lay_typ varchar(5) not null,
    cvg_fee_pd numeric(13,2),
    prem_chrg numeric(13,2),
    layer_typ varchar(1) not null,
    tot_prem_pd_wo_xtra numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tcoverage_extra_prems (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    extra_prem_typ varchar(1) not null,
    med_grd varchar(2),
    extra_rt numeric(6,2),
    client_rt numeric(6,2),
    extra_rt_dur numeric(2),
    strt_eff_cvg_yr numeric(2),
    date_created timestamp,
    date_amended timestamp
);

CREATE TABLE IF NOT EXISTS cas.tcoverage_layers_bf_re (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    layer_eff_dt timestamp not null,
    stat_cd varchar(1),
    layer_prem numeric(11,2),
    layer_dscnt_prem numeric(11,2),
    mpre numeric(11,2),
    old_face_amt numeric(13,2),
    new_face_amt numeric(13,2),
    old_cvg_clas varchar(3),
    new_cvg_clas varchar(3),
    wp_fa numeric(11,2),
    wp_prem numeric(11,2),
    wp_mpre numeric(11,2),
    cvg_lay_typ varchar(5) not null,
    old_prem_vers varchar(2),
    new_prem_vers varchar(2),
    occp_clas varchar(1),
    bnft_dur numeric(3),
    prem_dur numeric(3),
    pua_tot_amt numeric(13,2),
    smkr_code varchar(1),
    dth_bnft_amt numeric(13,2),
    band_face_amt numeric(13,2),
    face_ratg numeric(5,2),
    layer_eff_age numeric(3),
    nyr_layer_prem numeric(11,2),
    nyr_layer_dscnt_prem numeric(11,2),
    pua_crnt_amt numeric(13,2),
    div_crnt_amt numeric(11,2),
    temp_flat_dur numeric(3),
    temp_flat_unit_prem numeric(10,3),
    temp_flat_prem numeric(11,2),
    perm_flat_unit_prem numeric(10,3),
    perm_flat_prem numeric(11,2),
    temp_mort_dur numeric(3),
    temp_mort_unit_prem numeric(10,3),
    temp_mort_prem numeric(11,2),
    perm_mort_unit_prem numeric(10,3),
    perm_mort_prem numeric(11,2),
    eti_endow numeric(13,2),
    xtra_cat_cd varchar(1),
    perm_mort_ratg numeric(5),
    temp_mort_ratg numeric(5),
    adj_prem numeric(11,2),
    adj_start_dt timestamp,
    adj_end_dt timestamp,
    nxt_eff_cvg_prem numeric(11,2),
    nxt_eff_dscnt_prem numeric(11,2),
    risk_prem numeric(11,2),
    prev_dth_bnft_amt numeric(13,2),
    endow_acru numeric(13,2),
    adj_prem_pct numeric(3),
    nyr_wp_prem numeric(11,2),
    wp_eff_age numeric(3),
    wp_eff_dt timestamp,
    joint_cli_eff_age numeric(3),
    substd_cd varchar(3),
    excl_code1 varchar(5),
    excl_code2 varchar(5),
    excl_code3 varchar(5),
    excl_end_dt timestamp,
    excl_clause varchar(200),
    xfer_rider varchar(1),
    cvg_del_reasn varchar(1),
    layer_typ varchar(1) not null,
    face_ratg_start_dt timestamp,
    face_ratg_end_dt timestamp,
    lien_pct numeric(5,2),
    nc_face_ratg numeric(5,2) not null,
    nc_temp_flat_unit_prem numeric(10,3) not null,
    nc_perm_flat_unit_prem numeric(10,3) not null,
    nc_prem numeric(13,2) not null,
    nyr_nc_prem numeric(13,2) not null,
    wp_nc_prem numeric(13,2),
    face_ratg_prem numeric(11,2),
    temp_flat_ratg numeric(5,2),
    perm_flat_ratg numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.tcoverage_layer_comp_mapping (
    comm_ctl varchar(1) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    layer_typ varchar(5) not null,
    cvg_lay_typ varchar(5) not null,
    comp_typ varchar(5) not null,
    comm_pc_ind varchar(1) not null,
    add_rt_factor_ind varchar(1) not null,
    add_rt_factor numeric(13,2),
    min_pc_rel_case numeric(9) not null,
    cu_months numeric(2) not null,
    cb_months numeric(2) not null
);

CREATE TABLE IF NOT EXISTS cas.tcoverage_layer_comp_mappings (
    comm_ctl varchar(1) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    layer_typ varchar(5) not null,
    cvg_lay_typ varchar(5) not null,
    comp_typ varchar(5) not null,
    comm_pc_ind varchar(1) not null,
    add_rt_factor_ind varchar(1) not null,
    add_rt_factor numeric(13,2),
    min_pc_rel_case numeric(9) not null,
    cu_months numeric(2) not null,
    cb_months numeric(2) not null,
    crcy_code varchar(2) default '*' not null
);

CREATE TABLE IF NOT EXISTS cas.tcoverage_log (
    pol_num varchar(10) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    cvg_iss_dt timestamp,
    xpry_dt timestamp not null,
    cvg_typ varchar(1) not null,
    cvg_prem numeric(11,2) not null,
    dscnt_prem numeric(11,2) not null,
    dth_bnft_amt numeric(13,2) not null,
    face_amt numeric(13,2) not null,
    cvg_eff_age numeric(3) not null,
    crt_date timestamp not null,
    exp_date timestamp
);

CREATE TABLE IF NOT EXISTS cas.tcoverage_oth_insrds (
    pol_num varchar(10),
    plan_code varchar(5),
    vers_num varchar(2),
    cli_num varchar(13),
    cvg_eff_dt timestamp,
    oth_cli_num varchar(13)
);

CREATE TABLE IF NOT EXISTS cas.tcoverage_premiums (
    plan_code varchar(5) not null,
    prem_vers varchar(2) not null,
    crcy_code varchar(2) not null,
    sex_code varchar(1) not null,
    smkr_code varchar(1) not null,
    cvg_clas varchar(3) not null,
    band_low numeric(13,2) not null,
    band_high numeric(13,2) not null,
    eff_fr_dt timestamp not null,
    occp_clas varchar(1) not null,
    eff_age numeric(3) not null,
    prem_per_unit numeric(13,6) not null,
    unit_basis varchar(1) not null,
    eff_to_dt timestamp,
    prem_prd numeric(3) not null,
    band_percnt numeric(3),
    sec_rating_age numeric(3) default -1 not null,
    int_rt numeric(5,3) not null,
    dist_chnl_cd varchar(2) not null,
    fr_dur numeric(3) default -1 not null,
    to_dur numeric(3) default -1 not null,
    sec_sex_code varchar(1) default '*' not null,
    rcc_ind varchar(1) not null,
    no_of_insrd numeric(2) not null,
    rt_typ varchar(1) not null,
    to_bnft_prd numeric(3) default '-1' not null,
    fr_bnft_prd numeric(3) default '-1' not null
);

CREATE TABLE IF NOT EXISTS cas.tcoverage_premiums_adj (
    plan_code varchar(5) not null,
    crcy_code varchar(2) not null,
    prem_vers varchar(2) not null,
    sex_code varchar(1) not null,
    band_low numeric(13,2) not null,
    band_high numeric(13,2) not null,
    eff_age_fr numeric(3) not null,
    eff_age_to numeric(3) not null,
    smkr_code varchar(1) not null,
    occp_clas varchar(1) not null,
    oper varchar(1),
    prem_per_unit numeric(13,3),
    unit_basis varchar(1),
    prem_disc numeric(5,2) not null
);

CREATE TABLE IF NOT EXISTS cas.tcoverage_premiums_jhfix (
    plan_code varchar(6),
    si numeric(9),
    iss_age numeric(2),
    ann_prem_rate numeric(6,2),
    mon_prem_rate numeric(6,2),
    qutr_prem_rate numeric(6,2),
    half_yr_prem_rate numeric(6,2),
    file_nm varchar(20),
    cas_plan_code varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.tcoverage_premiums_layout (
    plan_code_pos numeric(3),
    plan_code_len numeric(3),
    prem_vers_pos numeric(3),
    prem_vers_len numeric(3),
    crcy_code_pos numeric(3),
    crcy_code_len numeric(3),
    sex_code_pos numeric(3),
    sex_code_len numeric(3),
    smkr_code_pos numeric(3),
    smkr_code_len numeric(3),
    cvg_clas_pos numeric(3),
    cvg_clas_len numeric(3),
    band_low_pos numeric(3),
    band_low_len numeric(3),
    band_high_pos numeric(3),
    band_high_len numeric(3),
    eff_fr_dt_pos numeric(3),
    eff_fr_dt_len numeric(3),
    occp_clas_pos numeric(3),
    occp_clas_len numeric(3),
    eff_age_pos numeric(3),
    eff_age_len numeric(3),
    prem_per_unit_pos numeric(3),
    prem_per_unit_len numeric(3),
    unit_basis_pos numeric(3),
    unit_basis_len numeric(3),
    eff_to_dt_pos numeric(3),
    eff_to_dt_len numeric(3),
    prem_prd_pos numeric(3),
    prem_prd_len numeric(3),
    band_percnt_pos numeric(3),
    band_percnt_len numeric(3),
    sec_rating_age_pos numeric(3),
    sec_rating_age_len numeric(3),
    dist_chnl_cd_len numeric(3),
    dist_chnl_cd_pos numeric(3),
    fr_dur_len numeric(3),
    fr_dur_pos numeric(3),
    int_rt_len numeric(3),
    int_rt_pos numeric(3),
    no_of_insrd_len numeric(3),
    no_of_insrd_pos numeric(3),
    rcc_ind_len numeric(3),
    rcc_ind_pos numeric(3),
    rt_typ_len numeric(3),
    rt_typ_pos numeric(3),
    sec_sex_code_len numeric(3),
    sec_sex_code_pos numeric(3),
    to_dur_len numeric(3),
    to_dur_pos numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tcoverage_premiums_load (
    plan_code varchar(5),
    prem_vers varchar(2),
    crcy_code varchar(2),
    sex_code varchar(1),
    smkr_code varchar(1),
    cvg_clas varchar(3),
    band_low numeric(13,2),
    band_high numeric(13,2),
    eff_fr_dt timestamp,
    occp_clas varchar(1),
    eff_age numeric(3),
    prem_per_unit numeric(10,3),
    unit_basis varchar(1),
    eff_to_dt timestamp,
    prem_prd numeric(3),
    band_percnt numeric(3),
    sec_rating_age numeric(3),
    int_rt numeric(5,3),
    dist_chnl_cd varchar(2),
    fr_dur numeric(3),
    to_dur numeric(3),
    sec_sex_code varchar(1),
    rcc_ind varchar(1),
    no_of_insrd numeric(2),
    rt_typ varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tcoverage_premiums_mrti (
    plan_code varchar(5) not null,
    prem_vers varchar(2) not null,
    crcy_code varchar(2) not null,
    sex_code varchar(1) not null,
    smkr_code varchar(1) not null,
    cvg_clas varchar(3) not null,
    band_low numeric(13,2) not null,
    band_high numeric(13,2) not null,
    eff_fr_dt timestamp not null,
    occp_clas varchar(1) not null,
    eff_age numeric(3) not null,
    prem_per_unit numeric(13,6) not null,
    unit_basis varchar(1) not null,
    eff_to_dt timestamp,
    prem_prd numeric(3) not null,
    band_percnt numeric(3),
    sec_rating_age numeric(3) not null,
    int_rt numeric(5,3) not null,
    dist_chnl_cd varchar(2) not null,
    fr_dur numeric(3) not null,
    to_dur numeric(3) not null,
    sec_sex_code varchar(1) not null,
    rcc_ind varchar(1),
    no_of_insrd numeric(2) not null,
    rt_typ varchar(1) not null,
    fr_bnft_prd numeric(3) not null,
    to_bnft_prd numeric(3) not null
);

CREATE TABLE IF NOT EXISTS cas.tcoverage_premiums_prem_fact (
    plan_code varchar(6),
    iss_age numeric(2),
    prem_rate numeric(6,2),
    sex varchar(1),
    file_nm varchar(20),
    cas_plan_code varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.tcoverage_premiums_sa_fact (
    plan_code varchar(6),
    sex varchar(1),
    smkr_non_smkr varchar(1),
    iss_age numeric(2),
    ins_range_fct1 numeric(6,2),
    ins_range_fct2 numeric(6,2),
    file_nm varchar(20),
    cas_plan_code varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.tcoverage_premiums_wrk (
    plan_code varchar(5) not null,
    prem_vers varchar(2) not null,
    crcy_code varchar(2) not null,
    sex_code varchar(1) not null,
    smkr_code varchar(1) not null,
    cvg_clas varchar(3) not null,
    band_low numeric(13,2) not null,
    band_high numeric(13,2) not null,
    eff_fr_dt timestamp not null,
    occp_clas varchar(1),
    eff_age numeric(3) not null,
    prem_per_unit numeric(10,3) not null,
    unit_basis varchar(1) not null,
    eff_to_dt timestamp,
    prem_prd numeric(3) not null
);

CREATE TABLE IF NOT EXISTS cas.tcoverage_tax_rate_th (
    plan_code varchar(5) not null,
    prem_vers varchar(2) not null,
    crcy_code varchar(2),
    sex_code varchar(1),
    smkr_code varchar(1),
    cvg_clas varchar(3),
    band_low numeric(13,2),
    band_high numeric(13,2),
    eff_fr_dt timestamp not null,
    occp_clas varchar(1),
    eff_age numeric(3),
    prem_per_unit numeric(13,6),
    unit_basis varchar(1),
    eff_to_dt timestamp,
    prem_prd numeric(3),
    band_percnt numeric(3),
    sec_rating_age numeric(3) default -1,
    int_rt numeric(5,3),
    dist_chnl_cd varchar(2),
    fr_dur numeric(3) default -1,
    to_dur numeric(3) default -1,
    sec_sex_code varchar(1) default '*',
    rcc_ind varchar(1),
    no_of_insrd numeric(2),
    rt_typ varchar(1),
    to_bnft_prd numeric(3) default '-1',
    fr_bnft_prd numeric(3) default '-1',
    tax_percen numeric(5,2) not null,
    tax_typ varchar(5) not null
);

CREATE TABLE IF NOT EXISTS cas.tcoverage_wps (
    pol_num varchar(10) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cli_num varchar(13) not null,
    cvg_eff_dt timestamp not null,
    layer_eff_dt timestamp not null,
    layer_typ varchar(1) not null,
    cvg_lay_typ varchar(5) not null,
    wp_plan_code varchar(5) not null,
    wp_vers_num varchar(2) not null,
    wp_cli_num varchar(13) not null,
    wp_eff_dt timestamp not null,
    wp_option varchar(1),
    wp_prem numeric(11,2),
    wp_nc_prem numeric(11,2),
    wp_mpre numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tcpf_bill_ctrl_stat_sg (
    rcpt_id varchar(70),
    dt_created timestamp,
    s_num numeric(4),
    batch_s_num varchar(6),
    txn_cde varchar(2),
    dt_send timestamp,
    bank_cde varchar(4),
    dt_ret timestamp,
    dt_settlement timestamp,
    hash_totl numeric(18),
    totl_rec_cnt numeric(5),
    success_rec_cnt numeric(5)
);

CREATE TABLE IF NOT EXISTS cas.tcpf_bill_det_stat_sg (
    batch_s_num varchar(6),
    int_ref_num varchar(6),
    cpf_inv_ac_num varchar(20),
    id_num varchar(20),
    cli_nm varchar(60),
    auth_ind varchar(1),
    pol_nm varchar(40),
    pol_num varchar(10),
    prem_payable numeric(11,2),
    prem_due_dt timestamp,
    deduct_stat_cde varchar(2),
    bank_cheque_no varchar(15),
    bank_cheque_dt timestamp,
    dt_cheque_recv timestamp
);

CREATE TABLE IF NOT EXISTS cas.tcpf_histories (
    pol_num varchar(10),
    cas_dt timestamp,
    trxn_dt timestamp,
    trxn_amt numeric(12,2),
    acct_cde varchar(15),
    dr_or_cr varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tcpf_hps_ctrl_stat_sg (
    run_num numeric(5),
    txn_dt timestamp,
    recv_dt timestamp,
    mth_data varchar(6),
    detl_rec_cnt numeric(6)
);

CREATE TABLE IF NOT EXISTS cas.tcpf_hps_det_stat_sg (
    mth_data varchar(6),
    cpf_inv_ac_num varchar(10),
    cli_nm varchar(60),
    pol_num varchar(10),
    pol_stat varchar(1),
    exem_dt timestamp,
    cpf_ac_num varchar(10),
    hm_ref_num varchar(20),
    link_typ varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tcpf_seq_num (
    cas_dt timestamp,
    gen_dt timestamp,
    fran_num varchar(5),
    seq_num numeric,
    bill_dt timestamp,
    settl_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tcreat_ratefiles_layout (
    table_name varchar(40) not null,
    column_name varchar(40) not null,
    start_position numeric(3) not null,
    length numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tcredit_card_billing_pol_sg (
    pol_num varchar(10),
    cli_num varchar(10),
    addr_typ numeric(2),
    run_date timestamp
);

CREATE TABLE IF NOT EXISTS cas.tcredit_card_charge_rates (
    srvc_ctr varchar(5) not null,
    iss_bank varchar(13) not null,
    card_typ varchar(1) not null,
    eff_dt timestamp not null,
    offline_rt numeric(7,4),
    online_rt numeric(7,4),
    recurring_rt numeric(7,4),
    proc_bank varchar(13) not null,
    card_cat varchar(1) not null,
    oth_rt_typ varchar(10) not null,
    oth_rt numeric(7,4)
);

CREATE TABLE IF NOT EXISTS cas.tcross_entry_details (
    fr_pol_num varchar(10) not null,
    trxn_dt timestamp not null,
    shi_num numeric(4) not null,
    eff_dt timestamp,
    trxn_amt numeric(13,2),
    xfer_reasn_cd varchar(3) not null,
    remarks varchar(100),
    to_pol_num varchar(10) not null,
    user_id varchar(30) not null,
    reasn_code varchar(3),
    fr_acct_mne_cd varchar(8),
    trxn_id varchar(15),
    orig_trxn_id varchar(15),
    fr_to_ind varchar(1),
    exchg_rt numeric
);

CREATE TABLE IF NOT EXISTS cas.tcrrs (
    crr_num numeric(15) not null,
    pol_num varchar(10) not null,
    agt_code varchar(6) not null,
    reasn_cd varchar(3) not null,
    prem_amt numeric(11,2) not null,
    comm_amt numeric(11,2) not null,
    pc_amt numeric(9) not null,
    case_ctr numeric(5,2) not null,
    splt_rt numeric(6,2) not null,
    colct_dt timestamp,
    plan_code varchar(5),
    vers_num varchar(2),
    insrd_nm varchar(60) not null,
    pd_to_dt timestamp not null,
    submt_dt timestamp not null,
    iss_dt timestamp,
    restr_case_cnt_ind varchar(2),
    pol_eff_dt timestamp not null,
    mode_num numeric(3),
    mode_freq varchar(2),
    prod_code varchar(5),
    crr_trxn_dt timestamp not null,
    fyip_amt numeric(11,2) not null,
    fyrp_amt numeric(11,2) not null,
    ryp_amt numeric(11,2) not null,
    fyic_amt numeric(11,2) not null,
    fyrc_amt numeric(11,2) not null,
    rcomm_amt numeric(11,2) not null,
    afyc_amt numeric(9) not null,
    lafyc_amt numeric(9) not null,
    lafyc13_amt numeric(9) not null,
    ncase_ctr numeric(5,2) not null,
    lcase_ctr numeric(5,2) not null,
    lcase13_ctr numeric(5,2) not null,
    bill_mthd varchar(1),
    fran_num varchar(5),
    crcy_cd varchar(2),
    pmt_mode varchar(2),
    orph_asign_ind varchar(1),
    cli_num varchar(13),
    cvg_eff_dt timestamp,
    comm_rt numeric(5,2),
    cause_cd varchar(3),
    cvg_lay_typ varchar(5),
    layer_eff_dt timestamp,
    tid varchar(15),
    trxn_id varchar(15),
    undo_trxn_id varchar(15),
    user_id varchar(30),
    plan_code_base varchar(5),
    vers_num_base varchar(2),
    uwg_clas varchar(30),
    sex_code varchar(1),
    comm_prem_amt numeric(13,2),
    anp_amt numeric(11,2),
    tcomm_fnd_valu numeric(20,10),
    renw_term numeric(3),
    renw_yr numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tcrrs_missing_nac (
    crr_num numeric(15) not null,
    pol_num varchar(10) not null,
    agt_code varchar(5) not null,
    reasn_cd varchar(3) not null,
    prem_amt numeric(11,2) not null,
    comm_amt numeric(11,2) not null,
    pc_amt numeric(9) not null,
    case_ctr numeric(5,2) not null,
    splt_rt numeric(6,2) not null,
    colct_dt timestamp,
    plan_code varchar(5),
    vers_num varchar(2),
    insrd_nm varchar(60) not null,
    pd_to_dt timestamp not null,
    submt_dt timestamp not null,
    iss_dt timestamp not null,
    restr_case_cnt_ind varchar(2),
    pol_eff_dt timestamp not null,
    mode_num numeric(3),
    mode_freq varchar(2),
    prod_code varchar(5),
    crr_trxn_dt timestamp not null,
    fyip_amt numeric(11,2) not null,
    fyrp_amt numeric(11,2) not null,
    ryp_amt numeric(11,2) not null,
    fyic_amt numeric(11,2) not null,
    fyrc_amt numeric(11,2) not null,
    rcomm_amt numeric(11,2) not null,
    afyc_amt numeric(9) not null,
    lafyc_amt numeric(9) not null,
    lafyc13_amt numeric(9) not null,
    ncase_ctr numeric(5,2) not null,
    lcase_ctr numeric(5,2) not null,
    lcase13_ctr numeric(5,2) not null,
    bill_mthd varchar(1),
    fran_num varchar(5),
    crcy_cd varchar(2),
    pmt_mode varchar(2),
    orph_asign_ind varchar(1),
    cli_num varchar(10),
    cvg_eff_dt timestamp,
    comm_rt numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.tcrrs_sg (
    crr_num numeric(7) not null,
    pol_num varchar(10) not null,
    agt_code varchar(5) not null,
    reasn_cd varchar(3) not null,
    prem_amt numeric(11,2) not null,
    comm_amt numeric(11,2) not null,
    pc_amt numeric(9) not null,
    case_ctr numeric(5,2) not null,
    splt_rt numeric(6,2) not null,
    colct_dt timestamp,
    plan_code varchar(5),
    vers_num varchar(2),
    insrd_nm varchar(60) not null,
    pd_to_dt timestamp not null,
    submt_dt timestamp not null,
    iss_dt timestamp,
    restr_case_cnt_ind varchar(2),
    pol_eff_dt timestamp not null,
    mode_num numeric(3),
    mode_freq varchar(2),
    prod_code varchar(5),
    crr_trxn_dt timestamp not null,
    fyip_amt numeric(11,2) not null,
    fyrp_amt numeric(11,2) not null,
    ryp_amt numeric(11,2) not null,
    fyic_amt numeric(11,2) not null,
    fyrc_amt numeric(11,2) not null,
    rcomm_amt numeric(11,2) not null,
    afyc_amt numeric(9) not null,
    lafyc_amt numeric(9) not null,
    lafyc13_amt numeric(9) not null,
    ncase_ctr numeric(5,2) not null,
    lcase_ctr numeric(5,2) not null,
    lcase13_ctr numeric(5,2) not null,
    bill_mthd varchar(1),
    fran_num varchar(5),
    crcy_cd varchar(2),
    pmt_mode varchar(2),
    orph_asign_ind varchar(1),
    cli_num varchar(10),
    cvg_eff_dt timestamp,
    comm_rt numeric(5,2),
    sm_code varchar(6),
    bm_code varchar(5),
    ann_fyp numeric(11,2),
    layer_eff_dt timestamp,
    anp_amt numeric(11,2),
    par_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tcrr_mappings (
    reasn_cd varchar(3) not null,
    prem_amt varchar(10),
    comm_amt varchar(10),
    pc_amt varchar(10),
    case_ctr varchar(10),
    reasn_desc varchar(50),
    upd_ftr numeric(2)
);

CREATE TABLE IF NOT EXISTS cas.tcsms_beneficiary_details (
    pol_num varchar(10) not null,
    bnfy_nm varchar(60) not null,
    bnfy_code varchar(3),
    bnfy_prty varchar(1),
    bnfy_pct numeric(5,2),
    trustee_nm varchar(60),
    trxn_seq_no numeric(5) not null
);

CREATE TABLE IF NOT EXISTS cas.tcsms_campaigns (
    pol_num varchar(10) not null,
    cmpn_code varchar(10) not null,
    trxn_seq_no numeric(5) not null
);

CREATE TABLE IF NOT EXISTS cas.tcsms_cash_batch_details (
    btch_num varchar(3),
    trxn_dt timestamp,
    btch_typ varchar(4),
    col_crcy_code varchar(2),
    col_trxn_amt numeric(11,2),
    btch_seq_no numeric(5),
    pol_num varchar(10),
    eff_dt timestamp,
    reasn_code varchar(3),
    crcy_code varchar(2),
    trxn_amt numeric(11,2),
    exchg_rt numeric(18,8),
    chq_no_text varchar(20),
    chq_dt timestamp,
    card_xpry_dt varchar(4),
    remarks varchar(100),
    acct_mne_cd varchar(8),
    report_no numeric(3),
    medic_fee_ind varchar(1),
    nb_trxn_map_no numeric(5),
    last_update_user varchar(30),
    last_update_date timestamp,
    cas_btch_num varchar(20),
    trxn_seq_no numeric(5)
);

CREATE TABLE IF NOT EXISTS cas.tcsms_cash_batch_headers (
    btch_num varchar(3),
    trxn_dt timestamp,
    btch_typ varchar(4),
    col_crcy_code varchar(2),
    col_btch_tot numeric(13,2),
    report_no numeric(3),
    nb_hdr varchar(1),
    trxn_seq_no numeric(5)
);

CREATE TABLE IF NOT EXISTS cas.tcsms_cbd_fund_alloc (
    btch_num varchar(3) not null,
    trxn_dt timestamp not null,
    pol_num varchar(10) not null,
    fnd_id varchar(5) not null,
    deal_basis varchar(1),
    deal_amt numeric(13,2),
    col_deal_amt numeric(13,2),
    trxn_seq_no numeric(10) not null,
    btch_seq_no numeric(5) not null
);

CREATE TABLE IF NOT EXISTS cas.tcsms_commission_trailers (
    pol_num varchar(10) not null,
    agt_code varchar(6) not null,
    pct_splt numeric(3),
    trxn_seq_no numeric(5) not null
);

CREATE TABLE IF NOT EXISTS cas.tcsms_coverages (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_typ varchar(1),
    cvg_clas varchar(3),
    occp_clas varchar(1),
    smkr_code varchar(1),
    sex_code varchar(1),
    face_amt numeric(13,2),
    temp_flat_dur numeric(3),
    temp_flat_unit_prem numeric(10,3),
    temp_mort_ratg numeric(5),
    temp_mort_dur numeric(3),
    perm_flat_unit_prem numeric(10,3),
    perm_mort_ratg numeric(5),
    rcc_ind varchar(1),
    excl_code1 varchar(1),
    no_of_insrd numeric(2),
    trxn_seq_no numeric(5) not null
);

CREATE TABLE IF NOT EXISTS cas.tcsms_coverage_other_insured (
    pol_num varchar(10),
    plan_code varchar(5),
    vers_num varchar(2),
    cvg_eff_dt timestamp,
    oth_cli_num varchar(13),
    trxn_seq_no numeric(5)
);

CREATE TABLE IF NOT EXISTS cas.tcsms_fund_allocations (
    pol_num varchar(10) not null,
    fnd_id varchar(5) not null,
    alloc_typ varchar(1) not null,
    alloc_pct numeric(5,2),
    trxn_seq_no numeric(5) not null,
    prem_grp varchar(3) not null
);

CREATE TABLE IF NOT EXISTS cas.tcsms_policys (
    pol_num varchar(10) not null,
    crcy_code varchar(2),
    pol_app_dt timestamp,
    pol_eff_dt timestamp,
    pol_iss_dt timestamp,
    pol_stat_cd varchar(1),
    frez_code varchar(1),
    pmt_mode varchar(5),
    bill_mthd varchar(1),
    uwg_clas varchar(30),
    comprop_prem numeric(11,2),
    plan_prem numeric(11,2),
    agt_code varchar(6),
    db_opt varchar(1),
    mode_prem numeric(11,2),
    mpre numeric(11,2),
    iio_opt varchar(1),
    iio_pct numeric(3),
    rebal_ind varchar(1),
    bank_acct_num varchar(20),
    bank_cd varchar(13),
    bank_acct_nm varchar(30),
    fran_num varchar(5),
    dda_eff_dt timestamp,
    dda_status varchar(2),
    ipo_ind varchar(1),
    subj_to_cd varchar(2),
    special_clas varchar(2),
    occ_cd varchar(6),
    insrd_mort varchar(4),
    bnh_code varchar(5),
    reins_mthd varchar(1),
    reins_cd varchar(3),
    init_prem_pd numeric(11,2),
    convrt_fr_pol varchar(10),
    trxn_seq_no numeric(5) not null,
    last_update_user varchar(30),
    last_update_date timestamp,
    init_tup_prem_pd numeric(11,2),
    nb_print_stat varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tctbank_add_th (
    bank_cd varchar(13) not null,
    zip_code varchar(6) not null
);

CREATE TABLE IF NOT EXISTS cas.tcurrency_master (
    crcy_code varchar(2) not null,
    crcy_abbr varchar(5),
    crcy_desc varchar(20),
    prem_tol_amt numeric(5,2) not null,
    crcy_symbl varchar(5) not null,
    loan_tol_amt numeric(5,2) not null,
    ntk_tol_amt numeric(5,2) not null,
    min_pdf_wthdr_amt numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tcurr_sessions (
    username varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.tcutoff_dt (
    grt_cut_dt timestamp not null,
    sys_cut_dt timestamp not null,
    process_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tcvg_srv_agt_hist_sg (
    crcy_code varchar(2) not null,
    pol_num varchar(10) not null,
    agt_seq_num numeric(2) not null,
    plan_num numeric(2) not null,
    plan_code varchar(6),
    plan_name varchar(40),
    cvg_eff_dt timestamp,
    eff_fr_ptd timestamp,
    created_by varchar(6),
    date_created timestamp,
    amended_by varchar(6),
    date_amended timestamp
);

CREATE TABLE IF NOT EXISTS cas.tcwa_suspense (
    pol_num varchar(10) not null,
    susp_dt timestamp not null,
    shi_num numeric(4) not null,
    susp_amt numeric(13,2) not null,
    crcy_code varchar(2) not null,
    trxn_cd varchar(8) not null,
    reasn_code varchar(3) not null,
    acct_mne_cd varchar(8),
    resv_dnr_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.td4exmr_examiner_master (
    examiner_code varchar(6) not null,
    examiner_nm varchar(100) not null,
    id_num varchar(13) not null,
    id_typ varchar(1),
    sex_code varchar(1) not null,
    birth_date timestamp,
    income_tax_num varchar(14),
    reg_num varchar(10),
    academic_dtls varchar(50),
    pref_doctor_flag varchar(1),
    panel_doctor_flag varchar(1),
    appointed_dt timestamp,
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp
);

CREATE TABLE IF NOT EXISTS cas.td1map_clinic_examiner_map (
    examiner_code varchar(6) not null,
    clinic_code varchar(6) not null,
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp
);

CREATE TABLE IF NOT EXISTS cas.td3cons_clinic_consult_hours (
    clinic_code varchar(6) not null,
    line_num numeric(2) not null,
    consult_day varchar(30),
    consult_hour varchar(40),
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp
);

CREATE TABLE IF NOT EXISTS cas.td5fac_medical_facilities (
    med_fac_cd varchar(10) not null,
    med_fac_desc varchar(60),
    acct_mne_cd varchar(8),
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp
);

CREATE TABLE IF NOT EXISTS cas.td6chrg_medical_charges (
    clinic_code varchar(6) not null,
    med_fac_cd varchar(10) not null,
    med_charges numeric(11,2),
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp
);

CREATE TABLE IF NOT EXISTS cas.td9acct_med_exam_ctl (
    clinic_code varchar(6) not null,
    payee_typ_mp varchar(1) not null,
    payee_code varchar(6) not null,
    pmt_bal numeric(11,2),
    pay_rel_flag varchar(1),
    payo_typ varchar(10),
    payo_arang varchar(10),
    last_proc_dt timestamp,
    chq_iss_mthd varchar(1),
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp
);

CREATE TABLE IF NOT EXISTS cas.tdashbord_monthly_th (
    create_date timestamp,
    b_mon_yr varchar(10),
    c_unq_cust numeric(13,2),
    f_ifp_cust numeric(13,2),
    j_new_cust_mtd numeric(13,2),
    k_new_cust_ytd numeric(13,2),
    l_attr_mtd numeric(13,2),
    m_attr_ytd numeric(13,2),
    o_ifp_rider_per_cust numeric(13,2),
    p_ifp_rider_per_new_6mth numeric(13,2),
    q_ifp_rider_per_ext numeric(13,2),
    t_ifp_rider_per_cust_agt numeric(13,2),
    z_ifp_rider_per_cust_oth numeric(13,2),
    ac_ifp_rider_per_cust_dg numeric(13,2),
    ae_sum_cat_cust numeric(13,2),
    af_1_cat_cust numeric(13,2),
    ag_multi_cat_cust numeric(13,2),
    al_clam_mth numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tdbnote_clinic_payment_note (
    payee_code varchar(6) not null,
    clinic_code varchar(6) not null,
    payee_typ_mp varchar(1) not null,
    cas_dt timestamp not null,
    set_num numeric(3) not null,
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp
);

CREATE TABLE IF NOT EXISTS cas.tdda_setups (
    pol_num varchar(10) not null,
    bank_id varchar(13) not null,
    bank_acct_num varchar(20) not null,
    setup_act varchar(1) not null,
    setup_src varchar(1) not null,
    id_typ varchar(1),
    id_num varchar(20),
    bank_acct_nm varchar(40) not null,
    bill_mthd varchar(1) not null,
    fran_num varchar(4),
    payr_addr_1 varchar(60),
    payr_addr_2 varchar(60),
    payr_addr_3 varchar(60),
    payr_nm varchar(60),
    payr_phon_num varchar(20),
    payr_zip_code varchar(6),
    trxn_dt timestamp,
    cli_num varchar(13),
    dda_reject_cd varchar(2),
    dda_reject_dt timestamp,
    feed_dt timestamp,
    update_dt timestamp,
    create_dt timestamp not null,
    debit_day numeric(2) not null,
    eff_dt timestamp not null,
    feed_stat_cd varchar(2) not null,
    seq_num numeric(2) not null,
    status varchar(2) not null,
    verify_stat_cd varchar(2) not null
);

CREATE TABLE IF NOT EXISTS cas.tdeath_benefit_values (
    plan_code varchar(5) not null,
    pol_val_vers varchar(2) not null,
    sex_code varchar(1) not null,
    eff_age numeric(3) not null,
    eff_dur numeric(3) not null,
    dth_bnft_rt numeric(12,5) not null,
    unit_basis varchar(1) not null,
    int_rt numeric(5,3) default -1 not null,
    crcy_code varchar(2) default '*' not null,
    prem_prd numeric(3) default -1 not null,
    dth_typ varchar(4) default '*' not null,
    bnft_prd numeric(3) default -1 not null
);

CREATE TABLE IF NOT EXISTS cas.tdeath_benefit_values_layout (
    plan_code_pos numeric(3),
    plan_code_len numeric(3),
    pol_val_vers_pos numeric(3),
    pol_val_vers_len numeric(3),
    sex_code_pos numeric(3),
    sex_code_len numeric(3),
    eff_age_pos numeric(3),
    eff_age_len numeric(3),
    eff_dur_pos numeric(3),
    eff_dur_len numeric(3),
    dth_bnft_rt_pos numeric(3),
    dth_bnft_rt_len numeric(3),
    unit_basis_pos numeric(3),
    unit_basis_len numeric(3),
    int_rt_len numeric(3),
    int_rt_pos numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tdebug_info (
    user_id varchar(30),
    module_id varchar(30),
    trxn_id varchar(30),
    info1 varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.tdebug_pc_calc (
    pol_num varchar(10) not null,
    cvg_idx numeric(6)
);

CREATE TABLE IF NOT EXISTS cas.tdeductions (
    id numeric(10) not null,
    pol_num varchar(10) not null,
    adv_comm_amt numeric(12,2) not null,
    agt_code varchar(6) not null,
    coll_dt timestamp not null,
    created_by varchar(10) not null,
    date_created timestamp not null,
    date_modified timestamp,
    modified_by varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tdiff_mvy_hist_headers (
    pol_num varchar(10) not null,
    mvy_seq numeric(4) not null,
    tot_amt numeric(11,2),
    curr_mvy_dt timestamp,
    ovrdu_dt timestamp,
    lapse_dt timestamp,
    defr_reasn varchar(1) not null,
    layer_eff_dt timestamp not null,
    layer_typ varchar(1) not null,
    test_lvl numeric(1) not null,
    mvy_ded_ind varchar(1) not null,
    count_row numeric
);

CREATE TABLE IF NOT EXISTS cas.tdist_chnl_cd_mapping_th (
    agt_sup char(6),
    dist_chnl_cd char(1),
    plan_code varchar(5),
    vers_num varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tdividend_values (
    plan_code varchar(5) not null,
    pol_val_vers varchar(2) not null,
    div_typ varchar(1) not null,
    sex_code varchar(1) not null,
    eff_age numeric(3) not null,
    eff_dur numeric(3) not null,
    unit_basis varchar(1) not null,
    div_rt numeric(9,4) not null,
    declar_dt timestamp not null,
    intrim_rt numeric(9,4),
    crcy_code varchar(2) default '*' not null,
    prem_prd numeric(3) default -1 not null,
    bnft_prd numeric(3) default -1 not null
);

CREATE TABLE IF NOT EXISTS cas.tdividend_values_layout (
    plan_code_pos numeric(3),
    plan_code_len numeric(3),
    pol_val_vers_pos numeric(3),
    pol_val_vers_len numeric(3),
    div_typ_pos numeric(3),
    div_typ_len numeric(3),
    sex_code_pos numeric(3),
    sex_code_len numeric(3),
    eff_age_pos numeric(3),
    eff_age_len numeric(3),
    eff_dur_pos numeric(3),
    eff_dur_len numeric(3),
    unit_basis_pos numeric(3),
    unit_basis_len numeric(3),
    div_rt_pos numeric(3),
    div_rt_len numeric(3),
    declar_dt_len numeric(3),
    declar_dt_pos numeric(3),
    intrim_rt_len numeric(3),
    intrim_rt_pos numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tdividend_values_load (
    plan_code varchar(5),
    pol_val_vers varchar(2),
    div_typ varchar(1),
    sex_code varchar(1),
    eff_age numeric(3),
    eff_dur numeric(3),
    unit_basis varchar(1),
    div_rt numeric(7,2),
    declar_dt timestamp,
    intrim_rt numeric(7,2)
);

CREATE TABLE IF NOT EXISTS cas.tdnr_details (
    pol_num varchar(10) not null,
    dnr_num numeric(4) not null,
    payo_amt numeric(14,2) not null,
    payo_type varchar(10) not null,
    payo_arrange varchar(10),
    payo_reas varchar(10) not null,
    user_id varchar(30),
    remarks varchar(100),
    trxn_dt timestamp,
    cli_num varchar(13),
    last_auto_feed_dt timestamp,
    autopay_ac_hldr_nm varchar(60),
    autopay_ac_num varchar(15),
    chrg_amt numeric(11,2),
    dnr_stat_cd varchar(1),
    exchg_rt numeric(18,8),
    fnd_trxn_cd varchar(3),
    payo_amt_payo_crcy numeric(13,2),
    payo_crcy varchar(2),
    payo_init_chrg numeric(13,2),
    payo_load_amt numeric(13,2),
    payo_unit numeric(20,10),
    pol_crcy varchar(2),
    rqst_amt numeric(13,2),
    trxn_id varchar(15),
    txfr_to_pol_num varchar(55),
    valn_dt timestamp,
    payee_nm varchar(60),
    clmout_inv_no varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.tdnr_details_sg (
    pol_num varchar(10),
    dnr_num numeric(4),
    payo_amt numeric(11,2),
    trxn_dt timestamp,
    cli_name varchar(60),
    status varchar(2),
    j_dnr_num numeric(4),
    appr_date timestamp,
    appr_by varchar(30),
    iss_dt timestamp,
    iss_by varchar(30),
    re_iss_dt timestamp,
    re_iss_by varchar(30),
    chq_cross varchar(1),
    chq_num varchar(10),
    chq_dt timestamp,
    chq_iss_bank varchar(10),
    remarks varchar(500),
    proc varchar(1),
    btch_num varchar(5),
    chq_btch_num varchar(5),
    dnr_letter varchar(20),
    print_chq varchar(1),
    extract_btch_num varchar(5),
    payee_typ varchar(1),
    payee_code varchar(13),
    bnfy_typ varchar(3),
    extract_dt timestamp,
    transfer_dt timestamp,
    proc_by varchar(30),
    proc_date timestamp
);

CREATE TABLE IF NOT EXISTS cas.tdnr_payo_th (
    payo_reas varchar(10) not null,
    priority numeric(3) not null,
    payo_typ varchar(10),
    payo_arang varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tdnr_setup_sg (
    user_id varchar(30) not null,
    role_granted varchar(30),
    dept_allow varchar(2),
    reasn_code varchar(10),
    stat_cd varchar(2),
    crcy_code varchar(2),
    amt_limit numeric
);

CREATE TABLE IF NOT EXISTS cas.tdoi_eti_rates_th (
    md_key varchar(7) not null,
    sex_code varchar(1) not null,
    eff_age numeric(3) not null,
    eff_dur numeric(3) not null,
    pe_rt numeric(9,4) default 0 not null,
    eti_yr numeric(3) not null,
    eti_day numeric(3) not null,
    eti_rfnd_rt numeric(9,4) default 0 not null
);

CREATE TABLE IF NOT EXISTS cas.tee_req_hdr (
    req_job_typ varchar(1),
    pol_num varchar(10),
    ee_req_num numeric(8) not null,
    ee_req_stat varchar(1),
    ee_req_typ varchar(4),
    sbmt_dt timestamp,
    chg_agt_flg varchar(1),
    atten_by_agt1 varchar(6),
    atten_by_agt2 varchar(6),
    letter_typ varchar(4),
    no_notice_send numeric(2),
    dt_last_send timestamp,
    last_rmd_flg varchar(1),
    srvc_ctr varchar(6),
    approval_dt timestamp,
    remark1 varchar(80),
    remark2 varchar(80),
    remark3 varchar(80),
    clinic_code varchar(3),
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp
);

CREATE TABLE IF NOT EXISTS cas.teg_doc_amd_det (
    ee_req_num numeric(8) not null,
    cl_typ varchar(1) not null,
    cl_grp varchar(8) not null,
    cl_line numeric(3) not null,
    cl_detail varchar(100),
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp
);

CREATE TABLE IF NOT EXISTS cas.temp_anp_sg (
    run_num varchar(6),
    pol_num varchar(10),
    agt_code varchar(5),
    agt_nm varchar(40),
    prem_amt numeric(11,2),
    annprem numeric(11,2),
    pc_amt numeric(9),
    splt_rt numeric(6,2),
    plan_code varchar(5),
    pmt_mode varchar(2),
    unit_code varchar(5),
    br_code varchar(5),
    un_nm varchar(40),
    br_nm varchar(40),
    sngle_prem_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.temp_erp_contest (
    pol_num varchar(10),
    agt_code varchar(5),
    agt_nm varchar(40),
    orig_agt_cd varchar(5),
    reasn_cd varchar(3),
    prem_amt numeric(11,2),
    annprem numeric(11,2),
    pc_amt numeric(9),
    splt_rt numeric(6,2),
    plan_code varchar(5),
    insrd_nm varchar(60),
    submt_dt timestamp,
    crr_trxn_dt timestamp,
    fran_num varchar(5),
    pmt_mode varchar(2),
    unit_code varchar(5),
    br_code varchar(5),
    un_nm varchar(40),
    br_nm varchar(40),
    orph_oind varchar(1),
    fmly_ind varchar(1),
    rank_cd varchar(5),
    comp_prvd_num varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.temp_fa (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    rel_to_insrd varchar(2) not null,
    crcy_code varchar(2) not null,
    fa_typ_low varchar(1) not null,
    face_amt_low numeric(13,2),
    fa_edit_low varchar(200),
    fa_typ_high varchar(1) not null,
    face_amt_high numeric(13,2),
    fa_edit_high varchar(200),
    error_lvl varchar(1) not null,
    eff_age_low numeric(3) not null,
    eff_age_high numeric(3) not null,
    eff_fr_dt timestamp not null,
    eff_to_dt timestamp not null,
    sex_code varchar(1),
    smkr_code varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.temp_fund_closure_sg (
    pol_num varchar(10) not null,
    policy_status varchar(150) not null,
    plan_code_base varchar(5),
    plan_lng_desc varchar(50) not null,
    cli_num varchar(13) not null,
    owner_nm varchar(60) not null,
    insrd_num varchar(13) not null,
    insured varchar(60) not null,
    alloc_pct numeric(5,2),
    fnd_id varchar(5) not null,
    rsp_ind varchar(1),
    svc_agt_1 varchar(6),
    svc_agt_nm_1 varchar(40) not null,
    svc_agt_2 varchar(6),
    svc_agt_nm_2 varchar(40),
    branch varchar(4000),
    addr_1 varchar(60) not null,
    addr_2 varchar(60),
    addr_3 varchar(60),
    zip_code varchar(6),
    fnd_switch_ctr numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.temp_lapse_actv_schedules (
    pol_num varchar(10) not null,
    actv_dt timestamp not null,
    asc_num numeric(4) not null,
    actv_reasn varchar(10) not null,
    actv_typ varchar(3) not null,
    actv_seq numeric(2),
    proc_dt timestamp,
    ref_date varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.temp_pol (
    pol_num varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.temp_tcas_mdrt_detailed_report (
    agent_id varchar(6),
    branch_code varchar(6),
    unit_code varchar(6)
);

CREATE TABLE IF NOT EXISTS cas.temp_text_db (
    comp_cd varchar(2),
    cli_id varchar(20),
    cli_nm varchar(60),
    cli_birth_dt timestamp,
    cli_sex varchar(1),
    ins_typ varchar(1),
    cvg_crcy varchar(2),
    cvg_amt numeric(13,2),
    stat_cd varchar(1),
    ref_no varchar(10),
    eff_rej_srd_dt timestamp,
    rej_reasn1 varchar(5),
    rej_reasn2 varchar(5),
    rej_reasn3 varchar(5),
    tlia_comp varchar(40),
    tlia_typ varchar(10),
    tlia_num numeric(10),
    app_dt timestamp,
    link_typ varchar(1) not null,
    agt_code varchar(6),
    br_code varchar(5),
    uwg_clas varchar(30),
    claim_ind varchar(1),
    smkr_code varchar(1),
    occp_code varchar(10),
    occp_clas varchar(1),
    pol_eff_dt timestamp,
    pol_iss_dt timestamp,
    sbmt_dt timestamp,
    medic_code varchar(1),
    agt_nm varchar(60),
    pmt_mode varchar(5),
    ipo_ind varchar(1),
    reins_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.temp_text_db_upd (
    cli_id varchar(20),
    cli_nm varchar(60)
);

CREATE TABLE IF NOT EXISTS cas.temp_text_db_upd (
    cli_id varchar(20),
    cli_nm varchar(60)
);

CREATE TABLE IF NOT EXISTS cas.temp_vested_pol (
    pol_num varchar(10),
    old_agt varchar(5),
    new_agt varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.tendrs_controls (
    endrs_typ varchar(30) not null,
    endrs_eng_desc varchar(100),
    endrs_lng_desc varchar(100),
    endrs_enable_ind varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tendrs_messages (
    msg_id varchar(5) not null,
    msg_txt varchar(1000)
);

CREATE TABLE IF NOT EXISTS cas.tenh_prob_mast (
    id_num varchar(15),
    dept varchar(30),
    subm_dt timestamp,
    subm_by varchar(20),
    auth_by varchar(20),
    priority varchar(20),
    system varchar(20),
    phase varchar(20),
    cycle# varchar(20),
    req_typ varchar(20),
    desc_enh varchar(500),
    desc_reasn varchar(500),
    cause varchar(500),
    solution varchar(500),
    status varchar(15),
    assign_to varchar(20),
    background varchar(500),
    est_effort numeric(5,2),
    exp_start_dt timestamp,
    exp_end_dt timestamp,
    act_end_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tenh_prob_mod (
    id_num varchar(15),
    module_affected varchar(50),
    desc_change varchar(500),
    mod_id varchar(3),
    task_id varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tenh_prob_tasks (
    id_num varchar(15),
    task_seq numeric(3),
    task varchar(50),
    assign_to varchar(20),
    exp_st_dt timestamp,
    exp_ed_dt timestamp,
    exp_sign_off_dt timestamp,
    exp_duration numeric(3),
    actl_st_dt timestamp,
    actl_ed_dt timestamp,
    actl_sign_off_dt timestamp,
    actl_duration numeric(3),
    person_sign_off varchar(20),
    task_stat varchar(15),
    task_id varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.texchange_rates (
    xchng_rate_typ varchar(5) not null,
    fr_crcy_code varchar(2) not null,
    to_crcy_code varchar(2) not null,
    fr_eff_dt timestamp not null,
    to_eff_dt timestamp not null,
    buy_rate numeric(10,4),
    sell_rate numeric(10,4),
    xchng_rate numeric(10,4)
);

CREATE TABLE IF NOT EXISTS cas.texclusion_th (
    pol_num varchar(10) not null,
    seq_num numeric(4) not null,
    exclusion_txt varchar(500),
    exclusion_sta varchar(1),
    exclusion_start timestamp,
    create_dt timestamp,
    create_user varchar(30),
    modify_dt timestamp,
    modify_user varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.text_db (
    comp_cd varchar(2),
    cli_id varchar(20),
    cli_nm varchar(60),
    cli_birth_dt timestamp,
    cli_sex varchar(1),
    ins_typ varchar(1),
    cvg_crcy varchar(2),
    cvg_amt numeric(13,2),
    stat_cd varchar(1),
    ref_no varchar(10),
    eff_rej_srd_dt timestamp,
    rej_reasn1 varchar(5),
    rej_reasn2 varchar(5),
    rej_reasn3 varchar(5),
    tlia_comp varchar(40),
    tlia_typ varchar(10),
    tlia_num numeric(10),
    app_dt timestamp,
    link_typ varchar(1) not null,
    agt_code varchar(6),
    br_code varchar(5),
    uwg_clas varchar(30),
    claim_ind varchar(1),
    smkr_code varchar(1),
    occp_code varchar(10),
    occp_clas varchar(1),
    pol_eff_dt timestamp,
    pol_iss_dt timestamp,
    sbmt_dt timestamp,
    medic_code varchar(1),
    agt_nm varchar(60),
    pmt_mode varchar(5),
    ipo_ind varchar(1),
    reins_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tfacultative_th (
    pol_num varchar(10),
    cvg_eff_date timestamp,
    exp_date timestamp,
    cvg_eff_age numeric(3),
    sex_code varchar(1),
    face_amt numeric(13,2),
    amt_reass numeric(13,2),
    typ_of_risk varchar(8),
    reinsurer varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tfas_currency_masters (
    crcy_cd varchar(2) not null,
    crcy_abbr varchar(5) not null,
    crcy_desc varchar(20) not null,
    crcy_desc_eng varchar(20) not null,
    crcy_symbl varchar(5) not null
);

CREATE TABLE IF NOT EXISTS cas.tfas_schedules (
    run_num varchar(6) not null,
    asof_dt timestamp not null,
    valn_ind varchar(1) not null,
    unit_pric_dt timestamp,
    crcy_cd varchar(2) not null,
    cas_chk_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tfa_chk_dtl_tw (
    cond_mne_cd varchar(20) not null,
    plan_code varchar(20) not null,
    vers_num varchar(2) not null,
    group_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tfa_chk_group_tw (
    group_cd varchar(20) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    chk_rule varchar(1) default 'N' not null
);

CREATE TABLE IF NOT EXISTS cas.tfa_chk_hdr_tw (
    cond_mne_cd varchar(20) not null,
    upper_limit numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tfield_descriptions (
    fld_nm varchar(30) not null,
    fld_nm_desc varchar(50) not null,
    rec_status varchar(1) not null,
    sys_ind varchar(1),
    dflt_valu varchar(10),
    app_cd varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tfield_values (
    fld_nm varchar(30) not null,
    fld_valu varchar(10) not null,
    fld_valu_desc varchar(150) not null,
    rec_status varchar(1) not null,
    fld_valu_desc_eng varchar(50),
    fld_lkup_valu varchar(10),
    app_cd varchar(3),
    seq_num numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tfield_groups (
    grp_nm varchar(30) not null,
    fld_nm varchar(30) not null,
    fld_valu varchar(10) not null
);

CREATE TABLE IF NOT EXISTS cas.tfield_mapping_casams (
    cas_fld_nm varchar(30),
    ams_fld_nm varchar(30),
    cas_fld_valu varchar(10),
    ams_fld_valu varchar(10),
    fld_valu_desc varchar(150),
    rec_status varchar(1) default 'A'
);

CREATE TABLE IF NOT EXISTS cas.tfield_values_2_sg (
    fld_nm varchar(30) not null,
    fld_valu varchar(10) not null,
    fld_valu_desc varchar(150) not null,
    fld_valu_low varchar(50) not null,
    fld_valu_high varchar(50) not null,
    rec_status varchar(1) not null,
    fld_valu_desc_eng varchar(50),
    fld_lkup_valu varchar(10),
    app_cd varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tfield_value_bnfy_prty_bak_sg (
    fld_nm varchar(30) not null,
    fld_valu varchar(10) not null,
    fld_valu_desc varchar(150) not null,
    rec_status varchar(1) not null,
    fld_valu_desc_eng varchar(50),
    fld_lkup_valu varchar(10),
    app_cd varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tfnd_xfer_ctl (
    reasn_code varchar(3) not null,
    trxn_cd varchar(8) not null,
    lvl_ctl varchar(3) not null,
    fxc_num numeric(3) not null,
    src_dest_desc varchar(100) not null,
    acct_mne_cd varchar(8) not null
);

CREATE TABLE IF NOT EXISTS cas.tfp_bank_details_sg (
    bank_cd varchar(5),
    bank_name varchar(50),
    tel_num_prim varchar(10),
    tel_num_sec varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tfp_bank_links_sg (
    orig_agt_cde varchar(6),
    bank_cd_prim varchar(5),
    bank_cd_sec varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.tfp_comm_la_load_sg (
    pol_num varchar(10) not null,
    cvg_code varchar(4),
    plan_code varchar(5),
    insrd_nm varchar(50),
    pol_eff_dt timestamp,
    stat_cd varchar(2),
    trxn_amt numeric(17,2),
    acct_amt numeric(17,2),
    comm_rt numeric(5,2),
    comm_dt timestamp,
    splt_rt numeric(5,2),
    bill_freq varchar(2),
    agt_code varchar(6),
    unit_code varchar(5),
    agt_nm varchar(50),
    agt_app_dt timestamp,
    agt_term_dt timestamp,
    trxn_code varchar(4),
    trxn_yyyymm varchar(6),
    trxn_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tfp_comm_la_sg (
    pol_num varchar(10) not null,
    cvg_code varchar(4),
    plan_code varchar(5),
    insrd_nm varchar(50),
    pol_eff_dt timestamp,
    stat_cd varchar(2),
    trxn_amt numeric(17,2),
    acct_amt numeric(17,2),
    comm_rt numeric(5,2),
    comm_dt timestamp,
    splt_rt numeric(5,2),
    bill_freq varchar(2),
    agt_code varchar(6),
    unit_code varchar(5),
    agt_nm varchar(50),
    agt_app_dt timestamp,
    agt_term_dt timestamp,
    trxn_code varchar(4),
    trxn_yyyymm varchar(6),
    trxn_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tfp_plans_sg (
    plan_code varchar(5),
    vers_num varchar(2),
    cvg_typ varchar(1),
    eff_age_frm numeric(3),
    eff_age_to numeric(3),
    bnft_dur_frm numeric(3),
    bnft_dur_to numeric(3),
    prem_dur_frm numeric(3),
    prem_dur_to numeric(3),
    pmt_mode varchar(5),
    pfc_fyc_rt numeric(7,4),
    fyp_fac numeric(7,4),
    bon_fac varchar(10),
    bon_mon numeric(3),
    pfc_fyp_rt numeric(7,4),
    isd_pl_fyp_rt numeric(7,4),
    br_pl_fyp_rt numeric(7,4),
    br_welfare_fyp_rt numeric(7,4),
    biz_welfare_fyp_rt numeric(7,4),
    isd_welfare_fyp_rt numeric(7,4),
    nac_ovr_rt numeric(7,4),
    ins_typ varchar(2),
    sing_ind varchar(1),
    plan_desc varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.tfunctions (
    fcn_id varchar(20) not null,
    fcn_desc varchar(60) not null,
    fcn_type varchar(10) not null,
    def_printer varchar(10),
    collector varchar(30),
    department varchar(30),
    location varchar(30),
    output_opt varchar(1),
    app_cd varchar(3),
    print_mode varchar(2),
    redo_rpt_dflt_ind varchar(1),
    undo_allow varchar(1),
    redo_allow_mode varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tfunctions_sg (
    fcn_id varchar(20),
    fcn_short_nm varchar(50),
    prn_qty numeric(2),
    paper_typ varchar(2),
    fil_nm_type varchar(2),
    rec_status varchar(2),
    prn_freq varchar(5),
    ins_tprn_ctl varchar(2),
    rpt_mode varchar(2),
    ins_last_print varchar(1),
    copy_ind varchar(1),
    signer_id varchar(150),
    signature_typ varchar(1),
    oth_usage_ind varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tfunc_parm (
    fcn_id varchar(20) not null,
    parm_nme varchar(20) not null,
    parm_label varchar(50) not null,
    data_typ varchar(10) not null,
    opt_ind varchar(1) not null,
    def_value varchar(50),
    p_asof_dt varchar(20),
    disp_seq numeric(2),
    column_type varchar(1),
    lov_lkup_val varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.tfunds (
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    fnd_abbr varchar(20) not null,
    fnd_desc varchar(200) not null,
    eff_fr_dt timestamp not null,
    eff_to_dt timestamp,
    crcy_cd varchar(2) not null,
    fnd_typ varchar(4) not null,
    rt_base varchar(5),
    buy_in_day numeric(3),
    legal_id varchar(4) not null,
    pric_dec numeric(3),
    unit_dec numeric(3),
    min_fnd_bal numeric(11,2) not null,
    min_trxn_amt numeric(11,2),
    pric_chng_tol numeric(5,2),
    min_guar_int_rt numeric(5,2),
    enhc_code varchar(4),
    enhc_band_basis varchar(1),
    buy_sell_diff_ind varchar(1),
    unit_bal numeric(20,10),
    buy_sell_pct numeric(5,2),
    int_create numeric(20,10),
    btch_unit_bal numeric(20,10),
    crsis_ind varchar(1),
    fnd_native_desc varchar(200),
    t4_code varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tfund_accounting_rules (
    fnd_trxn_cd varchar(3) not null,
    procedure_id varchar(30) not null,
    acct_typ varchar(8) not null,
    fnd_typ varchar(4) not null,
    acct_mne_cd varchar(8) not null,
    dr_cr varchar(1) not null,
    rec_status varchar(1) not null,
    legal_id_ind varchar(1) not null,
    acct_mne_cd_typ varchar(1) not null,
    db_opt varchar(1) not null,
    chrg_typ varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tfund_allocations (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    alloc_eff_dt timestamp not null,
    alloc_stat_cd varchar(1) not null,
    alloc_pct numeric(5,2),
    unit_purch numeric(20,10),
    unit_wthdr numeric(20,10),
    unit_bal numeric(20,10),
    fnd_purch numeric(13,2),
    fnd_wthdr numeric(13,2),
    fnd_bal numeric(13,2),
    lst_trxn_dt timestamp,
    lst_thi_num numeric(4),
    gain_los_amt numeric(13,2),
    alloc_typ varchar(1) not null,
    prem_grp varchar(3) not null,
    rebal_typ varchar(1),
    rebal_freq varchar(2),
    rebal_cancel_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tfund_alloc_conv_cpf (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    alloc_eff_dt timestamp not null,
    alloc_stat_cd varchar(1) not null,
    alloc_pct numeric(5,2),
    unit_purch numeric(20,10),
    unit_wthdr numeric(20,10),
    unit_bal numeric(20,10),
    fnd_purch numeric(13,2),
    fnd_wthdr numeric(13,2),
    fnd_bal numeric(13,2),
    lst_trxn_dt timestamp,
    lst_thi_num numeric(4),
    gain_los_amt numeric(13,2),
    alloc_typ varchar(1) not null,
    prem_grp varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tfund_alloc_conv_csh (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    alloc_eff_dt timestamp not null,
    alloc_stat_cd varchar(1) not null,
    alloc_pct numeric(5,2),
    unit_purch numeric(20,10),
    unit_wthdr numeric(20,10),
    unit_bal numeric(20,10),
    fnd_purch numeric(13,2),
    fnd_wthdr numeric(13,2),
    fnd_bal numeric(13,2),
    lst_trxn_dt timestamp,
    lst_thi_num numeric(4),
    gain_los_amt numeric(13,2),
    alloc_typ varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tfund_balances (
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    eff_dt timestamp not null,
    unit_bal numeric(20,10) not null,
    crcy_code varchar(2) not null
);

CREATE TABLE IF NOT EXISTS cas.tfund_balances_bak_sg (
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    eff_dt timestamp not null,
    unit_bal numeric(20,10) not null,
    crcy_code varchar(2) not null
);

CREATE TABLE IF NOT EXISTS cas.tfund_bonuses (
    plan_code varchar(5) not null,
    plan_vers varchar(2) not null,
    crcy_code varchar(2) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    fr_eff_dt timestamp not null,
    to_eff_dt timestamp not null,
    fr_dur numeric(3) not null,
    to_dur numeric(3) not null,
    bonus_method numeric(1),
    bonus_pct numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.tfund_cas_bal (
    pol_num varchar(10),
    plan_code_base varchar(10),
    valn_dt timestamp,
    fnd_id varchar(5),
    trxn_unit numeric(20,10),
    trxn_amt numeric(20,10),
    fnd_trxn_pric numeric(20,10),
    trxn_cd varchar(8)
);

CREATE TABLE IF NOT EXISTS cas.tfund_dt_shift (
    fnd_id varchar(15) not null,
    dt_shift numeric(20)
);

CREATE TABLE IF NOT EXISTS cas.tfund_enhancement (
    enhc_code varchar(4) not null,
    enhc_basis varchar(1) not null,
    fr_dur numeric(2) not null,
    to_dur numeric(2) not null,
    enhc_pct numeric(5,2) not null,
    enhc_band_basis varchar(1) not null,
    fr_band numeric(13,2) not null,
    to_band numeric(13,2) not null
);

CREATE TABLE IF NOT EXISTS cas.tfund_extracts_sg (
    cli_num varchar(13),
    pol_num varchar(10),
    pol_num1 varchar(10),
    pol_num2 varchar(10),
    pol_num3 varchar(10),
    pol_num4 varchar(10),
    pol_num5 varchar(10),
    pol_num6 varchar(10),
    pol_num7 varchar(10),
    pol_num8 varchar(10),
    pol_num9 varchar(10),
    pol_num10 varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tfund_hist_balance (
    fnd_id varchar(5) not null,
    fnd_abbr varchar(20) not null,
    fnd_name varchar(400),
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    fname varchar(400),
    lname varchar(400),
    cli_name varchar(400),
    valn_dt timestamp not null,
    sell_pric numeric(20,10) not null,
    fnd_bal numeric(20,10),
    to_fnd_bal numeric(20,10),
    per_ind numeric(20,4),
    sum_fnd_bal numeric,
    per_sum numeric(20,4),
    numage numeric,
    sex_code varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tfund_layers (
    pol_num varchar(10) not null,
    layer_eff_dt timestamp not null,
    layer_typ varchar(1) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    prem_grp varchar(3) not null,
    fnd_bal numeric(20,10) not null,
    stat_cd varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tfund_layer_histories (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    seq_num numeric(12) not null,
    layer_eff_dt timestamp,
    layer_typ varchar(1) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    chrgable_wthdr_amt numeric(13,2),
    chrgable_chrg_amt numeric(13,2),
    nonchrgable_wthdr_amt numeric(13,2),
    chrg_pct numeric(11,8),
    fnd_trxn_pric numeric(20,10),
    prem_grp varchar(3) not null,
    fnd_bal numeric(20,10),
    undo_trxn_id varchar(15),
    trxn_dt timestamp,
    valn_dt timestamp,
    prces_dt timestamp,
    fnd_trxn_cd varchar(3),
    chrg_typ varchar(10),
    trxn_amt numeric(13,2),
    trxn_unit numeric(20,10),
    fnd_crcy_cd varchar(2),
    pol_crcy_cd varchar(2),
    fnd_crcy_amt numeric(13,2),
    user_id varchar(30),
    rel_trxn_num numeric(5),
    odr_num numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tfund_layer_prem_trxn (
    pol_num varchar(10) not null,
    layer_eff_dt timestamp not null,
    layer_typ varchar(1) not null,
    prem_amt numeric(11,2) not null,
    trxn_id varchar(15) not null,
    prem_acct varchar(8) not null
);

CREATE TABLE IF NOT EXISTS cas.tfund_mamt_allot_unit (
    trxn_dt timestamp,
    fnd_nm varchar(100),
    fnd_unit numeric(20,4)
);

CREATE TABLE IF NOT EXISTS cas.tfund_parameters (
    parm_typ varchar(30) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    eff_dt timestamp not null,
    parm_valu varchar(40),
    parm_desc varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.tfund_portfolio_detial (
    pol_num varchar(10) not null,
    cli_num varchar(13),
    cli_nm varchar(30),
    plan_code varchar(5),
    face_amt numeric(13,2),
    fnd_abbr varchar(20),
    trxn_dt timestamp,
    detial varchar(200),
    investment numeric(20,10),
    priceallocation numeric(20,10),
    unit_amnt numeric(20,10),
    valn_dt timestamp not null
);

CREATE TABLE IF NOT EXISTS cas.tfund_portfolio_summary (
    pol_num varchar(10) not null,
    cli_nm varchar(30),
    plan_code varchar(5),
    face_amt numeric(13,2),
    fnd_abbr varchar(20),
    trxn_unit numeric(20,10),
    fnd_trxn_pric numeric(20,10),
    investment numeric(20,10),
    current_prices numeric(20,10),
    invest_market_prices numeric(20,10),
    compensation numeric(20,10),
    compensation_percent numeric(20,10),
    valn_dt timestamp not null
);

CREATE TABLE IF NOT EXISTS cas.tfund_port_bal (
    fnd_hse_cd varchar(15) not null,
    unt_hldr_no varchar(15) not null,
    fnd_cd varchar(15) not null,
    unt_bal numeric(20,10),
    avl_bal_unt numeric(20,10),
    as_of_dt timestamp not null
);

CREATE TABLE IF NOT EXISTS cas.tfund_port_mapping (
    fnd_hse_cd varchar(15) not null,
    unt_hldr_no varchar(15) not null,
    plan_cd varchar(15) not null
);

CREATE TABLE IF NOT EXISTS cas.tfund_port_trxn (
    fnd_hse_cd varchar(15),
    trxn_dt timestamp,
    trxn_ref varchar(17),
    trxn_fr_br varchar(3),
    trxn_cd varchar(2),
    unt_hldr_no varchar(15),
    fnd_cd varchar(15),
    trxn_amt numeric(15,2),
    trxn_unt numeric(15,4),
    sell_typ varchar(1),
    paid_buy varchar(1),
    chq_fr_bnk varchar(3),
    chq_fr_br varchar(30),
    chq_no varchar(7),
    fee_amt numeric(12,2),
    net_trxn_amt numeric(15,2),
    net_trxn_unt numeric(15,4),
    fnd_pric numeric(9,4),
    redeem_type varchar(1),
    redm_agt_ac varchar(10),
    redm_chq_nm varchar(80),
    redm_chq_no varchar(7),
    redm_chq_typ varchar(1),
    trxn_fr varchar(1),
    eff_dt timestamp,
    arm_cd varchar(5),
    agt_order_no varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.tfund_prices (
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    valn_dt timestamp not null,
    buy_pric numeric(20,10) not null,
    sell_pric numeric(20,10) not null,
    bare_pric numeric(20,10),
    return_rate numeric(20,10),
    dividend numeric(20,10),
    status varchar(1),
    cnfrm_by varchar(30),
    cnfrm_dt timestamp,
    unit_bal numeric(20,10),
    ibf_int_rt numeric(5,2),
    fr_dt timestamp not null,
    to_dt timestamp not null,
    int_create numeric(20,10),
    fr_feed varchar(1),
    crsis_ind varchar(1),
    cnfrm_status varchar(1),
    approve_by varchar(30),
    nav_pric numeric(20,10),
    castiron_seq integer,
    castiron_flag char(1),
    percent_chg numeric
);

CREATE TABLE IF NOT EXISTS cas.tfund_prices_org (
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    valn_dt timestamp not null,
    buy_pric numeric(20,10) not null,
    sell_pric numeric(20,10) not null,
    bare_pric numeric(20,10),
    return_rate numeric(20,10),
    dividend numeric(20,10),
    status varchar(1),
    cnfrm_by varchar(30),
    cnfrm_dt timestamp,
    unit_bal numeric(20,10),
    ibf_int_rt numeric(5,2),
    fr_dt timestamp not null,
    to_dt timestamp not null,
    int_create numeric(20,10),
    fr_feed varchar(1),
    crsis_ind varchar(1),
    cnfrm_status varchar(1),
    approve_by varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.tfund_schedules (
    sch_dt timestamp not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    valn_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tfund_summary (
    pol_num varchar(10) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    fnd_strt_dt timestamp not null,
    fnd_bal numeric(20,10) not null,
    guar_int_fnd_bal numeric(11,2),
    last_fnd_mvm_dt timestamp,
    avg_fnd_valu_ratio numeric(13,2),
    loan_bal numeric(13,2),
    pol_crcy_cd varchar(2) not null,
    tot_psu_amt numeric(13,2),
    prem_grp varchar(3) not null
);

CREATE TABLE IF NOT EXISTS cas.tfund_switch_headers (
    pol_num varchar(10) not null,
    prem_grp varchar(3) not null,
    switch_mode varchar(5) not null,
    eff_dt timestamp,
    cancel_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tfund_switch_hist (
    pol_num varchar(10) not null,
    trxn_dt timestamp not null,
    shi_num numeric(4) not null,
    trxn_mode varchar(1) not null,
    prem_grp varchar(3) not null,
    rebal_ind varchar(1) not null,
    switch_mode varchar(5) not null,
    eff_dt timestamp not null,
    cancel_dt timestamp,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    req_amt numeric(17,2),
    req_pct numeric(5,2),
    req_unit numeric(20,10),
    switch_stat_cd varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tfund_switch_tri (
    pol_num varchar(10) not null,
    switch_fnd_id varchar(5) not null,
    switch_fnd_vers varchar(6) not null,
    prem_grp varchar(5) not null,
    pct numeric(5,2) not null
);

CREATE TABLE IF NOT EXISTS cas.tfund_switch_tro (
    pol_num varchar(10) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    prem_grp varchar(5) not null,
    req_amt numeric(17,2),
    req_pct numeric(5,2),
    req_unit numeric(20,10)
);

CREATE TABLE IF NOT EXISTS cas.tfund_trailers (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    trxn_dt timestamp not null,
    trxn_reasn varchar(10),
    trxn_cd varchar(10),
    trxn_seq numeric(5) not null,
    fnd_id varchar(5),
    fnd_vers varchar(6),
    as_of_dt timestamp,
    crcy_cd varchar(2),
    trxn_amt numeric(18,8),
    surr_pv_amt numeric(18,8)
);

CREATE TABLE IF NOT EXISTS cas.tfund_trailers_summary (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    trxn_dt timestamp not null,
    trxn_reasn varchar(10),
    trxn_cd varchar(10),
    trxn_seq numeric(5) not null,
    sum_type varchar(5),
    fnd_id varchar(5),
    fnd_vers varchar(6),
    as_of_dt timestamp,
    crcy_cd varchar(2),
    trxn_amt numeric(18,8),
    surr_pv_amt numeric(18,8)
);

CREATE TABLE IF NOT EXISTS cas.tfund_trxn (
    pol_num varchar(10) not null,
    cli_num varchar(13),
    plan_code varchar(5),
    vers_num varchar(2),
    cvg_eff_dt timestamp,
    fnd_id varchar(5),
    fnd_vers varchar(6),
    trxn_dt timestamp not null,
    valn_dt timestamp not null,
    user_id varchar(30) not null,
    trxn_cd varchar(8) not null,
    reasn_cd varchar(3) not null,
    fnd_trxn_cd varchar(3) not null,
    prem_acct varchar(8),
    cvg_dur numeric(3),
    mode_prem_pd numeric(13,2),
    dump_in numeric(13,2),
    init_chrg numeric(13,2),
    load_amt numeric(13,2),
    trxn_unit numeric(20,10),
    trxn_amt numeric(13,2),
    trxn_pct numeric(5,2),
    estmt_amt numeric(17,2),
    trxn_id varchar(15) not null,
    pol_crcy_cd varchar(2) not null,
    fnd_typ varchar(4),
    trxn_typ varchar(1) not null,
    chrg_typ varchar(10),
    ftr_num numeric(10) not null,
    deal_basis varchar(1),
    prem_grp varchar(3),
    surr_chrg numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tfund_trxn_del_log (
    pol_num varchar(10) not null,
    cli_num varchar(13),
    plan_code varchar(5),
    vers_num varchar(2),
    cvg_eff_dt timestamp,
    fnd_id varchar(5),
    fnd_vers varchar(6),
    trxn_dt timestamp not null,
    valn_dt timestamp not null,
    user_id varchar(30) not null,
    trxn_cd varchar(8) not null,
    reasn_cd varchar(3) not null,
    fnd_trxn_cd varchar(3) not null,
    prem_acct varchar(8),
    cvg_dur numeric(3),
    mode_prem_pd numeric(13,2),
    dump_in numeric(13,2),
    init_chrg numeric(13,2),
    load_amt numeric(13,2),
    trxn_unit numeric(20,10),
    trxn_amt numeric(13,2),
    trxn_pct numeric(5,2),
    estmt_amt numeric(13,2),
    trxn_id varchar(15) not null,
    pol_crcy_cd varchar(2) not null,
    fnd_typ varchar(4),
    trxn_typ varchar(1) not null,
    chrg_typ varchar(10),
    del_trxn_id varchar(15),
    ftr_num numeric(10) not null,
    deal_basis varchar(1),
    prem_grp varchar(3),
    surr_chrg numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tfund_trxn_histories (
    pol_num varchar(10) not null,
    cli_num varchar(13),
    plan_code varchar(5),
    vers_num varchar(2),
    cvg_eff_dt timestamp,
    fnd_id varchar(5),
    fnd_vers varchar(6),
    trxn_dt timestamp not null,
    trxn_typ varchar(1) not null,
    valn_dt timestamp not null,
    user_id varchar(30) not null,
    trxn_cd varchar(8) not null,
    reasn_cd varchar(3) not null,
    fnd_trxn_cd varchar(3) not null,
    prem_acct varchar(8),
    cvg_dur numeric(3),
    mode_prem_pd numeric(13,2),
    dump_in numeric(13,2),
    init_chrg numeric(13,2),
    load_amt numeric(13,2),
    trxn_unit numeric(20,10),
    trxn_amt numeric(13,2),
    gain_los_amt numeric(13,2),
    prces_dt timestamp,
    trxn_pct numeric(13,2),
    trxn_id varchar(15) not null,
    pol_crcy_cd varchar(2) not null,
    fnd_crcy_amt numeric(13,2),
    fnd_crcy_cd varchar(2),
    fnd_typ varchar(4),
    enhc_amt numeric(11,2),
    fnd_trxn_pric numeric(20,10),
    chrg_typ varchar(10),
    chrg_amt numeric(13,2),
    fr_fnd_bal numeric(20,10),
    to_fnd_bal numeric(20,10),
    old_trxn_id varchar(15),
    ftr_num numeric(10) not null,
    fr_loan_bal numeric(13,2),
    to_loan_bal numeric(13,2),
    deal_basis varchar(1),
    self_gen_ind varchar(1),
    gain_los_proc_dt timestamp,
    fr_comp_fnd_bal numeric(20,10),
    to_comp_fnd_bal numeric(20,10),
    req_trxn_amt numeric(13,2),
    req_trxn_pct numeric(13,2),
    req_trxn_unit numeric(20,10),
    odr_num numeric(3),
    prem_grp varchar(3),
    undo_trxn_id varchar(15),
    gain_los_crcy numeric(13,2),
    surr_cost_amt numeric(13,2),
    pl_amt numeric(13,2),
    surr_chrg numeric(13,2),
    chk_initial numeric(1) default 1
);

CREATE TABLE IF NOT EXISTS cas.tfund_trxn_hist_sg (
    crcy_code varchar(2) not null,
    pol_num varchar(10) not null,
    trxn_num numeric(8) not null,
    plan_num numeric(2),
    plan_code varchar(6),
    plan_name varchar(40),
    cvg_eff_dt timestamp,
    fnd_code varchar(4),
    fnd_name varchar(40),
    fnd_trxn_typ varchar(4),
    fnd_trxn_desc varchar(30),
    prem_amt numeric(10,2),
    valn_dt timestamp,
    proc_order numeric(3),
    fnd_price_typ varchar(5),
    fnd_trxn_pric numeric(9,4),
    trxn_amt numeric(11,2),
    trxn_unit numeric(12,4),
    fin_cyc varchar(10),
    mvy_ded_dt timestamp,
    fr_fnd_bal numeric(12,4),
    to_fnd_bal numeric(12,4),
    created_by varchar(6),
    date_created timestamp
);

CREATE TABLE IF NOT EXISTS cas.tfund_trxn_rules (
    fnd_trxn_cd varchar(3) not null,
    trxn_typ varchar(1) not null,
    pric_ind varchar(1) not null,
    bonus_ind varchar(1) not null,
    buy_sell_diff_ind varchar(1) not null,
    alloc_typ varchar(1) not null,
    xtra_prces varchar(30),
    sign char(1) not null,
    chrg_cat varchar(10),
    min_trxn_amt numeric(13,2),
    crcy_cd varchar(2),
    xhst_fnd_act varchar(1),
    plan_grp_nm varchar(20) default '*' not null,
    fnd_lyr_ded_seq varchar(5),
    fnd_surr_rule varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.tfund_trxn_validation (
    chrg_cat varchar(10) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    fnd_crcy varchar(2) not null,
    plan_code varchar(5) not null,
    plan_vers varchar(2) not null,
    plan_crcy varchar(2) not null,
    fnd_trxn_unit varchar(2) not null,
    min_pre_bal numeric(20,10) not null
);

CREATE TABLE IF NOT EXISTS cas.tgiro (
    bank_cde varchar(10),
    bank_acct_num varchar(20),
    ins_nm varchar(20),
    dscnt_prem numeric(10,2),
    pol_num varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tgiro_frozen_pol_sg (
    pol_num varchar(10),
    run_date timestamp
);

CREATE TABLE IF NOT EXISTS cas.tgiro_mult_factor_sg (
    sysdate_ddmm varchar(4),
    mult_factor varchar(4)
);

CREATE TABLE IF NOT EXISTS cas.tgiro_return_man (
    pol_num varchar(17),
    man_num varchar(12),
    result_cd varchar(3),
    trxn_amt numeric
);

CREATE TABLE IF NOT EXISTS cas.tglobal_var (
    var_name varchar(50) not null,
    var_desc varchar(200)
);

CREATE TABLE IF NOT EXISTS cas.thash_total_check (
    table_name varchar(30),
    column_var_1 varchar(6),
    column_var_2 varchar(6),
    column_var_3 varchar(6),
    column_var_4 varchar(6),
    column_var_5 varchar(6),
    column_var_6 varchar(6),
    column_var_7 varchar(6),
    column_var_8 varchar(6),
    column_var_9 varchar(6),
    column_var_10 varchar(10),
    column_var_11 varchar(10),
    column_var_12 varchar(15),
    column_var_13 varchar(15),
    column_var_14 varchar(6),
    column_var_15 varchar(6),
    column_var_16 varchar(6),
    column_var_17 varchar(6),
    column_var_18 varchar(6),
    column_var_19 varchar(6),
    column_var_20 varchar(6),
    column_var_21 varchar(6),
    column_var_22 varchar(6),
    column_var_23 varchar(6),
    column_var_24 varchar(6),
    column_var_25 varchar(6),
    column_num_1 numeric(14,7),
    column_num_2 numeric(20,7),
    column_num_3 numeric(20,7),
    column_num_4 numeric(14,7),
    column_num_5 numeric(14,7),
    column_num_6 numeric(14,7),
    column_num_7 numeric(14,7),
    column_num_8 numeric(14,7),
    column_num_9 numeric(14,7),
    column_num_10 numeric(14,7),
    column_num_11 numeric(14,7),
    column_num_12 numeric(14,7),
    column_num_13 numeric(14,7),
    column_num_14 numeric(14,7),
    column_num_15 numeric(14,7)
);

CREATE TABLE IF NOT EXISTS cas.tholidays (
    holiday timestamp not null,
    type varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.thosp_benefit (
    benefit_id varchar(10),
    sort_seq numeric,
    benefit_desc1 varchar(50),
    benefit_desc2 varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.thosp_benefit_dtls (
    benefit_id varchar(10),
    class_code varchar(2),
    crcy_code varchar(2),
    max_benefit_amt numeric
);

CREATE TABLE IF NOT EXISTS cas.thosp_health_care_th (
    hosp_seq numeric(4) not null,
    area_cd varchar(1),
    region_cd varchar(1),
    province varchar(50),
    hosp_name varchar(100) not null,
    hosp_tel varchar(50),
    create_dt timestamp,
    amend_dt timestamp,
    user_id varchar(30),
    stat_cd varchar(1),
    page numeric(2)
);

CREATE TABLE IF NOT EXISTS cas.thouse_keeping_ctl (
    table_name varchar(120) not null,
    date_column varchar(50),
    ret_prd numeric(3) not null,
    gen_script_ind varchar(1),
    sql_script varchar(500) not null,
    del_seq numeric(4)
);

CREATE TABLE IF NOT EXISTS cas.ti01_coverage_dscnt_th (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    eff_avy_yr numeric(3),
    dscnt_typ varchar(1),
    dscnt_rt numeric(7,4),
    dscnt_sta varchar(1),
    date_crt timestamp,
    usr_crt varchar(30),
    date_amd timestamp,
    usr_amd varchar(30),
    to_avy_yr numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.ti0q_temp_receipt (
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp,
    temp_receipt_num varchar(10) not null,
    cover_branch_cd varchar(5),
    withdraw_date timestamp,
    cover_rcv_date timestamp,
    cover_agt_cd varchar(6),
    agt_rcv_date timestamp,
    acc_rcv_date timestamp,
    usr_branch_cd varchar(5),
    usr_agt_cd varchar(6),
    rcv_amt numeric(11,2),
    rcv_amt_date timestamp,
    reason_cd varchar(2),
    remarks varchar(40),
    agt_short_nm varchar(6),
    unit_short_nm varchar(6),
    chk_date timestamp,
    usr_branch varchar(30),
    date_branch timestamp,
    expiry_dt timestamp,
    withdraw_no varchar(20),
    request_dt timestamp,
    withdraw_name varchar(60),
    submission_no varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.ti0q_temp_receipt_hist (
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp,
    temp_receipt_num varchar(10) not null,
    cover_branch_cd varchar(5),
    withdraw_date timestamp,
    cover_rcv_date timestamp,
    cover_agt_cd varchar(6),
    agt_rcv_date timestamp,
    acc_rcv_date timestamp,
    usr_branch_cd varchar(5),
    usr_agt_cd varchar(6),
    rcv_amt numeric(11,2),
    rcv_amt_date timestamp,
    reason_cd varchar(2),
    remarks varchar(40),
    agt_short_nm varchar(6),
    unit_short_nm varchar(6),
    chk_date timestamp,
    usr_branch varchar(30),
    date_branch timestamp
);

CREATE TABLE IF NOT EXISTS cas.ti11_temp_hdr (
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp,
    btch_num varchar(20) not null,
    btch_role varchar(2) not null,
    pol_num varchar(10) not null,
    temp_receipt_num varchar(10),
    temp_receipt_date timestamp,
    cbd_num numeric not null,
    trxn_dt timestamp not null
);

CREATE TABLE IF NOT EXISTS cas.ti11_trxn_hist (
    usr_crt varchar(6),
    date_crt timestamp,
    usr_amd varchar(6),
    date_amd timestamp,
    trxn_num numeric(10) not null,
    temp_num varchar(10),
    temp_date timestamp,
    prem_receipt_num numeric(10),
    other_receipt_num numeric(10),
    trxn_num_of_receipt numeric(10)
);

CREATE TABLE IF NOT EXISTS cas.ti40_lia_th (
    ref_num numeric(10) not null,
    comp_code numeric(2) not null,
    title_name varchar(15),
    first_name varchar(25),
    mid_name varchar(30),
    alias_name varchar(30),
    sex_code varchar(1),
    birth_dt numeric(8),
    th_id varchar(13),
    pol_num varchar(20),
    result_cd varchar(10),
    reqst_cd varchar(30),
    app_dt numeric(8),
    remarks varchar(100),
    update_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.ti41_mib_ext_db (
    ref_num numeric(10),
    comp_code numeric(2),
    title_name varchar(15),
    first_name varchar(25),
    mid_name varchar(30),
    alias_name varchar(30),
    sex_code varchar(1),
    birth_dt numeric(8),
    th_id varchar(13),
    pol_num varchar(20),
    result_cd varchar(10),
    reqst_cd varchar(30),
    app_dt numeric(8),
    remarks varchar(100),
    update_ind varchar(1),
    update_by varchar(1),
    update_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tibs_claim_th (
    claim_refer_code_of_company varchar(50),
    claim_transaction_status varchar(1),
    claim_company_id varchar(4),
    claim_pol_id varchar(30),
    claim_pol_refer_code_of_compan varchar(50),
    claim_id varchar(30),
    claim_no varchar(200),
    claim_type varchar(20),
    claim_pol_type varchar(20),
    claim_incurred_date varchar(30),
    claim_report_date varchar(30),
    claim_notify_date varchar(30),
    claim_discharge_date varchar(30),
    claim_hospital_id varchar(20),
    claim_hospital_name varchar(200),
    claim_doctor_name varchar(200),
    claim_completion_date varchar(30),
    claim_close_date varchar(30),
    claim_status varchar(20),
    claim_reject_reason varchar(20),
    claim_document_link varchar(500),
    claim_causes_of_death varchar(20),
    claim_oic_case_id varchar(10),
    claim_oic_case_detail varchar(500),
    claim_request_channel varchar(500),
    claim_insrd_ids varchar(500),
    claim_icd_10_codes varchar(500),
    claim_icd_9_codes varchar(500),
    claim_coverage_code varchar(200),
    claim_coverage_detail varchar(200),
    claim_sum_insured_per_cover_y numeric,
    claim_sum_insured_per_cover_t numeric,
    claim_coverage_amt numeric,
    claim_deductible_amt numeric,
    claim_amount numeric,
    claim_pol_coverage_detail_s2 varchar(20),
    claim_pol_coverage_detail_s2_a numeric,
    claim_estimate_seq numeric,
    claim_estimate_date varchar(30),
    claim_estimate_amount numeric,
    claim_payment_id varchar(50),
    claim_payment_type varchar(20),
    claim_payment_term numeric,
    claim_payment_term_paid numeric,
    claim_payment_channel varchar(20),
    claim_payment_date varchar(30),
    claim_payment_account_date varchar(30),
    claim_payment_invoice_amt numeric,
    claim_payment_amt numeric,
    claim_payment_other_invoice_a numeric,
    claim_payment_beneficiary_name varchar(80),
    date_cr timestamp,
    request_id numeric(10)
);

CREATE TABLE IF NOT EXISTS cas.tibs_master_coverage_code (
    cvg_typ varchar(1) not null,
    plan_code varchar(5) not null,
    vers_num char(1),
    cov_code char(20),
    cov_detail char(200),
    cov_amt numeric(15,2),
    benefit_id varchar(10),
    sum_per_year numeric(15,2),
    sum_per_time numeric(15,2),
    number_day numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tibs_payment_th (
    pmt_refer_code_of_company varchar(50),
    pmt_transaction_status varchar(1),
    pmt_company_id varchar(4),
    pmt_pol_id varchar(30),
    pmt_pol_refer_code_of_company varchar(50),
    pmt_id varchar(30),
    pmt_type varchar(20),
    pmt_direct_premium varchar(20),
    pmt_premium_payment_period_yea numeric,
    pmt_premium_payment_year numeric,
    pmt_payment_period varchar(20),
    pmt_prd_premium_seq numeric,
    pmt_prd_premium_outstanding_pa numeric,
    pmt_prd_premium_amount numeric,
    pmt_prd_premium_amount_tax numeric,
    pmt_prd_premium_amount_life numeric,
    pmt_prd_premium_amt_saving numeric,
    pmt_prd_premium_amt_investment numeric,
    pmt_prd_premium_amount_other numeric,
    pmt_prd_premium_amount_com numeric,
    pmt_prd_premium_amt_interest numeric,
    pmt_prd_premium_date varchar(30),
    pmt_prd_premium_due_date varchar(30),
    pmt_prd_premium_temp_receipt_d varchar(30),
    pmt_prd_premium_receipt_date varchar(30),
    pmt_prd_premium_temp_receipt_n varchar(30),
    pmt_prd_premium_receipt_number varchar(30),
    pmt_prd_premium_channel varchar(30),
    pmt_prd_premium_channel_detail varchar(200),
    pmt_premium_rid_number varchar(200),
    pmt_premium_rid_amount numeric,
    pmt_premium_edm_number varchar(200),
    pmt_premium_edm_amount numeric,
    date_cr timestamp,
    request_id numeric(10)
);

CREATE TABLE IF NOT EXISTS cas.tibs_policy_th (
    pol_refer_code_of_company varchar(50),
    pol_transaction_status varchar(1),
    pol_company_id varchar(4),
    pol_id varchar(30),
    pol_type varchar(20),
    pol_type_gli_name numeric,
    pol_type_gli_plan numeric,
    pol_product_type varchar(20),
    pol_product_type_other_detail varchar(50),
    pol_type_2 varchar(20),
    pol_sub_type varchar(50),
    pol_name varchar(150),
    pol_name_oic varchar(150),
    pol_start_date varchar(30),
    pol_end_date varchar(30),
    pol_claim_document varchar(500),
    pol_payment_term varchar(100),
    pol_payment_amount numeric,
    pol_payment_period varchar(20),
    pol_info_url varchar(500),
    pol_claim_url varchar(500),
    pol_document_urls varchar(500),
    pol_year numeric,
    pol_status varchar(20),
    pol_status_note varchar(500),
    pol_status_date varchar(30),
    pol_expropriation_value numeric,
    pol_immediate_refund numeric,
    pol_sale_date varchar(30),
    pol_transaction_date varchar(30),
    pol_approved_date varchar(30),
    pol_issue_date varchar(30),
    pol_account_date varchar(30),
    pol_agree_date varchar(30),
    pol_distribution varchar(20),
    pol_distribution_other_detail varchar(50),
    pol_license varchar(20),
    pol_re_insured_contact_number varchar(50),
    pol_life_detail varchar(2000),
    cust_type varchar(20),
    cust_type_other_detail varchar(50),
    cust_id_type varchar(20),
    cust_id varchar(20),
    cust_company_name varchar(80),
    cust_first_name varchar(80),
    cust_last_name varchar(80),
    cust_age numeric,
    cust_birthday varchar(30),
    cust_gender varchar(20),
    cust_address varchar(500),
    cust_sub_district varchar(2),
    cust_district varchar(2),
    cust_province varchar(2),
    cust_zip_code varchar(50),
    cust_country_code varchar(20),
    cust_phone_number varchar(100),
    cust_mobile_number varchar(100),
    cust_email varchar(50),
    cust_issued_age numeric,
    cust_race varchar(30),
    cust_nationality varchar(30),
    cust_religion varchar(30),
    cust_occupation_level varchar(20),
    cust_occupation_level_other_de varchar(50),
    cust_occupation varchar(500),
    cust_job varchar(50),
    cust_position varchar(30),
    cust_business_type varchar(50),
    cust_income_per_year numeric,
    cust_us_person varchar(1),
    cust_us_person_born varchar(1),
    cust_us_person_green_card varchar(1),
    cust_us_person_vat varchar(1),
    cust_us_person_183 varchar(1),
    cust_address_permanent varchar(500),
    cust_sub_district_permanent varchar(2),
    cust_district_permanent varchar(2),
    cust_province_permanent varchar(2),
    cust_address_work varchar(500),
    cust_sub_district_work varchar(2),
    cust_district_work varchar(2),
    cust_province_work varchar(2),
    cust_address_current varchar(500),
    cust_sub_district_current varchar(2),
    cust_district_current varchar(2),
    cust_province_current varchar(2),
    insrd_cov_plan_seq numeric,
    insrd_seq numeric,
    insrd_type varchar(20),
    insrd_id_type varchar(20),
    insrd_id varchar(50),
    insrd_first_name varchar(80),
    insrd_last_name varchar(80),
    insrd_age numeric,
    insrd_birthday varchar(30),
    insrd_gender varchar(20),
    insrd_address varchar(500),
    insrd_sub_district varchar(2),
    insrd_district varchar(2),
    insrd_province varchar(2),
    insrd_zip_code varchar(50),
    insrd_country_code varchar(20),
    insrd_phone_number varchar(100),
    insrd_mobile_number varchar(100),
    insrd_email varchar(50),
    insrd_issued_age numeric,
    insrd_race varchar(30),
    insrd_nationality varchar(30),
    insrd_religion varchar(30),
    insrd_occupation_level varchar(20),
    insrd_occupation_level_other_d varchar(50),
    insrd_occupation varchar(500),
    insrd_job varchar(50),
    insrd_position varchar(30),
    insrd_business_type varchar(50),
    insrd_income_per_year numeric,
    insrd_pol_sub_ids varchar(80),
    insrd_beneficiary_seq_no numeric,
    insrd_beneficiary_name varchar(80),
    insrd_beneficiary_relation varchar(20),
    insrd_beneficiary_relation_oth varchar(50),
    insrd_benefit_ratio numeric,
    sub_pol_id varchar(80),
    sub_pol_type varchar(20),
    sub_pol_ppt varchar(50),
    sub_pol_start_date varchar(30),
    sub_pol_end_date varchar(30),
    sub_pol_sum_insured_per_year_e numeric,
    sub_pol_sum_insured_per_year_i numeric,
    cov_plan_seq numeric,
    cov_plan_name varchar(80),
    cov_plan_sum_insured numeric,
    cov_plan_maturity_benefit numeric,
    cov_plan_survival_benefit_min numeric,
    cov_plan_survival_benefit_max numeric,
    cov_plan_cov_code varchar(20),
    cov_plan_cov_detail varchar(200),
    cov_plan_cov_amt numeric,
    cov_plan_cov_sum_insured_per_y numeric,
    cov_plan_cov_sum_insured_per_t numeric,
    cov_plan_cov_co_payment numeric,
    cov_plan_cov_deductible_amount numeric,
    cov_plan_cov_deductible_detail varchar(200),
    cov_plan_cov_number_of_day numeric,
    cov_plan_cov_cover_year numeric,
    cov_plan_cov_payment_year numeric,
    cov_plan_cov_claim_status varchar(20),
    cov_code varchar(20),
    cov_detail varchar(200),
    cov_amt numeric,
    cov_sum_insured_per_coverage_y numeric,
    cov_sum_insured_per_coverage_t numeric,
    cov_co_payment numeric,
    cov_deductible_amount numeric,
    cov_deductible_detail varchar(200),
    cov_number_of_day numeric,
    cov_cover_year numeric,
    cov_payment_year numeric,
    cov_claim_status varchar(20),
    beneficiary_seq_no numeric,
    beneficiary_name varchar(80),
    beneficiary_relation varchar(20),
    beneficiary_relation_other_det varchar(50),
    benefit_ratio numeric,
    endorse_id varchar(30),
    endorse_type_1 varchar(20),
    endorse_type_2 varchar(20),
    endorse_sub_pol_id varchar(80),
    endorse_detail varchar(200),
    endorse_status varchar(30),
    loan_id varchar(30),
    loan_type varchar(20),
    loan_date varchar(30),
    loan_interest_rate numeric,
    loan_amount numeric,
    loan_interest_amount numeric,
    loan_status varchar(20),
    loan_payment_id varchar(30),
    loan_payment_date varchar(30),
    loan_payment_amount numeric,
    loan_payment_interest numeric,
    loan_payment_principal numeric,
    inv_transaction_date varchar(30),
    inv_transaction_type varchar(20),
    inv_fund_code varchar(30),
    inv_fund_unit numeric,
    inv_fund_nav numeric,
    inv_fund_thai_name varchar(60),
    inv_fund_eng_name varchar(60),
    inv_fund_type varchar(60),
    inv_fund_amc varchar(60),
    inv_fund_data_status varchar(20),
    date_cr timestamp,
    request_id numeric(10),
    renewal varchar(20),
    renewal_pol_id varchar(20),
    standard_risk varchar(20),
    medical varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.timage2_sg (
    seq_num numeric not null,
    fcn_id varchar(20),
    pol_num varchar(10),
    date_created timestamp,
    report_dt timestamp,
    path varchar(50),
    fil_nm varchar(50),
    version varchar(5),
    agt_code varchar(6),
    br_cd varchar(5),
    unit_cd varchar(5),
    rank_cd varchar(5),
    aws_post_ind varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.timage_gen_ctl_sg (
    run_date timestamp,
    job_status varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.timage_mvmt_log_sg (
    mvmt_seq_no numeric not null,
    mvmt_dt timestamp,
    user_id varchar(30),
    src_path varchar(100),
    src_fil_nm varchar(100),
    dest_path varchar(100),
    dest_fil_nm varchar(100),
    img_seq_no numeric,
    remarks varchar(100)
);

CREATE TABLE IF NOT EXISTS cas.timage_track_hist_sg (
    fcn_id varchar(20),
    fcn_vers varchar(2),
    pol_num varchar(10),
    sa_cd_1 varchar(6),
    sa_cd_2 varchar(6),
    ca_cd_1 varchar(6),
    ca_cd_2 varchar(6),
    wa_cd_1 varchar(6),
    wa_cd_2 varchar(6),
    ins_cli_num varchar(10),
    own_cli_num varchar(10),
    payor_cli_num varchar(10),
    cas_dt timestamp,
    dept varchar(10),
    gen_dt timestamp,
    path varchar(50),
    fil_nm varchar(50),
    version varchar(5),
    file_status varchar(2),
    request_id numeric(10),
    seq_num numeric not null,
    carton_num varchar(15)
);

CREATE TABLE IF NOT EXISTS cas.timg_access_sg (
    img_typ varchar(30) not null,
    profile_id varchar(30) not null
);

CREATE TABLE IF NOT EXISTS cas.timg_carton_detail_sg (
    carton_num varchar(15) not null,
    pol_num_from varchar(10) not null,
    pol_num_to varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.timg_carton_header_sg (
    carton_num varchar(15) not null,
    send_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tinsure_type (
    ins_typ varchar(1) not null,
    ins_typ_desc varchar(50) not null,
    face_amt_disp varchar(1),
    wait_perd numeric(3),
    wait_perd_unit varchar(2),
    max_bnft_perd numeric(3),
    max_bnft_perd_unit varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tinterest_rates (
    int_rt_typ varchar(1) not null,
    eff_dt timestamp not null,
    int_rt numeric(7,5) not null,
    plan_code varchar(5) not null,
    int_calc_mthd varchar(1),
    plan_grp_nm varchar(20) default '*' not null,
    user_id varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.tinvestment_days (
    run_dt timestamp not null,
    fr_dt timestamp not null,
    to_dt timestamp not null,
    fnd_id varchar(5),
    fnd_vers varchar(6),
    buy_in_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tinvoices_tmp (
    tdate timestamp,
    r_num numeric(5),
    serial_no varchar(9)
);

CREATE TABLE IF NOT EXISTS cas.tipo_assoc_plans (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    eff_dur numeric(3) not null,
    assoc_plan_code varchar(5) not null,
    crcy_code varchar(2) default '*' not null
);

CREATE TABLE IF NOT EXISTS cas.ti_control (
    trxn_seq_no numeric(5) not null,
    process varchar(20) not null,
    pol_num varchar(10),
    btch_num varchar(3),
    start_date timestamp,
    end_date timestamp,
    process_stat_cd varchar(1),
    result varchar(1),
    mode_prem numeric(11,2),
    mpre numeric(11,2),
    cas_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.ti_dda_return_files (
    seq_num numeric(10) not null,
    return_dt timestamp not null,
    pol_num varchar(8) not null,
    bank_cd varchar(3) not null,
    branch_cd varchar(3) not null,
    bank_acct_num varchar(9) not null,
    bank_acct_nm varchar(20) not null,
    eff_date timestamp not null,
    cancel_dt timestamp,
    cancel_cd varchar(2) not null,
    update_master_ind varchar(1) not null,
    verify_stat_cd varchar(2) not null,
    real_pol_num varchar(10),
    header_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.ti_err_msg (
    trxn_seq_no numeric(5) not null,
    msg_seq_no numeric(5) not null,
    process varchar(20) not null,
    pol_num varchar(10),
    btch_num varchar(3),
    msg_typ varchar(1),
    err_msg varchar(200),
    last_update_date timestamp
);

CREATE TABLE IF NOT EXISTS cas.ti_vpa_cash_flow_dtls (
    text varchar(600),
    seq_no numeric,
    request_id numeric,
    valn_dt timestamp,
    file_typ varchar(3),
    crcy_cd varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.ti_vpa_cash_flow_mst (
    file_nm varchar(50),
    request_id numeric,
    valn_dt timestamp,
    prn_ind varchar(1),
    file_typ varchar(3),
    crcy_cd varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.ti_vpa_est_cash_flow_dtls (
    text varchar(600),
    seq_no numeric,
    request_id numeric,
    valn_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.ti_vpa_est_cash_flow_mst (
    file_nm varchar(50),
    request_id numeric,
    valn_dt timestamp,
    prn_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.ti_vpa_unit_prices_feed (
    vpa_unit_price varchar(240) not null
);

CREATE TABLE IF NOT EXISTS cas.tji_alpha_search_param_src (
    terr_cd varchar(2) not null,
    app_typ varchar(10) not null,
    tmp_tbl_nm varchar(500) not null,
    tmp_fld_nm varchar(500) not null,
    ref_fld varchar(500) not null,
    ref_src varchar(500) not null,
    ref_id_fld varchar(500) not null,
    data_typ varchar(10) not null
);

CREATE TABLE IF NOT EXISTS cas.tji_app_info (
    terr_cd varchar(2) not null,
    pol_num varchar(50) not null,
    app_typ varchar(10) not null,
    quota_num varchar(10),
    fcn_typ varchar(1) not null,
    fld_nm varchar(6) not null,
    fld_seq numeric default 1 not null,
    ref_fld_nm varchar(3),
    fld_valu varchar(255),
    fld_attrib varchar(6),
    cli_num numeric(12),
    fld_valu_user varchar(255)
);

CREATE TABLE IF NOT EXISTS cas.tji_config (
    terr_cd varchar(2) not null,
    config_typ varchar(2) not null,
    config_id varchar(10) not null,
    config_desc varchar(255),
    config_desc_eng varchar(255),
    attrib_main varchar(255),
    attrib_sub varchar(255),
    attrib_minor varchar(255),
    attrib_num numeric(21,13),
    attrib_num_sub numeric(21,13),
    major_limit_fld_nm varchar(6),
    minor_limit_fld_nm varchar(3),
    incmplt_cd varchar(2),
    pend_cd varchar(2),
    fltr_fld_nm varchar(3),
    all_ind varchar(1),
    dflt_ind varchar(1),
    rec_stat varchar(1),
    err_cd varchar(6),
    attrib_option varchar(255),
    attrib_ref varchar(255),
    attrib_supp varchar(255),
    attrib_lov varchar(255),
    attrib_ovr_opt varchar(1),
    attrib_ovr_supp varchar(255),
    ret_valu_fld_nm varchar(255),
    attrib_ref_supp varchar(255),
    pol_link_typ varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tji_uw_results (
    terr_cd varchar(2) not null,
    pol_num varchar(50) not null,
    app_typ varchar(10) not null,
    quota_num varchar(10),
    fcn_typ varchar(1) not null,
    src_cd varchar(6) not null,
    incmplt_cd varchar(2),
    pend_cd varchar(2),
    err_cd varchar(6),
    medic_cd varchar(10),
    reply_day numeric(4),
    err_desc varchar(255),
    err_desc_eng varchar(255),
    uw_ind varchar(1),
    supp_msg1 varchar(2500),
    supp_msg2 varchar(1000),
    supp_msg3 varchar(500),
    supp_msg4 varchar(500)
);

CREATE TABLE IF NOT EXISTS cas.tji_zap_exchange_rate (
    terr_cd varchar(2) not null,
    fm_crcy_code varchar(2) not null,
    to_crcy_code varchar(2) not null,
    eff_date_char varchar(10) not null,
    ex_rate numeric(21,13)
);

CREATE TABLE IF NOT EXISTS cas.tji_zap_fcn (
    terr_cd varchar(2) not null,
    fcn_cd varchar(6) not null,
    fcn_sql varchar(500),
    rec_stat varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tji_zap_fcn_value_map (
    terr_cd varchar(2) not null,
    fcn_typ varchar(1) not null,
    fcn_cd varchar(6) not null,
    valu_typ varchar(2) not null,
    valu_domain varchar(6) not null
);

CREATE TABLE IF NOT EXISTS cas.tji_zap_filter (
    terr_cd varchar(2) not null,
    zap_id varchar(6) not null,
    app_typ varchar(10) not null,
    spec_app_typ varchar(10) default '*' not null,
    fltr_id varchar(6) not null,
    fld_nm varchar(6) not null,
    valu_typ varchar(2) not null,
    valu_domain varchar(6) not null,
    rpt_exist_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tji_zap_jobs (
    terr_cd varchar(2) not null,
    pol_num varchar(50) not null,
    app_typ varchar(10) not null,
    quota_num varchar(10),
    run_dt timestamp,
    complete_dt timestamp,
    zap_cd varchar(1),
    medic_cd varchar(10),
    incmplt_cd varchar(2),
    pend_cd varchar(2),
    temp_app_typ varchar(10),
    temp_ind varchar(1),
    crcy_code varchar(2),
    uwg_clas varchar(30),
    spec_ind varchar(1),
    spec_app_typ varchar(10),
    supp_msg1 varchar(2500),
    supp_msg2 varchar(1000),
    supp_msg3 varchar(500),
    supp_msg4 varchar(500),
    guarantee_ind varchar(1),
    payor_medic_cd varchar(10),
    spouse_medic_cd varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tji_zap_log (
    log_num varchar(20) not null,
    log_date timestamp not null,
    log_seq numeric not null,
    log_msg varchar(4000)
);

CREATE TABLE IF NOT EXISTS cas.tji_zap_master (
    terr_cd varchar(3) not null,
    zap_id varchar(6) not null,
    app_typ varchar(10) not null,
    fcn_typ varchar(1) not null,
    fcn_cd varchar(6) not null,
    seq numeric(8) not null,
    fcn_option varchar(1),
    pend_cd varchar(2),
    err_cd varchar(6),
    incmplt_cd varchar(2),
    reply_day numeric(4),
    disp_seq numeric(8),
    spec_app_typ varchar(10) default '*' not null
);

CREATE TABLE IF NOT EXISTS cas.tji_zap_param_src (
    terr_cd varchar(2) not null,
    app_typ varchar(10) not null,
    fld_nm varchar(6) not null,
    ref_expr varchar(255) not null,
    ref_fld varchar(255) not null,
    ref_src varchar(255) not null,
    ref_id_fld varchar(255) not null,
    unit varchar(100),
    fld_seq numeric(2) not null
);

CREATE TABLE IF NOT EXISTS cas.tji_zap_qtn (
    terr_cd varchar(2) not null,
    qtn_cd varchar(6) not null,
    fld_nm varchar(3),
    qtn_desc varchar(255),
    qtn_desc_eng varchar(255),
    dflt_valu varchar(255),
    valu_typ varchar(1),
    valid_typ varchar(1),
    valid_fcn_cd varchar(6),
    rec_stat varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tji_zap_qtn_excld_sg (
    client_typ varchar(10) not null,
    spec_app_typ varchar(10) not null,
    qtn_cd varchar(6) not null,
    status varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tji_zap_values (
    terr_cd varchar(2) not null,
    app_typ varchar(10) default 'NB' not null,
    crcy_code varchar(2) not null,
    valu_typ varchar(2) not null,
    valu_domain varchar(6) not null,
    fltr_valu varchar(10) not null,
    valu_cd varchar(10) not null,
    valu_value varchar(255),
    valu_desc varchar(255),
    valu_desc_eng varchar(255),
    major_lower_limit varchar(255),
    major_include_lower varchar(1),
    major_upper_limit varchar(255),
    major_include_upper varchar(1),
    minor_lower_limit varchar(255),
    minor_include_lower varchar(1),
    minor_upper_limit varchar(255),
    minor_include_upper varchar(1),
    incmplt_cd varchar(2),
    pend_cd varchar(2),
    reply_day numeric(4),
    zap_cd varchar(1),
    include_ind varchar(1),
    ret_valu varchar(255),
    supp_msg1 varchar(2500),
    supp_msg2 varchar(1000),
    supp_msg3 varchar(500),
    supp_msg4 varchar(500)
);

CREATE TABLE IF NOT EXISTS cas.tjob_date_masters (
    job_run_dt timestamp not null,
    sch_nm varchar(30) not null,
    sch_fr_dt timestamp,
    sch_to_dt timestamp,
    app_cd varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tjob_dpnds (
    job_nm varchar(30) not null,
    dpnd_job_nm varchar(30) not null,
    app_cd varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tjob_dtls (
    job_nm varchar(30) not null,
    job_desc varchar(100),
    job_typ varchar(1) not null,
    script_nm varchar(50) not null,
    job_run_ind varchar(1) not null,
    job_status varchar(1) not null,
    job_seq numeric(5) not null,
    app_cd varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tjob_logs (
    trxn_dt timestamp not null,
    job_nm varchar(30) not null,
    job_run_ind varchar(1),
    job_status varchar(1),
    job_strt_time timestamp,
    requester varchar(30),
    app_cd varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tjob_schedules (
    sch_nm varchar(30) not null,
    job_nm varchar(30) not null,
    seq_num numeric(5) not null,
    app_cd varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tlayers_bf_re (
    pol_num varchar(10) not null,
    layer_eff_dt timestamp not null,
    layer_typ varchar(1) not null,
    layer_stat_cd varchar(1),
    mpre numeric(11,2),
    xces_prem numeric(11,2),
    layer_trmn_dt timestamp,
    tot_prem_pd numeric(11,2),
    mpre_pd numeric(11,2),
    last_ryc_dt timestamp,
    mpre_rc_ind varchar(1),
    layer_prem_amt numeric(11,2),
    hwm_ann numeric(11,2),
    hwm_ann_xpry_dt timestamp,
    pd_to_dt timestamp,
    partial_pay_amt numeric(11,2),
    layer_prem_pct numeric(5,2),
    surr_chrg_pd numeric(13,2),
    asof_tot_prem_pd numeric(11,2),
    orig_mpre numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tlayer_premium_transactions (
    pol_num varchar(10) not null,
    layer_eff_dt timestamp not null,
    layer_typ varchar(1) not null,
    prem_amt numeric(11,2) not null,
    trxn_id varchar(15) not null,
    crcy_code varchar(2) not null
);

CREATE TABLE IF NOT EXISTS cas.tlayer_prem_histories (
    pol_num varchar(10) not null,
    layer_eff_dt timestamp not null,
    layer_prem_amt numeric(13,2),
    eff_dt timestamp not null,
    trxn_dt timestamp,
    layer_typ varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tla_collect_refund_hist_sg (
    pol_num varchar(10),
    eff_dt timestamp,
    rcpt_desc varchar(20),
    rcpt_amt numeric(20,10),
    rcpt_typ varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tla_fund_summary_sg (
    pol_num varchar(10),
    fnd_id varchar(5),
    unt_typ varchar(1),
    fnd_bal numeric(20,10)
);

CREATE TABLE IF NOT EXISTS cas.tla_fund_trxn_histories_sg (
    pol_num varchar(10) not null,
    trxn_num numeric(5),
    trxn_dt timestamp,
    fnd_id varchar(5),
    unt_typ varchar(1),
    unt_ind varchar(1),
    fnd_unit numeric(20,10),
    price_dt timestamp,
    monies_dt timestamp,
    price_used numeric(20,10),
    fnd_amt numeric(13,2),
    trxn_code varchar(4),
    cvg_code varchar(5),
    plan_code varchar(5),
    glacct varchar(14)
);

CREATE TABLE IF NOT EXISTS cas.tla_trxn_histories (
    pol_num varchar(8) not null,
    trxn_num numeric(5) not null,
    trxn_dt timestamp not null,
    trxn_time numeric(6) not null,
    eff_dt timestamp,
    trxn_cd varchar(4),
    trxn_desc varchar(40),
    validflag varchar(1),
    trxn_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tla_trxn_histories_b4la (
    pol_num varchar(8) not null,
    trxn_num varchar(4) not null,
    trxn_dt timestamp not null,
    trxn_time numeric(6) not null,
    eff_dt timestamp,
    trxn_cd varchar(4),
    trxn_desc varchar(40)
);

CREATE TABLE IF NOT EXISTS cas.tlifeasia_inflow (
    pol_num varchar(10) not null,
    inflow_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tloaded_files (
    coll_dt timestamp,
    file_name varchar(10),
    dist_chnl_cd varchar(2),
    off_loc_cd varchar(5),
    created_by varchar(10),
    date_created timestamp
);

CREATE TABLE IF NOT EXISTS cas.tload_ratefiles (
    table_name varchar(40) not null,
    file_name varchar(40) not null,
    file_path varchar(40) not null,
    select_code varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tloan_details (
    pol_num varchar(10) not null,
    loan_bal numeric(13,2) not null,
    loan_actv_dt timestamp not null,
    loan_int_acru numeric(9,2) not null,
    prev_yr_loan_bal numeric(13,2) not null,
    high_loan_bal numeric(13,2),
    cv_loan_pct numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.tloan_details_bf_re (
    pol_num varchar(10) not null,
    loan_bal numeric(13,2) not null,
    loan_actv_dt timestamp not null,
    loan_int_acru numeric(9,2) not null,
    prev_yr_loan_bal numeric(13,2) not null,
    high_loan_bal numeric(13,2),
    cv_loan_pct numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.tloan_histories (
    pol_num varchar(12) not null,
    loan_typ varchar(3) not null,
    trxn_dt timestamp not null,
    lhi_seq numeric(4) not null,
    loan_eff_dt timestamp not null,
    action_cd varchar(3) not null,
    trxn_desc varchar(200) not null,
    trxn_id varchar(15),
    undo_trxn_id varchar(15)
);

CREATE TABLE IF NOT EXISTS cas.tloan_lap (
    pol_num varchar(10) not null,
    loan_bal numeric(13,2) not null,
    loan_actv_dt timestamp not null,
    loan_int_acru numeric(9,2) not null,
    prev_yr_loan_bal numeric(13,2) not null
);

CREATE TABLE IF NOT EXISTS cas.tloan_rules (
    loan_typ varchar(3) not null,
    int_rt_typ varchar(1) not null,
    cap_avy_opt varchar(1) not null,
    min_cap_mth numeric(3) not null,
    acct_mne_cd varchar(8) not null,
    cap_acct_mne_cd varchar(8) not null,
    int_acct_mne_cd varchar(8) not null,
    rpy_acct_mne_cd varchar(8) not null
);

CREATE TABLE IF NOT EXISTS cas.tloan_typ_dtls (
    pol_num varchar(10) not null,
    loan_typ varchar(3) not null,
    loan_eff_dt timestamp not null,
    loan_bal numeric(13,2) not null,
    loan_actv_dt timestamp not null,
    loan_int_acru numeric(13,2) not null,
    rec_status varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tloan_typ_dtls_bf_re (
    pol_num varchar(10) not null,
    loan_typ varchar(3) not null,
    loan_eff_dt timestamp not null,
    loan_bal numeric(13,2) not null,
    loan_actv_dt timestamp not null,
    loan_int_acru numeric(13,2) not null,
    rec_status varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tlpol_pua_jan (
    pol_num varchar(10) not null,
    pol_stat_cd varchar(1) not null,
    pol_eff_dt timestamp not null,
    last_avy_dt timestamp not null,
    div_upto_dt timestamp,
    plan_code varchar(5) not null,
    par_code varchar(1) not null,
    pua_tot_amt numeric(13,2) not null,
    pua_crnt_amt numeric(13,2) not null,
    cvg_eff_age numeric(3) not null,
    face_amt numeric(13,2) not null,
    prob_typ char(1)
);

CREATE TABLE IF NOT EXISTS cas.tlpol_pua_oct (
    pol_num varchar(10) not null,
    pol_stat_cd varchar(1) not null,
    pol_eff_dt timestamp not null,
    last_avy_dt timestamp not null,
    div_upto_dt timestamp,
    plan_code varchar(5) not null,
    par_code varchar(1) not null,
    pua_tot_amt numeric(13,2) not null,
    pua_crnt_amt numeric(13,2) not null,
    cvg_eff_age numeric(3) not null,
    face_amt numeric(13,2) not null,
    prob_typ char(1),
    new_pua_tot_amt numeric(13,2),
    new_pua_crnt_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tlump_sum_factor (
    int_rt numeric(7,5) not null,
    prem_prd numeric(3) not null,
    lump_sum_factor numeric(6,4) not null
);

CREATE TABLE IF NOT EXISTS cas.tlump_sum_year_factor (
    int_rt numeric(7,5) not null,
    cvg_year numeric(3) not null,
    lump_sum_year_factor numeric(6,4) not null
);

CREATE TABLE IF NOT EXISTS cas.tm7_clause_master (
    cl_typ varchar(1) not null,
    cl_grp varchar(8) not null,
    cl_uflg varchar(1),
    total_line numeric(3),
    cl_desc varchar(100),
    new_page_brk varchar(1),
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp
);

CREATE TABLE IF NOT EXISTS cas.tm8_clause_details (
    cl_typ varchar(1) not null,
    cl_grp varchar(8) not null,
    cl_line numeric(3) not null,
    cl_detail varchar(100),
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp
);

CREATE TABLE IF NOT EXISTS cas.tm9_extra_prem_rt (
    plan_code varchar(5) not null,
    prem_vers varchar(2) not null,
    med_grd varchar(2) not null,
    eff_age numeric(3) not null,
    extra_rt numeric(8,4) not null,
    fr_bnft_prd numeric(3) default '-1' not null,
    to_bnft_prd numeric(3) default '-1' not null,
    eff_fr_dt timestamp not null,
    eff_to_dt timestamp not null
);

CREATE TABLE IF NOT EXISTS cas.tmail_grp_rpt (
    mail_grp_rpt varchar(30) not null,
    mail_grp_rpt_desc varchar(50) not null,
    mail_subject varchar(100),
    from_system varchar(10) default 'CAS' not null
);

CREATE TABLE IF NOT EXISTS cas.tmail_list (
    user_name varchar(50),
    email_addr varchar(50),
    status varchar(1),
    to_ind varchar(1),
    cc_ind varchar(1),
    bcc_ind varchar(1),
    phone_num varchar(20),
    bus_phone varchar(20),
    fax_num varchar(20),
    app_cd varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.tmail_receipt (
    mail_grp_rpt varchar(30) not null,
    rcpt_to varchar(100) not null,
    rcpt_type varchar(5) default 'TO' not null
);

CREATE TABLE IF NOT EXISTS cas.tmail_rep_det (
    mail_grp_rpt varchar(30) not null,
    rep_path varchar(100) not null,
    rep_name varchar(30) not null,
    rep_filetype varchar(5) default 'PDF'
);

CREATE TABLE IF NOT EXISTS cas.tmanusave_mailer_agt_sg (
    id_num varchar(20),
    pol_num varchar(10),
    pol_iss_dt timestamp,
    owner varchar(60),
    ownerdob timestamp,
    ownersex varchar(1),
    prim_phon varchar(20),
    othr_phon varchar(20),
    add1 varchar(60),
    add2 varchar(60),
    add3 varchar(60),
    add4 varchar(60),
    zipcode varchar(6),
    ins varchar(60),
    inssex varchar(1),
    insdob timestamp,
    agtcode varchar(6),
    agtnm varchar(40),
    branch varchar(4000),
    face_ratg numeric(5,2),
    permload numeric(11,2),
    tempload numeric(11,2),
    baseplan varchar(5),
    plandesc varchar(4000)
);

CREATE TABLE IF NOT EXISTS cas.tmanusave_mailer_sg (
    id_num varchar(20),
    pol_num varchar(10),
    pol_iss_dt timestamp,
    owner varchar(60),
    ownerdob timestamp,
    ownersex varchar(1),
    prim_phon varchar(20),
    othr_phon varchar(20),
    add1 varchar(60),
    add2 varchar(60),
    add3 varchar(60),
    add4 varchar(60),
    zipcode varchar(6),
    ins varchar(60),
    inssex varchar(1),
    insdob timestamp,
    agtcode varchar(6),
    agtnm varchar(40),
    branch varchar(4000),
    face_ratg numeric(5,2),
    permload numeric(11,2),
    tempload numeric(11,2),
    baseplan varchar(5),
    plandesc varchar(4000)
);

CREATE TABLE IF NOT EXISTS cas.tmatured_cheques (
    ref_num_text varchar(10) not null,
    che_num_text varchar(20) not null,
    coa_cd varchar(7) not null,
    clr_cd numeric(3) default 20 not null,
    che_dt timestamp not null,
    txn_amt numeric(15,2) not null,
    bank_cd varchar(4) not null,
    bank_cmpny_id varchar(6),
    bank_desc varchar(40),
    created_by varchar(10) not null,
    date_created timestamp not null,
    date_modified timestamp,
    modified_by varchar(10),
    id numeric(10) not null
);

CREATE TABLE IF NOT EXISTS cas.tmdrt_update_log_sg (
    agt_code varchar(6),
    frm_unit_code varchar(5),
    frm_br_code varchar(5),
    to_unit_code varchar(5),
    to_br_code varchar(5),
    date_changed timestamp,
    table_changed varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.tmedical_payment_acct_setup (
    acct_cat varchar(10) not null,
    acct_cat_item varchar(3) not null,
    prvd_or_exp varchar(1),
    acct_mne_cd varchar(8),
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp
);

CREATE TABLE IF NOT EXISTS cas.tmedical_payment_headers (
    req_num numeric(10) not null,
    pol_num varchar(10),
    pol_ind varchar(3) not null,
    clinic_code varchar(6) not null,
    req_typ varchar(2) not null,
    req_status varchar(1) not null,
    examinee_code varchar(13) not null,
    med_fees numeric(11,2) not null,
    amt_paid numeric(11,2) not null,
    tax_flag varchar(1) not null,
    med_exam_dt timestamp not null,
    med_fac_cd varchar(10) not null,
    pay_opt varchar(1) not null,
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp
);

CREATE TABLE IF NOT EXISTS cas.tmedical_payment_payees (
    req_num numeric(10) not null,
    payee_typ_mp varchar(1) not null,
    payee_code varchar(13) not null,
    payee_typ varchar(1),
    amt_paid numeric(11,2) not null,
    payo_typ varchar(10),
    payo_arang varchar(10),
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp
);

CREATE TABLE IF NOT EXISTS cas.tmedical_payment_details (
    req_num numeric(10) not null,
    payee_typ_mp varchar(1) not null,
    payee_code varchar(13) not null,
    seq_num numeric(4) not null,
    clinic_code varchar(6) not null,
    trxn_status varchar(1) not null,
    trxn_dt timestamp not null,
    trxn_proc_dt timestamp,
    pay_rel_flag varchar(1) not null,
    trxn_amt numeric(11,2) not null,
    tax_flag varchar(1) not null,
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp
);

CREATE TABLE IF NOT EXISTS cas.tmedical_payment_dnr (
    req_num numeric(10) not null,
    payee_typ_mp varchar(1) not null,
    payee_code varchar(13) not null,
    dnr_num numeric(4) not null,
    amt_paid numeric(11,2) not null,
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp
);

CREATE TABLE IF NOT EXISTS cas.tmedical_payment_trxn_payee (
    trxn_num numeric(10) not null,
    trxn_status varchar(2) not null,
    trxn_dt timestamp not null,
    trxn_typ varchar(2) not null,
    issue_dt timestamp,
    payee_typ_mp varchar(1) not null,
    payee_code varchar(13) not null,
    clinic_code varchar(6) not null,
    payo_amt numeric(11,2) not null,
    payo_typ varchar(10) not null,
    payo_arang varchar(10) not null,
    payo_crcy varchar(2),
    chq_num varchar(10),
    chq_dt timestamp,
    chq_iss_bank varchar(10),
    remark varchar(60),
    transfer_dt timestamp,
    extract_dt timestamp,
    extract_btch_num varchar(5),
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp,
    net_amt numeric(11,2),
    tax_amt numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tmedical_payment_trxn (
    trxn_seq numeric(10) not null,
    trxn_num numeric(10) not null,
    trxn_typ varchar(2) not null,
    trxn_dt timestamp not null,
    trxn_amt numeric(11,2) not null,
    req_num numeric(10),
    trxn_id varchar(15),
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp,
    net_amt numeric(11,2),
    tax_amt numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tmedical_requirement_th (
    eff_age_fr numeric(3) not null,
    eff_age_to numeric(3) not null,
    face_amt_fr numeric(13,2) not null,
    face_amt_to numeric(13,2) not null,
    med_req_dtl varchar(30) not null
);

CREATE TABLE IF NOT EXISTS cas.tmed_client_details (
    pol_num varchar(10) not null,
    id_num varchar(20),
    ins_nm varchar(60),
    age numeric(2),
    sex varchar(2),
    face_amt numeric(14,2),
    sum_face_amt numeric(16,2),
    pol_app_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tmed_details (
    pol_num varchar(10) not null,
    med_seq numeric(6) not null,
    med_hosp varchar(60),
    med_date timestamp,
    med_schd varchar(2),
    med_reasn varchar(2),
    exam_ind varchar(1),
    bt_ind varchar(1),
    ekg_ind varchar(1),
    cxr_ind varchar(1),
    micro_ind varchar(1),
    med_pend_cd varchar(20),
    med_folup_dt timestamp,
    med_comp_dt timestamp,
    med_reslt varchar(1),
    med_exps numeric(14,2),
    user_id varchar(10),
    remark varchar(100),
    id_num varchar(20),
    loc_code varchar(10),
    labone_exps numeric(9,2),
    in_exps numeric(14,2),
    med_doctor varchar(40),
    actl_med_ind varchar(1),
    link_typ varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tmenu_items_sg (
    fcn_id varchar(20) not null,
    menu_item varchar(255) not null,
    menu_label varchar(255) not null,
    active_ind varchar(1),
    menu_seq numeric(3,1)
);

CREATE TABLE IF NOT EXISTS cas.tmessages (
    msg_id varchar(5) not null,
    msg_typ varchar(1) not null,
    msg_txt varchar(100) not null,
    msg_txt_eng varchar(100) not null,
    msg_sevrty_lvl varchar(1) not null,
    app_cd varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tmessages_override (
    trxn_cd varchar(10) not null,
    msg_id varchar(5) not null,
    msg_id_or varchar(5) not null,
    msg_sevrty_lvl varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tmessage_log (
    fcn_id varchar(20) not null,
    log_id numeric(10) not null,
    msg_line_id numeric(10) not null,
    msg_txt varchar(100) not null,
    process_time timestamp not null
);

CREATE TABLE IF NOT EXISTS cas.tmf_medical_extra_rt (
    med_grd varchar(2) not null,
    extra_rt_pct numeric(6,2) not null,
    eff_fr_dt timestamp not null,
    eff_to_dt timestamp not null
);

CREATE TABLE IF NOT EXISTS cas.tmin_max_charges (
    chrg_cat varchar(10) not null,
    chrg_typ varchar(10) not null,
    eff_dt timestamp not null,
    fr_pol_yr numeric(3) not null,
    to_pol_yr numeric(3) not null,
    fr_prem_dur numeric(3) not null,
    to_prem_dur numeric(3) not null,
    chrg_lyr varchar(1) not null,
    chrg_lvl varchar(1) not null,
    fr_mth numeric(5) not null,
    to_mth numeric(5) not null,
    fr_prem_pd_yr numeric(3) not null,
    to_prem_pd_yr numeric(3) not null,
    plan_code varchar(5) not null,
    plan_vers varchar(2) not null,
    plan_crcy varchar(2) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    fnd_crcy varchar(2) not null,
    pmt_mode varchar(2) not null,
    bill_mthd varchar(1) not null,
    band_low numeric(13,2) not null,
    band_high numeric(13,2) not null,
    min_max_typ varchar(3),
    bas_alt_num varchar(2),
    bas_alt_chk_mthd varchar(1),
    min_max_pct numeric(11,8),
    min_max_basis_nm varchar(20),
    min_max_amt numeric(13,2),
    rdr_plan_code varchar(5) not null,
    rdr_plan_vers varchar(2) not null
);

CREATE TABLE IF NOT EXISTS cas.tmisrpt_sbmt_cutoff_dt_sg (
    prod_yr_mth varchar(6) not null,
    sbmt_dt_frm timestamp not null,
    sbmt_dt_to timestamp not null
);

CREATE TABLE IF NOT EXISTS cas.tmissing_image_sg (
    file_nm varchar(200),
    gen_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tmis_agents (
    agt_code varchar(5) not null,
    can_num varchar(10) not null,
    agt_nm varchar(40) not null,
    comp_prvd_num varchar(3) not null,
    addr_typ numeric(2),
    bank_ac_num varchar(20),
    bank_ac_nm varchar(40),
    rpt_to_grp varchar(5) not null,
    rpt_to_grp_eff_dt timestamp not null,
    mailbox_num varchar(10),
    recrut_by varchar(5),
    recrut_bns_to varchar(5),
    loc_code varchar(5),
    rank_cd varchar(5) not null,
    rank_eff_dt timestamp not null,
    lst_prom_evl_dt timestamp,
    lst_demo_evl_dt timestamp,
    nxt_prom_evl_dt timestamp,
    nxt_demo_evl_dt timestamp,
    con_evl_fail_cnt numeric(3),
    stat_cd varchar(3) not null,
    agt_stat_code varchar(2) not null,
    cntrct_eff_dt timestamp not null,
    trmn_dt timestamp,
    clb_mbr_cd varchar(5),
    pmt_mthd varchar(2),
    trmn_hld_ind varchar(1) not null,
    pay_slp_ind varchar(1) not null,
    tax_num varchar(40),
    agt_typ varchar(5) not null,
    pend_cd varchar(5),
    pend_flwup_dt timestamp,
    lst_rpt_to_grp varchar(5),
    br_code varchar(5) not null,
    cntrct_sign_dt timestamp,
    trmn_reasn varchar(5),
    lic_num varchar(15),
    bus_phone varchar(20),
    team_code varchar(10),
    unit_code varchar(5),
    agt_addr varchar(90),
    agt_join_dt timestamp,
    agt_term_dt timestamp,
    zip_code varchar(6),
    uwg_lvl varchar(10),
    agt_sup varchar(5),
    agt_rmk varchar(100),
    recrut_rank_cd varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.tmis_anp_hist (
    gen_seq numeric not null,
    gen_dt timestamp,
    from_dt timestamp,
    to_dt timestamp,
    gen_rpt_typ varchar(1),
    main_cat varchar(2) not null,
    sub_cat varchar(2) not null,
    crcy_code varchar(2) not null,
    amount numeric,
    amt_in_local_crcy numeric,
    amt_in_us_crcy numeric,
    rt_to_local_crcy numeric(18,8),
    rt_to_us_crcy numeric(18,8),
    curr_yr varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tmis_anp_last_year_end_records (
    fr_dt timestamp,
    to_dt timestamp,
    lob varchar(50),
    anp_typ varchar(50),
    crcy_cd varchar(2),
    pol_num varchar(10),
    plan_code_base varchar(5),
    vers_num_base varchar(2),
    plan_code varchar(5),
    vers_num varchar(2),
    prod_cat varchar(3),
    sngl_prem_ind varchar(1),
    ins_typ varchar(1),
    pol_eff_dt timestamp,
    pol_iss_sbmt_dt timestamp,
    pol_stat_cd varchar(1),
    pmt_mode varchar(5),
    bill_mthd varchar(1),
    cvg_lyr_eff_dt timestamp,
    cvg_lyr_iss_dt timestamp,
    cvg_lyr_stat_cd varchar(1),
    anp_amt numeric,
    cvg_lyr_face_amt numeric,
    cvg_lyr_clas varchar(3),
    cvg_lyr_typ varchar(2),
    layer_typ varchar(1),
    layer_eff_dt timestamp,
    layer_stat_cd varchar(1),
    main_cat varchar(2),
    sub_cat varchar(2),
    cli_num varchar(13),
    accum_change numeric default 0,
    last_update_timestamp timestamp
);

CREATE TABLE IF NOT EXISTS cas.tmis_anp_rep (
    gen_seq numeric,
    gen_dt timestamp,
    from_dt timestamp,
    to_dt timestamp,
    gen_rpt_typ varchar(1),
    main_cat varchar(2),
    sub_cat varchar(2),
    crcy_code varchar(2),
    amount numeric,
    amt_in_local_crcy numeric,
    amt_in_us_crcy numeric,
    rt_to_local_crcy numeric(18,8),
    rt_to_us_crcy numeric(18,8),
    curr_yr varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tmis_anp_ytd_chng_for_last_yr (
    gen_dt timestamp,
    run_dt timestamp not null,
    main_cat varchar(2) not null,
    sub_cat varchar(2) not null,
    crcy_code varchar(2) not null,
    ytd_chng_amt numeric
);

CREATE TABLE IF NOT EXISTS cas.tmis_anp_ytd_records (
    gen_dt timestamp,
    run_dt timestamp not null,
    main_cat varchar(2) not null,
    sub_cat varchar(2) not null,
    crcy_code varchar(2) not null,
    ytd_amt numeric
);

CREATE TABLE IF NOT EXISTS cas.tmis_ape_sc_cfg (
    param_name varchar(50),
    param_value varchar(50),
    param_desc varchar(200)
);

CREATE TABLE IF NOT EXISTS cas.tmis_ape_sc_feed_dat (
    gen_seq numeric,
    gen_dt timestamp,
    fr_dt timestamp,
    to_dt timestamp,
    feed_type varchar(20),
    segment varchar(50),
    bu varchar(50),
    sub_bu varchar(50),
    source varchar(50),
    plan_code varchar(8),
    customer_type varchar(50),
    par_code varchar(2),
    main_cat varchar(2),
    sub_cat varchar(2),
    pol_type varchar(50),
    chnl_code varchar(50),
    partner_nm varchar(50),
    prem_mode varchar(2),
    bu_crcy_abbr varchar(3),
    bu_crcy_gross_sales numeric(18,2),
    bu_crcy_ape numeric(18,2)
);

CREATE TABLE IF NOT EXISTS cas.tmis_ape_sc_ytd_rec (
    gen_seq numeric,
    gen_dt timestamp,
    run_dt timestamp,
    segment varchar(50),
    bu varchar(50),
    sub_bu varchar(50),
    source varchar(50),
    plan_code varchar(8),
    customer_type varchar(50),
    par_code varchar(2),
    main_cat varchar(2),
    sub_cat varchar(2),
    pol_type varchar(50),
    chnl_code varchar(50),
    partner_nm varchar(50),
    prem_mode varchar(2),
    pol_crcy_code varchar(2),
    gross_sales numeric(18,2),
    ape numeric(18,2)
);

CREATE TABLE IF NOT EXISTS cas.tmis_ape_sc_ytd_rec_dtl (
    gen_seq numeric,
    gen_dt timestamp,
    run_dt timestamp,
    fr_dt timestamp,
    to_dt timestamp,
    pol_num varchar(10),
    plan_code varchar(5),
    vers_num varchar(2),
    customer_type varchar(50),
    par_code varchar(2),
    main_cat varchar(2),
    sub_cat varchar(2),
    pol_type varchar(50),
    chnl_code varchar(50),
    partner_nm varchar(50),
    prem_type varchar(2),
    pol_crcy_code varchar(2),
    pmt_mode varchar(5),
    prem_amt numeric(18,2),
    gross_sales numeric(18,2),
    ape numeric(18,2),
    agt_code varchar(6),
    br_code varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.tmis_ape_sc_ytd_rec_dtl_hist (
    gen_seq numeric,
    gen_dt timestamp,
    run_dt timestamp,
    fr_dt timestamp,
    to_dt timestamp,
    pol_num varchar(10),
    plan_code varchar(5),
    vers_num varchar(2),
    customer_type varchar(50),
    par_code varchar(2),
    main_cat varchar(2),
    sub_cat varchar(2),
    pol_type varchar(50),
    chnl_code varchar(50),
    partner_nm varchar(50),
    prem_type varchar(2),
    pol_crcy_code varchar(2),
    pmt_mode varchar(5),
    prem_amt numeric(18,2),
    gross_sales numeric(18,2),
    ape numeric(18,2),
    agt_code varchar(6),
    br_code varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.tmis_ape_sc_ytd_rec_hist (
    gen_seq numeric,
    gen_dt timestamp,
    run_dt timestamp,
    segment varchar(50),
    bu varchar(50),
    sub_bu varchar(50),
    source varchar(50),
    plan_code varchar(8),
    customer_type varchar(50),
    par_code varchar(2),
    main_cat varchar(2),
    sub_cat varchar(2),
    pol_type varchar(50),
    chnl_code varchar(50),
    partner_nm varchar(50),
    prem_mode varchar(2),
    pol_crcy_code varchar(2),
    gross_sales numeric(18,2),
    ape numeric(18,2)
);

CREATE TABLE IF NOT EXISTS cas.tmis_ape_sc_ytd_rec_pr (
    gen_seq numeric,
    gen_dt timestamp,
    run_dt timestamp,
    segment varchar(50),
    bu varchar(50),
    sub_bu varchar(50),
    source varchar(50),
    plan_code varchar(8),
    customer_type varchar(50),
    par_code varchar(2),
    main_cat varchar(2),
    sub_cat varchar(2),
    pol_type varchar(50),
    chnl_code varchar(50),
    partner_nm varchar(50),
    prem_mode varchar(2),
    pol_crcy_code varchar(2),
    gross_sales numeric(18,2),
    ape numeric(18,2)
);

CREATE TABLE IF NOT EXISTS cas.tmis_ape_sc_ytd_rec_pr_dtl (
    gen_seq numeric,
    gen_dt timestamp,
    run_dt timestamp,
    fr_dt timestamp,
    to_dt timestamp,
    pol_num varchar(10),
    plan_code varchar(5),
    vers_num varchar(2),
    plan_code_base varchar(5),
    vers_num_base varchar(2),
    customer_type varchar(50),
    par_code varchar(2),
    main_cat varchar(2),
    sub_cat varchar(2),
    pol_type varchar(50),
    chnl_code varchar(50),
    partner_nm varchar(50),
    prem_type varchar(2),
    pol_crcy_code varchar(2),
    pmt_mode varchar(5),
    prem_amt numeric(18,2),
    gross_sales numeric(18,2),
    ape numeric(18,2),
    agt_code varchar(6),
    br_code varchar(5),
    cli_num varchar(13),
    cvg_lyr_eff_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tmis_ape_sc_ytd_rec_pr_dtl_h (
    gen_seq numeric,
    gen_dt timestamp,
    run_dt timestamp,
    fr_dt timestamp,
    to_dt timestamp,
    pol_num varchar(10),
    plan_code varchar(5),
    vers_num varchar(2),
    plan_code_base varchar(5),
    vers_num_base varchar(2),
    customer_type varchar(50),
    par_code varchar(2),
    main_cat varchar(2),
    sub_cat varchar(2),
    pol_type varchar(50),
    chnl_code varchar(50),
    partner_nm varchar(50),
    prem_type varchar(2),
    pol_crcy_code varchar(2),
    pmt_mode varchar(5),
    prem_amt numeric(18,2),
    gross_sales numeric(18,2),
    ape numeric(18,2),
    agt_code varchar(6),
    br_code varchar(5),
    cli_num varchar(13),
    cvg_lyr_eff_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tmis_ape_sc_ytd_rec_pr_h (
    gen_seq numeric,
    gen_dt timestamp,
    run_dt timestamp,
    segment varchar(50),
    bu varchar(50),
    sub_bu varchar(50),
    source varchar(50),
    plan_code varchar(8),
    customer_type varchar(50),
    par_code varchar(2),
    main_cat varchar(2),
    sub_cat varchar(2),
    pol_type varchar(50),
    chnl_code varchar(50),
    partner_nm varchar(50),
    prem_mode varchar(2),
    pol_crcy_code varchar(2),
    gross_sales numeric(18,2),
    ape numeric(18,2)
);

CREATE TABLE IF NOT EXISTS cas.tmis_ape_sc_ytd_rec_pr_sum (
    gen_seq numeric,
    gen_dt timestamp,
    run_dt timestamp,
    fr_dt timestamp,
    to_dt timestamp,
    plan_code varchar(5),
    vers_num varchar(2),
    customer_type varchar(50),
    par_code varchar(2),
    main_cat varchar(2),
    sub_cat varchar(2),
    pol_type varchar(50),
    chnl_code varchar(50),
    partner_nm varchar(50),
    prem_type varchar(2),
    pol_crcy_code varchar(2),
    gross_sales numeric(18,2),
    ape numeric(18,2)
);

CREATE TABLE IF NOT EXISTS cas.tmis_ape_sc_ytd_rec_pr_sum_h (
    gen_seq numeric,
    gen_dt timestamp,
    run_dt timestamp,
    fr_dt timestamp,
    to_dt timestamp,
    plan_code varchar(5),
    vers_num varchar(2),
    customer_type varchar(50),
    par_code varchar(2),
    main_cat varchar(2),
    sub_cat varchar(2),
    pol_type varchar(50),
    chnl_code varchar(50),
    partner_nm varchar(50),
    prem_type varchar(2),
    pol_crcy_code varchar(2),
    gross_sales numeric(18,2),
    ape numeric(18,2)
);

CREATE TABLE IF NOT EXISTS cas.tmis_ape_sc_ytd_rec_sum (
    gen_seq numeric,
    gen_dt timestamp,
    run_dt timestamp,
    fr_dt timestamp,
    to_dt timestamp,
    plan_code varchar(5),
    vers_num varchar(2),
    customer_type varchar(50),
    par_code varchar(2),
    main_cat varchar(2),
    sub_cat varchar(2),
    pol_type varchar(50),
    chnl_code varchar(50),
    partner_nm varchar(50),
    prem_type varchar(2),
    pol_crcy_code varchar(2),
    gross_sales numeric(18,2),
    ape numeric(18,2)
);

CREATE TABLE IF NOT EXISTS cas.tmis_ape_sc_ytd_rec_sum_hist (
    gen_seq numeric,
    gen_dt timestamp,
    run_dt timestamp,
    fr_dt timestamp,
    to_dt timestamp,
    plan_code varchar(5),
    vers_num varchar(2),
    customer_type varchar(50),
    par_code varchar(2),
    main_cat varchar(2),
    sub_cat varchar(2),
    pol_type varchar(50),
    chnl_code varchar(50),
    partner_nm varchar(50),
    prem_type varchar(2),
    pol_crcy_code varchar(2),
    gross_sales numeric(18,2),
    ape numeric(18,2)
);

CREATE TABLE IF NOT EXISTS cas.tmis_branches (
    br_code varchar(5) not null,
    br_stat_code varchar(2),
    br_nm varchar(20),
    mgr_code varchar(5),
    loc_code varchar(10),
    br_eff_dt timestamp,
    br_term_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tmis_dc002 (
    sp_ind varchar(2),
    ins_typ varchar(10),
    plan_code_base varchar(5),
    bill_mthd varchar(6),
    pmt_mode varchar(13),
    sa varchar(5),
    yrs_in_force numeric,
    mths_in_force numeric,
    mths_issued numeric,
    trmn_yr varchar(4),
    inception_yr varchar(4),
    iss_yr varchar(4),
    pol_num varchar(10) not null,
    pol_stat varchar(19),
    dist_type varchar(7),
    unit varchar(40),
    branch varchar(40) not null,
    ca varchar(5) not null,
    ins_sex varchar(1) not null,
    ins_smkr_code varchar(1) not null,
    face_amt numeric,
    inception_age numeric(3) not null,
    yrs_to_maturity numeric,
    mths_to_maturity numeric,
    ann_prem numeric,
    case_cnt numeric,
    trad_ul_ind char(4),
    iss_att_age numeric,
    own_att_age numeric,
    payor_att_age numeric(3),
    sp numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tmis_dc002_sg (
    sp_ind varchar(2),
    ins_typ varchar(10),
    plan_code_base varchar(5),
    bill_mthd varchar(6),
    pmt_mode varchar(13),
    yr_last_ptd varchar(4),
    mth_last_ptd varchar(3),
    yr_sbmt varchar(4),
    mth_sbmt varchar(3),
    sa varchar(5),
    wa varchar(5),
    fran_num varchar(4),
    yrs_in_force numeric,
    mths_in_force numeric,
    mths_issued numeric,
    trmn_yr varchar(4),
    trmn_mth varchar(3),
    inception_yr varchar(4),
    inception_mth varchar(3),
    iss_yr varchar(4),
    iss_mth varchar(3),
    pol_num varchar(10) not null,
    pol_stat varchar(19),
    dist_type varchar(7),
    unit varchar(40),
    branch varchar(40) not null,
    ca varchar(5) not null,
    ins_sex varchar(1) not null,
    ins_smkr_code varchar(1) not null,
    face_amt numeric,
    inception_age numeric(3) not null,
    yrs_to_maturity numeric,
    mths_to_maturity numeric,
    ann_prem numeric,
    case_cnt numeric,
    trad_ul_ind char(4),
    ins_id_num varchar(20),
    ins_cli_num varchar(10) not null,
    ins_cli_nm varchar(60) not null,
    own_id_num varchar(20),
    own_cli_num varchar(10) not null,
    own_cli_nm varchar(60) not null,
    ins_att_age numeric,
    own_att_age numeric
);

CREATE TABLE IF NOT EXISTS cas.tmis_dc003_sg (
    pol_num varchar(10) not null,
    dist_type varchar(7),
    ins_age_band varchar(20),
    fa_band_1 varchar(30),
    fa_band_1_seq numeric,
    fa_band_2 varchar(30),
    fa_band_2_seq numeric,
    fa_band_3 varchar(30),
    fa_band_3_seq numeric,
    case_cnt numeric,
    totl_fa_1 numeric
);

CREATE TABLE IF NOT EXISTS cas.tmis_email_log (
    app_cd varchar(20) not null,
    gen_seq numeric not null,
    status varchar(1),
    succ_timestamp timestamp,
    fail_timestamp timestamp,
    num_of_tries numeric default 0,
    email_err_cd varchar(10),
    email_err_msg varchar(200)
);

CREATE TABLE IF NOT EXISTS cas.tmis_persistency_excl_plans (
    plan_code varchar(5),
    vers_num varchar(2),
    crcy_code varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tmis_persistency_hist (
    gen_seq numeric not null,
    show_seq numeric,
    run_dt timestamp not null,
    rpt_mth varchar(10) not null,
    gen_dt timestamp,
    iw_tot_com_in_sp_tot_iss numeric,
    iw_tot_com_in_sp_tot_infor numeric,
    iw_tot_com_in_sp_ratio numeric,
    iw_tot_com_ex_sp_tot_iss numeric,
    iw_tot_com_ex_sp_tot_infor numeric,
    iw_tot_com_ex_sp_ratio numeric,
    iw_agt_in_sp_tot_iss numeric,
    iw_agt_in_sp_tot_infor numeric,
    iw_agt_in_sp_ratio numeric,
    iw_agt_ex_sp_tot_iss numeric,
    iw_agt_ex_sp_tot_infor numeric,
    iw_agt_ex_sp_ratio numeric,
    iw_non_agt_in_sp_tot_iss numeric,
    iw_non_agt_in_sp_tot_infor numeric,
    iw_non_agt_in_sp_ratio numeric,
    iw_non_agt_ex_sp_tot_iss numeric,
    iw_non_agt_ex_sp_tot_infor numeric,
    iw_non_agt_ex_sp_ratio numeric,
    i_tot_com_in_sp_tot_iss numeric,
    i_tot_com_in_sp_tot_infor numeric,
    i_tot_com_in_sp_ratio numeric,
    i_tot_com_ex_sp_tot_iss numeric,
    i_tot_com_ex_sp_tot_infor numeric,
    i_tot_com_ex_sp_ratio numeric,
    i_agt_in_sp_tot_iss numeric,
    i_agt_in_sp_tot_infor numeric,
    i_agt_in_sp_ratio numeric,
    i_agt_ex_sp_tot_iss numeric,
    i_agt_ex_sp_tot_infor numeric,
    i_agt_ex_sp_ratio numeric,
    i_non_agt_in_sp_tot_iss numeric,
    i_non_agt_in_sp_tot_infor numeric,
    i_non_agt_in_sp_ratio numeric,
    i_non_agt_ex_sp_tot_iss numeric,
    i_non_agt_ex_sp_tot_infor numeric,
    i_non_agt_ex_sp_ratio numeric,
    w_tot_com_in_sp_tot_iss numeric,
    w_tot_com_in_sp_tot_infor numeric,
    w_tot_com_in_sp_ratio numeric,
    w_tot_com_ex_sp_tot_iss numeric,
    w_tot_com_ex_sp_tot_infor numeric,
    w_tot_com_ex_sp_ratio numeric,
    w_agt_in_sp_tot_iss numeric,
    w_agt_in_sp_tot_infor numeric,
    w_agt_in_sp_ratio numeric,
    w_agt_ex_sp_tot_iss numeric,
    w_agt_ex_sp_tot_infor numeric,
    w_agt_ex_sp_ratio numeric,
    w_non_agt_in_sp_tot_iss numeric,
    w_non_agt_in_sp_tot_infor numeric,
    w_non_agt_in_sp_ratio numeric,
    w_non_agt_ex_sp_tot_iss numeric,
    w_non_agt_ex_sp_tot_infor numeric,
    w_non_agt_ex_sp_ratio numeric,
    gen_rpt_typ varchar(1),
    rpt_mth_ind numeric,
    excl_plan_rep_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tmis_persistency_rep (
    gen_seq numeric,
    show_seq numeric,
    run_dt timestamp,
    rpt_mth varchar(10),
    gen_dt timestamp,
    iw_tot_com_in_sp_tot_iss numeric,
    iw_tot_com_in_sp_tot_infor numeric,
    iw_tot_com_in_sp_ratio numeric,
    iw_tot_com_ex_sp_tot_iss numeric,
    iw_tot_com_ex_sp_tot_infor numeric,
    iw_tot_com_ex_sp_ratio numeric,
    iw_agt_in_sp_tot_iss numeric,
    iw_agt_in_sp_tot_infor numeric,
    iw_agt_in_sp_ratio numeric,
    iw_agt_ex_sp_tot_iss numeric,
    iw_agt_ex_sp_tot_infor numeric,
    iw_agt_ex_sp_ratio numeric,
    iw_non_agt_in_sp_tot_iss numeric,
    iw_non_agt_in_sp_tot_infor numeric,
    iw_non_agt_in_sp_ratio numeric,
    iw_non_agt_ex_sp_tot_iss numeric,
    iw_non_agt_ex_sp_tot_infor numeric,
    iw_non_agt_ex_sp_ratio numeric,
    i_tot_com_in_sp_tot_iss numeric,
    i_tot_com_in_sp_tot_infor numeric,
    i_tot_com_in_sp_ratio numeric,
    i_tot_com_ex_sp_tot_iss numeric,
    i_tot_com_ex_sp_tot_infor numeric,
    i_tot_com_ex_sp_ratio numeric,
    i_agt_in_sp_tot_iss numeric,
    i_agt_in_sp_tot_infor numeric,
    i_agt_in_sp_ratio numeric,
    i_agt_ex_sp_tot_iss numeric,
    i_agt_ex_sp_tot_infor numeric,
    i_agt_ex_sp_ratio numeric,
    i_non_agt_in_sp_tot_iss numeric,
    i_non_agt_in_sp_tot_infor numeric,
    i_non_agt_in_sp_ratio numeric,
    i_non_agt_ex_sp_tot_iss numeric,
    i_non_agt_ex_sp_tot_infor numeric,
    i_non_agt_ex_sp_ratio numeric,
    w_tot_com_in_sp_tot_iss numeric,
    w_tot_com_in_sp_tot_infor numeric,
    w_tot_com_in_sp_ratio numeric,
    w_tot_com_ex_sp_tot_iss numeric,
    w_tot_com_ex_sp_tot_infor numeric,
    w_tot_com_ex_sp_ratio numeric,
    w_agt_in_sp_tot_iss numeric,
    w_agt_in_sp_tot_infor numeric,
    w_agt_in_sp_ratio numeric,
    w_agt_ex_sp_tot_iss numeric,
    w_agt_ex_sp_tot_infor numeric,
    w_agt_ex_sp_ratio numeric,
    w_non_agt_in_sp_tot_iss numeric,
    w_non_agt_in_sp_tot_infor numeric,
    w_non_agt_in_sp_ratio numeric,
    w_non_agt_ex_sp_tot_iss numeric,
    w_non_agt_ex_sp_tot_infor numeric,
    w_non_agt_ex_sp_ratio numeric,
    gen_rpt_typ varchar(1),
    rpt_mth_ind numeric,
    excl_plan_rep_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tmis_pol080 (
    title varchar(30) not null,
    daily_pa numeric(11),
    daily_life numeric(11),
    last_m2d_pa numeric(11),
    last_m2d_life numeric(11),
    m2d_pa numeric(11),
    m2d_life numeric(11),
    y2d_pa numeric(11),
    y2d_life numeric(11)
);

CREATE TABLE IF NOT EXISTS cas.tmis_pol081 (
    title varchar(30) not null,
    daily_pa numeric(11),
    daily_life numeric(11),
    last_m2d_pa numeric(11),
    last_m2d_life numeric(11),
    m2d_pa numeric(11),
    m2d_life numeric(11),
    month_target numeric(11),
    month_target_achieve numeric(11,2),
    y2d_pa numeric(11),
    y2d_life numeric(11),
    y2d_target numeric(11),
    y2d_target_achieve numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tmis_pol082 (
    title varchar(30) not null,
    pending_pa numeric(11),
    pending_life numeric(11)
);

CREATE TABLE IF NOT EXISTS cas.tmis_pol090 (
    plan_code varchar(5) not null,
    submit numeric(6),
    decline numeric(6),
    cancel numeric(6),
    inforce numeric(6),
    not_taken numeric(6),
    lapse numeric(6),
    surrender numeric(6),
    death numeric(6),
    tt_inforce_fa numeric(13),
    tt_inforce_annprem numeric(11)
);

CREATE TABLE IF NOT EXISTS cas.tmis_pol091 (
    plan_code varchar(5) not null,
    submit numeric(6),
    issue numeric(6),
    decline numeric(6),
    cancel numeric(6),
    pending numeric(6),
    not_taken numeric(6),
    lapse numeric(6),
    surrender numeric(6),
    death numeric(6),
    uw_zap numeric(6),
    uw_medic numeric(6),
    uw_rating numeric(6),
    inforce numeric(6)
);

CREATE TABLE IF NOT EXISTS cas.tmis_pol092 (
    plan_code varchar(5) not null,
    inforce numeric(6),
    tt_inforce_fa numeric(13),
    tt_inforce_annprem numeric(11)
);

CREATE TABLE IF NOT EXISTS cas.tmis_pol100 (
    pol_pa numeric(8),
    pol_lf numeric(8),
    fa_10000_pa numeric(5,2),
    fa_50000_pa numeric(5,2),
    fa_100000_pa numeric(5,2),
    fa_150000_pa numeric(5,2),
    fa_300000_pa numeric(5,2),
    fa_500000_pa numeric(5,2),
    fa_999999_pa numeric(5,2),
    fa_10000_lf numeric(5,2),
    fa_50000_lf numeric(5,2),
    fa_100000_lf numeric(5,2),
    fa_150000_lf numeric(5,2),
    fa_300000_lf numeric(5,2),
    fa_500000_lf numeric(5,2),
    fa_999999_lf numeric(5,2),
    age_1_pa numeric(5,2),
    age_2_pa numeric(5,2),
    age_17_pa numeric(5,2),
    age_30_pa numeric(5,2),
    age_40_pa numeric(5,2),
    age_50_pa numeric(5,2),
    age_60_pa numeric(5,2),
    age_99_pa numeric(5,2),
    age_1_lf numeric(5,2),
    age_2_lf numeric(5,2),
    age_17_lf numeric(5,2),
    age_30_lf numeric(5,2),
    age_40_lf numeric(5,2),
    age_50_lf numeric(5,2),
    age_60_lf numeric(5,2),
    age_99_lf numeric(5,2),
    bill_mthd_regular_pa numeric(5,2),
    bill_mthd_autopay_pa numeric(5,2),
    bill_mthd_payroll_pa numeric(5,2),
    bill_mthd_regular_lf numeric(5,2),
    bill_mthd_autopay_lf numeric(5,2),
    bill_mthd_payroll_lf numeric(5,2),
    pmt_mode_annual_pa numeric(5,2),
    pmt_mode_semiann_pa numeric(5,2),
    pmt_mode_quarter_pa numeric(5,2),
    pmt_mode_month_pa numeric(5,2),
    pmt_mode_lumpsum_pa numeric(5,2),
    pmt_mode_annual_lf numeric(5,2),
    pmt_mode_semiann_lf numeric(5,2),
    pmt_mode_quarter_lf numeric(5,2),
    pmt_mode_month_lf numeric(5,2),
    pmt_mode_lumpsum_lf numeric(5,2),
    ann_prem_200_pa numeric(5,2),
    ann_prem_250_pa numeric(5,2),
    ann_prem_400_pa numeric(5,2),
    ann_prem_500_pa numeric(5,2),
    ann_prem_1000_pa numeric(5,2),
    ann_prem_9999_pa numeric(5,2),
    ann_prem_200_lf numeric(5,2),
    ann_prem_250_lf numeric(5,2),
    ann_prem_400_lf numeric(5,2),
    ann_prem_500_lf numeric(5,2),
    ann_prem_1000_lf numeric(5,2),
    ann_prem_9999_lf numeric(5,2),
    sex_m_pa numeric(5,2),
    sex_f_pa numeric(5,2),
    sex_m_lf numeric(5,2),
    sex_f_lf numeric(5,2),
    occupation_1_pa numeric(5,2),
    occupation_2_pa numeric(5,2),
    occupation_3_pa numeric(5,2),
    occupation_4_pa numeric(5,2),
    occupation_1_lf numeric(5,2),
    occupation_2_lf numeric(5,2),
    occupation_3_lf numeric(5,2),
    occupation_4_lf numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.tmis_pol101 (
    plan_code varchar(10) not null,
    under_pa numeric(10,2),
    under_lf numeric(10,2)
);

CREATE TABLE IF NOT EXISTS cas.tmis_pol110 (
    plan_code varchar(5) not null,
    last_yr_inforce numeric(6),
    last_yr_lapse_1 numeric(6),
    last_yr_lapse_2 numeric(6),
    last_yr_lapse_3 numeric(6),
    y2d_inforce numeric(6),
    y2d_lapse_1 numeric(6),
    y2d_lapse_2 numeric(6),
    y2d_lapse_3 numeric(6),
    tt_inforce numeric(8),
    tt_lapse_1 numeric(6),
    tt_lapse_2 numeric(6),
    tt_lapse_3 numeric(6)
);

CREATE TABLE IF NOT EXISTS cas.tmis_pol120 (
    pol_stat_cd varchar(1),
    pol_num varchar(10),
    pol_date timestamp,
    pmt_mode varchar(2),
    mode_prem numeric(11,2),
    pol_susp numeric(13,2),
    incmplt_cd varchar(2),
    pend_cd varchar(2),
    subj_to_cd varchar(2),
    pmt_susp numeric(11,2),
    cwa_susp numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tmis_pol130 (
    cli_num varchar(10) not null,
    cli_nm varchar(40),
    life_face_amt numeric(13,2),
    life_cede_amt numeric(13,2),
    add_face_amt numeric(13,2),
    add_cede_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tmis_pol131 (
    cli_num varchar(10) not null,
    pol_num varchar(40) not null,
    pol_eff_dt timestamp,
    life_face_amt numeric(13,2),
    add_face_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tmis_pol140 (
    serv_agt varchar(5),
    serv_agt_nm varchar(40),
    serv_agt_stat varchar(2),
    pol_num varchar(10),
    ins_name varchar(40),
    ins_addr varchar(60),
    fran_num varchar(4),
    pol_stat_cd varchar(1),
    issue_dt timestamp,
    pd_to_dt timestamp,
    reconf_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tmis_pol145 (
    pol_num varchar(10) not null,
    pol_stat_cd varchar(1),
    serv_agt_cd varchar(5),
    serv_agt_nm varchar(40),
    serv_unit_cd varchar(5),
    ori_agt_nm varchar(40),
    ori_unit_cd varchar(5),
    ori_unit_mgr varchar(40)
);

CREATE TABLE IF NOT EXISTS cas.tmis_pol150 (
    serv_agt varchar(5),
    plan_code varchar(5),
    comm_agt varchar(5),
    comm_agt_stat varchar(2),
    pol_stat_cd varchar(1),
    pol_num varchar(10),
    ins_name varchar(40),
    pol_eff_dt timestamp,
    pol_end_dt timestamp,
    pol_pc numeric(9),
    pmt_mode varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tmis_pol214 (
    plan_code varchar(5),
    pol_num varchar(10),
    face_amt numeric(13,2),
    cli_nm varchar(40),
    cvg_eff_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tmis_pol220 (
    issue_mth varchar(20) not null,
    prod_line varchar(1) not null,
    issue_total numeric(10),
    inforce_pct numeric(5,2),
    lapse_pct numeric(5,2),
    non_orph_total numeric(10),
    non_orph_inforce_pct numeric(5,2),
    non_orph_lapse_pct numeric(5,2),
    orph_total numeric(10),
    orph_inforce_pct numeric(5,2),
    orph_lapse_pct numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.tmis_pol221 (
    orph_ind varchar(1) not null,
    br_code varchar(5) not null,
    unit_code varchar(5) not null,
    prod_line varchar(1) not null,
    issue_total numeric(10),
    inforce_pct numeric(5,2),
    lapse_pct numeric(5,2),
    lapse_pct_1_3 numeric(5,2),
    lapse_pct_4_6 numeric(5,2),
    lapse_pct_7_9 numeric(5,2),
    lapse_pct_10_12 numeric(5,2),
    lapse_pct_13 numeric(5,2),
    lapse_pct_14_15 numeric(5,2),
    lapse_pct_16_24 numeric(5,2),
    lapse_pct_25 numeric(5,2),
    lapse_pct_26_36 numeric(5,2),
    lapse_pct_over36 numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.tmis_pol223 (
    orph_ind varchar(1) not null,
    lapse_cat varchar(1) not null,
    br_code varchar(5) not null,
    unit_code varchar(5) not null,
    agt_code varchar(5) not null,
    prod_line varchar(1) not null,
    issue_total numeric(10),
    inforce_pct numeric(5,2),
    lapse_pct numeric(5,2),
    lapse_pct_1_3 numeric(5,2),
    lapse_pct_4_6 numeric(5,2),
    lapse_pct_7_12 numeric(5,2),
    lapse_pct_13 numeric(5,2),
    lapse_pct_14_24 numeric(5,2),
    lapse_pct_over24 numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.tmis_pol225 (
    fran_num varchar(10) not null,
    insureds numeric(10),
    prods varchar(30),
    agt_code varchar(20),
    issue_total numeric(10),
    inforce_pct numeric(5,2),
    lapse_pct numeric(5,2),
    lapse_pct_1_3 numeric(5,2),
    lapse_pct_4_6 numeric(5,2),
    lapse_pct_7_12 numeric(5,2),
    lapse_pct_13 numeric(5,2),
    lapse_pct_14_24 numeric(5,2),
    lapse_pct_over24 numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.tmis_policys_prem_hist (
    pol_num varchar(10) not null,
    prem_dt timestamp not null,
    dscnt_prem numeric(13,2) not null,
    pol_stat_cd varchar(1) not null,
    rec_crea_dt timestamp not null
);

CREATE TABLE IF NOT EXISTS cas.tmis_prem_persistency_hist (
    gen_seq numeric not null,
    show_seq numeric,
    run_dt timestamp not null,
    rpt_mth varchar(10) not null,
    gen_dt timestamp,
    iw_tot_com_in_sp_prem_iss numeric,
    iw_tot_com_in_sp_prem_infor numeric,
    iw_tot_com_in_sp_prem_ratio numeric,
    iw_tot_com_ex_sp_prem_iss numeric,
    iw_tot_com_ex_sp_prem_infor numeric,
    iw_tot_com_ex_sp_prem_ratio numeric,
    iw_agt_in_sp_prem_iss numeric,
    iw_agt_in_sp_prem_infor numeric,
    iw_agt_in_sp_prem_ratio numeric,
    iw_agt_ex_sp_prem_iss numeric,
    iw_agt_ex_sp_prem_infor numeric,
    iw_agt_ex_sp_prem_ratio numeric,
    iw_non_agt_in_sp_prem_iss numeric,
    iw_non_agt_in_sp_prem_infor numeric,
    iw_non_agt_in_sp_prem_ratio numeric,
    iw_non_agt_ex_sp_prem_iss numeric,
    iw_non_agt_ex_sp_prem_infor numeric,
    iw_non_agt_ex_sp_prem_ratio numeric,
    i_tot_com_in_sp_prem_iss numeric,
    i_tot_com_in_sp_prem_infor numeric,
    i_tot_com_in_sp_prem_ratio numeric,
    i_tot_com_ex_sp_prem_iss numeric,
    i_tot_com_ex_sp_prem_infor numeric,
    i_tot_com_ex_sp_prem_ratio numeric,
    i_agt_in_sp_prem_iss numeric,
    i_agt_in_sp_prem_infor numeric,
    i_agt_in_sp_prem_ratio numeric,
    i_agt_ex_sp_prem_iss numeric,
    i_agt_ex_sp_prem_infor numeric,
    i_agt_ex_sp_prem_ratio numeric,
    i_non_agt_in_sp_prem_iss numeric,
    i_non_agt_in_sp_prem_infor numeric,
    i_non_agt_in_sp_prem_ratio numeric,
    i_non_agt_ex_sp_prem_iss numeric,
    i_non_agt_ex_sp_prem_infor numeric,
    i_non_agt_ex_sp_prem_ratio numeric,
    w_tot_com_in_sp_prem_iss numeric,
    w_tot_com_in_sp_prem_infor numeric,
    w_tot_com_in_sp_prem_ratio numeric,
    w_tot_com_ex_sp_prem_iss numeric,
    w_tot_com_ex_sp_prem_infor numeric,
    w_tot_com_ex_sp_prem_ratio numeric,
    w_agt_in_sp_prem_iss numeric,
    w_agt_in_sp_prem_infor numeric,
    w_agt_in_sp_prem_ratio numeric,
    w_agt_ex_sp_prem_iss numeric,
    w_agt_ex_sp_prem_infor numeric,
    w_agt_ex_sp_prem_ratio numeric,
    w_non_agt_in_sp_prem_iss numeric,
    w_non_agt_in_sp_prem_infor numeric,
    w_non_agt_in_sp_prem_ratio numeric,
    w_non_agt_ex_sp_prem_iss numeric,
    w_non_agt_ex_sp_prem_infor numeric,
    w_non_agt_ex_sp_prem_ratio numeric,
    gen_rpt_typ varchar(1),
    rpt_mth_ind numeric,
    excl_plan_rep_ind varchar(1),
    grc_prd varchar(20),
    report_dt varchar(6)
);

CREATE TABLE IF NOT EXISTS cas.tmis_prem_persistency_rep (
    gen_seq numeric,
    show_seq numeric,
    run_dt timestamp,
    rpt_mth varchar(10),
    gen_dt timestamp,
    iw_tot_com_in_sp_prem_iss numeric,
    iw_tot_com_in_sp_prem_infor numeric,
    iw_tot_com_in_sp_prem_ratio numeric,
    iw_tot_com_ex_sp_prem_iss numeric,
    iw_tot_com_ex_sp_prem_infor numeric,
    iw_tot_com_ex_sp_prem_ratio numeric,
    iw_agt_in_sp_prem_iss numeric,
    iw_agt_in_sp_prem_infor numeric,
    iw_agt_in_sp_prem_ratio numeric,
    iw_agt_ex_sp_prem_iss numeric,
    iw_agt_ex_sp_prem_infor numeric,
    iw_agt_ex_sp_prem_ratio numeric,
    iw_non_agt_in_sp_prem_iss numeric,
    iw_non_agt_in_sp_prem_infor numeric,
    iw_non_agt_in_sp_prem_ratio numeric,
    iw_non_agt_ex_sp_prem_iss numeric,
    iw_non_agt_ex_sp_prem_infor numeric,
    iw_non_agt_ex_sp_prem_ratio numeric,
    i_tot_com_in_sp_prem_iss numeric,
    i_tot_com_in_sp_prem_infor numeric,
    i_tot_com_in_sp_prem_ratio numeric,
    i_tot_com_ex_sp_prem_iss numeric,
    i_tot_com_ex_sp_prem_infor numeric,
    i_tot_com_ex_sp_prem_ratio numeric,
    i_agt_in_sp_prem_iss numeric,
    i_agt_in_sp_prem_infor numeric,
    i_agt_in_sp_prem_ratio numeric,
    i_agt_ex_sp_prem_iss numeric,
    i_agt_ex_sp_prem_infor numeric,
    i_agt_ex_sp_prem_ratio numeric,
    i_non_agt_in_sp_prem_iss numeric,
    i_non_agt_in_sp_prem_infor numeric,
    i_non_agt_in_sp_prem_ratio numeric,
    i_non_agt_ex_sp_prem_iss numeric,
    i_non_agt_ex_sp_prem_infor numeric,
    i_non_agt_ex_sp_prem_ratio numeric,
    w_tot_com_in_sp_prem_iss numeric,
    w_tot_com_in_sp_prem_infor numeric,
    w_tot_com_in_sp_prem_ratio numeric,
    w_tot_com_ex_sp_prem_iss numeric,
    w_tot_com_ex_sp_prem_infor numeric,
    w_tot_com_ex_sp_prem_ratio numeric,
    w_agt_in_sp_prem_iss numeric,
    w_agt_in_sp_prem_infor numeric,
    w_agt_in_sp_prem_ratio numeric,
    w_agt_ex_sp_prem_iss numeric,
    w_agt_ex_sp_prem_infor numeric,
    w_agt_ex_sp_prem_ratio numeric,
    w_non_agt_in_sp_prem_iss numeric,
    w_non_agt_in_sp_prem_infor numeric,
    w_non_agt_in_sp_prem_ratio numeric,
    w_non_agt_ex_sp_prem_iss numeric,
    w_non_agt_ex_sp_prem_infor numeric,
    w_non_agt_ex_sp_prem_ratio numeric,
    gen_rpt_typ varchar(1),
    rpt_mth_ind numeric,
    excl_plan_rep_ind varchar(1),
    grc_prd varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.tmis_prem_pers_excl_plans (
    plan_code varchar(5),
    vers_num varchar(2),
    crcy_code varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tmis_schedule (
    runno varchar(8) not null,
    ref_dt timestamp,
    month_ind varchar(1),
    year_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tmis_smc010 (
    br_code varchar(5) not null,
    br_name varchar(20),
    br_mgr_cd varchar(5),
    br_mgr_nm varchar(20),
    un_code varchar(5) not null,
    un_name varchar(20),
    un_mgr_cd varchar(5),
    un_mgr_nm varchar(20),
    agt_code varchar(5) not null,
    agt_name varchar(20),
    agt_stat_cd varchar(2),
    d_smc_case numeric(6,1),
    d_non_smc_case numeric(6,1),
    mtd_smc_case numeric(6,1),
    mtd_non_smc_case numeric(6,1),
    smc_clients numeric(10)
);

CREATE TABLE IF NOT EXISTS cas.tmis_smc020 (
    br_code varchar(5),
    unit_code varchar(5),
    agt_code varchar(5),
    agt_nm varchar(20),
    cli_num numeric(10),
    pol_num numeric(10)
);

CREATE TABLE IF NOT EXISTS cas.tmis_units (
    un_code varchar(5) not null,
    un_stat_code varchar(2),
    un_nm varchar(20),
    mgr_code varchar(5),
    br_code varchar(5),
    supervisor_code varchar(5),
    loc_code varchar(10),
    un_eff_dt timestamp,
    un_term_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tmode_min_prem (
    pmt_mode varchar(5) not null,
    min_prem numeric(11,2),
    restricted_bill_mthd varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tmoney_value_desc_sg (
    dollar_or_cents varchar(1),
    position numeric(2),
    word varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.tmortalitys (
    md_key varchar(10) not null,
    md_type varchar(1) not null,
    eff_fr_dt timestamp not null,
    eff_dur numeric(3) not null,
    eff_to_dt timestamp,
    qx numeric(13,6) not null,
    sex_code varchar(1) not null,
    unit_basis varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tmortalitys_layout (
    md_key_pos numeric(3),
    md_key_len numeric(3),
    md_type_pos numeric(3),
    md_type_len numeric(3),
    eff_fr_dt_pos numeric(3),
    eff_fr_dt_len numeric(3),
    eff_dur_pos numeric(3),
    eff_dur_len numeric(3),
    eff_to_dt_pos numeric(3),
    eff_to_dt_len numeric(3),
    qx_pos numeric(3),
    qx_len numeric(3),
    sex_code_pos numeric(3),
    sex_code_len numeric(3),
    unit_basis_pos numeric(3),
    unit_basis_len numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tmp_auto_reject (
    pol_num varchar(10),
    amt numeric(11,2),
    return_code varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tmp_cbd_1630 (
    btch_num varchar(20) not null,
    btch_role varchar(2) not null,
    pol_num varchar(10) not null,
    cbd_num numeric(4) not null,
    eff_dt timestamp not null,
    trxn_dt timestamp not null,
    trxn_cd varchar(8) not null,
    reasn_code varchar(3) not null,
    trxn_amt numeric(11,2) not null,
    remarks varchar(100),
    btch_dtl_stat_cd varchar(1),
    result_cd varchar(5),
    clr_cd varchar(2),
    bank_cd varchar(13),
    chq_no_text varchar(20),
    chq_dt timestamp,
    off_rcpt_num numeric(10),
    acct_mne_cd varchar(8),
    card_xpry_dt varchar(4),
    check_amt numeric(13,2),
    check_num varchar(8),
    collect_dt timestamp,
    col_crcy_code varchar(2),
    col_trxn_amt numeric(11,2),
    credit_num varchar(16),
    dnr_reasn_code varchar(10),
    exchg_rt numeric(18,8),
    indirect varchar(1),
    iss_bank varchar(30),
    pd_to_dt timestamp,
    pmt_mode varchar(5),
    receipt_num varchar(7),
    report_no numeric(3),
    trxn_id varchar(15),
    auto_ur_fail_ind varchar(1),
    no_pol_crcy_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tmp_cbh_1630 (
    btch_num varchar(20) not null,
    btch_role varchar(2) not null,
    btch_dt timestamp,
    btch_typ varchar(4) not null,
    btch_tot numeric(13,2) not null,
    crcy_code varchar(2) not null,
    btch_stat_code varchar(1) not null,
    recpt_stat_code varchar(1) not null,
    trxn_dt timestamp not null,
    user_id varchar(30),
    dist_chnl_cd varchar(2),
    off_loc_cd varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.tmp_commerr_sg (
    pol_num varchar(10) not null
);

CREATE TABLE IF NOT EXISTS cas.tmp_mvy_hist_details (
    pol_num varchar(10) not null,
    mvy_seq numeric(4) not null,
    seq_num numeric(4) not null,
    ded_amt numeric(11,2),
    acct_mne_cd varchar(8),
    plan_code varchar(5),
    vers_num varchar(2),
    cli_num varchar(13),
    chrg_typ varchar(10),
    layer_eff_dt timestamp,
    prem_dur numeric(3),
    chrg_lyr varchar(1),
    chrg_lvl varchar(1),
    chrg_mth numeric(5),
    fnd_id varchar(5),
    fnd_vers varchar(6),
    cvg_eff_dt timestamp,
    bef_dscnt_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tmp_mvy_hist_headers (
    pol_num varchar(10) not null,
    mvy_seq numeric(4) not null,
    tot_amt numeric(11,2),
    curr_mvy_dt timestamp,
    ovrdu_dt timestamp,
    lapse_dt timestamp,
    defr_reasn varchar(1) not null,
    layer_eff_dt timestamp not null,
    layer_typ varchar(1) not null,
    test_lvl numeric(1) not null,
    mvy_ded_ind varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tmp_nfo_value_sg (
    pol_num varchar(10),
    asof_dt timestamp,
    cv_pol numeric(13,2),
    pv_pol numeric(13,2),
    cv_pua numeric(13,2),
    unearn_prem numeric(11,2),
    surr_valu numeric(13,2),
    lapse_valu numeric(13,2),
    rsdue_valu numeric(13,2),
    div_valu numeric(11,2),
    endow_valu numeric(13,2),
    anty_valu numeric(13,2),
    lump_sum_valu numeric(13,2),
    loan_valu numeric(13,2),
    max_loan numeric(13,2),
    max_loan_apl numeric(13,2),
    rfnd_rv numeric(11,2),
    rfnd_prem numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tmp_rates (
    face_amt_lo numeric(13,2),
    sex_code varchar(1),
    smkr_code varchar(1),
    eff_age numeric(3),
    prem_05 numeric(10,3),
    prem_06 numeric(10,3),
    prem_07 numeric(10,3),
    prem_08 numeric(10,3),
    prem_09 numeric(10,3),
    prem_10 numeric(10,3),
    prem_11 numeric(10,3),
    prem_12 numeric(10,3),
    prem_13 numeric(10,3),
    prem_14 numeric(10,3),
    prem_15 numeric(10,3),
    prem_16 numeric(10,3),
    prem_17 numeric(10,3),
    prem_18 numeric(10,3),
    prem_19 numeric(10,3),
    prem_20 numeric(10,3),
    prem_21 numeric(10,3),
    prem_22 numeric(10,3),
    prem_23 numeric(10,3),
    prem_24 numeric(10,3),
    prem_25 numeric(10,3),
    prem_26 numeric(10,3),
    prem_27 numeric(10,3),
    prem_28 numeric(10,3),
    prem_29 numeric(10,3),
    prem_30 numeric(10,3),
    prem_31 numeric(10,3),
    prem_32 numeric(10,3),
    prem_33 numeric(10,3),
    prem_34 numeric(10,3),
    prem_35 numeric(10,3),
    prem_36 numeric(10,3),
    prem_37 numeric(10,3),
    prem_38 numeric(10,3),
    prem_39 numeric(10,3),
    prem_40 numeric(10,3)
);

CREATE TABLE IF NOT EXISTS cas.tmp_reinst_value (
    pol_num varchar(10),
    seq_num numeric(6),
    reinst_date timestamp,
    pd_to_dt timestamp,
    plan_code varchar(5),
    cli_num varchar(13),
    cvg_eff_dt timestamp,
    os_prem numeric(13,2),
    risk_prem numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tmp_tactivity_schedules (
    pol_num varchar(10) not null,
    actv_dt timestamp not null,
    asc_num numeric(4) not null,
    actv_reasn varchar(10) not null,
    actv_typ varchar(3) not null
);

CREATE TABLE IF NOT EXISTS cas.tmp_tautopay_histories_th (
    trxn_dt timestamp,
    pol_num varchar(10),
    pd_to_dt timestamp,
    prem numeric(11,2),
    bank_cd varchar(13),
    bank_acct_num varchar(20),
    bank_sv_kd varchar(1),
    id_num varchar(20),
    pac_bk_ctr varchar(1),
    client_nm varchar(80),
    pol_crcy_code varchar(2),
    pol_crcy_prem numeric(11,2),
    exchg_rt numeric(18,8),
    run_dt timestamp,
    autopay_status varchar(1),
    reject_reasn_cd varchar(10),
    trxn_id varchar(15),
    autopay_col_dt timestamp,
    autopay_reject_dt timestamp,
    bank_debit_dt timestamp,
    trxn_amt numeric(11,2),
    bank_fee_ind varchar(1),
    bank_fee_amt numeric(11,4),
    bill_mthd varchar(1),
    fran_num varchar(4),
    acct_typ varchar(1),
    acct_xpry_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tmp_tauto_feed_files (
    bank_code varchar(13),
    file_name varchar(20),
    dataline varchar(200),
    result_cd varchar(5),
    pol_num varchar(17),
    trxn_amt numeric(11,2),
    trxn_dt timestamp,
    file_num varchar(5),
    feed_date timestamp,
    acct_num varchar(20),
    off_loc_cd varchar(5),
    dist_chnl_cd varchar(2),
    crcy_code varchar(2),
    c_cpf_inv_acct varchar(20),
    c_nric_no varchar(20),
    c_cust_name varchar(80),
    c_authorise varchar(1),
    c_pol_name varchar(40),
    c_collect_ind varchar(1),
    c_batch_serial varchar(6),
    c_internal_ref varchar(6),
    h_cpf_acct varchar(9),
    h_house_ref varchar(12),
    h_name varchar(66),
    h_coy_cde varchar(2),
    reject_cd varchar(10),
    bank_cd varchar(13),
    bank_deb_dt timestamp,
    pac_upd varchar(1),
    prem_amt numeric(11,2),
    bank_fee_ind varchar(1),
    bank_fee_amt numeric(11,4),
    pd_to_dt timestamp,
    bill_mthd varchar(1),
    fran_num varchar(4),
    acct_typ varchar(1),
    acct_xpry_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tmp_tcbd_1617 (
    btch_num varchar(20) not null,
    btch_role varchar(2) not null,
    pol_num varchar(10) not null,
    cbd_num numeric(4) not null,
    eff_dt timestamp not null,
    trxn_dt timestamp not null,
    trxn_cd varchar(8) not null,
    reasn_code varchar(3) not null,
    trxn_amt numeric(11,2) not null,
    remarks varchar(100),
    btch_dtl_stat_cd varchar(1),
    result_cd varchar(5),
    clr_cd varchar(2),
    bank_cd varchar(13),
    chq_no_text varchar(20),
    chq_dt timestamp,
    off_rcpt_num numeric(10),
    acct_mne_cd varchar(8),
    card_xpry_dt varchar(4),
    check_amt numeric(13,2),
    check_num varchar(8),
    collect_dt timestamp,
    col_crcy_code varchar(2),
    col_trxn_amt numeric(11,2),
    credit_num varchar(16),
    dnr_reasn_code varchar(10),
    exchg_rt numeric(18,8),
    indirect varchar(1),
    iss_bank varchar(30),
    pd_to_dt timestamp,
    pmt_mode varchar(5),
    receipt_num varchar(7),
    report_no numeric(3),
    trxn_id varchar(15),
    auto_ur_fail_ind varchar(1),
    no_pol_crcy_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tmp_twrk_activity_schedules (
    pol_num varchar(10) not null,
    actv_dt timestamp not null,
    asc_num numeric(4) not null,
    actv_reasn varchar(10) not null,
    actv_typ varchar(3) not null,
    actv_seq numeric(2),
    proc_dt timestamp,
    ref_date varchar(30),
    freeze_dt timestamp,
    freeze_by varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.tmp_twrk_activity_schedules_sg (
    pol_num varchar(10) not null,
    actv_dt timestamp not null,
    asc_num numeric(4) not null,
    actv_reasn varchar(10) not null,
    actv_typ varchar(3) not null
);

CREATE TABLE IF NOT EXISTS cas.tmthly_accumulations (
    as_of_dt timestamp not null,
    acum_type varchar(10),
    acum_tot numeric(15,2)
);

CREATE TABLE IF NOT EXISTS cas.tmvy_ded_details (
    pol_num varchar(10) not null,
    mvy_seq numeric(4) not null,
    seq_num numeric(4) not null,
    ded_amt numeric(11,2),
    acct_mne_cd varchar(8),
    plan_code varchar(5),
    vers_num varchar(2),
    cli_num varchar(13),
    chrg_typ varchar(10),
    crcy_code varchar(2),
    trxn_id varchar(15),
    undo_trxn_id varchar(15)
);

CREATE TABLE IF NOT EXISTS cas.tmvy_ded_headers (
    pol_num varchar(10) not null,
    curr_mvy_dt timestamp not null,
    mvy_seq numeric(3) not null,
    layer_typ varchar(1) not null,
    layer_eff_dt timestamp not null,
    proc_seq numeric(3) not null,
    trxn_id varchar(15) not null,
    trxn_dt timestamp,
    mvy_ded_to_dt timestamp,
    undo_trxn_id varchar(15)
);

CREATE TABLE IF NOT EXISTS cas.tmvy_ded_prem_grp_mappings (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    prem_grp varchar(3) not null,
    crcy_code varchar(2) default '*' not null
);

CREATE TABLE IF NOT EXISTS cas.tmvy_hist_details (
    pol_num varchar(10) not null,
    mvy_seq numeric(4) not null,
    seq_num numeric(4) not null,
    ded_amt numeric(11,2),
    acct_mne_cd varchar(8),
    plan_code varchar(5),
    vers_num varchar(2),
    cli_num varchar(13),
    chrg_typ varchar(10),
    layer_eff_dt timestamp,
    prem_dur numeric(3),
    chrg_lyr varchar(1),
    chrg_lvl varchar(1),
    chrg_mth numeric(5),
    fnd_id varchar(5),
    fnd_vers varchar(6),
    cvg_eff_dt timestamp,
    bef_dscnt_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tmvy_hist_headers (
    pol_num varchar(10) not null,
    mvy_seq numeric(4) not null,
    tot_amt numeric(11,2),
    curr_mvy_dt timestamp,
    ovrdu_dt timestamp,
    lapse_dt timestamp,
    defr_reasn varchar(1) not null,
    layer_eff_dt timestamp not null,
    layer_typ varchar(1) not null,
    test_lvl numeric(1) not null,
    mvy_ded_ind varchar(1) not null,
    lapse_ded_amt numeric(11,2),
    proc_seq numeric(3) not null,
    catchup_end_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tnb_batch_seq (
    cas_dt timestamp,
    batch_seq varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tnb_case (
    pol_num varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tnfo_value_sg (
    pol_num varchar(10),
    asof_dt timestamp,
    cv_pol numeric(13,2),
    pv_pol numeric(13,2),
    cv_pua numeric(13,2),
    unearn_prem numeric(11,2),
    surr_valu numeric(13,2),
    lapse_valu numeric(13,2),
    rsdue_valu numeric(13,2),
    div_valu numeric(11,2),
    endow_valu numeric(13,2),
    anty_valu numeric(13,2),
    lump_sum_valu numeric(13,2),
    loan_valu numeric(13,2),
    max_loan numeric(13,2),
    max_loan_apl numeric(13,2),
    rfnd_rv numeric(11,2),
    rfnd_prem numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tnh_doc_req (
    ee_req_num numeric(8) not null,
    doc_rec_hq timestamp,
    doc_rec_br timestamp,
    comp_doc_flg varchar(1),
    cl_typ varchar(1) not null,
    cl_grp varchar(8) not null,
    desc_amend_ind varchar(1),
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp
);

CREATE TABLE IF NOT EXISTS cas.tnlg_validations (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    iss_age_fr numeric(3) not null,
    iss_age_to numeric(3) not null,
    max_sa_fct numeric(3) not null
);

CREATE TABLE IF NOT EXISTS cas.tnsp_values (
    plan_code varchar(5) not null,
    pol_val_vers varchar(2) not null,
    nsp_typ varchar(1) not null,
    sex_code varchar(1) not null,
    eff_age numeric(3) not null,
    eff_dur numeric(3) not null,
    nsp_rt_aftr numeric(14,7) not null,
    nsp_rt_before numeric(14,7) not null,
    unit_basis varchar(1) not null,
    z_factor numeric(5,4),
    crcy_code varchar(2) default '*' not null,
    band_low numeric(13,2) default '-1' not null,
    band_high numeric(13,2) default '-1' not null,
    sec_age numeric(3) default -1 not null,
    prem_prd numeric(3) default '-1' not null,
    eff_mth numeric(2) default 0 not null,
    bnft_prd numeric(3) default -1 not null
);

CREATE TABLE IF NOT EXISTS cas.tnsp_values_layout (
    plan_code_pos numeric(3),
    plan_code_len numeric(3),
    pol_val_vers_pos numeric(3),
    pol_val_vers_len numeric(3),
    nsp_typ_pos numeric(3),
    nsp_typ_len numeric(3),
    sex_code_pos numeric(3),
    sex_code_len numeric(3),
    eff_age_pos numeric(3),
    eff_age_len numeric(3),
    eff_dur_pos numeric(3),
    eff_dur_len numeric(3),
    nsp_rt_aftr_pos numeric(3),
    nsp_rt_aftr_len numeric(3),
    nsp_rt_before_pos numeric(3),
    nsp_rt_before_len numeric(3),
    unit_basis_pos numeric(3),
    unit_basis_len numeric(3),
    z_factor_len numeric(3),
    z_factor_pos numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tnsp_values_load (
    plan_code varchar(5),
    pol_val_vers varchar(2),
    nsp_typ varchar(1),
    sex_code varchar(1),
    eff_age numeric(3),
    eff_dur numeric(3),
    nsp_rt_aftr numeric(7,2),
    nsp_rt_before numeric(7,2),
    unit_basis varchar(1),
    z_factor numeric(5,4)
);

CREATE TABLE IF NOT EXISTS cas.tntc_gen_lst_sg (
    fcn_id varchar(20),
    pol_num varchar(20),
    cas_dt timestamp,
    valid_addr_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tnt_progress (
    pol_num varchar(10) not null,
    proc_date timestamp not null,
    prog_record varchar(800) not null,
    reason_code varchar(6),
    medical_stat varchar(1),
    user_id varchar(10),
    remark varchar(100)
);

CREATE TABLE IF NOT EXISTS cas.tnt_attention (
    pol_num varchar(10) not null,
    proc_date timestamp not null,
    event_seq numeric(6) not null,
    event varchar(120) not null
);

CREATE TABLE IF NOT EXISTS cas.tnt_cpf_bill (
    pol_num varchar(10) not null,
    bill_dt timestamp,
    cpf_reqst_prem numeric(11,2),
    cpf_prem_reqst_typ varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tnt_cpf_bill_hist (
    pol_num varchar(10),
    bill_dt timestamp,
    cas_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tnt_cpf_rfnd (
    pol_num varchar(10) not null,
    rfnd_dt timestamp,
    cpf_payable numeric(11,2),
    cpf_paid numeric(11,2),
    cpf_rfnd_reqst_typ varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.tnt_exam_item (
    age_low numeric(4,2) not null,
    age_high numeric(2) not null,
    face_amt_low numeric(10) not null,
    face_amt_high numeric(10) not null,
    nm_ind varchar(1),
    ekg_ind varchar(1),
    bt_ind varchar(1),
    mc_ind varchar(1),
    cxr_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tnt_f409 (
    pol_num varchar(10) not null,
    proc_date timestamp not null,
    f4_seq numeric(6) not null,
    sub_f4 varchar(100) not null
);

CREATE TABLE IF NOT EXISTS cas.tnt_f856 (
    pol_num varchar(10) not null,
    proc_date timestamp not null,
    f8_seq numeric(6) not null,
    sub_f8 varchar(100) not null
);

CREATE TABLE IF NOT EXISTS cas.tnt_field_descriptions (
    fld_nm varchar(30) not null,
    fld_nm_desc varchar(50) not null,
    rec_status varchar(1) not null,
    sys_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tnt_field_values (
    fld_nm varchar(30) not null,
    fld_valu varchar(10) not null,
    fld_valu_desc varchar(100) not null,
    rec_status varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tnt_field_values_sg (
    fld_nm varchar(30) not null,
    fld_valu varchar(10) not null,
    fld_valu_desc varchar(100) not null,
    rec_status varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tnt_material (
    pol_num varchar(10) not null,
    proc_date timestamp not null,
    mat_seq numeric(6) not null,
    material varchar(50) not null
);

CREATE TABLE IF NOT EXISTS cas.tnt_med_lmt (
    nt_role varchar(2),
    med_ind varchar(1),
    face_amthigh numeric(14,2),
    rating varchar(20),
    rating1 varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tnt_med_reqt (
    pol_num varchar(10) not null,
    med_reqt_seq numeric(6) not null,
    med_reqt varchar(50) not null,
    start_dt timestamp,
    end_dt timestamp,
    remarks varchar(250)
);

CREATE TABLE IF NOT EXISTS cas.tnt_mib (
    id_num varchar(10) not null,
    face_amt numeric(15,2)
);

CREATE TABLE IF NOT EXISTS cas.tnt_modi (
    pol_num varchar(10) not null,
    proc_date timestamp not null,
    mod_seq numeric(6) not null,
    modi_event varchar(50) not null
);

CREATE TABLE IF NOT EXISTS cas.tnt_mort (
    pol_num varchar(10) not null,
    mort_code1 varchar(6),
    mort_code2 varchar(6),
    mort_code3 varchar(6)
);

CREATE TABLE IF NOT EXISTS cas.tnt_nonmed_lmt (
    nt_role varchar(2),
    nonmed_ind varchar(1),
    face_amthigh numeric(14,2),
    age_low numeric(4,2),
    age_high numeric(2)
);

CREATE TABLE IF NOT EXISTS cas.tnt_others (
    pol_num varchar(10) not null,
    others_seq numeric(6) not null,
    others varchar(250) not null,
    start_dt timestamp,
    end_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tnt_outst_docs (
    pol_num varchar(10) not null,
    out_doc_seq numeric(6) not null,
    out_doc varchar(50) not null,
    start_dt timestamp,
    end_dt timestamp,
    remarks varchar(250)
);

CREATE TABLE IF NOT EXISTS cas.tnt_pa_lmt (
    nt_role varchar(2),
    pc_face_amt numeric(14,2)
);

CREATE TABLE IF NOT EXISTS cas.tnt_prem_iss (
    pol_num varchar(10) not null,
    prem_iss_seq numeric(6) not null,
    prem_iss varchar(50) not null,
    start_dt timestamp,
    end_dt timestamp,
    remarks varchar(250)
);

CREATE TABLE IF NOT EXISTS cas.tnt_progress_histories (
    pol_num varchar(10) not null,
    trxn_date timestamp not null,
    phi_num numeric(6) not null,
    progress varchar(400),
    trxn_code varchar(6) not null,
    folup_date timestamp,
    user_id varchar(10) not null,
    pend_code varchar(10),
    rev_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tnt_rate (
    pol_num varchar(10) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    rating varchar(10),
    cvg_typ varchar(1),
    ntr_seq numeric(7) not null
);

CREATE TABLE IF NOT EXISTS cas.tnt_remark (
    pol_num varchar(10) not null,
    proc_date timestamp not null,
    remark varchar(100),
    remark1 varchar(100),
    remark3 varchar(100)
);

CREATE TABLE IF NOT EXISTS cas.tnt_roles (
    nt_role varchar(2),
    nt_user varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.tnt_substd_cde (
    pol_num varchar(10) not null,
    substd_cde1 varchar(10),
    substd_cde2 varchar(10),
    link_typ varchar(1) not null,
    cli_num varchar(13)
);

CREATE TABLE IF NOT EXISTS cas.tnt_supp_quest (
    pol_num varchar(10) not null,
    supp_quest_seq numeric(6) not null,
    supp_quest varchar(50) not null,
    start_dt timestamp,
    end_dt timestamp,
    remarks varchar(250)
);

CREATE TABLE IF NOT EXISTS cas.tnt_uw (
    pol_num varchar(10) not null,
    userid varchar(30) not null,
    start_dt timestamp,
    end_dt timestamp,
    an_income numeric(13,2),
    exist_pol numeric(13,2),
    new_app numeric(13,2),
    total numeric(13,2),
    justify varchar(1),
    uv_com text
);

CREATE TABLE IF NOT EXISTS cas.tnt_uw_progress (
    pol_num varchar(10) not null,
    uw_progress_seq numeric(6) not null,
    remarks varchar(60) not null
);

CREATE TABLE IF NOT EXISTS cas.tnt_uw_req (
    pol_num varchar(10) not null,
    proc_date timestamp not null,
    uw_seq numeric(6) not null,
    uw_req varchar(50) not null
);

CREATE TABLE IF NOT EXISTS cas.tnumtoword_sg (
    dollar_or_cents varchar(1),
    mod_pos numeric(2),
    len numeric(2),
    value numeric(2),
    word varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.toccupation (
    occp_code varchar(10) not null,
    occp_desc varchar(150) not null,
    occp_clas varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tofficial_receipts (
    user_nm varchar(10) not null,
    beg_or_num numeric(10),
    end_or_num numeric(10),
    current_or_num numeric(10),
    date_modified timestamp,
    modified_by varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.torphan_asign_tw (
    asign_agt varchar(5) not null,
    asign_dt timestamp not null,
    pol_num varchar(10) not null,
    pd_to_dt timestamp not null,
    pol_stat_cd varchar(1) not null,
    pmt_mode varchar(1) not null,
    dscnt_prem numeric(11,2) not null,
    cnfrm_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.torphan_policies (
    pol_num varchar(10) not null,
    trmn_agt varchar(6) not null,
    trxn_dt timestamp not null,
    asign_dt timestamp,
    asign_agt varchar(6),
    cnfrm_dt timestamp,
    letter_gen_ind varchar(1),
    orph_typ_ind varchar(1),
    wa_ind varchar(1),
    sa_ind varchar(1),
    ca_ind varchar(1),
    complete_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.toverloan_actv_days (
    fr_cv_loan_pct numeric(5,2) not null,
    to_cv_loan_pct numeric(5,2) not null,
    actv_days numeric(3) not null
);

CREATE TABLE IF NOT EXISTS cas.tpac_bk_ctr (
    pol_num varchar(10),
    pac_bk_ctr varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpage3_pa_schd (
    plan_code varchar(5) not null,
    pol_val_vers varchar(2) not null,
    eff_age numeric(3) not null,
    face_amt_lif numeric(13,2),
    prem_amt_lif numeric(11,2),
    face_amt_med numeric(13,2),
    prem_amt_med numeric(11,2),
    face_amt_rc1 numeric(13,2),
    prem_amt_rc1 numeric(11,2),
    face_amt_rc2 numeric(13,2),
    prem_amt_rc2 numeric(11,2),
    face_amt_dv1 numeric(13,2),
    prem_amt_dv1 numeric(11,2),
    face_amt_dv2 numeric(13,2),
    prem_amt_dv2 numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tpage3_plans_info (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    face_amt_disp varchar(1),
    wait_perd numeric(3),
    wait_perd_unit varchar(2),
    max_bnft_perd numeric(3),
    max_bnft_perd_unit varchar(2),
    plan_desc varchar(100),
    prem_grnt_ind varchar(1),
    agt_face_amt_disp varchar(1),
    crcy_code varchar(2) default '*' not null
);

CREATE TABLE IF NOT EXISTS cas.tpage3_prt_seq (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    crcy_code varchar(2) not null,
    seq_num numeric(10)
);

CREATE TABLE IF NOT EXISTS cas.tpage3_rates (
    rate_typ varchar(6) not null,
    plan_code varchar(5) not null,
    sex_code varchar(1) not null,
    eff_dt timestamp not null,
    eff_age numeric(3) not null,
    eff_dur numeric(3) not null,
    unit_basis varchar(1) not null,
    rate numeric(9,4) not null,
    vers_num varchar(2) default '01' not null,
    crcy_code varchar(2) default '*' not null
);

CREATE TABLE IF NOT EXISTS cas.tpage3_rates_layout (
    rate_typ_pos numeric(3),
    rate_typ_len numeric(3),
    plan_code_pos numeric(3),
    plan_code_len numeric(3),
    sex_code_pos numeric(3),
    sex_code_len numeric(3),
    eff_dt_pos numeric(3),
    eff_dt_len numeric(3),
    eff_age_pos numeric(3),
    eff_age_len numeric(3),
    eff_dur_pos numeric(3),
    eff_dur_len numeric(3),
    unit_basis_pos numeric(3),
    unit_basis_len numeric(3),
    rate_pos numeric(3),
    rate_len numeric(3),
    vers_num_pos numeric(3),
    vers_num_len numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tpage3_rates_load (
    rate_typ varchar(6),
    plan_code varchar(5),
    sex_code varchar(1),
    eff_dt timestamp,
    eff_age numeric(3),
    eff_dur numeric(3),
    unit_basis varchar(1),
    rate numeric(9,4),
    ver_nums varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tpage3_rates_th (
    plan_code varchar(5) not null,
    pol_val_vers varchar(2) not null,
    sex_code varchar(1) not null,
    eff_age numeric(3) not null,
    eff_dur numeric(3) not null,
    cv_rt numeric(9,4),
    rpu_rt numeric(9,4),
    rpu_rfnd numeric(9,4),
    eti_rt numeric(9,4),
    eti_yr numeric(3),
    eti_dy numeric(3),
    eti_rfnd numeric(9,4)
);

CREATE TABLE IF NOT EXISTS cas.tpage3_remarks (
    set_num numeric(3) not null,
    line_num numeric(3) not null,
    remark_line varchar(200)
);

CREATE TABLE IF NOT EXISTS cas.tpage3_remark_sets (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    set_num numeric(3) not null
);

CREATE TABLE IF NOT EXISTS cas.tpatch_bs_diff_load_uji (
    fnd_id varchar(5),
    pol_num varchar(10),
    trxn_amt numeric(13,2),
    fnd_trxn_pric numeric(20,10),
    trxn_unit numeric(20,10),
    prces_dt timestamp,
    valn_dt timestamp,
    buy_pric numeric(20,10),
    new_buy_pric numeric(20,10),
    new_units numeric(20,10),
    req_units numeric(20,10)
);

CREATE TABLE IF NOT EXISTS cas.tpatch_bs_diff_uji (
    pol_num varchar(10),
    prem_grp varchar(3),
    fnd_id varchar(5),
    fnd_vers varchar(6),
    req_unit numeric(20,10)
);

CREATE TABLE IF NOT EXISTS cas.tpatch_bs_diff_uji_results (
    pol_num varchar(10),
    trxn_id varchar(15),
    fnd_id varchar(5),
    fnd_vers varchar(6),
    req_unit numeric(20,10),
    prem_grp varchar(3),
    status varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpatch_bs_reasn_codes (
    pol_num varchar(10),
    reasn_codes varchar(100),
    adj_unit varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpayee_rules_th (
    payo_reas varchar(10) not null,
    payee_rule varchar(2) not null
);

CREATE TABLE IF NOT EXISTS cas.tpayer_details_th (
    pol_num varchar(10) not null,
    pyer_num numeric(4) not null,
    payer_name_surname varchar(200),
    payer_gender varchar(1),
    payer_age numeric(3),
    payer_dob_date timestamp,
    payer_idcard varchar(20),
    payer_idcard_exp varchar(10),
    payer_home_phone varchar(20),
    payer_office_phone varchar(20),
    payer_mobile_phone varchar(20),
    payer_email varchar(40),
    payer_job varchar(20),
    payer_job_description varchar(100),
    payer_job_position varchar(100),
    payer_income numeric(18),
    payer_relation varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tpayo_desc_th (
    comb_payo_cd varchar(50) not null,
    payo_desc varchar(40)
);

CREATE TABLE IF NOT EXISTS cas.tpclala305 (
    trxn_id varchar(15) not null,
    trxn_dt timestamp not null,
    pol_num varchar(10) not null,
    reasn_code varchar(3),
    face_ratg_start_dt timestamp,
    face_ratg_end_dt timestamp,
    prem_cess_by varchar(10),
    duration varchar(2),
    recurr_end_dt timestamp,
    provision_num varchar(40)
);

CREATE TABLE IF NOT EXISTS cas.tpclala305_comm (
    trxn_id varchar(15) not null,
    pol_num varchar(10) not null,
    agt_code varchar(6),
    pct_splt numeric(3),
    pc_pct_splt numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tpclala305_cvg (
    trxn_id varchar(15) not null,
    pol_num varchar(10) not null,
    rel_to_insrd varchar(2),
    joint_rel_insrd varchar(2),
    plan_code_list varchar(30),
    cvg_eff_dt timestamp,
    cvg_iss_dt timestamp,
    face_amt numeric(13,2),
    cvg_clas varchar(3),
    occp_clas varchar(1),
    prem_amt numeric,
    arrear_pyt varchar(1),
    perm_flat_unit_prem numeric(10,3),
    temp_flat_unit_prem numeric(10,3),
    temp_flat_dur numeric(3),
    face_ratg numeric(5,2),
    xtra_cat_cd varchar(1),
    substd_cd varchar(3),
    perm_mort_unit_prem numeric(10,3),
    perm_mort_ratg numeric(5),
    temp_mort_unit_prem numeric(10,3),
    temp_mort_ratg numeric(5),
    temp_mort_dur numeric(3),
    cli_num varchar(13),
    joint_cli_num varchar(13),
    refresh_cli_mode varchar(7),
    cp numeric(11,2),
    os_prem numeric(11,2),
    chg_fee numeric(11,2),
    rcc_ind varchar(1),
    smkr_code varchar(1),
    excl_code1 varchar(5),
    excl_code2 varchar(5),
    excl_code3 varchar(5),
    excl_end_dt timestamp,
    excl_clause varchar(200),
    xfer_rider varchar(1),
    pkg_rdr_typ varchar(1),
    lien_pct numeric(5,2),
    face_ratg_start_dt timestamp,
    face_ratg_end_dt timestamp,
    nxt_col_dt timestamp,
    int_rt numeric(7,5),
    nc_face_ratg numeric(5,2),
    nc_perm_flat_unit_prem numeric(10,3),
    nc_temp_flat_unit_prem numeric(10,3),
    perm_flat_ratg numeric(5,2),
    adj_prem numeric(13,2),
    sel_insrd varchar(1),
    temp_flat_ratg numeric(5,2),
    bnft_dur numeric(3),
    prem_dur numeric(3),
    cvg_eff_age numeric(3),
    eff_age_ovrid varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpclala305_fnd_alloc (
    trxn_id varchar(15) not null,
    pol_num varchar(10) not null,
    fnd_id varchar(5),
    fnd_vers varchar(6),
    alloc_pct numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.tpclala305_insured (
    trxn_id varchar(15) not null,
    pol_num varchar(10) not null,
    dp_cli_num varchar(13),
    dp_rec varchar(3),
    dp_role varchar(15),
    dp_rel_to_insrd varchar(13)
);

CREATE TABLE IF NOT EXISTS cas.tpclala306 (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    trxn_dt timestamp,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cli_num varchar(13) not null,
    cvg_eff_dt timestamp not null,
    prem_amt numeric(13,2),
    refund_prem_amt numeric(13,2),
    payo_typ varchar(15),
    payo_arang varchar(15),
    ck_arrears varchar(1),
    prem_typ varchar(1),
    chg_mode varchar(11),
    change_date timestamp,
    face_amt numeric(13,2),
    init_chg_ind varchar(1),
    cvg_stat_cd varchar(1) not null,
    cvg_del_dt timestamp,
    cvg_clas varchar(3) not null,
    occp_clas varchar(1) not null,
    reasn_code varchar(3),
    new_cp numeric(13,2),
    new_cvg_eff_dt timestamp,
    smkr_code varchar(1),
    rcc_ind varchar(1),
    cvg_del_reasn varchar(1),
    cvg_iss_dt timestamp,
    os_prem numeric(13,2),
    chg_fee numeric(13,2),
    perm_mort_ratg numeric(11,2),
    temp_mort_ratg numeric(11,2),
    temp_mort_dur numeric(3),
    perm_flat_prem numeric(11,2),
    temp_flat_prem numeric(11,2),
    temp_flat_dur numeric(3),
    excl_code1 varchar(5),
    excl_code2 varchar(5),
    excl_code3 varchar(5),
    excl_end_dt timestamp,
    excl_clause varchar(200),
    xfer_rider varchar(1),
    face_ratg numeric(5,2),
    temp_flat_unit_prem numeric(10,3),
    perm_flat_unit_prem numeric(10,3)
);

CREATE TABLE IF NOT EXISTS cas.tpclala306_comm (
    trxn_id varchar(15) not null,
    pol_num varchar(10) not null,
    agt_code varchar(6) not null,
    pct_splt numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tpclala306_insrd (
    trxn_id varchar(15) not null,
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    rel_to_insrd varchar(2) not null,
    id_num varchar(20) not null,
    del_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpclala307 (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    trxn_dt timestamp not null,
    div_opt varchar(1),
    div_opt_ind varchar(1),
    ipo_ind varchar(1),
    ipo_ind_ind varchar(1),
    vp_ind varchar(1),
    vp_ind_ind varchar(1),
    vp_point timestamp,
    vp_point_ind varchar(1),
    nfo_opt varchar(1),
    nfo_opt_ind varchar(1),
    frez_code varchar(1),
    frez_code_ind varchar(1),
    aea_ind varchar(1),
    aea_ind_ind varchar(1),
    lnb_ind varchar(1),
    lnb_ind_ind varchar(1),
    hiv_ind varchar(1),
    hiv_ind_ind varchar(1),
    xcpt_bill_cd varchar(1),
    xcpt_bill_cd_ind varchar(1),
    medic_code varchar(10),
    medic_code_ind varchar(1),
    pol_rmrk varchar(500),
    prefix_cd varchar(3),
    prefix_cd_ind varchar(1),
    mort_cd varchar(6),
    mort_cd_ind varchar(1),
    endow_ctl varchar(1),
    endow_ctl_ind varchar(1),
    chg_insrd_opt varchar(1),
    chg_insrd_opt_ind varchar(1),
    dscnt_prem numeric(11,2),
    dscnt_prem_ind varchar(1),
    anty_start_dt timestamp,
    anty_start_dt_ind varchar(1),
    anty_freq varchar(5),
    anty_freq_ind varchar(1),
    gurt_prd numeric(3),
    gurt_prd_ind varchar(1),
    cvg_exp_opt varchar(1),
    cvg_exp_opt_ind varchar(1),
    db_opt varchar(1),
    db_opt_ind varchar(1),
    rebal_ind varchar(1),
    rebal_ind_ind varchar(1),
    reasn_code varchar(3),
    plan_code_base varchar(5),
    vers_num_base varchar(2),
    iio_opt varchar(1),
    iio_opt_ind varchar(1),
    iio_pct numeric(3),
    iio_pct_ind varchar(1),
    restrict_cd_1 varchar(5),
    restrict_cd_1_ind varchar(1),
    restrict_cd_2 varchar(5),
    restrict_cd_2_ind varchar(1),
    restrict_cd_3 varchar(5),
    restrict_cd_3_ind varchar(1),
    fran_num varchar(4),
    fran_num_ind varchar(1),
    plan_prem numeric(11,2),
    plan_prem_ind varchar(1),
    disable_dt timestamp,
    disable_dt_ind varchar(1),
    eff_dt timestamp,
    lien_pct numeric(5,2),
    no_lapse_gurt_ind varchar(1),
    no_lapse_gurt_ind_ind varchar(1),
    lien_pct_ind varchar(1),
    bbr_flag varchar(1),
    bbr_flag_ind varchar(1),
    ph_ind varchar(1),
    ph_ind_ind varchar(1),
    ph_strt_dt timestamp,
    ph_strt_dt_ind varchar(1),
    ph_end_dt timestamp,
    ph_end_dt_ind varchar(1),
    anty_payo_amt_ind varchar(1),
    chg_mode varchar(15),
    anty_dur numeric(2),
    anty_dur_ind varchar(1),
    anty_int_rt numeric(7,5),
    anty_int_rt_ind varchar(1),
    anty_opt varchar(2),
    anty_opt_ind varchar(1),
    anty_payo_amt numeric(13,2),
    loyal_bns_ind varchar(1),
    loyal_bns_ind_ind varchar(1),
    payo_crcy varchar(2),
    payo_crcy_ind varchar(1),
    payo_mthd varchar(10),
    payo_mthd_ind varchar(1),
    payo_arang varchar(4),
    payo_arang_ind varchar(1),
    nxt_payo_dt timestamp,
    nxt_payo_dt_ind varchar(1),
    anty_end_dt timestamp,
    anty_end_dt_ind varchar(1),
    anty_min_payo_amt numeric(13,2),
    anty_min_payo_amt_ind varchar(1),
    prs_ind varchar(1),
    prs_ind_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpclala308 (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    trxn_dt timestamp not null,
    refund_prem_amt numeric,
    payo_type varchar(10),
    payo_arang varchar(10),
    ipo_year numeric(4),
    rb_prem_type varchar(1),
    ck_arrear varchar(1),
    plan_code varchar(5),
    vers_num varchar(5),
    cvg_eff_dt timestamp,
    face_amt numeric(13,2),
    prem_amt numeric(11,2),
    reasn_code varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tpclala309 (
    trxn_id varchar(15) not null,
    trxn_dt timestamp not null,
    pol_num varchar(10) not null,
    pmt_mode varchar(5),
    old_pmt_mode varchar(5),
    pd_to_dt timestamp,
    pd_to_dt_chg_ind varchar(1),
    old_pd_to_dt timestamp,
    plan_prem numeric(11,2),
    cp_dt timestamp,
    old_plan_prem numeric(11,2),
    bill_mthd varchar(1),
    old_bill_mthd varchar(1),
    fran_num varchar(4),
    old_fran_num varchar(4),
    pac_bk_ctr varchar(1),
    old_pac_bk_ctr varchar(1),
    new_bank_ind varchar(1),
    new_cpf_ind varchar(1),
    bank_acct_num varchar(20),
    bank_acct_typ numeric(2),
    bank_cd varchar(13),
    bank_acct_nm varchar(40),
    id_num varchar(20),
    id_typ varchar(1),
    bank_sv_kd varchar(1),
    old_bank_acct_typ numeric(2),
    cpf_acct_num varchar(100),
    ck_arrear varchar(1),
    prem_amt numeric(9,2),
    os_prem numeric(9,2),
    chg_fee numeric(9,2),
    rb_prem_typ varchar(1),
    refund_prem_amt numeric(9,2),
    payo_typ varchar(30),
    payo_arang varchar(30),
    reasn_code varchar(3),
    nxt_prem_due_dt timestamp,
    last_pd_to_dt timestamp,
    old_last_pd_to_dt timestamp,
    bank_fee_ind varchar(1),
    bank_fee_ind_chg varchar(1),
    acct_xpry_dt timestamp,
    bank_acct_title varchar(20),
    card_cat varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpclala310 (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    trxn_dt timestamp not null,
    ovr_loan_ind varchar(1),
    ovr_loan_ind_ind varchar(1),
    frez_code varchar(1),
    frez_code_ind varchar(1),
    reins_ind varchar(1),
    reins_ind_ind varchar(1),
    last_avy_dt timestamp,
    last_avy_dt_ind varchar(1),
    last_pd_to_dt timestamp,
    last_pd_to_dt_ind varchar(1),
    pd_to_dt timestamp,
    pd_to_dt_ind varchar(1),
    pol_eff_dt timestamp,
    pol_eff_dt_ind varchar(1),
    pol_iss_dt timestamp,
    pol_iss_dt_ind varchar(1),
    pol_reiss_dt timestamp,
    pol_reiss_dt_ind varchar(1),
    cnfrm_acpt_dt timestamp,
    cnfrm_acpt_dt_ind varchar(1),
    pol_rlse_dt timestamp,
    pol_rlse_dt_ind varchar(1),
    sbmt_dt timestamp,
    sbmt_dt_ind varchar(1),
    pol_stat_cd varchar(1),
    pol_stat_cd_ind varchar(1),
    pol_trmn_dt timestamp,
    pol_trmn_dt_ind varchar(1),
    pol_susp numeric(13,2),
    pol_susp_ind varchar(1),
    pmt_susp numeric(11,2),
    pmt_susp_ind varchar(1),
    ipo_last_refu_yr numeric(4),
    ipo_last_refu_yr_ind varchar(1),
    bill_to_dt timestamp,
    bill_to_dt_ind varchar(1),
    pac_loan_repy numeric(11,2),
    pac_loan_repy_ind varchar(1),
    pac_bk_ctr varchar(1),
    pac_bk_ctr_ind varchar(1),
    pac_eff_dt timestamp,
    pac_eff_dt_ind varchar(1),
    uwg_clas varchar(30),
    uwg_clas_ind varchar(1),
    apl_laps_dt timestamp,
    apl_laps_dt_ind varchar(1),
    apl_ext_days numeric(3),
    apl_ext_days_ind varchar(1),
    renw_yr numeric(3),
    renw_yr_ind varchar(1),
    run_num numeric(2),
    run_num_ind varchar(1),
    pol_app_dt timestamp,
    pol_app_dt_ind varchar(1),
    tlia_code_1 varchar(10),
    tlia_code_1_ind varchar(1),
    tlia_code_2 varchar(10),
    tlia_code_2_ind varchar(1),
    tlia_code_3 varchar(10),
    tlia_code_3_ind varchar(1),
    disab_clas varchar(3),
    disab_clas_ind varchar(1),
    restr_case_cnt_ind varchar(1),
    restr_case_cnt_ind_ind varchar(1),
    comm_wthld_dt timestamp,
    comm_wthld_dt_ind varchar(1),
    last_actv_dt timestamp,
    last_actv_dt_ind varchar(1),
    joint_cli_dth_ind varchar(1),
    joint_cli_dth_ind_ind varchar(1),
    comprop_prem numeric(11,2),
    comprop_prem_ind varchar(1),
    os_anty_susp numeric(13,2),
    os_anty_susp_ind varchar(1),
    lump_sum_ind varchar(1),
    lump_sum_ind_ind varchar(1),
    lump_sum_pmt_amt numeric(11,2),
    lump_sum_pmt_amt_ind varchar(1),
    proc_fee_ind varchar(1),
    proc_fee_ind_ind varchar(1),
    dist_chnl_cd varchar(2),
    dist_chnl_cd_ind varchar(1),
    tot_prem_appy numeric(15,2),
    tot_prem_appy_ind varchar(1),
    convrt_fr_pol varchar(10),
    convrt_fr_pol_ind varchar(1),
    apl_lapse_ind varchar(1),
    apl_lapse_ind_ind varchar(1),
    div_upto_dt timestamp,
    div_upto_dt_ind varchar(1),
    sa_cd_2 varchar(6),
    sa_cd_2_ind varchar(1),
    wa_cd_1 varchar(6),
    wa_cd_1_ind varchar(1),
    wa_cd_2 varchar(6),
    wa_cd_2_ind varchar(1),
    vp_point timestamp,
    vp_point_ind varchar(1),
    override_bill_day numeric(2),
    override_bill_day_ind varchar(1),
    plan_prem numeric(11,2),
    plan_prem_ind varchar(1),
    recurr_bill_ind varchar(1),
    recurr_bill_ind_ind varchar(1),
    recurr_bill_st_dt timestamp,
    recurr_bill_st_dt_ind varchar(1),
    mvy_ded_to_dt timestamp,
    mvy_ded_to_dt_ind varchar(1),
    interest_start_dt timestamp,
    interest_start_dt_ind varchar(1),
    gurt_amt numeric(13,2),
    gurt_amt_ind varchar(1),
    invest_start_dt timestamp,
    invest_start_dt_ind varchar(1),
    dvalu_stop_dt timestamp,
    dvalu_stop_dt_ind varchar(1),
    int_adjust_mth varchar(6),
    int_adjust varchar(22),
    reasn_code varchar(3),
    occp_extra_ind varchar(1),
    scpt_hi_rh_ind varchar(1),
    no_lapse_gurt_ind varchar(1),
    no_lapse_gurt_ind_ind varchar(1),
    recurr_end_dt timestamp,
    recurr_end_dt_ind varchar(1),
    loan_ovr_int_rt numeric(7,5),
    anty_start_dt timestamp,
    anty_start_dt_ind varchar(1),
    anty_wthdr numeric(13,2),
    anty_wthdr_ind varchar(1),
    nfo_opt varchar(2),
    nfo_opt_ind varchar(1),
    div_opt varchar(1),
    div_opt_ind varchar(1),
    pol_rmrk varchar(100),
    pol_rmrk_ind varchar(1),
    prefix_cd varchar(3),
    prefix_cd_ind varchar(1),
    anty_freq numeric(2),
    anty_freq_ind varchar(1),
    loan_ovr_int_rt_ind varchar(1),
    reins_cd varchar(3),
    reins_cd_ind varchar(1),
    reins_mthd varchar(1),
    reins_mthd_ind varchar(1),
    vp_ind varchar(1),
    vp_indc varchar(1),
    waive_end_dt timestamp,
    waive_end_dt_ind varchar(1),
    last_tcomm_calc_dt timestamp,
    last_tcomm_calc_dt_ind varchar(1),
    fnd_switch_ctr numeric(3),
    fnd_switch_ctr_ind varchar(1),
    reference_no varchar(16),
    reference_no_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpclala311 (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    trxn_dt timestamp not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cli_num varchar(13) not null,
    cvg_eff_dt timestamp not null,
    plan_code_disp varchar(5),
    plan_code_disp_ind varchar(1),
    vers_num_disp varchar(2),
    vers_num_disp_ind varchar(1),
    cvg_eff_dt_disp timestamp,
    cvg_eff_dt_disp_ind varchar(1),
    cvg_reasn varchar(1),
    cvg_reasn_ind varchar(1),
    cvg_stat_cd varchar(1),
    cvg_stat_cd_ind varchar(1),
    pua_tot_amt numeric(13,3),
    pua_tot_amt_ind varchar(1),
    smkr_code varchar(1),
    smkr_code_ind varchar(1),
    sex_code varchar(1),
    sex_code_ind varchar(1),
    comm_vers varchar(2),
    comm_vers_ind varchar(1),
    par_code varchar(1),
    par_code_ind varchar(1),
    orig_death_bnft numeric(13,2),
    orig_death_bnft_ind varchar(1),
    band_face_amt numeric(13,2),
    band_face_amt_ind varchar(1),
    face_ratg numeric(5,2),
    face_ratg_ind varchar(1),
    cvg_iss_dt timestamp,
    cvg_iss_dt_ind varchar(1),
    prem_vers varchar(2),
    prem_vers_ind varchar(1),
    pol_val_vers varchar(2),
    pol_val_vers_ind varchar(1),
    prem_ovrid_end_date timestamp,
    prem_ovrid_end_date_ind varchar(1),
    joint_cli_num varchar(13),
    joint_cli_num_ind varchar(1),
    joint_rel_insrd varchar(2),
    joint_rel_insrd_ind varchar(1),
    dscnt_prem numeric(11,2),
    dscnt_prem_ind varchar(1),
    orig_face_amt numeric(13,2),
    orig_face_amt_ind varchar(1),
    orig_pua_amt numeric(13,2),
    orig_pua_amt_ind varchar(1),
    substd_cd varchar(3),
    substd_cd_ind varchar(1),
    temp_flat_dur numeric(3),
    temp_flat_dur_ind varchar(1),
    temp_flat_unit_prem numeric(10,3),
    temp_flat_unit_prem_ind varchar(1),
    perm_flat_unit_prem numeric(10,3),
    perm_flat_unit_prem_ind varchar(1),
    temp_mort_dur numeric(3),
    temp_mort_dur_ind varchar(1),
    temp_mort_unit_prem numeric(10,3),
    temp_mort_unit_prem_ind varchar(1),
    adj_prem numeric(11,2),
    adj_prem_ind varchar(1),
    adj_prem_pct numeric(3),
    adj_prem_pct_ind varchar(1),
    perm_mort_unit_prem numeric(10,3),
    perm_mort_unit_prem_ind varchar(1),
    xtra_cat_cd varchar(1),
    xtra_cat_cd_ind varchar(1),
    perm_mort_ratg numeric(5),
    perm_mort_ratg_ind varchar(1),
    temp_mort_ratg numeric(5),
    temp_mort_ratg_ind varchar(1),
    eti_endow numeric(13,2),
    eti_endow_ind varchar(1),
    face_amt numeric(13,2),
    face_amt_ind varchar(1),
    adj_start_dt timestamp,
    adj_start_dt_ind varchar(1),
    adj_end_dt timestamp,
    adj_end_dt_ind varchar(1),
    xpry_dt timestamp,
    xpry_dt_ind varchar(1),
    ins_typ varchar(1),
    ins_typ_ind varchar(1),
    reasn_code varchar(3),
    lien_pct numeric(5,2),
    lien_pct_ind varchar(1),
    prem_dur numeric(3),
    wp_option varchar(1),
    wp_option_ind varchar(1),
    prem_dur_ind varchar(1),
    eff_age_ovrid varchar(1),
    eff_age_ovrid_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpclala312 (
    trxn_id varchar(30) not null,
    trxn_dt timestamp not null,
    pol_num varchar(20) not null,
    asof_dt timestamp,
    agt_code varchar(12) not null,
    cli_num varchar(26) not null,
    plan_code varchar(10) not null,
    vers_num varchar(4) not null,
    cvg_eff_dt timestamp not null,
    layer_eff_dt timestamp not null,
    agt_code_ind varchar(2),
    reasn_code varchar(6),
    cvg_lay_typ varchar(5) not null,
    layer_typ varchar(5) not null
);

CREATE TABLE IF NOT EXISTS cas.tpclala312_comm (
    trxn_id varchar(30) not null,
    agt_code varchar(12) not null,
    comm_dt timestamp,
    comm_stat_cd varchar(2),
    pc_stat_cd varchar(2),
    pct_splt numeric(3),
    orph_asign_ind varchar(2),
    comm_rest_ind varchar(2),
    comm_rest_dur numeric(3),
    comm_rest_rt numeric(5,2),
    fa_ratio numeric(7,5),
    comm_reasn_cd varchar(6),
    comm_earn_adj numeric(9,2),
    pc_reasn_cd varchar(6),
    pc_earn_adj numeric(9),
    pc_chg_bck_reasn_cd varchar(6),
    pc_chg_bck_adj numeric(9),
    case_ctr_reasn_cd varchar(6),
    case_ctr_adj numeric(9),
    ep_reasn_cd varchar(6),
    ep_earn_adj numeric(9),
    ep_chg_bck_reasn_cd varchar(6),
    ep_chg_bck_adj numeric(9),
    comm_dt_ind varchar(2),
    comm_stat_cd_ind varchar(2),
    pct_splt_ind varchar(2),
    orph_asign_ind_ind varchar(2),
    comm_rest_ind_ind varchar(2),
    comm_rest_dur_ind varchar(2),
    comm_rest_rt_ind varchar(2),
    fa_ratio_ind varchar(2),
    cvg_lay_typ varchar(5),
    layer_typ varchar(5),
    pc_pct_splt varchar(3),
    pc_stat_cd_ind varchar(1),
    pc_pct_splt_ind varchar(1),
    comm_reasn_cd1 varchar(3),
    comm_reasn_cd2 varchar(3),
    comm_earn_adj1 numeric(9,2),
    comm_earn_adj2 numeric(9,2),
    pc_reasn_cd1 varchar(3),
    pc_reasn_cd2 varchar(3),
    pc_earn_adj1 numeric(9),
    pc_earn_adj2 numeric(9),
    pc_chg_bck_reasn_cd1 varchar(3),
    pc_chg_bck_reasn_cd2 varchar(3),
    pc_chg_bck_adj1 numeric(9),
    pc_chg_bck_adj2 numeric(9),
    case_ctr_reasn_cd1 varchar(3),
    case_ctr_adj1 numeric(9),
    cause_cd varchar(3),
    cause_cd1 varchar(3),
    cause_cd2 varchar(3),
    cause_cd3 varchar(3),
    cause_cd4 varchar(3),
    cause_cd5 varchar(3),
    cause_cd6 varchar(3),
    cause_cd7 varchar(3),
    cause_cd8 varchar(3),
    cause_cd9 varchar(3),
    cause_cd10 varchar(3),
    seq_no numeric(4) not null,
    pc_earn_afyc numeric(9),
    pc_chrg_bk_afyc numeric(9),
    anp_amt_adj numeric(11,2),
    anp_chg_bck_adj numeric(11,2),
    pc_base_reasn_cd varchar(6),
    pc_base_adj numeric(9),
    prem_amt_comm numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tpclala312_over (
    trxn_id varchar(30) not null,
    agt_code varchar(10) not null,
    override_rates numeric(5,2),
    override_yr_from numeric(3) not null,
    override_yr_to numeric(3),
    cvg_lay_typ varchar(5),
    layer_typ varchar(5),
    comp_typ varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.tpclala322 (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    trxn_dt timestamp not null,
    reasn_code varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tpclala322_cvg (
    trxn_id varchar(15) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cli_num varchar(13) not null,
    cvg_eff_dt timestamp not null,
    wp_option varchar(1),
    wp_eff_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tpclala322_cvg_wps (
    trxn_id varchar(15) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cli_num varchar(13) not null,
    cvg_eff_dt timestamp not null,
    layer_eff_dt timestamp not null,
    cvg_lay_typ varchar(5) not null,
    layer_typ varchar(1) not null,
    wp_plan_code varchar(5) not null,
    wp_vers_num varchar(2) not null,
    wp_cli_num varchar(13) not null,
    wp_cvg_eff_dt timestamp not null,
    wp_eff_dt timestamp not null,
    wp_option varchar(1),
    old_wp_option varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpclala323 (
    trxn_id varchar(15) not null,
    trxn_dt timestamp,
    pol_num varchar(10) not null,
    old_agt_code varchar(6),
    new_agt_code varchar(6),
    chg_eff_dt timestamp,
    agt_chg_reasn varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tpclala329 (
    trxn_id varchar(15) not null,
    trxn_dt timestamp not null,
    pol_num varchar(10) not null,
    plan_code varchar(30) not null,
    vers_num varchar(2) not null,
    cli_num varchar(13) not null,
    cvg_eff_dt timestamp not null,
    new_plan_code varchar(30),
    new_vers_num varchar(2),
    reasn_code varchar(3),
    face_amt numeric(13,2),
    new_face_amt numeric(13,2),
    div_opt varchar(30),
    ipo_opt varchar(1),
    chg_fee numeric(11,2),
    arrear_pyt varchar(1),
    prem_type varchar(1),
    arrear_amt numeric,
    refund_amt numeric,
    face_ratg numeric(5,2),
    perm_flat_unit_prem numeric(10,3),
    temp_flat_unit_prem numeric(10,3),
    temp_flat_dur numeric(3),
    excl_code1 varchar(5),
    excl_code2 varchar(5),
    excl_code3 varchar(5),
    excl_end_dt timestamp,
    excl_clause varchar(200)
);

CREATE TABLE IF NOT EXISTS cas.tpclala334 (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    trxn_dt timestamp not null,
    alloc_typ varchar(1),
    alloc_eff_dt timestamp not null,
    reasn_code varchar(3),
    same_fund_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpclala334_fnd (
    trxn_id varchar(15) not null,
    pol_num varchar(10) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    alloc_pct numeric(3) not null,
    prem_grp varchar(3) not null
);

CREATE TABLE IF NOT EXISTS cas.tpclala337 (
    trxn_id varchar(15) not null,
    trxn_dt timestamp not null,
    pol_num varchar(10) not null,
    pmt_mode varchar(5),
    old_pmt_mode varchar(5),
    reasn_code varchar(3),
    plan_prem numeric(11,2),
    old_plan_prem numeric(11,2),
    db_opt varchar(1),
    iio_opt varchar(1),
    iio_pct numeric(3),
    old_db_opt varchar(1),
    old_iio_opt varchar(1),
    old_iio_pct numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tpclala337_cvg (
    trxn_id varchar(15) not null,
    pol_num varchar(10) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cli_num varchar(13) not null,
    cvg_eff_dt timestamp not null,
    cvg_reasn varchar(1),
    what_operator varchar(30),
    new_cvg_ind varchar(1),
    rel_to_insrd varchar(2),
    cvg_typ varchar(1),
    joint_rel_insrd varchar(2),
    face_amt numeric(13,2),
    old_face_amt numeric(13,2),
    cvg_clas varchar(3),
    old_cvg_clas varchar(3),
    occp_clas varchar(1),
    old_occp_clas varchar(1),
    perm_flat_unit_prem numeric(7,3),
    old_perm_flat_unit_prem numeric(7,3),
    temp_flat_unit_prem numeric(7,3),
    old_temp_flat_unit_prem numeric(7,3),
    temp_flat_dur numeric(3),
    old_temp_flat_dur numeric(3),
    oper_seq numeric(3),
    perm_mort_ratg numeric(5),
    temp_mort_ratg numeric(5),
    temp_mort_dur numeric(3),
    face_ratg numeric(5,2),
    excl_code1 varchar(5),
    excl_code2 varchar(5),
    excl_code3 varchar(5),
    excl_end_dt timestamp,
    excl_clause varchar(200),
    perm_flat_prem numeric(11,2),
    temp_flat_prem numeric(11,2),
    rcc_ind varchar(1),
    old_perm_mort_ratg numeric(5),
    old_temp_mort_ratg numeric(5),
    old_temp_mort_dur numeric(3),
    old_face_ratg numeric(5,2),
    old_excl_code1 varchar(5),
    old_excl_code2 varchar(5),
    old_excl_code3 varchar(5),
    old_excl_end_dt timestamp,
    old_excl_clause varchar(200),
    old_perm_flat_prem numeric(11,2),
    old_temp_flat_prem numeric(11,2),
    old_rcc_ind varchar(1),
    smkr_code varchar(1),
    old_smkr_code varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpclala337_cvg_fnd (
    trxn_id varchar(15) not null,
    pol_num varchar(10) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cli_num varchar(13) not null,
    cvg_eff_dt timestamp not null,
    fnd_id varchar(5),
    fnd_vers varchar(6),
    alloc_pct numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.tpclala337_insrd (
    trxn_id varchar(15) not null,
    pol_num varchar(10) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cli_num varchar(13) not null,
    cvg_eff_dt timestamp not null,
    oth_cli_num varchar(13) not null,
    rel_to_insrd varchar(2) not null,
    id_num varchar(20) not null,
    post_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpclala339 (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    trxn_dt timestamp not null,
    reasn_cd varchar(3),
    eff_dt timestamp,
    chrg_amt numeric(13,2),
    user_id varchar(30),
    prem_grp varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tpclala339_tri (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    pct numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.tpclala339_tro (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    req_amt numeric(17,2),
    req_pct numeric(5,2),
    req_unit numeric(20,10)
);

CREATE TABLE IF NOT EXISTS cas.tpclala340 (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    trxn_dt timestamp,
    nxt_rebal_date timestamp,
    rebal_ind varchar(1),
    method varchar(10),
    reasn_code varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tpclala340_fnd (
    pol_num varchar(10),
    trxn_id varchar(15),
    cli_num varchar(13),
    plan_code varchar(5),
    vers_num varchar(2),
    cvg_eff_dt timestamp,
    alloc_stat_cd varchar(1),
    alloc_typ varchar(1),
    alloc_eff_dt timestamp,
    fnd_id varchar(5),
    fnd_vers varchar(6),
    alloc_pct numeric(3),
    post_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpclala341 (
    trxn_id varchar(15) not null,
    trxn_dt timestamp,
    pol_num varchar(10) not null,
    eff_dt timestamp,
    new_con_prem numeric(10,2),
    os_prem numeric(10,2),
    arr_prem numeric(10,2),
    reasn_code varchar(3),
    new_bp numeric(13,3),
    prem_amt numeric(13,3)
);

CREATE TABLE IF NOT EXISTS cas.tpclala341_agt (
    trxn_id varchar(15) not null,
    agt_code varchar(6),
    pct_splt numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tpclala343 (
    trxn_id varchar(15) not null,
    trxn_dt timestamp not null,
    pol_num varchar(10) not null,
    eff_dt timestamp,
    chg_fee numeric(11,2),
    prem_amt numeric(11,2),
    os_prem numeric(11,2),
    refund_amt numeric(11,2),
    chg_sex_flag varchar(1),
    reasn_code varchar(3),
    plan_prem numeric(11,2),
    old_plan_prem numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tpclala343_cvg_lay (
    trxn_id varchar(15) not null,
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    layer_eff_dt timestamp not null,
    cvg_lay_typ varchar(5) not null,
    layer_typ varchar(1) not null,
    smkr_code varchar(1),
    occp_clas varchar(1),
    rcc_ind varchar(1),
    face_ratg numeric(5,2),
    perm_flat_unit_prem numeric(10,3),
    temp_flat_unit_prem numeric(10,3),
    temp_flat_dur numeric(3),
    excl_code1 varchar(5),
    excl_code2 varchar(5),
    excl_code3 varchar(5),
    excl_end_dt timestamp,
    excl_clause varchar(200),
    old_smkr_code varchar(1),
    old_occp_clas varchar(1),
    old_rcc_ind varchar(1),
    old_face_ratg numeric(5,2),
    old_perm_flat_unit_prem numeric(10,3),
    old_temp_flat_unit_prem numeric(10,3),
    old_temp_flat_dur numeric(3),
    old_excl_code1 varchar(5),
    old_excl_code2 varchar(5),
    old_excl_code3 varchar(5),
    old_excl_end_dt timestamp,
    old_excl_clause varchar(200),
    face_ratg_start_dt timestamp,
    face_ratg_end_dt timestamp,
    old_face_ratg_start_dt timestamp,
    old_face_ratg_end_dt timestamp,
    lien_pct numeric(5,2),
    old_lien_pct numeric(5,2),
    nc_face_ratg numeric(5,2),
    nc_perm_flat_unit_prem numeric(10,3),
    nc_temp_flat_unit_prem numeric(10,3),
    old_nc_face_ratg numeric(5,2),
    old_nc_perm_flat_unit_prem numeric(10,3),
    old_nc_temp_flat_unit_prem numeric(10,3),
    temp_flat_ratg_ind varchar(1),
    perm_flat_ratg numeric(5,2),
    temp_flat_ratg numeric(5,2),
    perm_flat_ratg_ind varchar(1),
    bnft_dur numeric(3),
    prem_dur numeric(3),
    old_bnft_dur numeric(3),
    old_prem_dur numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tpclala344 (
    trxn_id varchar(15) not null,
    trxn_dt timestamp,
    pol_num varchar(10) not null,
    new_crcy_code varchar(2),
    exchg_eff_dt timestamp,
    exchg_rate_eff_dt timestamp,
    chg_fee numeric(13,2),
    os_prem numeric(13,2),
    arrears numeric(13,2),
    reasn_code varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tpclala346 (
    trxn_id varchar(15) not null,
    trxn_dt timestamp,
    pol_num varchar(10) not null,
    eff_dt timestamp,
    new_pol_stat_cd varchar(1),
    payo_crcy varchar(2),
    payo_mthd varchar(30),
    payo_chnl varchar(30),
    atp_acct_no varchar(30),
    atp_acct_hld_nm varchar(30),
    payo_pol_num varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tpclala348 (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    trxn_id varchar(15) not null,
    trxn_dt timestamp not null,
    dscnt_prem numeric(11,2) not null,
    prem_ovrid_end_date timestamp,
    perm_prem_ovrid_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpclala348_lay (
    trxn_id varchar(15) not null,
    layer_eff_dt timestamp not null,
    cvg_lay_typ varchar(5) not null,
    layer_typ varchar(1) not null,
    layer_dscnt_prem numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tpclala348_schedules (
    trxn_id varchar(15) not null,
    eff_fr_dt timestamp not null,
    eff_to_dt timestamp not null,
    pmt_mode varchar(5) not null,
    layer_prem numeric(13,2),
    layer_dscnt_prem numeric(13,2),
    ann_layer_prem numeric(13,2),
    ann_layer_dscnt_prem numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tpclala349 (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    trxn_dt timestamp not null,
    switch_mode varchar(5) not null,
    rebal_ind varchar(1),
    reasn_cd varchar(3),
    eff_dt timestamp,
    cancel_dt timestamp,
    chrg_amt numeric(13,2),
    user_id varchar(30),
    prem_grp varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tpclala349_tri (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    switch_fnd_id varchar(5) not null,
    switch_fnd_vers varchar(6) not null,
    prem_grp varchar(5) not null,
    pct numeric(5,2) not null
);

CREATE TABLE IF NOT EXISTS cas.tpclala349_tro (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    prem_grp varchar(5) not null,
    req_amt numeric(17,2),
    req_pct numeric(5,2),
    req_unit numeric(20,10)
);

CREATE TABLE IF NOT EXISTS cas.tpclala351 (
    trxn_id varchar(15) not null,
    trxn_dt timestamp,
    pol_num varchar(10) not null,
    eff_dt timestamp,
    old_cv numeric(13,2),
    req_cv numeric(13,2),
    new_cv numeric(13,2),
    old_face_amt numeric(13,2),
    new_face_amt numeric(13,2),
    payo_typ varchar(15),
    payo_arang varchar(15),
    reasn_code varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tpclala360 (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    trxn_dt timestamp not null,
    act_mode varchar(1) not null,
    pdf_opt varchar(1),
    pdf_opt_chg_ind varchar(1),
    pdf_eff_dt timestamp,
    pdf_eff_dt_chg_ind varchar(1),
    instl_prd numeric(2),
    instl_prd_chg_ind varchar(1),
    instl_amt numeric(13,2),
    instl_amt_chg_ind varchar(1),
    prepay_prd numeric(2),
    prepay_prd_chg_ind varchar(1),
    defer_to_yr varchar(4),
    defer_to_yr_chg_ind varchar(1),
    drop_cvg_opt varchar(1),
    drop_cvg_opt_chg_ind varchar(1),
    gurt_rt_ind varchar(1),
    gurt_rt_ind_chg_ind varchar(1),
    gurt_int_rt numeric(7,5),
    gurt_int_rt_chg_ind varchar(1),
    div_po_ind varchar(1),
    div_po_ind_chg_ind varchar(1),
    endow_po_ind varchar(1),
    endow_po_ind_chg_ind varchar(1),
    amt_to_pdf numeric(13,2),
    admin_fee numeric(13,2),
    surr_chrg numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tpclsga306 (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    trxn_dt timestamp,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cli_num varchar(13) not null,
    cvg_eff_dt timestamp not null,
    chg_mode varchar(11),
    reasn_code varchar(3),
    change_date timestamp,
    face_amt numeric(13,2),
    init_chg_ind varchar(1),
    int_rt numeric(12,5),
    pol_stat_cd varchar(1) not null,
    cvg_stat_cd varchar(1) not null,
    cvg_del_dt timestamp,
    ck_arrears varchar(1),
    prem_typ varchar(1),
    prem_amt numeric(13,2),
    refund_prem_amt numeric(13,2),
    payo_typ varchar(15),
    payo_arang varchar(15),
    cvg_clas varchar(3),
    occp_clas varchar(1),
    smkr_code varchar(1),
    perm_flat_unit_prem numeric(10,3),
    temp_flat_unit_prem numeric(10,3),
    temp_flat_dur numeric(3),
    perm_mort_unit_prem numeric(10,3),
    perm_mort_ratg numeric(5),
    temp_mort_unit_prem numeric(10,3),
    temp_mort_ratg numeric(5),
    temp_mort_dur numeric(3),
    face_ratg numeric(5,2),
    xtra_cat_cd varchar(1),
    substd_cd varchar(3),
    excl_code1 varchar(5),
    excl_code2 varchar(5),
    excl_code3 varchar(5),
    excl_end_dt timestamp,
    excl_clause varchar(200),
    face_ratg_start_dt timestamp,
    face_ratg_end_dt timestamp,
    lien_pct numeric(5,2),
    ck_convert varchar(1),
    perm_flat_ratg numeric(5,2),
    fa_payout_ind varchar(1),
    temp_flat_ratg numeric(5,2),
    endors_eff_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tpclsga334 (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    trxn_dt timestamp not null,
    alloc_typ varchar(1),
    alloc_eff_dt timestamp not null,
    reasn_code varchar(3),
    same_fund_ind varchar(1),
    rebal_typ varchar(1),
    rebal_freq varchar(2),
    rebal_cancel_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tpclsga334_fnd (
    trxn_id varchar(15) not null,
    pol_num varchar(10) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    alloc_pct numeric(5,2) not null,
    prem_grp varchar(3) not null
);

CREATE TABLE IF NOT EXISTS cas.tpclsga500 (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    trxn_dt timestamp not null,
    reasn_cd varchar(3),
    eff_dt timestamp,
    chrg_amt numeric(13,2),
    user_id varchar(30),
    prem_grp varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tpclsga500_tro (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    req_amt numeric(17,2),
    req_pct numeric(5,2),
    req_unit numeric(20,10)
);

CREATE TABLE IF NOT EXISTS cas.tpclsga806 (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    trxn_dt timestamp not null,
    plan_code varchar(5),
    vers_num varchar(2),
    cli_num varchar(13),
    cvg_eff_dt timestamp,
    cvg_stat_cd varchar(1),
    pd_to_dt timestamp,
    last_pd_to_dt timestamp,
    wp_claim_eff_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tpc_charge_bck (
    pol_num varchar(10),
    plan_code varchar(5),
    agt_code varchar(6),
    pc_chrg_bck numeric(9)
);

CREATE TABLE IF NOT EXISTS cas.tpdf_ctl (
    pdf_opt varchar(1) not null,
    max_wthdr_ctr numeric(2) not null,
    div_po_avail varchar(1) not null,
    endow_po_avail varchar(1) not null,
    int_rt_typ varchar(1) not null,
    gurt_int_rt_typ varchar(1) not null,
    setup_bill_mthd varchar(1) not null,
    to_bill_mthd varchar(1) not null,
    setup_pmt_mode varchar(2) not null
);

CREATE TABLE IF NOT EXISTS cas.tpdf_dtls (
    pol_num varchar(10) not null,
    pdf_eff_dt timestamp not null,
    prepay_prd numeric(2),
    defer_to_yr varchar(4),
    instl_prd numeric(2),
    gurt_rt_ind varchar(1),
    gurt_int_rt numeric(7,5),
    div_po_ind varchar(1),
    endow_po_ind varchar(1),
    drop_cvg_opt varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpdnala201 (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    trxn_dt timestamp not null,
    dnr_fr varchar(3) not null,
    req_dnr_amt numeric(11,2) not null,
    payo_typ varchar(10),
    payo_arrange varchar(10),
    payo_reas varchar(10),
    remarks varchar(100),
    reasn_code varchar(3),
    trans_no varchar(55)
);

CREATE TABLE IF NOT EXISTS cas.tpdnsha202_prem_hist (
    trxn_id varchar(30) not null,
    prem_dt timestamp not null,
    shi_num numeric(4) not null,
    prem_typ varchar(6),
    apply_used numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tperiod_masters (
    service_cd varchar(30),
    pr_run_dt timestamp,
    pr_fr_dt timestamp,
    pr_to_dt timestamp,
    pr_num numeric
);

CREATE TABLE IF NOT EXISTS cas.tperm_rcpt_cvg_th (
    trxn_dt timestamp not null,
    pol_num varchar(10) not null,
    reasn_code varchar(3) not null,
    trxn_id varchar(15) not null,
    thi_aex_num numeric(4) not null,
    seq_no numeric(2) not null,
    plan_code varchar(5),
    vers_num varchar(2),
    cvg_typ varchar(1),
    cvg_eff_dt timestamp,
    tax_percen numeric(5,2),
    tax_typ varchar(5),
    prem_amt numeric(11,2),
    taxable_prem numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tperm_rcpt_th (
    trxn_dt timestamp not null,
    pol_num varchar(10) not null,
    reasn_code varchar(3) not null,
    off_rcpt_num numeric(10),
    rcpt_dt timestamp,
    pmt_mode varchar(2),
    pd_to_dt timestamp,
    prem_applied numeric(13,2),
    eff_dt timestamp,
    prem_dscnt numeric(13,2),
    pmt_susp_used numeric(13,2),
    pol_susp_used numeric(13,2),
    apl_used numeric(13,2),
    endow_used numeric(13,2),
    div_used numeric(13,2),
    lump_sum_used numeric(13,2),
    prem_tol_applied numeric(13,2),
    trxn_id varchar(15),
    thi_aex_num numeric(4) not null,
    prt_status varchar(1),
    user_created varchar(30),
    date_created timestamp,
    user_amended varchar(30),
    date_amended timestamp,
    prev_pd_to_dt timestamp,
    next_pd_to_dt timestamp,
    basic_prem numeric(11,2),
    rider_prem numeric(11,2),
    taxable_prem numeric(11,2),
    non_taxable_prem numeric(11,2),
    payment_type1 numeric(11,2),
    payment_type2 numeric(11,2),
    payment_type3 numeric(11,2),
    payment_type4 numeric(11,2),
    payment_type5 numeric(11,2),
    pol_year varchar(4),
    pol_period varchar(4),
    insured_name varchar(100),
    payee_name varchar(100),
    owner_name varchar(100),
    owner_addr1 varchar(100),
    owner_addr2 varchar(100),
    owner_addr3 varchar(100),
    iss_year varchar(4),
    plan_code varchar(5),
    vers_num varchar(2),
    valn_code varchar(5),
    prod_cat varchar(5),
    prem_chrg_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tpics_ntu_sg (
    pics_pol_num varchar(10) not null,
    owner_id_num varchar(20) not null,
    owner_nm varchar(60) not null,
    insured_id_num varchar(20) not null,
    insured_nm varchar(60) not null,
    appl_stat_cd varchar(2) not null,
    agt_code varchar(5),
    br_code varchar(5),
    spl_notes varchar(500)
);

CREATE TABLE IF NOT EXISTS cas.tpics_ntu_substd_sg (
    pics_pol_num varchar(10) not null,
    substd_cde varchar(10) not null
);

CREATE TABLE IF NOT EXISTS cas.tpk_rpl_logs (
    pol_num varchar(20) not null,
    trxn_id varchar(30) not null,
    txl_num numeric(7) not null,
    tbl_nm varchar(50) not null,
    old_prim_key varchar(200) not null,
    new_prim_key varchar(200) not null
);

CREATE TABLE IF NOT EXISTS cas.tplans_bak (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    loan_int_typ varchar(1) not null,
    loan_dflt_int numeric(7,5) not null,
    loan_max_pct numeric(5,2) not null,
    mli_prem_prd numeric(3) not null,
    mli_bnft_prd numeric(3) not null,
    mli_ln_bus varchar(2) not null,
    par_code varchar(1) not null,
    assum_int_rt numeric(7,5) not null,
    comm_by_age varchar(1) not null,
    comm_by_band varchar(1) not null,
    comm_by_crcy varchar(1) not null,
    comm_by_dur varchar(1) not null,
    comm_ctl varchar(1) not null,
    mli_fnd_code varchar(2) not null,
    mli_mnl_code varchar(3) not null,
    plan_lng_desc varchar(50) not null,
    plan_shrt_desc varchar(20) not null,
    mli_plan_type varchar(1) not null,
    mli_sub_type varchar(3) not null,
    ins_typ varchar(3) not null,
    mult_base_ind varchar(1) not null,
    mode_fct_mo numeric(6,5) not null,
    mode_fct_semi numeric(6,5) not null,
    mode_fct_qtr numeric(6,5) not null,
    nfo_dflt varchar(1) not null,
    nfo_apl_cd varchar(1) not null,
    nfo_rpu_ok varchar(1) not null,
    nfo_eti_ok varchar(1) not null,
    renw_prd numeric(3) not null,
    renw_cntct_ind varchar(1) not null,
    spec_fcn_ind varchar(1) not null,
    cv_avail_ind varchar(1) not null,
    cvg_typ varchar(1) not null,
    dscnt_cv_rt numeric(5,5) not null,
    dth_bnft_ind varchar(1) not null,
    sngl_prem_ind varchar(1) not null,
    div_dflt varchar(1) not null,
    eff_fr_dt timestamp not null,
    endow_ctl varchar(1) not null,
    fmly_cvg_ind varchar(1) not null,
    ipo_pct numeric(5,2) not null,
    ipo_trmn_age numeric(3) not null,
    ipo_trmn_yr numeric(3) not null,
    prem_age_basis varchar(1) not null,
    prem_by_sex varchar(1) not null,
    prem_by_band varchar(1) not null,
    prem_by_clas varchar(1) not null,
    prem_by_smkr varchar(1) not null,
    prem_by_occp varchar(1) not null,
    pc_fct_ann numeric(7,5) not null,
    pc_fct_semi numeric(7,5) not null,
    pc_fct_qtr numeric(7,5) not null,
    pc_fct_mo numeric(7,5) not null,
    eff_to_dt timestamp,
    mkt_plan_nm varchar(50) not null,
    prem_by_ppp varchar(1) not null,
    ppp_typ varchar(1) not null,
    bpp_typ varchar(1) not null,
    ipo_max_fa numeric(13,2) not null,
    off_incep_typ varchar(1),
    prod_code varchar(5),
    vp_dflt varchar(1) not null,
    prem_by_age varchar(1) not null,
    cntrct_pg_int_rt numeric(7,5) not null,
    md_key varchar(6),
    div_fct_k1 numeric(7,3),
    div_fct_k2 numeric(7,3),
    div_fct_k3 numeric(7,3),
    ipo_max_fa_me numeric(5,2),
    plan_avail_cd varchar(1) not null,
    ipo_avail_ind varchar(1) not null,
    cmp_page2_frmt numeric(2) not null,
    anty_ctl varchar(1),
    anty_freq numeric(2),
    no_grp_dscnt_ind varchar(1) not null,
    sell_as_rdr_ind varchar(1) not null,
    rst_prem_ind varchar(1),
    lump_sum_int_rt numeric(7,5),
    band_like_base_ind varchar(1) not null,
    band_prem_prd numeric(3),
    eti_factor numeric(4,3) not null,
    comm_by_dc varchar(1),
    ret_prem_ind varchar(1),
    pkg_plan_ind varchar(1),
    age_calc_rule varchar(1),
    cb_pct_1st numeric(3),
    cb_pct_2nd numeric(3),
    cv_payo_mth numeric(3),
    crcy_code varchar(2),
    maturity_ind varchar(1),
    mode_fct_mo_auto numeric(6,5),
    prem_by_int_rt varchar(1),
    pua_payo_mth numeric(3),
    tb_ctl varchar(1),
    wp_typ varchar(1),
    rpu_par_code varchar(1),
    eti_par_code varchar(1),
    eti_endow_ind varchar(1),
    sec_age_typ varchar(1),
    prem_by_dist_chnl varchar(1),
    prem_by_dur varchar(1) not null,
    prem_by_sec_sex varchar(1) not null,
    add_rt_basis varchar(5),
    add_rt_factor_asp numeric(13,2),
    add_rt_factor_cp numeric(13,2),
    add_rt_factor_ind varchar(1),
    cb_months_comm numeric(2),
    cb_months_pc numeric(2),
    corridor_ctl varchar(1),
    corridor_pct numeric(3),
    cu_months_comm numeric(2),
    cu_months_pc numeric(2),
    db_adjust varchar(5),
    display_cat varchar(1),
    dth_bnft_pct_x numeric(6,2),
    dth_bnft_pct_y numeric(6,2),
    dth_bnft_ref_amt numeric(13,2),
    ep_cap numeric(3),
    ep_pc_fct numeric(7,5),
    fa_rnd numeric(1),
    fnd_deal_mthd varchar(5),
    fnd_surr_rule varchar(5),
    invst_prd numeric(3),
    max_psu_pct numeric(5,2),
    min_loan_amt numeric(11,2),
    min_nar numeric(13,2),
    min_psu_amt numeric(11,2),
    mode_fct_ctl varchar(1),
    no_lapse_gurt_ind varchar(1),
    plan_native_desc varchar(200),
    prem_by_rcc_ind varchar(1),
    realloc_ind varchar(1),
    recurr_bill_ind varchar(1),
    recurr_rsp_mo numeric(11,2),
    recurr_rsp_qtr numeric(11,2),
    recurr_rsp_semi numeric(11,2),
    recurr_rsp_yr numeric(11,2),
    rpt_layout_mthd varchar(5),
    surr_pv_typ varchar(1),
    xces_prem_mpre_factor numeric(3),
    arrear_calc_mthd varchar(5),
    comm_by_add_rt_basis varchar(1),
    prem_app_mthd varchar(5),
    prem_by_crcy varchar(1),
    prem_by_no_of_insrd varchar(1),
    prem_calc_mthd varchar(5),
    prod_cat varchar(5),
    min_tro_amt numeric(13,3),
    min_topup_amt numeric(13,2),
    rider_typ varchar(2),
    min_pol_prem numeric(13,2),
    lien_ind varchar(1),
    sa_tup_pct numeric(5,2),
    chg_insrd_ind varchar(1),
    ph_opt varchar(1),
    ph_avail_mth numeric(3),
    rst_mthd varchar(6),
    coi_age_basis varchar(1),
    endow_payo_mth numeric(3),
    eti_endow_ctl varchar(1),
    rpu_endow_ctl varchar(1),
    nsp_by_bpp varchar(1) not null,
    nsp_by_band varchar(1) not null,
    dv_by_ppp varchar(1) not null,
    pua_div_opt varchar(1),
    db_by_ppp varchar(1) not null,
    rv_fct_pmt numeric(1),
    max_ln_fct_div numeric(1),
    rv_fct_div numeric(1),
    anty_mature_yr numeric(2),
    db_opt varchar(1),
    int_snstv_ind varchar(1),
    no_band_pct_extra varchar(1),
    plan_cpny varchar(1),
    wp_mthd varchar(1),
    db_by_dth_typ varchar(1),
    div_payo_mth numeric(3),
    sep_loan_ind varchar(1),
    sa_fct_ind varchar(1),
    pv_by_sec_age varchar(1) not null,
    pv_by_ppp varchar(1) not null,
    pv_by_band varchar(1) not null,
    prem_by_bpp varchar(1) not null,
    pdf_cap_opt varchar(5),
    pc_ctl varchar(2),
    nsp_by_ppp varchar(1) not null,
    dv_by_bpp varchar(1) not null,
    db_by_bpp varchar(1) not null,
    dscnt_by_bill_mthd varchar(1),
    dscnt_by_prem_band varchar(1),
    sa_wthdr_pct numeric(5,2),
    pv_by_bpp varchar(1) not null,
    comm_by_bpp varchar(1) not null,
    prem_fa_opt varchar(1) not null,
    fnd_lay_ind varchar(1),
    sio_ind_dflt varchar(1),
    anty_mature_age numeric(3),
    div_calc_mthd varchar(1) not null,
    valn_code varchar(5),
    comm_by_bnft_dur varchar(1) not null,
    comm_by_anp varchar(1),
    eti_fa_ind varchar(1),
    eti_dth_bnft_ind varchar(1) not null,
    rpu_dth_bnft_ind varchar(1) not null,
    set_ctl varchar(2),
    set_opt_dflt varchar(5),
    ph_mthd varchar(1),
    gen_renw_pc_ind varchar(1),
    plan_shrt_cd varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.tplans_dscnt_rt (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    dscnt_typ varchar(1) not null,
    sex varchar(1) not null,
    dscnt_rt numeric(7,4),
    date_crt timestamp,
    usr_crt varchar(30),
    date_amd timestamp,
    usr_amd varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.tplans_oic_gateway_setup (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    oic_field_nm varchar(100) not null,
    oic_thai_desc varchar(100),
    oic_eng_desc varchar(100),
    show_amt numeric,
    show_text varchar(2000)
);

CREATE TABLE IF NOT EXISTS cas.tplans_prem_tolerance (
    terr_cd varchar(2) not null,
    crcy_code varchar(2) not null,
    dist_chnl_cd varchar(2) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    tol_typ varchar(4) not null,
    tol_cat varchar(1) not null,
    lower_tol_limit numeric(20,2) not null,
    lower_tol_fmt varchar(2) not null,
    upper_tol_limit numeric(20,2) not null,
    upper_tol_fmt varchar(2) not null,
    within_tol varchar(1),
    prem_tol_acct varchar(10),
    chrg_to varchar(1),
    fr_mth numeric(3) not null,
    to_mth numeric(3) not null
);

CREATE TABLE IF NOT EXISTS cas.tplans_prem_val (
    plan_grp_nm varchar(20) not null,
    eff_fr_dt timestamp not null,
    eff_to_dt timestamp,
    net_profit_pct numeric(5,4) not null,
    tax_pct numeric(5,4) not null,
    int_cal numeric(5,4) not null,
    infl_yr numeric(2) not null,
    exp_initial numeric(10,2) not null,
    exp_renewal numeric(10,2) not null,
    exp_nac_pct numeric(5,4) not null,
    exp_sa_pct numeric(5,4) not null,
    inflt_pct numeric(5,4) not null,
    nac_factor numeric(5,4) not null,
    bonus_fyc_pct numeric(5,4) not null,
    bonus_syc_pct numeric(5,4) not null,
    bonus_ryc_pct numeric(5,4) not null,
    pricing_sa numeric(10,2) not null
);

CREATE TABLE IF NOT EXISTS cas.tplans_sg (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    fcn_id varchar(20),
    p_vers varchar(2),
    plan_desc varchar(100),
    fcn_type varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tplan_activity_days (
    plan_code varchar(20) not null,
    actv_typ varchar(7) not null,
    actv_day varchar(20) not null,
    ref_rule varchar(1) not null,
    report_id varchar(20),
    ref_prd varchar(2),
    ref_date varchar(30) not null,
    cvg_typ varchar(1),
    actv_day_typ varchar(1),
    actv_seq numeric(2),
    actv_reasn varchar(10) not null,
    actv_dt timestamp,
    fr_dur numeric(4) not null,
    to_dur numeric(4) not null,
    nlg_ind varchar(1) not null,
    pol_stat_cd_sw varchar(1) not null,
    frez_code_sw varchar(1) not null,
    pmt_mode_sw varchar(1) not null,
    bill_mthd_sw varchar(1) not null,
    pd_to_dt_sw varchar(1) not null,
    mvy_ded_to_dt_sw varchar(1) not null,
    last_avy_dt_sw varchar(1) not null,
    nlg_ind_sw varchar(1) not null,
    apl_laps_dt_sw varchar(1) not null,
    bill_to_dt_sw varchar(1) not null,
    recurr_bill_ind_sw varchar(1) not null,
    dur_base_dt varchar(8),
    fr_include varchar(1) default 'Y' not null,
    to_include varchar(1) default 'Y' not null,
    lump_sum_ind_sw varchar(1) not null,
    bbr_flag_sw varchar(1) not null,
    actv_eff_day varchar(20),
    set_stat_cd_sw varchar(1),
    set_last_avy_dt_sw varchar(1),
    pol_stat_grp varchar(10),
    anty_stat_cd_sw varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tplan_activity_days_old (
    plan_code varchar(5) not null,
    actv_typ varchar(30) not null,
    actv_day varchar(20) not null,
    ref_rule varchar(1),
    report_id varchar(20),
    ref_prd varchar(2),
    ref_date varchar(30),
    cvg_typ varchar(1),
    actv_day_typ varchar(1),
    actv_seq numeric(2)
);

CREATE TABLE IF NOT EXISTS cas.tplan_alpha_search_ctrl (
    terr_cd varchar(2) not null,
    ctrl_typ varchar(30) not null,
    ctrl_sql varchar(255) not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_alpha_search_setup (
    terr_cd varchar(2) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    crcy_code varchar(2) not null,
    ins_typ varchar(1) not null,
    prod_cat varchar(5) not null,
    ins_risk_typ varchar(10) not null,
    native_risk_typ_op varchar(1) not null,
    native_risk_typ varchar(10) not null,
    native_sub_typ_op varchar(1) not null,
    native_sub_risk_typ varchar(10) not null,
    multiplier numeric(13,2),
    risk_amt_typ varchar(40) not null,
    risk_amt_valu numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tplan_anty_ctls (
    plan_grp_nm varchar(20) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    set_opt varchar(2) not null,
    int_rt numeric(7,5),
    anty_dur numeric(3,1),
    anty_payo_mode varchar(1),
    regr_calc_mode varchar(1),
    regr_calc_mthd varchar(2),
    anty_base varchar(2),
    lump_sum_ind varchar(1),
    wthdr_ind varchar(1),
    payo_dpnd varchar(4),
    pol_valu_opt varchar(2),
    pol_valu_min numeric(13,2),
    anty_payo_chnl varchar(1),
    payo_amt_opt varchar(2),
    payo_amt_min numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tplan_cat_dashbord_th (
    plan_code varchar(5) not null,
    plan_cat char(50)
);

CREATE TABLE IF NOT EXISTS cas.tplan_charges (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    chg_typ varchar(10) not null,
    fr_yr numeric(2),
    to_yr numeric(2),
    pmt_mode varchar(2),
    cvg_typ varchar(1),
    comm_ind numeric(1),
    bill_mthd varchar(1),
    chg_amt numeric(11,3),
    crcy_code varchar(2) default '*' not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_conv_mappings (
    fr_plan_code varchar(5),
    fr_vers_num varchar(2),
    to_plan_code varchar(5),
    to_vers_num varchar(2),
    reasn_code varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tplan_cpf_age_rge (
    plan_code varchar(5),
    vers_num varchar(2),
    cpf_min_age numeric(2),
    cpf_max_age numeric(2),
    cpf_prod_code varchar(10),
    crcy_code varchar(2) default '*' not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_cvg_clas (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_clas varchar(3) not null,
    cvg_clas_desc varchar(100) not null,
    cvg_edit varchar(1000),
    eff_age_low numeric(3) not null,
    eff_age_high numeric(3) not null,
    crcy_code varchar(2) not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_dpnd_rules (
    pir_num numeric(8) not null,
    subj_plan_code_typ varchar(1) not null,
    subj_plan_code varchar(20) not null,
    subj_vers_num varchar(10) not null,
    dpnd_rule varchar(4) not null,
    obj_plan_code_typ varchar(1) not null,
    obj_plan_code varchar(20),
    obj_vers_num varchar(10),
    cond_eval_oper varchar(1) not null,
    vcnd1_same_eff_dt varchar(1),
    pcnd1_typ varchar(1) not null,
    pcnd1_expr varchar(200),
    error_lvl varchar(1) not null,
    rule_desc varchar(100) not null,
    eff_age_low numeric(3) not null,
    eff_age_high numeric(3) not null,
    package_ind varchar(1),
    crcy_code varchar(2) not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_dscnt_fct_sg (
    plan_code varchar(5) not null,
    dscnt_fct_cd varchar(1) not null,
    dscnt_fct numeric(8,6)
);

CREATE TABLE IF NOT EXISTS cas.tplan_edit_vars (
    var_nm varchar(20) not null,
    src_typ varchar(2) not null,
    oper_cd varchar(3) not null,
    rslt_typ varchar(1) not null,
    plan_code_typ varchar(1) not null,
    plan_code varchar(20),
    vers_num varchar(10),
    rel_to_insrd varchar(2),
    col_nm varchar(30),
    var_desc varchar(100) not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_extra_typ (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    extra_prem_typ varchar(1) not null,
    extra_prem_formula varchar(2) not null,
    ub_discp_flag varchar(1) default 'N' not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_face_amts (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    rel_to_insrd varchar(2) not null,
    crcy_code varchar(2) not null,
    fa_typ_low varchar(1) not null,
    face_amt_low numeric(13,2),
    fa_edit_low varchar(200),
    fa_typ_high varchar(1) not null,
    face_amt_high numeric(13,2),
    fa_edit_high varchar(200),
    error_lvl varchar(1) not null,
    eff_age_low numeric(3) not null,
    eff_age_high numeric(3) not null,
    eff_fr_dt timestamp not null,
    eff_to_dt timestamp not null,
    sex_code varchar(1) default '*' not null,
    smkr_code varchar(1) default '*' not null,
    error_lvl_quota varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tplan_factors (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    plan_grp_nm varchar(20) not null,
    crcy_code varchar(2) not null,
    eff_fr_dt timestamp not null,
    eff_to_dt timestamp not null,
    mode_fct_mo numeric(6,5) not null,
    mode_fct_semi numeric(6,5) not null,
    mode_fct_qtr numeric(6,5) not null,
    mode_fct_mo_auto numeric(6,5) not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_fund_links (
    plan_code varchar(5) not null,
    plan_vers_num varchar(2) not null,
    fund_cd varchar(5) not null,
    fund_vers_num varchar(6) not null,
    fr_dur numeric(3) not null,
    to_dur numeric(3) not null,
    def_aloc_pct numeric(5,2),
    aloc_mthd varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.tplan_fund_mappings (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    fr_dur numeric(3) not null,
    to_dur numeric(3),
    alloc_pct numeric(5,2) not null,
    alloc_mthd varchar(5),
    min_alloc_pct numeric(3),
    crcy_code varchar(2) default '*' not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_fund_xfer_rules (
    plan_code varchar(5),
    vers_num varchar(2),
    stat_code varchar(1) default '*',
    acct_mne_cd varchar(8),
    cr_or_dr varchar(1),
    error_lvl varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tplan_groups (
    plan_grp_nm varchar(20) not null,
    plg_num numeric(4) not null,
    plan_code_typ varchar(1) not null,
    plan_code varchar(20) not null,
    vers_num varchar(10) not null,
    error_lvl varchar(1) not null,
    grp_desc varchar(100) not null,
    crcy_code varchar(2) default '*' not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_group_parameters (
    parm_typ varchar(30) not null,
    plan_grp_nm varchar(20) not null,
    eff_dt timestamp not null,
    parm_valu varchar(40),
    parm_desc varchar(50),
    crcy_code varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tplan_hash_total_sg (
    plan_code varchar(5),
    plan_group varchar(30),
    eff_age_low numeric(2),
    eff_age_high numeric(2)
);

CREATE TABLE IF NOT EXISTS cas.tplan_ins_risk_typ (
    terr_cd varchar(2) not null,
    ins_risk_typ varchar(10) not null,
    ins_risk_typ_desc varchar(255) not null,
    ins_risk_typ_eff_period numeric(4),
    ins_risk_col varchar(40),
    eff_cvg_stat varchar(1) not null,
    parent_risk_typ varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tplan_map_page3 (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_typ varchar(1),
    full_plan_code varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tplan_member_versions (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    rel_to_insrd varchar(2) not null,
    pol_val_vers varchar(2) not null,
    comm_vers varchar(2) not null,
    prem_vers varchar(2) not null,
    bnft_prd_ind varchar(1),
    prem_prd_ind varchar(1),
    prem_prd numeric(3),
    bnft_prd numeric(3),
    eff_age_low numeric(3),
    eff_age_high numeric(3),
    error_lvl varchar(1),
    eff_age_low_rule varchar(1),
    eff_age_high_rule varchar(1),
    ppp_renw_fct numeric(2) not null,
    bpp_renw_fct numeric(2) not null,
    crcy_code varchar(2) not null,
    eff_dt timestamp not null,
    anty_xcpt varchar(20),
    bnft_age numeric(3),
    cv_xcpt varchar(20),
    db_xcpt varchar(20),
    div_xcpt varchar(20),
    eti_xcpt varchar(20),
    prem_age numeric(3),
    rpu_xcpt varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.tplan_min_db_sg (
    plan_code varchar(5),
    vers_num varchar(2),
    eff_dt timestamp,
    issue_age_fr numeric(2),
    issue_age_to numeric(2),
    mdb_fct numeric(9,2)
);

CREATE TABLE IF NOT EXISTS cas.tplan_mort_mappings (
    mort_typ varchar(1) not null,
    plan_code varchar(5) not null,
    md_key varchar(10) not null,
    eff_fr_dur numeric(3),
    eff_to_dur numeric(3),
    vers_num varchar(2) not null,
    crcy_code varchar(2) default '*' not null,
    min_eti_age_m numeric(3),
    min_eti_age_f numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tplan_mthd_overrides (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    mthd_mne_cd varchar(20) not null,
    ovrid_valu varchar(20) not null,
    mthd_desc varchar(50),
    crcy_code varchar(2) default '*' not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_occp_clas (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    occp_clas varchar(3) not null,
    occp_clas_desc varchar(100) not null,
    occp_edit varchar(200),
    eff_age_low numeric(3) not null,
    eff_age_high numeric(3) not null,
    crcy_code varchar(2) default '*' not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_online_dur_edit (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    crcy_code varchar(2) not null,
    dur_typ varchar(2) not null,
    fr_prem_dur_bf numeric(4) not null,
    to_prem_dur_bf numeric(4) not null,
    fr_prem_dur_aft numeric(4) not null,
    to_prem_dur_aft numeric(4) not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_online_edit_rules (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    crcy_code varchar(2) not null,
    bill_mthd varchar(1) not null,
    pmt_mode varchar(5) not null,
    min_face_amt_inc numeric(13,2),
    min_face_amt_basis varchar(1),
    min_pp_inc numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tplan_parameters (
    parm_typ varchar(30) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    eff_dt timestamp not null,
    parm_valu varchar(40),
    parm_desc varchar(50),
    rpu_rndrule_ind varchar(1),
    eti_rndrule_ind varchar(1),
    crcy_code varchar(2),
    fr_dur numeric(5),
    to_dur numeric(5)
);

CREATE TABLE IF NOT EXISTS cas.tplan_payout_setups (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    plan_grp_nm varchar(20) not null,
    payo_stat_cd varchar(1) not null,
    prem_prd numeric(3) not null,
    cli_typ varchar(1) not null,
    fr_eff_age numeric(3) not null,
    to_eff_age numeric(3) not null,
    fr_eff_dur numeric(3) not null,
    to_eff_dur numeric(3) not null,
    fr_mth numeric(2),
    to_mth numeric(2),
    payo_freq numeric(2),
    payo_basis varchar(30),
    payo_rt numeric(5,2),
    acct_link_typ varchar(10),
    payo_term numeric(2) default -1 not null,
    payo_num numeric(2) default 1 not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_pdf_ctls (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    eff_dt timestamp not null,
    pdf_opt varchar(1) not null,
    dflt_opt varchar(1) not null,
    pdf_dur numeric(3),
    pdf_int_eff_ctl varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.tplan_prd_info (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    crcy_code varchar(2) not null,
    prem_dur numeric(2) not null,
    bnft_dur numeric(2) not null,
    plan_lng_desc varchar(50) not null,
    plan_shrt_desc varchar(20) not null,
    mkt_plan_nm varchar(50) not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_prems (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    pmt_mode varchar(2) not null,
    crcy_code varchar(2) not null,
    prem_low numeric(13,2) not null,
    prem_high numeric(13,2) not null,
    error_lvl varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_prem_discounts (
    plan_code varchar(5) not null,
    prem_vers varchar(2) not null,
    crcy_code varchar(2) not null,
    eff_dt timestamp not null,
    prem_band_low numeric(13,2) not null,
    prem_band_high numeric(13,2) not null,
    dscnt_prem_per_unit numeric(10,3) not null,
    unit_basis varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_prem_grp_mappings (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    prem_grp varchar(3) not null,
    crcy_code varchar(2) default '*' not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_prod_code_sg (
    plan_code varchar(5) not null,
    vers_num varchar(5) not null,
    fran_code varchar(5) not null,
    prod_code varchar(10),
    prod_int_ref varchar(60)
);

CREATE TABLE IF NOT EXISTS cas.tplan_prod_groups_sg (
    plan_code varchar(20) not null,
    vers_num varchar(10) not null,
    prod_grp varchar(20) not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_prt_seq (
    plan_code varchar(5) not null,
    prt_seq numeric(3) not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_prt_seq_tw (
    plan_code varchar(5) not null,
    prt_seq numeric(3) not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_rst_pay_rule (
    plan_code varchar(5),
    pay_typ varchar(1),
    dur numeric,
    rst_mthd varchar(6),
    pay_rule varchar(3),
    os_chrg_rule varchar(1),
    gp_chrg_rule varchar(1),
    la_chrg_rule varchar(1),
    num_mode numeric
);

CREATE TABLE IF NOT EXISTS cas.tplan_settlement (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    settle_code varchar(2) not null,
    sex_code varchar(1) not null,
    eff_age numeric(3) not null,
    unit_basis varchar(1) not null,
    amt_per_unit numeric(11,3),
    crcy_code varchar(2) default '*' not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_sub_desc (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    psd_num numeric(3) not null,
    desc_typ varchar(1) not null,
    sub_desc1 varchar(100),
    sub_desc2 varchar(100),
    face_amt_typ varchar(1) not null,
    face_amt numeric(13,2) not null,
    bp_fa_pct numeric(5,2) not null,
    cvg_clas varchar(3) not null,
    is_level varchar(1),
    crcy_code varchar(2) default '*' not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_sub_desc_cmp (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    psd_num numeric(3) not null,
    desc_typ varchar(1) not null,
    sub_desc1 varchar(100),
    sub_desc2 varchar(100),
    face_amt_typ varchar(1) not null,
    face_amt numeric(13,2) not null,
    bp_fa_pct numeric(5,2) not null,
    cvg_clas varchar(3) not null,
    is_level varchar(1),
    crcy_code varchar(2) default '*' not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_term_mappings_tw (
    term_typ varchar(2) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    term_key varchar(10) not null,
    eff_fr_dur numeric(3),
    eff_to_dur numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tplan_unable_deduct_tax_th (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    eff_age_low numeric(3),
    eff_age_high numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tplan_wp_mappings (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    wp_plan_code varchar(5) not null,
    wp_vers_num varchar(2) not null,
    wp_prem_age_basis varchar(1),
    wp_prem_vers varchar(2) not null,
    pb_to_wp_plan_code varchar(5),
    pb_to_wp_vers_num varchar(2),
    base_plan_code varchar(5) not null,
    base_vers_num varchar(2) not null,
    base_crcy_code varchar(2) default '*' not null,
    pb_to_wp_crcy_code varchar(2) default '*' not null,
    wp_crcy_code varchar(2) default '*' not null,
    crcy_code varchar(2) default '*' not null
);

CREATE TABLE IF NOT EXISTS cas.tplan_wp_mappings_backup (
    plan_code varchar(5),
    vers_num varchar(2),
    wp_plan_code varchar(5),
    wp_vers_num varchar(2),
    wp_prem_age_basis varchar(1),
    wp_prem_vers varchar(2),
    pb_to_wp_plan_code varchar(5),
    pb_to_wp_vers_num varchar(2),
    base_plan_code varchar(5),
    base_vers_num varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tplan_wp_mappings_load (
    plan_code varchar(5),
    vers_num varchar(2),
    wp_plan_code varchar(5),
    wp_vers_num varchar(2),
    wp_prem_age_basis varchar(1),
    wp_prem_vers varchar(2),
    pb_to_wp_plan_code varchar(5),
    pb_to_wp_vers_num varchar(2),
    base_plan_code varchar(5),
    base_vers_num varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tplan_xcpt_factors (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    crcy_code varchar(2) not null,
    xcpt_pgm varchar(20) not null,
    fct_typ varchar(10) not null,
    eff_age numeric(3) not null,
    eff_dur numeric(3) not null,
    fct_valu numeric(20,10) not null
);

CREATE TABLE IF NOT EXISTS cas.tpmt_payee_hist_sg (
    crcy_code varchar(2) not null,
    pmt_typ varchar(30) not null,
    trxn_num numeric(8) not null,
    payee_id_typ varchar(1) not null,
    payee_id_num varchar(13) not null,
    payee_nm varchar(32),
    amt_pd numeric(11,2),
    share_pct numeric(5,2),
    chq_num varchar(8),
    chq_iss_bank varchar(32),
    chq_iss_dt timestamp,
    chq_post_dt timestamp,
    chq_post_to varchar(6),
    chq_stat_cd varchar(30),
    chq_stat_eff_dt timestamp,
    created_by varchar(6),
    date_created timestamp,
    amended_by varchar(6),
    date_amended timestamp
);

CREATE TABLE IF NOT EXISTS cas.tpnbtha725 (
    trxn_id varchar(15) not null,
    trxn_dt timestamp not null,
    pol_num varchar(10) not null
);

CREATE TABLE IF NOT EXISTS cas.tpnbtha725_cvg_extra (
    trxn_id varchar(15) not null,
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    std_med_grd varchar(2),
    std_med_dur numeric(2) default 0,
    med_1_rt numeric(6,2) default 0.00,
    med_1_dur numeric(2) default 0,
    med_2_rt numeric(6,2) default 0.00,
    med_2_dur numeric(2) default 0,
    med_3_rt numeric(6,2) default 0.00,
    med_3_dur numeric(2) default 0,
    life_rt numeric(6,2) default 0.00,
    life_dur numeric(2) default 0,
    morb_rt numeric(6,2) default 0.00,
    morb_dur numeric(2) default 0,
    tpd_occup_rt numeric(6,2) default 0.00,
    tpd_occup_dur numeric(2) default 0,
    tpd_med_rt numeric(6,2) default 0.00,
    tpd_med_dur numeric(2) default 0
);

CREATE TABLE IF NOT EXISTS cas.tpolicys_bf_re (
    pol_num varchar(10) not null,
    mode_prem numeric(11,2) not null,
    ovr_loan_ind varchar(1) not null,
    frez_code varchar(1) not null,
    ipo_ind varchar(1) not null,
    vp_ind varchar(1) not null,
    reins_ind varchar(1) not null,
    bill_mthd varchar(1) not null,
    crcy_code varchar(2) not null,
    last_avy_dt timestamp not null,
    last_pd_to_dt timestamp not null,
    pd_to_dt timestamp not null,
    pol_eff_dt timestamp not null,
    pol_iss_dt timestamp,
    pol_reiss_dt timestamp,
    cnfrm_acpt_dt timestamp,
    pol_rlse_dt timestamp,
    sbmt_dt timestamp not null,
    pol_stat_cd varchar(1) not null,
    state_cd varchar(2) not null,
    pol_trmn_dt timestamp,
    div_opt varchar(1) not null,
    terr_cd varchar(2) not null,
    dscnt_prem numeric(11,2) not null,
    pol_susp numeric(13,2) not null,
    pmt_susp numeric(11,2) not null,
    ipo_last_refu_yr numeric(4),
    pmt_mode varchar(5) not null,
    bill_prem numeric(11,2) not null,
    bill_to_dt timestamp not null,
    pac_loan_repy numeric(11,2),
    pac_bk_ctr varchar(1),
    pac_eff_dt timestamp,
    medic_code varchar(10),
    medic_dt timestamp,
    incmplt_cd varchar(2),
    pend_cd varchar(2),
    subj_to_cd varchar(2),
    uwg_clas varchar(30),
    fran_num varchar(4),
    agt_code varchar(6),
    nfo_opt varchar(1) not null,
    nfo_eff_dt timestamp,
    zap_ind varchar(1),
    aea_ind varchar(1) not null,
    lnb_ind varchar(1) not null,
    hiv_ind varchar(1) not null,
    pol_rmrk varchar(500),
    apl_laps_dt timestamp,
    pc_typ varchar(10),
    pc_recv_dt timestamp,
    pc_pend_reasn varchar(10),
    pc_efft_date timestamp,
    apl_ext_days numeric(3),
    nyr_mode_prem numeric(11,2) not null,
    nyr_dscnt_prem numeric(11,2) not null,
    renw_yr numeric(3) not null,
    run_num numeric(2),
    pol_app_dt timestamp,
    tlia_code_1 varchar(10),
    tlia_code_2 varchar(10),
    tlia_code_3 varchar(10),
    disab_clas varchar(3),
    restr_case_cnt_ind varchar(1) not null,
    comm_wthld_dt timestamp,
    nb_user_id varchar(30) not null,
    last_actv_dt timestamp,
    joint_cli_dth_ind varchar(1) not null,
    comprop_prem numeric(11,2),
    resv_dnr_amt numeric(13,2),
    xcpt_bill_cd varchar(1),
    nb_pc_pol_tot numeric(9),
    cnfrm_prt_dt timestamp,
    os_anty_susp numeric(13,2),
    payo_mthd varchar(1),
    anty_stat_cd varchar(1),
    nxt_eff_mode_prem numeric(11,2),
    nxt_eff_dscnt_prem numeric(11,2),
    nxt_eff_prem_dt timestamp,
    ctr_prem numeric(11,2),
    nxt_eff_ctr_prem numeric(11,2),
    lump_sum_ind varchar(1),
    lump_sum_pmt_amt numeric(11,2),
    proc_fee_ind varchar(1),
    dist_chnl_cd varchar(2),
    tot_prem_appy numeric(15,2),
    prefix_cd varchar(3),
    oth_rqmts_text varchar(60),
    mort_cd varchar(6),
    chg_insrd_opt varchar(1),
    convrt_fr_pol varchar(10),
    apl_lapse_ind varchar(1),
    div_upto_dt timestamp,
    endow_ctl varchar(1),
    sa_cd_2 varchar(6),
    wa_cd_1 varchar(6),
    wa_cd_2 varchar(6),
    vp_point timestamp,
    override_bill_day numeric(2),
    plan_code_base varchar(5),
    vers_num_base varchar(2),
    bnh_code varchar(5),
    corridor_pct numeric(3),
    curr_debit_day numeric(2),
    db_opt varchar(1),
    disable_dt timestamp,
    dth_susp numeric(13,2),
    fnd_switch_ctr numeric(3),
    fnd_wthdr_ctr numeric(3),
    iio_opt varchar(1),
    iio_pct numeric(3),
    insrd_mort varchar(4),
    ins_typ_base varchar(1),
    lst_fnd_valn_dt timestamp,
    mvy_ded_to_dt timestamp,
    nb_update_date timestamp,
    no_lapse_gurt_ind varchar(1),
    nxt_debit_day numeric(2),
    nxt_pac_eff_dt timestamp,
    nxt_rebal_date timestamp,
    occ_cd varchar(6),
    open_flag varchar(5),
    pickup_debit_day numeric(2),
    pickup_eff_dt timestamp,
    plan_prem numeric(11,2),
    pol_clm_dt timestamp,
    pric_rsrv_dt timestamp,
    rebal_ind varchar(1),
    recurr_bill_ind varchar(1),
    recurr_bill_st_dt timestamp,
    reins_cd varchar(3),
    reins_mthd varchar(1),
    restrict_cd_1 varchar(5),
    restrict_cd_2 varchar(5),
    restrict_cd_3 varchar(5),
    special_clas varchar(2),
    wrk_area varchar(4),
    non_lapse_ind varchar(1),
    lro_eff_dt timestamp,
    bbr_flag varchar(1),
    ph_ind varchar(1),
    ph_strt_dt timestamp,
    ph_end_dt timestamp,
    ph_eff_typ varchar(1),
    ph_pd_to_dt timestamp,
    ph_last_pd_to_dt timestamp,
    ph_autopay_ind varchar(1),
    anty_wthdr numeric(13,2),
    anty_dur numeric(2),
    anty_freq numeric(2),
    anty_int_rt numeric(7,5),
    anty_opt varchar(2),
    anty_payo_amt numeric(13,2),
    anty_start_dt timestamp,
    loan_ovr_int_rt numeric(7,5),
    conv_dt timestamp,
    pdf_strt_dt timestamp,
    pdf_end_dt timestamp,
    instl_strt_dt timestamp,
    instl_end_dt timestamp,
    instl_amt numeric(13,2),
    edw_loan varchar(1),
    loyal_bns_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpolicys_info_bf_re (
    pol_num varchar(10) not null,
    spec_hdl_cd varchar(1),
    retent_limit numeric(7),
    nac_rel_dt timestamp,
    anty_freq varchar(5),
    anty_start_dt timestamp,
    cvg_exp_opt varchar(1),
    dvalu_stop_dt timestamp,
    gurt_amt numeric(13,2),
    gurt_crcy_code varchar(2),
    gurt_prd numeric(3),
    interest_cap_dt timestamp,
    interest_start_dt timestamp,
    invest_start_dt timestamp,
    ovr_loan_dt timestamp,
    ovr_loan_lapse_dt timestamp,
    ovr_loan_lapse_ind varchar(1),
    occp_extra_ind varchar(1),
    scpt_hi_rh_ind varchar(1),
    pend_rmrk varchar(60),
    request_dt timestamp,
    outst_reqmts varchar(40),
    exam_dt timestamp,
    exam_reve_dt timestamp,
    agt_app_dt timestamp,
    exam_rmrk varchar(60),
    rel_ind varchar(1),
    anty_opt varchar(1),
    surr_pv_ind varchar(1),
    recurr_end_dt timestamp,
    prem_cess_by varchar(10),
    duration varchar(2),
    assignor_cli_num varchar(13),
    assgn_typ varchar(2),
    trust_type varchar(5),
    reference_no varchar(16),
    referrer_id varchar(20),
    assignor_addr_typ numeric(2)
);

CREATE TABLE IF NOT EXISTS cas.tpolicys_info_sg (
    pol_num varchar(10) not null,
    spec_hdl_cd varchar(1),
    retent_limit numeric(7),
    nac_rel_dt timestamp,
    anty_freq varchar(5),
    anty_start_dt timestamp,
    cvg_exp_opt varchar(1),
    dvalu_stop_dt timestamp,
    gurt_amt numeric(13,2),
    gurt_crcy_code varchar(2),
    gurt_prd numeric(3),
    interest_cap_dt timestamp,
    interest_start_dt timestamp,
    invest_start_dt timestamp,
    ovr_loan_dt timestamp,
    ovr_loan_lapse_dt timestamp,
    ovr_loan_lapse_ind varchar(1),
    occp_extra_ind varchar(1),
    scpt_hi_rh_ind varchar(1),
    pend_rmrk varchar(60),
    request_dt timestamp,
    outst_reqmts varchar(40),
    exam_dt timestamp,
    exam_reve_dt timestamp,
    agt_app_dt timestamp,
    exam_rmrk varchar(60),
    rel_ind varchar(1),
    anty_opt varchar(1),
    surr_pv_ind varchar(1),
    recurr_end_dt timestamp,
    prem_cess_by varchar(10),
    duration varchar(2),
    assignor_cli_num varchar(13),
    assgn_typ varchar(2),
    trust_type varchar(5),
    reference_no varchar(16),
    referrer_id varchar(20),
    assignor_addr_typ numeric(2),
    prs_ind varchar(1),
    tr_prs_end_dt timestamp,
    wrksite_co_id varchar(8)
);

CREATE TABLE IF NOT EXISTS cas.tpolicys_info_th (
    pol_num varchar(10) not null,
    ntu_reasn_cd varchar(3),
    ntu_prt_req_dt timestamp,
    postpone_dur varchar(50),
    sales_campaign varchar(10),
    app_no varchar(17),
    staff_cd varchar(15),
    staff_nm varchar(60),
    cmpny_cd varchar(5),
    tax_consent_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpolicys_info_tw (
    pol_num varchar(10) not null,
    occp_extra_ind varchar(1) default 'N',
    scpt_hi_rh_ind varchar(1) default 'N',
    pend_rmrk varchar(60),
    request_dt timestamp,
    outst_reqmts varchar(40),
    exam_dt timestamp,
    exam_reve_dt timestamp,
    agt_app_dt timestamp,
    exam_rmrk varchar(60),
    rel_ind varchar(1),
    anty_start_dt timestamp,
    anty_freq varchar(5),
    gurt_prd numeric(3),
    invest_start_dt timestamp,
    interest_start_dt timestamp,
    ovr_loan_lapse_ind varchar(1),
    ovr_loan_dt timestamp,
    ovr_loan_lapse_dt timestamp,
    interest_cap_dt timestamp,
    gurt_amt numeric(18,8),
    gurt_crcy_code varchar(2),
    anty_opt varchar(1),
    cvg_exp_opt varchar(1),
    dvalu_stop_dt timestamp,
    surr_pv_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpolicys_sg (
    pol_num varchar(10) not null,
    rescission_dt timestamp,
    hps_ind varchar(1) default 'N',
    sm_code varchar(6),
    bm_code varchar(5),
    ann_fyp numeric(11,2),
    last_stofac_dt timestamp,
    pfp_choice varchar(1),
    pac_bk_ctr varchar(1),
    intro_agt_code varchar(5),
    pfp_health varchar(1),
    auto_nb_wp varchar(1),
    batch_no varchar(10),
    seq_no numeric(2),
    delivery_dt timestamp,
    mdb_fct numeric(9,2),
    ext_repl_pol varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_activity_bf_cas_dt (
    pol_num varchar(10) not null
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_bonuses (
    pol_num varchar(10) not null,
    seq_num numeric(3) not null,
    plan_code varchar(5) not null,
    plan_vers varchar(2) not null,
    crcy_code varchar(2) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    strt_dt timestamp,
    end_dt timestamp,
    bonus_method numeric(1),
    bonus_pct numeric(5,2),
    cmpn_code varchar(10) not null,
    acct_mne_cd varchar(8)
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_change_status (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    crcy_code varchar(2) not null,
    chg_action varchar(10) not null,
    stat_valid varchar(1) not null,
    quota_allowed varchar(1) default 'Y',
    incl_ind varchar(1) default 'Y'
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_contracts_sg (
    plan_code varchar(5),
    vers_num varchar(2),
    cvg_eff_dt_from timestamp,
    cvg_eff_dt_to timestamp,
    contract_num varchar(20),
    img_path varchar(100)
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_counters (
    pol_num varchar(10) not null,
    pol_ctr_nm varchar(20) not null,
    pol_ctr_valu numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_discounts (
    pol_num varchar(10) not null,
    seq_num numeric(3) not null,
    plan_code varchar(5) not null,
    plan_vers varchar(2) not null,
    crcy_code varchar(2) not null,
    chrg_cat varchar(10) not null,
    chrg_typ varchar(10) not null,
    strt_dt timestamp,
    end_dt timestamp,
    dscnt_factor_k numeric(5,2),
    dscnt_constant_k numeric(5),
    dscnt_factor_c numeric(5,2),
    dscnt_constant_c numeric(5),
    cmpn_code varchar(10) not null
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_follow_up (
    pol_num varchar(10) not null,
    follow_up_dt timestamp not null,
    follow_up_reason varchar(200),
    user_id varchar(30) not null,
    follow_up_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_log (
    pol_num varchar(10) not null,
    plan_code_base varchar(5),
    vers_num_base varchar(2),
    mode_prem numeric(11,2) not null,
    dscnt_prem numeric(11,2) not null,
    nyr_mode_prem numeric(11,2) not null,
    nyr_dscnt_prem numeric(11,2) not null,
    sbmt_dt timestamp not null,
    pol_iss_dt timestamp,
    cnfrm_acpt_dt timestamp,
    pol_eff_dt timestamp not null,
    last_pd_to_dt timestamp not null,
    pmt_mode varchar(5) not null,
    medic_code varchar(10),
    medic_dt timestamp,
    pol_yr numeric,
    pol_stat_cd varchar(1) not null,
    insured_age numeric,
    agt_code varchar(6),
    service_agt_1 varchar(6),
    service_agt_2 varchar(6),
    frez_code varchar(1) not null,
    bill_mthd varchar(1) not null,
    pol_trmn_dt timestamp,
    fran_num varchar(4),
    ph_ind varchar(1),
    ph_strt_dt timestamp,
    ph_end_dt timestamp,
    ph_eff_typ varchar(1),
    ph_pd_to_dt timestamp,
    ph_last_pd_to_dt timestamp,
    ph_autopay_ind varchar(1),
    crt_date timestamp not null,
    exp_date timestamp
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_mail_sg (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_msg_th (
    msg_trn_no numeric(10) not null,
    msg_typ_th varchar(1) not null,
    msg_ref varchar(10) not null,
    msg1 varchar(80),
    msg2 varchar(80),
    attend_date timestamp,
    msg_sta_th varchar(1),
    intend_usr varchar(30),
    actual_usr varchar(30),
    dt_last_attend timestamp,
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_payo_arang (
    pol_num varchar(10) not null,
    payo_ctl varchar(10) not null,
    fr_pol_yr numeric(3) not null,
    to_pol_yr numeric(3) not null,
    payo_mthd varchar(10) not null,
    payo_crcy varchar(2) not null,
    payo_arang varchar(10) not null
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_print_histories (
    request_id numeric(10) not null,
    pol_num varchar(10) not null,
    fcn_id varchar(20),
    lst_prt_dt timestamp,
    crt_dt timestamp,
    lst_req_user varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_regen_activity (
    pol_num varchar(10) not null
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_rqst (
    pol_num varchar(10) not null,
    prt_rqst varchar(20) not null,
    rslt_valu varchar(1) not null,
    rqst_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_set_gen_ctl (
    ctl_nm varchar(20) not null,
    page3 varchar(1) not null,
    comprop varchar(1) not null,
    agt_card varchar(1) not null,
    cnfrm_slip varchar(1) not null,
    recpt varchar(1) not null,
    coi varchar(1) not null,
    cli_card varchar(1) not null,
    thkyou_ltr varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_set_messages (
    mess_typ varchar(10) not null,
    mess_cat varchar(10) not null,
    mess_seq numeric not null,
    mess_desc varchar(200)
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_set_opt_hdrs (
    pol_num varchar(10) not null,
    eff_dt timestamp not null,
    stat_cd varchar(2) not null,
    seq_num varchar(3) not null,
    prcd_amt numeric(11,2),
    proc_cd varchar(10),
    plan_code varchar(5),
    vers_num varchar(2),
    cli_num varchar(10),
    cvg_eff_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_set_opt_dtls (
    pol_num varchar(10) not null,
    seq_num varchar(3) not null,
    set_opt varchar(5) not null,
    set_amt numeric(13,2),
    set_pct numeric(5,2),
    set_to_pol_num varchar(10) default '*' not null,
    set_payo_freq numeric(2),
    set_payo_dur numeric(2),
    set_payo_crtn_dur numeric(2),
    set_payo_rt numeric(12,6),
    set_rmrk varchar(50),
    payo_mthd varchar(10),
    payo_crcy varchar(2),
    payo_arang varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_set_type (
    rqst_typ varchar(5) not null,
    prt_rqst varchar(20) not null,
    seq_num numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_uw_dets_th (
    pol_num varchar(10) not null,
    ins_ind varchar(1) not null,
    ans_nb1 varchar(1) not null,
    ans_nb2 varchar(1) not null,
    ans_nb3 varchar(1),
    ans_nb4 varchar(1) not null,
    ans_nb5 varchar(1) not null,
    ans_nb6 varchar(1) not null,
    fa_age_death numeric(3),
    fa_cause_death varchar(2),
    mo_age_death numeric(3),
    mo_cause_death varchar(2),
    cou_age_death numeric(3),
    cou_cause_death varchar(2),
    remark varchar(100),
    use_motorcycle varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_values (
    plan_code varchar(5) not null,
    pol_val_vers varchar(2) not null,
    sex_code varchar(1) not null,
    eff_age numeric(3) not null,
    eff_dur numeric(3) not null,
    unit_basis varchar(1) not null,
    endow_rt numeric(10,3) not null,
    cv_rt_before numeric(13,6) not null,
    cv_rt_aftr numeric(13,6) not null,
    pv_rt_before numeric(13,6) not null,
    pv_rt_aftr numeric(13,6) not null,
    crcy_code varchar(2) default '*' not null,
    prem_prd numeric(3) default -1 not null,
    band_low numeric(13,2) default -1 not null,
    band_high numeric(13,2) default -1 not null,
    eff_mth numeric(2) default 0 not null,
    sec_age numeric(3) default -1 not null,
    bnft_prd numeric(3) default -1 not null
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_values_layout (
    plan_code_pos numeric(3),
    plan_code_len numeric(3),
    pol_val_vers_pos numeric(3),
    pol_val_vers_len numeric(3),
    sex_code_pos numeric(3),
    sex_code_len numeric(3),
    eff_age_pos numeric(3),
    eff_age_len numeric(3),
    eff_dur_pos numeric(3),
    eff_dur_len numeric(3),
    unit_basis_pos numeric(3),
    unit_basis_len numeric(3),
    endow_rt_pos numeric(3),
    endow_rt_len numeric(3),
    cv_rt_before_pos numeric(3),
    cv_rt_before_len numeric(3),
    cv_rt_aftr_pos numeric(3),
    cv_rt_aftr_len numeric(3),
    pv_rt_before_pos numeric(3),
    pv_rt_before_len numeric(3),
    pv_rt_aftr_pos numeric(3),
    pv_rt_aftr_len numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_values_load (
    plan_code varchar(5),
    pol_val_vers varchar(2),
    sex_code varchar(1),
    eff_age numeric(3),
    eff_dur numeric(3),
    unit_basis varchar(1),
    endow_rt numeric(10,3),
    cv_rt_before numeric(10,3),
    cv_rt_aftr numeric(10,3),
    pv_rt_before numeric(10,3),
    pv_rt_aftr numeric(10,3)
);

CREATE TABLE IF NOT EXISTS cas.tpolicy_values_wrk (
    plan_code varchar(5) not null,
    pol_val_vers varchar(2) not null,
    sex_code varchar(1) not null,
    eff_age numeric(3) not null,
    eff_dur numeric(3) not null,
    unit_basis varchar(1) not null,
    endow_rt numeric(7,3) not null,
    cv_rt_before numeric(7,3) not null,
    cv_rt_aftr numeric(7,3) not null,
    pv_rt_before numeric(7,3) not null,
    pv_rt_aftr numeric(7,3) not null
);

CREATE TABLE IF NOT EXISTS cas.tpoliss_doi (
    fr_date timestamp,
    to_date timestamp,
    code varchar(50),
    br_code varchar(5),
    faceamt_base numeric(13,2),
    faceamt_rider numeric(13,2),
    prem_base numeric(13,2),
    prem_rider numeric(13,2),
    fst_comm numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tpol_annuity_history_th (
    pol_num varchar(10),
    pay_yr numeric(3),
    pay_dt timestamp,
    payo_amt numeric(14,2)
);

CREATE TABLE IF NOT EXISTS cas.tpol_credit_card_tw (
    pol_num varchar(10) not null,
    credit_card_owner varchar(30),
    credit_card_no varchar(19) not null,
    credit_card_yymm varchar(6) not null,
    credit_card_bank_cd varchar(3) not null
);

CREATE TABLE IF NOT EXISTS cas.tpol_histories (
    pol_num varchar(10) not null,
    dept_code varchar(3) not null,
    seq_num varchar(10) not null,
    trxn_dt timestamp not null,
    trxn_code varchar(5) not null,
    rmrk varchar(1000),
    process_ind varchar(1),
    user_id varchar(30),
    copy_ind varchar(1),
    trxn_seq numeric(4),
    rec_stat varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpol_hist_code (
    dept_code varchar(3) not null,
    trxn_code varchar(5) not null,
    class_code varchar(1) not null,
    dicid_flag varchar(1),
    trxn_code_desc varchar(100),
    allow_status varchar(75)
);

CREATE TABLE IF NOT EXISTS cas.tpol_hist_comm (
    pol_num varchar(10) not null,
    trxn_code varchar(5) not null,
    trxn_dt timestamp not null,
    seq_num varchar(10) not null,
    dept_code varchar(3) not null,
    trxn_id varchar(10) not null,
    comm_dt timestamp not null,
    comm_user varchar(4000),
    comm_rmrk varchar(1000),
    userid varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.tpol_hist_dicid (
    pol_num varchar(10) not null,
    dept_code varchar(3) not null,
    seq_num varchar(10) not null,
    trxn_dt timestamp not null,
    trxn_code varchar(5) not null,
    dicid_seq_num varchar(10) not null,
    dicid_dt timestamp,
    plan varchar(10),
    dicid_rmrk varchar(1000),
    dicid_id varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.tpol_hist_pending (
    pol_num varchar(10) not null,
    dept_code varchar(3) not null,
    seq_num varchar(10) not null,
    trxn_dt timestamp not null,
    trxn_code varchar(5) not null,
    pend_reasn_code varchar(10) not null,
    cmplt_dt timestamp,
    cmplt_comnt varchar(1000),
    exc_day numeric,
    exc_date timestamp,
    drop_date timestamp,
    pend_rmrk varchar(1000),
    pend_seq numeric(4),
    pend_seq_num varchar(10) not null,
    pend_ind varchar(1),
    answer_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tpol_invnty_ctl (
    pol_num varchar(10) not null,
    crcy_code varchar(2) not null,
    pmt_susp_bal numeric(13,2) not null,
    pol_susp_bal numeric(13,2) not null,
    pol_loan_bal numeric(13,2) not null,
    acum_div_bal numeric(13,2) not null,
    csh_cpn_bal numeric(13,2) not null,
    apl_loan_bal numeric(13,2) default 0 not null,
    pol_svg_bal numeric(13,2) default 0 not null
);

CREATE TABLE IF NOT EXISTS cas.tpol_overloan_neg_surr (
    pol_num varchar(10) not null,
    last_avy_dt timestamp,
    loan_actv_dt timestamp,
    nfo_dt timestamp,
    loan_val numeric(13,2),
    loan_int numeric(13,2),
    surr_valu numeric(13,2),
    run_dt timestamp not null
);

CREATE TABLE IF NOT EXISTS cas.tpol_pmt_hist_sg (
    crcy_code varchar(2) not null,
    pol_num varchar(10),
    batch_ref varchar(5),
    trxn_num numeric(8) not null,
    pmt_typ varchar(30),
    payo_mthd varchar(20),
    pmt_stat_cd varchar(20),
    crt_ind varchar(2),
    pmt_flag varchar(1),
    pmt_cycle varchar(10),
    fin_cycle varchar(10),
    pol_typ varchar(1),
    pol_pdln varchar(1),
    created_by varchar(6),
    date_created timestamp,
    amended_by varchar(6),
    date_amended timestamp
);

CREATE TABLE IF NOT EXISTS cas.tpol_pmt_items_hist_sg (
    crcy_code varchar(2) not null,
    trxn_num numeric(8) not null,
    item_num numeric(2) not null,
    item_cd varchar(4) not null,
    item_desc varchar(30),
    int_dt timestamp,
    plan_num numeric(2),
    plan_code varchar(6),
    plan_name varchar(40),
    cvg_eff_dt timestamp,
    fnd_code varchar(4),
    fnd_name varchar(40),
    pmt_ind varchar(1),
    crt_ind varchar(2),
    pmt_stat_cd varchar(20),
    instl_opt varchar(20),
    item_amt numeric(11,2),
    amt_pd numeric(11,2),
    comm_ind varchar(1),
    payo_opt varchar(100),
    prt_ind varchar(1),
    created_by varchar(6),
    date_created timestamp,
    amended_by varchar(6),
    date_amended timestamp
);

CREATE TABLE IF NOT EXISTS cas.tpol_pua_tot_hist_sg (
    pol_num varchar(10),
    asof_dt timestamp,
    pua_acru_tot numeric(13,2),
    pua_1yr_tot numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tpol_reinstate (
    pol_num varchar(10),
    pol_reiss_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tpol_replacement_case_th (
    repl_num numeric(10) not null,
    case_num numeric(10) not null,
    restr_pol_num varchar(10) not null,
    business_typ varchar(3) not null,
    restr_stat_cd varchar(1) not null,
    restr_amt numeric(11,2),
    restr_comm_amt numeric(11,2),
    restr_trxn_id varchar(15) not null,
    release_trxn_id varchar(15),
    created_by varchar(30) not null,
    date_created timestamp not null,
    amended_by varchar(30),
    date_amended timestamp
);

CREATE TABLE IF NOT EXISTS cas.tpol_replacement_crr_th (
    case_num numeric(10) not null,
    crr_num_restr numeric(15) not null,
    crr_num_release numeric(15),
    repl_num numeric(10) not null,
    created_by varchar(30) not null,
    date_created timestamp not null,
    amended_by varchar(30),
    date_amended timestamp
);

CREATE TABLE IF NOT EXISTS cas.tpol_replacement_exempt_th (
    causing_pol_co_cd varchar(3) not null,
    causing_pol_num varchar(20) not null,
    repl_reasn_code varchar(3) not null,
    restr_pol_num varchar(10) not null,
    business_typ varchar(3) not null,
    exempt_stat_cd varchar(1) not null,
    created_by varchar(30) not null,
    date_created timestamp not null,
    amended_by varchar(30),
    date_amended timestamp
);

CREATE TABLE IF NOT EXISTS cas.tpol_replacement_sg_bak (
    causing_pol_co_cd varchar(2) not null,
    causing_pol_crcy_code varchar(2) not null,
    causing_pol_num varchar(20) not null,
    pmt_mode varchar(2),
    mode_prem numeric(11,2),
    repl_start_dt timestamp not null,
    repl_end_dt timestamp,
    repl_reasn_code varchar(3) not null,
    repl_stat_cd varchar(1) not null,
    causing_agt_code varchar(6),
    insured_id_typ varchar(1) not null,
    insured_id_num varchar(20) not null,
    insured_nm varchar(60) not null,
    payer_id_typ varchar(1),
    payer_id_num varchar(20),
    payer_nm varchar(60),
    causing_anp numeric(10,2),
    causing_afyc numeric(10,2),
    restr_pol_crcy_code varchar(2) not null,
    restr_pol_num varchar(10) not null,
    last_scan_dt timestamp,
    created_by varchar(30),
    date_created timestamp,
    amended_by varchar(30),
    date_amended timestamp
);

CREATE TABLE IF NOT EXISTS cas.tpol_replacement_th (
    repl_num numeric(10) not null,
    causing_pol_co_cd varchar(3) not null,
    causing_pol_num varchar(20) not null,
    pmt_mode varchar(2),
    dscnt_prem numeric(11,2),
    repl_start_dt timestamp not null,
    repl_end_dt timestamp not null,
    repl_reasn_code varchar(3) not null,
    repl_stat_cd varchar(1) not null,
    causing_agt_code varchar(6),
    insured_cli_num varchar(13),
    amt_to_restr numeric(11,2),
    outs_amt_to_restr numeric(11,2),
    last_scan_dt timestamp,
    created_by varchar(30) not null,
    date_created timestamp not null,
    amended_by varchar(30),
    date_amended timestamp
);

CREATE TABLE IF NOT EXISTS cas.tpol_replace_sg (
    ins_id_num varchar(20),
    ins_name varchar(60),
    disc_agt_name varchar(40),
    disc_pol_num varchar(10),
    disc_plan_desc varchar(50),
    disc_mode_desc varchar(20),
    disc_mode_prem numeric(11,2),
    disc_status varchar(50),
    disc_trmn_date timestamp,
    disc_pd_to_dt timestamp,
    rep_agt_name varchar(40),
    rep_pol_num varchar(10),
    rep_plan_desc varchar(50),
    rep_mode_desc varchar(20),
    rep_mode_prem numeric(11,2),
    rep_status varchar(50),
    rep_iss_date timestamp,
    rep_eff_dt timestamp,
    disc_dt timestamp,
    repl_dt timestamp,
    disc_wa1_nm varchar(40),
    disc_wa1_reln varchar(1),
    disc_wa2_nm varchar(40),
    disc_wa2_reln varchar(1),
    repl_wa1_nm varchar(40),
    repl_wa1_reln varchar(1),
    repl_wa2_nm varchar(40),
    repl_wa2_reln varchar(1),
    disc_recurr_bill_ind varchar(1),
    disc_owner_nm varchar(60),
    disc_owner_addr1 varchar(60),
    disc_owner_addr2 varchar(60),
    disc_owner_addr3 varchar(60),
    disc_owner_addr4 varchar(60),
    disc_owner_zip varchar(6),
    disc_br_nm varchar(40),
    repl_recurr_bill_ind varchar(1),
    repl_owner_nm varchar(60),
    repl_owner_addr1 varchar(60),
    repl_owner_addr2 varchar(60),
    repl_owner_addr3 varchar(60),
    repl_owner_addr4 varchar(60),
    repl_owner_zip varchar(6),
    repl_br_nm varchar(40)
);

CREATE TABLE IF NOT EXISTS cas.tpol_replace_sg_bak (
    ins_id_num varchar(20),
    ins_name varchar(60),
    disc_agt_name varchar(40),
    disc_pol_num varchar(10),
    disc_plan_desc varchar(50),
    disc_mode_desc varchar(20),
    disc_mode_prem numeric(11,2),
    disc_status varchar(50),
    disc_trmn_date timestamp,
    disc_pd_to_dt timestamp,
    rep_agt_name varchar(40),
    rep_pol_num varchar(10),
    rep_plan_desc varchar(50),
    rep_mode_desc varchar(20),
    rep_mode_prem numeric(11,2),
    rep_status varchar(50),
    rep_iss_date timestamp,
    rep_eff_dt timestamp,
    disc_dt timestamp,
    repl_dt timestamp,
    disc_wa1_nm varchar(40),
    disc_wa1_reln varchar(1),
    disc_wa2_nm varchar(40),
    disc_wa2_reln varchar(1),
    repl_wa1_nm varchar(40),
    repl_wa1_reln varchar(1),
    repl_wa2_nm varchar(40),
    repl_wa2_reln varchar(1),
    disc_recurr_bill_ind varchar(1),
    disc_owner_nm varchar(60),
    disc_owner_addr1 varchar(60),
    disc_owner_addr2 varchar(60),
    disc_owner_addr3 varchar(60),
    disc_owner_addr4 varchar(60),
    disc_owner_zip varchar(6),
    disc_br_nm varchar(40),
    repl_recurr_bill_ind varchar(1),
    repl_owner_nm varchar(60),
    repl_owner_addr1 varchar(60),
    repl_owner_addr2 varchar(60),
    repl_owner_addr3 varchar(60),
    repl_owner_addr4 varchar(60),
    repl_owner_zip varchar(6),
    repl_br_nm varchar(40)
);

CREATE TABLE IF NOT EXISTS cas.tpol_srv_agt_hist_sg (
    crcy_code varchar(2) not null,
    pol_num varchar(10) not null,
    agt_seq_num numeric(2) not null,
    agt_id_typ varchar(1) not null,
    agt_id_num varchar(13) not null,
    agt_nm varchar(32),
    agt_num varchar(6),
    eff_fr_ptd timestamp,
    eff_fr_prod_cycle varchar(10),
    um_id_typ varchar(1),
    um_id_num varchar(13),
    um_nm varchar(32),
    am_id_typ varchar(1),
    am_id_num varchar(13),
    am_nm varchar(32),
    da_id_typ varchar(1),
    da_id_num varchar(13),
    da_nm varchar(32),
    region varchar(30),
    dist_chnl varchar(30),
    comm_pct numeric(5,2),
    created_by varchar(6),
    date_created timestamp,
    amended_by varchar(6),
    date_amended timestamp
);

CREATE TABLE IF NOT EXISTS cas.tpol_stats_01 (
    pol_num varchar(10) not null,
    plan_code_base varchar(5),
    pol_iss_dt timestamp,
    sbmt_dt timestamp not null,
    pd_to_dt timestamp not null,
    last_pd_to_dt timestamp not null,
    pmt_desc varchar(9),
    pmt_mode varchar(5) not null,
    dscnt_prem numeric(11,2) not null,
    trmn_year numeric,
    trmn_mth varchar(3),
    trmn_qtr varchar(2),
    iss_year numeric,
    iss_mth varchar(3),
    iss_qtr varchar(2),
    eff_year numeric,
    eff_mth varchar(3),
    eff_qtr varchar(2),
    iss_tat numeric,
    pol_eff_dt timestamp not null,
    pol_trmn_dt timestamp,
    agt_code varchar(6),
    group_type varchar(9),
    cpf_type varchar(9),
    mkt_plan_nm varchar(50) not null,
    prem_typ varchar(9),
    prod_cat varchar(11),
    pol_stat varchar(150) not null,
    agt_nm varchar(40) not null,
    unit_cd varchar(5) not null,
    distribution varchar(10),
    unit varchar(40) not null,
    branch_cd varchar(5) not null,
    branch varchar(40) not null,
    plan_type varchar(29),
    std_ind varchar(12),
    med_ind varchar(11),
    rating_ind varchar(18),
    sbmt_yr numeric,
    sbmt_qtr varchar(9),
    sbmt_mth varchar(9),
    cli_nm varchar(60) not null,
    birth_dt timestamp,
    sex_code varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpol_surrenders_sg (
    asof_dt timestamp,
    pol_num varchar(10),
    br_code varchar(5),
    agt_code varchar(40),
    pol_eff_dt timestamp,
    insrd_nm varchar(60),
    plan_desc varchar(50),
    face_amt numeric(13,2),
    surr_dt timestamp,
    net_cash_valu numeric(13,2),
    avail_unit_bal numeric(13,2),
    last_unit_bid numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tpol_undo_histories (
    pol_num varchar(10) not null,
    trxn_dt timestamp not null,
    trxn_id varchar(15) not null,
    dest_trxn_id varchar(15) not null
);

CREATE TABLE IF NOT EXISTS cas.tpol_ur_histories (
    pol_num varchar(20) not null,
    trxn_dt timestamp not null,
    undo_fr_trxn_id varchar(30) not null,
    undo_to_trxn_id varchar(30) not null,
    undo_trxn_trxn_id varchar(30) not null,
    redo_fr_trxn_id varchar(30),
    redo_to_trxn_id varchar(30),
    reason varchar(60)
);

CREATE TABLE IF NOT EXISTS cas.tpost_code_th (
    province_cd numeric(4) not null,
    post_code varchar(10) not null,
    stat_cd varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tppfala302 (
    trxn_id varchar(15) not null,
    trxn_dt timestamp not null,
    pol_num varchar(10) not null,
    nd_cur_cn varchar(5),
    type varchar(15),
    xfer_reasn_cd varchar(10),
    eff_dt timestamp,
    new_ptd timestamp,
    rev_amt numeric(13,2),
    payo_typ varchar(10),
    payo_arang varchar(10),
    plan_code varchar(5),
    vers_num varchar(2),
    cli_num varchar(13),
    cvg_eff_dt timestamp,
    layer_eff_dt timestamp,
    acct_no varchar(8),
    amt numeric(13,2),
    reasn_code varchar(30),
    payo_crcy varchar(2),
    payo_ac_num varchar(20),
    payo_ac_hldr_nm varchar(40),
    reject_reasn varchar(5),
    trxn_desc varchar(100),
    payo_pol_num varchar(10),
    loan_typ varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.tppfala302_db_cr (
    trxn_id varchar(15) not null,
    db_or_cr varchar(5) not null,
    acct_mne_cd varchar(8) not null,
    plan_code varchar(5),
    vers_num varchar(2),
    cli_num varchar(13),
    cvg_eff_dt timestamp,
    amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tppfala302_fnd_alloc (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    deal_basis varchar(1),
    deal_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tppfala302_fnd_lst (
    trxn_id varchar(15) not null,
    acct_mne_cd varchar(8) not null,
    amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tppfala302_prem_hist (
    trxn_id varchar(15) not null,
    prem_dt timestamp not null,
    shi_num numeric(4) not null,
    prem_typ varchar(3),
    apply_used numeric(13,2),
    prem_hist_tid varchar(15),
    lien_pct numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.tpqeala204 (
    trxn_id varchar(15) not null,
    trxn_dt timestamp not null,
    pol_num varchar(10) not null,
    asof_dt timestamp,
    nfo_cd varchar(30),
    payo_currency varchar(2),
    payo_typ varchar(30),
    payo_arang varchar(30),
    request_amt numeric(13,2),
    autopay_acct varchar(30),
    autopay_acct_name varchar(30),
    rg_fund varchar(30),
    tot_withdr_amt numeric(13,2),
    tot_withdr_unit numeric(20,10),
    tot_withdr_pct numeric(13,2),
    charge_amt numeric(13,2),
    reasn_code varchar(3),
    trxf_to_pol_1 varchar(10),
    trxf_to_pol_2 varchar(10),
    trxf_to_pol_3 varchar(10),
    trxf_to_pol_4 varchar(10),
    trxf_to_pol_5 varchar(10),
    fund_account varchar(2),
    prem_grp varchar(3),
    surrender_valu numeric(13,2),
    request_dt timestamp,
    stamp_duty numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tpqeala204_fnd (
    trxn_id varchar(15) not null,
    fnd_id varchar(5),
    fnd_vers varchar(6),
    withdrawal_amt numeric(13,2),
    withdrawal_unit numeric(20,10),
    withdrawal_pct numeric(13,2),
    trxn_amount numeric(20,10)
);

CREATE TABLE IF NOT EXISTS cas.tpremium_histories (
    pol_num varchar(10) not null,
    prem_dt timestamp not null,
    shi_num numeric(4) not null,
    prem_typ varchar(3) not null,
    prem_amt numeric(13,2) not null,
    prem_apply numeric(13,2),
    used_ind varchar(1),
    user_id varchar(30) not null,
    apply_used numeric(13,2),
    mpre_pd numeric(11,2),
    net_prem numeric(11,2),
    trxn_id varchar(15),
    crcy_code varchar(2),
    eff_dt timestamp,
    btch_typ varchar(4),
    col_crcy_code varchar(2),
    col_trxn_amt numeric(11,2),
    exchg_rt numeric(18,8),
    report_no numeric(3),
    chq_no_text varchar(20),
    chq_dt timestamp,
    card_xpry_dt varchar(4),
    status varchar(10),
    reject_reasn varchar(5),
    trxn_desc varchar(100),
    lien_pct numeric(5,2),
    dth_bnft_amt numeric(13,2),
    comm_earn numeric(9,2),
    pc_earn numeric(9),
    prem_ded numeric(13,2),
    xtra_prem numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tpremium_holiday (
    pol_num varchar(10) not null,
    fr_dt timestamp not null,
    to_dt timestamp,
    pd_to_dt timestamp,
    last_pd_to_dt timestamp,
    eff_typ varchar(1),
    ph_pd_to_dt timestamp,
    ph_last_pd_to_dt timestamp,
    trxn_dt timestamp,
    trxn_id varchar(15) not null,
    undo_trxn_id varchar(15),
    prem_ind varchar(1),
    autopay_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tprem_app_mappings (
    prem_app_mthd varchar(5) not null,
    cvg_typ varchar(1) not null,
    layer_typ varchar(1) not null,
    cvg_lay_typ varchar(5) not null,
    prem_grp varchar(3) not null
);

CREATE TABLE IF NOT EXISTS cas.tprem_calc_coi_log (
    pol_num varchar(10),
    cli_num varchar(13),
    plan_code varchar(5),
    vers_num varchar(2),
    cvg_eff_dt timestamp,
    layer_eff_dt timestamp,
    layer_dur numeric(3),
    amt_value numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tprem_calc_cvg_log (
    pol_num varchar(10),
    cli_num varchar(10),
    plan_code varchar(5),
    vers_num varchar(2),
    cvg_eff_dt timestamp,
    cvg_stat_cd varchar(1),
    cvg_eff_age numeric(3),
    cvg_prem numeric(11,2),
    dscnt_prem numeric(11,2),
    nyr_cvg_prem numeric(11,2),
    nyr_dscnt_prem numeric(11,2),
    nxt_eff_cvg_prem numeric(11,2),
    nxt_eff_dscnt_prem numeric(11,2),
    temp_flat_prem numeric(11,2),
    perm_flat_prem numeric(11,2),
    c_cvg_eff_age numeric(3),
    c_cvg_prem numeric(11,2),
    c_dscnt_prem numeric(11,2),
    c_nyr_cvg_prem numeric(11,2),
    c_nyr_dscnt_prem numeric(11,2),
    c_nxt_eff_cvg_prem numeric(11,2),
    c_nxt_eff_dscnt_prem numeric(11,2),
    c_temp_flat_prem numeric(11,2),
    c_perm_flat_prem numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tprem_calc_pol_log (
    pol_num varchar(10),
    pol_stat_cd varchar(1),
    frez_code varchar(1),
    pd_to_dt timestamp,
    apl_ext_days numeric(3),
    mode_prem numeric(11,2),
    dscnt_prem numeric(11,2),
    nyr_mode_prem numeric(11,2),
    nyr_dscnt_prem numeric(11,2),
    nxt_eff_mode_prem numeric(11,2),
    nxt_eff_dscnt_prem numeric(11,2),
    c_mode_prem numeric(11,2),
    c_dscnt_prem numeric(11,2),
    c_nyr_mode_prem numeric(11,2),
    c_nyr_dscnt_prem numeric(11,2),
    c_nxt_eff_mode_prem numeric(11,2),
    c_nxt_eff_dscnt_prem numeric(11,2),
    return_code numeric(2),
    return_msg varchar(20),
    diff_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tprem_over_pol (
    pol_num varchar(10),
    plan_code varchar(5),
    cvg_stat_cd varchar(1),
    dscnt_prem numeric(11,2),
    b_dscnt_prem numeric(11,2),
    cvg_prem numeric(11,2),
    nyr_cvg_prem numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tprem_ovrid_schedules (
    pol_num varchar(10) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cli_num varchar(10) not null,
    cvg_eff_dt timestamp not null,
    layer_eff_dt timestamp not null,
    eff_fr_dt timestamp not null,
    eff_to_dt timestamp not null,
    pmt_mode varchar(5) not null,
    layer_prem numeric(13,2) not null,
    layer_dscnt_prem numeric(13,2) not null,
    ann_layer_prem numeric(13,2) not null,
    ann_layer_dscnt_prem numeric(13,2) not null
);

CREATE TABLE IF NOT EXISTS cas.tprem_stmnt_img_sg (
    fcn_id varchar(20),
    fcn_vers varchar(2),
    pol_num varchar(10),
    sa_cd_1 varchar(6),
    sa_cd_2 varchar(6),
    ca_cd_1 varchar(6),
    ca_cd_2 varchar(6),
    wa_cd_1 varchar(6),
    wa_cd_2 varchar(6),
    ins_cli_num varchar(10),
    own_cli_num varchar(10),
    payor_cli_num varchar(10),
    cas_dt timestamp,
    dept varchar(10),
    gen_dt timestamp,
    path varchar(50),
    fil_nm varchar(50),
    version varchar(5),
    file_status varchar(2),
    request_id numeric(10),
    seq_num numeric not null,
    carton_num varchar(15)
);

CREATE TABLE IF NOT EXISTS cas.tprem_test_schedules (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    fr_dur numeric(3),
    to_dur numeric(3),
    layer_typ varchar(1) not null,
    test_ind varchar(1),
    lvl_grd numeric(1),
    prem_test varchar(2),
    mvy_ded_ind varchar(1),
    proc_seq numeric(3) not null,
    mvy_offset numeric(3),
    test_base varchar(1),
    mvy_edit_typ varchar(2),
    mvy_seq_edit varchar(50),
    exp_mvy_seq varchar(50),
    extra_proc varchar(50),
    catchup_typ numeric,
    prem_base varchar(50),
    fr_eff_dt timestamp,
    to_eff_dt timestamp,
    rec_status varchar(1) not null,
    extra_proc_desc varchar(100),
    crcy_code varchar(2) default '05' not null
);

CREATE TABLE IF NOT EXISTS cas.tpreviousl_assigned_ors (
    id numeric(10) not null,
    user_nm varchar(10) not null,
    beg_or_num numeric(10) not null,
    end_or_num numeric(10) not null,
    coll_dt timestamp not null,
    created_by varchar(10) not null,
    date_created timestamp not null,
    date_modified timestamp,
    modified_by varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tprint_controls (
    request_id numeric(10) not null,
    fcn_id varchar(20) not null,
    report_desc varchar(50) not null,
    user_id varchar(30) not null,
    request_date timestamp not null,
    pol_num varchar(10),
    last_printed timestamp
);

CREATE TABLE IF NOT EXISTS cas.tprint_distn_sg (
    fcn_id varchar(20),
    distn_cde varchar(5),
    output_opt varchar(2),
    email_opt varchar(2),
    email_addr varchar(1500),
    fil_nm_opt varchar(2),
    rec_status varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tprocessed_trad_pol (
    pol_num varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tprocessed_uvl_pol (
    pol_num varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tprodn_period (
    prodn_yr numeric,
    prodn_mth numeric,
    prodn_qtr numeric,
    period_st_dt timestamp,
    period_ed_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tproducts (
    prod_code varchar(5) not null,
    prod_shrt_nm varchar(50),
    last_vers_num varchar(30),
    face_amt_label varchar(40),
    adj_prem_label varchar(40),
    top_up_prem_label varchar(40),
    top_up_dur_label varchar(40),
    par_code varchar(1),
    ins_typ varchar(1),
    cv_avail_ind varchar(1),
    cvg_typ varchar(1),
    endow_ctl varchar(1),
    fmly_cvg_ind varchar(1),
    prem_age_basis varchar(1),
    prem_by_sex varchar(1),
    prem_by_clas varchar(1),
    prem_by_smkr varchar(1),
    prem_by_occp varchar(1),
    sex_excl varchar(1),
    crcy_code varchar(2),
    sales_lvl numeric,
    prem_by_bpp varchar(1),
    sngl_plan_ind varchar(1),
    cmp_active_ind varchar(1),
    nb_active_ind varchar(1),
    is_life varchar(1) not null,
    is_accident varchar(1) not null,
    is_health varchar(1) not null,
    is_traditional varchar(1) not null,
    is_universal varchar(1) not null,
    is_unit_link varchar(1) not null,
    is_term varchar(1) not null,
    is_endowment varchar(1) not null,
    is_whole_life varchar(1) not null,
    is_annuity varchar(1) not null,
    is_new_annuity varchar(1) not null,
    is_juvenile varchar(1) not null,
    long_or_short varchar(1) not null,
    is_income_protector varchar(1) not null,
    is_dread_desease varchar(1) not null,
    is_hospital varchar(1) not null,
    is_inpatient varchar(1) not null,
    is_bank varchar(1) not null,
    is_wp varchar(1) not null,
    is_pb varchar(1) not null,
    eff_age_low numeric(3),
    eff_age_high numeric(3),
    prem_by_fa varchar(1) not null,
    prem_by_cvg_clas varchar(1) not null,
    prem_by_prem varchar(1) not null,
    pmt_mo_avail varchar(1) not null,
    pmt_qtr_avail varchar(1) not null,
    pmt_semi_avail varchar(1) not null,
    pmt_ann_avail varchar(1) not null,
    sell_ind varchar(1) not null,
    eff_days_low numeric(3) not null,
    is_package_rider varchar(1),
    input_fund_alloc varchar(1),
    input_fund_wthdr varchar(1),
    input_fund_topup varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tprovince_th (
    region_cd varchar(5) not null,
    province_th varchar(100) not null,
    province_eng varchar(100),
    seq_num numeric(4) not null,
    stat_cd varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tprovision_pages (
    plan_code_base varchar(5),
    vers_num_base varchar(2),
    page_typ varchar(5),
    jdt_nm varchar(20),
    form_nm varchar(20),
    page_desc varchar(60),
    seq_num numeric(2),
    start_page_no numeric(2),
    display_cat varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tpt_tclient_details (
    quota_num varchar(50) not null,
    cli_num varchar(40) not null,
    cli_nm varchar(101) not null,
    id_num varchar(30),
    sex_code varchar(1) not null,
    birth_dt timestamp not null,
    smkr_code varchar(1),
    occp_code varchar(10),
    id_typ varchar(1),
    terr_cd varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tpt_tclient_policy_links (
    quota_num varchar(50) not null,
    pol_num varchar(50) not null,
    cli_num varchar(23) not null,
    link_typ varchar(1) not null,
    rec_status varchar(1),
    rel_to_insrd varchar(4000),
    addr_typ numeric,
    bank_acct_typ numeric,
    xcpt_addr_typ numeric,
    payo_bank_acct_typ numeric
);

CREATE TABLE IF NOT EXISTS cas.tpt_tcoverages (
    quota_num varchar(50) not null,
    pol_num varchar(50) not null,
    plan_code varchar(5) not null,
    cvg_typ varchar(1) not null,
    dth_bnft_amt numeric(13,2) not null,
    cvg_reasn varchar(1) not null,
    ins_typ varchar(1) not null,
    face_ratg numeric(5,2) not null,
    temp_flat_unit_prem numeric(10,3) default 0 not null,
    perm_flat_unit_prem numeric(10,3) default 0 not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    face_amt numeric(13,2) not null,
    cvg_stat_cd varchar(1) not null,
    cvg_del_dt timestamp,
    dscnt_prem numeric(11,2) not null,
    lien_pct numeric(5,2),
    cvg_clas varchar(3) not null,
    par_code varchar(1) not null,
    cntr_price numeric(13,2),
    cli_num varchar(13) not null,
    cvg_prem numeric(11,2) not null,
    cvg_eff_age numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.tpt_tpolicys (
    quota_num varchar(50) not null,
    pol_num varchar(50) not null,
    pol_eff_dt timestamp not null,
    pol_iss_dt timestamp,
    pol_stat_cd varchar(1) not null,
    sbmt_dt timestamp not null,
    agt_code varchar(6),
    pol_rmrk varchar(100),
    pol_trmn_dt timestamp,
    crcy_code varchar(2) not null,
    uwg_clas varchar(30),
    medic_code varchar(10),
    pmt_mode varchar(5) not null,
    dscnt_prem numeric(11,2),
    mode_prem numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tqry_msg_mappings (
    msg_id varchar(5) not null,
    fcn_id varchar(20) not null,
    msg_condition varchar(100),
    display_ind varchar(1) default 'Y' not null
);

CREATE TABLE IF NOT EXISTS cas.tquery_registers (
    pol_num varchar(10) not null,
    user_id varchar(30) not null,
    trxn_dt timestamp not null,
    qre_num numeric(4) not null,
    trxn_cd varchar(8) not null,
    query_desc varchar(100) not null,
    eff_dt timestamp,
    rec_status varchar(1),
    reasn_code varchar(3) not null,
    query_typ varchar(5) not null,
    fnd_id varchar(5),
    fnd_trxn_cd varchar(3),
    fnd_vers varchar(6),
    trxn_id varchar(15)
);

CREATE TABLE IF NOT EXISTS cas.tquota_basechg_check (
    plan_code varchar(5) not null,
    vers_num varchar(25) not null,
    pln_to_chg_ind varchar(1) not null,
    pln_be_chg_ind varchar(1) not null,
    vers_chg_ind varchar(1) not null,
    sngl_prem_ind varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tquota_basechg_fortune (
    plan_code_from varchar(5) not null,
    plan_code_to varchar(5) not null
);

CREATE TABLE IF NOT EXISTS cas.tquota_basechg_plan_check (
    plan_code_from varchar(5) not null,
    plan_code_to varchar(5) not null,
    not_allow_chg_ind varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tquota_client_details (
    quota_num varchar(6) not null,
    trxn_dt timestamp,
    cli_num varchar(13) not null,
    terr_cd varchar(2) not null,
    state_cd varchar(2) not null,
    cli_nm varchar(60) not null,
    smkr_code varchar(1) not null,
    addr_typ numeric(2),
    birth_dt timestamp,
    fax_num varchar(20),
    id_num varchar(20),
    othr_phon_num varchar(20),
    prim_phon_num varchar(20),
    cli_rmrk varchar(500),
    sex_code varchar(1),
    cli_cnsldt_ind varchar(1),
    id_typ varchar(1),
    occp_code varchar(10),
    offce_addr_typ numeric(2),
    bill_addr_typ numeric(2),
    reg_addr_typ numeric(2),
    soldier_ind varchar(1) not null,
    res_addr_typ numeric(2),
    email_add varchar(40),
    hp_num varchar(20),
    cli_title varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.tquota_client_policy_links (
    quota_num varchar(6) not null,
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    link_typ varchar(1) not null,
    rec_status varchar(1) not null,
    rel_to_insrd varchar(2),
    addr_typ numeric(2),
    bank_acct_typ numeric(2),
    xcpt_addr_typ numeric(2),
    payo_bank_acct_typ numeric(2),
    res_addr_typ numeric(2)
);

CREATE TABLE IF NOT EXISTS cas.tquota_coverages (
    quota_num varchar(6) not null,
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    cvg_typ varchar(1) not null,
    cvg_reasn varchar(1) not null,
    occp_clas varchar(1),
    par_code varchar(1),
    bnft_dur numeric(3),
    prem_dur numeric(3),
    pua_tot_amt numeric(13,2),
    rel_to_insrd varchar(2) not null,
    smkr_code varchar(1),
    sex_code varchar(1),
    cvg_prem numeric(11,2),
    cvg_stat_cd varchar(1) not null,
    comm_ctl varchar(1),
    comm_vers varchar(2),
    cvg_clas varchar(3) not null,
    dscnt_pct numeric(5,2),
    dscnt_prem numeric(11,2),
    dth_bnft_amt numeric(13,2),
    face_amt numeric(13,2) not null,
    band_face_amt numeric(13,2),
    face_ratg numeric(5,2),
    ins_typ varchar(1),
    cvg_eff_age numeric(3) not null,
    cvg_iss_dt timestamp,
    xpry_dt timestamp,
    nyr_cvg_prem numeric(11,2),
    nyr_dscnt_prem numeric(11,2),
    pua_crnt_amt numeric(13,2),
    prem_vers varchar(2),
    pol_val_vers varchar(2),
    prem_ovrid_end_date timestamp,
    div_crnt_amt numeric(11,2),
    joint_cli_num varchar(13),
    joint_rel_insrd varchar(2),
    temp_flat_dur numeric(3),
    temp_flat_unit_prem numeric(10,3),
    temp_flat_prem numeric(11,2),
    perm_flat_unit_prem numeric(10,3),
    perm_flat_prem numeric(11,2),
    temp_mort_dur numeric(3),
    temp_mort_unit_prem numeric(10,3),
    temp_mort_prem numeric(11,2),
    perm_mort_unit_prem numeric(10,3),
    perm_mort_prem numeric(11,2),
    eti_endow numeric(13,2) not null,
    xtra_cat_cd varchar(1),
    perm_mort_ratg numeric(5),
    temp_mort_ratg numeric(5),
    cvg_del_dt timestamp,
    adj_prem numeric(11,2),
    adj_start_dt timestamp,
    adj_end_dt timestamp,
    nxt_eff_cvg_prem numeric(11,2),
    nxt_eff_dscnt_prem numeric(11,2),
    ctr_prem numeric(11,2),
    nxt_eff_ctr_prem numeric(11,2),
    prev_dth_bnft_amt numeric(13,2),
    risk_prem numeric(11,2),
    init_chg_ind varchar(1),
    adj_prem_pct numeric(3),
    int_rt numeric(5,3),
    nyr_wp_prem numeric(11,2),
    wp_eff_age numeric(3),
    wp_eff_dt timestamp,
    wp_option varchar(1),
    wp_prem numeric(11,2),
    wp_prem_age_basis varchar(1),
    wp_prem_vers varchar(2),
    orig_face_amt numeric(13,2),
    orig_death_bnft numeric(13,2),
    orig_pua_amt numeric(13,2),
    joint_cli_eff_age numeric(3),
    substd_cd varchar(3),
    cntr_price numeric(13,2),
    joint_cli_smkr_code varchar(1),
    joint_cli_sex_code varchar(1),
    cvg_del_reasn varchar(1),
    endow_acru numeric(13,2),
    nb_seq numeric(5),
    no_of_insrd numeric(2),
    rcc_ind varchar(1),
    face_ratg_start_dt timestamp,
    face_ratg_end_dt timestamp,
    lien_pct numeric(5,2),
    pkg_plan_code varchar(5),
    nc_face_ratg numeric(5,2),
    nc_temp_flat_unit_prem numeric(10,3),
    nc_perm_flat_unit_prem numeric(10,3),
    nc_prem numeric(13,2),
    nyr_nc_prem numeric(13,2),
    wp_nc_prem numeric(13,2),
    eff_age_ovrid varchar(1),
    wp_plan_code varchar(5),
    wp_vers_num varchar(2),
    face_ratg_prem numeric(11,2),
    perm_prem_ovrid_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tquota_coverage_layers (
    quota_num varchar(6) not null,
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    layer_eff_dt timestamp not null,
    stat_cd varchar(1),
    layer_prem numeric(11,2),
    layer_dscnt_prem numeric(11,2),
    mpre numeric(11,2),
    old_face_amt numeric(13,2),
    new_face_amt numeric(13,2),
    old_cvg_clas varchar(3),
    new_cvg_clas varchar(3),
    wp_fa numeric(11,2),
    wp_prem numeric(11,2),
    wp_mpre numeric(11,2),
    cvg_lay_typ varchar(5) not null,
    old_prem_vers varchar(2),
    new_prem_vers varchar(2),
    occp_clas varchar(1),
    bnft_dur numeric(3),
    prem_dur numeric(3),
    pua_tot_amt numeric(13,2),
    smkr_code varchar(1),
    dth_bnft_amt numeric(13,2),
    band_face_amt numeric(13,2),
    face_ratg numeric(5,2),
    layer_eff_age numeric(3),
    nyr_layer_prem numeric(11,2),
    nyr_layer_dscnt_prem numeric(11,2),
    pua_crnt_amt numeric(13,2),
    div_crnt_amt numeric(11,2),
    temp_flat_dur numeric(3),
    temp_flat_unit_prem numeric(10,3),
    temp_flat_prem numeric(11,2),
    perm_flat_unit_prem numeric(10,3),
    perm_flat_prem numeric(11,2),
    temp_mort_dur numeric(3),
    temp_mort_unit_prem numeric(10,3),
    temp_mort_prem numeric(11,2),
    perm_mort_unit_prem numeric(10,3),
    perm_mort_prem numeric(11,2),
    eti_endow numeric(13,2),
    xtra_cat_cd varchar(1),
    perm_mort_ratg numeric(5),
    temp_mort_ratg numeric(5),
    adj_prem numeric(11,2),
    adj_start_dt timestamp,
    adj_end_dt timestamp,
    nxt_eff_cvg_prem numeric(11,2),
    nxt_eff_dscnt_prem numeric(11,2),
    risk_prem numeric(11,2),
    prev_dth_bnft_amt numeric(13,2),
    endow_acru numeric(13,2),
    adj_prem_pct numeric(3),
    nyr_wp_prem numeric(11,2),
    wp_eff_age numeric(3),
    wp_eff_dt timestamp,
    joint_cli_eff_age numeric(3),
    substd_cd varchar(3),
    excl_code1 varchar(5),
    excl_code2 varchar(5),
    excl_code3 varchar(5),
    excl_end_dt timestamp,
    excl_clause varchar(200),
    xfer_rider varchar(1),
    cvg_del_reasn varchar(1),
    layer_typ varchar(1),
    face_ratg_start_dt timestamp,
    face_ratg_end_dt timestamp,
    lien_pct numeric(5,2),
    nc_face_ratg numeric(5,2),
    nc_temp_flat_unit_prem numeric(10,3),
    nc_perm_flat_unit_prem numeric(10,3),
    nc_prem numeric(13,2),
    nyr_nc_prem numeric(13,2),
    wp_nc_prem numeric(13,2),
    face_ratg_prem numeric(11,2),
    temp_flat_ratg numeric(5,2),
    perm_flat_ratg numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.tquota_details (
    pol_num varchar(10) not null,
    quota_num varchar(6) not null,
    action_cd varchar(10) not null,
    seq_num varchar(10) not null,
    prt_seq numeric(3),
    plan_code varchar(5),
    vers_num varchar(2),
    cli_num varchar(13),
    cvg_eff_dt timestamp,
    cvg_typ varchar(1),
    cvg_reasn varchar(1),
    is_new_rider varchar(1),
    is_del_rider varchar(1),
    is_upd_rider varchar(1),
    is_pol_chg varchar(1),
    is_new_cli varchar(1),
    is_base_chg varchar(1),
    face_amt numeric(11,2),
    new_face_amt numeric(11,2),
    cvg_clas varchar(3),
    new_cvg_clas varchar(3),
    occp_clas varchar(1),
    new_occp_clas varchar(1),
    cvg_dscnt_prem numeric(11,2),
    new_cvg_dscnt_prem numeric(11,2),
    bill_mthd varchar(2),
    new_bill_mthd varchar(2),
    pmt_mode varchar(5),
    new_pmt_mode varchar(5),
    mode_prem numeric(11,2),
    new_mode_prem numeric(11,2),
    dscnt_prem numeric(11,2),
    new_dscnt_prem numeric(11,2),
    pol_trmn_dt timestamp,
    reinstat_prem numeric(11,2),
    orig_plan_code varchar(5),
    orig_vers_num varchar(2),
    orig_cvg_eff_dt timestamp,
    arrear_payment numeric(11,2),
    arrear_refund numeric(11,2),
    arrear_wp_prem numeric(11,2),
    cvg_cv_chg_amt numeric(11,2),
    cv_cvg numeric(11,2),
    orig_cv_cvg numeric(11,2),
    risk_prem numeric(11,2),
    cvg_prem numeric(11,2),
    new_cvg_prem numeric(11,2),
    pv_cvg numeric(11,2),
    orig_pv_cvg numeric(11,2),
    loan_amt numeric(11,2),
    apply_dt timestamp,
    chg_eff_dt timestamp,
    fran_num varchar(4),
    new_fran_num varchar(4),
    chg_fee numeric(11,2),
    new_no_of_insrd numeric(2),
    no_of_insrd numeric(2)
);

CREATE TABLE IF NOT EXISTS cas.tquota_details_debug (
    pol_num varchar(10),
    quota_num varchar(6),
    action_cd varchar(10),
    seq_num varchar(10),
    apply_dt timestamp,
    chg_eff_dt timestamp,
    prt_seq numeric(3),
    plan_code varchar(5),
    vers_num varchar(2),
    cli_num varchar(13),
    cvg_eff_dt timestamp,
    cvg_typ varchar(1),
    cvg_reasn varchar(1),
    is_new_rider varchar(1),
    is_del_rider varchar(1),
    is_upd_rider varchar(1),
    is_pol_chg varchar(1),
    is_new_cli varchar(1),
    is_base_chg varchar(1),
    face_amt numeric(11,2),
    new_face_amt numeric(11,2),
    cvg_clas varchar(3),
    new_cvg_clas varchar(3),
    occp_clas varchar(1),
    new_occp_clas varchar(1),
    cvg_dscnt_prem numeric(11,2),
    new_cvg_dscnt_prem numeric(11,2),
    bill_mthd varchar(2),
    new_bill_mthd varchar(2),
    pmt_mode varchar(5),
    new_pmt_mode varchar(5),
    mode_prem numeric(11,2),
    new_mode_prem numeric(11,2),
    dscnt_prem numeric(11,2),
    new_dscnt_prem numeric(11,2),
    pol_trmn_dt timestamp,
    reinstat_prem numeric(11,2),
    orig_plan_code varchar(5),
    orig_vers_num varchar(2),
    orig_cvg_eff_dt timestamp,
    arrear_payment numeric(9),
    arrear_refund numeric(9),
    arrear_wp_prem numeric(11,2),
    cvg_cv_chg_amt numeric(11,2),
    risk_prem numeric(11,2),
    fran_num varchar(4),
    new_fran_num varchar(4),
    cvg_prem numeric(11,2),
    new_cvg_prem numeric(11,2),
    cv_cvg numeric(11,2),
    orig_cv_cvg numeric(11,2),
    pv_cvg numeric(11,2),
    orig_pv_cvg numeric(11,2),
    loan_amt numeric(11,2),
    no_of_insrd numeric(2),
    new_no_of_insrd numeric(2),
    chg_fee numeric(11,2),
    rcc_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tquota_forms (
    form_code varchar(5) not null,
    form_name varchar(80) not null
);

CREATE TABLE IF NOT EXISTS cas.tquota_form_req (
    quota_num varchar(6) not null,
    pol_num varchar(10) not null,
    form_code varchar(5) not null
);

CREATE TABLE IF NOT EXISTS cas.tquota_form_req_rules (
    action_cd varchar(10) not null,
    form_code varchar(5) not null,
    invalid_ind varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.tquota_layers (
    quota_num varchar(6) not null,
    pol_num varchar(10) not null,
    layer_eff_dt timestamp not null,
    layer_typ varchar(1),
    layer_stat_cd varchar(1),
    mpre numeric(11,2),
    xces_prem numeric(11,2),
    layer_trmn_dt timestamp,
    tot_prem_pd numeric(11,2),
    mpre_pd numeric(11,2),
    last_ryc_dt timestamp,
    mpre_rc_ind varchar(1),
    layer_prem_amt numeric(11,2),
    hwm_ann numeric(11,2),
    hwm_ann_xpry_dt timestamp,
    pd_to_dt timestamp,
    partial_pay_amt numeric(11,2),
    layer_prem_pct numeric(5,2),
    surr_chrg_pd numeric(13,2),
    asof_tot_prem_pd numeric(11,2),
    orig_mpre numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.tquota_order (
    quota_action_cd varchar(10) not null,
    action_desc varchar(40),
    quota_order numeric(2) not null,
    terr_action_desc varchar(80),
    chng_eff_dt_ctl varchar(20),
    dda_eff_dt_ctl varchar(20),
    defn_str varchar(60),
    wp_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tquota_policys (
    quota_num varchar(6) not null,
    apply_dt timestamp,
    trxn_dt timestamp,
    new_pd_to_dt timestamp,
    orig_dscnt_prem numeric(11,2),
    reinstat_prem numeric(11,2),
    pol_num varchar(10) not null,
    mode_prem numeric(11,2) not null,
    ovr_loan_ind varchar(1) not null,
    frez_code varchar(1) not null,
    ipo_ind varchar(1) not null,
    vp_ind varchar(1) not null,
    reins_ind varchar(1) not null,
    bill_mthd varchar(1) not null,
    crcy_code varchar(2) not null,
    last_avy_dt timestamp not null,
    last_pd_to_dt timestamp not null,
    pd_to_dt timestamp not null,
    pol_eff_dt timestamp not null,
    pol_iss_dt timestamp,
    pol_reiss_dt timestamp,
    cnfrm_acpt_dt timestamp,
    pol_rlse_dt timestamp,
    sbmt_dt timestamp not null,
    pol_stat_cd varchar(1) not null,
    state_cd varchar(2) not null,
    pol_trmn_dt timestamp,
    div_opt varchar(1) not null,
    terr_cd varchar(2) not null,
    dscnt_prem numeric(11,2) not null,
    pol_susp numeric(13,2) not null,
    pmt_susp numeric(11,2) not null,
    ipo_last_refu_yr numeric(4),
    pmt_mode varchar(5) not null,
    bill_prem numeric(11,2) not null,
    bill_to_dt timestamp not null,
    pac_loan_repy numeric(11,2),
    pac_bk_ctr varchar(1),
    pac_eff_dt timestamp,
    medic_code varchar(10),
    medic_dt timestamp,
    incmplt_cd varchar(2),
    pend_cd varchar(2),
    subj_to_cd varchar(2),
    uwg_clas varchar(30),
    fran_num varchar(4),
    agt_code varchar(6),
    nfo_opt varchar(1) not null,
    nfo_eff_dt timestamp,
    zap_ind varchar(1),
    aea_ind varchar(1) not null,
    lnb_ind varchar(1) not null,
    hiv_ind varchar(1) not null,
    pol_rmrk varchar(500),
    apl_laps_dt timestamp,
    pc_typ varchar(10),
    pc_recv_dt timestamp,
    pc_pend_reasn varchar(10),
    pc_efft_date timestamp,
    apl_ext_days numeric(3),
    nyr_mode_prem numeric(11,2) not null,
    nyr_dscnt_prem numeric(11,2) not null,
    renw_yr numeric(3) not null,
    run_num numeric(2),
    pol_app_dt timestamp,
    tlia_code_1 varchar(10),
    tlia_code_2 varchar(10),
    tlia_code_3 varchar(10),
    disab_clas varchar(3),
    restr_case_cnt_ind varchar(1) not null,
    comm_wthld_dt timestamp,
    nb_user_id varchar(30) not null,
    last_actv_dt timestamp,
    joint_cli_dth_ind varchar(1) not null,
    comprop_prem numeric(11,2),
    resv_dnr_amt numeric(13,2),
    xcpt_bill_cd varchar(1),
    nb_pc_pol_tot numeric(9),
    cnfrm_prt_dt timestamp,
    os_anty_susp numeric(13,2),
    payo_mthd varchar(1),
    anty_stat_cd varchar(1),
    nxt_eff_mode_prem numeric(11,2),
    nxt_eff_dscnt_prem numeric(11,2),
    nxt_eff_prem_dt timestamp,
    ctr_prem numeric(11,2),
    nxt_eff_ctr_prem numeric(11,2),
    lump_sum_ind varchar(1),
    lump_sum_pmt_amt numeric(11,2),
    proc_fee_ind varchar(1),
    dist_chnl_cd varchar(2),
    tot_prem_appy numeric(15,2),
    prefix_cd varchar(3),
    oth_rqmts_text varchar(60),
    mort_cd varchar(6),
    chg_insrd_opt varchar(1),
    convrt_fr_pol varchar(10),
    apl_lapse_ind varchar(1),
    div_upto_dt timestamp,
    endow_ctl varchar(1),
    sa_cd_2 varchar(6),
    wa_cd_1 varchar(6),
    wa_cd_2 varchar(6),
    vp_point timestamp,
    override_bill_day numeric(2),
    plan_code_base varchar(5),
    vers_num_base varchar(5),
    is_free_look varchar(1),
    bnh_code varchar(5),
    corridor_pct numeric(3),
    curr_debit_day numeric(2),
    db_opt varchar(1),
    disable_dt timestamp,
    dth_susp numeric(13,2),
    fnd_switch_ctr numeric(3),
    fnd_wthdr_ctr numeric(3),
    iio_opt varchar(1),
    iio_pct numeric(3),
    insrd_mort varchar(4),
    ins_typ_base varchar(1),
    lst_fnd_valn_dt timestamp,
    mvy_ded_to_dt timestamp,
    nb_update_date timestamp,
    no_lapse_gurt_ind varchar(1),
    nxt_debit_day numeric(2),
    nxt_pac_eff_dt timestamp,
    nxt_rebal_date timestamp,
    occ_cd varchar(6),
    open_flag varchar(5),
    pickup_debit_day numeric(2),
    pickup_eff_dt timestamp,
    plan_prem numeric(11,2),
    pol_clm_dt timestamp,
    pric_rsrv_dt timestamp,
    rebal_ind varchar(1),
    recurr_bill_ind varchar(1),
    recurr_bill_st_dt timestamp,
    reins_cd varchar(3),
    reins_mthd varchar(1),
    restrict_cd_1 varchar(5),
    restrict_cd_2 varchar(5),
    restrict_cd_3 varchar(5),
    special_clas varchar(2),
    wrk_area varchar(4),
    non_lapse_ind varchar(1),
    lro_eff_dt timestamp,
    bbr_flag varchar(1),
    ph_ind varchar(1),
    ph_strt_dt timestamp,
    ph_end_dt timestamp,
    ph_eff_typ varchar(1),
    ph_pd_to_dt timestamp,
    ph_last_pd_to_dt timestamp,
    ph_autopay_ind varchar(1),
    anty_wthdr numeric(13,2),
    anty_dur numeric(2),
    anty_freq numeric(2),
    anty_int_rt numeric(7,5),
    anty_opt varchar(2),
    anty_payo_amt numeric(13,2),
    anty_start_dt timestamp,
    loan_ovr_int_rt numeric(7,5),
    conv_dt timestamp,
    pdf_strt_dt timestamp,
    pdf_end_dt timestamp,
    instl_strt_dt timestamp,
    instl_end_dt timestamp,
    instl_amt numeric(13,2),
    edw_loan varchar(1),
    loyal_bns_ind varchar(1),
    bank_fee_ind varchar(1),
    anty_payo_base numeric(11,2),
    anty_payo_rt numeric(12,6),
    anty_crtn_dur numeric(2),
    waive_end_dt timestamp,
    anty_ref_dt timestamp,
    anty_end_dt timestamp,
    gurt_bnft numeric(13,2),
    gurt_amt numeric(13,2),
    life_incm numeric(13,2),
    rmn_gurt_amt numeric(13,2),
    rmn_life_incm numeric(13,2),
    nxt_payo_dt timestamp,
    last_fnd_avy_dt timestamp,
    anty_min_payo_amt numeric(13,2),
    ins_birth_dt timestamp,
    last_tcomm_calc_dt timestamp,
    set_eff_dt timestamp,
    set_last_avy_dt timestamp,
    set_stat_cd varchar(1),
    loyal_bns_opt varchar(1),
    last_lbns_decla_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.trasal201_d (
    user_id varchar(10) not null,
    timestamp varchar(16) not null,
    id_num varchar(20),
    cli_nm varchar(20),
    birth_dt timestamp,
    sex_code varchar(10),
    cli_num varchar(13),
    pol_num varchar(10),
    link_typ varchar(10),
    plan_code varchar(10),
    pol_stat_cd varchar(10),
    uwg_clas varchar(20),
    pol_eff_dt timestamp,
    trmn_dt timestamp,
    life_rsk_amt numeric(18,2),
    accd_rsk_amt numeric(18,2),
    br_code varchar(5),
    srch_id varchar(16)
);

CREATE TABLE IF NOT EXISTS cas.trasal201_h (
    user_id varchar(10) not null,
    timestamp varchar(16) not null,
    caller_typ varchar(10),
    id_num varchar(20),
    cli_nm varchar(20),
    birth_dt timestamp,
    sex_code varchar(10),
    excl_pol_num varchar(10),
    srch_id varchar(16),
    dtl_xist varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tratefile_field_values (
    table_name varchar(40) not null,
    column_name varchar(40) not null,
    default_value varchar(12) not null
);

CREATE TABLE IF NOT EXISTS cas.trcc_bill_histories (
    run_dt timestamp,
    bill_mthd varchar(1),
    fran_num varchar(4),
    pol_num varchar(10),
    pol_crcy_code varchar(2),
    pd_to_dt timestamp,
    prem_amt numeric(11,2),
    pmt_susp numeric(11,2),
    bill_amt numeric(11,2),
    sa_cd_1 varchar(6),
    sa_cd_2 varchar(6),
    client_nm varchar(80),
    card_num varchar(20),
    card_typ varchar(1),
    card_iss_bank varchar(13),
    card_holder_id_typ varchar(1),
    card_holder_id_num varchar(20),
    card_holder_name varchar(60),
    card_xpry_dt timestamp,
    trxn_dt timestamp,
    bank_process_dt timestamp,
    download_dt timestamp,
    cc_fee_ind varchar(1),
    cc_fee_amt numeric(11,4),
    cwa_susp numeric(13,2),
    card_cat varchar(1),
    pol_iss_dt timestamp,
    rcc_type varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.trcpt_hdrs (
    off_rcpt_num numeric(10) not null,
    coll_dt timestamp not null,
    ref_num_text varchar(10) not null,
    bill_to_dt timestamp,
    pmt_mode_text varchar(15),
    crncy_cd varchar(2) default '14' not null,
    off_rcpt_amt numeric(12,2),
    remarks varchar(60),
    pr_num numeric(10),
    pr_dt timestamp,
    payor_nm varchar(60),
    mail_addr varchar(260),
    pymnt_typ varchar(2) default '10' not null,
    canc_dt timestamp,
    canc_by_nm varchar(10),
    agt_code varchar(5),
    agt_nm varchar(60),
    br_nm varchar(40),
    agt_loc_code varchar(10),
    agt_unit_code varchar(5),
    der_cd varchar(2),
    incl_der_ind varchar(1) default 'N' not null,
    deposit_dt timestamp,
    dist_chnl_cd varchar(2) default 'AG' not null,
    col_bank_alias varchar(6),
    adv_comm_amt numeric(12,2),
    created_by varchar(10) not null,
    created_dt timestamp not null,
    off_loc_cd varchar(5),
    fran_num varchar(4)
);

CREATE TABLE IF NOT EXISTS cas.trcpt_dtls (
    pal_id numeric(10) not null,
    coa_cd varchar(8) not null,
    alloc_amt numeric(12,2) not null,
    bank_cd_alias varchar(6),
    clr_cd varchar(2),
    che_num_text numeric(25),
    che_dt timestamp,
    off_rcpt_num numeric(10) not null
);

CREATE TABLE IF NOT EXISTS cas.treasn_code_mappings (
    reasn_code varchar(3) not null,
    cas_reasn_code varchar(3) not null
);

CREATE TABLE IF NOT EXISTS cas.treasn_code_turn_max_th (
    reasn_code varchar(10),
    team_id varchar(2),
    turnaround_max_day numeric
);

CREATE TABLE IF NOT EXISTS cas.treins_client_details (
    seq_no numeric not null,
    result varchar(500)
);

CREATE TABLE IF NOT EXISTS cas.treins_cvg_code_mappings (
    plan_code varchar(5) not null,
    cov_code varchar(3),
    cov_group varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.treins_feed_claims (
    seq_no numeric,
    result varchar(500)
);

CREATE TABLE IF NOT EXISTS cas.treins_feed_clients (
    seq_no numeric,
    result varchar(500)
);

CREATE TABLE IF NOT EXISTS cas.treins_feed_details (
    seq_no numeric,
    result varchar(500)
);

CREATE TABLE IF NOT EXISTS cas.treins_feed_details_ul (
    pol_num varchar(10),
    seq_no numeric,
    result varchar(500)
);

CREATE TABLE IF NOT EXISTS cas.treins_feed_log (
    cas_dt timestamp,
    pol_num varchar(10),
    plan_code varchar(5),
    vers_num varchar(2),
    remarks varchar(100)
);

CREATE TABLE IF NOT EXISTS cas.treins_field_value_mappings (
    fld_nm varchar(15),
    fr_fld_value varchar(2),
    to_fld_value varchar(2),
    fld_desc varchar(30),
    to_fld_value_desc varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.treins_nfo_vals (
    cas_date timestamp not null,
    pol_num varchar(10) not null,
    cli_num varchar(10) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    acru_pua_tot numeric(15,2) not null,
    cv_pua_last numeric(15,2) not null,
    cv_pua_next numeric(15,2) not null,
    cv_face_amt_last numeric(15,2) not null,
    cv_face_amt_next numeric(15,2) not null
);

CREATE TABLE IF NOT EXISTS cas.treport_activity_days_sg (
    plan_code varchar(5) not null,
    actv_typ varchar(30) not null,
    actv_day varchar(20) not null,
    ref_rule varchar(1),
    report_id varchar(20),
    ref_prd varchar(2),
    ref_date varchar(30),
    cvg_typ varchar(1),
    actv_day_typ varchar(1),
    actv_seq numeric(2)
);

CREATE TABLE IF NOT EXISTS cas.treport_schedules (
    pol_num varchar(10),
    cli_num varchar(13),
    cvg_eff_dt timestamp,
    plan_code varchar(5),
    vers_num varchar(2),
    actv_date timestamp,
    report_id varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.treport_schedules_bk (
    pol_num varchar(10),
    cli_num varchar(10),
    cvg_eff_dt timestamp,
    plan_code varchar(5),
    vers_num varchar(2),
    actv_date timestamp,
    report_id varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.trep_cntrl (
    fcn_id varchar(20) not null,
    step_nm varchar(20) not null,
    step_num numeric(10) not null,
    step_valu varchar(20) not null,
    step_end_valu varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.trequest_parm (
    request_id numeric(10) not null,
    parm_nme varchar(20) not null,
    parm_valu varchar(150)
);

CREATE TABLE IF NOT EXISTS cas.trider_del_dt (
    pol_num varchar(10),
    plan_code varchar(5),
    cvg_del_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.trider_issue_dt (
    pol_num varchar(10),
    plan_code varchar(5),
    cvg_iss_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.troc_conv_sg (
    link_num numeric(5),
    causing_pol_co_cd varchar(2),
    causing_pol_crcy_code varchar(2),
    causing_pol_num varchar(20),
    repl_start_dt timestamp,
    repl_end_dt timestamp,
    repl_reasn_code varchar(3),
    repl_stat_cd varchar(1),
    restr_pol_crcy_code varchar(2),
    restr_pol_num varchar(10),
    last_scan_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.troc_dtls_sg (
    link_num numeric(5),
    restr_pol_num varchar(10),
    cli_num varchar(13),
    plan_code varchar(5),
    vers_num varchar(2),
    cvg_eff_dt timestamp,
    layer_eff_dt timestamp,
    cvg_lay_typ varchar(5),
    layer_typ varchar(1),
    conv_status varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.trole_objects_sg (
    role_id varchar(30) not null,
    fcn_id varchar(20) not null,
    obj_id varchar(80) not null,
    obj_type varchar(18) not null
);

CREATE TABLE IF NOT EXISTS cas.trpt_for_transfer (
    server_rpt_path varchar(200),
    user_id varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.trst_int_calc (
    pol_num varchar(10),
    pol_eff_dt timestamp,
    pol_lapse_dt timestamp,
    reinstat_dt timestamp,
    pmt_mode numeric,
    no_of_prem_due numeric,
    int_rate numeric(13,2),
    no_of_yrs numeric,
    inst_dt timestamp,
    nxt_avy_dt timestamp,
    nxt_avy_dt_on_b4 timestamp,
    no_of_days numeric,
    inst_no numeric,
    cum_int numeric(13,2),
    cum_pr numeric(13,2),
    prem numeric(13,2),
    int numeric(13,2),
    pd_to_dt timestamp,
    bill_to_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.trxn_histories (
    pol_num varchar(10) not null,
    tranno numeric(5),
    validflag varchar(1),
    trxn_amt numeric(13,2),
    trxn_code varchar(4),
    sign varchar(1),
    code varchar(4)
);

CREATE TABLE IF NOT EXISTS cas.ts1_user_ext (
    user_id varchar(30) not null,
    srvc_ctr varchar(6),
    srvc_ctr_acc varchar(6),
    usr_crt varchar(30),
    date_crt timestamp,
    usr_amd varchar(30),
    date_amd timestamp
);

CREATE TABLE IF NOT EXISTS cas.tsa_inc_options (
    pol_num varchar(10) not null,
    eff_dur numeric(3) not null,
    sio_ind varchar(2),
    sio_pct numeric(5,2),
    chg_allw_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tschedules (
    sch_dt timestamp not null,
    run_num varchar(6),
    clndr_dt timestamp,
    mth_ind varchar(1),
    yr_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tsequences (
    seq_nm varchar(30) not null,
    reset_freq varchar(1) not null,
    script_nm varchar(60),
    status_cd varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.tset_anty_rates (
    plan_grp_nm varchar(20) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    crcy_code varchar(2) not null,
    eff_dt timestamp not null,
    eff_age numeric(3) not null,
    sex_code varchar(2) not null,
    anty_dur numeric(3) not null,
    anty_crtn_dur numeric(2) not null,
    anty_freq numeric(2) not null,
    anty_rt numeric(12,6) not null
);

CREATE TABLE IF NOT EXISTS cas.tset_opt_ctl (
    set_opt varchar(5) not null,
    set_min_valu numeric(13,2),
    anty_opt varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tsftp_th (
    sftp_code varchar(30) not null,
    app_cd varchar(10) not null,
    sftp_type varchar(10) default 'DB2APP' not null,
    sftp_db_full_path varchar(100),
    sftp_app_full_path varchar(100),
    daily_job varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tsms_fld_value_th (
    dept varchar(3) not null,
    sms_item_typ varchar(3) not null,
    fld_nm varchar(30) not null,
    fld_valu varchar(10) not null
);

CREATE TABLE IF NOT EXISTS cas.tsms_txt_th (
    dept varchar(3) not null,
    sms_item_typ varchar(3) not null,
    phone_to varchar(10) not null,
    txt_sms varchar(400) not null,
    job_typ varchar(1) not null,
    sms_item_desc varchar(100),
    active_stat varchar(5),
    account varchar(50),
    category varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.tsos_card (
    seq_num numeric(10) not null,
    pol_num varchar(10) not null,
    team_num varchar(2) not null,
    no_of_insrd numeric(2) not null,
    prt_reasn_cd varchar(2) not null,
    trxn_dt timestamp not null
);

CREATE TABLE IF NOT EXISTS cas.tsos_plans (
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    dlft_insrd numeric,
    crcy_code varchar(2) default '*' not null
);

CREATE TABLE IF NOT EXISTS cas.tsun_ac_sg (
    cas_ac varchar(10),
    pallm_ac varchar(10),
    sun_ac varchar(10),
    t1 varchar(10),
    t2 varchar(10),
    t3 varchar(10),
    t4us varchar(10),
    t4s varchar(10),
    acct_desc varchar(50),
    fund_id varchar(2),
    prod_cat varchar(1),
    t5 varchar(10),
    legal_id varchar(10),
    cond_ind varchar(2),
    t2us varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.tsurrender_values (
    pol_num varchar(10) not null,
    trxn_dt timestamp not null,
    surr_pv_amt numeric(18,8)
);

CREATE TABLE IF NOT EXISTS cas.tsuspense_histories (
    shi_num numeric(4) not null,
    pol_num varchar(10) not null,
    reasn_code varchar(3) not null,
    acct_mne_cd varchar(8) not null,
    susp_dt timestamp not null,
    trxn_cd varchar(8) not null,
    susp_amt numeric(13,2) not null,
    crcy_code varchar(2) not null,
    trxn_id varchar(15),
    undo_trxn_id varchar(15)
);

CREATE TABLE IF NOT EXISTS cas.tsusp_recon_sg (
    pol_num varchar(10) not null,
    trxn_dt timestamp,
    aex_num numeric(8),
    trxn_cd varchar(8),
    acct_mne_cd varchar(8),
    cr_or_dr varchar(1),
    acct_gen_amt numeric(13,2),
    reasn_code varchar(3),
    eff_dt timestamp,
    crcy_code varchar(2),
    acct_num varchar(8),
    shi_num numeric(4),
    susp_reasn_code varchar(3),
    susp_acct_mne_cd varchar(8),
    susp_dt timestamp,
    susp_trxn_cd varchar(8),
    susp_amt numeric(13,2),
    susp_crcy_code varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.tterminal_bonus_rates (
    plan_code varchar(5) not null,
    pol_val_vers varchar(2) not null,
    sex_code varchar(1) not null,
    eff_age numeric(3) not null,
    eff_dur numeric(3) not null,
    tb_typ varchar(1) not null,
    tb_rt numeric(13,6) not null,
    unit_basis varchar(1) not null,
    crcy_code varchar(2) default '*' not null,
    tb_base varchar(4),
    acct_link_typ varchar(10),
    prem_high numeric(13,2) default -1 not null,
    prem_prd numeric(3) default -1 not null,
    bnft_prd numeric(3) default -1 not null,
    tbr_num varchar(2) default '1' not null,
    band_low numeric(13,2) default -1 not null,
    band_high numeric(13,2) default -1 not null,
    prem_low numeric(13,2) default -1 not null
);

CREATE TABLE IF NOT EXISTS cas.tterminal_bonus_rates_load (
    plan_code varchar(5),
    pol_val_vers varchar(2),
    sex_code varchar(1),
    eff_age numeric(3),
    eff_dur numeric(3),
    tb_typ varchar(1),
    tb_rt numeric(7,3),
    unit_basis varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.ttermination_details (
    pol_num varchar(10) not null,
    trmn_endow_int numeric(9,2) not null,
    trmn_endow_bal numeric(11,2) not null,
    trmn_acum_bal numeric(11,2) not null,
    trmn_acum_int numeric(9,2) not null,
    trmn_pmt_susp numeric(11,2) not null,
    trmn_bnft_pua numeric(13,2) not null,
    trmn_loan_bal numeric(11,2) not null,
    trmn_loan_int numeric(9,2) not null,
    trmn_pol_susp numeric(11,2) not null,
    trmn_bnft_cvg numeric(13,2) not null,
    trmn_payo_amt numeric(13,2) not null,
    trmn_rfnd_amt numeric(13,2) not null,
    trmn_lsp_int numeric(9,2),
    trmn_lsp_bal numeric(11,2),
    payo_ind varchar(1),
    tb_amt numeric(13,2),
    trmn_fund_bal numeric(11,2),
    trmn_prem_grp varchar(3),
    trmn_loan_bal_apl numeric(13,2),
    trmn_loan_int_apl numeric(13,2),
    trmn_svg_bal numeric(13,2) default 0 not null,
    trmn_svg_int numeric(13,2) default 0 not null,
    trmn_csa_bal numeric(11,2) default 0,
    trmn_csa_int numeric(9,2) default 0
);

CREATE TABLE IF NOT EXISTS cas.tterm_lap (
    pol_num varchar(10) not null,
    trmn_endow_int numeric(9,2) not null,
    trmn_endow_bal numeric(11,2) not null,
    trmn_acum_bal numeric(11,2) not null,
    trmn_acum_int numeric(9,2) not null,
    trmn_pmt_susp numeric(11,2) not null,
    trmn_bnft_pua numeric(13,2) not null,
    trmn_loan_bal numeric(11,2) not null,
    trmn_loan_int numeric(9,2) not null,
    trmn_pol_susp numeric(11,2) not null,
    trmn_bnft_cvg numeric(13,2) not null,
    trmn_payo_amt numeric(13,2) not null,
    trmn_rfnd_amt numeric(13,2) not null,
    trmn_lsp_int numeric(9,2),
    trmn_lsp_bal numeric(11,2),
    payo_ind varchar(1),
    tb_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tterm_prem_rates (
    trm_prm_typ varchar(10) not null,
    sex_code varchar(1) not null,
    eff_age numeric(3) not null,
    eff_dur numeric(3) not null,
    unit_basis char(1) not null,
    trm_prm_rt numeric(13,5) not null
);

CREATE TABLE IF NOT EXISTS cas.ttlia_tw (
    company varchar(40) not null,
    id varchar(20),
    clasify varchar(5),
    name varchar(40),
    dob timestamp,
    proc_dt timestamp,
    amount numeric(10),
    record varchar(20),
    reason varchar(20),
    reason_2 varchar(20),
    reason_3 varchar(20),
    code varchar(5),
    proc_time varchar(12),
    tlia_typ varchar(1) not null,
    tlia_num numeric(5) not null
);

CREATE TABLE IF NOT EXISTS cas.ttmp_alpha_search_client (
    session_code varchar(15) not null,
    cli_num varchar(40) not null,
    cli_nm varchar(101),
    id_num varchar(30),
    sex_code varchar(1) not null,
    birth_dt timestamp not null,
    smkr_code varchar(1),
    occp_code varchar(10),
    last_update timestamp DEFAULT CURRENT_TIMESTAMP,
    quota_num varchar(50),
    link_typ varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.ttmp_alpha_search_pb (
    session_code varchar(25) not null,
    comp_cd varchar(50) not null,
    pol_num varchar(50) not null,
    cli_nm varchar(255) not null,
    sex_code varchar(1) not null,
    birth_dt timestamp not null,
    ref_pol_num varchar(50),
    pb_amt numeric(13,2) not null,
    last_update timestamp DEFAULT CURRENT_TIMESTAMP,
    pb_chg_amt numeric(13,2),
    ins_risk_typ varchar(10),
    cli_sess_cd varchar(25),
    risk_amt_typ varchar(20),
    cli_num varchar(20),
    quota_num varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.ttm_company (
    cmpny_cd varchar(5) not null,
    cmpny_name varchar(100) not null,
    eff_start_dt timestamp DEFAULT CURRENT_TIMESTAMP not null,
    eff_end_dt timestamp,
    status varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.ttm_file_to_cas_dtls (
    file_id varchar(10),
    line_no numeric,
    ref_code varchar(20),
    pi_insured_title varchar(20),
    pi_insured_first_name varchar(100),
    pi_insured_last_name varchar(100),
    pi_insured_dob timestamp,
    pi_insured_gender varchar(2),
    pi_insured_occupation varchar(10),
    pi_id_card varchar(20),
    pi_marital_status varchar(5),
    pi_weight numeric,
    pi_high numeric,
    pi_income numeric,
    pi_address1 varchar(255),
    pi_address2 varchar(255),
    pi_address3 varchar(100),
    pi_address_postal_code varchar(10),
    pi_phoneno varchar(20),
    pi_mobileno varchar(20),
    office_address1 varchar(255),
    office_address2 varchar(255),
    office_address3 varchar(100),
    office_address_postal_code varchar(10),
    office_phoneno varchar(20),
    office_mobileno varchar(20),
    contact_address_flag varchar(2),
    sold_plan varchar(15),
    sold_premium numeric,
    sold_benefit_amount numeric,
    sold_billing_mode varchar(2),
    credit_card_account_number varchar(20),
    credit_card_expiry_date varchar(10),
    sold_billing_freq varchar(2),
    bank_code varchar(20),
    bnfy_title_1 varchar(20),
    bnfy_firstname_1 varchar(100),
    bnfy_lastname_1 varchar(100),
    bnfy_age_1 numeric(3),
    bnfy_relation_1 varchar(10),
    bnfy_benefit_1 numeric,
    bnfy_title_2 varchar(20),
    bnfy_firstname_2 varchar(100),
    bnfy_lastname_2 varchar(100),
    bnfy_age_2 numeric(3),
    bnfy_relation_2 varchar(10),
    bnfy_benefit_2 numeric,
    bnfy_title_3 varchar(20),
    bnfy_firstname_3 varchar(100),
    bnfy_lastname_3 varchar(100),
    bnfy_age_3 numeric(3),
    bnfy_relation_3 varchar(10),
    bnfy_benefit_3 numeric,
    bnfy_title_4 varchar(20),
    bnfy_firstname_4 varchar(100),
    bnfy_lastname_4 varchar(100),
    bnfy_age_4 numeric(3),
    bnfy_relation_4 varchar(10),
    bnfy_benefit_4 numeric(2),
    bnfy_title_5 varchar(20),
    bnfy_firstname_5 varchar(100),
    bnfy_lastname_5 varchar(100),
    bnfy_age_5 numeric(3),
    bnfy_relation_5 varchar(10),
    bnfy_benefit_5 numeric(2),
    health_answer_1 varchar(20),
    health_answer_2 varchar(20),
    health_answer_3 varchar(20),
    health_answer_3_detail_1 varchar(255),
    health_answer_3_detail_2 varchar(255),
    health_answer_3_detail_3 varchar(255),
    health_answer_3_detail_4 varchar(255),
    health_answer_4 varchar(20),
    health_answer_5 varchar(20),
    health_answer_5_detail_1 varchar(255),
    health_answer_5_detail_2 varchar(255),
    health_answer_5_detail_3 varchar(255),
    health_answer_5_detail_4 varchar(255),
    tmrcode varchar(10),
    approve_date timestamp,
    ref_policyno varchar(20),
    campaign_code varchar(20),
    mit_agent_code varchar(10),
    remarks varchar(200),
    status varchar(5),
    msg varchar(4000),
    mit_policy_no varchar(20),
    cof_flag varchar(3),
    vedc_pnding numeric default 0,
    trxn_flag varchar(5),
    exclusion_msg1 varchar(80),
    exclusion_msg2 varchar(80),
    uw_user varchar(30),
    ntu_reason varchar(3),
    health_answer_1_detail_1 varchar(255),
    health_answer_1_detail_2 varchar(255),
    health_answer_1_detail_3 varchar(255),
    health_answer_1_detail_4 varchar(255),
    health_answer_1_detail_5 varchar(255),
    health_answer_2_detail_1 varchar(255),
    health_answer_2_detail_2 varchar(255),
    health_answer_2_detail_3 varchar(255),
    health_answer_2_detail_4 varchar(255),
    health_answer_2_detail_5 varchar(255),
    health_answer_3_detail_5 varchar(255),
    health_answer_4_detail_1 varchar(255),
    health_answer_4_detail_2 varchar(255),
    health_answer_4_detail_3 varchar(255),
    health_answer_4_detail_4 varchar(255),
    health_answer_4_detail_5 varchar(255),
    health_answer_5_detail_5 varchar(255),
    health_answer_6 varchar(1),
    health_answer_6_detail_1 varchar(255),
    health_answer_6_detail_2 varchar(255),
    health_answer_6_detail_3 varchar(255),
    health_answer_6_detail_4 varchar(255),
    health_answer_6_detail_5 varchar(255),
    health_answer_7 varchar(1),
    health_answer_7_detail_1 varchar(255),
    health_answer_7_detail_2 varchar(255),
    health_answer_7_detail_3 varchar(255),
    health_answer_7_detail_4 varchar(255),
    health_answer_7_detail_5 varchar(255),
    health_answer_8 varchar(1),
    health_answer_8_detail_1 varchar(255),
    health_answer_8_detail_2 varchar(255),
    health_answer_8_detail_3 varchar(255),
    health_answer_8_detail_4 varchar(255),
    health_answer_8_detail_5 varchar(255),
    health_answer_9 varchar(1),
    health_answer_9_detail_1 varchar(255),
    health_answer_9_detail_2 varchar(255),
    health_answer_9_detail_3 varchar(255),
    health_answer_9_detail_4 varchar(255),
    health_answer_9_detail_5 varchar(255),
    health_answer_10 varchar(1),
    health_answer_10_detail_1 varchar(255),
    health_answer_10_detail_2 varchar(255),
    health_answer_10_detail_3 varchar(255),
    health_answer_10_detail_4 varchar(255),
    health_answer_10_detail_5 varchar(255),
    email varchar(255),
    payer_name_surname varchar(200),
    payer_gender varchar(3),
    payer_age varchar(3),
    payer_dob_date timestamp,
    payer_idcard varchar(20),
    payer_idcard_exp varchar(10),
    payer_home_phone varchar(20),
    payer_office_phone varchar(20),
    payer_mobile_phone varchar(20),
    payer_email varchar(100),
    payer_job varchar(20),
    payer_job_description varchar(100),
    payer_job_position varchar(100),
    payer_income numeric(18),
    payer_relation varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.ttm_file_to_cas_hd (
    cmpny_cd varchar(5) not null,
    file_id varchar(10) not null,
    file_name varchar(500),
    load_dt timestamp,
    total_line numeric,
    hashfileone varchar(200),
    remark varchar(100),
    run_by varchar(20) default USER,
    dist_chnl_cd varchar(2),
    file_type varchar(5),
    lot_id varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.ttm_lead_file_dt (
    lead_id varchar(10) not null,
    line_no numeric not null,
    first_name varchar(100),
    sur_name varchar(100),
    phone1 varchar(50),
    phone2 varchar(50),
    phone3 varchar(50),
    status varchar(5),
    msg varchar(500),
    ref_row varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.ttm_lead_file_hd (
    cmpny_cd varchar(5) not null,
    lead_id varchar(10) not null,
    file_name varchar(100) not null,
    load_dt timestamp not null,
    total_line numeric,
    remark varchar(20),
    hashfileone varchar(200),
    hashfiletwo varchar(200)
);

CREATE TABLE IF NOT EXISTS cas.ttm_packages (
    package_code varchar(10) not null,
    package_nm varchar(60),
    eff_start_dt timestamp,
    eff_end_dt timestamp,
    cmpny_cd varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.ttm_package_plan_mappings (
    package_code varchar(10) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    sex varchar(2) not null,
    payment_mode varchar(2) not null,
    crcy_code varchar(2),
    cvg_typ varchar(1) not null,
    face_amt numeric
);

CREATE TABLE IF NOT EXISTS cas.ttm_user_authorize (
    user_id varchar(30) not null,
    access_tab varchar(50) not null
);

CREATE TABLE IF NOT EXISTS cas.ttm_vedc_file (
    no varchar(4),
    vedc_date timestamp,
    vedc_time varchar(10),
    invoice_no varchar(20),
    product_desc varchar(100),
    card_no varchar(20),
    vpv varchar(10),
    status varchar(10),
    approval_code varchar(10),
    amount numeric,
    lot_id varchar(10),
    process_status varchar(10),
    remark varchar(4000)
);

CREATE TABLE IF NOT EXISTS cas.ttm_voice_file_to_cas_dtls (
    file_id varchar(10) not null,
    seq_no numeric not null,
    file_load_nm varchar(200),
    file_app_nm varchar(200),
    file_dt timestamp,
    voice_typ varchar(10),
    ref_policyno varchar(20),
    mit_policy_no varchar(20),
    active_status varchar(2),
    file_name varchar(100)
);

CREATE TABLE IF NOT EXISTS cas.ttm_voice_file_to_cas_hd (
    cmpny_cd varchar(5) not null,
    lot_file_id varchar(10) not null,
    load_dt timestamp not null,
    total_file numeric,
    user_id_network varchar(20),
    user_id_cas varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.ttot_fnd_values (
    pol_num varchar(10) not null,
    mth numeric(3) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    rec_typ varchar(4) not null,
    tot_fnd_valu numeric(20,10) not null,
    tot_day numeric(10) not null,
    fr_dt timestamp,
    to_dt timestamp,
    stat_cd varchar(1),
    aum_calc_dt timestamp,
    aum_release_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.ttrxn_histories (
    pol_num varchar(10) not null,
    trxn_dt timestamp not null,
    thi_num numeric(4) not null,
    user_id varchar(30) not null,
    trxn_cd varchar(8) not null,
    trxn_desc varchar(200) not null,
    eff_dt timestamp not null,
    reasn_code varchar(3) not null,
    pd_to_dt timestamp,
    trxn_amt numeric(13,2),
    thi_aex_num numeric(4),
    crcy_code varchar(2),
    fcn_id varchar(20),
    orig_trxn_id varchar(15),
    trxn_id varchar(15),
    undo_trxn_id varchar(15),
    redo_rpt_ind varchar(1),
    redo_mod_ind varchar(1),
    sort_seq varchar(15) not null,
    action_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.ttrxn_logs (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    txl_num numeric(5) not null,
    act_mode varchar(6),
    tbl_nm varchar(30),
    prim_key varchar(100),
    col_nm varchar(30),
    old_valu varchar(200),
    new_valu varchar(200)
);

CREATE TABLE IF NOT EXISTS cas.ttrxn_logs_backup (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    txl_num numeric(5) not null,
    act_mode varchar(6),
    tbl_nm varchar(30),
    prim_key varchar(100),
    col_nm varchar(30),
    old_valu varchar(200),
    new_valu varchar(200)
);

CREATE TABLE IF NOT EXISTS cas.ttype_values (
    type_valu varchar(10),
    type_valu_desc varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.tundo_activity_schedules (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    actv_dt timestamp not null,
    asc_num numeric(4) not null,
    actv_reasn varchar(10) not null,
    actv_typ varchar(3) not null,
    proc_dt timestamp,
    actv_seq numeric(2),
    ref_date varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.tundo_disp_trxn_cd (
    trxn_cd varchar(8) not null,
    fcn_id varchar(20),
    disp_trxn_cd varchar(8),
    trxn_desc varchar(30),
    para varchar(50),
    para_valu varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.tundo_mvy_hist_details (
    trxn_id varchar(15) not null,
    pol_num varchar(10) not null,
    mvy_seq numeric(4) not null,
    seq_num numeric(4) not null,
    ded_amt numeric(11,2),
    acct_mne_cd varchar(8),
    plan_code varchar(5),
    vers_num varchar(2),
    cli_num varchar(13),
    chrg_typ varchar(10),
    layer_eff_dt timestamp,
    prem_dur numeric(3),
    chrg_lyr varchar(1),
    chrg_lvl varchar(1),
    chrg_mth numeric(5),
    fnd_id varchar(5),
    fnd_vers varchar(6),
    cvg_eff_dt timestamp,
    bef_dscnt_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.tundo_mvy_hist_headers (
    trxn_id varchar(15) not null,
    pol_num varchar(10) not null,
    mvy_seq numeric(4) not null,
    tot_amt numeric(11,2),
    curr_mvy_dt timestamp,
    ovrdu_dt timestamp,
    lapse_dt timestamp,
    defr_reasn varchar(1) not null,
    layer_eff_dt timestamp not null,
    layer_typ varchar(1) not null,
    test_lvl numeric(1) not null,
    mvy_ded_ind varchar(1) not null,
    lapse_ded_amt numeric(11,2),
    proc_seq numeric(3) not null,
    catchup_end_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.tundo_wrk_activity_schedules (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    actv_dt timestamp not null,
    asc_num numeric(4) not null,
    actv_reasn varchar(10) not null,
    actv_typ varchar(3) not null,
    proc_dt timestamp,
    actv_seq numeric(2),
    ref_date varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.tunits (
    unit_cde varchar(5) not null,
    unit_nm varchar(40),
    unit_stat_cde varchar(1) not null,
    sup_agt_cde varchar(5),
    br_cde varchar(5),
    unit_type varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.tuob_comm_batch_sg (
    record_type varchar(1),
    report_date timestamp,
    file_name varchar(50),
    hash_field_no varchar(2),
    filler varchar(97),
    pol_num varchar(10),
    plan_code varchar(10),
    stat_cd varchar(2),
    submission_date timestamp,
    production_date timestamp,
    pol_maturity_date timestamp,
    plan_underwrite_date timestamp,
    plan_issued_date timestamp,
    plan_maturity_date timestamp,
    plan_cancel_date timestamp,
    product_line varchar(1),
    product_type varchar(1),
    product_class varchar(2),
    plan_type varchar(1),
    product_name varchar(50),
    product_code varchar(10),
    payment_frequency varchar(2),
    prem_amount numeric(10,2),
    annul_prem_amount numeric(12,2),
    due_date timestamp,
    next_due_date timestamp,
    agt_ref_code1 varchar(12),
    agt_name1 varchar(32),
    agt_ref_code2 varchar(12),
    agt_name2 varchar(32),
    agt_ref_code3 varchar(12),
    agt_name3 varchar(32),
    agt_code1_share numeric(5,2),
    agt_code2_share numeric(5,2),
    agt_code3_share numeric(5,2),
    um1_code varchar(12),
    um1_name varchar(32),
    um2_code varchar(12),
    um2_name varchar(32),
    um3_code varchar(12),
    um3_name varchar(32),
    prem_received numeric(10,2),
    prem_received_date timestamp,
    policy_year numeric(1),
    policy_month numeric(2),
    comm_amount numeric(10,2),
    payment_channel varchar(2),
    bank_ac varchar(16),
    owner_nric varchar(12),
    owner_name varchar(32),
    owner_dob varchar(10),
    owner_sex varchar(1),
    owner_marital_stat varchar(1),
    owner_contact_no varchar(20),
    insur_nric varchar(12),
    insur_name varchar(32),
    insur_dob varchar(10),
    insur_sex varchar(1),
    insur_marital_stat varchar(1),
    insur_contact_no varchar(20),
    insur_relation varchar(12),
    nb_ind varchar(1),
    comm_rate numeric(3,2),
    mis_date timestamp,
    agt1_join_date timestamp,
    agt2_join_date timestamp,
    agt3_join_date timestamp,
    comm_hold_stat varchar(1),
    pol_appl_date timestamp,
    referrer_nric varchar(20),
    reference_no varchar(16),
    count numeric(9),
    total_comm numeric(16,2)
);

CREATE TABLE IF NOT EXISTS cas.tuob_coverage_batch_sg (
    record_type varchar(1),
    co_code varchar(2),
    batch_no varchar(8),
    trx_type varchar(2),
    trx_date timestamp,
    date_send timestamp,
    reference_no varchar(16),
    policy_no varchar(10),
    renew_no numeric(2),
    serial_no numeric(2),
    plan_code varchar(10),
    plan_description varchar(50),
    policy_date timestamp,
    maturity_date timestamp,
    sum_assured numeric(12,2),
    tpd_amt numeric(12,2),
    issue_age numeric(2),
    plan_status varchar(2),
    status_eff_date timestamp,
    status_exp_date timestamp,
    status_eff_proddate timestamp,
    prem_stop_date timestamp,
    modal_prem numeric(8,2),
    total_count numeric(6),
    filler varchar(31)
);

CREATE TABLE IF NOT EXISTS cas.tuob_pol_det_batch_sg (
    record_type varchar(1),
    co_code varchar(2),
    batch_no varchar(8),
    trx_type varchar(2),
    trx_date timestamp,
    date_send timestamp,
    first_agt_name varchar(40),
    first_agt_id_type varchar(1),
    first_agt_nric varchar(20),
    first_agt_sharing numeric(5,2),
    first_agt_um_name varchar(40),
    first_agt_um_id_type varchar(1),
    first_agt_um_nric varchar(20),
    first_agt_br_name varchar(6),
    first_agt_br_id_type varchar(1),
    first_agt_br_nric varchar(12),
    second_agt_name varchar(40),
    second_agt_id_type varchar(1),
    second_agt_nric varchar(20),
    second_agt_sharing numeric(5,2),
    second_agt_um_name varchar(40),
    second_agt_um_id_type varchar(1),
    second_agt_um_nric varchar(20),
    second_agt_br_name varchar(6),
    second_agt_br_id_type varchar(1),
    second_agt_br_nric varchar(12),
    third_agt_name varchar(40),
    third_agt_id_type varchar(1),
    third_agt_nric varchar(20),
    third_agt_sharing numeric(5,2),
    third_agt_um_name varchar(40),
    third_agt_um_id_type varchar(1),
    third_agt_um_nric varchar(20),
    third_agt_br_name varchar(6),
    third_agt_br_id_type varchar(1),
    third_agt_br_nric varchar(12),
    appl_no varchar(16),
    pol_num varchar(10),
    basic_plan_com_code varchar(10),
    basic_plan_name varchar(50),
    product_line varchar(1),
    owner_gender varchar(1),
    owner_name varchar(60),
    owner_idtype varchar(1),
    owner_nric varchar(20),
    owner_dob timestamp,
    owner_relationship varchar(12),
    owner_race varchar(1),
    owner_religion varchar(1),
    owner_address1 varchar(60),
    owner_address2 varchar(60),
    owner_address3 varchar(60),
    owner_address4 varchar(60),
    owner_district varchar(10),
    owner_country varchar(2),
    owner_telno varchar(20),
    owner_email varchar(40),
    assured_gender varchar(1),
    assured_name varchar(60),
    assured_id_type varchar(1),
    assured_nric varchar(20),
    assured_dob timestamp,
    assured_race varchar(1),
    assured_religion varchar(1),
    prod_date timestamp,
    effect_date timestamp,
    next_due timestamp,
    submt_date timestamp,
    payment_mode numeric(2),
    modal_prem numeric(12,2),
    annual_prem numeric(12,2),
    extra_modal_prem numeric(12,2),
    extra_annual_prem numeric(12,2),
    sum_assured numeric(12,2),
    payment_method varchar(2),
    maturity_date timestamp,
    prem_stop_date timestamp,
    policy_status varchar(2),
    status_eff_date timestamp,
    referrer varchar(20),
    appl_status numeric(2),
    total_count numeric(6),
    filler varchar(31)
);

CREATE TABLE IF NOT EXISTS cas.tuser_aprov_change_th (
    trxn_dt timestamp DEFAULT CURRENT_TIMESTAMP not null,
    chg_typ varchar(1) not null,
    team_id varchar(2) not null,
    user_id varchar(30) not null,
    fcn_id varchar(20),
    fld_nm varchar(30),
    rec_status varchar(1),
    allow_fr_dt timestamp,
    allow_to_dt timestamp,
    aprov_user varchar(30),
    aprov_dt timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS cas.tuser_passwords (
    user_id varchar(30) not null,
    pwd_used varchar(30) not null,
    pwd_end_date timestamp not null
);

CREATE TABLE IF NOT EXISTS cas.tuser_profiles_sg (
    user_id varchar(30) not null,
    profile_id varchar(30) not null
);

CREATE TABLE IF NOT EXISTS cas.tuser_role_defn (
    user_defn_role varchar(10) not null,
    cas_role varchar(10) not null
);

CREATE TABLE IF NOT EXISTS cas.tuser_rpt_dtls (
    fcn_id varchar(20) not null,
    user_title varchar(20),
    user_name varchar(100),
    user_position varchar(100),
    user_position_eng varchar(100),
    rec_status varchar(1),
    user_id varchar(30),
    id numeric
);

CREATE TABLE IF NOT EXISTS cas.tuser_signature_th (
    id numeric,
    image_filename varchar(50),
    image bytea,
    user_id varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.tuw_authority (
    uw_level numeric(1) not null,
    cli_sex_code varchar(1) not null,
    std_life_sa numeric(13,2) not null,
    std_acc_sa numeric(13,2) not null,
    std_ddb_sa numeric(13,2) not null,
    sub_life_sa numeric(13,2) not null,
    sub_acc_sa numeric(13,2) not null,
    sub_modern_sa numeric(13,2) not null,
    sub_ddb_sa numeric(13,2) not null,
    sub_life_extra numeric(6,2) not null,
    sub_modern_extra numeric(6,2) not null,
    sub_ddb_extra numeric(6,2) not null,
    face_ratg_acc numeric(5,2) not null,
    face_ratg_hs numeric(5,2) not null,
    sub_pblt_extra numeric(6,2) not null,
    face_ratg_pbwp numeric(5,2) not null,
    allow_ind varchar(1) not null,
    last_update_dt varchar(20) not null,
    sub_ci_extra numeric(6,2) not null
);

CREATE TABLE IF NOT EXISTS cas.tvaluation_lead_days (
    col_btch_typ varchar(4) not null,
    lead_days numeric(5),
    last_update_user varchar(30),
    last_update_date timestamp
);

CREATE TABLE IF NOT EXISTS cas.tvp_eligible (
    pol_num varchar(10) not null,
    actual_cv numeric(11,2) not null,
    dec_int_rt numeric(7,5) not null,
    acum_div numeric(11,2) not null,
    csh_surr_valu numeric(11,2) not null,
    fpu_amt numeric(11,2) not null
);

CREATE TABLE IF NOT EXISTS cas.tweb_user_profiles (
    user_id varchar(30),
    user_desc varchar(50),
    appln_id varchar(20),
    user_profile varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.twk_autopay (
    pol_num varchar(10),
    last_avy_dt timestamp,
    pd_to_dt timestamp,
    pmt_mode varchar(5),
    pac_bk_ctr varchar(1),
    dscnt_prem numeric(11,2),
    nyr_dscnt_prem numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.twk_autopay_extract (
    bank_cd varchar(6),
    trxn_dt timestamp,
    pol_num varchar(10),
    pd_to_dt timestamp,
    bank_acct_num varchar(20),
    bank_sv_kd varchar(1),
    prem numeric(11,2),
    id_num varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.tworkareas (
    wor_cd varchar(4) not null,
    wor_desc varchar(40) not null,
    created_by varchar(10) not null,
    date_created timestamp not null,
    date_modified timestamp,
    modified_by varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_acct_extracts (
    pol_num varchar(10),
    trxn_dt timestamp,
    aex_num numeric(8),
    cr_or_dr varchar(1),
    acct_gen_amt numeric(16,2),
    eff_dt timestamp,
    crcy_code varchar(2),
    acct_num varchar(8),
    prod_code varchar(5),
    extract_typ varchar(1),
    fund_id varchar(2),
    jrnl_typ varchar(1),
    legal_id varchar(4),
    lob varchar(2),
    par_ind varchar(1),
    reins_ind varchar(1),
    terr_cd varchar(2),
    wrk_area varchar(4),
    acct_mne_cd varchar(8),
    cli_num varchar(13)
);

CREATE TABLE IF NOT EXISTS cas.twrk_acct_extracts_hk (
    pol_num varchar(10) not null,
    trxn_dt timestamp not null,
    aex_num numeric(8) not null,
    trxn_cd varchar(8) not null,
    acct_mne_cd varchar(8),
    cr_or_dr varchar(1) not null,
    acct_gen_amt numeric(13,2) not null,
    reasn_code varchar(3) not null,
    eff_dt timestamp not null,
    crcy_code varchar(2) not null,
    acct_num varchar(8),
    plan_code varchar(5),
    vers_num varchar(2),
    prod_code varchar(5),
    extract_typ varchar(1) not null,
    feed_ind varchar(1) not null,
    fund_id varchar(2),
    jrnl_typ varchar(5),
    legal_id varchar(4),
    lob varchar(2),
    par_ind varchar(1),
    reins_ind varchar(1),
    terr_cd varchar(2),
    wrk_area varchar(4),
    cli_num varchar(13),
    thi_aex_num numeric(4),
    trxn_id varchar(15),
    report_no numeric(3),
    undo_trxn_id varchar(15),
    user_id varchar(30),
    jrnl_src varchar(5),
    open_flag varchar(5),
    bnk_id varchar(5),
    scheme_cd varchar(5),
    par_ind_hk varchar(1),
    fnd_id varchar(5),
    fnd_vers varchar(6),
    plan_code_base varchar(5),
    vers_num_base varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_acct_extracts_sg (
    pol_num varchar(10) not null,
    trxn_dt timestamp not null,
    aex_num numeric(8) not null,
    trxn_cd varchar(8) not null,
    acct_mne_cd varchar(8),
    cr_or_dr varchar(1) not null,
    acct_gen_amt numeric(13,2) not null,
    reasn_code varchar(3) not null,
    eff_dt timestamp not null,
    crcy_code varchar(2) not null,
    acct_num varchar(8),
    plan_code varchar(5),
    vers_num varchar(2),
    prod_code varchar(5),
    extract_typ varchar(1) not null,
    feed_ind varchar(1) not null,
    fund_id varchar(2),
    jrnl_typ varchar(1),
    legal_id varchar(4),
    lob varchar(2),
    par_ind varchar(1),
    reins_ind varchar(1),
    terr_cd varchar(2),
    wrk_area varchar(4),
    cli_num varchar(10),
    thi_aex_num numeric(4),
    prod_cat varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_acct_values (
    rpt_month varchar(6) not null,
    interest_amt numeric(18,8),
    mngt_fee numeric(18,8),
    invest_return numeric(18,8),
    crcy_cd varchar(2) not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_activity_processed (
    pol_num varchar(10) not null,
    actv_dt timestamp not null,
    asc_num numeric(4) not null,
    actv_reasn varchar(10) not null,
    actv_typ varchar(3) not null,
    trxn_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_activity_schedules (
    pol_num varchar(10) not null,
    actv_dt timestamp not null,
    asc_num numeric(4) not null,
    actv_reasn varchar(10) not null,
    actv_typ varchar(3) not null,
    actv_seq numeric(2),
    proc_dt timestamp,
    ref_date varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.twrk_activity_schedules_backup (
    pol_num varchar(10) not null,
    actv_dt timestamp not null,
    asc_num numeric(4) not null,
    actv_reasn varchar(10) not null,
    actv_typ varchar(3) not null,
    actv_seq numeric(2),
    proc_dt timestamp,
    ref_date varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.twrk_act_schd_b4_p1 (
    pol_num varchar(10) not null,
    actv_dt timestamp not null,
    asc_num numeric(4) not null,
    actv_reasn varchar(10) not null,
    actv_typ varchar(3) not null,
    actv_seq numeric(2),
    proc_dt timestamp,
    ref_date varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.twrk_add00_prem (
    pol_num varchar(10),
    plan_code varchar(5),
    vers_num varchar(2),
    face_amt numeric(13,2),
    add00_prem numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_aea_master (
    cli_num varchar(13) not null,
    trxn_dt timestamp not null,
    pol_num varchar(10) not null,
    nb_ind varchar(1) default 'N' not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_aea_online (
    pol_num varchar(10),
    trxn_dt timestamp,
    nb_ind varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_agents (
    agt_code varchar(5) not null,
    agt_stat_code varchar(2) not null,
    agt_nm varchar(40) not null,
    bus_phone varchar(20) not null,
    loc_code varchar(10),
    team_code varchar(10),
    unit_code varchar(5),
    br_code varchar(5) not null,
    agt_addr varchar(90),
    agt_join_dt timestamp,
    agt_term_dt timestamp,
    zip_code varchar(6),
    uwg_lvl varchar(10),
    agt_sup varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.twrk_agent_cards (
    pol_set_id numeric(10),
    trxn_seq_no numeric(5),
    pol_num varchar(10),
    life_insured varchar(60),
    pol_yr_dt timestamp,
    iss_dt timestamp,
    birth_dt timestamp,
    br_code varchar(5),
    unit_code varchar(5),
    loc_code varchar(10),
    owner varchar(60),
    agt_code varchar(6),
    agt_nm varchar(40),
    addr_1 varchar(60),
    addr_2 varchar(60),
    addr_3 varchar(60),
    addr_4 varchar(60),
    age numeric,
    sex varchar(1),
    rate varchar(10),
    bill_mthd varchar(1),
    pmt_mode varchar(5),
    min_prem numeric(13,2),
    plan_prem numeric(13,2),
    crcy_code varchar(2),
    tot_ctrct_prem numeric(13,2),
    db_opt varchar(1),
    print_flag varchar(1),
    print_status varchar(1),
    request_id numeric(10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_agent_sub (
    agt_code varchar(5) not null,
    agt_sub varchar(5) not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_agt_card (
    request_id numeric(10),
    pol_num varchar(10),
    agt_code varchar(6),
    agt_nm varchar(40),
    br_code varchar(5),
    unit_code varchar(5),
    loc_code varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_agt_card_bene (
    request_id numeric(10),
    pol_num varchar(10),
    agt_code varchar(6),
    seq_num numeric(3),
    bnfy_nm varchar(60),
    bnfy_code varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.twrk_agt_card_cvg (
    request_id numeric(10),
    pol_num varchar(10),
    agt_code varchar(6),
    seq_num numeric(3),
    plan_desc varchar(150),
    face_amt numeric(13,2),
    occp_clas varchar(1),
    prem_dur numeric(3),
    cvg_prem numeric(11,2),
    extra_prem numeric(11,2),
    cvg_eff_dt timestamp,
    cvg_iss_dt timestamp,
    cvg_stat_cd varchar(1),
    cvg_typ varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_agt_chng (
    pol_num varchar(10) not null,
    trxn_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_app_prem_rslts (
    pol_num varchar(10) not null,
    trxn_dt timestamp not null,
    apr_num numeric(5) not null,
    app_fr_acct varchar(8),
    app_mode varchar(10) not null,
    app_reasn varchar(10) not null,
    app_amt numeric(11,2) not null,
    app_rslt varchar(1) not null,
    plan_code varchar(5),
    vers_num varchar(2),
    cli_num varchar(13),
    cvg_eff_dt timestamp,
    prev_stat_cd varchar(1) not null,
    prev_pd_to_dt timestamp not null,
    prev_last_avy_dt timestamp not null,
    prev_dscnt_prem numeric(11,2) not null,
    prev_pmt_susp numeric(11,2) not null,
    prev_pol_susp numeric(11,2) not null,
    new_stat_cd varchar(1) not null,
    new_pd_to_dt timestamp not null,
    new_last_avy_dt timestamp not null,
    new_dscnt_prem numeric(11,2) not null,
    new_pmt_susp numeric(11,2) not null,
    new_pol_susp numeric(11,2) not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_autopay (
    pol_num varchar(10),
    last_avy_dt timestamp,
    pd_to_dt timestamp,
    pmt_mode varchar(5),
    pac_bk_ctr varchar(1),
    dscnt_prem numeric(11,2),
    nyr_dscnt_prem numeric(11,2),
    pmt_susp numeric(11,2),
    bill_to_dt timestamp,
    pol_eff_dt timestamp,
    nxt_eff_dscnt_prem numeric(11,2),
    nxt_eff_prem_dt timestamp,
    ctr_prem numeric(11,2),
    nxt_eff_ctr_prem numeric(11,2),
    crcy_code varchar(2),
    mode_prem numeric(11,2),
    fran_num varchar(4)
);

CREATE TABLE IF NOT EXISTS cas.twrk_autopay_extract (
    trxn_dt timestamp,
    pol_num varchar(10),
    pd_to_dt timestamp,
    prem numeric(11,2),
    bank_cd varchar(13),
    bank_acct_num varchar(20),
    bank_sv_kd varchar(1),
    id_num varchar(20),
    pac_bk_ctr varchar(1),
    client_nm varchar(80),
    bank_acct_nm varchar(60),
    div_amt numeric(11,2),
    exchg_rt numeric(18,8),
    owner_cli_nm varchar(40),
    owner_cli_num varchar(13),
    pol_crcy_code varchar(2),
    pol_crcy_prem numeric(11,2),
    run_dt timestamp,
    bank_fee_ind varchar(1),
    bank_fee_amt numeric(11,4),
    bill_amt numeric(11,2),
    bank_debit_dt timestamp,
    fran_num varchar(4)
);

CREATE TABLE IF NOT EXISTS cas.twrk_autopay_extract_ht (
    pol_num varchar(10),
    pd_to_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_autopay_extract_sg (
    trxn_dt timestamp,
    pol_num varchar(10),
    pd_to_dt timestamp,
    prem numeric(11,2),
    bank_cd varchar(13),
    bank_acct_num varchar(20),
    bank_sv_kd varchar(1),
    id_num varchar(20),
    pac_bk_ctr varchar(1),
    client_nm varchar(80),
    bank_acct_nm varchar(60),
    div_amt numeric(11,2),
    exchg_rt numeric(18,8),
    owner_cli_num varchar(10),
    owner_cli_nm varchar(40),
    pol_crcy_code varchar(2),
    pol_crcy_prem numeric(11,2),
    run_dt timestamp,
    bank_fee_ind varchar(1),
    bank_fee_amt numeric(11,4),
    bill_amt numeric(11,2),
    bank_debit_dt timestamp,
    fran_num varchar(4)
);

CREATE TABLE IF NOT EXISTS cas.twrk_autopay_sg (
    pol_num varchar(10),
    last_avy_dt timestamp,
    pd_to_dt timestamp,
    pmt_mode varchar(5),
    pac_bk_ctr varchar(1),
    dscnt_prem numeric(11,2),
    nyr_dscnt_prem numeric(11,2),
    pmt_susp numeric(11,2),
    bill_to_dt timestamp,
    pol_eff_dt timestamp,
    nxt_eff_dscnt_prem numeric(11,2),
    nxt_eff_prem_dt timestamp,
    ctr_prem numeric(11,2),
    nxt_eff_ctr_prem numeric(11,2),
    crcy_code varchar(2),
    mode_prem numeric(11,2),
    fran_num varchar(4)
);

CREATE TABLE IF NOT EXISTS cas.twrk_auto_bank_th (
    trxn_dt timestamp,
    seq_no numeric(4),
    bank_code varchar(30),
    company_cd varchar(4),
    trxn_type varchar(2),
    bank_acct varchar(10),
    home_branch varchar(3),
    rec_code varchar(1),
    bill_amt varchar(12),
    pol_num varchar(10),
    pd_to_dt timestamp,
    bank_debit_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_auto_feed_files (
    bank_code varchar(13),
    file_name varchar(35),
    dataline varchar(2000),
    result_cd varchar(5),
    pol_num varchar(20),
    trxn_amt numeric(11,2),
    trxn_dt varchar(14),
    file_num varchar(5),
    feed_date varchar(14),
    acct_num varchar(30),
    off_loc_cd varchar(5),
    dist_chnl_cd varchar(2),
    crcy_code varchar(2),
    c_cpf_inv_acct varchar(20),
    c_nric_no varchar(20),
    c_cust_name varchar(80),
    c_authorise varchar(1),
    c_pol_name varchar(40),
    c_collect_ind varchar(1),
    c_batch_serial varchar(6),
    c_internal_ref varchar(20),
    h_cpf_acct varchar(9),
    h_house_ref varchar(30),
    h_name varchar(66),
    h_coy_cde varchar(2),
    reject_cd varchar(10),
    bank_cd varchar(13),
    bank_deb_dt varchar(14),
    pac_upd varchar(1),
    prem_amt numeric(11,2),
    bank_fee_ind varchar(1),
    bank_fee_amt numeric(11,4),
    pd_to_dt varchar(14),
    bill_mthd varchar(1),
    fran_num varchar(4),
    acct_typ varchar(5),
    acct_xpry_dt varchar(14),
    branch_cd varchar(20),
    payment_ref varchar(200),
    batch_seq numeric(10),
    deposit_slip_num varchar(30),
    reasn_code varchar(3),
    status_cd varchar(1),
    feed_typ varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_auto_rcc_bill_extracts (
    run_dt timestamp,
    bill_mthd varchar(1),
    fran_num varchar(4),
    pol_num varchar(10),
    pol_crcy_code varchar(2),
    pd_to_dt timestamp,
    prem_amt numeric(11,2),
    pmt_susp numeric(11,2),
    bill_amt numeric(11,2),
    sa_cd_1 varchar(6),
    sa_cd_2 varchar(6),
    client_nm varchar(80),
    card_num varchar(20),
    card_typ varchar(1),
    card_iss_bank varchar(13),
    card_holder_id_typ varchar(1),
    card_holder_id_num varchar(20),
    card_holder_name varchar(60),
    card_xpry_dt timestamp,
    bill_status varchar(1),
    trxn_dt timestamp,
    bank_process_dt timestamp,
    cc_fee_ind varchar(1),
    cc_fee_amt numeric(11,4),
    cwa_susp numeric(13,2),
    card_cat varchar(1),
    pol_iss_dt timestamp,
    rcc_type varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.twrk_batch_policys (
    seq_no numeric(6),
    proc_code varchar(1),
    pol_num varchar(10),
    trxn_amt numeric(10),
    trxn_dt timestamp,
    reasn_code varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.twrk_batch_policy_tw (
    seq_no numeric(6),
    proc_code varchar(1),
    pol_num varchar(10),
    trxn_amt numeric(10),
    trxn_dt timestamp,
    reasn_code varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.twrk_billing_cli_tw (
    pol_num varchar(10) not null,
    bex_num numeric(4) not null,
    trxn_dt timestamp not null,
    rel_to_insrd varchar(2) not null,
    rel_desc varchar(50),
    cli_num varchar(10) not null,
    cli_nm varchar(40),
    cli_dob timestamp not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_billing_cvg_tw (
    pol_num varchar(10) not null,
    bex_num numeric(4) not null,
    trxn_dt timestamp not null,
    cli_num varchar(10) not null,
    plan_typ varchar(2) not null,
    prt_seq numeric(3) not null,
    plan_code varchar(5) not null,
    plan_desc varchar(50),
    plan_cntnt varchar(20),
    cvg_eff_dt timestamp not null,
    prem_dur numeric(3),
    mode_prem numeric(11,2),
    joint_cli_num varchar(10),
    vers_num varchar(2) not null,
    xpry_dt timestamp,
    cvg_eff_age numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.twrk_billing_extracts (
    pol_num varchar(10) not null,
    bex_num numeric(4) not null,
    agt_branch varchar(5),
    agt_code varchar(6),
    agt_nm varchar(40),
    apl_ext_days numeric(3),
    apl_laps_dt timestamp,
    apl_max_loan numeric(11,2),
    apl_pmt_mode varchar(5),
    avy_dt timestamp,
    bank_acct_num varchar(40),
    base_plan_code varchar(5),
    bill_mthd varchar(1),
    bill_to_dt timestamp,
    div_bal numeric(11,2),
    div_int numeric(11,2),
    div_opt varchar(1),
    div_crnt_amt numeric(11,2),
    dscnt_prem numeric(11,2),
    endow_bal numeric(11,2),
    endow_int numeric(11,2),
    fran_num varchar(4),
    ins_typ varchar(1),
    insrd_addr_1 varchar(60),
    insrd_addr_2 varchar(60),
    insrd_addr_3 varchar(60),
    insrd_zip_code varchar(6),
    insrd_nm varchar(60),
    ipo_ind varchar(1),
    lapse_amt numeric(11,2),
    loan_bal numeric(11,2),
    loan_int numeric(11,2),
    owner_addr_1 varchar(60),
    owner_addr_2 varchar(60),
    owner_addr_3 varchar(60),
    owner_zip_code varchar(6),
    owner_nm varchar(60),
    pac_gen_dt timestamp,
    pd_to_dt timestamp,
    pmt_mode varchar(5),
    pmt_susp numeric(11,2),
    pol_eff_dt timestamp,
    pol_susp numeric(13,2),
    pol_stat_cd varchar(1),
    prem_bill numeric(11,2),
    proc_code varchar(1),
    query_code varchar(10),
    sex varchar(1),
    pac_eff_dt timestamp,
    trxn_dt timestamp,
    prem_paid_by_endow numeric(13,2),
    last_endow_bal numeric(13,2),
    endow_earned numeric(13,2),
    last_loan_bal numeric(13,2),
    cash_value numeric(13,2),
    invalid_addr_ind varchar(1),
    pac_bk_ctr varchar(1),
    xcpt_bill_cd varchar(1),
    local_query varchar(20),
    actv_dt timestamp,
    lnb_ind varchar(1),
    vers_num varchar(2),
    agt_unit varchar(5),
    agt_loc_code varchar(10),
    actv_reasn varchar(10),
    prev_loan_bal numeric(13,2),
    prev_loan_int numeric(13,2),
    ipo_fa numeric(13,2),
    pol_value numeric(13,2),
    adv_btd varchar(2),
    lump_sum_bal numeric(13,2),
    lump_sum_ind varchar(1),
    mode_prem numeric(11,2),
    prev_dscnt_prem numeric(11,2),
    prev_pmt_mode varchar(2),
    insrd_addr_4 varchar(60),
    owner_addr_4 varchar(60),
    id_num varchar(20),
    rpu_db numeric(13,2),
    endow_ctl varchar(1),
    cv_avail_ind varchar(1),
    fcn_id varchar(20),
    fcn_id_ver varchar(10),
    surr_valu numeric(13,2),
    prev_pd_to_dt timestamp,
    apl_used numeric(11,2),
    ccp_used numeric(11,2),
    div_used numeric(11,2),
    lump_sum_used numeric(11,2),
    suppay_used numeric(11,2),
    bank_fee_ind varchar(1),
    bank_fee_amt numeric(11,4),
    bill_amt numeric(11,2),
    ncd_plan_code varchar(5),
    ncd_vers_num varchar(2),
    ncd_amt numeric(13,2),
    ncd_dscnt_rt numeric(7,4),
    ncd_eff_avy_yr numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.twrk_billing_extracts_cvg (
    bex_num numeric(4) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    face_amt numeric(13,2),
    cvg_stat_cd varchar(1),
    pua_tot_amt numeric(13,2),
    expiry_dt timestamp,
    dscnt_prem numeric(11,2),
    cvg_prem numeric(11,2),
    extra_prem numeric(11,2),
    dth_bnft_amt numeric(13,2),
    action_code varchar(10),
    trxn_dt timestamp,
    pol_num varchar(10) not null,
    cvg_clas varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.twrk_bnfy_dtls (
    pol_set_id numeric(10),
    trxn_seq_no numeric(5),
    pol_num varchar(10),
    bde_num numeric(4),
    bnfy_typ varchar(3),
    bnfy_code varchar(3),
    bnfy_nm varchar(60),
    bnfy_pct numeric(5,2),
    bnfy_prty varchar(1),
    bnfy_order numeric(2),
    print_flag varchar(1),
    print_status varchar(1),
    request_id numeric(10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_broker_uppol (
    agt_code varchar(6),
    agt_nm varchar(60),
    app_no varchar(17),
    pol_num varchar(10),
    pol_app_dt timestamp,
    sbmt_dt timestamp,
    pol_iss_dt timestamp,
    pol_eff_dt timestamp,
    pd_to_dt timestamp,
    cli_nm varchar(100),
    plan_code varchar(5),
    face_amt numeric(13,2),
    pmt_mode varchar(150),
    dscnt_prem numeric(11,2),
    dscnt_rt numeric,
    total_premium numeric(11,2),
    premium_collected numeric,
    last_paid_premium_dt timestamp,
    last_premium_trxn_dt timestamp,
    pol_status varchar(150),
    date_cr timestamp,
    reciv_prem_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_casacthr0004 (
    request_id numeric,
    run_date timestamp,
    rep_grp numeric(2),
    rep_grp_desc varchar(20),
    plan_type_seq numeric(3),
    plan_type_desc varchar(40),
    premium numeric(13,2),
    commission numeric(13,2),
    user_created varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casacthr0016 (
    request_id numeric(10),
    chq_btch_num varchar(5),
    agt_typ varchar(5),
    pol_num varchar(10),
    payee_nm varchar(60),
    trxn_amt numeric(11,2),
    receipt_num varchar(60),
    eff_dt timestamp,
    pol_iss_dt timestamp,
    iss_bank varchar(30),
    bank_cd varchar(13),
    bank_acct_num varchar(16),
    bank_type varchar(150),
    agt_code varchar(6),
    pol_yr numeric,
    edc_zip_zap_rec varchar(150),
    reas_des varchar(150),
    trxn_dt timestamp,
    dnr_iss_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_casacthr0016a (
    dnr_iss_dt timestamp not null,
    pol_num varchar(10) not null,
    trxn_dt timestamp not null,
    chq_btch_num varchar(5) not null,
    trxn_amt numeric(11,2),
    receipt_num varchar(60),
    pol_iss_dt timestamp,
    iss_bank varchar(30),
    bank_acct_num varchar(16),
    bank_type varchar(150),
    agt_code varchar(6),
    pol_yr numeric,
    current_bill_mthd varchar(150),
    reas_des varchar(150)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casacthr0025_1 (
    pol_num varchar(10),
    layer_typ varchar(60),
    pol_iss_dt timestamp,
    mvy_trxn_dt timestamp,
    fnd_id varchar(5),
    fnd_vers varchar(6),
    fnd_bal numeric(13,2),
    fnd_bal_unit numeric(20,10),
    fnd_bal_pric numeric(20,10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casacthr0025_2 (
    pol_num varchar(10),
    layer_typ varchar(60),
    fnd_id varchar(5),
    fnd_vers varchar(6),
    fnd_bal numeric(13,2),
    fnd_bal_unit numeric(20,10),
    fnd_bal_pric numeric(20,10),
    deposit numeric(13,2),
    withdrawal numeric(13,2),
    prem_chrg numeric(13,2),
    coi_chrg numeric(13,2),
    pol_chrg numeric(13,2),
    pol_mgt_fee numeric(13,2),
    surr_chrg numeric(13,2),
    stm_fee numeric(13,2),
    div1 numeric(13,2),
    div2 numeric(13,2),
    gain numeric(13,2),
    loss numeric(13,2),
    other numeric(13,2),
    net_bal numeric(13,2),
    net_bal_unit numeric(20,10),
    net_bal_pric numeric(20,10),
    user_id varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casacthr0025_3 (
    run_num varchar(6),
    pol_num varchar(10),
    layer_typ varchar(60),
    pol_iss_dt timestamp,
    mvy_trxn_dt timestamp,
    fnd_id varchar(5),
    fnd_vers varchar(6),
    fnd_bal numeric(13,2),
    fnd_bal_unit numeric(20,10),
    fnd_bal_pric numeric(20,10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casacthr0026_1 (
    pol_num varchar(10),
    layer_typ varchar(60),
    pol_iss_dt timestamp,
    mvy_trxn_dt timestamp,
    fnd_id varchar(5),
    fnd_vers varchar(6),
    fnd_bal numeric(13,2),
    fnd_bal_unit numeric(20,10),
    fnd_bal_pric numeric(20,10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casacthr0026_2 (
    pol_num varchar(10),
    layer_typ varchar(60),
    fnd_id varchar(5),
    fnd_vers varchar(6),
    fnd_bal numeric(13,2),
    fnd_bal_unit numeric(20,10),
    fnd_bal_pric numeric(20,10),
    deposit numeric(13,2),
    withdrawal numeric(13,2),
    prem_chrg numeric(13,2),
    coi_chrg numeric(13,2),
    pol_chrg numeric(13,2),
    pol_mgt_fee numeric(13,2),
    surr_chrg numeric(13,2),
    stm_fee numeric(13,2),
    div1 numeric(13,2),
    div2 numeric(13,2),
    gain numeric(13,2),
    loss numeric(13,2),
    other numeric(13,2),
    net_bal numeric(13,2),
    net_bal_unit numeric(20,10),
    net_bal_pric numeric(20,10),
    user_id varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casacthr0026_3 (
    run_num varchar(6),
    pol_num varchar(10),
    layer_typ varchar(60),
    pol_iss_dt timestamp,
    mvy_trxn_dt timestamp,
    fnd_id varchar(5),
    fnd_vers varchar(6),
    fnd_bal numeric(13,2),
    fnd_bal_unit numeric(20,10),
    fnd_bal_pric numeric(20,10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casacthr0027_1 (
    reasn_desc varchar(20),
    trxn_dt timestamp,
    pol_num varchar(10),
    reasn_cd varchar(10),
    deal_basis varchar(10),
    fnd_id varchar(5),
    fnd_vers varchar(6),
    trxn_unit numeric(20,10),
    fnd_trxn_pric numeric(20,10),
    trxn_amt numeric(13,2),
    user_id varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casacthr0027_2 (
    reasn_desc varchar(20),
    trxn_dt timestamp,
    pol_num varchar(10),
    prem_type varchar(10),
    order_type varchar(10),
    fnd_desc_1 varchar(250),
    fnd_unit_1 numeric(20,10),
    fnd_pric_1 numeric(20,10),
    fnd_thb_1 numeric(13,2),
    fnd_amt_1 numeric(13,2),
    fnd_desc_2 varchar(250),
    fnd_unit_2 numeric(20,10),
    fnd_pric_2 numeric(20,10),
    fnd_thb_2 numeric(13,2),
    fnd_amt_2 numeric(13,2),
    fnd_desc_3 varchar(250),
    fnd_unit_3 numeric(20,10),
    fnd_pric_3 numeric(20,10),
    fnd_thb_3 numeric(13,2),
    fnd_amt_3 numeric(13,2),
    fnd_desc_4 varchar(250),
    fnd_unit_4 numeric(20,10),
    fnd_pric_4 numeric(20,10),
    fnd_thb_4 numeric(13,2),
    fnd_amt_4 numeric(13,2),
    fnd_tot_amt numeric(13,2),
    user_id varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casacthr0027_3 (
    fnd_id varchar(5),
    fnd_vers varchar(6),
    fnd_desc varchar(250),
    fnd_seq numeric(3),
    user_id varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casacthr0028_1 (
    trxn_dt timestamp,
    valn_dt timestamp,
    pol_num varchar(10),
    fnd_id varchar(5),
    fnd_vers varchar(6),
    deal_basis varchar(1),
    trxn_cd varchar(3),
    trxn_id varchar(15),
    cas_trxn_pric numeric(20,10),
    cas_trxn_unit numeric(20,10),
    cas_trxn_amt numeric(13,2),
    trxn_pct numeric(13,2),
    fnd_trxn_pric numeric(20,10),
    fnd_trxn_unit numeric(20,10),
    fnd_trxn_amt numeric(13,2),
    user_id varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casacthr0028_2 (
    trxn_dt timestamp,
    pol_num varchar(10),
    fnd_out_desc varchar(20),
    fnd_in_1_desc varchar(20),
    fnd_in_2_desc varchar(20),
    fnd_out_unit numeric(20,10),
    fnd_in_1_unit numeric(20,10),
    fnd_in_2_unit numeric(20,10),
    cas_fnd_out_pct numeric(13,2),
    cas_fnd_out_unit numeric(20,10),
    cas_fnd_in_1_pct numeric(13,2),
    cas_fnd_in_1_unit numeric(20,10),
    cas_fnd_in_2_pct numeric(13,2),
    cas_fnd_in_2_unit numeric(20,10),
    diff_fnd_in_1_unit numeric(20,10),
    diff_fnd_in_2_unit numeric(20,10),
    rec_fnd_out_unit numeric(20,10),
    rec_fnd_out_nav_t1 numeric(20,10),
    rec_fnd_out_amt_t1 numeric(13,2),
    rec_fnd_out_nav_t0 numeric(20,10),
    rec_fnd_out_amt_t0 numeric(13,2),
    rec_fnd_out_amt_diff numeric(13,2),
    rec_fnd_in_1_nav_t1 numeric(20,10),
    rec_fnd_in_2_nav_t1 numeric(20,10),
    rec_fnd_in_1_unit_diff numeric(20,10),
    rec_fnd_in_2_unit_diff numeric(20,10),
    rec_fnd_in_1_unit_chk numeric(20,10),
    rec_fnd_in_2_unit_chk numeric(20,10),
    seq_no numeric(9),
    user_id varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casacthr0029 (
    request_id numeric,
    fnd_id varchar(5),
    fnd_vers varchar(6),
    fnd_desc varchar(200),
    pol_num varchar(10),
    plan_code varchar(5),
    vers_num varchar(2),
    mvy_dt timestamp,
    mvy_seq numeric(3),
    insured_nm varchar(60),
    pol_iss_dt timestamp,
    pd_to_dt timestamp,
    pmt_mode varchar(5),
    trxn_dt timestamp,
    fnd_trxn_pric numeric(20,10),
    sell_pric numeric(20,10),
    valn_dt timestamp,
    trxn_unit numeric(20,10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casactthr0005_pa (
    request_id numeric,
    from_dt timestamp,
    to_dt timestamp,
    issuedate varchar(4),
    province varchar(20),
    pa_new_no_pol numeric(6),
    pa_new_face_amt numeric(13,2),
    pa_de_no_pol numeric(6),
    pa_de_face_amt numeric(13,2),
    pa_if_no_pol numeric(6),
    pa_if_face_amt numeric(13,2),
    pa_tot_prem numeric(13,2),
    pa_benefit_pay numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casactthr0005_th (
    request_id numeric,
    from_dt timestamp,
    to_dt timestamp,
    issuedate varchar(4),
    province varchar(20),
    ord_new_no_pol numeric(6),
    ord_new_face_amt numeric(13,2),
    ord_de_no_pol numeric(6),
    ord_de_face_amt numeric(13,2),
    ord_if_no_pol numeric(6),
    ord_if_face_amt numeric(13,2),
    ord_tot_prem numeric(13,2),
    ord_benefit_pay numeric(13,2),
    ind_new_no_pol numeric(6),
    ind_new_face_amt numeric(13,2),
    ind_de_no_pol numeric(6),
    ind_de_face_amt numeric(13,2),
    ind_if_no_pol numeric(6),
    ind_if_face_amt numeric(13,2),
    ind_tot_prem numeric(13,2),
    ind_benefit_pay numeric(13,2),
    glh_new_no_pol numeric(6),
    glh_new_face_amt numeric(13,2),
    glh_de_no_pol numeric(6),
    glh_de_face_amt numeric(13,2),
    glh_if_no_pol numeric(6),
    glh_if_face_amt numeric(13,2),
    glh_tot_prem numeric(13,2),
    glh_benefit_pay numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casactthr0006 (
    request_id numeric,
    class varchar(1),
    ord numeric,
    plan_code varchar(10),
    type_acc varchar(200),
    plan_rider varchar(100),
    num_pol numeric,
    face_amount numeric,
    cp_earned_premium numeric,
    cp_death_case numeric,
    cp_death_paid numeric,
    cp_dis_case numeric,
    cp_dis_paid numeric,
    cp_tpd_case numeric,
    cp_tpd_paid numeric,
    cp_tpd_hs_expense numeric
);

CREATE TABLE IF NOT EXISTS cas.twrk_casactthr0007 (
    request_id numeric,
    class varchar(1),
    ord numeric,
    plan_code varchar(10),
    type_acc varchar(200),
    plan_rider varchar(100),
    num_pol numeric,
    face_amount numeric,
    cp_earned_premium numeric,
    cp_death_case numeric,
    cp_death_paid numeric,
    cp_dis_case numeric,
    cp_dis_paid numeric,
    cp_tpd_case numeric,
    cp_tpd_paid numeric,
    cp_tpd_hs_expense numeric
);

CREATE TABLE IF NOT EXISTS cas.twrk_casactthr0008 (
    request_id numeric,
    sex_code varchar(1),
    sex varchar(10),
    plan_code varchar(10),
    cvg_clas varchar(10),
    num_claims numeric,
    room numeric,
    doc numeric,
    misc numeric,
    sug numeric,
    outp numeric,
    oth numeric,
    total_benefits numeric,
    earned_prem numeric,
    death_benefits numeric,
    cf_count_ins numeric,
    flag varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casactthr0010_th (
    request_id numeric,
    run_year varchar(4),
    pol_stat_cd varchar(20),
    valn_code varchar(20),
    plan_grp_nm varchar(50),
    medic_code varchar(20),
    uwg_clas varchar(20),
    sex_code varchar(10),
    age numeric(3),
    duration0 numeric(3),
    duration1 numeric(3),
    duration2 numeric(3),
    duration3 numeric(3),
    duration4 numeric(3),
    duration5 numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casactthr0011_th (
    request_id numeric,
    run_year varchar(4),
    pol_stat_cd varchar(20),
    valn_code varchar(20),
    plan_grp_nm varchar(50),
    medic_code varchar(20),
    uwg_clas varchar(20),
    sex_code varchar(10),
    age numeric(3),
    duration0 numeric(3),
    duration1 numeric(3),
    duration2 numeric(3),
    duration3 numeric(3),
    duration4 numeric(3),
    duration5 numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casactthr0012_th (
    request_id numeric,
    run_year varchar(4),
    pol_stat_cd varchar(20),
    valn_code varchar(20),
    plan_grp_nm varchar(50),
    medic_code varchar(20),
    uwg_clas varchar(20),
    sex_code varchar(10),
    age numeric(3),
    duration0 numeric(3),
    duration1 numeric(3),
    duration2 numeric(3),
    duration3 numeric(3),
    duration4 numeric(3),
    duration5 numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casactthr0013 (
    year varchar(4),
    from_dt timestamp,
    to_dt timestamp,
    channel_typ varchar(2),
    premium numeric(16,2),
    percentage numeric
);

CREATE TABLE IF NOT EXISTS cas.twrk_casactthr0014 (
    request_id numeric,
    grp varchar(50),
    grp_typ varchar(20),
    cnt_nb numeric,
    cnt_lapse numeric,
    cnt_oth numeric,
    cnt_curr numeric,
    premium_nb numeric(13,2),
    premium_lapse numeric(13,2),
    premium_oth numeric(13,2),
    premium_curr numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casactthr0015 (
    request_id numeric,
    plan_grp_nm varchar(20),
    att_age numeric,
    cnt_pol_num numeric,
    cnt_male numeric,
    cnt_female numeric,
    cnt_claim numeric
);

CREATE TABLE IF NOT EXISTS cas.twrk_casactthr0016 (
    request_id numeric,
    rec010 varchar(10),
    plcsts varchar(10),
    polstsform varchar(200),
    plctyp varchar(5),
    plcnbr varchar(10),
    efd010 varchar(5),
    eftmm varchar(5),
    eftyyyy varchar(5),
    issage numeric,
    cwc010 varchar(10),
    plcpln varchar(50),
    mop010 varchar(5),
    dud010 varchar(5),
    dum010 varchar(5),
    duy010 varchar(5),
    duration varchar(5),
    pol_eff_dt timestamp,
    pd_to_dt timestamp,
    prd010 varchar(10),
    cls010 varchar(10),
    std010 varchar(30),
    medic_code varchar(10),
    lifeamtp numeric,
    ai_aprov numeric,
    airc_aprov numeric,
    add_aprov numeric,
    adrc_aprov numeric,
    adb_aprov numeric,
    ddb_aprov numeric,
    lt_aprov numeric,
    dhd010 varchar(5),
    dhm010 varchar(5),
    dhy010 varchar(5),
    srd010 numeric,
    srm010 numeric,
    sry010 numeric,
    cac010 varchar(9),
    pct010 numeric,
    ifa010 numeric,
    ai_face numeric,
    airc_face numeric,
    add_face numeric,
    adrc_face numeric,
    adb_face numeric,
    ddb_face numeric,
    lt_face numeric,
    pyd010 varchar(5),
    pym010 varchar(5),
    pyy010 varchar(5),
    brc010 varchar(5),
    unc010 varchar(5),
    agc010 varchar(6),
    sex010 varchar(1),
    slt010 numeric,
    aml numeric,
    pnc010 numeric,
    cac_thai varchar(10),
    att_age numeric,
    std_sub varchar(30),
    med_non varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casactthr0017 (
    request_id numeric,
    cas_sys_dt timestamp,
    plan_sts varchar(1),
    num_rec_plan numeric,
    sum_as numeric,
    dth_ben_sa numeric,
    ann_prm numeric,
    annstd_prm numeric,
    disc_modpm numeric
);

CREATE TABLE IF NOT EXISTS cas.twrk_casactthr0018 (
    request_id numeric,
    cas_sys_dt timestamp,
    pol_num varchar(10),
    col_nm varchar(30),
    old_valu varchar(200),
    new_valu varchar(200),
    old_dscnt_prem numeric,
    old_face_amt numeric
);

CREATE TABLE IF NOT EXISTS cas.twrk_casactthr0018s (
    request_id numeric,
    cas_sys_dt timestamp,
    no_pre_mth numeric,
    pre_mth_anp numeric,
    pre_mth_sa numeric,
    no_curr_mth numeric,
    curr_mth_anp numeric,
    curr_mth_sa numeric,
    add_new numeric,
    add_new_anp numeric,
    add_new_sa numeric,
    add_rein numeric,
    add_rein_anp numeric,
    add_rein_sa numeric,
    add_inc_sa numeric,
    add_inc_sa_anp numeric,
    add_inc_sa_sa numeric,
    add_chg_mode numeric,
    add_chg_mode_anp numeric,
    add_eti_inf numeric,
    add_eti_inf_anp numeric,
    add_eti_inf_sa numeric,
    add_rpu_inf numeric,
    add_rpu_inf_anp numeric,
    add_rpu_inf_sa numeric,
    add_oth numeric,
    add_oth_anp numeric,
    add_oth_sa numeric,
    add_oth_pol varchar(200),
    reduc_lapse numeric,
    reduc_lapse_anp numeric,
    reduc_lapse_sa numeric,
    reduc_sur numeric,
    reduc_sur_anp numeric,
    reduc_sur_sa numeric,
    reduc_death numeric,
    reduc_death_anp numeric,
    reduc_death_sa numeric,
    reduc_mat numeric,
    reduc_mat_anp numeric,
    reduc_mat_sa numeric,
    reduc_exp numeric,
    reduc_exp_anp numeric,
    reduc_exp_sa numeric,
    reduc_canc numeric,
    reduc_canc_anp numeric,
    reduc_canc_sa numeric,
    reduc_dec_sa numeric,
    reduc_dec_sa_anp numeric,
    reduc_dec_sa_sa numeric,
    reduc_chg_mode numeric,
    reduc_chg_mode_anp numeric,
    reduc_inf_eti numeric,
    reduc_inf_eti_anp numeric,
    reduc_inf_eti_sa numeric,
    reduc_inf_rpu numeric,
    reduc_inf_rpu_anp numeric,
    reduc_inf_rpu_sa numeric,
    reduc_inf_fulp numeric,
    reduc_inf_fulp_anp numeric,
    reduc_oth numeric,
    reduc_oth_anp numeric,
    reduc_oth_sa numeric,
    reduc_oth_pol varchar(200)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casactthr0019 (
    status varchar(15),
    request_id numeric,
    cas_sys_dt timestamp,
    pol_num varchar(10),
    act_mode varchar(6),
    col_nm varchar(30),
    old_valu varchar(200),
    new_valu varchar(200),
    old_dscnt_prem numeric,
    new_dscnt_prem numeric,
    old_face_amt numeric,
    plan_code varchar(5),
    vers_num varchar(2),
    cvg_eff_dt timestamp,
    cli_num varchar(13)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casactthr0019s (
    request_id numeric,
    cas_sys_dt timestamp,
    no_pre_mth numeric,
    pre_mth_anp numeric,
    pre_mth_sa numeric,
    no_curr_mth numeric,
    curr_mth_anp numeric,
    curr_mth_sa numeric,
    add_new numeric,
    add_new_anp numeric,
    add_new_sa numeric,
    add_rein numeric,
    add_rein_anp numeric,
    add_rein_sa numeric,
    reduc_canc numeric,
    reduc_canc_anp numeric,
    reduc_canc_sa numeric,
    reduc_lapse numeric,
    reduc_lapse_anp numeric,
    reduc_lapse_sa numeric,
    reduc_death numeric,
    reduc_death_anp numeric,
    reduc_death_sa numeric,
    reduc_exp numeric,
    reduc_exp_anp numeric,
    reduc_exp_sa numeric,
    reduc_del numeric,
    reduc_del_anp numeric,
    reduc_del_sa numeric,
    chgmod numeric,
    chgmod_anp numeric,
    chgmod_sa numeric,
    chganp numeric,
    chganp_anp numeric,
    chganp_sa numeric,
    chgsa numeric,
    chgsa_anp numeric,
    chgsa_sa numeric,
    oth numeric,
    oth_anp numeric,
    oth_sa numeric,
    oth_pol varchar(500)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casactthr0020 (
    request_id numeric,
    cas_sys_dt timestamp,
    rtype varchar(10),
    pol_num varchar(10),
    i_sex_code varchar(1),
    i_birth_dt timestamp,
    plan_eff_dt timestamp,
    pmt_mode varchar(5),
    div_opt varchar(1),
    occp_clas varchar(1),
    face_amt numeric(13,2),
    orig_face_amt numeric(13,2),
    pol_stat_cd varchar(1),
    pol_iss_dt timestamp,
    last_due_dt timestamp,
    next_due_dt timestamp,
    status_eff_dt timestamp,
    pol_loan_amt numeric(13,2),
    risk_clas varchar(3),
    p_sex_code varchar(1),
    death_amt numeric(13,2),
    plan_shrt_desc varchar(20),
    sum_ass_chg_dt timestamp,
    fnd_detail varchar(200)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casagthr0002 (
    request_id numeric,
    pol_num varchar(10),
    agt_code varchar(6),
    agt_nm varchar(80),
    insure_name varchar(80),
    br_code varchar(5),
    br_nm varchar(40),
    ret_to_agt_nm varchar(80),
    rpt_to_grp varchar(6),
    pol_eff_dt timestamp,
    nfo_eff_dt timestamp,
    plan_code_base varchar(5),
    orig_face_amt numeric,
    pol_stat_cd varchar(1),
    newsum numeric,
    expire_date timestamp,
    pureendowment numeric,
    csv numeric,
    total_loan numeric,
    net_cvg numeric,
    net_amt numeric
);

CREATE TABLE IF NOT EXISTS cas.twrk_casagthr0003 (
    request_id numeric,
    pol_num varchar(10),
    agt_code varchar(6),
    agt_nm varchar(80),
    insure_name varchar(80),
    br_code varchar(5),
    br_nm varchar(40),
    ret_to_agt_nm varchar(80),
    rpt_to_grp varchar(6),
    pol_eff_dt timestamp,
    nfo_eff_dt timestamp,
    plan_code_base varchar(5),
    orig_face_amt numeric,
    pol_stat_cd varchar(1),
    newsum numeric,
    expire_date timestamp,
    pureendowment numeric,
    csv numeric,
    total_loan numeric,
    net_cvg numeric,
    net_amt numeric
);

CREATE TABLE IF NOT EXISTS cas.twrk_casclthl0022 (
    seq_num numeric(4),
    clm_code varchar(2),
    clm_stat_code varchar(1),
    fax_claim varchar(1),
    event_date timestamp,
    pol_num varchar(10),
    clmant varchar(40),
    hospital_name varchar(100),
    clm_hosp_begin_dt timestamp,
    clm_hosp_end_dt timestamp,
    room_board_days numeric(4),
    intens_care_days numeric(4),
    doctor_visit_days numeric(4),
    surgeon_fee_pct numeric(5,2),
    anaesth_fee_pct numeric(5,2),
    room_board_ben numeric(17,2),
    intens_care_max numeric(17,2),
    doctor_visit_ben numeric(17,2),
    hosp_expens_max numeric(17,2),
    surgeon_fee_max numeric(17,2),
    anaesth_fee_max numeric(17,2),
    op_theatre_max numeric(17,2),
    room_board_clm numeric(17,2),
    intens_care_clm numeric(17,2),
    doctor_visit_clm numeric(17,2),
    hosp_expens_clm numeric(17,2),
    surgeon_fee_clm numeric(17,2),
    anaesth_fee_clm numeric(17,2),
    op_theatre_clm numeric(17,2),
    room_board_paid numeric(17,2),
    intens_care_paid numeric(17,2),
    doctor_visit_paid numeric(17,2),
    hosp_expens_paid numeric(17,2),
    surgeon_fee_paid numeric(17,2),
    anaesth_fee_paid numeric(17,2),
    op_theatre_paid numeric(17,2),
    clm_aprov_amt numeric(17,2),
    total_amt_fax_claim numeric(17,2),
    other_amt numeric(17,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casclthl0023ul (
    request_id numeric,
    plan_nm varchar(50),
    pol_num varchar(10),
    ins_nm varchar(60),
    add_1 varchar(60),
    add_2 varchar(60),
    add_3 varchar(60),
    trxn_dt timestamp,
    fnd_desc varchar(200),
    trxn_typ varchar(10),
    trxn_unit numeric(20,10),
    trxn_pric numeric(20,10),
    trxn_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casclthr0023 (
    request_id numeric(10) not null,
    br_code varchar(5),
    br_nm varchar(40),
    pol_num varchar(10),
    id_num varchar(20),
    cli_name varchar(80),
    cli_name1 varchar(80),
    event_date timestamp,
    aprov_amt numeric(17,2),
    settled_dt timestamp,
    payment_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_casclthr0024 (
    request_id numeric(10) not null,
    br_code varchar(5),
    br_nm varchar(40),
    trxn_dt timestamp,
    msg1 varchar(80),
    pol_num varchar(10),
    pol_eff_df timestamp,
    xpry_dt timestamp,
    plan_code_base varchar(5),
    birth_dt timestamp,
    id_num varchar(20),
    insured_nm varchar(80),
    payo_amt numeric(14,2),
    chq_dt timestamp,
    face_amt numeric(13,2),
    face_amt_ai numeric(13,2),
    face_amt_h numeric(13,2),
    face_amt_oth numeric(13,2),
    total_face_amt numeric(13,2),
    dscnt_prem numeric(13,2),
    dscnt_prem_ai numeric(13,2),
    dscnt_prem_h numeric(13,2),
    dscnt_prem_oth numeric(13,2),
    total_dscnt_prem numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casclthr0027ul (
    request_id numeric,
    pol_num varchar(10),
    prm_chrg numeric,
    polfee numeric,
    pmgtfee numeric,
    morchrg numeric,
    fsuchrg numeric,
    dnr_amt numeric(14,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_cascothr0020 (
    cover_branch_cd varchar(5),
    submission_no varchar(20),
    withdraw_date timestamp,
    withdraw_name varchar(60),
    withdraw_no varchar(20),
    request_dt timestamp,
    tot_fy_book numeric(3),
    fr_fy_tr_no varchar(10),
    to_fy_tr_no varchar(10),
    tot_rw_book numeric(3),
    fr_rw_tr_no varchar(10),
    to_rw_tr_no varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_cascothr0021 (
    cover_agt_cd varchar(6),
    agt_sup varchar(6),
    agt_short_nm varchar(6),
    cover_branch_cd varchar(5),
    withdraw_date timestamp,
    temp_receipt_num varchar(10),
    usr_branch_cd varchar(5),
    unit_short_nm varchar(6),
    usr_agt_cd varchar(6),
    agt_stat_code varchar(2),
    agt_rcv_date timestamp,
    expiry_dt timestamp,
    acc_rcv_date timestamp,
    aging numeric(3),
    type_file varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_cascothr0022 (
    agt_sup varchar(6),
    agt_short_nm varchar(6),
    cover_agt_cd varchar(6),
    cover_branch_cd varchar(5),
    usr_branch_cd varchar(5),
    unit_short_nm varchar(6),
    usr_agt_cd varchar(6),
    withdraw_date timestamp,
    temp_receipt_num varchar(10),
    agt_stat_code varchar(2),
    agt_rcv_date timestamp,
    expiry_dt timestamp,
    acc_rcv_date timestamp,
    aging numeric(3),
    rank_cd varchar(5),
    type_file varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_cascothr0023 (
    cover_branch_cd varchar(5),
    agt_sup varchar(6),
    agt_short_nm varchar(6),
    cover_agt_cd varchar(6),
    usr_branch_cd varchar(5),
    unit_short_nm varchar(6),
    usr_agt_cd varchar(6),
    withdraw_date timestamp,
    temp_receipt_num varchar(10),
    agt_stat_code varchar(2),
    agt_rcv_date timestamp,
    expiry_dt timestamp,
    acc_rcv_date timestamp,
    aging numeric(3),
    rank_cd varchar(5),
    type_file varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_cascothr0024 (
    cover_agt_cd varchar(6),
    agt_sup varchar(6),
    agt_short_nm varchar(6),
    cover_branch_cd varchar(5),
    withdraw_date timestamp,
    agt_rcv_date timestamp,
    expiry_dt timestamp,
    tr_type varchar(1),
    fr_tr_no varchar(10),
    to_tr_no varchar(10),
    sheet numeric(3),
    agt_stat_code varchar(2),
    rank_cd varchar(5),
    type_file varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_cascothr0025 (
    unit_code_short varchar(6),
    unit_name_short varchar(80),
    unit_agt_cd varchar(6),
    unit_agt_name varchar(80),
    agt_sup varchar(6),
    agt_short_nm varchar(6),
    cover_agt_cd varchar(6),
    cover_branch_cd varchar(4),
    br_nm varchar(40),
    withdraw_date timestamp,
    agt_rcv_date timestamp,
    expiry_dt timestamp,
    tr_type varchar(1),
    fr_tr_no varchar(10),
    to_tr_no varchar(10),
    sheet numeric(3),
    agt_stat_code varchar(2),
    quantity_booklet numeric,
    quantity_sheet numeric,
    rank_cd varchar(5),
    type_file varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_cascothr0026_detail (
    cover_branch_cd varchar(4),
    agt_sup varchar(6),
    agt_short_nm varchar(6),
    unit_name varchar(80),
    cover_agt_cd varchar(6),
    agt_nm varchar(80),
    withdraw_date timestamp,
    agt_rcv_date timestamp,
    expiry_dt timestamp,
    tr_type varchar(1),
    fr_tr_no varchar(10),
    to_tr_no varchar(10),
    sheet numeric(3),
    agt_stat_code varchar(2),
    rank_cd varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.twrk_cascothr0026_header (
    cover_branch_cd varchar(4),
    withdraw_date timestamp,
    tr_type varchar(1),
    fr_tr_no varchar(10),
    to_tr_no varchar(10),
    booklet numeric(3),
    type_file varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_cascothr0027 (
    request_id numeric,
    btch_num varchar(20),
    pol_num varchar(10),
    plan_code varchar(5),
    client_nm varchar(60),
    acct_mne_cd varchar(8),
    acct_gen_amt numeric(13,2),
    br_code varchar(5),
    user__id varchar(30),
    temp_receipt_num varchar(10),
    temp_receipt_dt timestamp,
    pol_stat_cd varchar(1),
    pol_stat_desc varchar(150),
    trxn_dt timestamp,
    rep_typ varchar(1),
    reasn_code varchar(3),
    pol_susp numeric,
    pmt_susp numeric,
    resv_dnr_amt numeric
);

CREATE TABLE IF NOT EXISTS cas.twrk_cascothr0028_d (
    request_id numeric(10),
    pol_num varchar(20),
    depost_date timestamp,
    inst_type varchar(10),
    bank_type varchar(5),
    branch_id varchar(10),
    ref_no varchar(25),
    drawee_nm varchar(100),
    deposit_slip_no varchar(25),
    payment_ref varchar(25),
    inst_amt numeric(13,2),
    status_code varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_cascothr0028_h (
    request_id numeric(10),
    fr_dt timestamp,
    to_dt timestamp,
    user_id varchar(30),
    bank_cd varchar(25),
    file_name varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.twrk_cascpthr0003_01 (
    request_id numeric(10),
    request_dt timestamp,
    country_cd varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.twrk_cascpthr0003_02 (
    request_id numeric(10),
    action_dt timestamp,
    cli_num varchar(13),
    cli_nm varchar(101),
    team_code varchar(10),
    pol_num varchar(10),
    restrict_cd_1 varchar(5),
    restrict_cd_2 varchar(5),
    restrict_cd_3 varchar(5),
    restrict_desc_1 varchar(150),
    restrict_desc_2 varchar(150),
    restrict_desc_3 varchar(150),
    trxn_dt timestamp,
    eff_dt timestamp,
    trxn_typ varchar(150),
    trxn_desc varchar(200),
    trxn_amt numeric(13,2),
    pd_to_dt timestamp,
    user_id varchar(30),
    user_input_ind varchar(1),
    ur_status varchar(5),
    crcy_abbr varchar(5),
    trxn_id varchar(15),
    sort_seq varchar(15),
    print_seq numeric(10),
    payo_i_type_desc varchar(150)
);

CREATE TABLE IF NOT EXISTS cas.twrk_cascpthr0004_01 (
    request_id numeric,
    request_date timestamp,
    fr_trxn_dt timestamp,
    to_trxn_dt timestamp,
    new_iss_fr_dt timestamp,
    country_cd varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_cascpthr0004_02 (
    request_id numeric,
    cli_num varchar(13),
    cli_nm varchar(101),
    pol_num varchar(10),
    pol_eff_dt timestamp,
    plan_code_base varchar(5),
    vers_num_base varchar(5),
    pol_crcy_abbr varchar(5),
    agt_code varchar(6),
    agt_nm varchar(60),
    trxn_dt timestamp,
    trxn_type varchar(200),
    payo_crcy_abbr varchar(5),
    payo_amt_pol_crcy numeric(18,2),
    payo_amt_payo_crcy numeric(18,2),
    payo_amt_local_crcy numeric(18,2),
    payo_type_desc varchar(150),
    payo_arrange_desc varchar(150),
    user_id varchar(30),
    reasn_desc1 varchar(150),
    reasn_desc2 varchar(150),
    reasn_desc3 varchar(150)
);

CREATE TABLE IF NOT EXISTS cas.twrk_cascpthr0005 (
    run_dt timestamp not null,
    cli_num varchar(13) not null,
    pol_num varchar(10) not null,
    cv_amt numeric,
    surr_amt numeric,
    privacy_waiv varchar(1),
    all_no_us varchar(1),
    us_citizen varchar(1),
    us_perm_res varchar(1),
    us_res varchar(1),
    country varchar(80),
    nationality varchar(80)
);

CREATE TABLE IF NOT EXISTS cas.twrk_cascpthr0005_s (
    run_dt timestamp not null,
    cli_num varchar(13) not null,
    pol_num_s varchar(300),
    new_pol_fg varchar(1),
    cli_nm varchar(80),
    id_num varchar(20),
    nationality varchar(80),
    country varchar(80),
    zip_code varchar(80),
    tel_no varchar(80),
    surr_amt numeric,
    fatca_risk varchar(1),
    privacy_waiv varchar(1),
    us_citizen varchar(1),
    us_perm_res varchar(1),
    us_res varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casmdthl0001 (
    request_id numeric(10),
    wht_num varchar(10),
    wht_dt timestamp,
    gross_amt numeric(11,2),
    tax_amt numeric(11,2),
    clinic_name varchar(100),
    address varchar(250),
    addr_1 varchar(60),
    addr_2 varchar(60),
    addr_3 varchar(60),
    addr_4 varchar(60),
    zip_code varchar(6),
    wht_tax numeric(5,2),
    income_tax_num varchar(14),
    comp_nm varchar(150),
    comp_addr varchar(250),
    comp_tax_id varchar(40),
    attach_typ varchar(1),
    deduct_typ varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casmdthr0001 (
    req_num numeric(10),
    req_stat varchar(1),
    pol_num varchar(10),
    clinic_code varchar(6),
    examinee_code varchar(13),
    examinee_name varchar(60),
    med_fac_cd varchar(10),
    med_exam_dt timestamp,
    med_fees numeric(11,2),
    payee_typ_mp varchar(1),
    payee_code varchar(13),
    trxn_dt timestamp,
    trxn_status varchar(1),
    trxn_amt numeric(11,2),
    pay_rel_flag varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casmdthr0006 (
    req_num numeric(10),
    pol_num varchar(10),
    clinic_code varchar(6),
    id_num varchar(20),
    agt_code varchar(6),
    id_nm varchar(60),
    agt_nm varchar(60),
    med_fac_cd varchar(10),
    med_exam_dt timestamp,
    med_fees numeric(11,2),
    trxn_dt timestamp,
    trxn_stat varchar(1),
    trxn_amt numeric(11,2),
    pay_rel_flag varchar(1),
    query_typ_desc varchar(60)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casmdthr0009 (
    request_id numeric(10),
    ref_issue_dt varchar(15),
    wht_dt timestamp,
    wht_num varchar(10),
    descriptions varchar(100),
    clinic_name varchar(100),
    address varchar(250),
    income_tax_num varchar(14),
    wht_tax numeric(5,2),
    gross_amt numeric(11,2),
    tax_amt numeric(11,2),
    addr_1 varchar(60),
    addr_2 varchar(60),
    addr_3 varchar(60),
    addr_4 varchar(60),
    zip_code varchar(6),
    comp_nm varchar(150),
    comp_addr varchar(250),
    comp_tax_id varchar(40)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casmkthr0001_th (
    request_id numeric,
    pol_num varchar(10),
    agt_code varchar(6),
    agent_name varchar(60),
    birth_dt timestamp,
    pol_stat_cd varchar(1),
    pd_to_dt timestamp,
    plan_code_base varchar(5),
    address varchar(240),
    addr1 varchar(60),
    addr2 varchar(60),
    addr3 varchar(60),
    addr4 varchar(60),
    zipcode varchar(6),
    client_name varchar(60),
    age numeric
);

CREATE TABLE IF NOT EXISTS cas.twrk_casnbthl0002 (
    request_id numeric,
    run_dt timestamp,
    doc_crt_dt timestamp,
    pol_num varchar(10),
    pol_app_dt timestamp,
    sbmt_dt timestamp,
    dscnt_prem numeric(11,2),
    pmt_mode varchar(5),
    insured_name varchar(100),
    expiry_dt varchar(30),
    job_typ varchar(1),
    user_created varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casnbthl0008 (
    request_id numeric,
    run_dt timestamp,
    pol_num varchar(10),
    pd_to_dt varchar(30),
    doc_crt_dt varchar(30),
    expiry_dt varchar(30),
    plan_code_base varchar(5),
    insured_name varchar(100),
    payee_nm varchar(100),
    addr1 varchar(100),
    addr2 varchar(100),
    addr3 varchar(100),
    addr4 varchar(100),
    zipcode varchar(30),
    agt_nm varchar(100),
    agt_cd varchar(6),
    job_typ varchar(1),
    user_created varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casnbthl0040 (
    pol_num varchar(10),
    pol_eff_dt timestamp,
    payer_nm varchar(80),
    addr_1 varchar(80),
    addr_2 varchar(80),
    addr_3 varchar(80),
    insured_nm varchar(80),
    plan_lng_desc varchar(50),
    crcy_code varchar(2),
    face_amt numeric(13,2),
    fnd_id varchar(5),
    fnd_vers varchar(6),
    fnd_desc varchar(250),
    trxn_dt timestamp,
    trxn_amt numeric(13,2),
    fnd_trxn_desc varchar(100),
    valn_dt timestamp,
    buy_pric numeric(20,10),
    sell_pric numeric(20,10),
    trxn_unit numeric(20,10),
    tot_unit numeric(20,10),
    opn_bal numeric(20,10),
    cls_bal numeric(20,10),
    seq_no numeric(9),
    user_id varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casnbthl0041 (
    pol_num varchar(10),
    perm_mort_ratg numeric(5),
    eff_age numeric(3),
    coi_std_m numeric(13,6),
    coi_std_f numeric(13,6),
    coi_sub_m numeric(13,6),
    coi_sub_f numeric(13,6)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casnbthl0042 (
    request_id numeric,
    run_dt timestamp,
    doc_crt_dt timestamp,
    pol_num varchar(10),
    pol_app_dt timestamp,
    sbmt_dt timestamp,
    dscnt_prem numeric(11,2),
    pmt_mode varchar(5),
    insured_name varchar(100),
    expiry_dt varchar(30),
    total_day numeric,
    total_holiday numeric,
    job_typ varchar(1),
    user_created varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casnbthl0043 (
    request_id numeric,
    run_dt timestamp,
    pol_num varchar(10),
    pd_to_dt varchar(30),
    doc_crt_dt varchar(30),
    expiry_dt varchar(30),
    plan_code_base varchar(5),
    insured_name varchar(100),
    payee_nm varchar(100),
    addr1 varchar(100),
    addr2 varchar(100),
    addr3 varchar(100),
    addr4 varchar(100),
    zipcode varchar(30),
    agt_nm varchar(100),
    agt_cd varchar(6),
    total_day numeric,
    total_holiday numeric,
    job_typ varchar(1),
    user_created varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casnbthr0017tm (
    request_id numeric,
    agt_code varchar(6),
    agt_name varchar(200),
    grp_plan varchar(1),
    grp_issue numeric,
    issue varchar(100),
    sub_issue varchar(50),
    cnt_pol numeric,
    sum_prem numeric(13,2),
    sum_face numeric(13,2),
    sum_anp numeric(13,2),
    agt_typ varchar(50),
    from_dt timestamp,
    to_dt timestamp,
    ytd_anp numeric(13,2),
    user_crt varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casnbthr0033 (
    request_id numeric(10),
    from_dt timestamp,
    to_dt timestamp,
    grp_rep varchar(2),
    case0 numeric(4),
    percent0 numeric(6,2),
    case1 numeric(4),
    percent1 numeric(6,2),
    case2 numeric(4),
    percent2 numeric(6,2),
    case3 numeric(4),
    percent3 numeric(6,2),
    case4 numeric(4),
    percent4 numeric(6,2),
    case5 numeric(4),
    percent5 numeric(6,2),
    casemore5 numeric(4),
    percentmore5 numeric(6,2),
    tot_app numeric(4),
    avg_time numeric(6,2),
    submit numeric(4),
    issue numeric(4),
    issue_pend numeric(4),
    pend_memo numeric(4),
    pend_counter numeric(4),
    pend_decision numeric(4),
    ntu numeric(4),
    decline numeric(4),
    postpone numeric(4),
    miss_code numeric(4)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casnbthr0036 (
    br_code varchar(5),
    br_nm varchar(40),
    unit_code varchar(5),
    unit_nm varchar(60),
    agt_nm varchar(60),
    pol_num varchar(10),
    cli_nm varchar(60),
    pol_iss_dt timestamp,
    payo_amt numeric(14,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casnbthr0037 (
    pol_trmn_dt timestamp,
    pol_num varchar(10),
    cli_nm varchar(60),
    wa_cd_1 varchar(6),
    former_agt_nm varchar(60),
    br_code varchar(5),
    br_nm varchar(40),
    agt_code varchar(6),
    agt_nm varchar(60),
    rank_cd varchar(5),
    unit_code varchar(6),
    unit_nm varchar(60),
    pmt_mode varchar(5),
    face_amt numeric(13,2),
    dscnt_prem numeric(11,2),
    anp numeric(11,2),
    cnfrm_acpt_dt timestamp,
    comm_amt numeric(11,2),
    pol_iss_dt timestamp,
    pol_eff_dt timestamp,
    remarks varchar(100),
    hp_num varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casnbthr0038 (
    request_id numeric(10) not null,
    br_code varchar(5),
    br_nm varchar(40),
    trxn_dt timestamp,
    msg1 varchar(80),
    pol_num varchar(10),
    pol_eff_df timestamp,
    xpry_dt timestamp,
    plan_code_base varchar(5),
    birth_dt timestamp,
    id_num varchar(20),
    insured_nm varchar(80),
    payo_amt numeric(14,2),
    chq_dt timestamp,
    face_amt numeric(13,2),
    face_amt_ai numeric(13,2),
    face_amt_h numeric(13,2),
    face_amt_oth numeric(13,2),
    total_face_amt numeric(13,2),
    dscnt_prem numeric(13,2),
    dscnt_prem_ai numeric(13,2),
    dscnt_prem_h numeric(13,2),
    dscnt_prem_oth numeric(13,2),
    total_dscnt_prem numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casnbthr0039 (
    the_policy numeric,
    policy_number varchar(10) not null,
    agent_code varchar(6),
    name_the_insured_extension varchar(4000),
    insured numeric(13,2) not null,
    premium_fyp numeric(13,2) not null,
    premiums_anp numeric(13,2) not null,
    agent_insured numeric(13,2) not null,
    agent_premium_fyp numeric(13,2) not null,
    agent_premiums_anp numeric(13,2) not null,
    agent_type numeric(5,2),
    tm_insured numeric(13,2) not null,
    tm_premium_fyp numeric(13,2) not null,
    tm_premiums_anp numeric(13,2) not null,
    tm_type numeric(5,2),
    policy_issue_date timestamp,
    item varchar(1),
    item_desc varchar(20),
    id_num varchar(13),
    sign_name varchar(50),
    position varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspbthl0005 (
    request_id numeric,
    ct_asign_cli_cd varchar(40),
    chq_dt timestamp,
    pol_num varchar(10),
    insure_name varchar(60),
    payer_name varchar(60),
    agt_nm varchar(80),
    addr1 varchar(60),
    addr2 varchar(60),
    addr3 varchar(60),
    addr4 varchar(60),
    zip_code varchar(6),
    branch_nm varchar(40),
    due_date varchar(50),
    pol_yr numeric,
    pol_benf numeric,
    pl_amt numeric,
    apl_amt numeric,
    prem numeric,
    net_amt numeric,
    loan_date varchar(50),
    loan_rem numeric,
    owner_name varchar(60),
    div_benf numeric,
    gcp_benf numeric
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspbthl0022 (
    request_id numeric(10),
    cas_dt varchar(50),
    pol_num varchar(10),
    full_pd_yr numeric(3),
    pd_to_dt varchar(50),
    pay_nm varchar(90),
    ins_nm varchar(90),
    pay_addr1 varchar(60),
    pay_addr2 varchar(60),
    pay_addr3 varchar(70),
    agt_nm varchar(90),
    br_nm varchar(40),
    grace_pr varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspbthl0023 (
    request_id numeric,
    pol_num varchar(10),
    endow_amt numeric,
    acum_bal numeric,
    apl numeric,
    csh numeric,
    insure_name varchar(60),
    payer_name varchar(60),
    addr1 varchar(60),
    addr2 varchar(60),
    addr3 varchar(60),
    addr4 varchar(60),
    zip_code varchar(6),
    agt_nm varchar(80),
    br_nm varchar(40),
    last_avy_dt varchar(100),
    apl_int numeric(13,2),
    csh_int numeric(13,2),
    endow_int numeric(13,2),
    acum_int numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspbthl0024 (
    request_id numeric,
    run_date timestamp,
    user_nm varchar(70),
    pol_num varchar(10),
    xpry_dt timestamp,
    xpry_date varchar(30),
    payer_name varchar(60),
    insure_name varchar(60),
    pay_addr1 varchar(60),
    pay_addr2 varchar(60),
    pay_addr3 varchar(60),
    agt_code varchar(6),
    agt_nm varchar(70),
    br_code varchar(5),
    br_nm varchar(70),
    pol_stat_cd varchar(1),
    eti_endow numeric(13,2),
    agt_sup varchar(6),
    agt_sup_nm varchar(60),
    agt_sup_br_code varchar(5),
    agt_sup_br_nm varchar(40)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspbthl0025 (
    request_id numeric,
    cas_dt varchar(20),
    pol_num varchar(10),
    pay_nm varchar(60),
    ins_nm varchar(60),
    pay_addr1 varchar(60),
    pay_addr2 varchar(60),
    pay_addr3 varchar(60),
    agt_nm varchar(80),
    br_nm varchar(40),
    lapsed_dt varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspbthl0026 (
    request_id numeric,
    cas_dt varchar(20),
    pol_num varchar(10),
    pay_nm varchar(60),
    ins_nm varchar(60),
    pay_addr1 varchar(60),
    pay_addr2 varchar(60),
    pay_addr3 varchar(60),
    agt_nm varchar(80),
    br_nm varchar(40),
    xpry_dt varchar(20),
    surr_tot_amt numeric(15,2),
    bank_nm varchar(150),
    bank_acc_no varchar(20),
    transfer_dt varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspbthl0027 (
    request_id numeric,
    pol_num varchar(10),
    own_nm varchar(60),
    ins_nm varchar(60),
    own_addr1 varchar(60),
    own_addr2 varchar(60),
    own_addr3 varchar(60),
    agt_nm varchar(80),
    br_nm varchar(40),
    pd_to_dt varchar(40)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspbthl0028 (
    request_id numeric,
    pol_num varchar(10),
    own_nm varchar(60),
    ins_nm varchar(60),
    own_addr1 varchar(60),
    own_addr2 varchar(60),
    own_addr3 varchar(60),
    agt_nm varchar(80),
    br_nm varchar(40),
    lapse_dt varchar(40)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspbthl0029 (
    request_id numeric,
    pol_num varchar(10),
    own_nm varchar(60),
    ins_nm varchar(60),
    own_addr1 varchar(60),
    own_addr2 varchar(60),
    own_addr3 varchar(60),
    agt_nm varchar(80),
    br_nm varchar(40),
    pd_to_dt varchar(40)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspbthl0030 (
    request_id numeric,
    cas_dt varchar(20),
    pol_num varchar(10),
    pay_nm varchar(60),
    ins_nm varchar(60),
    pay_addr1 varchar(60),
    pay_addr2 varchar(60),
    pay_addr3 varchar(60),
    agt_nm varchar(80),
    br_nm varchar(40),
    pol_trmn_dt varchar(20),
    surr_tot_amt numeric(15,2),
    surr_chrg numeric(15,2),
    uneared_coi numeric(15,2),
    surr_amt numeric(15,2),
    oth_amt numeric(15,2),
    rider_prem numeric(15,2),
    net_amt numeric(15,2),
    bank_nm varchar(150),
    bank_acc_no varchar(20),
    transfer_dt varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspbthl0031 (
    request_id numeric,
    trans_dt varchar(20),
    pol_num varchar(10),
    pay_nm varchar(60),
    ins_nm varchar(60),
    pay_addr1 varchar(60),
    pay_addr2 varchar(60),
    pay_addr3 varchar(60),
    agt_nm varchar(80),
    br_nm varchar(40),
    surr_tot_amt numeric(15,2),
    surr_chrg numeric(15,2),
    net_amt numeric(15,2),
    bank_nm varchar(150),
    bank_acc_no varchar(20),
    transfer_dt varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspbthl0032 (
    request_id numeric,
    cas_dt varchar(20),
    pol_num varchar(10),
    pay_nm varchar(60),
    ins_nm varchar(60),
    pay_addr1 varchar(60),
    pay_addr2 varchar(60),
    pay_addr3 varchar(60),
    agt_nm varchar(80),
    br_nm varchar(40),
    lapse_dt varchar(20),
    surr_tot_amt numeric(15,2),
    surr_chrg numeric(15,2),
    uneared_coi numeric(15,2),
    surr_amt numeric(15,2),
    oth_amt numeric(15,2),
    rider_prem numeric(15,2),
    net_amt numeric(15,2),
    bank_nm varchar(150),
    bank_acc_no varchar(20),
    transfer_dt varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspbthl0033 (
    request_id numeric,
    pol_num varchar(10),
    own_nm varchar(60),
    ins_nm varchar(60),
    own_addr1 varchar(60),
    own_addr2 varchar(60),
    own_addr3 varchar(60),
    agt_nm varchar(80),
    br_nm varchar(40),
    lapse_dt varchar(40)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspcthl0004a (
    request_id numeric(10),
    run_dt timestamp,
    pol_num varchar(10),
    insured_name varchar(100),
    payer_name varchar(100),
    addr1 varchar(100),
    addr2 varchar(100),
    addr3 varchar(100),
    zipcode varchar(100),
    agent_name varchar(100),
    agt_code varchar(6),
    pd_to_dt timestamp,
    prem_next_due numeric(13,2),
    br_nm varchar(100),
    text_typ varchar(1),
    reject_reasn_cd varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspcthl0009a (
    request_id numeric(10),
    run_dt timestamp,
    pol_num varchar(10),
    insured_name varchar(100),
    payer_name varchar(100),
    addr1 varchar(100),
    addr2 varchar(100),
    addr3 varchar(100),
    zipcode varchar(100),
    agent_name varchar(100),
    agt_code varchar(6),
    pd_to_dt timestamp,
    prem_next_due numeric(13,2),
    reject_text varchar(100),
    reject_code varchar(2),
    br_nm varchar(100)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspcthl0016 (
    request_id numeric,
    run_date timestamp,
    rep_grp numeric(10),
    pol_num varchar(20),
    addr_1 varchar(60),
    addr_2 varchar(60),
    addr_3 varchar(60),
    addr_4 varchar(60),
    zip_code varchar(6),
    insured_nm varchar(100),
    payer_nm varchar(100),
    totyear numeric(3),
    run_year varchar(4),
    thaiyear varchar(4),
    pol_year varchar(4),
    due_date varchar(20),
    trxn_dt timestamp,
    rcpt_dt varchar(20),
    rcpt_no varchar(20),
    fran_num varchar(4),
    reverse_577 varchar(1),
    reverse_511 varchar(1),
    reverse_512 varchar(1),
    reverse_112 varchar(1),
    reasn_202 varchar(1),
    reasn_204 varchar(1),
    invalid_pol varchar(1),
    invalid_rcpt varchar(1),
    premium_paid numeric(11,2),
    basic_prem numeric(11,2),
    rider_prem numeric(11,2),
    taxable_prem numeric(13,2),
    non_taxable_prem numeric(13,2),
    agt_code varchar(6),
    user_created varchar(30),
    issued_year varchar(4),
    pmt_mode varchar(5),
    dist_chnl_cd varchar(2),
    pd_to_dt timestamp,
    trxn_id varchar(15)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspcthl0016_bk (
    request_id numeric,
    run_date timestamp,
    rep_grp numeric(10),
    pol_num varchar(20),
    addr_1 varchar(60),
    addr_2 varchar(60),
    addr_3 varchar(60),
    addr_4 varchar(60),
    zip_code varchar(6),
    insured_nm varchar(100),
    payer_nm varchar(100),
    totyear numeric(3),
    run_year varchar(4),
    thaiyear varchar(4),
    pol_year varchar(4),
    due_date varchar(20),
    trxn_dt timestamp,
    rcpt_dt varchar(20),
    rcpt_no varchar(20),
    fran_num varchar(4),
    reverse_577 varchar(1),
    reverse_511 varchar(1),
    reverse_512 varchar(1),
    reverse_112 varchar(1),
    reasn_202 varchar(1),
    reasn_204 varchar(1),
    invalid_pol varchar(1),
    invalid_rcpt varchar(1),
    premium_paid numeric(11,2),
    basic_prem numeric(11,2),
    rider_prem numeric(11,2),
    taxable_prem numeric(13,2),
    non_taxable_prem numeric(13,2),
    agt_code varchar(6),
    user_created varchar(30),
    issued_year varchar(4),
    pmt_mode varchar(5),
    dist_chnl_cd varchar(2),
    pd_to_dt timestamp,
    trxn_id varchar(15)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspcthl0016_cvg (
    request_id numeric(10),
    run_date timestamp,
    pol_num varchar(10),
    trxn_dt timestamp,
    plan_code varchar(5),
    vers_num varchar(2),
    cvg_eff_dt timestamp,
    tax_percen numeric(5,2),
    tax_typ varchar(5),
    prem_amt numeric(11,2),
    tax_amt numeric(11,2),
    trxn_id varchar(15)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspcthl0016_ul (
    request_id numeric,
    run_date timestamp,
    rep_grp numeric(10),
    pol_num varchar(20),
    addr_1 varchar(60),
    addr_2 varchar(60),
    addr_3 varchar(60),
    addr_4 varchar(60),
    zip_code varchar(6),
    insured_nm varchar(100),
    payer_nm varchar(100),
    totyear numeric(3),
    run_year varchar(4),
    thaiyear varchar(4),
    pol_year varchar(4),
    due_date varchar(20),
    trxn_dt timestamp,
    rcpt_dt varchar(20),
    rcpt_no varchar(20),
    fran_num varchar(4),
    reverse_577 varchar(1),
    reverse_511 varchar(1),
    reverse_512 varchar(1),
    reverse_112 varchar(1),
    reasn_202 varchar(1),
    reasn_204 varchar(1),
    invalid_pol varchar(1),
    invalid_rcpt varchar(1),
    premium_paid numeric(11,2),
    basic_prem numeric(11,2),
    rider_prem numeric(11,2),
    taxable_prem numeric(13,2),
    non_taxable_prem numeric(13,2),
    agt_code varchar(6),
    user_created varchar(30),
    issued_year varchar(4),
    trxn_id varchar(15)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspcthl0022 (
    request_id numeric(10),
    pol_num varchar(10),
    pol_eff_dt timestamp,
    owner_nm varchar(90),
    owner_nm_t varchar(90),
    insrd_nm varchar(90),
    insrd_nm_t varchar(90),
    pd_to_dt timestamp,
    trxn_dt timestamp,
    trxn_dt_char varchar(50),
    cvg_eff_age numeric,
    cli_num_insurd varchar(13),
    cli_num_owner varchar(13),
    addr1 varchar(50),
    addr2 varchar(50),
    addr3 varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspcthl0024 (
    request_id numeric,
    pol_num varchar(10),
    insure_name varchar(60),
    payer_name varchar(60),
    agt_nm varchar(80),
    addr1 varchar(60),
    addr2 varchar(60),
    addr3 varchar(60),
    addr4 varchar(60),
    zip_code varchar(6),
    branch_nm varchar(40),
    plan_lng_desc varchar(50),
    face_amt numeric,
    prem numeric,
    efftive_date varchar(50),
    expire_date varchar(50),
    cvg_stat_cd varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspcthl0025 (
    request_id numeric(10),
    run_dt timestamp,
    apl_date timestamp,
    payor_name varchar(100),
    addr1 varchar(100),
    addr2 varchar(100),
    addr3 varchar(100),
    zipcode varchar(10),
    pol_num varchar(10),
    insured_name varchar(100),
    pd_to_dt timestamp,
    pmt_mode varchar(5),
    premium numeric(11,2),
    apl_used numeric(11,2),
    nxt_pd_to_dt timestamp,
    off_rcpt_num numeric(10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspcthl0029 (
    request_id numeric,
    pol_num varchar(10),
    ins_nm varchar(60),
    pay_nm varchar(60),
    addr1 varchar(60),
    addr2 varchar(60),
    addr3 varchar(60),
    agent_name varchar(80),
    br_nm varchar(40),
    reiss_dt varchar(20),
    dscnt_prem numeric(15,2),
    pd_to_dt varchar(20),
    polfee numeric(15,2),
    pmgtfee numeric(15,2),
    morchrg numeric(15,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspsthl0002 (
    request_id numeric(10),
    run_dt varchar(20),
    bank_nm varchar(100),
    bank_branch varchar(100),
    bank_acct_no varchar(20),
    bank_deb_dt varchar(20),
    file_rtn_dt varchar(20),
    tot_policy numeric(5),
    tot_bill_amt numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspsthr0017 (
    run_dt timestamp,
    bill_mthd varchar(1),
    fran_num varchar(4),
    pol_num varchar(10),
    pol_crcy_code varchar(2),
    pd_to_dt timestamp,
    prem_amt numeric(11,2),
    pmt_susp numeric(11,2),
    bill_amt numeric(11,2),
    sa_cd_1 varchar(6),
    sa_cd_2 varchar(6),
    client_nm varchar(80),
    card_num varchar(20),
    card_typ varchar(1),
    card_iss_bank varchar(13),
    card_holder_id_typ varchar(1),
    card_holder_id_num varchar(20),
    card_holder_name varchar(60),
    card_xpry_dt timestamp,
    trxn_dt timestamp,
    rcc_type varchar(20),
    pol_stat_cd varchar(1),
    frez_code varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspsthr0024 (
    typ_pol varchar(10),
    bank_code varchar(20),
    pol_num varchar(10),
    c_cust_name varchar(80),
    pd_to_dt timestamp,
    trxn_amt numeric(11,2),
    bank_deb_dt timestamp,
    reject_cd varchar(10),
    card_type varchar(60),
    yr_period timestamp,
    agt_nm varchar(80),
    phone char(100)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspsthr0035 (
    request_id numeric(10),
    pol_num varchar(10),
    ins_nm varchar(90),
    sum_assured numeric(13,2),
    loan_bal numeric(13,2),
    loan_actv_dt varchar(10),
    ov_cv_loan_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspsthr0036 (
    request_id numeric,
    br_code varchar(5),
    pol_num varchar(10),
    agt_code varchar(6),
    agt_nm varchar(70),
    ret_to_agt_nm varchar(70),
    rpt_to_grp varchar(70),
    plan_code_base varchar(5),
    insure_name varchar(60),
    address varchar(250),
    avy timestamp,
    policy_status varchar(150),
    pmt_mode varchar(5),
    policy_yr numeric,
    prem numeric,
    gcp_option varchar(70),
    face_amt numeric(13,2),
    apl numeric(13,2),
    pl numeric(13,2),
    gcp_type_paying varchar(10),
    gcp numeric(13,2),
    mat numeric(13,2),
    flag varchar(10),
    cnt_all_br numeric,
    sum_apl_all_br numeric(13,2),
    sum_pl_all_br numeric(13,2),
    sum_gcp_all_br numeric(13,2),
    sum_mat_all_br numeric(13,2),
    group_code varchar(6),
    group_nm varchar(70)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspsthr0037 (
    group_mg_code varchar(6),
    group_mg_name varchar(80),
    agt_code varchar(6),
    pol_num varchar(10),
    cli_name varchar(80),
    addr varchar(250),
    pol_eff_dt timestamp,
    pd_to_dt timestamp,
    pol_yr_pr varchar(10),
    dscnt_prem numeric,
    pmt_mode varchar(5),
    bill_mthd varchar(80),
    br_code varchar(6),
    br_nm varchar(40),
    agt_nm varchar(80),
    ret_to_agt_nm varchar(100),
    rpt_to_grp varchar(6),
    plan_code_base varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspsthr0040 (
    request_id numeric,
    pol_num varchar(10),
    trxn_dt timestamp,
    fnd_id varchar(5),
    fnd_desc varchar(200),
    fndcrcy_amt numeric(13,2),
    trxn_unit numeric(20,10),
    fnd_trxn_pric numeric(20,10),
    prces_dt timestamp,
    surr_chrg numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspsthr0041 (
    request_id numeric,
    cas_dt timestamp,
    pol_num varchar(10),
    plan_code varchar(5),
    pd_to_dt timestamp,
    last_pd_to_dt timestamp,
    mvy_ded_to_dt timestamp,
    ins_nm varchar(60),
    addr1 varchar(60),
    addr2 varchar(60),
    addr3 varchar(60),
    tel_no varchar(40),
    bill_mthd varchar(25),
    pmt_mode varchar(10),
    dscnt_prem numeric,
    pol_yr numeric,
    pol_period numeric,
    chrg_amt_per_m numeric(15,5),
    av_balance numeric(15,5),
    last_fnd_mvm_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspsthr0043 (
    request_id numeric,
    pol_num varchar(10),
    pol_eff_dt timestamp,
    pd_to_dt timestamp,
    xpry_dt timestamp,
    pol_trmn_dt timestamp,
    pmt_mode varchar(5),
    pay_nm varchar(60),
    assignname varchar(81),
    pol_stat_cd varchar(1),
    plan varchar(8),
    face_amt numeric(13,2),
    polyr numeric,
    totloan numeric,
    interest numeric,
    interestdt timestamp,
    eti_endow numeric,
    restrict_cd_1 varchar(5),
    restrict_cd_2 varchar(5),
    restrict_cd_3 varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.twrk_caspsthr0044 (
    request_id numeric,
    trxn_id varchar(15),
    trxn_dt timestamp,
    pol_num varchar(10),
    ins_nm varchar(60),
    pol_eff_dt timestamp,
    fnd_desc varchar(200),
    trxn_typ varchar(10),
    trxn_desc varchar(80),
    trxn_unit numeric(20,10),
    trxn_pric numeric(20,10),
    trxn_amt numeric(13,2),
    addr_1 varchar(80),
    addr_2 varchar(80),
    addr_3 varchar(80),
    payer_nm varchar(80),
    plan_lng_desc varchar(50),
    face_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casraa03hk (
    request_id numeric(10),
    pol_num varchar(10),
    insrd_nm varchar(120),
    agt_nm_new varchar(120),
    bus_phone varchar(20),
    endos_dt timestamp,
    owner_nm varchar(120),
    addr_1 varchar(60),
    addr_2 varchar(60),
    addr_3 varchar(60),
    addr_4 varchar(60),
    team_code varchar(10),
    br_code varchar(5),
    agt_code varchar(6),
    loc_desc varchar(20),
    copy_stamp varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrac01hk (
    request_id numeric(10),
    request_date timestamp,
    period_date timestamp,
    valn_dt timestamp,
    plan_code varchar(5),
    crcy_abbr varchar(5),
    legal_id varchar(5),
    acct_num varchar(8),
    debit_amt numeric(13,2),
    credit_amt numeric(13,2),
    balance numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrac02hk (
    request_id numeric(10),
    request_date timestamp,
    period_date timestamp,
    acct_num varchar(8),
    acc_desc varchar(100),
    division varchar(10),
    terr_cd varchar(2),
    legal_id varchar(5),
    lob varchar(2),
    pi varchar(1),
    crcy_abbr varchar(5),
    trxn_code varchar(8),
    trxn_date timestamp,
    reasn_code varchar(3),
    system varchar(10),
    user_id varchar(30),
    report_no numeric(3),
    fund_id varchar(2),
    pol_num varchar(10),
    pdt varchar(5),
    reins_ind varchar(1),
    trxn_amt numeric(13,2),
    par_signal varchar(1),
    open_flag varchar(5),
    sch_code varchar(5),
    bank_id varchar(5),
    branch varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrac04hk (
    request_id numeric(10),
    request_date timestamp,
    period_date timestamp,
    acct_num varchar(8),
    acc_desc varchar(100),
    division varchar(10),
    terr_cd varchar(2),
    legal_id varchar(5),
    lob varchar(2),
    pi varchar(1),
    crcy_abbr varchar(5),
    trxn_code varchar(8),
    trxn_date timestamp,
    reasn_code varchar(3),
    system varchar(10),
    user_id varchar(30),
    report_no numeric(3),
    fund_id varchar(2),
    pol_num varchar(10),
    pdt varchar(5),
    reins_ind varchar(1),
    trxn_amt numeric(13,2),
    par_signal varchar(1),
    open_flag varchar(5),
    sch_code varchar(5),
    bank_id varchar(5),
    branch varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrac05hk (
    request_id numeric(10),
    request_date timestamp,
    period_date timestamp,
    acct_num varchar(8),
    acc_desc varchar(100),
    division varchar(10),
    terr_cd varchar(2),
    legal_id varchar(5),
    lob varchar(2),
    pi varchar(1),
    crcy_abbr varchar(5),
    trxn_code varchar(8),
    trxn_date timestamp,
    reasn_code varchar(3),
    system varchar(5),
    user_id varchar(30),
    report_no numeric(3),
    fund_id varchar(2),
    pol_num varchar(10),
    pdt varchar(5),
    reins_ind varchar(1),
    trxn_amt numeric(13,2),
    par_signal varchar(1),
    open_flag varchar(5),
    sch_code varchar(5),
    bank_id varchar(5),
    branch varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrac07hk (
    request_id numeric(10),
    request_date timestamp,
    period_date timestamp,
    aex_num numeric(8),
    acct_num varchar(8),
    acc_desc varchar(100),
    division varchar(10),
    terr_cd varchar(2),
    legal_id varchar(5),
    lob varchar(2),
    pi varchar(1),
    crcy_abbr varchar(5),
    trxn_code varchar(8),
    trxn_date timestamp,
    eff_date timestamp,
    valu_date timestamp,
    reasn_code varchar(3),
    system varchar(10),
    user_id varchar(30),
    report_no numeric(3),
    fund_id varchar(2),
    pol_num varchar(10),
    pdt varchar(5),
    reins_ind varchar(1),
    trxn_amt numeric(13,2),
    par_signal varchar(1),
    open_flag varchar(5),
    sch_code varchar(5),
    bank_id varchar(5),
    branch varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrap06hk (
    request_id numeric(10),
    debit_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrap06hk_atp (
    request_id numeric(10),
    pol_crcy varchar(5),
    pol_num varchar(10),
    bank_acct_num varchar(20),
    client_nm varchar(60),
    reject_reasn varchar(150),
    pol_crcy_prem numeric(11,2),
    prem numeric(11,2),
    exchg_rt numeric(18,8)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casray01dhk (
    request_id numeric(10),
    rtn_dt timestamp,
    prt_dt timestamp,
    acpt_ctr numeric(4),
    rjct_ctr numeric(4)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casray01dhk_dtl (
    request_id numeric(10),
    verify_stat_cd varchar(2),
    verify_stat_desc varchar(150),
    pol_num varchar(10),
    acct_num varchar(15),
    acct_nm varchar(20),
    eff_dt timestamp,
    msg varchar(60)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrbl01hk_01 (
    request_id numeric(10),
    pol_num varchar(10),
    insrd_nm varchar(60),
    owner_nm varchar(60),
    owner_addr_1 varchar(60),
    owner_addr_2 varchar(60),
    owner_addr_3 varchar(60),
    owner_addr_4 varchar(60),
    notice_dt timestamp,
    pol_eff_dt timestamp,
    pol_crcy_abbr varchar(5),
    agt_code varchar(6),
    agt_nm varchar(60),
    agt_team_code varchar(10),
    agt_bus_phone varchar(20),
    br_code varchar(5),
    loc_desc varchar(20),
    pmt_mode_desc varchar(150),
    prem_bill numeric(11,2),
    pd_to_dt timestamp,
    exchg_crcy_abbr varchar(5),
    exchg_rt numeric(18,8),
    prem_bill_hkd numeric(11,2),
    asign_nm varchar(60),
    asign_addr_1 varchar(60),
    asign_addr_2 varchar(60),
    asign_addr_3 varchar(60),
    asign_addr_4 varchar(60),
    last_print_dt timestamp,
    query_code varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrcl01hk_01 (
    request_id numeric(10),
    request_dt timestamp,
    report_no numeric(10),
    trxn_dt timestamp,
    btch_num varchar(20),
    btch_typ_desc varchar(150),
    col_crcy varchar(2),
    col_trxn_amt numeric(11,2),
    trxn_crcy varchar(2),
    trxn_amt numeric(11,2),
    exchg_rt numeric(18,8)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrcl02hk_01 (
    request_id numeric(10),
    request_dt timestamp,
    pol_num varchar(10),
    pol_crcy varchar(2),
    pol_stat_cd varchar(1),
    trxn_dt timestamp,
    trxn_amt numeric(11,2),
    btch_dtl_stat_cd varchar(1),
    col_crcy_code varchar(2),
    col_reasn_code varchar(3),
    col_eff_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrdb03hk (
    request_id numeric(10),
    request_date timestamp,
    acct_num varchar(8),
    period_date timestamp,
    acc_desc varchar(100),
    division varchar(10),
    terr_cd varchar(2),
    legal_id varchar(5),
    lob varchar(2),
    pi varchar(1),
    crcy_abbr varchar(5),
    trxn_code varchar(8),
    trxn_date timestamp,
    reasn_code varchar(3),
    system varchar(10),
    user_id varchar(30),
    report_no numeric(3),
    fund_id varchar(2),
    pol_num varchar(10),
    pdt varchar(5),
    reins_ind varchar(1),
    trxn_amt numeric(13,2),
    par_signal varchar(1),
    open_flag varchar(5),
    sch_code varchar(5),
    bank_id varchar(5),
    branch varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrms06hk (
    request_id numeric(10),
    request_date timestamp,
    trxn_dt_fr timestamp,
    trxn_dt_to timestamp,
    team_code varchar(10),
    susp_typ varchar(10),
    susp_desc varchar(150),
    pol_num varchar(10),
    trxn_dt timestamp,
    eff_dt timestamp,
    pol_crcy varchar(5),
    trxn_amt numeric(11,2),
    pend_days numeric(5),
    frez_code varchar(1),
    pd_to_dt timestamp,
    mode_prem numeric(11,2),
    pmt_mode varchar(150),
    susp_reasn varchar(150)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrnb01hk (
    request_id numeric(10),
    request_dt timestamp,
    pol_num varchar(10),
    cli_nm varchar(101),
    addr_1 varchar(40),
    addr_2 varchar(40),
    addr_3 varchar(40),
    addr_4 varchar(40)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrnb04hk (
    request_id numeric(10),
    request_date timestamp,
    team_code varchar(10),
    user_name varchar(40),
    pol_iss_dt timestamp,
    frez_code varchar(1),
    pol_num varchar(10),
    crcy_code varchar(2),
    crcy_code_desc varchar(5),
    cli_nm varchar(60),
    pol_susp numeric(13,2),
    agt_code varchar(6),
    agt_nm varchar(40),
    br_code varchar(5),
    loc_code varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps01ahk (
    request_id numeric(10),
    pol_num varchar(10),
    owner_nm varchar(40),
    insrd_nm varchar(40),
    pol_eff_dt timestamp,
    crcy_abbr varchar(5),
    db_opt_desc varchar(20),
    mode_prem numeric(11,2),
    mode_desc varchar(10),
    chg_eff_dt timestamp,
    team_code varchar(10),
    br_code varchar(5),
    agt_code varchar(6),
    loc_desc varchar(20),
    endos_dt timestamp,
    copy_stamp varchar(20),
    rpt_layout_mthd varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps01bhk (
    request_id numeric(10),
    pol_num varchar(10),
    owner_nm varchar(120),
    insrd_nm varchar(120),
    pol_eff_dt timestamp,
    crcy_abbr varchar(5),
    db_desc varchar(50),
    plan_prem numeric(11,2),
    mode_desc varchar(10),
    reins_dt timestamp,
    endos_dt timestamp,
    team_code varchar(10),
    br_code varchar(5),
    agt_code varchar(6),
    loc_desc varchar(20),
    copy_stamp varchar(20),
    rpt_layout_mthd varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps01chk (
    request_id numeric(10),
    seq_id numeric(10),
    pol_num varchar(10),
    owner_nm varchar(101),
    insrd_nm varchar(101),
    pol_eff_dt timestamp,
    crcy_abbr varchar(5),
    db_desc varchar(50),
    prem numeric(11,2),
    mode_desc varchar(10),
    endos_dt timestamp,
    eff_dt timestamp,
    team_code varchar(10),
    br_code varchar(5),
    agt_code varchar(6),
    loc_desc varchar(20),
    copy_stamp varchar(20),
    rpt_layout_mthd varchar(5),
    query_code varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps01chk_curr (
    seq_id numeric(10),
    pol_num varchar(10),
    seq_num numeric(10),
    trxn_dt timestamp,
    eff_dt timestamp,
    old_crcy_abbr varchar(5),
    new_crcy_abbr varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps01chk_cvg (
    seq_id numeric(10),
    pol_num varchar(10),
    seq_num numeric(10),
    plan_code varchar(5),
    vers_num varchar(2),
    plan_lng_desc varchar(50),
    plan_native_desc varchar(200),
    face_amt varchar(20),
    cvg_prem numeric(11,2),
    xpry_dt timestamp,
    excls_cls varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps01chk_db_opt (
    seq_id numeric(10),
    pol_num varchar(10),
    seq_num numeric(10),
    trxn_dt timestamp,
    eff_dt timestamp,
    old_db_opt_desc varchar(20),
    new_db_opt_desc varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps01chk_face_amt (
    seq_id numeric(10),
    pol_num varchar(10),
    seq_num numeric(10),
    trxn_dt timestamp,
    eff_dt timestamp,
    plan_code varchar(5),
    vers_num varchar(2),
    plan_lng_desc varchar(50),
    plan_native_desc varchar(200),
    old_crcy_abbr varchar(5),
    new_crcy_abbr varchar(5),
    old_face_amt numeric(13,2),
    new_face_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps01chk_hb (
    seq_id numeric(10),
    pol_num varchar(10),
    seq_num numeric(10),
    trxn_dt timestamp,
    eff_dt timestamp,
    old_plan_code varchar(5),
    old_plan_lng_desc varchar(50),
    old_no_insured varchar(2),
    old_major_mdeical varchar(50),
    new_plan_code varchar(5),
    new_plan_lng_desc varchar(50),
    new_no_insured varchar(2),
    new_major_mdeical varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps01chk_iio_opt (
    seq_id numeric(10),
    pol_num varchar(10),
    seq_num numeric(10),
    trxn_dt timestamp,
    eff_dt timestamp,
    old_iio_opt_desc varchar(20),
    old_iio_percent numeric(5,2),
    new_iio_opt_desc varchar(20),
    new_iio_percent numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps01chk_rbp_prem (
    seq_id numeric(10),
    pol_num varchar(10),
    seq_num numeric(10),
    trxn_dt timestamp,
    eff_dt timestamp,
    old_crcy_abbr varchar(5),
    new_crcy_abbr varchar(5),
    old_prem_rbp numeric(11,2),
    new_prem_rbp numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps01chk_rider (
    seq_id numeric(10),
    pol_num varchar(10),
    seq_num numeric(10),
    action_code varchar(10),
    trxn_dt timestamp,
    eff_dt timestamp,
    plan_code varchar(5),
    vers_num varchar(2),
    plan_lng_desc varchar(50),
    plan_native_desc varchar(200)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps01chk_risk_excl (
    seq_id numeric(10),
    pol_num varchar(10),
    seq_num numeric(10),
    trxn_dt timestamp,
    eff_dt timestamp,
    plan_code varchar(5),
    vers_num varchar(2),
    plan_lng_desc varchar(50),
    plan_native_desc varchar(200),
    old_excl_clause varchar(200),
    new_excl_clause varchar(200)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps01chk_risk_flat (
    seq_id numeric(10),
    pol_num varchar(10),
    seq_num numeric(10),
    trxn_dt timestamp,
    eff_dt timestamp,
    plan_code varchar(5),
    vers_num varchar(2),
    plan_lng_desc varchar(50),
    plan_native_desc varchar(200),
    old_flat_prem numeric(11,2),
    old_flat_dur numeric(3),
    new_flat_prem numeric(11,2),
    new_flat_dur numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps01chk_risk_occp (
    seq_id numeric(10),
    pol_num varchar(10),
    seq_num numeric(10),
    trxn_dt timestamp,
    eff_dt timestamp,
    plan_code varchar(5),
    vers_num varchar(2),
    plan_lng_desc varchar(50),
    plan_native_desc varchar(200),
    old_occp_clas_desc varchar(20),
    new_occp_clas_desc varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps01chk_risk_percent (
    seq_id numeric(10),
    pol_num varchar(10),
    seq_num numeric(10),
    trxn_dt timestamp,
    eff_dt timestamp,
    plan_code varchar(5),
    vers_num varchar(2),
    plan_lng_desc varchar(50),
    plan_native_desc varchar(200),
    old_precent_prem numeric(11,2),
    old_precent_dur numeric(3),
    new_precent_prem numeric(11,2),
    new_precent_dur numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps01chk_risk_rcc (
    seq_id numeric(10),
    pol_num varchar(10),
    seq_num numeric(10),
    trxn_dt timestamp,
    eff_dt timestamp,
    plan_code varchar(5),
    vers_num varchar(2),
    plan_lng_desc varchar(50),
    plan_native_desc varchar(200),
    old_rcc_desc varchar(20),
    new_rcc_desc varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps01chk_risk_smok (
    seq_id numeric(10),
    pol_num varchar(10),
    seq_num numeric(10),
    trxn_dt timestamp,
    eff_dt timestamp,
    plan_code varchar(5),
    vers_num varchar(2),
    plan_lng_desc varchar(50),
    plan_native_desc varchar(200),
    old_smkr_desc varchar(20),
    new_smkr_desc varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps01chk_rtu_plan_prem (
    seq_id numeric(10),
    pol_num varchar(10),
    seq_num numeric(10),
    trxn_dt timestamp,
    eff_dt timestamp,
    old_crcy_abbr varchar(5),
    new_crcy_abbr varchar(5),
    old_prem numeric(11,2),
    new_prem numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps02ahk (
    request_id numeric(10),
    pol_num varchar(10),
    insrd_nm varchar(120),
    chg_eff_dt timestamp,
    pmt_mode_old varchar(50),
    pmt_mode_new varchar(50),
    bill_mthd_old varchar(50),
    bill_mthd_new varchar(50),
    mode_prem_crcy varchar(5),
    mode_prem numeric(11,2),
    mode_desc varchar(10),
    endos_dt timestamp,
    owner_nm varchar(120),
    addr_1 varchar(60),
    addr_2 varchar(60),
    addr_3 varchar(60),
    addr_4 varchar(60),
    agt_code varchar(6),
    agt_nm varchar(120),
    loc_desc varchar(20),
    bus_phone varchar(20),
    br_code varchar(5),
    team_code varchar(10),
    copy_stamp varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps02bhk (
    request_id numeric(10),
    pol_num varchar(10),
    insrd_nm varchar(120),
    endos_dt timestamp,
    owner_nm varchar(120),
    addr_1 varchar(60),
    addr_2 varchar(60),
    addr_3 varchar(60),
    addr_4 varchar(60),
    agt_nm varchar(120),
    loc_desc varchar(20),
    bus_phone varchar(20),
    team_code varchar(10),
    copy_stamp varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps02bhk_bnfy (
    request_id numeric(10),
    pol_num varchar(10),
    seq_num numeric(10),
    bnfy_nm varchar(120),
    bnfy_typ varchar(50),
    bnfy_prty varchar(20),
    bnfy_pct numeric(5,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps02chk (
    request_id numeric(10),
    pol_num varchar(10),
    insrd_nm varchar(120),
    chg_typ varchar(50),
    assgn_nm varchar(120),
    assgn_dt timestamp,
    endos_dt timestamp,
    owner_nm varchar(120),
    addr_1 varchar(60),
    addr_2 varchar(60),
    addr_3 varchar(60),
    addr_4 varchar(60),
    agt_nm varchar(120),
    loc_desc varchar(20),
    bus_phone varchar(20),
    team_code varchar(10),
    copy_stamp varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps03ahk (
    request_id numeric(10),
    pol_num varchar(10),
    owner_nm varchar(40),
    insrd_nm varchar(40),
    pol_eff_dt timestamp,
    crcy_abbr varchar(5),
    mode_prem numeric(11,2),
    pmt_mode_desc varchar(50),
    assgn_nm varchar(40),
    endos_dt timestamp,
    team_code varchar(10),
    br_code varchar(5),
    agt_code varchar(6),
    loc_desc varchar(20),
    copy_stamp varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps03ahk_bnfy (
    request_id numeric(10),
    pol_num varchar(10),
    bnfy_prty_seq numeric(3),
    bnfy_nm varchar(40),
    bnfy_rel varchar(150),
    bnfy_prty varchar(1),
    bnfy_pct numeric(5,2),
    bnfy_code varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps03ahk_cvg (
    request_id numeric(10),
    pol_num varchar(10),
    seq_num numeric(3),
    plan_code varchar(5),
    plan_lng_desc varchar(50),
    plan_native_desc varchar(200),
    face_amt numeric(13,2),
    cvg_prem numeric(13,2),
    expiry_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps03bhk (
    request_id numeric(10),
    pol_num varchar(10),
    owner_nm varchar(40),
    insrd_nm varchar(40),
    pol_eff_dt timestamp,
    crcy_abbr varchar(5),
    mode_prem numeric(11,2),
    pmt_mode_desc varchar(50),
    assgn_nm varchar(40),
    endos_dt timestamp,
    team_code varchar(10),
    br_code varchar(5),
    agt_code varchar(6),
    loc_desc varchar(20),
    copy_stamp varchar(20),
    db_opt varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps03bhk_bnfy (
    request_id numeric(10),
    pol_num varchar(10),
    bnfy_prty_seq numeric(3),
    bnfy_nm varchar(40),
    bnfy_rel varchar(150),
    bnfy_prty varchar(1),
    bnfy_pct numeric(5,2),
    bnfy_code varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.twrk_casrps03bhk_cvg (
    request_id numeric(10),
    pol_num varchar(10),
    seq_num numeric(3),
    plan_code varchar(5),
    plan_lng_desc varchar(50),
    plan_native_desc varchar(200),
    face_amt numeric(13,2),
    cvg_prem numeric(13,2),
    expiry_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_casulthr0001 (
    pol_num varchar(10),
    insured_nm varchar(60),
    plan_code varchar(5),
    vers_num varchar(2),
    pol_iss_dt timestamp,
    pd_to_dt timestamp,
    pmt_mode varchar(5),
    face_amt numeric(13,2),
    dscnt_prem numeric(11,2),
    trxn_dt timestamp,
    fnd_trxn_desc varchar(80),
    buy_amt numeric(13,2),
    buy_unit numeric(20,10),
    sell_amt numeric(13,2),
    sell_unit numeric(20,10),
    cnfrm_acpt_dt timestamp,
    fnd_id varchar(5),
    fnd_vers varchar(6),
    fnd_trxn_cd varchar(3),
    reasn_cd varchar(3),
    deal_basis varchar(1),
    trxn_pct numeric(5,2),
    user_id varchar(30),
    dept_cd varchar(3),
    ul_typ varchar(1),
    pi_user_id varchar(30),
    pi_dept_cd varchar(3),
    seq_no numeric(9),
    sun_t3cd varchar(10),
    fnd_in varchar(5),
    fnd_in_vers varchar(6)
);

CREATE TABLE IF NOT EXISTS cas.twrk_cheque_extract (
    crcy_abbr varchar(3) not null,
    team_num varchar(2) not null,
    user_id varchar(30) not null,
    cli_nm varchar(40) not null,
    cli_id varchar(10) not null,
    pol_num_line varchar(100) not null,
    payo_amt numeric(13,2) not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_cis_cm01 (
    br_code varchar(5),
    unit_code varchar(5),
    loc_code varchar(10),
    agt_code varchar(5),
    agt_nm varchar(40),
    fran_num varchar(4),
    pol_num varchar(10),
    owner varchar(40),
    insured varchar(40),
    birth_dt timestamp,
    cntct_dt timestamp,
    cntct_reasn varchar(30),
    address varchar(200),
    prim_phone varchar(20),
    othr_phone varchar(20),
    pol_eff_dt timestamp,
    face_amt numeric(13,2),
    base_plan varchar(5),
    has_rider varchar(1),
    pmt_mthd varchar(20),
    dscnt_prem numeric(11,2),
    pmt_mode varchar(20),
    pd_to_dt timestamp,
    has_loan varchar(1),
    pol_trmn_dt timestamp,
    reinstat_prem numeric,
    reinstat_dt timestamp,
    agt_comm numeric,
    pol_stat_cd varchar(1),
    cnfrm_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_claim_pending_cd_id (
    curr_user varchar(30),
    pol_num varchar(10),
    seq_num numeric(4),
    clm_pend_cd varchar(3),
    comments_dt timestamp,
    user_id varchar(30),
    comments varchar(1000),
    comnt_seq_num numeric(10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_clm_history_search_th (
    seq numeric,
    user_logon varchar(80),
    system_typ varchar(10),
    pol_num varchar(10),
    cli_num varchar(13),
    cli_nm varchar(60),
    id_num varchar(20),
    seq_num numeric,
    clm_hosp_begin_dt timestamp,
    clm_hosp_end_dt timestamp,
    days_of_treat_curr numeric,
    clm_stat_code varchar(5),
    clm_stat_desc varchar(150),
    hospital_name varchar(100),
    diagnose varchar(500),
    type_clm varchar(100),
    num_days_disab numeric,
    perm_pct numeric,
    calc_clm_amt numeric
);

CREATE TABLE IF NOT EXISTS cas.twrk_cmp_base (
    request_id numeric(10),
    pol_num varchar(10),
    seq_num numeric(3),
    pol_year numeric(3),
    age numeric(3),
    gcv numeric(13),
    cc numeric(13),
    year_prem numeric(13,2),
    div numeric(13)
);

CREATE TABLE IF NOT EXISTS cas.twrk_cmp_cvg (
    request_id numeric(10),
    pol_num varchar(10),
    seq_num numeric(3),
    cvg_typ varchar(1),
    rider_seq_num numeric(3),
    description varchar(100),
    face_amt numeric(13,2),
    sub_desc varchar(100),
    is_cdd varchar(1),
    is_last varchar(1),
    mode_prem numeric(11,2),
    year_prem numeric(11,2),
    is_level varchar(1),
    plan_code varchar(5),
    is_first varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_cmp_prem (
    request_id numeric(10),
    pol_num varchar(10),
    rider_seq_num numeric(3),
    seq_num numeric(3),
    pol_year varchar(5),
    age varchar(5),
    mode_prem numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_collection_dtl (
    run_seq numeric(9) not null,
    btch_num varchar(20) not null,
    btch_role varchar(2) not null,
    pol_num varchar(10) not null,
    cbd_num numeric(4) not null,
    eff_dt timestamp not null,
    trxn_dt timestamp not null,
    trxn_cd varchar(8) not null,
    reasn_code varchar(3) not null,
    trxn_amt numeric(11,2) not null,
    remarks varchar(100),
    btch_dtl_stat_cd varchar(1),
    result_cd varchar(5),
    collect_dt timestamp,
    check_amt numeric(13,2),
    check_num varchar(8),
    credit_num varchar(16),
    iss_bank varchar(30),
    indirect varchar(1),
    receipt_num varchar(7),
    pd_to_dt timestamp,
    pmt_mode varchar(5),
    trxn_id varchar(15),
    clr_cd varchar(2),
    bank_cd varchar(13),
    chq_no_text varchar(20),
    chq_dt timestamp,
    off_rcpt_num numeric(10),
    col_crcy_code varchar(2),
    col_trxn_amt numeric(11,2),
    exchg_rt numeric(18,8),
    report_no numeric(3),
    acct_mne_cd varchar(8),
    card_xpry_dt varchar(4),
    dnr_reasn_code varchar(10),
    csms_btch_num varchar(3),
    btch_seq_no numeric(5)
);

CREATE TABLE IF NOT EXISTS cas.twrk_collection_fnd_dtl (
    run_seq numeric(9) not null,
    btch_num varchar(20) not null,
    btch_role varchar(2) not null,
    trxn_dt timestamp not null,
    pol_num varchar(10) not null,
    cbd_num numeric(4) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    deal_basis varchar(1),
    deal_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_collection_hdr (
    run_seq numeric(9) not null,
    btch_num varchar(20) not null,
    btch_role varchar(2) not null,
    trxn_dt timestamp not null,
    btch_typ varchar(4),
    btch_tot numeric(13,2),
    crcy_code varchar(2),
    btch_stat_code varchar(1),
    recpt_stat_code varchar(1),
    user_id varchar(30),
    btch_dt timestamp,
    dist_chnl_cd varchar(2),
    off_loc_cd varchar(5),
    where_cpf varchar(100),
    w_button varchar(1),
    bank_code varchar(6),
    file_name varchar(20),
    ti_eff_dt timestamp,
    dt_fmt varchar(10),
    cn_bal_sw varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_comm_prepaid_th (
    asof_dt timestamp,
    pol_num varchar(10),
    pol_eff_dt timestamp,
    last_avy_dt timestamp,
    pd_to_dt timestamp,
    pmt_mode varchar(2),
    dscnt_prem numeric(11,2),
    comm_rt numeric(8,5),
    total_comm_pd numeric(11,2),
    comm_prepaid numeric(11,2),
    acru_prem_comm numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_contest (
    br_code varchar(5),
    br_mgr_cd varchar(5),
    un_code varchar(5),
    un_mgr_cd varchar(5),
    agt_code varchar(6),
    agt_name varchar(20),
    agt_stat_cd varchar(2),
    mkt_case numeric(5,1),
    comm_earn numeric(9,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_credit_card (
    trxn_dt timestamp not null,
    pol_num varchar(10) not null,
    pd_to_dt timestamp not null,
    pol_eff_dt timestamp,
    period_yy numeric(2),
    period_mm numeric(2),
    pmt_mode varchar(2),
    pmt_mode_desc varchar(10),
    bill_mthd varchar(2),
    bill_mthd_desc varchar(10),
    insrd_cli_num varchar(10),
    insrd_cli_nm varchar(20),
    plan_code varchar(5),
    plan_code_desc varchar(30),
    mode_prem numeric(11,2),
    dscnt_prem numeric(11,2),
    pmt_susp numeric(11,2),
    prem_bill numeric(11,2),
    pol_pd_to_dt timestamp,
    pol_pmt_mode varchar(2),
    pol_mode_prem numeric(11,2),
    pol_dscnt_prem numeric(11,2),
    pol_pmt_susp numeric(11,2),
    agt_code varchar(5),
    agt_nm varchar(10),
    br_code varchar(10),
    br_nm varchar(20),
    br_phone varchar(20),
    pac_bk_ctr varchar(1),
    credit_card_owner varchar(30),
    credit_card_no varchar(19),
    credit_card_yymm varchar(6),
    credit_card_bank_cd varchar(3),
    credit_card_bank_desc varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.twrk_crrs (
    crr_num numeric(15),
    pol_num varchar(10),
    agt_code varchar(6),
    reasn_cd varchar(3),
    prem_amt numeric(11,2),
    comm_amt numeric(11,2),
    pc_amt numeric(9),
    case_ctr numeric(5,2),
    splt_rt numeric(6,2),
    colct_dt timestamp,
    plan_code varchar(5),
    vers_num varchar(2),
    insrd_nm varchar(60),
    pd_to_dt timestamp,
    submt_dt timestamp,
    iss_dt timestamp,
    restr_case_cnt_ind varchar(2),
    pol_eff_dt timestamp,
    mode_num numeric(3),
    mode_freq varchar(2),
    prod_code varchar(5),
    crr_trxn_dt timestamp,
    fyip_amt numeric(11,2),
    fyrp_amt numeric(11,2),
    ryp_amt numeric(11,2),
    fyic_amt numeric(11,2),
    fyrc_amt numeric(11,2),
    rcomm_amt numeric(11,2),
    afyc_amt numeric(9),
    lafyc_amt numeric(9),
    lafyc13_amt numeric(9),
    ncase_ctr numeric(5,2),
    lcase_ctr numeric(5,2),
    lcase13_ctr numeric(5,2),
    bill_mthd varchar(1),
    fran_num varchar(5),
    crcy_cd varchar(2),
    pmt_mode varchar(2),
    sngl_prem_ind varchar(1),
    local_db_ind varchar(1),
    orph_asign_ind varchar(1),
    ins_rel_to_agt varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_crrs_hk (
    crr_num numeric(15) not null,
    pol_num varchar(10) not null,
    agt_code varchar(6) not null,
    reasn_cd varchar(3) not null,
    prem_amt numeric(11,2) not null,
    comm_amt numeric(11,2) not null,
    pc_amt numeric(9) not null,
    case_ctr numeric(5,2) not null,
    splt_rt numeric(6,2) not null,
    colct_dt timestamp,
    plan_code varchar(5),
    vers_num varchar(2),
    insrd_nm varchar(60) not null,
    pd_to_dt timestamp not null,
    submt_dt timestamp not null,
    iss_dt timestamp,
    restr_case_cnt_ind varchar(2),
    pol_eff_dt timestamp not null,
    mode_num numeric(3),
    mode_freq varchar(2),
    prod_code varchar(5),
    crr_trxn_dt timestamp not null,
    fyip_amt numeric(11,2) not null,
    fyrp_amt numeric(11,2) not null,
    ryp_amt numeric(11,2) not null,
    fyic_amt numeric(11,2) not null,
    fyrc_amt numeric(11,2) not null,
    rcomm_amt numeric(11,2) not null,
    afyc_amt numeric(9) not null,
    lafyc_amt numeric(9) not null,
    lafyc13_amt numeric(9) not null,
    ncase_ctr numeric(5,2) not null,
    lcase_ctr numeric(5,2) not null,
    lcase13_ctr numeric(5,2) not null,
    bill_mthd varchar(1),
    fran_num varchar(5),
    crcy_cd varchar(2),
    pmt_mode varchar(2),
    orph_asign_ind varchar(1),
    cli_num varchar(13),
    cvg_eff_dt timestamp,
    comm_rt numeric(5,2),
    tid varchar(15),
    trxn_id varchar(15),
    cvg_lay_typ varchar(5),
    layer_eff_dt timestamp,
    user_id varchar(30),
    undo_trxn_id varchar(15),
    cause_cd varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.twrk_daily_nac_sg (
    trxn_dt timestamp,
    pol_num varchar(12),
    insrd_nm varchar(40),
    nac numeric(11,2),
    fyp numeric(11,2),
    naccase numeric(5,1),
    reinst_nac numeric(11,2),
    reinst_prem numeric(11,2),
    reincase numeric(5,1),
    adjmt_nac numeric(11,2),
    adjmt_prem numeric(11,2),
    lapsed_nac numeric(11,2),
    lapsed_prem numeric(11,2),
    lapcase numeric(5,1),
    rescinded_nac numeric(11,2),
    rescinded_prem numeric(11,2),
    rescase numeric(5,1),
    pmt_mode varchar(1),
    agt_code varchar(6),
    nric varchar(9),
    plan_code varchar(5),
    nac_yr varchar(1),
    remarks varchar(40),
    ann_fyp numeric(11,2),
    br_code varchar(5),
    unit_code varchar(6)
);

CREATE TABLE IF NOT EXISTS cas.twrk_daily_pc (
    request_id numeric(10) not null,
    pol_num varchar(10) not null,
    insrd varchar(60) not null,
    pc_amt numeric(9) not null,
    case_ctr numeric(5,2) not null,
    dpnd_ctr numeric(3) not null,
    prem_amt numeric(11,2) not null,
    trxn_dt timestamp not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_daily_va_disposal (
    cvg_stat_cd varchar(1) not null,
    term_to_maturity numeric not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    crcy_cd varchar(2),
    trxn_amt numeric(18,8)
);

CREATE TABLE IF NOT EXISTS cas.twrk_dnrs_reasn_tw (
    payo_reas varchar(10) not null,
    reas_desc varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.twrk_dnr_ct_dtls_th (
    link_seq numeric(10),
    dnr_num numeric(4),
    pol_num varchar(10),
    dnr_payo_amt numeric(11,2),
    clm_recv_dt timestamp,
    seq_num numeric(4)
);

CREATE TABLE IF NOT EXISTS cas.twrk_dnr_ct_th (
    link_seq numeric(10),
    payo_typ varchar(10),
    trxn_typ varchar(3),
    ben_nm varchar(70),
    mail_to_nm varchar(35),
    addr_1 varchar(35),
    addr_2 varchar(35),
    addr_3 varchar(35),
    payo_amt varchar(15),
    inv_amt varchar(15),
    vat_amt varchar(15),
    wht_amt varchar(15),
    ben_chrg varchar(15),
    ref_num varchar(12),
    chq_dt varchar(8),
    paydet1 varchar(35),
    paydet2 varchar(35),
    paydet3 varchar(35),
    deliv_mthd varchar(4),
    ct_asign_cli_cd varchar(6),
    db_acc_num varchar(10),
    chq_br_nm varchar(50),
    trxn_cd varchar(2),
    ben_bnk_br_cd varchar(7),
    ben_fax_num varchar(35),
    ben_acc_num varchar(11),
    eff_dt varchar(8),
    trxf_chrg varchar(3),
    co_nm varchar(43),
    reasn_code varchar(3),
    dnr_num numeric(4)
);

CREATE TABLE IF NOT EXISTS cas.twrk_dnr_details (
    pol_num varchar(10) not null,
    dnr_num numeric(4) not null,
    payo_amt numeric(11,2) not null,
    payo_type varchar(10) not null,
    payo_arrange varchar(10),
    payo_reas varchar(10) not null,
    team_num varchar(2),
    user_id varchar(30),
    trxn_dt timestamp,
    cli_num varchar(13),
    cli_nm varchar(40) not null,
    rqst_amt numeric(11,2),
    payo_crcy varchar(2),
    exchg_rt numeric(18,8),
    payo_amt_payo_crcy numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_electronic_pages (
    pol_set_id numeric(10) not null,
    trxn_seq_no numeric(5),
    pol_num varchar(10) not null,
    page_typ varchar(5) not null,
    jdt_nm varchar(20),
    form_nm varchar(20),
    page_no numeric(3) not null,
    page_desc varchar(60),
    plan_code varchar(5) not null,
    vers_num varchar(2),
    request_id numeric(10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_endrs_addr_chg (
    request_id numeric(10),
    cli_num varchar(13),
    addr_typ numeric(2),
    pol_num varchar(10),
    link_typ varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_endrs_bnfy_details (
    request_id numeric(10),
    ebd_seq numeric(7),
    bnfy_nm varchar(40),
    id_num varchar(20),
    birth_dt timestamp,
    sex_code varchar(1),
    bnfy_code_desc varchar(20),
    bnfy_pct numeric(5,2),
    bnfy_typ_desc varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.twrk_endrs_common_details (
    request_id numeric(10),
    ecd_seq numeric(7),
    description varchar(1000)
);

CREATE TABLE IF NOT EXISTS cas.twrk_endrs_common_master (
    request_id numeric(10),
    pol_num varchar(10),
    owner_nm varchar(60),
    insured_nm varchar(60),
    trxn_dt timestamp default to_date('1990-01-01','yyyy-mm-dd') not null,
    endrs_typ varchar(30) default 'DUMMY' not null,
    insured_cli_num varchar(10),
    owner_cli_num varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_eti_rpu (
    pol_num varchar(10),
    payer_nm varchar(60),
    add1 varchar(60),
    add2 varchar(60),
    add3 varchar(60),
    add4 varchar(60),
    cli_nm varchar(60),
    sum numeric(13,2),
    actv_dt timestamp,
    exp_dt timestamp,
    pur_pay numeric(13,2),
    pol_stat_cd varchar(1),
    agt_nm varchar(60),
    branch_nm varchar(40)
);

CREATE TABLE IF NOT EXISTS cas.twrk_fp_comm_sg (
    unit_code varchar(5),
    bank_code varchar(5),
    orig_agt_cde varchar(6),
    agt_code varchar(5),
    agt_nm varchar(60),
    sm_code varchar(6),
    sm_nm varchar(60),
    pol_num varchar(10),
    pol_iss_dt timestamp,
    trxn_dt timestamp,
    mode_num numeric(4),
    insrd_nm varchar(60),
    plan_code varchar(5),
    ins_typ varchar(2),
    cvg_eff_dt timestamp,
    cvg_eff_age numeric(3),
    pmt_mode varchar(15),
    pfc_comm numeric(11,2),
    isd_pl_comm numeric(11,2),
    br_pl_comm numeric(11,2),
    br_welfare_comm numeric(11,2),
    biz_welfare_comm numeric(11,2),
    isd_welfare_comm numeric(11,2),
    comm_amt numeric(11,2),
    prem_amt numeric(11,2),
    sing_ind varchar(1),
    plan_desc varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.twrk_fund_notice_dtl (
    trxn_dt timestamp not null,
    notice_typ varchar(10) not null,
    pol_num varchar(10) not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    fnd_abbr varchar(20),
    alloc_pct numeric(5,2),
    gurt_amt numeric(18,8),
    pv1_amt numeric(18,8),
    orig_pv1_amt numeric(18,8)
);

CREATE TABLE IF NOT EXISTS cas.twrk_fund_notice_loan (
    trxn_dt timestamp not null,
    notice_typ varchar(10) not null,
    pol_num varchar(10) not null,
    loan_trxn_dt timestamp not null,
    amt_ind varchar(1),
    loan_thi_num numeric(5) not null,
    trxn_cd varchar(8),
    reasn_code varchar(3),
    trxn_amt numeric(13,2),
    exchg_rt numeric(18,8),
    orig_trxn_amt numeric(18,8),
    eff_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_fund_notice_tw (
    trxn_dt timestamp not null,
    notice_typ varchar(10) not null,
    pol_num varchar(10) not null,
    agt_code varchar(5),
    agt_nm varchar(40),
    br_code varchar(5),
    br_nm varchar(40),
    br_phone varchar(20),
    insrd_cli_num varchar(10),
    insrd_nm varchar(40),
    owner_cli_num varchar(10),
    owner_nm varchar(40),
    owner_bill_addr_1 varchar(60),
    owner_bill_addr_2 varchar(60),
    owner_bill_addr_3 varchar(60),
    owner_bill_zip_code varchar(6),
    owner_invalid_addr_ind varchar(1),
    pol_eff_dt timestamp,
    base_plan_code varchar(5),
    base_plan_nm varchar(50),
    base_face_amt numeric(11,2),
    loan_bal numeric(11,2),
    loan_int_acru numeric(11,2),
    anty_start_dt timestamp,
    anty_freq varchar(5),
    anty_freq_desc varchar(10),
    interest_start_dt timestamp,
    interest_amt numeric(11,2),
    exchg_rt numeric(18,8),
    invest_start_dt timestamp,
    gurt_amt numeric(18,8),
    pv1_amt numeric(18,8),
    pv1_exchg_rt numeric(18,8),
    orig_pv1_amt numeric(18,8),
    partial_surr_amt numeric(18,8),
    ovr_loan_lapse_ind varchar(1),
    ovr_loan_dt timestamp,
    ovr_loan_lapse_dt timestamp,
    pv1_exchg_rt_date timestamp,
    owner_id_num varchar(10),
    base_crcy_cd varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_fund_prices (
    line1 varchar(200) not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_fund_prices_th (
    trxn_dt timestamp,
    fnd_id varchar(5),
    fnd_vers varchar(6),
    valn_dt timestamp,
    nav_pric numeric(20,10),
    buy_pric numeric(20,10),
    sell_pric numeric(20,10),
    upload_by varchar(30),
    upload_dt timestamp,
    status varchar(1),
    chng_status_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_fund_rpt_sg (
    cli_num varchar(13) not null,
    cli_nm varchar(60),
    addr1 varchar(60),
    addr2 varchar(60),
    addr3 varchar(60),
    zip_code varchar(6),
    pol_num_fld1 varchar(75),
    pol_num_fld2 varchar(75),
    seq_no numeric,
    addr_4 varchar(60),
    pol_num_fld3 varchar(75),
    pol_num_fld4 varchar(75)
);

CREATE TABLE IF NOT EXISTS cas.twrk_fund_trailers (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    trxn_dt timestamp not null,
    trxn_cd varchar(10) not null,
    fnd_id varchar(5),
    fnd_vers varchar(6),
    crcy_cd varchar(2),
    trxn_amt numeric(18,8)
);

CREATE TABLE IF NOT EXISTS cas.twrk_fund_trxn (
    pol_num varchar(10) not null,
    trxn_dt timestamp not null,
    trxn_typ varchar(1),
    trxn_id varchar(15) not null,
    fnd_trxn_cd varchar(3) not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_gen_acct (
    pol_num varchar(10),
    cr_or_dr varchar(1),
    acct_mne_cd varchar(8),
    acct_gen_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_gen_casmkthr0001_th (
    request_id numeric,
    pol_num varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_hb_attachment_id (
    pol_num varchar(10),
    seq_num numeric(4),
    clm_code varchar(2),
    clm_stat_code varchar(1),
    plan_code varchar(5),
    pati_cli_num varchar(13),
    clm_hosp_begin_dt timestamp,
    clm_hosp_end_dt timestamp,
    disease_code varchar(9),
    diagnose varchar(500),
    class_code varchar(3),
    room_board_days numeric(4),
    room_board_max numeric(17,2),
    room_board_clm numeric(17,2),
    room_board_paid numeric(17,2),
    intens_care_days numeric(4),
    intens_care_max numeric(17,2),
    intens_care_clm numeric(17,2),
    intens_care_paid numeric(17,2),
    doctor_visit_days numeric(4),
    doctor_visit_max numeric(17,2),
    doctor_visit_clm numeric(17,2),
    doctor_visit_paid numeric(17,2),
    hosp_expens_max numeric(17,2),
    hosp_expens_clm numeric(17,2),
    hosp_expens_paid numeric(17,2),
    surgeon_fee_pct numeric(5,2),
    surgeon_fee_max numeric(17,2),
    surgeon_fee_clm numeric(17,2),
    surgeon_fee_paid numeric(17,2),
    speclst_fee_max numeric(17,2),
    speclst_fee_clm numeric(17,2),
    speclst_fee_paid numeric(17,2),
    anaesth_fee_max numeric(17,2),
    anaesth_fee_clm numeric(17,2),
    anaesth_fee_paid numeric(17,2),
    op_theatre_max numeric(17,2),
    op_theatre_clm numeric(17,2),
    op_theatre_paid numeric(17,2),
    emer_outpati_max numeric(17,2),
    emer_outpati_clm numeric(17,2),
    emer_outpati_paid numeric(17,2),
    death_bene_max numeric(17,2),
    death_bene_clm numeric(17,2),
    death_bene_paid numeric(17,2),
    related_mark numeric(4),
    emgncy_dentl_max numeric(17,2),
    emgncy_dentl_clm numeric(17,2),
    emgncy_dentl_paid numeric(17,2),
    private_nurse_days numeric(4),
    private_nurse_max numeric(17,2),
    private_nurse_clm numeric(17,2),
    private_nurse_paid numeric(17,2),
    ambulance_max numeric(17,2),
    ambulance_clm numeric(17,2),
    ambulance_paid numeric(17,2),
    instrm_rental_max numeric(17,2),
    instrm_rental_clm numeric(17,2),
    instrm_rental_paid numeric(17,2),
    post_hospital_max numeric(17,2),
    post_hospital_clm numeric(17,2),
    post_hospital_paid numeric(17,2),
    surgy_class varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.twrk_hosp_dependents (
    pol_set_id numeric(10),
    trxn_seq_no numeric(5),
    pol_num varchar(10),
    plan_code varchar(5),
    dependent_nm varchar(60),
    birth_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_hsdscnt_sum (
    from_dt timestamp,
    to_dt timestamp,
    mtd_hs_prem numeric(13,2),
    mtd_dscnt_rt numeric(13,2),
    accum_prem numeric(13,2),
    accum_dscnt_rt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_iflist (
    line_buf varchar(3000)
);

CREATE TABLE IF NOT EXISTS cas.twrk_ipo_srch_rslts (
    request_id numeric(10) not null,
    pol_num varchar(10) not null,
    ipo_ind varchar(1) not null,
    chk_ipo_rslt varchar(2) not null,
    fld_nm varchar(30),
    cli_nm varchar(40)
);

CREATE TABLE IF NOT EXISTS cas.twrk_labels (
    pol_num varchar(10),
    ins_name varchar(60),
    owner_name varchar(60)
);

CREATE TABLE IF NOT EXISTS cas.twrk_labels_null (
    dummy varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_labels_sg (
    pol_num varchar(10),
    ins_name varchar(60),
    owner_name varchar(60)
);

CREATE TABLE IF NOT EXISTS cas.twrk_lapsation (
    pol_num varchar(10) not null,
    cli_nm varchar(60),
    addr_typ numeric(2),
    addr_1 varchar(60),
    addr_2 varchar(60),
    addr_3 varchar(60),
    zip_code varchar(6),
    invalid_addr_ind varchar(1),
    addr_4 varchar(60),
    res_code varchar(2),
    cvg_lapse_dt timestamp,
    agt_nm varchar(40),
    br_nm varchar(40),
    actv_dt timestamp not null,
    actv_typ varchar(1) not null,
    rider_desc varchar(50),
    rider_typ varchar(2),
    plan_code varchar(5) default '*****' not null,
    vers_num varchar(2) default '**' not null,
    cli_num varchar(13),
    cvg_eff_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_med_exps (
    exp_seq numeric(9),
    med_date timestamp,
    cli_nm varchar(30),
    pol_num varchar(10),
    med_exam varchar(70),
    med_hosp varchar(10),
    med_seq numeric(6),
    in_exps numeric(14,2),
    labone_exps numeric(9,2),
    remark varchar(300)
);

CREATE TABLE IF NOT EXISTS cas.twrk_med_schd (
    schd_seq varchar(2),
    schd_dt varchar(20),
    cli_nm varchar(30),
    pol_num varchar(10),
    med_exam varchar(70),
    loc_code varchar(6),
    med_hosp varchar(10),
    med_seq numeric(6)
);

CREATE TABLE IF NOT EXISTS cas.twrk_mit_sms (
    notice_type varchar(3),
    gen_date timestamp,
    ul_plan varchar(2),
    ovr_70 numeric(5),
    pol_num varchar(10),
    sms_txt varchar(400),
    mob_phone varchar(200),
    job_type varchar(2),
    export_date timestamp,
    dept varchar(3),
    errormsg varchar(200),
    account varchar(50),
    category varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.twrk_monthly_rpt_tw (
    cas_dt timestamp not null,
    atr_num numeric(8) not null,
    rpt_typ varchar(2) not null,
    cnt_typ varchar(1) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    old_stat_cd varchar(1) not null,
    new_stat_cd varchar(1) not null,
    unit_basis numeric(2) default 1 not null,
    pol_num varchar(10) not null,
    cli_num varchar(10) not null,
    cvg_eff_dt timestamp not null,
    face_amt numeric(13,2) not null,
    base_plan_code varchar(5) not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_nac_sg (
    pol_num varchar(12),
    insrd_nm varchar(40),
    nac numeric(5),
    naccase numeric(4,1),
    reinst numeric(5),
    reincase numeric(4,1),
    adjmt numeric(5),
    lapsed numeric(5),
    lapcase numeric(4,1),
    rescinded numeric(5),
    rescase numeric(4,1),
    pmt_mode varchar(1),
    agtnbr varchar(6),
    nric varchar(9),
    plan_code varchar(5),
    trxn_dt timestamp,
    nac_yr varchar(1),
    prem_amt numeric(11,2),
    comm_amt numeric(11,2),
    cvg_eff_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_name_scan_bridger_th (
    request_id numeric,
    run_mode varchar(1),
    trxn_dt timestamp,
    cli_name varchar(100),
    birth_dt timestamp,
    gender varchar(10),
    addr_1 varchar(60),
    addr_2 varchar(60),
    addr_3 varchar(60),
    addr_4 varchar(60),
    zip_code varchar(6),
    cli_num varchar(13),
    others_info varchar(100),
    user_crt varchar(30),
    id_num varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.twrk_nb_tracking (
    pol_num varchar(10) not null,
    trxn_dt timestamp not null,
    dump varchar(1000) not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_nfo_wrksht (
    request_id numeric(10) not null,
    pol_num varchar(10) not null,
    asof_dt timestamp not null,
    cv_pol numeric(13,2),
    pv_pol numeric(13,2),
    unearn_prem numeric(11,2),
    surr_valu numeric(13,2),
    lapse_valu numeric(13,2),
    rsdue_valu numeric(13,2),
    div_valu numeric(11,2),
    endow_valu numeric(13,2),
    loan_valu numeric(13,2),
    max_loan numeric(13,2),
    max_loan_apl numeric(13,2),
    anty_valu numeric(13,2),
    lump_sum_valu numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_nfo_wrksht_cvg (
    request_id numeric(10) not null,
    pol_num varchar(10) not null,
    asof_dt timestamp not null,
    cli_num varchar(13) not null,
    cvg_eff_dt timestamp not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cv_face_amt numeric(13,2),
    cv_pua numeric(13,2),
    cv_cvg numeric(13,2),
    pv_face_amt numeric(13,2),
    pv_pua numeric(13,2),
    pv_cvg numeric(13,2),
    unearn_prem numeric(11,2),
    rpu_db numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_orphan_notice (
    trxn_dt timestamp not null,
    fcn_id varchar(20) not null,
    pol_num varchar(10) not null,
    print_ind varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_orphan_notice_tw (
    trxn_dt timestamp not null,
    noti_typ varchar(5) not null,
    request_id numeric(10) not null,
    pol_num varchar(10) not null,
    agt_code varchar(5),
    owner_cli_num varchar(10),
    owner_nm varchar(40)
);

CREATE TABLE IF NOT EXISTS cas.twrk_ovr_loaned_pol (
    trxn_dt timestamp not null,
    pol_num varchar(10) not null,
    last_avy_dt timestamp,
    pd_to_dt timestamp,
    pol_eff_dt timestamp,
    pol_stat_cd varchar(1),
    tot_cv numeric(11,2) not null,
    tot_loan numeric(11,2) not null,
    ovr_loaned_amt numeric(11,2) not null,
    asof_dt timestamp not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_ovr_loaned_pol_60 (
    trxn_dt timestamp not null,
    pol_num varchar(10),
    last_avy_dt timestamp,
    pd_to_dt timestamp,
    pol_eff_dt timestamp,
    pol_stat_cd varchar(1),
    tot_cv numeric(11,2),
    tot_loan numeric(11,2),
    tot_sur numeric(11,2),
    cv_bfover numeric(11,2),
    loaned_bfover numeric(11,2),
    surr_bfover numeric(11,2),
    asof_dt_bfover timestamp,
    min_payable numeric(11,2),
    payable_date timestamp,
    add_1 varchar(70),
    add_2 varchar(70),
    add_3 varchar(70),
    insured_nm varchar(70)
);

CREATE TABLE IF NOT EXISTS cas.twrk_page3 (
    request_id numeric(10),
    pol_num varchar(10),
    copy_num numeric(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_page3_agt (
    request_id numeric(10) not null,
    pol_num varchar(10) not null,
    copy_num numeric(1) not null,
    agt_nm1 varchar(40),
    agt_lic_num1 varchar(15),
    agt_nm2 varchar(40),
    agt_lic_num2 varchar(15),
    agt_type varchar(1) not null,
    prem_inc_ind varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_page3_cmp (
    request_id numeric(10),
    pol_num varchar(10),
    prt_ctl varchar(4),
    pol_eff_dt timestamp,
    pol_iss_dt timestamp,
    ins_nm varchar(60),
    ins_id_num varchar(20),
    ins_sex varchar(1),
    ins_dob timestamp,
    ins_age numeric(3),
    own_nm varchar(60),
    own_id_num varchar(20),
    pay_nm varchar(60),
    pay_sex varchar(1),
    pay_id_num varchar(20),
    addr_1 varchar(60),
    addr_2 varchar(60),
    addr_3 varchar(60),
    zip_code varchar(10),
    phon_num varchar(20),
    plan_code varchar(5),
    plan_desc varchar(50),
    face_amt numeric(13,2),
    pmt_mode varchar(2),
    mode_prem numeric(11,2),
    year_prem numeric(11,2),
    bill_mthd varchar(1),
    crcy_code varchar(2),
    bank_acct_num varchar(20),
    prem_paid numeric(11,2),
    agt_code varchar(6),
    agt_nm varchar(40),
    br_code varchar(5),
    unit_code varchar(5),
    loc_code varchar(10),
    ret_dt timestamp,
    paid_up_age numeric(3),
    cntrct_end_dt timestamp,
    cmp_page2_frmt numeric(2),
    own_age numeric(3),
    pb_paid_up_age numeric(3),
    lump_sum_prem numeric(11,2),
    annuity_01 numeric(13,2),
    annuity_10 numeric(13,2),
    annuity_20 numeric(13,2),
    annuity_wl numeric(13,2),
    vers_num varchar(2),
    xcpt_bill_cd varchar(1),
    othr_phon_num varchar(20),
    pol_stat_cd varchar(1),
    div_opt varchar(1),
    occp_clas varchar(1),
    pay_dob timestamp,
    pay_age numeric(3),
    prem_int_rt numeric(7,5),
    ctl_nm varchar(20),
    last_printed_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_page3_cvg (
    request_id numeric(10),
    pol_num varchar(10),
    copy_num numeric(1),
    seq_num numeric(3),
    cvg_typ varchar(1),
    is_first varchar(1),
    description varchar(100),
    face_amt numeric(10),
    sub_desc varchar(100),
    plan_code varchar(5),
    org_create varchar(1),
    cli_num varchar(13),
    bnft_dur numeric(3) not null,
    prem_dur numeric(3) not null,
    cvg_eff_age numeric(3) not null,
    sex_code varchar(1) not null,
    sngl_prem_ind varchar(1) not null,
    mode_prem numeric(13,2),
    hosp_bnft numeric(9,2),
    prem_inc_ind varchar(1),
    accident_ind varchar(1),
    plan_desc varchar(50),
    bnft_schd_ind varchar(1),
    rpu_rfnd_ind varchar(1),
    eti_rfnd_ind varchar(1),
    vers_num varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_page3_cvgdtls (
    pol_set_id numeric(10),
    trxn_seq_no numeric(5),
    pol_num varchar(10),
    seq_num numeric,
    cvg_typ varchar(1),
    plan_code varchar(5),
    vers_num varchar(2),
    plan_desc varchar(100),
    face_amt numeric(13,2),
    cvg_prem numeric(13,2),
    ins_typ varchar(1),
    cvg_clas varchar(3),
    no_of_insrd numeric(2),
    wait_perd numeric(3),
    wait_perd_unit varchar(2),
    max_bnft_perd numeric(3),
    max_bnft_perd_unit varchar(2),
    rcc_ind varchar(1),
    desc_1 varchar(100),
    desc_2 varchar(100),
    desc_3 varchar(100),
    desc_4 varchar(100),
    desc_5 varchar(100),
    extra_prem numeric(13,2),
    request_id numeric(10),
    prem_grnt_ind varchar(1),
    plan_shrt_desc varchar(20),
    tot_prem numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_page3_cvg_rcpt_th (
    request_id numeric(10) not null,
    pol_num varchar(10) not null,
    rcpt_num varchar(12) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp,
    tax_percen numeric(5,2),
    tax_typ varchar(5),
    prem_amt numeric(11,2),
    taxable_prem numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_page3_details (
    pol_set_id numeric(10) not null,
    trxn_seq_no numeric(5),
    pol_num varchar(10) not null,
    life_insured varchar(60),
    pol_yr_dt timestamp,
    iss_dt timestamp,
    id_num varchar(20),
    birth_dt timestamp,
    age numeric,
    sex varchar(1),
    rate varchar(10),
    owner varchar(60),
    beneficiary varchar(100),
    par_code varchar(1),
    plan_code varchar(5),
    vers_num varchar(2),
    plan_desc varchar(100),
    display_cat varchar(1),
    face_amt numeric(11,2),
    db_opt varchar(1),
    iio_opt varchar(1),
    iio_pct numeric(3),
    plan_prem numeric(11,2),
    crcy_code varchar(2),
    pmt_mode varchar(5),
    no_of_copy numeric,
    print_flag varchar(1),
    print_status varchar(1),
    ctr_prem numeric(11,2),
    agt_code varchar(6),
    request_id numeric(10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_page3_extra_charge (
    request_id numeric(10) not null,
    pol_num varchar(10) not null,
    copy_num numeric(1) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    extra_desc varchar(100),
    face_amt numeric(10),
    face_ratg_prem numeric(11,2),
    perm_flat_prem numeric(11,2),
    temp_flat_prem numeric(11,2),
    temp_flat_dur numeric(3)
);

CREATE TABLE IF NOT EXISTS cas.twrk_page3_funddtls (
    pol_set_id numeric(10),
    trxn_seq_no numeric(5),
    pol_num varchar(10),
    seq_num numeric,
    fnd_id varchar(5),
    fnd_vers varchar(6),
    fnd_desc varchar(200),
    alloc_pct numeric(5,2),
    prem_grp varchar(3),
    request_id numeric(10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_page3_mortgage (
    request_id varchar(10) not null,
    pol_num varchar(10) not null,
    dscnt_prem numeric(11,2) not null,
    pol_iss_dt timestamp not null,
    pol_eff_dt timestamp not null,
    client_name varchar(200),
    cvg_eff_age numeric(3) not null,
    face_amt numeric(13,2) not null,
    xpry_dt timestamp not null,
    bnft_dur numeric(3) not null,
    plan_code varchar(5) not null,
    extra_charge_desc varchar(50),
    sales_champaign varchar(50),
    last_printed_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_page3_pa (
    request_id numeric(10) not null,
    pol_num varchar(10) not null,
    copy_num numeric(1) not null,
    base_plan_code varchar(5) not null,
    pol_val_vers varchar(2) not null,
    pol_yr numeric(3),
    pd_to_dt timestamp,
    ins_nm varchar(60),
    ins_addr_1 varchar(60),
    ins_addr_2 varchar(60),
    ins_addr_3 varchar(60),
    occp_clas varchar(1),
    occp_desc varchar(150),
    bnfy_name1 varchar(60),
    bnfy_name2 varchar(60),
    bnfy_relt1 varchar(30),
    bnfy_relt2 varchar(30),
    cvg_eff_dt timestamp,
    cvg_end_dt timestamp,
    cvg_eff_age numeric(3),
    add_prem numeric(11,2),
    net_prem numeric(11,2),
    tot_prem numeric(11,2),
    agt_nm varchar(40),
    agt_lic_num varchar(15),
    agree_dt timestamp,
    br_nm varchar(40),
    base_vers_num varchar(2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_page3_prem (
    request_id numeric(10),
    pol_num varchar(10),
    copy_num numeric(1),
    seq_num numeric(3),
    description varchar(100),
    mode_prem numeric(11,2),
    is_level varchar(1),
    paid_up_dt timestamp,
    plan_code varchar(5),
    cvg_typ varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_page3_prem_rcpt (
    request_id numeric(10) not null,
    pol_num varchar(10) not null,
    copy_num numeric(1) not null,
    rcpt_num varchar(12),
    rcpt_prt_dt timestamp,
    temp_rcpt_num varchar(7),
    temp_rcpt_dt timestamp,
    payer_nm varchar(60),
    rcpt_amt numeric(11,2),
    pmt_mode varchar(2),
    face_amt numeric(13,2),
    plan_desc varchar(50),
    bnft_dur numeric(3),
    prem_dur numeric(3),
    insure_nm varchar(60),
    basic_prem numeric(11,2),
    rider_prem numeric(11,2),
    taxable_prem numeric(11,2),
    temp_rcpt_num2 varchar(7),
    temp_rcpt_dt2 timestamp,
    temp_rcpt_num3 varchar(7),
    temp_rcpt_dt3 timestamp,
    temp_rcpt_num4 varchar(7),
    temp_rcpt_dt4 timestamp,
    no_of_period varchar(6)
);

CREATE TABLE IF NOT EXISTS cas.twrk_page3_prem_rcpt_th (
    request_id numeric(10) not null,
    pol_num varchar(10) not null,
    rcpt_num varchar(12),
    rcpt_prt_dt timestamp,
    rcpt_amt numeric(11,2),
    basic_prem numeric(11,2),
    rider_prem numeric(11,2),
    taxable_prem numeric(11,2),
    non_taxable_prem numeric(11,2),
    rider_taxable_prem numeric(11,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_page3_remarks (
    request_id numeric(10) not null,
    pol_num varchar(10) not null,
    copy_num numeric(1) not null,
    line_num numeric(3) not null,
    remark_line varchar(200)
);

CREATE TABLE IF NOT EXISTS cas.twrk_page3_values (
    request_id numeric(10),
    pol_num varchar(10),
    copy_num numeric(1),
    seq_num numeric(3),
    pol_year numeric(3),
    age numeric(3),
    cv numeric(12,2),
    rpu numeric(12,2),
    div numeric(10),
    dth_bnft numeric(12,2),
    rpu_rfnd numeric(9,4),
    eti_rt numeric(9,4),
    eti_yr numeric(3),
    eti_dy numeric(3),
    eti_rfnd numeric(9,4)
);

CREATE TABLE IF NOT EXISTS cas.twrk_pasala201 (
    user_id varchar(10) not null,
    request_id numeric(10) not null,
    pol_app_dt timestamp,
    eff_age numeric(3) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    life_rsk_amt numeric(18,2),
    tlife_risk_amt numeric(18,2),
    accd_rsk_amt numeric(18,2),
    add_rsk numeric(18,2),
    adb_risk_amt numeric(18,2),
    rcc_rsk numeric(18,2),
    wp_rsk numeric(18,2),
    ddb_rsk numeric(18,2),
    pbwp_risk_amt numeric(18,2),
    pbl_rsk numeric(18,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_pend_app_sg (
    pend_id varchar(2),
    team_code varchar(10),
    pend_cd varchar(2),
    pol_cnt numeric(5)
);

CREATE TABLE IF NOT EXISTS cas.twrk_pend_tracks (
    pol_num varchar(10) not null,
    track_dt timestamp not null,
    pend_flag varchar(1) not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_picc_reins_pa (
    seq_num numeric(2) not null,
    pol_num_from varchar(10),
    pol_num_to varchar(10),
    count numeric(6),
    pol_date_from timestamp,
    pol_date_to timestamp,
    face_amt numeric(13,2),
    prem_rate_from numeric(10,3),
    prem_rate_to numeric(10,3),
    premium numeric(11,2),
    plan_code varchar(5),
    prod_code varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.twrk_pol (
    pol_num varchar(10) not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_policy_confirms (
    pol_set_id numeric(10),
    trxn_seq_no numeric(5),
    pol_num varchar(10),
    life_insured varchar(60),
    init_prem_req numeric(11,2),
    prem_receive numeric(11,2),
    os_prem numeric(11,2),
    crcy_code varchar(2),
    addr_1 varchar(60),
    addr_2 varchar(60),
    addr_3 varchar(60),
    addr_4 varchar(60),
    bank_no varchar(13),
    bank_acct_no varchar(20),
    bank_acct_nm varchar(40),
    payment_day varchar(2),
    eff_mth_first_dr timestamp,
    print_flag varchar(1),
    print_status varchar(1),
    request_id numeric(10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_policy_set_rqst (
    pol_set_id numeric(10) not null,
    request_id numeric(10),
    trxn_seq_no numeric(5),
    pol_num varchar(10) not null,
    prt_rqst varchar(20) not null,
    rslt_valu varchar(1) not null,
    seq_num numeric(3),
    rqst_typ varchar(5),
    rqst_dt timestamp,
    pol_iss_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_policy_tax_th (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    cvg_typ varchar(1) not null,
    cvg_prem numeric(11,2) not null,
    dscnt_prem numeric(11,2) not null,
    face_amt numeric(13,2) not null,
    cvg_eff_age numeric(3) not null,
    cvg_iss_dt timestamp,
    cvg_stat_cd varchar(1) not null,
    pol_iss_dt timestamp,
    pol_stat_cd varchar(1) not null,
    pmt_mode varchar(5) not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_policy_tax_th_tmp (
    pol_num varchar(10) not null,
    cli_num varchar(13) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    cvg_eff_dt timestamp not null,
    cvg_typ varchar(1) not null,
    cvg_prem numeric(11,2) not null,
    dscnt_prem numeric(11,2) not null,
    cvg_stat_cd varchar(1) not null,
    pmt_mode varchar(5) not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_polmst_err_sg (
    err_txt varchar(100)
);

CREATE TABLE IF NOT EXISTS cas.twrk_polmst_sg (
    seq_num numeric(10),
    textline varchar(4000)
);

CREATE TABLE IF NOT EXISTS cas.twrk_pol_chg_cont (
    pol_num varchar(10),
    request_id numeric(10),
    chg_cont varchar(100),
    action_cd varchar(10),
    request_date timestamp,
    old_value varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.twrk_pol_chg_notice (
    pol_num varchar(10),
    request_id numeric(10),
    plan_lng_desc varchar(100),
    insrd_nm varchar(60),
    owner_nm varchar(60),
    pd_to_dt timestamp,
    request_date timestamp,
    pol_iss_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_pol_invnty_ctl (
    pol_num varchar(10),
    strt_crcy_code varchar(2),
    strt_pmt_susp_bal numeric(13,2),
    strt_pol_susp_bal numeric(13,2),
    strt_pol_loan_bal numeric(13,2),
    strt_acum_div_bal numeric(13,2),
    strt_csh_cpn_bal numeric(13,2),
    move_crcy_code varchar(2),
    move_pmt_susp_bal numeric(13,2),
    move_pol_susp_bal numeric(13,2),
    move_pol_loan_bal numeric(13,2),
    move_acum_div_bal numeric(13,2),
    move_csh_cpn_bal numeric(13,2),
    end_crcy_code varchar(2),
    end_pmt_susp_bal numeric(13,2),
    end_pol_susp_bal numeric(13,2),
    end_pol_loan_bal numeric(13,2),
    end_acum_div_bal numeric(13,2),
    end_csh_cpn_bal numeric(13,2),
    err_code numeric(4),
    err_msg varchar(100),
    strt_svg_bal numeric(13,2),
    move_svg_bal numeric(13,2),
    end_svg_bal numeric(13,2),
    strt_apl_loan_bal numeric(13,2),
    move_apl_loan_bal numeric(13,2),
    end_apl_loan_bal numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_pol_lapse (
    agt_code varchar(6),
    pol_num varchar(10) not null,
    pd_to_dt timestamp,
    prem numeric(11,2),
    trxn_dt timestamp,
    br_code varchar(5),
    unit_code varchar(5),
    unit_loc varchar(10),
    agt_nm varchar(40),
    ins_nm varchar(60),
    home_phone varchar(20),
    offe_phone varchar(20),
    pmt_mode varchar(2),
    bill_mthd varchar(1),
    unit_mgr_cd varchar(5),
    unit_mgr_nm varchar(40),
    br_mgr_cd varchar(5),
    br_mgr_nm varchar(40),
    num_owed numeric(1),
    fran_num varchar(4),
    plan_code varchar(5),
    is_orphan varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_pol_replacement_sg (
    causing_pol_co_cd varchar(2),
    causing_pol_crcy_code varchar(2),
    causing_pol_num varchar(20),
    repl_start_dt timestamp,
    repl_end_dt timestamp,
    repl_reasn_code varchar(3),
    causing_agt_code varchar(6),
    insured_id_typ varchar(1),
    insured_id_num varchar(20),
    insured_nm varchar(60),
    payer_id_typ varchar(1),
    payer_id_num varchar(20),
    payer_nm varchar(60),
    restr_pol_crcy_code varchar(2),
    restr_pol_num varchar(10),
    extract_dt timestamp,
    last_scan_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_pol_replacement_tw (
    report_typ varchar(20) not null,
    br_code varchar(5) not null,
    br_nm varchar(40) not null,
    agt_code varchar(5) not null,
    agt_nm varchar(40) not null,
    pol_num varchar(10) not null,
    pol_eff_dt timestamp not null,
    pol_stat_cd varchar(1) not null,
    insrd_cli_num varchar(10) not null,
    insrd_cli_nm varchar(40) not null,
    plan_code varchar(5) not null,
    face_amt numeric(11,2) not null,
    mode_prem numeric(11,2) not null,
    actv_dt timestamp not null,
    iss_pol_num varchar(10) not null,
    iss_pol_eff_dt timestamp not null,
    iss_plan_code varchar(5) not null,
    iss_face_amt numeric(11,2) not null,
    iss_mode_prem numeric(11,2) not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_pol_set_base_tw (
    request_id numeric(10),
    pol_num varchar(10),
    report_typ varchar(1),
    pol_eff_dt timestamp,
    pol_iss_dt timestamp,
    pol_print_dt timestamp,
    agt_code1 varchar(5),
    agt_nm1 varchar(40),
    agt_br_code1 varchar(5),
    agt_br_nm1 varchar(40),
    agt_code2 varchar(5),
    agt_nm2 varchar(40),
    agt_br_code2 varchar(5),
    agt_br_nm2 varchar(40),
    agt_code3 varchar(5),
    agt_nm3 varchar(40),
    agt_br_code3 varchar(5),
    agt_br_nm3 varchar(40),
    orig_agt_code1 varchar(5),
    orig_agt_nm1 varchar(40),
    orig_agt_br_code1 varchar(5),
    orig_agt_br_nm1 varchar(40),
    orig_agt_code2 varchar(5),
    orig_agt_nm2 varchar(40),
    orig_agt_br_code2 varchar(5),
    orig_agt_br_nm2 varchar(40),
    orig_agt_code3 varchar(5),
    orig_agt_nm3 varchar(40),
    orig_agt_br_code3 varchar(5),
    orig_agt_br_nm3 varchar(40),
    own_cli_num varchar(10),
    own_nm varchar(40),
    own_sex varchar(2),
    own_dob timestamp,
    own_id_num varchar(20),
    own_reg_addr_1 varchar(60),
    own_reg_addr_2 varchar(60),
    own_reg_addr_3 varchar(60),
    own_bill_addr_1 varchar(60),
    own_bill_addr_2 varchar(60),
    own_bill_addr_3 varchar(60),
    own_prim_phon_num varchar(20),
    own_othr_phon_num varchar(20),
    insrd_cli_num varchar(10),
    insrd_nm varchar(40),
    insrd_sex varchar(2),
    insrd_dob timestamp,
    insrd_age numeric(3),
    insrd_id_num varchar(20),
    insrd_mail_addr_1 varchar(60),
    insrd_mail_addr_2 varchar(60),
    insrd_mail_addr_3 varchar(60),
    insrd_offce_addr_1 varchar(60),
    insrd_offce_addr_2 varchar(60),
    insrd_offce_addr_3 varchar(60),
    insrd_prim_phon_num varchar(20),
    insrd_othr_phon_num varchar(20),
    joint_cli_num varchar(10),
    joint_cli_nm varchar(40),
    joint_cli_sex varchar(2),
    joint_cli_dob timestamp,
    joint_cli_age numeric(3),
    joint_cli_id_num varchar(20),
    base_plan_code varchar(5),
    base_mkt_plan_nm varchar(50),
    fran_num varchar(4),
    pmt_mode varchar(5),
    pmt_mode_desc varchar(20),
    bill_mthd varchar(1),
    bill_mthd_desc varchar(20),
    div_opt varchar(1),
    div_opt_desc varchar(20),
    nfo_opt varchar(1),
    nfo_opt_desc varchar(2),
    ipo_ind varchar(1),
    ipo_ind_desc varchar(2),
    lnb_ind varchar(1),
    lnb_ind_desc varchar(2),
    dscnt_prem numeric(11,2),
    actual_prem numeric(11,2),
    pol_trmn_dt timestamp,
    copy_num numeric(1),
    own_reg_zip_code varchar(6),
    own_bill_zip_code varchar(6),
    insrd_mail_zip_code varchar(6),
    insrd_offce_zip_code varchar(6),
    copy_no numeric(1),
    base_plan_full_nm varchar(50),
    cvg_exp_opt varchar(1),
    cvg_exp_opt_desc varchar(50),
    invest_start_dt timestamp,
    gurt_prd numeric(3),
    gurt_prd_desc varchar(50),
    anty_start_dt timestamp,
    anty_freq varchar(5),
    gurt_amt numeric(18,8),
    gurt_crcy_code varchar(2),
    gurt_crcy_symbl varchar(5),
    pv1_as_of_dt timestamp,
    pv1_crcy_symbl varchar(5),
    pv1_amt numeric(18,8),
    anty_freq_desc varchar(50)
);

CREATE TABLE IF NOT EXISTS cas.twrk_pol_set_bnft_tw (
    request_id numeric(10),
    pol_num varchar(10),
    across_item numeric(3),
    down_item numeric(3),
    bnft_cntnt varchar(12),
    copy_no numeric(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_pol_set_bnfy_tw (
    request_id numeric(10),
    pol_num varchar(10),
    bde_num numeric(4),
    bnfy_typ varchar(3),
    bnfy_typ_desc varchar(20),
    bnfy_nm varchar(40),
    bnfy_code varchar(3),
    bnfy_code_desc varchar(20),
    bnfy_pct numeric(5,2),
    bnfy_prty numeric(2),
    copy_no numeric(1),
    bnfy_birth_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_pol_set_cli_tw (
    request_id numeric(10),
    pol_num varchar(10),
    rel_to_insrd varchar(2),
    rel_desc varchar(50),
    cli_num varchar(10),
    cli_nm varchar(40),
    cli_dob timestamp,
    copy_no numeric(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_pol_set_cvg_tw (
    request_id numeric(10),
    pol_num varchar(10),
    cli_num varchar(10),
    plan_typ varchar(2),
    prt_seq numeric(3),
    plan_code varchar(5),
    plan_desc varchar(50),
    plan_cntnt varchar(20),
    cvg_eff_dt timestamp,
    prem_dur numeric(3),
    mode_prem numeric(11,2),
    vers_num varchar(2) default '01',
    copy_no numeric(1),
    xpry_dt timestamp,
    eti_endow numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_prdctvty_tracks (
    user_id varchar(30) not null,
    start_dt timestamp not null,
    end_dt timestamp not null,
    not_proc numeric(10) not null,
    sb_nb numeric(10) not null,
    not_pend numeric(10) not null,
    new_iss numeric(10) not null,
    prev_pend_iss numeric(10) not null,
    new_pend numeric(10) not null,
    decline numeric(10) not null,
    rate numeric(10) not null,
    decline_not_pend numeric(10) not null,
    user_proc numeric(10) not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_premium_holiday (
    pol_num varchar(10) not null,
    prem_due_dt timestamp,
    prem_hol_fee numeric(13,2),
    mode_prem numeric(11,2),
    pmt_mode varchar(5),
    prem_hol_exp_dt timestamp,
    lapse_dt timestamp,
    autopay_ind varchar(1),
    autopay_ded_dt timestamp,
    agt_nm varchar(40),
    br_nm varchar(40),
    actv_dt timestamp not null,
    actv_typ varchar(1) not null,
    trxn_id varchar(15) not null,
    undo_trxn_id varchar(15)
);

CREATE TABLE IF NOT EXISTS cas.twrk_premium_tax (
    plan_code varchar(5) not null,
    acct_num varchar(8) not null,
    premium numeric(11,2),
    prem_tax numeric(9,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_rasal201_cli_dtl (
    user_id varchar(10) not null,
    request_id varchar(10) not null,
    ins_id_num varchar(30) not null,
    ins_cli_num varchar(40) not null,
    ins_nm varchar(255),
    ins_sex varchar(1),
    ins_birth_dt timestamp,
    crcy_code varchar(2) not null,
    risk_typ varchar(10) not null,
    risk_typ_desc varchar(255),
    risk_amt numeric(18,2),
    risk_prem numeric(18,2),
    request_dt timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS cas.twrk_rasal201_d (
    user_id varchar(10) not null,
    request_id numeric(10) not null,
    id_num varchar(20),
    cli_nm varchar(60),
    birth_dt timestamp,
    sex_code varchar(10),
    cli_num varchar(13),
    pol_num varchar(10),
    link_typ varchar(10),
    plan_code varchar(10),
    pol_stat_cd varchar(10),
    uwg_clas varchar(30),
    pol_eff_dt timestamp,
    trmn_dt timestamp,
    life_rsk_amt numeric(18,2),
    accd_rsk_amt numeric(18,2),
    br_code varchar(5),
    srch_id varchar(20),
    pol_iss_dt timestamp,
    agt_code varchar(6),
    pol_rmrk varchar(500),
    agt_nm varchar(40),
    hosp_stat_cd varchar(50),
    occp_code varchar(10),
    occp_clas varchar(1),
    base_plan_ratg varchar(1),
    cvg_ratg varchar(1),
    clm_ind varchar(1),
    pa_rsk_amt numeric(18,2),
    cdd_rsk_amt numeric(18,2),
    crcy_code varchar(4),
    ir_rsk_amt numeric(18,2),
    tlia_comp varchar(40),
    tlia_num numeric(10),
    tlia_typ varchar(10),
    adb_risk_amt numeric(18,2),
    rcc_rsk numeric(18,2),
    wp_rsk numeric(18,2),
    ddb_rsk numeric(18,2),
    pb_risk_amt numeric(18,2),
    pbl_rsk numeric(18,2),
    tlife_risk_amt numeric(18,2),
    add_rsk numeric(18,2),
    cab_risk_amt numeric(18,2),
    mdb_risk_amt numeric(18,2),
    fib_risk_amt numeric(18,2),
    hib_risk_amt numeric(18,2),
    fb_risk_amt numeric(18,2),
    ca_risk_amt numeric(18,2),
    pwb_risk_amt numeric(18,2),
    pne_risk_amt numeric(18,2),
    bnt_risk_amt numeric(18,2),
    adnd_risk_amt numeric(18,2),
    amdb_risk_amt numeric(18,2),
    pbwp_risk_amt numeric(18,2),
    mib_ind varchar(1),
    pmt_mode varchar(5),
    vers_num varchar(2),
    face_amt numeric(13,2),
    cvg_stat_cd varchar(1),
    cvg_prem numeric(11,2),
    cvg_typ varchar(1),
    face_ratg numeric(5,2),
    smkr_code varchar(1),
    cvg_eff_age numeric(3),
    plan_shrt_desc varchar(20),
    mode_fct_mo numeric(6,5),
    mode_fct_qtr numeric(6,5),
    mode_fct_semi numeric(6,5)
);

CREATE TABLE IF NOT EXISTS cas.twrk_rasal201_h (
    user_id varchar(10) not null,
    request_id numeric(10) not null,
    caller_typ varchar(10),
    id_num varchar(20),
    cli_nm varchar(60),
    birth_dt timestamp,
    sex_code varchar(10),
    excl_pol_num varchar(10),
    srch_id varchar(20),
    dtl_xist varchar(1),
    team_id varchar(2),
    pol_num varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_rasal201_ncas_cvg (
    user_id varchar(10) not null,
    request_id numeric(10) not null,
    cli_num varchar(13),
    pol_num varchar(10),
    plan_code varchar(10),
    pol_stat_cd varchar(10),
    pol_eff_dt timestamp,
    vers_num varchar(2),
    face_amt numeric(13,2),
    cvg_stat_cd varchar(1),
    cvg_prem numeric(11,2),
    cvg_typ varchar(1),
    face_ratg numeric(5,2),
    smkr_code varchar(1),
    cvg_eff_age numeric(3),
    plan_shrt_desc varchar(20),
    mode_fct_mo numeric(6,5),
    mode_fct_qtr numeric(6,5),
    mode_fct_semi numeric(6,5),
    pmt_mode varchar(5)
);

CREATE TABLE IF NOT EXISTS cas.twrk_rasal201_pol_dtl (
    user_id varchar(10) not null,
    request_id varchar(10) not null,
    pol_num varchar(50) not null,
    link_typ varchar(10) not null,
    crcy_code varchar(2) not null,
    risk_typ varchar(10) not null,
    risk_typ_desc varchar(255),
    risk_amt numeric(18,2),
    risk_prem numeric(18,2),
    request_dt timestamp DEFAULT CURRENT_TIMESTAMP,
    cli_num varchar(13) not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_rcc_bill_extracts (
    run_dt timestamp,
    bill_mthd varchar(1),
    fran_num varchar(4),
    pol_num varchar(10),
    pol_crcy_code varchar(2),
    pd_to_dt timestamp,
    prem_amt numeric(11,2),
    pmt_susp numeric(11,2),
    bill_amt numeric(11,2),
    sa_cd_1 varchar(6),
    sa_cd_2 varchar(6),
    client_nm varchar(80),
    card_num varchar(20),
    card_typ varchar(1),
    card_iss_bank varchar(13),
    card_holder_id_typ varchar(1),
    card_holder_id_num varchar(20),
    card_holder_name varchar(60),
    card_xpry_dt timestamp,
    bill_status varchar(1),
    trxn_dt timestamp,
    bank_process_dt timestamp,
    cc_fee_ind varchar(1),
    cc_fee_amt numeric(11,4),
    cwa_susp numeric(13,2),
    card_cat varchar(1),
    pol_iss_dt timestamp,
    rcc_type varchar(20)
);

CREATE TABLE IF NOT EXISTS cas.twrk_rcpt_rpt_parm (
    btch_num varchar(20) not null,
    btch_role varchar(20) not null,
    pol_num varchar(10) not null,
    cbd_num varchar(4) not null,
    trxn_dt timestamp not null,
    user_id varchar(30),
    status_flg varchar(1),
    rcpt_num numeric(10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_reconcile_unit_daily (
    run_dt timestamp,
    fnd_id varchar(5),
    plan_code varchar(50),
    trxn_cd varchar(10),
    trxn_dt timestamp,
    trxn_desc varchar(500),
    sub_cas_reg_switch varchar(100),
    sub_cas_unit numeric(25,10),
    sub_cas_nav numeric(25,10),
    sub_cas_amt numeric(13,2),
    sub_mamt_reg_switch varchar(100),
    sub_mamt_unit numeric(25,10),
    sub_mamt_nav numeric(25,10),
    sub_mamt_amt numeric(13,2),
    sub_diff numeric(25,10),
    redm_unit numeric(25,10),
    redm_avg_cost numeric(25,10),
    redm_cost numeric(25,10),
    redm_deduct_cas numeric(25,10),
    redm_seg_gl_cost numeric(25,10),
    redm_recpt_amt numeric(25,10),
    redm_gen_gl_recpt numeric(25,10),
    redm_total_gl numeric(25,10),
    bal_cas_unit numeric(25,10),
    bal_cas_avg_cost numeric(25,10),
    bal_cas_amt numeric(25,10),
    bal_mamt_unit numeric(25,10),
    bal_mamt_avg_cost numeric(25,10),
    bal_mamt_amt numeric(25,10),
    mamt_redm_unit numeric(25,10),
    mamt_redm_nav numeric(25,10),
    mamt_redm_amt numeric(25,10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_redo_schedules (
    pol_num varchar(10) not null,
    trxn_dt timestamp not null,
    trxn_cd varchar(8) not null,
    trxn_desc varchar(200) not null,
    trxn_id varchar(15)
);

CREATE TABLE IF NOT EXISTS cas.twrk_replacements_sg (
    seq_num numeric(9),
    agt_name varchar(40),
    ins_id_num varchar(20),
    ins_name varchar(60),
    disc_pol_num varchar(10),
    disc_plan_desc varchar(50),
    disc_mode_desc varchar(20),
    disc_mode_prem numeric(11,2),
    disc_status varchar(50),
    disc_trmn_date timestamp,
    disc_pd_to_dt timestamp,
    rep_pol_num varchar(10),
    rep_plan_desc varchar(50),
    rep_mode_desc varchar(20),
    rep_mode_prem numeric(11,2),
    rep_status varchar(50),
    rep_iss_date timestamp,
    rep_eff_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_repl_no_crr_sg (
    causing_pol_co_cd varchar(2),
    causing_pol_crcy_code varchar(2),
    causing_pol_num varchar(20),
    causing_pmt_mode varchar(5),
    causing_mode_prem numeric(11,2),
    repl_start_dt timestamp,
    repl_end_dt timestamp,
    repl_reasn_code varchar(3),
    causing_agt_code varchar(6),
    insured_id_typ varchar(1),
    insured_id_num varchar(20),
    insured_nm varchar(60),
    payer_id_typ varchar(1),
    payer_id_num varchar(20),
    payer_nm varchar(60),
    restr_pol_crcy_code varchar(2),
    restr_pol_num varchar(10),
    mode_prem numeric(11,2),
    pol_iss_dt timestamp,
    pmt_mode varchar(5),
    business_typ varchar(3),
    pol_stat_cd varchar(1),
    top_up_layer_eff_dt timestamp,
    top_up_layer_stat_cd varchar(1),
    top_up_layer_prem numeric(11,2),
    scan_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_repl_restr_sg (
    restr_br_code varchar(5),
    restr_unit_code varchar(5),
    restr_agt_code varchar(5),
    causing_pol_co_cd varchar(2),
    causing_pol_crcy_code varchar(2),
    causing_pol_num varchar(20),
    restr_pol_crcy_code varchar(2),
    restr_pol_num varchar(10),
    pol_iss_dt timestamp,
    business_typ varchar(3),
    restr_comm_amt numeric(11,2),
    restr_pc_amt numeric(9),
    restr_case_ctr numeric(5,2),
    restr_afyc_amt numeric(9),
    restr_anp_amt numeric(11,2),
    restr_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_rpt_rgtr (
    pol_num varchar(10) not null,
    trxn_id varchar(15) not null,
    proc_cd varchar(10) not null,
    proc_typ varchar(10) not null,
    trxn_dt timestamp not null,
    eff_dt timestamp not null,
    user_id varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.twrk_rseppol3_sg (
    seq_num numeric(10),
    textline varchar(4000)
);

CREATE TABLE IF NOT EXISTS cas.twrk_stale (
    pol_num varchar(10) not null,
    amount numeric(11,2) not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_stale_cmp (
    pol_num varchar(10),
    pay_to varchar(60),
    amount numeric(11,2),
    bank_code varchar(10),
    bank_accdt_name varchar(60),
    effective_dt timestamp,
    bank_acct_num varchar(15)
);

CREATE TABLE IF NOT EXISTS cas.twrk_sun (
    num varchar(10),
    trxn numeric(15,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_sun_dload (
    sun_acct_num varchar(10),
    trxn_dt timestamp,
    cd_or_dr varchar(1),
    acct_gen_amt numeric(13,2),
    t0 varchar(10),
    t1 varchar(10),
    t2 varchar(10),
    t3 varchar(10),
    t4 varchar(10),
    t5 varchar(10),
    t6 varchar(10),
    t7 varchar(10),
    t8 varchar(10),
    t9 varchar(10)
);

CREATE TABLE IF NOT EXISTS cas.twrk_sun_extract (
    acct_num varchar(15) not null,
    acct_year varchar(4) not null,
    acct_mon varchar(2) not null,
    trxn_dt timestamp not null,
    rec_typ varchar(1),
    cr_or_dr varchar(1),
    jur_typ varchar(5),
    crcy_code varchar(5) not null,
    trxn_amt numeric(18) not null,
    dec varchar(1),
    comp_code varchar(15),
    fund_id varchar(15),
    lob varchar(15),
    prod_code varchar(5),
    terr_code varchar(2),
    br_code varchar(5),
    pi_rj_jnl varchar(10),
    sub_ldg varchar(10),
    par_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_sun_extract_acc (
    acct_num varchar(15) not null,
    acct_year varchar(4) not null,
    acct_mon varchar(2) not null,
    trxn_dt timestamp not null,
    rec_typ varchar(1),
    cr_or_dr varchar(1),
    jur_typ varchar(5),
    crcy_code varchar(5) not null,
    trxn_amt numeric(16,2) not null,
    dec varchar(1),
    comp_code varchar(15),
    fund_id varchar(15),
    lob varchar(15),
    prod_code varchar(5),
    terr_code varchar(2),
    br_code varchar(5),
    pi_rj_jnl varchar(10),
    sub_ldg varchar(10),
    par_ind varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_tax (
    request_id numeric(10),
    comp_id varchar(13) not null,
    comp_titl varchar(100) not null,
    comp_nm varchar(160) not null,
    tax_typ varchar(2),
    policy_status varchar(1),
    policy_sub_status varchar(1),
    pol_trmn_dt timestamp,
    off_rcpt_num varchar(50),
    rcpt_dt timestamp,
    taxable_prem numeric(15,2),
    benefit_typ varchar(1),
    pol_num varchar(10) not null,
    pol_eff_dt timestamp,
    prem_dur numeric(2),
    bnft_dur numeric(2),
    id_num varchar(13) not null,
    cli_title varchar(100),
    cli_nm varchar(150) not null,
    cli_last_nm varchar(150),
    id_num_p varchar(13) not null,
    cli_title_p varchar(100),
    cli_nm_p varchar(150) not null,
    cli_last_nm_p varchar(150),
    edit_dt timestamp,
    trxn_typ varchar(1),
    plan varchar(50),
    plan_typ varchar(50),
    tax_yr varchar(4),
    create_dt timestamp,
    trxn_id varchar(15),
    trxn_dt timestamp,
    rev_prem varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_tax_certificate_th (
    wht_num varchar(10),
    dnr_num numeric(4),
    trxn_num numeric(10),
    wht_dt timestamp,
    clinic_code varchar(6),
    payo_typ varchar(10),
    payee_typ_mp varchar(1),
    wht_tax numeric(5,2),
    gross_amt numeric(11,2),
    tax_amt numeric(11,2),
    issue_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_tax_hl (
    request_id numeric(10),
    comp_id varchar(13) not null,
    comp_titl varchar(100) not null,
    comp_nm varchar(160) not null,
    rcpt_dt timestamp,
    off_rcpt_num varchar(50) not null,
    id_num varchar(13) not null,
    cli_title varchar(100),
    cli_nm varchar(160) not null,
    cli_last_nm varchar(80),
    taxable_prem numeric(15,2),
    pol_num varchar(10) not null,
    plan varchar(50),
    plan_typ varchar(50),
    edit_dt timestamp,
    trxn_typ varchar(1),
    tax_yr varchar(4),
    create_dt timestamp,
    trxn_id varchar(15),
    trxn_dt timestamp,
    rev_prem varchar(1)
);

CREATE TABLE IF NOT EXISTS cas.twrk_tfield_values_id (
    fld_nm varchar(30) not null,
    fld_valu varchar(10) not null,
    fld_valu_desc varchar(150) not null,
    rec_status varchar(1) not null,
    fld_valu_desc_eng varchar(50),
    fld_lkup_valu varchar(10),
    app_cd varchar(3)
);

CREATE TABLE IF NOT EXISTS cas.twrk_thank_you_ltr (
    request_id numeric(10) not null,
    pol_num varchar(10) not null,
    ltr_typ varchar(1) not null,
    base_plan_code varchar(5) not null,
    pol_yr numeric(3) not null,
    renewal_code varchar(1) not null,
    ins_nm varchar(60),
    mode_prem numeric(11,2),
    pd_to_dt_desc varchar(40),
    agt_nm varchar(80),
    sup_nm varchar(60),
    cvg_end_dt timestamp,
    last_printed_dt timestamp
);

CREATE TABLE IF NOT EXISTS cas.twrk_tot_prem (
    pol_num varchar(10) not null,
    year numeric(4) not null,
    prem_jan numeric(13,2),
    prem_jan_cas numeric(13,2),
    prem_jan_pallm numeric(13,2),
    prem_feb numeric(13,2),
    prem_mar numeric(13,2),
    prem_apr numeric(13,2),
    prem_may numeric(13,2),
    prem_jun numeric(13,2),
    prem_jul numeric(13,2),
    prem_aug numeric(13,2),
    prem_sep numeric(13,2),
    prem_oct numeric(13,2),
    prem_nov numeric(13,2),
    prem_dec numeric(13,2),
    batch_no integer,
    prem_adj numeric(13,2),
    seq_no integer,
    prem_rfnd numeric(13,2),
    sum_insured numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_tot_prem_regen (
    pol_num varchar(10),
    prem_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_ul_tb_lst_sg (
    acct_num varchar(8),
    acct_desc varchar(100),
    gasia_growth numeric(13,2),
    gbal_growth numeric(13,2),
    gintl_bond numeric(13,2),
    greg_china numeric(13,2),
    gsing_growth numeric(13,2),
    gsea_special numeric(13,2),
    gwld_equity numeric(13,2),
    gglobal_tech numeric(13,2),
    gsure numeric(13,2),
    gglobal_bal numeric(13,2),
    gcash numeric(13,2),
    glife_science numeric(13,2),
    sing_bond numeric(13,2),
    sing_cash numeric(13,2),
    agg_portfolio numeric(13,2),
    growth_portfolio numeric(13,2),
    mod_portfolio numeric(13,2),
    secure_portfolio numeric(13,2),
    cons_portfolio numeric(13,2),
    jp_growth numeric(13,2),
    india_equity numeric(13,2),
    eu_equity numeric(13,2),
    non_unit_link numeric(13,2),
    unit_linked_total numeric(13,2),
    total_link numeric(13,2),
    tb_month varchar(10),
    fu_beacon numeric(13,2),
    fu_asia numeric(13,2),
    jh_adventure numeric(13,2),
    jh_balanced numeric(13,2),
    jh_cautious numeric(13,2),
    jh_european numeric(13,2),
    jh_global_bal numeric(13,2),
    jh_global_tech numeric(13,2),
    jh_china numeric(13,2),
    jh_japan numeric(13,2),
    jh_junior numeric(13,2),
    jh_life_science numeric(13,2),
    jh_pac_equity numeric(13,2),
    money_growth numeric(13,2),
    pac_finance numeric(13,2),
    pac_harvest numeric(13,2),
    sig_capital numeric(13,2),
    sg_cash numeric(13,2),
    ww_bond numeric(13,2),
    ww_equity numeric(13,2),
    fu_bond_sg numeric(13,2),
    fu_global_bal numeric(13,2),
    fu_global_growth numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_ul_tb_temp_sg (
    acct_num varchar(8),
    acct_desc varchar(100),
    gasia_growth numeric(13,2),
    gbal_growth numeric(13,2),
    gintl_bond numeric(13,2),
    greg_china numeric(13,2),
    gsing_growth numeric(13,2),
    gsea_special numeric(13,2),
    gwld_equity numeric(13,2),
    gglobal_tech numeric(13,2),
    gsure numeric(13,2),
    gglobal_bal numeric(13,2),
    gcash numeric(13,2),
    glife_science numeric(13,2),
    sing_bond numeric(13,2),
    sing_cash numeric(13,2),
    agg_portfolio numeric(13,2),
    growth_portfolio numeric(13,2),
    mod_portfolio numeric(13,2),
    secure_portfolio numeric(13,2),
    cons_portfolio numeric(13,2),
    jp_growth numeric(13,2),
    india_equity numeric(13,2),
    eu_equity numeric(13,2),
    non_unit_link numeric(13,2),
    unit_linked_total numeric(13,2),
    total_link numeric(13,2),
    tb_month timestamp,
    fu_beacon numeric(13,2),
    fu_asia numeric(13,2),
    jh_adventure numeric(13,2),
    jh_balanced numeric(13,2),
    jh_cautious numeric(13,2),
    jh_european numeric(13,2),
    jh_global_bal numeric(13,2),
    jh_global_tech numeric(13,2),
    jh_china numeric(13,2),
    jh_japan numeric(13,2),
    jh_junior numeric(13,2),
    jh_life_science numeric(13,2),
    jh_pac_equity numeric(13,2),
    money_growth numeric(13,2),
    pac_finance numeric(13,2),
    pac_harvest numeric(13,2),
    sig_capital numeric(13,2),
    sg_cash numeric(13,2),
    ww_bond numeric(13,2),
    ww_equity numeric(13,2),
    fu_bond_sg numeric(13,2),
    fu_global_bal numeric(13,2),
    fu_global_growth numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_underpay_policys (
    request_id numeric(10) not null,
    pol_num varchar(10) not null,
    eff_dt timestamp not null,
    insrd varchar(60) not null,
    prem_amt numeric(11,2) not null,
    cwa_susp_amt numeric(11,2) not null
);

CREATE TABLE IF NOT EXISTS cas.twrk_valuation_extract (
    stat_code varchar(1) not null,
    pol_num varchar(10) not null,
    plan_code varchar(5) not null,
    riss_age numeric(3) not null,
    insrd_sex varchar(1) not null,
    rface_amt numeric(9) not null,
    pay_mode varchar(2) not null,
    ipo_code varchar(1),
    div_code varchar(1),
    rprem_amt numeric(8),
    div_amt numeric(8),
    pua_amt numeric(9),
    tx_cat varchar(1),
    tx_ppp numeric(2),
    tx_prem numeric(8),
    tx_rate numeric(6),
    pm_cat varchar(1),
    pm_rate numeric(6),
    pm_prem numeric(8),
    insrd_dob_dt timestamp,
    insrd_id varchar(20),
    cat varchar(1),
    pyd_dt timestamp,
    riss_dt timestamp,
    lup_dt timestamp,
    lnb varchar(1),
    pol_prem numeric(8),
    pol_aprm numeric(8),
    iss_dt timestamp,
    pd_to_dt timestamp,
    med_code varchar(1),
    extra_code varchar(1),
    grp_num varchar(4),
    agt_code varchar(6),
    unit_code varchar(5),
    agt_term_dt timestamp,
    crcy_code varchar(2),
    pnp_code varchar(1),
    smok_ind varchar(1),
    ppp numeric(3),
    bpp numeric(3),
    add_code varchar(1),
    wp_code varchar(1),
    pb_code varchar(1),
    pay_age numeric(3),
    base_pln varchar(5),
    pc_earn numeric(9),
    vers_num varchar(2),
    cvg_clas varchar(3),
    pol_stat_cd varchar(1),
    r_dscnt_prem numeric(8),
    txm_ppp numeric(2),
    txm_prem numeric(8),
    txm_rate numeric(6),
    pmm_rate numeric(6),
    pmm_prem numeric(8)
);

CREATE TABLE IF NOT EXISTS cas.twrk_va_disposal (
    cvg_stat_cd varchar(1) not null,
    term_to_maturity numeric not null,
    fnd_id varchar(5) not null,
    fnd_vers varchar(6) not null,
    crcy_cd varchar(2),
    trxn_amt numeric(18,8)
);

CREATE TABLE IF NOT EXISTS cas.twrk_va_rpt (
    trxn_id varchar(15) not null,
    seq_num numeric(5) not null,
    avy_dt timestamp,
    intl_cd varchar(10),
    old_gwb numeric(13,2),
    new_gwb numeric(13,2),
    old_gwa numeric(13,2),
    new_gwa numeric(13,2),
    old_rmn_gwa numeric(13,2),
    new_rmn_gwa numeric(13,2),
    old_ifl numeric(13,2),
    new_ifl numeric(13,2),
    old_rmn_ifl numeric(13,2),
    new_rmn_ifl numeric(13,2),
    old_fnd_valu numeric(13,2),
    new_fnd_valu numeric(13,2),
    old_anty_opt varchar(2),
    new_anty_opt varchar(2),
    old_anty_freq numeric(2),
    new_anty_freq numeric(2),
    old_payo_amt numeric(13,2),
    new_payo_amt numeric(13,2),
    old_anty_start_dt timestamp,
    new_anty_start_dt timestamp,
    old_anty_end_dt timestamp,
    new_anty_end_dt timestamp,
    old_nxt_payo_dt timestamp,
    new_nxt_payo_dt timestamp,
    old_min_payo_amt numeric(13,2),
    new_min_payo_amt numeric(13,2),
    payo_crcy varchar(2),
    payo_mthd varchar(10),
    payo_arang varchar(10),
    tot_pymt numeric(13,2),
    def_bns_amt numeric(13,2)
);

CREATE TABLE IF NOT EXISTS cas.twrk_va_trail_tw (
    trxn_dt timestamp not null,
    trxn_cd varchar(10) not null,
    pol_num varchar(10) not null,
    plan_code varchar(5) not null,
    vers_num varchar(2) not null,
    fnd_id varchar(5),
    fnd_vers varchar(6),
    crcy_cd varchar(2),
    as_of_dt timestamp,
    trxn_amt numeric(18,8)
);

CREATE TABLE IF NOT EXISTS cas.unitbal (
    policy_no varchar(10),
    fund_code varchar(5),
    unit_bal numeric(19,5),
    filler_1 varchar(2),
    eff_date timestamp,
    bare_price numeric(11,5),
    bid_price numeric(11,5),
    off_price numeric(11,5),
    unit_value numeric(20,10),
    fund_name varchar(30)
);

CREATE TABLE IF NOT EXISTS cas.wrk_cli_num (
    cli_num varchar(13)
);

CREATE TABLE IF NOT EXISTS cas.z_owl (
    ctest numeric
);

