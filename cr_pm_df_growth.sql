Declare @object_set_id int
EXEC msdb.dbo.sp_syspolicy_add_object_set @object_set_name=N'Datafile growth disabled_ObjectSet', @facet=N'DataFile', @object_set_id=@object_set_id OUTPUT
Select @object_set_id

Declare @target_set_id int
EXEC msdb.dbo.sp_syspolicy_add_target_set @object_set_name=N'Datafile growth disabled_ObjectSet', @type_skeleton=N'Server/Database/FileGroup/File', @type=N'FILE', @enabled=True, @target_set_id=@target_set_id OUTPUT
Select @target_set_id

EXEC msdb.dbo.sp_syspolicy_add_target_set_level @target_set_id=@target_set_id, @type_skeleton=N'Server/Database/FileGroup/File', @level_name=N'File', @condition_name=N'', @target_set_level_id=0
EXEC msdb.dbo.sp_syspolicy_add_target_set_level @target_set_id=@target_set_id, @type_skeleton=N'Server/Database/FileGroup', @level_name=N'FileGroup', @condition_name=N'', @target_set_level_id=0
EXEC msdb.dbo.sp_syspolicy_add_target_set_level @target_set_id=@target_set_id, @type_skeleton=N'Server/Database', @level_name=N'Database', @condition_name=N'', @target_set_level_id=0


GO

Declare @policy_id int
EXEC msdb.dbo.sp_syspolicy_add_policy @name=N'Datafile growth disabled', @condition_name=N'Growth', @policy_category=N'', @description=N'', @help_text=N'', @help_link=N'', @schedule_uid=N'accbee48-bc69-4e18-9cfd-0a1d81b19825', @execution_mode=0, @is_enabled=False, @policy_id=@policy_id OUTPUT, @root_condition_name=N'', @object_set=N'Datafile growth disabled_ObjectSet'
Select @policy_id


GO

