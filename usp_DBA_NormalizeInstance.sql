USE [MNGDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_DBA_NormalizeInstance]    Script Date: 1/15/2020 9:48:29 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[usp_DBA_NormalizeInstance]
AS
declare @cmd varchar(200);

drop table dbo.dbcmd;
create table dbo.dbcmd ( cmd varchar(200) );

drop table dbo.dbfsu;
select * into dbo.dbfsu from sys.dm_db_file_space_usage where 0=1;

drop table dbo.dblsu;
select * into dbo.dblsu from sys.dm_db_log_space_usage where 0=1;


select @cmd = 'use ? insert into mngdb.dbo.dbfsu select * from sys.dm_db_file_space_usage;';
exec sp_MSforeachdb @cmd;

select @cmd = 'use ? insert into mngdb.dbo.dblsu select * from sys.dm_db_log_space_usage;';
exec sp_MSforeachdb @cmd;

delete from dbo.dbcmd;

exec dbo.usp_DBA_NormalizeDBfiles;

/*select * from dbo.dbcmd;*/

exec dbo.usp_DBA_NormalizeDBLogs;

/*select * from dbo.dbcmd order by cmd;*/
GO

