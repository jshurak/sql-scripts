--- Index Read/Write stats (all tables in current DB) ordered by Writes  (Query 50) (Overall Index Usage - Writes)
-- Show which indexes in the current database are most active for Writes


create table #tmp(
	[database name] sysname
	,[objectname] sysname
	,[indexname] sysname null
	,[indexid] int
	,[writes] bigint
	,[reads] bigint
	,[IndexType] nvarchar(60)
	,[FillFactor] tinyint
)
insert into #tmp
exec sp_msforeachdb N' use [?]
SELECT DB_NAME(database_id) AS [Database Name],OBJECT_NAME(s.[object_id]) AS [ObjectName], i.name AS [IndexName], i.index_id,
	   s.user_updates AS [Writes], user_seeks + user_scans + user_lookups AS [Reads], 
	   i.type_desc AS [IndexType], i.fill_factor AS [FillFactor]
FROM sys.dm_db_index_usage_stats AS s WITH (NOLOCK)
INNER JOIN sys.indexes AS i WITH (NOLOCK)
ON s.[object_id] = i.[object_id]
WHERE OBJECTPROPERTY(s.[object_id],''IsUserTable'') = 1
AND i.index_id = s.index_id
AND s.database_id = DB_ID()
ORDER BY s.user_updates DESC OPTION (RECOMPILE);						 -- Order by writes'

select *
from #tmp

drop table #tmp