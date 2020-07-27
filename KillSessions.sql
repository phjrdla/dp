procedure killSessions ( par_status varchar2 default 'INACTIVE'
                        ,par_days number default 7
						,doit boolean default false) is
    /*
    Kills all inactive user sessions except SYS SYSTEM DBSNMP OPCON OPCONAP
    Enables restricted mode on database
    */
    c_username v$session.username%type; 
    c_sid      v$session.sid%type; 
    c_serial   v$session.serial#%type;
    c_status   v$session.status%type;
    c_taddr    v$session.taddr%type;
    cmd        varchar2(80);
    msg        varchar2(80);
    username   varchar2(30);
    cnt        integer;
    sessn      integer := 0;
    sesskilled integer := 0;
    v_code     NUMBER;
    v_errm     VARCHAR2(64);
  
    CURSOR c_sessions(par_status, par_days) is 
      SELECT username, sid, serial#, status, taddr
        FROM v$session
       WHERE username not in ('SYS','SYSTEM','DBSNMP')
	     AND status = par_status
		 and (sysdate - logon_time) >= par_days
       ORDER BY USERNAME; 
      
    begin 
      -- Current number of sessions 
      execute immediate 'select count(1) from v$session ' into cnt;
      dbms_output.put_line('Current number of sessions is '||to_char(cnt));
           
      -- List and kill sessions
      sys.dbms_system.ksdwrt(3,'killSessions starts');
      OPEN c_sessions; 
        LOOP 
          FETCH c_sessions into c_username, c_sid, c_serial, c_status, c_taddr; 
          EXIT WHEN c_sessions%notfound; 
        
          -- Session being processed
          sessn := sessn + 1;
          dbms_output.put_line('Session '||to_char(sessn)||' : User is '||c_username||' session status is '||c_status );
       
          -- Warning if session involved in a transaction
          if  c_taddr is not null then 
            dbms_output.put_line('A transaction is still running, will complete before session is terminated');
          else
            dbms_output.put_line('Session is clean');
          end if;
      
          cmd := 'alter system kill session '||''''||to_char(c_sid)||','||to_char(c_serial)||''' immediate';
          display_mode(doit);
          dbms_output.put_line(cmd);
          if doit then
            -------------------------------------------------------
            -- handle sessions already gone
            BEGIN
            execute immediate cmd;
            exception
                when others then
				  -- ORA-00030: User session ID does not exist
                  if SQLCODE = -30 then
                    continue; -- suppreses ORA-00030 exception
				  -- ORA-00031: User session marked for kill
				  elsif SQLCODE = -31 then
				    continue; -- suppreses ORA-00031 exception
                  else
                    v_code := SQLCODE;
                    v_errm := SUBSTR(SQLERRM, 1, 64);
                    DBMS_OUTPUT.PUT_LINE('Error code ' || v_code || ': ' || v_errm);
                    raise;
                end if;  
            END;
            -------------------------------------------------------
            sesskilled := sesskilled + 1;
            msg := 'Session '||''''||to_char(c_sid)||','||to_char(c_serial)||''' for '||c_username||' was terminated';
            dbms_output.put_line(msg);
          end if;
        END LOOP;
      CLOSE c_sessions;
      sys.dbms_system.ksdwrt(3,'killSessions ended');
   
      -- After killing sessions
      display_mode(doit);
      execute immediate 'select count(1) from v$session ' into cnt;
      dbms_output.put_line('Remaining number of sessions is '||to_char(cnt));
      if doit then
        dbms_output.put_line(to_char(sesskilled)||' sessions were killed');
      end if;
    
     exception
        when others then
          v_code := SQLCODE;
          v_errm := SUBSTR(SQLERRM, 1, 64);
          DBMS_OUTPUT.PUT_LINE('Error code ' || v_code || ': ' || v_errm);
         raise;
  end killSessions;
