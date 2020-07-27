WITH REF_TABLES_LU AS
  (SELECT T1.tvnumsuit,
    trim(t1.tvnomattr) AS tvnomattr,
    trim(t1.tvcodibba) AS tvcodibba,
    trim(t1.tvinddact) AS tvinddact,
    trim(t1.tvnivattr) AS tvnivattr,
    trim(t1.TVCODUTIL) AS TVCODUTIL,
    trim(t1.TVSGLUTIL) AS TVSGLUTIL,
    T1.system,
    t1.system_country,
    trim(t1.TVCODAPPA)                           AS TVCODAPPA,
    MAX(DECODE(t2.insgllan,'0001',t2.ININTCODE)) AS ININTCODE_FR,
    MAX(DECODE(t2.insgllan,'0001',t2.INABRCODE)) AS INABRCODE_FR
  FROM EDW_FL.REF_IBLU_PARAMETER_ATTRIBUTE T1
  LEFT JOIN EDW_FL.REF_IBLU_PARAMETER_ATTRIBUTE_DESCRIPTION T2
  ON T1.tvnumsuit   = T2.innumsuit
  WHERE T1.tvinddact='0'
  GROUP BY T1.tvnumsuit,
    t1.tvnomattr,
    t1.tvcodibba,
    t1.tvinddact,
    t1.tvnivattr,
    t1.TVCODUTIL,
    t1.TVSGLUTIL,
    T1.system,
    t1.system_country,
    t1.TVCODAPPA
  ),
  REF_TABLES_BE AS
  (SELECT  T1.tvnumsuit,
    trim(t1.tvnomattr) AS tvnomattr,
    trim(t1.tvcodibba) AS tvcodibba,
    trim(t1.tvinddact) AS tvinddact,
    trim(t1.tvnivattr) AS tvnivattr,
    trim(t1.TVCODUTIL) AS TVCODUTIL,
    trim(t1.TVSGLUTIL) AS TVSGLUTIL,
    T1.system,
    t1.system_country,
    trim(t1.TVCODAPPA)                           AS TVCODAPPA,
    MAX(DECODE(t2.insgllan,'0001',t2.ININTCODE)) AS ININTCODE_FR,
    MAX(DECODE(t2.insgllan,'0001',t2.INABRCODE)) AS INABRCODE_FR
  FROM EDW_FL.REF_IBBE_PARAMETER_ATTRIBUTE T1
  LEFT JOIN EDW_FL.REF_IBBE_PARAMETER_ATTRIBUTE_DESCRIPTION T2
  ON T1.tvnumsuit   = T2.innumsuit
  WHERE T1.tvinddact='0'
  GROUP BY T1.tvnumsuit,
    t1.tvnomattr,
    t1.tvcodibba,
    t1.tvinddact,
    t1.tvnivattr,
    t1.TVCODUTIL,
    t1.TVSGLUTIL,
    T1.system,
    t1.system_country,
    t1.TVCODAPPA
  ),
  TM_PARAMATER_FLAT_OPE AS
  (
  --
  ----------------
  -- PART ONE  ---
  ----------------
  --
  ----------------
  -- CASH BE    --
  ----------------
  SELECT
    /*+  noparallel */
    t11.opcodetpe    AS CODETPE_DPAR_USER_CODE,
    R11.tvsglutil    AS CODETPE_DPAR_USER_SIGLE,
    R11.inintcode_fr AS CODETPE_DPAR_NAME_FR,
    R11.inabrcode_fr AS CODETPE_DPAR_SHORT_FR,
    --
    NVL(T41.DCMODLIQU,' ')    AS MODLIQU_DPAR_USER_CODE ,
    NVL(R91.tvsglutil,' ')    AS MODLIQU_DPAR_USER_SIGLE,
    NVL(R91.inintcode_fr,' ') AS MODLIQU_DPAR_NAME_FR,
    NVL(R91.inabrcode_fr,' ') AS MODLIQU_DPAR_SHORT_FR,
    --
    NVL(T41.DCINDCLICO,' ')   AS INDCLICO_DPAR_USER_CODE ,
    NVL(R92.tvsglutil,' ')    AS INDCLICO_DPAR_USER_SIGLE,
    NVL(R92.inintcode_fr,' ') AS INDCLICO_DPAR_NAME_FR,
    NVL(R92.inabrcode_fr,' ') AS INDCLICO_DPAR_SHORT_FR,
    --
    NVL(T11.opstatope,' ')    AS STATOPE_DPAR_USER_CODE,
    NVL(R51.tvsglutil,' ')    AS STATOPE_DPAR_USER_SIGLE,
    NVL(R51.inintcode_fr,' ') AS STATOPE_DPAR_NAME_FR,
    NVL(R51.inabrcode_fr,' ') AS STATOPE_DPAR_SHORT_FR,
    --
    NVL(T11.opstaeope,' ')    AS STAEOPE_DPAR_USER_CODE,
    NVL(R41.tvsglutil,' ')    AS STAEOPE_DPAR_USER_SIGLE,
    NVL(R41.inintcode_fr,' ') AS STAEOPE_DPAR_NAME_FR,
    NVL(R41.inabrcode_fr,' ') AS STAEOPE_DPAR_SHORT_FR,
    --
    NVL(T21.fetypfond,' ')    AS TYPFOND_DPAR_USER_CODE,
    NVL(R61.tvsglutil,' ')    AS TYPFOND_DPAR_USER_SIGLE,
    NVL(R61.inintcode_fr,' ') AS TYPFOND_DPAR_NAME_FR,
    NVL(R61.inabrcode_fr,' ') AS TYPFOND_DPAR_SHORT_FR,
    --
    NVL(T21.FECODCPSO,' ')    AS COMPL_PST_DPAR_USER_CODE,
    NVL(R71.tvsglutil,' ')    AS COMPL_PST_DPAR_USER_SIGLE,
    NVL(R71.inintcode_fr,' ') AS COMPL_PST_DPAR_NAME_FR,
    NVL(R71.inabrcode_fr,' ') AS COMPL_PST_DPAR_SHORT_FR,
    --
    NVL(T11.OPCODIBBAP,' ')   AS LEV4_PST_DPAR_USER_CODE,
    NVL(R21.tvsglutil,' ')    AS LEV4_PST_DPAR_USER_SIGLE,
    NVL(R21.inintcode_fr,' ') AS LEV4_PST_DPAR_NAME_FR,
    NVL(R21.inabrcode_fr,' ') AS LEV4_PST_DPAR_SHORT_FR,
    --
    NVL(R32.tvcodibba,' ')    AS LEV3_PST_DPAR_USER_CODE,
    NVL(R32.tvsglutil,' ')    AS LEV3_PST_DPAR_USER_SIGLE,
    NVL(R32.inintcode_fr,' ') AS LEV3_PST_DPAR_NAME_FR,
    NVL(R32.inabrcode_fr,' ') AS LEV3_PST_DPAR_SHORT_FR,
    --
    NVL(R81.tvcodutil,' ')     AS SGLFRCO_DPAR_USER_CODE,
    NVL(R81.tvsglutil,' ')     AS SGLFRCO_DPAR_USER_SIGLE,
    NVL(R81.inintcode_fr,' ')  AS SGLFRCO_DPAR_NAME_FR,
    NVL(R81.inabrcode_fr,' ')  AS SGLFRCO_DPAR_SHORT_FR,
    NVL(T31.AUTYPINT,' ')      AS TYPINT_DPAR_USER_CODE,
    NVL(R101.tvsglutil,' ')    AS TYPINT_DPAR_USER_SIGLE,
    NVL(R101.inintcode_fr,' ') AS TYPINT_DPAR_NAME_FR,
    NVL(R101.inabrcode_fr,' ') AS TYPINT_DPAR_SHORT_FR,
    --
    T11.system_country
  FROM EDW_FL.HUB_TRANSACTION T1
  LEFT OUTER JOIN EDW_FL.SAT_IBBE_TRANSACTION_TRANSACTION T11
  ON T1.TRANSACTION_HKEY = T11.TRANSACTION_HKEY
  LEFT OUTER JOIN REF_TABLES_BE R11
  ON R11.tvcodibba       = T11.opcodetpe
  AND R11.system_country = T11.system_country
  AND R11.tvnomattr      = 'CODETPE'
  AND R11.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_BE R21
  ON R21.tvcodibba       = T11.OPCODIBBAP
  AND R21.system_country = T11.system_country
  AND R21.tvnomattr      = 'SGLPSO'
  AND R21.tvnivattr      = '04'
    --
  LEFT OUTER JOIN REF_TABLES_BE R31
  ON R31.TVCODIBBA       = T11.opcodibbap
  AND R31.system_country = T11.system_country
  AND R31.tvnomattr      = 'SGLPSO'
  AND R31.tvnivattr      = '04'
  LEFT OUTER JOIN REF_TABLES_BE R32
  ON R32.TVNUMSUIT       = R31.TVCODAPPA
  AND R31.system_country = R31.system_country
    --
  LEFT OUTER JOIN REF_TABLES_BE R41
  ON R41.tvcodibba       = T11.opstaeope
  AND R41.system_country = T11.system_country
  AND R41.tvnomattr      = 'STAEOPE'
  AND R41.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_BE R51
  ON R51.tvcodibba       = T11.opstatope
  AND R51.system_country = T11.system_country
  AND R51.tvnomattr      = 'STATOPE'
  AND R51.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.LNK_ACCOUNT_FLOW_TRANSACTION L1
  ON T1.TRANSACTION_HKEY = L1.TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.HUB_ACCOUNT_FLOW T2
  ON L1.ACCOUNT_FLOW_HKEY = T2.ACCOUNT_FLOW_HKEY
  LEFT OUTER JOIN EDW_FL.SAT_IBBE_OPERATION_CASH_ACCOUNT_FLOW T21
  ON T2.ACCOUNT_FLOW_HKEY = T21.ACCOUNT_FLOW_HKEY
  LEFT OUTER JOIN REF_TABLES_BE R61
  ON R61.tvcodibba       = T21.FETYPFOND
  AND R61.system_country = T21.system_country
  AND R61.tvnomattr      = 'TYPFOND'
  AND R61.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_BE R71
  ON R71.tvcodibba       = T21.FECODCPSO
  AND R71.system_country = T21.system_country
  AND R71.tvnomattr      = 'SGLPSO'
  AND R71.tvnivattr      = '04'
    --
  LEFT OUTER JOIN EDW_FL.SAT_IBBE_CHARGE_COMMISION_AMOUNT_ACCOUNT_FLOW T23
  ON T21.FENUMOPER  = T23.FRNUMOPER
  AND T21.FEVERFLUX = T23.FRVERFLUX
  AND T21.FENUMFLUX = T23.FRNUMFLUX
  LEFT OUTER JOIN REF_TABLES_BE R81
  ON R81.tvnumsuit       = T23.FRNUMSFRAI
  AND R81.system_country = T23.system_country
  AND R81.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.LNK_OTHER_INTERVENING_PARTY_ACCOUNT_FLOW L2
  ON T2.ACCOUNT_FLOW_HKEY = L2.ACCOUNT_FLOW_HKEY
  LEFT OUTER JOIN EDW_FL.HUB_OTHER_INTERVENING_PARTY T3
  ON L2.OTHER_INTERVENING_PARTY_HKEY = T3.OTHER_INTERVENING_PARTY_HKEY
  LEFT OUTER JOIN EDW_FL.SAT_IBBE_OTHER_INTERVENING_PARTY T31
  ON T3.OTHER_INTERVENING_PARTY_HKEY = T31.OTHER_INTERVENING_PARTY_HKEY
  LEFT OUTER JOIN REF_TABLES_BE R101
  ON R101.tvcodutil       = T31.AUTYPINT
  AND R101.system_country = T31.system_country
  AND R101.tvnomattr      = 'TYPINT'
  AND R101.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.LNK_STOCK_EXCHANGE_TRANSACTION_TRANSACTION L3
  ON T1.TRANSACTION_HKEY = L3.TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.HUB_STOCK_EXCHANGE_TRANSACTION T4
  ON L3.STOCK_EXCHANGE_TRANSACTION_HKEY = T4.STOCK_EXCHANGE_TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.SAT_IBBE_STOCK_EXCHANGE_TRANSACTION T41
  ON T4.STOCK_EXCHANGE_TRANSACTION_HKEY = T41.STOCK_EXCHANGE_TRANSACTION_HKEY
    --
  LEFT OUTER JOIN REF_TABLES_BE R91
  ON R91.TVCODIBBA       = T41.DCMODLIQU
  AND R91.system_country = T41.system_country
  AND R91.tvnomattr      = 'MODLIQU'
  AND R91.tvnivattr      = '01'
  LEFT OUTER JOIN REF_TABLES_BE R92
  ON R92.TVCODIBBA       = T41.DCINDCLICO
  AND R92.system_country = T41.system_country
  AND R92.tvnomattr      = 'INDCLICO'
  AND R92.tvnivattr      = '01'
    --
  WHERE T1.src_bk LIKE ('%IBBE%')
  AND T1.LOAD_DATE > to_date('20191009 00:00:01','YYYYMMDD HH24:MI:SS')
  ----
  UNION ALL
  ----------------
  -- CASH LU    --
  ----------------
  SELECT
    /*+ noparallel */
    t12.opcodetpe    AS CODETPE_DPAR_USER_CODE,
    R12.tvsglutil    AS CODETPE_DPAR_USER_SIGLE,
    R12.inintcode_fr AS CODETPE_DPAR_NAME_FR,
    R12.inabrcode_fr AS CODETPE_DPAR_SHORT_FR,
    --
    NVL(T42.DCMODLIQU,' ')    AS MODLIQU_DPAR_USER_CODE ,
    NVL(R91.tvsglutil,' ')    AS MODLIQU_DPAR_USER_SIGLE,
    NVL(R91.inintcode_fr,' ') AS MODLIQU_DPAR_NAME_FR,
    NVL(R91.inabrcode_fr,' ') AS MODLIQU_DPAR_SHORT_FR,
    --
    NVL(T42.DCINDCLICO,' ')   AS INDCLICO_DPAR_USER_CODE ,
    NVL(R92.tvsglutil,' ')    AS INDCLICO_DPAR_USER_SIGLE,
    NVL(R92.inintcode_fr,' ') AS INDCLICO_DPAR_NAME_FR,
    NVL(R92.inabrcode_fr,' ') AS INDCLICO_DPAR_SHORT_FR,
    --
    NVL(T12.opstatope,' ')    AS STATOPE_DPAR_USER_CODE,
    NVL(R52.tvsglutil,' ')    AS STATOPE_DPAR_USER_SIGLE,
    NVL(R52.inintcode_fr,' ') AS STATOPE_DPAR_NAME_FR,
    NVL(R52.inabrcode_fr,' ') AS STATOPE_DPAR_SHORT_FR,
    --
    NVL(T12.opstaeope,' ')    AS STAEOPE_DPAR_USER_CODE,
    NVL(R42.tvsglutil,' ')    AS STAEOPE_DPAR_USER_SIGLE,
    NVL(R42.inintcode_fr,' ') AS STAEOPE_DPAR_NAME_FR,
    NVL(R42.inabrcode_fr,' ') AS STAEOPE_DPAR_SHORT_FR,
    --
    NVL(T22.fetypfond,' ')    AS TYPFOND_DPAR_USER_CODE,
    NVL(R62.tvsglutil,' ')    AS TYPFOND_DPAR_USER_SIGLE,
    NVL(R62.inintcode_fr,' ') AS TYPFOND_DPAR_NAME_FR,
    NVL(R62.inabrcode_fr,' ') AS TYPFOND_DPAR_SHORT_FR,
    --
    NVL(T22.FECODCPSO,' ')    AS COMPL_PST_DPAR_USER_CODE,
    NVL(R72.tvsglutil,' ')    AS COMPL_PST_DPAR_USER_SIGLE,
    NVL(R72.inintcode_fr,' ') AS COMPL_PST_DPAR_NAME_FR,
    NVL(R72.inabrcode_fr,' ') AS COMPL_PST_DPAR_SHORT_FR,
    --
    NVL(T12.OPCODIBBAP,' ')   AS LEV4_PST_DPAR_USER_CODE,
    NVL(R22.tvsglutil,' ')    AS LEV4_PST_DPAR_USER_SIGLE,
    NVL(R22.inintcode_fr,' ') AS LEV4_PST_DPAR_NAME_FR,
    NVL(R22.inabrcode_fr,' ') AS LEV4_PST_DPAR_SHORT_FR,
    --
    NVL(R34.tvcodibba,' ')    AS LEV3_PST_DPAR_USER_CODE,
    NVL(R34.tvsglutil,' ')    AS LEV3_PST_DPAR_USER_SIGLE,
    NVL(R34.inintcode_fr,' ') AS LEV3_PST_DPAR_NAME_FR,
    NVL(R34.inabrcode_fr,' ') AS LEV3_PST_DPAR_SHORT_FR,
    --
    NVL(R82.tvcodutil,' ')     AS SGLFRCO_DPAR_USER_CODE,
    NVL(R82.tvsglutil,' ')     AS SGLFRCO_DPAR_USER_SIGLE,
    NVL(R82.inintcode_fr,' ')  AS SGLFRCO_DPAR_NAME_FR,
    NVL(R82.inabrcode_fr,' ')  AS SGLFRCO_DPAR_SHORT_FR,
    NVL(T32.AUTYPINT,' ')      AS TYPINT_DPAR_USER_CODE,
    NVL(R102.tvsglutil,' ')    AS TYPINT_DPAR_USER_SIGLE,
    NVL(R102.inintcode_fr,' ') AS TYPINT_DPAR_NAME_FR,
    NVL(R102.inintcode_fr,' ') AS TYPINT_DPAR_SHORT_FR,
    --
    T12.system_country
  FROM EDW_FL.HUB_TRANSACTION T1
  LEFT OUTER JOIN EDW_FL.SAT_IBLU_TRANSACTION_TRANSACTION T12
  ON T1.TRANSACTION_HKEY = T12.TRANSACTION_HKEY
  LEFT OUTER JOIN REF_TABLES_LU R12
  ON R12.tvcodibba       = T12.opcodetpe
  AND R12.system_country = T12.system_country
  AND R12.tvnomattr      = 'CODETPE'
  AND R12.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_LU R22
  ON R22.tvcodibba       = T12.OPCODIBBAP
  AND R22.system_country = T12.system_country
  AND R22.tvnomattr      = 'SGLPSO'
  AND R22.tvnivattr      = '04'
    --
  LEFT OUTER JOIN REF_TABLES_LU R33
  ON R33.TVCODIBBA       = T12.opcodibbap
  AND R33.system_country = T12.system_country
  AND R33.tvnomattr      = 'SGLPSO'
  AND R33.tvnivattr      = '04'
  LEFT OUTER JOIN REF_TABLES_LU R34
  ON R34.TVNUMSUIT       = R33.TVCODAPPA
  AND R33.system_country = R33.system_country
    --
  LEFT OUTER JOIN REF_TABLES_LU R42
  ON R42.tvcodibba       = T12.opstaeope
  AND R42.system_country = T12.system_country
  AND R42.tvnomattr      = 'STAEOPE'
  AND R42.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_LU R52
  ON R52.tvcodibba       = T12.opstatope
  AND R52.system_country = T12.system_country
  AND R52.tvnomattr      = 'STATOPE'
  AND R52.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.LNK_ACCOUNT_FLOW_TRANSACTION L1
  ON T1.TRANSACTION_HKEY = L1.TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.HUB_ACCOUNT_FLOW T2
  ON L1.ACCOUNT_FLOW_HKEY = T2.ACCOUNT_FLOW_HKEY
  LEFT OUTER JOIN EDW_FL.SAT_IBLU_OPERATION_CASH_ACCOUNT_FLOW T22
  ON T2.ACCOUNT_FLOW_HKEY = T22.ACCOUNT_FLOW_HKEY
  LEFT OUTER JOIN REF_TABLES_LU R62
  ON R62.tvcodibba       = T22.FETYPFOND
  AND R62.system_country = T22.system_country
  AND R62.tvnomattr      = 'TYPFOND'
  AND R62.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_LU R72
  ON R72.tvcodibba       = T22.FECODCPSO
  AND R72.system_country = T22.system_country
  AND R72.tvnomattr      = 'SGLPSO'
  AND R72.tvnivattr      = '04'
    --
  LEFT OUTER JOIN EDW_FL.SAT_IBLU_CHARGE_COMMISION_AMOUNT_ACCOUNT_FLOW T24
  ON T22.FENUMOPER  = T24.FRNUMOPER
  AND T22.FEVERFLUX = T24.FRVERFLUX
  AND T22.FENUMFLUX = T24.FRNUMFLUX
  LEFT OUTER JOIN REF_TABLES_LU R82
  ON R82.tvnumsuit       = T24.FRNUMSFRAI
  AND R82.system_country = T24.system_country
  AND R82.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.LNK_OTHER_INTERVENING_PARTY_ACCOUNT_FLOW L2
  ON T2.ACCOUNT_FLOW_HKEY = L2.ACCOUNT_FLOW_HKEY
  LEFT OUTER JOIN EDW_FL.HUB_OTHER_INTERVENING_PARTY T3
  ON L2.OTHER_INTERVENING_PARTY_HKEY = T3.OTHER_INTERVENING_PARTY_HKEY
  LEFT OUTER JOIN EDW_FL.SAT_IBLU_OTHER_INTERVENING_PARTY T32
  ON T3.OTHER_INTERVENING_PARTY_HKEY = T32.OTHER_INTERVENING_PARTY_HKEY
  LEFT OUTER JOIN REF_TABLES_LU R102
  ON R102.tvcodutil       = T32.AUTYPINT
  AND R102.system_country = T32.system_country
  AND R102.tvnomattr      = 'TYPINT'
  AND R102.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.LNK_STOCK_EXCHANGE_TRANSACTION_TRANSACTION L3
  ON T1.TRANSACTION_HKEY = L3.TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.HUB_STOCK_EXCHANGE_TRANSACTION T4
  ON L3.STOCK_EXCHANGE_TRANSACTION_HKEY = T4.STOCK_EXCHANGE_TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.SAT_IBLU_STOCK_EXCHANGE_TRANSACTION T42
  ON T4.STOCK_EXCHANGE_TRANSACTION_HKEY = T42.STOCK_EXCHANGE_TRANSACTION_HKEY
    --
  LEFT OUTER JOIN REF_TABLES_LU R91
  ON R91.TVCODIBBA       = T42.DCMODLIQU
  AND R91.system_country = T42.system_country
  AND R91.tvnomattr      = 'MODLIQU'
  AND R91.tvnivattr      = '01'
  LEFT OUTER JOIN REF_TABLES_LU R92
  ON R92.TVCODIBBA       = T42.DCINDCLICO
  AND R92.system_country = T42.system_country
  AND R92.tvnomattr      = 'INDCLICO'
  AND R92.tvnivattr      = '01'
    --
  WHERE T1.src_bk LIKE ('%IBLU%')
  AND T1.LOAD_DATE > to_date('20191009 00:00:01','YYYYMMDD HH24:MI:SS')
  --
  UNION ALL
  ----------------
  -- SECU BE    --
  ----------------
  SELECT
    /*+ noparallel */
    t11.opcodetpe    AS CODETPE_DPAR_USER_CODE,
    R11.tvsglutil    AS CODETPE_DPAR_USER_SIGLE,
    R11.inintcode_fr AS CODETPE_DPAR_NAME_FR,
    R11.inabrcode_fr AS CODETPE_DPAR_SHORT_FR,
    --
    NVL(T41.DCMODLIQU,' ')    AS MODLIQU_DPAR_USER_CODE ,
    NVL(R91.tvsglutil,' ')    AS MODLIQU_DPAR_USER_SIGLE,
    NVL(R91.inintcode_fr,' ') AS MODLIQU_DPAR_NAME_FR,
    NVL(R91.inabrcode_fr,' ') AS MODLIQU_DPAR_SHORT_FR,
    --
    NVL(T41.DCINDCLICO,' ')   AS INDCLICO_DPAR_USER_CODE ,
    NVL(R92.tvsglutil,' ')    AS INDCLICO_DPAR_USER_SIGLE,
    NVL(R92.inintcode_fr,' ') AS INDCLICO_DPAR_NAME_FR,
    NVL(R92.inabrcode_fr,' ') AS INDCLICO_DPAR_SHORT_FR,
    --
    NVL(T11.opstatope,' ')    AS STATOPE_DPAR_USER_CODE,
    NVL(R51.tvsglutil,' ')    AS STATOPE_DPAR_USER_SIGLE,
    NVL(R51.inintcode_fr,' ') AS STATOPE_DPAR_NAME_FR,
    NVL(R51.inabrcode_fr,' ') AS STATOPE_DPAR_SHORT_FR,
    --
    NVL(T11.opstaeope,' ')    AS STAEOPE_DPAR_USER_CODE,
    NVL(R41.tvsglutil,' ')    AS STAEOPE_DPAR_USER_SIGLE,
    NVL(R41.inintcode_fr,' ') AS STAEOPE_DPAR_NAME_FR,
    NVL(R41.inabrcode_fr,' ') AS STAEOPE_DPAR_SHORT_FR,
    --
    '0000'                    AS TYPFOND_DPAR_USER_CODE,
    NVL(R61.tvsglutil,' ')    AS TYPFOND_DPAR_USER_SIGLE,
    NVL(R61.inintcode_fr,' ') AS TYPFOND_DPAR_NAME_FR,
    NVL(R61.inabrcode_fr,' ') AS TYPFOND_DPAR_SHORT_FR,
    --
    NVL(T21.FTCODCPSO,' ')    AS COMPL_PST_DPAR_USER_CODE,
    NVL(R71.tvsglutil,' ')    AS COMPL_PST_DPAR_USER_SIGLE,
    NVL(R71.inintcode_fr,' ') AS COMPL_PST_DPAR_NAME_FR,
    NVL(R71.inabrcode_fr,' ') AS COMPL_PST_DPAR_SHORT_FR,
    --
    NVL(T11.OPCODIBBAP,' ')   AS LEV4_PST_DPAR_USER_CODE,
    NVL(R21.tvsglutil,' ')    AS LEV4_PST_DPAR_USER_SIGLE,
    NVL(R21.inintcode_fr,' ') AS LEV4_PST_DPAR_NAME_FR,
    NVL(R21.inabrcode_fr,' ') AS LEV4_PST_DPAR_SHORT_FR,
    --
    NVL(R32.tvcodibba,' ')    AS LEV3_PST_DPAR_USER_CODE,
    NVL(R32.tvsglutil,' ')    AS LEV3_PST_DPAR_USER_SIGLE,
    NVL(R32.inintcode_fr,' ') AS LEV3_PST_DPAR_NAME_FR,
    NVL(R32.inabrcode_fr,' ') AS LEV3_PST_DPAR_SHORT_FR,
    --
    NVL(R81.tvcodutil,' ')     AS SGLFRCO_DPAR_USER_CODE,
    NVL(R81.tvsglutil,' ')     AS SGLFRCO_DPAR_USER_SIGLE,
    NVL(R81.inintcode_fr,' ')  AS SGLFRCO_DPAR_NAME_FR,
    NVL(R81.inabrcode_fr,' ')  AS SGLFRCO_DPAR_SHORT_FR,
    NVL(T31.AUTYPINT,' ')      AS TYPINT_DPAR_USER_CODE,
    NVL(R101.tvsglutil,' ')    AS TYPINT_DPAR_USER_SIGLE,
    NVL(R101.inintcode_fr,' ') AS TYPINT_DPAR_NAME_FR,
    NVL(R101.inabrcode_fr,' ') AS TYPINT_DPAR_SHORT_FR,
    --
    T11.system_country
  FROM EDW_FL.HUB_TRANSACTION T1
  LEFT OUTER JOIN EDW_FL.SAT_IBBE_TRANSACTION_TRANSACTION T11
  ON T1.TRANSACTION_HKEY = T11.TRANSACTION_HKEY
  LEFT OUTER JOIN REF_TABLES_BE R11
  ON R11.tvcodibba       = T11.opcodetpe
  AND R11.system_country = T11.system_country
  AND R11.tvnomattr      = 'CODETPE'
  AND R11.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_BE R21
  ON R21.tvcodibba       = T11.OPCODIBBAP
  AND R21.system_country = T11.system_country
  AND R21.tvnomattr      = 'SGLPSO'
  AND R21.tvnivattr      = '04'
    --
  LEFT OUTER JOIN REF_TABLES_BE R31
  ON R31.TVCODIBBA       = T11.opcodibbap
  AND R31.system_country = T11.system_country
  AND R31.tvnomattr      = 'SGLPSO'
  AND R31.tvnivattr      = '04'
  LEFT OUTER JOIN REF_TABLES_BE R32
  ON R32.TVNUMSUIT       = R31.TVCODAPPA
  AND R31.system_country = R31.system_country
    --
  LEFT OUTER JOIN REF_TABLES_BE R41
  ON R41.tvcodibba       = T11.opstaeope
  AND R41.system_country = T11.system_country
  AND R41.tvnomattr      = 'STAEOPE'
  AND R41.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_BE R51
  ON R51.tvcodibba       = T11.opstatope
  AND R51.system_country = T11.system_country
  AND R51.tvnomattr      = 'STATOPE'
  AND R51.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.LNK_ACCOUNT_FLOW_TRANSACTION L1
  ON T1.TRANSACTION_HKEY = L1.TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.HUB_ACCOUNT_FLOW T2
  ON L1.ACCOUNT_FLOW_HKEY = T2.ACCOUNT_FLOW_HKEY
  LEFT OUTER JOIN EDW_FL.SAT_IBBE_OPERATION_SECURITIES_ACCOUNT_FLOW T21
  ON T21.ACCOUNT_FLOW_HKEY = T2.ACCOUNT_FLOW_HKEY
  LEFT OUTER JOIN REF_TABLES_BE R61
  ON R61.tvcodibba       = '0000'
  AND R61.system_country = T21.system_country
  AND R61.tvnomattr      = 'TYPFOND'
  AND R61.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_BE R71
  ON R71.tvcodibba       = T21.FTCODCPSO
  AND R71.system_country = T21.system_country
  AND R71.tvnomattr      = 'SGLPSO'
  AND R71.tvnivattr      = '04'
    --
  LEFT OUTER JOIN EDW_FL.SAT_IBBE_CHARGE_COMMISION_AMOUNT_ACCOUNT_FLOW T23
  ON T21.FTNUMOPER  = T23.FRNUMOPER
  AND T21.FTVERFLUX = T23.FRVERFLUX
  AND T21.FTNUMFLUX = T23.FRNUMFLUX
  LEFT OUTER JOIN REF_TABLES_BE R81
  ON R81.tvnumsuit       = T23.FRNUMSFRAI
  AND R81.system_country = T23.system_country
  AND R81.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.LNK_OTHER_INTERVENING_PARTY_ACCOUNT_FLOW L2
  ON T2.ACCOUNT_FLOW_HKEY = L2.ACCOUNT_FLOW_HKEY
  LEFT OUTER JOIN EDW_FL.HUB_OTHER_INTERVENING_PARTY T3
  ON L2.OTHER_INTERVENING_PARTY_HKEY = T3.OTHER_INTERVENING_PARTY_HKEY
  LEFT OUTER JOIN EDW_FL.SAT_IBBE_OTHER_INTERVENING_PARTY T31
  ON T3.OTHER_INTERVENING_PARTY_HKEY = T31.OTHER_INTERVENING_PARTY_HKEY
  LEFT OUTER JOIN REF_TABLES_BE R101
  ON R101.tvcodutil       = T31.AUTYPINT
  AND R101.system_country = T31.system_country
  AND R101.tvnomattr      = 'TYPINT'
  AND R101.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.LNK_STOCK_EXCHANGE_TRANSACTION_TRANSACTION L3
  ON T1.TRANSACTION_HKEY = L3.TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.HUB_STOCK_EXCHANGE_TRANSACTION T4
  ON L3.STOCK_EXCHANGE_TRANSACTION_HKEY = T4.STOCK_EXCHANGE_TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.SAT_IBBE_STOCK_EXCHANGE_TRANSACTION T41
  ON T4.STOCK_EXCHANGE_TRANSACTION_HKEY = T41.STOCK_EXCHANGE_TRANSACTION_HKEY
    --
  LEFT OUTER JOIN REF_TABLES_BE R91
  ON R91.TVCODIBBA       = T41.DCMODLIQU
  AND R91.system_country = T41.system_country
  AND R91.tvnomattr      = 'MODLIQU'
  AND R91.tvnivattr      = '01'
  LEFT OUTER JOIN REF_TABLES_BE R92
  ON R92.TVCODIBBA       = T41.DCINDCLICO
  AND R92.system_country = T41.system_country
  AND R92.tvnomattr      = 'INDCLICO'
  AND R92.tvnivattr      = '01'
    --
  WHERE T1.src_bk LIKE ('%IBBE%')
  AND T1.LOAD_DATE > to_date('20191009 00:00:01','YYYYMMDD HH24:MI:SS')
  --
  UNION ALL
  ----------------
  -- SECU LU    --
  ----------------
  SELECT
    /*+ noparallel */
    t12.opcodetpe    AS CODETPE_DPAR_USER_CODE,
    R12.tvsglutil    AS CODETPE_DPAR_USER_SIGLE,
    R12.inintcode_fr AS CODETPE_DPAR_NAME_FR,
    R12.inabrcode_fr AS CODETPE_DPAR_SHORT_FR,
    --
    NVL(T42.DCMODLIQU,' ')    AS MODLIQU_DPAR_USER_CODE ,
    NVL(R91.tvsglutil,' ')    AS MODLIQU_DPAR_USER_SIGLE,
    NVL(R91.inintcode_fr,' ') AS MODLIQU_DPAR_NAME_FR,
    NVL(R91.inabrcode_fr,' ') AS MODLIQU_DPAR_SHORT_FR,
    --
    NVL(T42.DCINDCLICO,' ')   AS INDCLICO_DPAR_USER_CODE ,
    NVL(R92.tvsglutil,' ')    AS INDCLICO_DPAR_USER_SIGLE,
    NVL(R92.inintcode_fr,' ') AS INDCLICO_DPAR_NAME_FR,
    NVL(R92.inabrcode_fr,' ') AS INDCLICO_DPAR_SHORT_FR,
    --
    NVL(T12.opstatope,' ')    AS STATOPE_DPAR_USER_CODE,
    NVL(R52.tvsglutil,' ')    AS STATOPE_DPAR_USER_SIGLE,
    NVL(R52.inintcode_fr,' ') AS STATOPE_DPAR_NAME_FR,
    NVL(R52.inabrcode_fr,' ') AS STATOPE_DPAR_SHORT_FR,
    --
    NVL(T12.opstaeope,' ')    AS STAEOPE_DPAR_USER_CODE,
    NVL(R42.tvsglutil,' ')    AS STAEOPE_DPAR_USER_SIGLE,
    NVL(R42.inintcode_fr,' ') AS STAEOPE_DPAR_NAME_FR,
    NVL(R42.inabrcode_fr,' ') AS STAEOPE_DPAR_SHORT_FR,
    --
    '0000'                    AS TYPFOND_DPAR_USER_CODE,
    NVL(R62.tvsglutil,' ')    AS TYPFOND_DPAR_USER_SIGLE,
    NVL(R62.inintcode_fr,' ') AS TYPFOND_DPAR_NAME_FR,
    NVL(R62.inabrcode_fr,' ') AS TYPFOND_DPAR_SHORT_FR,
    --
    NVL(T22.FTCODCPSO,' ')    AS COMPL_PST_DPAR_USER_CODE,
    NVL(R72.tvsglutil,' ')    AS COMPL_PST_DPAR_USER_SIGLE,
    NVL(R72.inintcode_fr,' ') AS COMPL_PST_DPAR_NAME_FR,
    NVL(R72.inabrcode_fr,' ') AS COMPL_PST_DPAR_SHORT_FR,
    --
    NVL(T12.OPCODIBBAP,' ')   AS LEV4_PST_DPAR_USER_CODE,
    NVL(R22.tvsglutil,' ')    AS LEV4_PST_DPAR_USER_SIGLE,
    NVL(R22.inintcode_fr,' ') AS LEV4_PST_DPAR_NAME_FR,
    NVL(R22.inabrcode_fr,' ') AS LEV4_PST_DPAR_SHORT_FR,
    --
    NVL(R34.tvcodibba,' ')    AS LEV3_PST_DPAR_USER_CODE,
    NVL(R34.tvsglutil,' ')    AS LEV3_PST_DPAR_USER_SIGLE,
    NVL(R34.inintcode_fr,' ') AS LEV3_PST_DPAR_NAME_FR,
    NVL(R34.inabrcode_fr,' ') AS LEV3_PST_DPAR_SHORT_FR,
    --
    NVL(R82.tvcodutil,' ')     AS SGLFRCO_DPAR_USER_CODE,
    NVL(R82.tvsglutil,' ')     AS SGLFRCO_DPAR_USER_SIGLE,
    NVL(R82.inintcode_fr,' ')  AS SGLFRCO_DPAR_NAME_FR,
    NVL(R82.inabrcode_fr,' ')  AS SGLFRCO_DPAR_SHORT_FR,
    NVL(T32.AUTYPINT,' ')      AS TYPINT_DPAR_USER_CODE,
    NVL(R102.tvsglutil,' ')    AS TYPINT_DPAR_USER_SIGLE,
    NVL(R102.inintcode_fr,' ') AS TYPINT_DPAR_NAME_FR,
    NVL(R102.inintcode_fr,' ') AS TYPINT_DPAR_SHORT_FR,
    --
    T12.system_country
  FROM EDW_FL.HUB_TRANSACTION T1
  LEFT OUTER JOIN EDW_FL.SAT_IBLU_TRANSACTION_TRANSACTION T12
  ON T1.TRANSACTION_HKEY = T12.TRANSACTION_HKEY
  LEFT OUTER JOIN REF_TABLES_LU R12
  ON R12.tvcodibba       = T12.opcodetpe
  AND R12.system_country = T12.system_country
  AND R12.tvnomattr      = 'CODETPE'
  AND R12.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_LU R22
  ON R22.tvcodibba       = T12.OPCODIBBAP
  AND R22.system_country = T12.system_country
  AND R22.tvnomattr      = 'SGLPSO'
  AND R22.tvnivattr      = '04'
    --
  LEFT OUTER JOIN REF_TABLES_LU R33
  ON R33.TVCODIBBA       = T12.opcodibbap
  AND R33.system_country = T12.system_country
  AND R33.tvnomattr      = 'SGLPSO'
  AND R33.tvnivattr      = '04'
  LEFT OUTER JOIN REF_TABLES_LU R34
  ON R34.TVNUMSUIT       = R33.TVCODAPPA
  AND R33.system_country = R33.system_country
    --
  LEFT OUTER JOIN REF_TABLES_LU R42
  ON R42.tvcodibba       = T12.opstaeope
  AND R42.system_country = T12.system_country
  AND R42.tvnomattr      = 'STAEOPE'
  AND R42.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_LU R52
  ON R52.tvcodibba       = T12.opstatope
  AND R52.system_country = T12.system_country
  AND R52.tvnomattr      = 'STATOPE'
  AND R52.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.LNK_ACCOUNT_FLOW_TRANSACTION L1
  ON T1.TRANSACTION_HKEY = L1.TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.HUB_ACCOUNT_FLOW T2
  ON L1.ACCOUNT_FLOW_HKEY = T2.ACCOUNT_FLOW_HKEY
  LEFT OUTER JOIN EDW_FL.SAT_IBLU_OPERATION_SECURITIES_ACCOUNT_FLOW T22
  ON T2.ACCOUNT_FLOW_HKEY = T22.ACCOUNT_FLOW_HKEY
  LEFT OUTER JOIN REF_TABLES_LU R62
  ON R62.tvcodibba       = '0000'
  AND R62.system_country = T22.system_country
  AND R62.tvnomattr      = 'TYPFOND'
  AND R62.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_LU R72
  ON R72.tvcodibba       = T22.FTCODCPSO
  AND R72.system_country = T22.system_country
  AND R72.tvnomattr      = 'SGLPSO'
  AND R72.tvnivattr      = '04'
    --
  LEFT OUTER JOIN EDW_FL.SAT_IBLU_CHARGE_COMMISION_AMOUNT_ACCOUNT_FLOW T24
  ON T22.FTNUMOPER  = T24.FRNUMOPER
  AND T22.FTVERFLUX = T24.FRVERFLUX
  AND T22.FTNUMFLUX = T24.FRNUMFLUX
  LEFT OUTER JOIN REF_TABLES_LU R82
  ON R82.tvnumsuit       = T24.FRNUMSFRAI
  AND R82.system_country = T24.system_country
  AND R82.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.LNK_OTHER_INTERVENING_PARTY_ACCOUNT_FLOW L2
  ON T2.ACCOUNT_FLOW_HKEY = L2.ACCOUNT_FLOW_HKEY
  LEFT OUTER JOIN EDW_FL.HUB_OTHER_INTERVENING_PARTY T3
  ON L2.OTHER_INTERVENING_PARTY_HKEY = T3.OTHER_INTERVENING_PARTY_HKEY
  LEFT OUTER JOIN EDW_FL.SAT_IBLU_OTHER_INTERVENING_PARTY T32
  ON T3.OTHER_INTERVENING_PARTY_HKEY = T32.OTHER_INTERVENING_PARTY_HKEY
  LEFT OUTER JOIN REF_TABLES_LU R102
  ON R102.tvcodutil       = T32.AUTYPINT
  AND R102.system_country = T32.system_country
  AND R102.tvnomattr      = 'TYPINT'
  AND R102.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.LNK_STOCK_EXCHANGE_TRANSACTION_TRANSACTION L3
  ON T1.TRANSACTION_HKEY = L3.TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.HUB_STOCK_EXCHANGE_TRANSACTION T4
  ON L3.STOCK_EXCHANGE_TRANSACTION_HKEY = T4.STOCK_EXCHANGE_TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.SAT_IBLU_STOCK_EXCHANGE_TRANSACTION T42
  ON T4.STOCK_EXCHANGE_TRANSACTION_HKEY = T42.STOCK_EXCHANGE_TRANSACTION_HKEY
    --
  LEFT OUTER JOIN REF_TABLES_LU R91
  ON R91.TVCODIBBA       = T42.DCMODLIQU
  AND R91.system_country = T42.system_country
  AND R91.tvnomattr      = 'MODLIQU'
  AND R91.tvnivattr      = '01'
  LEFT OUTER JOIN REF_TABLES_LU R92
  ON R92.TVCODIBBA       = T42.DCINDCLICO
  AND R92.system_country = T42.system_country
  AND R92.tvnomattr      = 'INDCLICO'
  AND R92.tvnivattr      = '01'
    --
  WHERE T1.src_bk LIKE ('%IBLU%')
  AND T1.LOAD_DATE > to_date('20191009 00:00:01','YYYYMMDD HH24:MI:SS')
  --
  ----------------
  -- PART TWO  ---
  ----------------
  --
  UNION ALL
  ----------------
  -- CASH BE    --
  ----------------
  --
  SELECT
    /*+ noparallel */
    t11.opcodetpe    AS CODETPE_DPAR_USER_CODE,
    R11.tvsglutil    AS CODETPE_DPAR_USER_SIGLE,
    R11.inintcode_fr AS CODETPE_DPAR_NAME_FR,
    R11.inabrcode_fr AS CODETPE_DPAR_SHORT_FR,
    --
    NVL(T41.DCMODLIQU,' ')    AS MODLIQU_DPAR_USER_CODE ,
    NVL(R91.tvsglutil,' ')    AS MODLIQU_DPAR_USER_SIGLE,
    NVL(R91.inintcode_fr,' ') AS MODLIQU_DPAR_NAME_FR,
    NVL(R91.inabrcode_fr,' ') AS MODLIQU_DPAR_SHORT_FR,
    --
    NVL(T41.DCINDCLICO,' ')   AS INDCLICO_DPAR_USER_CODE ,
    NVL(R92.tvsglutil,' ')    AS INDCLICO_DPAR_USER_SIGLE,
    NVL(R92.inintcode_fr,' ') AS INDCLICO_DPAR_NAME_FR,
    NVL(R92.inabrcode_fr,' ') AS INDCLICO_DPAR_SHORT_FR,
    --
    NVL(T11.opstatope,' ')    AS STATOPE_DPAR_USER_CODE,
    NVL(R51.tvsglutil,' ')    AS STATOPE_DPAR_USER_SIGLE,
    NVL(R51.inintcode_fr,' ') AS STATOPE_DPAR_NAME_FR,
    NVL(R51.inabrcode_fr,' ') AS STATOPE_DPAR_SHORT_FR,
    --
    NVL(T11.opstaeope,' ')    AS STAEOPE_DPAR_USER_CODE,
    NVL(R41.tvsglutil,' ')    AS STAEOPE_DPAR_USER_SIGLE,
    NVL(R41.inintcode_fr,' ') AS STAEOPE_DPAR_NAME_FR,
    NVL(R41.inabrcode_fr,' ') AS STAEOPE_DPAR_SHORT_FR,
    --
    NVL(T21.fetypfond,' ')    AS TYPFOND_DPAR_USER_CODE,
    NVL(R61.tvsglutil,' ')    AS TYPFOND_DPAR_USER_SIGLE,
    NVL(R61.inintcode_fr,' ') AS TYPFOND_DPAR_NAME_FR,
    NVL(R61.inabrcode_fr,' ') AS TYPFOND_DPAR_SHORT_FR,
    --
    NVL(T21.FECODCPSO,' ')    AS COMPL_PST_DPAR_USER_CODE,
    NVL(R71.tvsglutil,' ')    AS COMPL_PST_DPAR_USER_SIGLE,
    NVL(R71.inintcode_fr,' ') AS COMPL_PST_DPAR_NAME_FR,
    NVL(R71.inabrcode_fr,' ') AS COMPL_PST_DPAR_SHORT_FR,
    --
    NVL(T11.OPCODIBBAP,' ')   AS LEV4_PST_DPAR_USER_CODE,
    NVL(R21.tvsglutil,' ')    AS LEV4_PST_DPAR_USER_SIGLE,
    NVL(R21.inintcode_fr,' ') AS LEV4_PST_DPAR_NAME_FR,
    NVL(R21.inabrcode_fr,' ') AS LEV4_PST_DPAR_SHORT_FR,
    --
    NVL(R32.tvcodibba,' ')    AS LEV3_PST_DPAR_USER_CODE,
    NVL(R32.tvsglutil,' ')    AS LEV3_PST_DPAR_USER_SIGLE,
    NVL(R32.inintcode_fr,' ') AS LEV3_PST_DPAR_NAME_FR,
    NVL(R32.inabrcode_fr,' ') AS LEV3_PST_DPAR_SHORT_FR,
    --
    NVL(R81.tvcodutil,' ')     AS SGLFRCO_DPAR_USER_CODE,
    NVL(R81.tvsglutil,' ')     AS SGLFRCO_DPAR_USER_SIGLE,
    NVL(R81.inintcode_fr,' ')  AS SGLFRCO_DPAR_NAME_FR,
    NVL(R81.inabrcode_fr,' ')  AS SGLFRCO_DPAR_SHORT_FR,
    NVL(T31.AUTYPINT,' ')      AS TYPINT_DPAR_USER_CODE,
    NVL(R101.tvsglutil,' ')    AS TYPINT_DPAR_USER_SIGLE,
    NVL(R101.inintcode_fr,' ') AS TYPINT_DPAR_NAME_FR,
    NVL(R101.inabrcode_fr,' ') AS TYPINT_DPAR_SHORT_FR,
    --
    T11.system_country
  FROM EDW_FL.HUB_TRANSACTION T1
  LEFT OUTER JOIN EDW_FL.SAT_IBBE_TRANSACTION_TRANSACTION T11
  ON T1.TRANSACTION_HKEY = T11.TRANSACTION_HKEY
  LEFT OUTER JOIN REF_TABLES_BE R11
  ON R11.tvcodibba       = T11.opcodetpe
  AND R11.system_country = T11.system_country
  AND R11.tvnomattr      = 'CODETPE'
  AND R11.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_BE R21
  ON R21.tvcodibba       = T11.OPCODIBBAP
  AND R21.system_country = T11.system_country
  AND R21.tvnomattr      = 'SGLPSO'
  AND R21.tvnivattr      = '04'
    --
  LEFT OUTER JOIN REF_TABLES_BE R31
  ON R31.TVCODIBBA       = T11.opcodibbap
  AND R31.system_country = T11.system_country
  AND R31.tvnomattr      = 'SGLPSO'
  AND R31.tvnivattr      = '04'
  LEFT OUTER JOIN REF_TABLES_BE R32
  ON R32.TVNUMSUIT       = R31.TVCODAPPA
  AND R31.system_country = R31.system_country
    --
  LEFT OUTER JOIN REF_TABLES_BE R41
  ON R41.tvcodibba       = T11.opstaeope
  AND R41.system_country = T11.system_country
  AND R41.tvnomattr      = 'STAEOPE'
  AND R41.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_BE R51
  ON R51.tvcodibba       = T11.opstatope
  AND R51.system_country = T11.system_country
  AND R51.tvnomattr      = 'STATOPE'
  AND R51.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.LNK_ACCOUNT_FLOW_TRANSACTION L1
  ON T1.TRANSACTION_HKEY = L1.TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.HUB_ACCOUNT_FLOW T2
  ON L1.ACCOUNT_FLOW_HKEY = T2.ACCOUNT_FLOW_HKEY
  LEFT OUTER JOIN EDW_FL.SAT_IBBE_OPERATION_CASH_ACCOUNT_FLOW T21
  ON T2.ACCOUNT_FLOW_HKEY = T21.ACCOUNT_FLOW_HKEY
  LEFT OUTER JOIN REF_TABLES_BE R61
  ON R61.tvcodibba       = T21.FETYPFOND
  AND R61.system_country = T21.system_country
  AND R61.tvnomattr      = 'TYPFOND'
  AND R61.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_BE R71
  ON R71.tvcodibba       = T21.FECODCPSO
  AND R71.system_country = T21.system_country
  AND R71.tvnomattr      = 'SGLPSO'
  AND R71.tvnivattr      = '04'
    --
  LEFT OUTER JOIN EDW_FL.SAT_IBBE_CHARGE_COMMISION_AMOUNT_ACCOUNT_FLOW T23
  ON T21.FENUMOPER  = T23.FRNUMOPER
  AND T21.FEVERFLUX = T23.FRVERFLUX
  AND T21.FENUMFLUX = T23.FRNUMFLUX
  LEFT OUTER JOIN REF_TABLES_BE R81
  ON R81.tvnumsuit       = T23.FRNUMSFRAI
  AND R81.system_country = T23.system_country
  AND R81.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.SAT_IBBE_OTHER_INTERVENING_PARTY T31
  ON T21.fenumflux       = T31.aunumflux
  AND T21.feverflux      = T31.auverflux
  AND T21.fenumoper      = T31.aunumoper
  AND t21.fetypint       =T31.autypint
  AND T21.system_country = T31.system_country
  LEFT OUTER JOIN REF_TABLES_BE R101
  ON R101.tvcodutil       = T31.AUTYPINT
  AND R101.system_country = T31.system_country
  AND R101.tvnomattr      = 'TYPINT'
  AND R101.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.LNK_STOCK_EXCHANGE_TRANSACTION_TRANSACTION L3
  ON T1.TRANSACTION_HKEY = L3.TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.HUB_STOCK_EXCHANGE_TRANSACTION T4
  ON L3.STOCK_EXCHANGE_TRANSACTION_HKEY = T4.STOCK_EXCHANGE_TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.SAT_IBBE_STOCK_EXCHANGE_TRANSACTION T41
  ON T4.STOCK_EXCHANGE_TRANSACTION_HKEY = T41.STOCK_EXCHANGE_TRANSACTION_HKEY
    --
  LEFT OUTER JOIN REF_TABLES_BE R91
  ON R91.TVCODIBBA       = T41.DCMODLIQU
  AND R91.system_country = T41.system_country
  AND R91.tvnomattr      = 'MODLIQU'
  AND R91.tvnivattr      = '01'
  LEFT OUTER JOIN REF_TABLES_BE R92
  ON R92.TVCODIBBA       = T41.DCINDCLICO
  AND R92.system_country = T41.system_country
  AND R92.tvnomattr      = 'INDCLICO'
  AND R92.tvnivattr      = '01'
    --
  WHERE T1.src_bk LIKE ('%IBBE%')
  AND T1.LOAD_DATE > to_date('20191009 00:00:01','YYYYMMDD HH24:MI:SS')
  ----
  UNION ALL
  ----------------
  -- CASH LU    --
  ----------------
  SELECT
    /*+ noparallel */
    t12.opcodetpe    AS CODETPE_DPAR_USER_CODE,
    R12.tvsglutil    AS CODETPE_DPAR_USER_SIGLE,
    R12.inintcode_fr AS CODETPE_DPAR_NAME_FR,
    R12.inabrcode_fr AS CODETPE_DPAR_SHORT_FR,
    --
    NVL(T42.DCMODLIQU,' ')    AS MODLIQU_DPAR_USER_CODE ,
    NVL(R91.tvsglutil,' ')    AS MODLIQU_DPAR_USER_SIGLE,
    NVL(R91.inintcode_fr,' ') AS MODLIQU_DPAR_NAME_FR,
    NVL(R91.inabrcode_fr,' ') AS MODLIQU_DPAR_SHORT_FR,
    --
    NVL(T42.DCINDCLICO,' ')   AS INDCLICO_DPAR_USER_CODE ,
    NVL(R92.tvsglutil,' ')    AS INDCLICO_DPAR_USER_SIGLE,
    NVL(R92.inintcode_fr,' ') AS INDCLICO_DPAR_NAME_FR,
    NVL(R92.inabrcode_fr,' ') AS INDCLICO_DPAR_SHORT_FR,
    --
    NVL(T12.opstatope,' ')    AS STATOPE_DPAR_USER_CODE,
    NVL(R52.tvsglutil,' ')    AS STATOPE_DPAR_USER_SIGLE,
    NVL(R52.inintcode_fr,' ') AS STATOPE_DPAR_NAME_FR,
    NVL(R52.inabrcode_fr,' ') AS STATOPE_DPAR_SHORT_FR,
    --
    NVL(T12.opstaeope,' ')    AS STAEOPE_DPAR_USER_CODE,
    NVL(R42.tvsglutil,' ')    AS STAEOPE_DPAR_USER_SIGLE,
    NVL(R42.inintcode_fr,' ') AS STAEOPE_DPAR_NAME_FR,
    NVL(R42.inabrcode_fr,' ') AS STAEOPE_DPAR_SHORT_FR,
    --
    NVL(T22.fetypfond,' ')    AS TYPFOND_DPAR_USER_CODE,
    NVL(R62.tvsglutil,' ')    AS TYPFOND_DPAR_USER_SIGLE,
    NVL(R62.inintcode_fr,' ') AS TYPFOND_DPAR_NAME_FR,
    NVL(R62.inabrcode_fr,' ') AS TYPFOND_DPAR_SHORT_FR,
    --
    NVL(T22.FECODCPSO,' ')    AS COMPL_PST_DPAR_USER_CODE,
    NVL(R72.tvsglutil,' ')    AS COMPL_PST_DPAR_USER_SIGLE,
    NVL(R72.inintcode_fr,' ') AS COMPL_PST_DPAR_NAME_FR,
    NVL(R72.inabrcode_fr,' ') AS COMPL_PST_DPAR_SHORT_FR,
    --
    NVL(T12.OPCODIBBAP,' ')   AS LEV4_PST_DPAR_USER_CODE,
    NVL(R22.tvsglutil,' ')    AS LEV4_PST_DPAR_USER_SIGLE,
    NVL(R22.inintcode_fr,' ') AS LEV4_PST_DPAR_NAME_FR,
    NVL(R22.inabrcode_fr,' ') AS LEV4_PST_DPAR_SHORT_FR,
    --
    NVL(R34.tvcodibba,' ')    AS LEV3_PST_DPAR_USER_CODE,
    NVL(R34.tvsglutil,' ')    AS LEV3_PST_DPAR_USER_SIGLE,
    NVL(R34.inintcode_fr,' ') AS LEV3_PST_DPAR_NAME_FR,
    NVL(R34.inabrcode_fr,' ') AS LEV3_PST_DPAR_SHORT_FR,
    --
    NVL(R82.tvcodutil,' ')     AS SGLFRCO_DPAR_USER_CODE,
    NVL(R82.tvsglutil,' ')     AS SGLFRCO_DPAR_USER_SIGLE,
    NVL(R82.inintcode_fr,' ')  AS SGLFRCO_DPAR_NAME_FR,
    NVL(R82.inabrcode_fr,' ')  AS SGLFRCO_DPAR_SHORT_FR,
    NVL(T31.AUTYPINT,' ')      AS TYPINT_DPAR_USER_CODE,
    NVL(R101.tvsglutil,' ')    AS TYPINT_DPAR_USER_SIGLE,
    NVL(R101.inintcode_fr,' ') AS TYPINT_DPAR_NAME_FR,
    NVL(R101.inintcode_fr,' ') AS TYPINT_DPAR_SHORT_FR,
    --
    T12.system_country
  FROM EDW_FL.HUB_TRANSACTION T1
  LEFT OUTER JOIN EDW_FL.SAT_IBLU_TRANSACTION_TRANSACTION T12
  ON T1.TRANSACTION_HKEY = T12.TRANSACTION_HKEY
  LEFT OUTER JOIN REF_TABLES_LU R12
  ON R12.tvcodibba       = T12.opcodetpe
  AND R12.system_country = T12.system_country
  AND R12.tvnomattr      = 'CODETPE'
  AND R12.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_LU R22
  ON R22.tvcodibba       = T12.OPCODIBBAP
  AND R22.system_country = T12.system_country
  AND R22.tvnomattr      = 'SGLPSO'
  AND R22.tvnivattr      = '04'
    --
  LEFT OUTER JOIN REF_TABLES_LU R33
  ON R33.TVCODIBBA       = T12.opcodibbap
  AND R33.system_country = T12.system_country
  AND R33.tvnomattr      = 'SGLPSO'
  AND R33.tvnivattr      = '04'
  LEFT OUTER JOIN REF_TABLES_LU R34
  ON R34.TVNUMSUIT       = R33.TVCODAPPA
  AND R33.system_country = R33.system_country
    --
  LEFT OUTER JOIN REF_TABLES_LU R42
  ON R42.tvcodibba       = T12.opstaeope
  AND R42.system_country = T12.system_country
  AND R42.tvnomattr      = 'STAEOPE'
  AND R42.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_LU R52
  ON R52.tvcodibba       = T12.opstatope
  AND R52.system_country = T12.system_country
  AND R52.tvnomattr      = 'STATOPE'
  AND R52.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.LNK_ACCOUNT_FLOW_TRANSACTION L1
  ON T1.TRANSACTION_HKEY = L1.TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.HUB_ACCOUNT_FLOW T2
  ON L1.ACCOUNT_FLOW_HKEY = T2.ACCOUNT_FLOW_HKEY
  LEFT OUTER JOIN EDW_FL.SAT_IBLU_OPERATION_CASH_ACCOUNT_FLOW T22
  ON T2.ACCOUNT_FLOW_HKEY = T22.ACCOUNT_FLOW_HKEY
  LEFT OUTER JOIN REF_TABLES_LU R62
  ON R62.tvcodibba       = T22.FETYPFOND
  AND R62.system_country = T22.system_country
  AND R62.tvnomattr      = 'TYPFOND'
  AND R62.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_LU R72
  ON R72.tvcodibba       = T22.FECODCPSO
  AND R72.system_country = T22.system_country
  AND R72.tvnomattr      = 'SGLPSO'
  AND R72.tvnivattr      = '04'
    --
  LEFT OUTER JOIN EDW_FL.SAT_IBLU_CHARGE_COMMISION_AMOUNT_ACCOUNT_FLOW T24
  ON T22.FENUMOPER  = T24.FRNUMOPER
  AND T22.FEVERFLUX = T24.FRVERFLUX
  AND T22.FENUMFLUX = T24.FRNUMFLUX
  LEFT OUTER JOIN REF_TABLES_LU R82
  ON R82.tvnumsuit       = T24.FRNUMSFRAI
  AND R82.system_country = T24.system_country
  AND R82.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.SAT_IBLU_OTHER_INTERVENING_PARTY T31
  ON T22.fenumflux       = T31.aunumflux
  AND T22.fEverflux      = T31.auverflux
  AND T22.fenumoper      = T31.aunumoper
  AND t22.fEtypint       =T31.autypint
  AND T22.system_country = T31.system_country
  LEFT OUTER JOIN REF_TABLES_LU R101
  ON R101.tvcodutil       = T31.AUTYPINT
  AND R101.system_country = T31.system_country
  AND R101.tvnomattr      = 'TYPINT'
  AND R101.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.LNK_STOCK_EXCHANGE_TRANSACTION_TRANSACTION L3
  ON T1.TRANSACTION_HKEY = L3.TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.HUB_STOCK_EXCHANGE_TRANSACTION T4
  ON L3.STOCK_EXCHANGE_TRANSACTION_HKEY = T4.STOCK_EXCHANGE_TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.SAT_IBLU_STOCK_EXCHANGE_TRANSACTION T42
  ON T4.STOCK_EXCHANGE_TRANSACTION_HKEY = T42.STOCK_EXCHANGE_TRANSACTION_HKEY
    --
  LEFT OUTER JOIN REF_TABLES_LU R91
  ON R91.TVCODIBBA       = T42.DCMODLIQU
  AND R91.system_country = T42.system_country
  AND R91.tvnomattr      = 'MODLIQU'
  AND R91.tvnivattr      = '01'
  LEFT OUTER JOIN REF_TABLES_LU R92
  ON R92.TVCODIBBA       = T42.DCINDCLICO
  AND R92.system_country = T42.system_country
  AND R92.tvnomattr      = 'INDCLICO'
  AND R92.tvnivattr      = '01'
    --
  WHERE T1.src_bk LIKE ('%IBLU%')
  AND T1.LOAD_DATE > to_date('20191009 00:00:01','YYYYMMDD HH24:MI:SS')
  --
  UNION ALL
  ----------------
  -- SECU BE    --
  ----------------
  SELECT
    /*+ noparallel */
    t11.opcodetpe    AS CODETPE_DPAR_USER_CODE,
    R11.tvsglutil    AS CODETPE_DPAR_USER_SIGLE,
    R11.inintcode_fr AS CODETPE_DPAR_NAME_FR,
    R11.inabrcode_fr AS CODETPE_DPAR_SHORT_FR,
    --
    NVL(T41.DCMODLIQU,' ')    AS MODLIQU_DPAR_USER_CODE ,
    NVL(R91.tvsglutil,' ')    AS MODLIQU_DPAR_USER_SIGLE,
    NVL(R91.inintcode_fr,' ') AS MODLIQU_DPAR_NAME_FR,
    NVL(R91.inabrcode_fr,' ') AS MODLIQU_DPAR_SHORT_FR,
    --
    NVL(T41.DCINDCLICO,' ')   AS INDCLICO_DPAR_USER_CODE ,
    NVL(R92.tvsglutil,' ')    AS INDCLICO_DPAR_USER_SIGLE,
    NVL(R92.inintcode_fr,' ') AS INDCLICO_DPAR_NAME_FR,
    NVL(R92.inabrcode_fr,' ') AS INDCLICO_DPAR_SHORT_FR,
    --
    NVL(T11.opstatope,' ')    AS STATOPE_DPAR_USER_CODE,
    NVL(R51.tvsglutil,' ')    AS STATOPE_DPAR_USER_SIGLE,
    NVL(R51.inintcode_fr,' ') AS STATOPE_DPAR_NAME_FR,
    NVL(R51.inabrcode_fr,' ') AS STATOPE_DPAR_SHORT_FR,
    --
    NVL(T11.opstaeope,' ')    AS STAEOPE_DPAR_USER_CODE,
    NVL(R41.tvsglutil,' ')    AS STAEOPE_DPAR_USER_SIGLE,
    NVL(R41.inintcode_fr,' ') AS STAEOPE_DPAR_NAME_FR,
    NVL(R41.inabrcode_fr,' ') AS STAEOPE_DPAR_SHORT_FR,
    --
    '0000'                    AS TYPFOND_DPAR_USER_CODE,
    NVL(R61.tvsglutil,' ')    AS TYPFOND_DPAR_USER_SIGLE,
    NVL(R61.inintcode_fr,' ') AS TYPFOND_DPAR_NAME_FR,
    NVL(R61.inabrcode_fr,' ') AS TYPFOND_DPAR_SHORT_FR,
    --
    NVL(T21.FTCODCPSO,' ')    AS COMPL_PST_DPAR_USER_CODE,
    NVL(R71.tvsglutil,' ')    AS COMPL_PST_DPAR_USER_SIGLE,
    NVL(R71.inintcode_fr,' ') AS COMPL_PST_DPAR_NAME_FR,
    NVL(R71.inabrcode_fr,' ') AS COMPL_PST_DPAR_SHORT_FR,
    --
    NVL(T11.OPCODIBBAP,' ')   AS LEV4_PST_DPAR_USER_CODE,
    NVL(R21.tvsglutil,' ')    AS LEV4_PST_DPAR_USER_SIGLE,
    NVL(R21.inintcode_fr,' ') AS LEV4_PST_DPAR_NAME_FR,
    NVL(R21.inabrcode_fr,' ') AS LEV4_PST_DPAR_SHORT_FR,
    --
    NVL(R32.tvcodibba,' ')    AS LEV3_PST_DPAR_USER_CODE,
    NVL(R32.tvsglutil,' ')    AS LEV3_PST_DPAR_USER_SIGLE,
    NVL(R32.inintcode_fr,' ') AS LEV3_PST_DPAR_NAME_FR,
    NVL(R32.inabrcode_fr,' ') AS LEV3_PST_DPAR_SHORT_FR,
    --
    NVL(R81.tvcodutil,' ')     AS SGLFRCO_DPAR_USER_CODE,
    NVL(R81.tvsglutil,' ')     AS SGLFRCO_DPAR_USER_SIGLE,
    NVL(R81.inintcode_fr,' ')  AS SGLFRCO_DPAR_NAME_FR,
    NVL(R81.inabrcode_fr,' ')  AS SGLFRCO_DPAR_SHORT_FR,
    NVL(T31.AUTYPINT,' ')      AS TYPINT_DPAR_USER_CODE,
    NVL(R101.tvsglutil,' ')    AS TYPINT_DPAR_USER_SIGLE,
    NVL(R101.inintcode_fr,' ') AS TYPINT_DPAR_NAME_FR,
    NVL(R101.inabrcode_fr,' ') AS TYPINT_DPAR_SHORT_FR,
    --
    T11.system_country
  FROM EDW_FL.HUB_TRANSACTION T1
  LEFT OUTER JOIN EDW_FL.SAT_IBBE_TRANSACTION_TRANSACTION T11
  ON T1.TRANSACTION_HKEY = T11.TRANSACTION_HKEY
  LEFT OUTER JOIN REF_TABLES_BE R11
  ON R11.tvcodibba       = T11.opcodetpe
  AND R11.system_country = T11.system_country
  AND R11.tvnomattr      = 'CODETPE'
  AND R11.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_BE R21
  ON R21.tvcodibba       = T11.OPCODIBBAP
  AND R21.system_country = T11.system_country
  AND R21.tvnomattr      = 'SGLPSO'
  AND R21.tvnivattr      = '04'
    --
  LEFT OUTER JOIN REF_TABLES_BE R31
  ON R31.TVCODIBBA       = T11.opcodibbap
  AND R31.system_country = T11.system_country
  AND R31.tvnomattr      = 'SGLPSO'
  AND R31.tvnivattr      = '04'
  LEFT OUTER JOIN REF_TABLES_BE R32
  ON R32.TVNUMSUIT       = R31.TVCODAPPA
  AND R31.system_country = R31.system_country
    --
  LEFT OUTER JOIN REF_TABLES_BE R41
  ON R41.tvcodibba       = T11.opstaeope
  AND R41.system_country = T11.system_country
  AND R41.tvnomattr      = 'STAEOPE'
  AND R41.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_BE R51
  ON R51.tvcodibba       = T11.opstatope
  AND R51.system_country = T11.system_country
  AND R51.tvnomattr      = 'STATOPE'
  AND R51.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.LNK_ACCOUNT_FLOW_TRANSACTION L1
  ON T1.TRANSACTION_HKEY = L1.TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.HUB_ACCOUNT_FLOW T2
  ON L1.ACCOUNT_FLOW_HKEY = T2.ACCOUNT_FLOW_HKEY
  LEFT OUTER JOIN EDW_FL.SAT_IBBE_OPERATION_SECURITIES_ACCOUNT_FLOW T21
  ON T21.ACCOUNT_FLOW_HKEY = T2.ACCOUNT_FLOW_HKEY
  LEFT OUTER JOIN REF_TABLES_BE R61
  ON R61.tvcodibba       = '0000'
  AND R61.system_country = T21.system_country
  AND R61.tvnomattr      = 'TYPFOND'
  AND R61.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_BE R71
  ON R71.tvcodibba       = T21.FTCODCPSO
  AND R71.system_country = T21.system_country
  AND R71.tvnomattr      = 'SGLPSO'
  AND R71.tvnivattr      = '04'
    --
  LEFT OUTER JOIN EDW_FL.SAT_IBBE_CHARGE_COMMISION_AMOUNT_ACCOUNT_FLOW T23
  ON T21.FTNUMOPER  = T23.FRNUMOPER
  AND T21.FTVERFLUX = T23.FRVERFLUX
  AND T21.FTNUMFLUX = T23.FRNUMFLUX
  LEFT OUTER JOIN REF_TABLES_BE R81
  ON R81.tvnumsuit       = T23.FRNUMSFRAI
  AND R81.system_country = T23.system_country
  AND R81.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.SAT_IBBE_OTHER_INTERVENING_PARTY T31
  ON T21.ftnumflux       = T31.aunumflux
  AND T21.ftverflux      = T31.auverflux
  AND T21.ftnumoper      = T31.aunumoper
  AND t21.fttypint       =T31.autypint
  AND T21.system_country = T31.system_country
  LEFT OUTER JOIN REF_TABLES_BE R101
  ON R101.tvcodutil       = T31.AUTYPINT
  AND R101.system_country = T31.system_country
  AND R101.tvnomattr      = 'TYPINT'
  AND R101.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.LNK_STOCK_EXCHANGE_TRANSACTION_TRANSACTION L3
  ON T1.TRANSACTION_HKEY = L3.TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.HUB_STOCK_EXCHANGE_TRANSACTION T4
  ON L3.STOCK_EXCHANGE_TRANSACTION_HKEY = T4.STOCK_EXCHANGE_TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.SAT_IBBE_STOCK_EXCHANGE_TRANSACTION T41
  ON T4.STOCK_EXCHANGE_TRANSACTION_HKEY = T41.STOCK_EXCHANGE_TRANSACTION_HKEY
    --
  LEFT OUTER JOIN REF_TABLES_BE R91
  ON R91.TVCODIBBA       = T41.DCMODLIQU
  AND R91.system_country = T41.system_country
  AND R91.tvnomattr      = 'MODLIQU'
  AND R91.tvnivattr      = '01'
  LEFT OUTER JOIN REF_TABLES_BE R92
  ON R92.TVCODIBBA       = T41.DCINDCLICO
  AND R92.system_country = T41.system_country
  AND R92.tvnomattr      = 'INDCLICO'
  AND R92.tvnivattr      = '01'
    --
  WHERE T1.src_bk LIKE ('%IBBE%')
  AND T1.LOAD_DATE > to_date('20191009 00:00:01','YYYYMMDD HH24:MI:SS')
  --
  UNION ALL
  ----------------
  -- SECU LU    --
  ----------------
  SELECT
    /*+ noparallel */
    t12.opcodetpe    AS CODETPE_DPAR_USER_CODE,
    R12.tvsglutil    AS CODETPE_DPAR_USER_SIGLE,
    R12.inintcode_fr AS CODETPE_DPAR_NAME_FR,
    R12.inabrcode_fr AS CODETPE_DPAR_SHORT_FR,
    --
    NVL(T42.DCMODLIQU,' ')    AS MODLIQU_DPAR_USER_CODE ,
    NVL(R91.tvsglutil,' ')    AS MODLIQU_DPAR_USER_SIGLE,
    NVL(R91.inintcode_fr,' ') AS MODLIQU_DPAR_NAME_FR,
    NVL(R91.inabrcode_fr,' ') AS MODLIQU_DPAR_SHORT_FR,
    --
    NVL(T42.DCINDCLICO,' ')   AS INDCLICO_DPAR_USER_CODE ,
    NVL(R92.tvsglutil,' ')    AS INDCLICO_DPAR_USER_SIGLE,
    NVL(R92.inintcode_fr,' ') AS INDCLICO_DPAR_NAME_FR,
    NVL(R92.inabrcode_fr,' ') AS INDCLICO_DPAR_SHORT_FR,
    --
    NVL(T12.opstatope,' ')    AS STATOPE_DPAR_USER_CODE,
    NVL(R52.tvsglutil,' ')    AS STATOPE_DPAR_USER_SIGLE,
    NVL(R52.inintcode_fr,' ') AS STATOPE_DPAR_NAME_FR,
    NVL(R52.inabrcode_fr,' ') AS STATOPE_DPAR_SHORT_FR,
    --
    NVL(T12.opstaeope,' ')    AS STAEOPE_DPAR_USER_CODE,
    NVL(R42.tvsglutil,' ')    AS STAEOPE_DPAR_USER_SIGLE,
    NVL(R42.inintcode_fr,' ') AS STAEOPE_DPAR_NAME_FR,
    NVL(R42.inabrcode_fr,' ') AS STAEOPE_DPAR_SHORT_FR,
    --
    '0000'                    AS TYPFOND_DPAR_USER_CODE,
    NVL(R62.tvsglutil,' ')    AS TYPFOND_DPAR_USER_SIGLE,
    NVL(R62.inintcode_fr,' ') AS TYPFOND_DPAR_NAME_FR,
    NVL(R62.inabrcode_fr,' ') AS TYPFOND_DPAR_SHORT_FR,
    --
    NVL(T22.FTCODCPSO,' ')    AS COMPL_PST_DPAR_USER_CODE,
    NVL(R72.tvsglutil,' ')    AS COMPL_PST_DPAR_USER_SIGLE,
    NVL(R72.inintcode_fr,' ') AS COMPL_PST_DPAR_NAME_FR,
    NVL(R72.inabrcode_fr,' ') AS COMPL_PST_DPAR_SHORT_FR,
    --
    NVL(T12.OPCODIBBAP,' ')   AS LEV4_PST_DPAR_USER_CODE,
    NVL(R22.tvsglutil,' ')    AS LEV4_PST_DPAR_USER_SIGLE,
    NVL(R22.inintcode_fr,' ') AS LEV4_PST_DPAR_NAME_FR,
    NVL(R22.inabrcode_fr,' ') AS LEV4_PST_DPAR_SHORT_FR,
    --
    NVL(R34.tvcodibba,' ')    AS LEV3_PST_DPAR_USER_CODE,
    NVL(R34.tvsglutil,' ')    AS LEV3_PST_DPAR_USER_SIGLE,
    NVL(R34.inintcode_fr,' ') AS LEV3_PST_DPAR_NAME_FR,
    NVL(R34.inabrcode_fr,' ') AS LEV3_PST_DPAR_SHORT_FR,
    --
    NVL(R82.tvcodutil,' ')     AS SGLFRCO_DPAR_USER_CODE,
    NVL(R82.tvsglutil,' ')     AS SGLFRCO_DPAR_USER_SIGLE,
    NVL(R82.inintcode_fr,' ')  AS SGLFRCO_DPAR_NAME_FR,
    NVL(R82.inabrcode_fr,' ')  AS SGLFRCO_DPAR_SHORT_FR,
    NVL(T31.AUTYPINT,' ')      AS TYPINT_DPAR_USER_CODE,
    NVL(R101.tvsglutil,' ')    AS TYPINT_DPAR_USER_SIGLE,
    NVL(R101.inintcode_fr,' ') AS TYPINT_DPAR_NAME_FR,
    NVL(R101.inintcode_fr,' ') AS TYPINT_DPAR_SHORT_FR,
    --
    T12.system_country
  FROM EDW_FL.HUB_TRANSACTION T1
  LEFT OUTER JOIN EDW_FL.SAT_IBLU_TRANSACTION_TRANSACTION T12
  ON T1.TRANSACTION_HKEY = T12.TRANSACTION_HKEY
  LEFT OUTER JOIN REF_TABLES_LU R12
  ON R12.tvcodibba       = T12.opcodetpe
  AND R12.system_country = T12.system_country
  AND R12.tvnomattr      = 'CODETPE'
  AND R12.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_LU R22
  ON R22.tvcodibba       = T12.OPCODIBBAP
  AND R22.system_country = T12.system_country
  AND R22.tvnomattr      = 'SGLPSO'
  AND R22.tvnivattr      = '04'
    --
  LEFT OUTER JOIN REF_TABLES_LU R33
  ON R33.TVCODIBBA       = T12.opcodibbap
  AND R33.system_country = T12.system_country
  AND R33.tvnomattr      = 'SGLPSO'
  AND R33.tvnivattr      = '04'
  LEFT OUTER JOIN REF_TABLES_LU R34
  ON R34.TVNUMSUIT       = R33.TVCODAPPA
  AND R33.system_country = R33.system_country
    --
  LEFT OUTER JOIN REF_TABLES_LU R42
  ON R42.tvcodibba       = T12.opstaeope
  AND R42.system_country = T12.system_country
  AND R42.tvnomattr      = 'STAEOPE'
  AND R42.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_LU R52
  ON R52.tvcodibba       = T12.opstatope
  AND R52.system_country = T12.system_country
  AND R52.tvnomattr      = 'STATOPE'
  AND R52.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.LNK_ACCOUNT_FLOW_TRANSACTION L1
  ON T1.TRANSACTION_HKEY = L1.TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.HUB_ACCOUNT_FLOW T2
  ON L1.ACCOUNT_FLOW_HKEY = T2.ACCOUNT_FLOW_HKEY
  LEFT OUTER JOIN EDW_FL.SAT_IBLU_OPERATION_SECURITIES_ACCOUNT_FLOW T22
  ON T2.ACCOUNT_FLOW_HKEY = T22.ACCOUNT_FLOW_HKEY
  LEFT OUTER JOIN REF_TABLES_LU R62
  ON R62.tvcodibba       = '0000'
  AND R62.system_country = T22.system_country
  AND R62.tvnomattr      = 'TYPFOND'
  AND R62.tvnivattr      = '01'
    --
  LEFT OUTER JOIN REF_TABLES_LU R72
  ON R72.tvcodibba       = T22.FTCODCPSO
  AND R72.system_country = T22.system_country
  AND R72.tvnomattr      = 'SGLPSO'
  AND R72.tvnivattr      = '04'
    --
  LEFT OUTER JOIN EDW_FL.SAT_IBLU_CHARGE_COMMISION_AMOUNT_ACCOUNT_FLOW T24
  ON T22.FTNUMOPER  = T24.FRNUMOPER
  AND T22.FTVERFLUX = T24.FRVERFLUX
  AND T22.FTNUMFLUX = T24.FRNUMFLUX
  LEFT OUTER JOIN REF_TABLES_LU R82
  ON R82.tvnumsuit       = T24.FRNUMSFRAI
  AND R82.system_country = T24.system_country
  AND R82.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.SAT_IBLU_OTHER_INTERVENING_PARTY T31
  ON T22.ftnumflux       = T31.aunumflux
  AND T22.ftverflux      = T31.auverflux
  AND T22.ftnumoper      = T31.aunumoper
  AND t22.fttypint       =T31.autypint
  AND T22.system_country = T31.system_country
  LEFT OUTER JOIN REF_TABLES_LU R101
  ON R101.tvcodutil       = T31.AUTYPINT
  AND R101.system_country = T31.system_country
  AND R101.tvnomattr      = 'TYPINT'
  AND R101.tvnivattr      = '01'
    --
  LEFT OUTER JOIN EDW_FL.LNK_STOCK_EXCHANGE_TRANSACTION_TRANSACTION L3
  ON T1.TRANSACTION_HKEY = L3.TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.HUB_STOCK_EXCHANGE_TRANSACTION T4
  ON L3.STOCK_EXCHANGE_TRANSACTION_HKEY = T4.STOCK_EXCHANGE_TRANSACTION_HKEY
  LEFT OUTER JOIN EDW_FL.SAT_IBLU_STOCK_EXCHANGE_TRANSACTION T42
  ON T4.STOCK_EXCHANGE_TRANSACTION_HKEY = T42.STOCK_EXCHANGE_TRANSACTION_HKEY
    --
  LEFT OUTER JOIN REF_TABLES_LU R91
  ON R91.TVCODIBBA       = T42.DCMODLIQU
  AND R91.system_country = T42.system_country
  AND R91.tvnomattr      = 'MODLIQU'
  AND R91.tvnivattr      = '01'
  LEFT OUTER JOIN REF_TABLES_LU R92
  ON R92.TVCODIBBA       = T42.DCINDCLICO
  AND R92.system_country = T42.system_country
  AND R92.tvnomattr      = 'INDCLICO'
  AND R92.tvnivattr      = '01'
    --
  WHERE T1.src_bk LIKE ('%IBLU%')
  AND T1.LOAD_DATE > to_date('20191009 00:00:01','YYYYMMDD HH24:MI:SS')
  )
