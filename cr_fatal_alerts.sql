USE [msdb]
GO

EXEC msdb.dbo.sp_add_alert @name=N'Error 17 Alert:Insufficient Resources', 
  @message_id=0, 
  @severity=17, 
  @enabled=1, 
  @delay_between_responses=0, 
  @include_event_description_in=1;
GO

EXEC msdb.dbo.sp_add_alert @name=N'Error 18 Alert:Nonfatal Internal Error Detected', 
  @message_id=0, 
  @severity=18, 
  @enabled=1, 
  @delay_between_responses=0, 
  @include_event_description_in=1;
GO

EXEC msdb.dbo.sp_add_alert @name=N'Error 19 Alert:SQL Server Error in Resource', 
  @message_id=0, 
  @severity=19, 
  @enabled=1, 
  @delay_between_responses=0, 
  @include_event_description_in=1;
GO

EXEC msdb.dbo.sp_add_alert @name=N'Error 20 Alert:SQL Server Fatal Error in Current Process', 
  @message_id=0, 
  @severity=20, 
  @enabled=1, 
  @delay_between_responses=0, 
  @include_event_description_in=1;
GO

EXEC msdb.dbo.sp_add_alert @name=N'Error 21 Alert:SQL Server Fatal Error in Database (dbid) Process', 
  @message_id=0, 
  @severity=21, 
  @enabled=1, 
  @delay_between_responses=0, 
  @include_event_description_in=1;
GO

EXEC msdb.dbo.sp_add_alert @name=N'Error 22 Alert:SQL Server Fatal Error Table Integrity Suspect', 
  @message_id=0, 
  @severity=22, 
  @enabled=1, 
  @delay_between_responses=0, 
  @include_event_description_in=1;
GO

EXEC msdb.dbo.sp_add_alert @name=N'Error 23 Alert:SQL Server Fatal Error: Database Integrity Suspect', 
  @message_id=0, 
  @severity=23, 
  @enabled=1, 
  @delay_between_responses=0, 
  @include_event_description_in=1;
GO

EXEC msdb.dbo.sp_add_alert @name=N'Error 24 Alert:Hardware Error', 
  @message_id=0, 
  @severity=24, 
  @enabled=1, 
  @delay_between_responses=0, 
  @include_event_description_in=1;
GO

EXEC msdb.dbo.sp_add_alert @name=N'Error 25 Alert:Fatal Error', 
  @message_id=0, 
  @severity=25, 
  @enabled=1, 
  @delay_between_responses=0, 
  @include_event_description_in=1;
GO

EXEC msdb.dbo.sp_add_alert @name = N'825 – Read-Retry Required',
    @message_id = 825,
    @severity = 0,
    @enabled = 1,
    @delay_between_responses = 0,
    @include_event_description_in = 1;
GO