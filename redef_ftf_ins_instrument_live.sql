set timing on
set serveroutput on
set echo on
set pages 0
set lines 200
set trimspool on

spool job_redef_FTF_INS_INSTRUMENT.lst;

DROP TABLE FTF_INS_INSTRUMENT_save CASCADE CONSTRAINTS;

create table FTF_INS_INSTRUMENT_save as select * from FTF_INS_INSTRUMENT;

DROP TABLE INTERIM CASCADE CONSTRAINTS;

CREATE TABLE INTERIM
(
  FINS_PK            NUMBER,
  FINS_ENTITY        VARCHAR2(10 BYTE),
  FINS_COUNTRY       VARCHAR2(2 BYTE),
  FINS_DINS_SK       NUMBER,
  FINS_DINS_REF_KEY  VARCHAR2(50 BYTE),
  FINS_REPORTING_SK  NUMBER,
  SOURCE_NAME        VARCHAR2(50 BYTE),
  CREATION_DATE      TIMESTAMP(6),
  CREATION_USER      VARCHAR2(30 BYTE),
  CREATION_BATCH_ID  NUMBER,
  CREATION_RUN_ID    NUMBER
)
partition by range (FINS_REPORTING_SK)
interval (1)
(partition p0 values less than (20180101));

begin
dbms_redefinition.can_redef_table
 (uname=>USER,
 tname=>'FTF_INS_INSTRUMENT');
end;
/

BEGIN
DBMS_REDEFINITION.START_REDEF_TABLE
 (uname=>USER,
 orig_table=>'FTF_INS_INSTRUMENT',
 int_table=>'INTERIM');
end;
/

vari num_errors number
BEGIN
DBMS_REDEFINITION.COPY_TABLE_DEPENDENTS
 (uname=>USER,
 orig_table=>'FTF_INS_INSTRUMENT',
 int_table=>'INTERIM',
 num_errors=>:num_errors);
END;
/
print num_errors

begin
dbms_redefinition.finish_redef_table
 (uname=>user,
 orig_table=>'FTF_INS_INSTRUMENT',
 int_table=>'INTERIM');
end;
/ 

CREATE INDEX FINS_REPORTING_SK_ix ON FTF_INS_INSTRUMENT (FINS_REPORTING_SK) LOCAL PARALLEL NOLOGGING ;

execute dbms_stats.gather_table_stats(user, tabname=>'FTF_INS_INSTRUMENT', degree=>4, granularity=>'GLOBAL AND PARTITION', cascade=>true);

spool off 