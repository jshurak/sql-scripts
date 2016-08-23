-- Possible Bad NC Indexes (writes > reads)  (Query 41) (Bad NC Indexes)
-- Look for indexes with high numbers of writes and zero or very low numbers of reads
-- Consider your complete workload
-- Investigate further before dropping an index!


create table #tmp (
	[Database Name] sysname
	,[Table Name] sysname
	,[Index Name] sysname
	,[index_id] int
	,[is_disabled] bit
	,[Total Writes] bigint
	,[Total Reads] bigint
	,[Difference] bigint
)

insert into #tmp
exec sp_msforeachdb N' use [?]
SELECT DB_NAME(DB_ID()) AS [Database Name],OBJECT_NAME(s.[object_id]) AS [Table Name], i.name AS [Index Name], i.index_id, i.is_disabled,
user_updates AS [Total Writes], user_seeks + user_scans + user_lookups AS [Total Reads],
user_updates - (user_seeks + user_scans + user_lookups) AS [Difference]
FROM sys.dm_db_index_usage_stats AS s WITH (NOLOCK)
INNER JOIN sys.indexes AS i WITH (NOLOCK)
ON s.[object_id] = i.[object_id]
AND i.index_id = s.index_id
WHERE OBJECTPROPERTY(s.[object_id],''IsUserTable'') = 1
AND s.database_id = DB_ID()
AND user_updates > (user_seeks + user_scans + user_lookups)
AND i.index_id > 1
ORDER BY [Difference] DESC, [Total Writes] DESC, [Total Reads] ASC OPTION (RECOMPILE);'

select *
from #tmp

drop table #tmp