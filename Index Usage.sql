SELECT DB_Name(ips.Database_ID) as DatabaseName
,OBJECT_NAME(ips.Object_id) as TableName
,ips.index_id
,i.name as IndexName
,index_type_desc
,page_count
,CAST(page_count*8.0/1024 AS DECIMAL (10,2)) AS SizeMB
,us.system_lookups + us.system_scans + us.system_seeks + us.user_lookups + us.user_scans + us.user_seeks AS TimesRead
,us.system_updates + us.user_updates as TimesUpdated
,us.last_user_lookup
,us.last_user_scan
,us.last_user_seek
,us.last_system_lookup
,us.last_system_scan
,us.last_system_seek
,us.last_system_update
,us.last_user_update
,STATS_DATE(i.object_id, i.index_id) AS StatsUpdated
FROM sys.dm_db_index_physical_stats(db_id(),null,null,null,null) as ips
	INNER JOIN sys.indexes as i with (nolock)
		ON ips.index_id = i.index_id and ips.object_id = i.object_id
	INNER JOIN sys.dm_db_index_usage_stats as us with (nolock)
		ON ips.database_id = us.database_id AND ips.object_id = us.object_id AND ips.index_id = us.index_id
WHERE i.index_id > 1
GO 


