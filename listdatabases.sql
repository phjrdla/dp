use master
DECLARE
  @database_name varchar(128),
  @database_id int;

DECLARE cursor_dbname cursor
  for select name, database_id
        from sys.databases
	   order by database_id;

open cursor_dbname;

fetch next from cursor_dbname into
  @database_name,
  @database_id;

while @@FETCH_STATUS = 0
begin

  print @database_name ;
  exec dbo.NormalizeDbFiles @database_id;
  fetch next from cursor_dbname into
    @database_name,
    @database_id;

end;

close cursor_dbname;

deallocate cursor_dbname;