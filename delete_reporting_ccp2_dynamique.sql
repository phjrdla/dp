DECLARE
    CURSOR lc_sql IS
        SELECT 'alter table ' || table_name || ' disable constraint ' ||
			   constraint_name || ' ' AS instruct
		FROM   user_constraints t
		WHERE  t.table_name LIKE 'CCP2%'
		AND    t.table_name NOT LIKE 'CCP2_PAR%'
		AND    t.table_name NOT LIKE 'CCP2_299%'
		AND    t.table_name NOT LIKE 'CCP2_1%'
		AND    t.table_name NOT LIKE 'CCP2_4%'
		AND    t.table_name NOT LIKE 'CCP2_7%'
		AND    t.table_name NOT LIKE 'CCP2_8%'
		AND    t.constraint_type = 'R'
		UNION ALL
		SELECT 'truncate table ' || table_name /*|| ' REUSE STORAGE'*/|| ' ' AS instruct  -- utiliser reuse storage si on veut garder l'espace alloué à la table
		FROM   user_all_tables t
		WHERE  t.table_name LIKE 'CCP2%'
		AND    t.table_name NOT LIKE 'CCP2_PAR%'
		AND    t.table_name NOT LIKE 'CCP2_299%'
		AND    t.table_name NOT LIKE 'CCP2_1%'
		AND    t.table_name NOT LIKE 'CCP2_4%'
		AND    t.table_name NOT LIKE 'CCP2_7%'
		AND    t.table_name NOT LIKE 'CCP2_8%'
		UNION ALL
		SELECT 'alter table ' || table_name || ' enable constraint ' ||
			   constraint_name || ' ' AS instruct
		FROM   user_constraints t
		WHERE  t.table_name LIKE 'CCP2%'
		AND    t.table_name NOT LIKE 'CCP2_PAR%'
		AND    t.table_name NOT LIKE 'CCP2_299%'
		AND    t.table_name NOT LIKE 'CCP2_1%'
		AND    t.table_name NOT LIKE 'CCP2_4%'
		AND    t.table_name NOT LIKE 'CCP2_7%'
		AND    t.table_name NOT LIKE 'CCP2_8%'
		AND    t.constraint_type = 'R';

BEGIN
    FOR lr_sql IN lc_sql
    LOOP
        BEGIN
            EXECUTE IMMEDIATE lr_sql.instruct;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error when executing "' || lr_sql.instruct || '"');
                DBMS_OUTPUT.PUT_LINE(SQLERRM);
                DBMS_OUTPUT.PUT_LINE('------------------');
        END;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Clean CCP2 reporting executed');
END;
/