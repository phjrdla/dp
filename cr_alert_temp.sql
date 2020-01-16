USE [msdb]
GO

/****** Object:  Alert [TEMPDB Growing]    Script Date: 1/14/2020 11:17:31 AM ******/
EXEC msdb.dbo.sp_add_alert @name=N'Database Tempdb Large', 
		@message_id=0, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=3600, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@performance_condition=N'Databases|Data File(s) Size (KB)|tempdb|>|25165824', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

