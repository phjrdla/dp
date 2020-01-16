use MNGDB

SELECT database_id, f.file_id, volume_mount_point, total_bytes/(1024*1024) "TOTMB", available_bytes/(1024*1024) "AVMB"  
FROM sys.database_files AS f  
CROSS APPLY sys.dm_os_volume_stats(DB_ID(f.name), f.file_id);

SELECT f.database_id
      ,DB_NAME(f.database_id)
      ,f.file_id
      ,volume_mount_point, total_bytes/(1024*1024) "TOTMB" , available_bytes  /(1024*1024) "AVMB"
FROM sys.master_files AS f  
CROSS APPLY sys.dm_os_volume_stats(f.database_id, f.file_id);