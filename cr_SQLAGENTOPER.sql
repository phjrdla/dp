USE [msdb]
GO

/****** Object:  Operator [SQLAGENTOPER]    Script Date: 1/14/2020 10:49:52 AM ******/
EXEC msdb.dbo.sp_add_operator @name=N'SQLAGENTOPER', 
		@enabled=1, 
		@weekday_pager_start_time=90000, 
		@weekday_pager_end_time=180000, 
		@saturday_pager_start_time=90000, 
		@saturday_pager_end_time=180000, 
		@sunday_pager_start_time=90000, 
		@sunday_pager_end_time=180000, 
		@pager_days=0, 
		@email_address=N'p.briens@degroofpetercam.com', 
		@category_name=N'[Uncategorized]'
GO