SELECT DISTINCT CAST(STANDARD_HASH(CODETPE_DPAR_USER_CODE
  || MODLIQU_DPAR_USER_CODE
  || INDCLICO_DPAR_USER_CODE
  || STATOPE_DPAR_USER_CODE
  || STAEOPE_DPAR_USER_CODE
  || TYPFOND_DPAR_USER_CODE
  || COMPL_PST_DPAR_USER_CODE
  || LEV4_PST_DPAR_USER_CODE
  || LEV3_PST_DPAR_USER_CODE
  || SGLFRCO_DPAR_USER_CODE
  || TYPINT_DPAR_USER_CODE
  || SYSTEM_COUNTRY
  || TO_CHAR(sysdate,'YYYYMMDD'),'MD5') AS VARCHAR(4000)) AS DPAR_FLAT_SK,
  TM_PARAMATER_FLAT_OPE.CODETPE_DPAR_USER_CODE,
  TM_PARAMATER_FLAT_OPE.CODETPE_DPAR_USER_SIGLE,
  TM_PARAMATER_FLAT_OPE.CODETPE_DPAR_NAME_FR,
  TM_PARAMATER_FLAT_OPE.CODETPE_DPAR_SHORT_FR,
  TM_PARAMATER_FLAT_OPE.MODLIQU_DPAR_USER_CODE,
  TM_PARAMATER_FLAT_OPE.MODLIQU_DPAR_USER_SIGLE,
  TM_PARAMATER_FLAT_OPE.MODLIQU_DPAR_NAME_FR,
  TM_PARAMATER_FLAT_OPE.MODLIQU_DPAR_SHORT_FR,
  TM_PARAMATER_FLAT_OPE.INDCLICO_DPAR_USER_CODE,
  TM_PARAMATER_FLAT_OPE.INDCLICO_DPAR_USER_SIGLE,
  TM_PARAMATER_FLAT_OPE.INDCLICO_DPAR_NAME_FR,
  TM_PARAMATER_FLAT_OPE.INDCLICO_DPAR_SHORT_FR,
  TM_PARAMATER_FLAT_OPE.STATOPE_DPAR_USER_CODE,
  TM_PARAMATER_FLAT_OPE.STATOPE_DPAR_USER_SIGLE,
  TM_PARAMATER_FLAT_OPE.STATOPE_DPAR_NAME_FR,
  TM_PARAMATER_FLAT_OPE.STATOPE_DPAR_SHORT_FR,
  TM_PARAMATER_FLAT_OPE.STAEOPE_DPAR_USER_CODE,
  TM_PARAMATER_FLAT_OPE.STAEOPE_DPAR_USER_SIGLE,
  TM_PARAMATER_FLAT_OPE.STAEOPE_DPAR_NAME_FR,
  TM_PARAMATER_FLAT_OPE.STAEOPE_DPAR_SHORT_FR,
  TM_PARAMATER_FLAT_OPE.TYPFOND_DPAR_USER_CODE,
  TM_PARAMATER_FLAT_OPE.TYPFOND_DPAR_USER_SIGLE,
  TM_PARAMATER_FLAT_OPE.TYPFOND_DPAR_NAME_FR,
  TM_PARAMATER_FLAT_OPE.TYPFOND_DPAR_SHORT_FR,
  TM_PARAMATER_FLAT_OPE.COMPL_PST_DPAR_USER_CODE,
  TM_PARAMATER_FLAT_OPE.COMPL_PST_DPAR_USER_SIGLE,
  TM_PARAMATER_FLAT_OPE.COMPL_PST_DPAR_NAME_FR,
  TM_PARAMATER_FLAT_OPE.COMPL_PST_DPAR_SHORT_FR,
  TM_PARAMATER_FLAT_OPE.LEV4_PST_DPAR_USER_CODE,
  TM_PARAMATER_FLAT_OPE.LEV4_PST_DPAR_USER_SIGLE,
  TM_PARAMATER_FLAT_OPE.LEV4_PST_DPAR_NAME_FR,
  TM_PARAMATER_FLAT_OPE.LEV4_PST_DPAR_SHORT_FR,
  TM_PARAMATER_FLAT_OPE.LEV3_PST_DPAR_USER_CODE,
  TM_PARAMATER_FLAT_OPE.LEV3_PST_DPAR_USER_SIGLE,
  TM_PARAMATER_FLAT_OPE.LEV3_PST_DPAR_NAME_FR,
  TM_PARAMATER_FLAT_OPE.LEV3_PST_DPAR_SHORT_FR,
  TM_PARAMATER_FLAT_OPE.SGLFRCO_DPAR_USER_CODE,
  TM_PARAMATER_FLAT_OPE.SGLFRCO_DPAR_USER_SIGLE,
  TM_PARAMATER_FLAT_OPE.SGLFRCO_DPAR_NAME_FR,
  TM_PARAMATER_FLAT_OPE.SGLFRCO_DPAR_SHORT_FR,
  TM_PARAMATER_FLAT_OPE.TYPINT_DPAR_USER_CODE,
  TM_PARAMATER_FLAT_OPE.TYPINT_DPAR_USER_SIGLE,
  TM_PARAMATER_FLAT_OPE.TYPINT_DPAR_NAME_FR,
  TM_PARAMATER_FLAT_OPE.TYPINT_DPAR_SHORT_FR,
  'Y' AS ACTUAL_FLAG,
  /* The VaultSpeed treats reference tables as SCD TYPE1, not TYPE2: Reference tables are not historized. As such there is no discremination in the actual flag. */
  sysdate                              AS CREATION_DATE,
  TM_PARAMATER_FLAT_OPE.SYSTEM_COUNTRY AS country_cde
FROM TM_PARAMATER_FLAT_OPE;