set timing on
set serveroutput on
set echo on
set pages 0
set lines 200
set trimspool on

spool job_redef.lst;

DROP TABLE TABORIG CASCADE CONSTRAINTS;

create table taborig as select * from ftf_insp_price;

CREATE UNIQUE INDEX taborig_PK_FINSP_SK ON taborig (FINSP_PK);

ALTER TABLE TABORIG ADD (
  CONSTRAINT taborig_PK_FINSP_SK
  PRIMARY KEY
  (FINSP_PK)
  USING INDEX taborig_PK_FINSP_SK 
  ENABLE VALIDATE);

GRANT SELECT ON taborig TO DTM_CF_FINANCERO;

GRANT SELECT ON taborig TO DTM_CF_FINANCES WITH GRANT OPTION;

GRANT SELECT ON taborig TO DTM_CF_REFERENTIAL WITH GRANT OPTION;

DROP TABLE INTERIM CASCADE CONSTRAINTS;

CREATE TABLE INTERIM
(
  FINSP_PK                     NUMBER,
  FINSP_ENTITY                 VARCHAR2(10 BYTE),
  FINSP_COUNTRY                VARCHAR2(2 BYTE),
  FINSP_DINS_SK                NUMBER,
  FINSP_REPORTING_SK           NUMBER,
  FINSP_COT_MARKET_SK          NUMBER,
  FINSP_CURR_COTATION_SK       NUMBER,
  FINSP_RATE_TYPE_SK           NUMBER,
  FINSP_PRINCIPAL_MARKET_FLAG  CHAR(1 BYTE),
  FINSP_DATE_START_COT         DATE,
  FINSP_DATE_END_COT           DATE,
  FINSP_COTATION_UNITY         NUMBER,
  FINSP_NEGOCIABLE_QUANTITY    NUMBER,
  FINSP_NEGOCIABLE_MINIMUM     NUMBER,
  FINSP_PRICE                  NUMBER,
  FINSP_DATE_PRICE             DATE,
  FINSP_TIME_PRICE             TIMESTAMP(6),
  FINSP_PROVIDER_SK            NUMBER,
  FINSP_STRIKE_PRICE           NUMBER,
  FINSP_DINS_REF_KEY           VARCHAR2(50 BYTE),
  FINSP_MARKET_CODE            VARCHAR2(20 BYTE),
  FINSP_COTATION_ISO_CODE      VARCHAR2(3 BYTE),
  FINSP_PRICE_TYPE_CODE        VARCHAR2(20 BYTE),
  SOURCE_NAME                  VARCHAR2(50 BYTE),
  CREATION_DATE                TIMESTAMP(6),
  CREATION_USER                VARCHAR2(30 BYTE),
  CREATION_BATCH_ID            NUMBER,
  CREATION_RUN_ID              NUMBER,
  FINSP_PRICE_POST             NUMBER,
  FINSP_DATE_PRICE_POST        TIMESTAMP(6),
  FINSP_DATE_PRICE_CREATION    TIMESTAMP(6)
)
partition by range (FINSP_REPORTING_SK)
interval (1)
(partition p0 values less than (20180101));

begin
dbms_redefinition.can_redef_table
 (uname=>USER,
 tname=>'TABORIG');
end;
/

BEGIN
DBMS_REDEFINITION.START_REDEF_TABLE
 (uname=>USER,
 orig_table=>'TABORIG',
 int_table=>'INTERIM');
end;
/

vari num_errors number
BEGIN
DBMS_REDEFINITION.COPY_TABLE_DEPENDENTS
 (uname=>USER,
 orig_table=>'TABORIG',
 int_table=>'INTERIM',
 num_errors=>:num_errors);
END;
/
print num_errors

begin
dbms_redefinition.finish_redef_table
 (uname=>user,
 orig_table=>'TABORIG',
 int_table=>'INTERIM');
end;
/ 

CREATE INDEX FINSP_REPORTING_SK_ix ON taborig (FINSP_REPORTING_SK) LOCAL PARALLEL NOLOGGING ;

execute dbms_stats.gather_table_stats(user, tabname=>'TABORIG', degree=>4, granularity=>'GLOBAL AND PARTITION', cascade=>true);

spool off 