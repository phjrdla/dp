CREATE OR REPLACE FUNCTION SYSPB.employees_policy (user_name IN VARCHAR2,tab_name in varchar2)
  RETURN VARCHAR2 IS
BEGIN
  RETURN 'upper(first_name) = SYS_CONTEXT(''USERENV'', ''CURRENT_USER'')';
  -- RETURN 'first_name = ''Scott''';
  -- RETURN '1=1';
END;
/
