set timing on
set serveroutput on
set echo on
set pages 0
set lines 200
set trimspool on

spool job_redef.lst;

DROP TABLE TABORIG CASCADE CONSTRAINTS;

create table taborig as select * from ftf_ins_instrument;

CREATE UNIQUE INDEX taborig_PK_FINS_SK ON taborig (FINS_PK);
ALTER TABLE TABORIG ADD (
  CONSTRAINT taborig_PK_FINS_SK
  PRIMARY KEY
  (FINS_PK)
  USING INDEX taborig_PK_FINS_SK 
  ENABLE VALIDATE);

GRANT SELECT ON taborig TO DTM_CF_FINANCES WITH GRANT OPTION;

GRANT SELECT ON taborig TO DTM_CF_REFERENTIAL WITH GRANT OPTION;


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

CREATE INDEX FINS_REPORTING_SK_ix ON taborig (FINS_REPORTING_SK) LOCAL PARALLEL NOLOGGING ;

execute dbms_stats.gather_table_stats(user, tabname=>'TABORIG', degree=>4, granularity=>'GLOBAL AND PARTITION', cascade=>true);

spool off 