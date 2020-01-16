USE [MNGDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_DBA_NormalizeDbFiles]    Script Date: 1/15/2020 10:40:20 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[usp_DBA_NormalizeDbFiles]
as
DECLARE
  @database_name                 varchar(50),
  @database_id                   int,
  @file_name                     varchar(200),
  @file_id                       int,
  @total_page_count              decimal,
  @allocated_extent_page_count   decimal,
  @unallocated_extent_page_count decimal,
  @pctused                       decimal,
  @pctusedreq                    decimal,
  @growth						 int,
  @file_size				     decimal,
  @file_resized                  decimal,
  @sizemb                        decimal,
  @resizemb                      decimal,
  @maxsizemb                     decimal,
  @sqlcmd                        varchar(1000);

-- table dbfsu DataBaseFileStorqgeUsage must be created for instance
DECLARE cursor_dbfsu cursor
  for select fsu.database_id
            ,fsu.file_id
			,mf.name
			,fsu.total_page_count
			,fsu.allocated_extent_page_count
			,fsu.unallocated_extent_page_count
        from dbo.dbfsu fsu
		    ,sys.master_files mf
		where fsu.database_id = mf.database_id
		  and fsu.file_id = mf.file_id
	   order by fsu.database_id, fsu.file_id;

-- Threshold % for resize
set @pctusedreq = 80;

open cursor_dbfsu;

BEGIN TRANSACTION;

-- fetch storage usage for file
fetch next from cursor_dbfsu into
  @database_id, @file_id, @file_name, @total_page_count, @allocated_extent_page_count, @unallocated_extent_page_count;

while @@FETCH_STATUS = 0
begin

  --print @database_id;
  print db_name(@database_id) + ' : ' + @file_name;
  print '    Total 8K pages is ' + str(@total_page_count) + ' Pages ' + str(@total_page_count*8/1024) + ' MB';
  print 'Allocated 8K pages is ' + str(@allocated_extent_page_count) + ' Pages ' + str(@allocated_extent_page_count*8/1024) + ' MB';

  -- Compute percentage of allocated space used (pages are 8K)
  set @pctused = 100 * ( @allocated_extent_page_count / @total_page_count );
  print 'pctused is ' + str(@pctused);

  -- Check if a resize is necessary
  if @pctused > @pctusedreq 
    begin
	  -- file is resized wrt pctused requested
      set @file_resized = @total_page_count * ( @pctused / @pctusedreq );

	  -- Sizes are normalised to multiples of 32M et 2048M
      set @sizemb   = ( @total_page_count * 8 * 1024 ) / ( 1024 * 1024 );
      set @resizemb = ( @file_resized * 8 * 1024 ) / ( 1024 * 1024 );
      set @resizemb = CEILING( @resizemb / 32 ) * 32;
      --set @maxsizemb = CEILING( @resizemb / 2048 ) * 2048;

      print db_name(@database_id) + ' : ' + @file_name + ' resized from ' + ltrim(str(@sizemb)) + ' MB to ==> ' + ltrim(str( @resizemb)) + 'MB';

      -- build alter command
      set @sqlcmd = 'ALTER DATABASE ' + db_name(@database_id) 
	              + ' MODIFY FILE ( NAME=' + @file_name + ','
		  	      + ' SIZE=' + ltrim(str(@resizemb)) + 'MB,' 
			      + ' MAXSIZE=' + ltrim(str(@resizemb)) + 'MB,'
			      + ' FILEGROWTH=0MB'
			      + ');';
      insert into dbo.dbcmd (cmd) values ( @sqlcmd );
	end;
  else
    begin
      print 'no resize';
	end;

  -- Next file
  fetch next from cursor_dbfsu into
    @database_id, @file_id, @file_name, @total_page_count, @allocated_extent_page_count, @unallocated_extent_page_count;

end;

commit transaction;

close cursor_dbfsu;

deallocate cursor_dbfsu;
GO

