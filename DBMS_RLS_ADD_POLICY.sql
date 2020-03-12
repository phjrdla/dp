BEGIN
  SYS.DBMS_RLS.ADD_POLICY     (
    object_schema          => 'HR'
    ,object_name           => 'EMPLOYEES'
    ,policy_name           => 'EMPLOYEES_VPD_POLICY'
    ,function_schema       => 'SYSPB'
    ,policy_function       => 'EMPLOYEES_POLICY'
    ,statement_types       => 'SELECT'
    ,policy_type           => dbms_rls.dynamic
    ,long_predicate        => FALSE
    ,update_check          => FALSE
    ,static_policy         => FALSE
    ,enable                => TRUE );
END;
/