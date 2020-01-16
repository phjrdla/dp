USE [MNGDB]
GO

/****** Object:  StoredProcedure [dbo].[usp_DBA_checkfordatabaseusedspace]    Script Date: 1/15/2020 9:46:33 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[usp_DBA_checkfordatabaseusedspace]
AS
DECLARE @loop               INT;
DECLARE @count              INT;
DECLARE @db_name            VARCHAR(25);
DECLARE @exec_string        VARCHAR(500);
DECLARE @threshold          INT;
DECLARE @id                 INT;
DECLARE @space_used_percent decimal(9,3);
DEclare @used_space         decimal(9,3);
Declare @used_space_int     int;

-- % of space used above which an alarm is raised
SET @threshold = 80;

--create a table for holding all database used space %
CREATE TABLE #tmp_space_used
(
id                 INT IDENTITY(1,1),
database_name      VARCHAR(25),
space_used_percent int
)
--get the names of all user databases, exclude master, msdb, model, tempdb
SELECT
	IDENTITY(INT,1,1) as ID,
	name
INTO
	#temp
FROM
	sys.databases
WHERE
	database_id > 4;

SET @loop = 1;
SELECT @count = MAX(ID) FROM #temp;
--loop through each database and get the data file used space %        
WHILE @loop <= @count
 BEGIN
	--get our working db
	SELECT
		@db_name = name
	FROM
		#temp
	WHERE
		ID = @loop;
	--build the string for execution
	SET @exec_string = '
		USE ' + @db_name + ';
		SELECT 
			''' + @db_name + ''' as database_name,
			AVG(100 * (CAST (((CAST(FILEPROPERTY(f.name,  ''spaceused'') AS decimal(9,3) ))/(f.size)) AS decimal(9,3)))) AS space_used_percent
		FROM
			sys.sysfiles f
		WHERE
			groupid != 0;-- data files'
	--pull our space data back and insert into our holding table
	INSERT #tmp_space_used
	EXECUTE (@exec_string);
	--next please                
	SET @loop = @loop + 1
END
--clean up our un-needed table
drop table #temp;
--remove any entries that do not meet our threshold
DELETE FROM #tmp_space_used WHERE space_used_percent < @threshold;

--loop through all problem databases and raise error
WHILE EXISTS
(
	SELECT
		NULL
	FROM
		#tmp_space_used
)
BEGIN
	--work through each database
	SELECT TOP 1
		@id = id,
		@db_name = database_name,
		@used_space = space_used_percent
	FROM
		#tmp_space_used
    order by space_used_percent desc;

	set @used_space_int = cast(@used_space as integer);

	-- An alert is raised for each database above the used space threshold
	RAISERROR  (75001, 10,1, @used_space_int, @db_name) WITH LOG;
	print 'raiserror for ' + @db_name;

	-- Necessary to not loose a RAISERROR
	WAITFOR DELAY '00:00:05';

	-- print 'used space for ' + @db_name + ' is : ' + str(@used_space_int);
	-- remove the processed entry
	DELETE FROM #tmp_space_used WHERE id = @id;
END
--clean up our un-needed table
drop table #tmp_space_used;
GO

