SELECT DB_Name(ips.Database_ID) as DatabaseName
,OBJECT_NAME(ips.Object_id) as TableName
,cast(SUM(page_count) * 8.0/1024 as decimal(7,2)) as TransactionSize
FROM sys.dm_db_index_physical_stats(db_id(),null,null,null,null) ips
	INNER JOIN sys.indexes i 
		ON ips.index_id = i.index_id and ips.object_id = i.object_id
GROUP BY ips.database_id,ips.object_id
order by TransactionSize desc
GO 