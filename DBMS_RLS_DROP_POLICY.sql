BEGIN
  SYS.DBMS_RLS.DROP_POLICY (
    object_schema    => 'HR'
    ,object_name     => 'EMPLOYEES'
    ,policy_name     => 'EMPLOYEES_VPD_POLICY');
END;
/
