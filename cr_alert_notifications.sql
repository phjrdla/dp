USE msdb;
GO

EXEC msdb.dbo.sp_add_notification 
  @alert_name = N'Error 17 Alert:Insufficient Resources',
  @operator_name = 'SQLAGENTOPER',
  @notification_method = 1;
GO

EXEC msdb.dbo.sp_add_notification 
  @alert_name = N'Error 18 Alert:Nonfatal Internal Error Detected',
  @operator_name = 'SQLAGENTOPER',
  @notification_method = 1;
GO

EXEC msdb.dbo.sp_add_notification 
  @alert_name = N'Error 19 Alert:SQL Server Error in Resource',
  @operator_name = 'SQLAGENTOPER',
  @notification_method = 1;
GO

EXEC msdb.dbo.sp_add_notification 
  @alert_name = N'Error 20 Alert:SQL Server Fatal Error in Current Process',
  @operator_name = 'SQLAGENTOPER',
  @notification_method = 1;
GO

EXEC msdb.dbo.sp_add_notification 
  @alert_name = N'Error 21 Alert:SQL Server Fatal Error in Database (dbid) Process',
  @operator_name = 'SQLAGENTOPER',
  @notification_method = 1;
GO

EXEC msdb.dbo.sp_add_notification 
  @alert_name = N'Error 22 Alert:SQL Server Fatal Error Table Integrity Suspect',
  @operator_name = 'SQLAGENTOPER',
  @notification_method = 1;
GO

EXEC msdb.dbo.sp_add_notification 
  @alert_name = N'Error 23 Alert:SQL Server Fatal Error: Database Integrity Suspect',
  @operator_name = 'SQLAGENTOPER',
  @notification_method = 1;
GO

EXEC msdb.dbo.sp_add_notification 
  @alert_name = N'Error 24 Alert:Hardware Error',
  @operator_name = 'SQLAGENTOPER',
  @notification_method = 1;
GO

EXEC msdb.dbo.sp_add_notification 
  @alert_name = N'Error 25 Alert:Fatal Error',
  @operator_name = 'SQLAGENTOPER',
  @notification_method = 1;
GO