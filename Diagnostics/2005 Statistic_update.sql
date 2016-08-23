CREATE TABLE #tmp(
	[Database Name] sysname
	,[name] sysname
	,[Index Name] sysname
	,[Statistics Date] datetime
	,[auto_created] bit
	,[no_recompute] bit
	,[user_created] bit
)

insert into #tmp
exec sp_MSforeachdb N' use [?]
SELECT DB_NAME(DB_ID()) AS [Database Name],o.name, i.name AS [Index Name],  
       STATS_DATE(i.[object_id], i.index_id) AS [Statistics Date], 
       s.auto_created, s.no_recompute, s.user_created
FROM sys.objects AS o WITH (NOLOCK)
INNER JOIN sys.indexes AS i WITH (NOLOCK)
ON o.[object_id] = i.[object_id]
INNER JOIN sys.stats AS s WITH (NOLOCK)
ON i.[object_id] = s.[object_id] 
AND i.index_id = s.stats_id
WHERE o.[type] = ''U''
ORDER BY STATS_DATE(i.[object_id], i.index_id) ASC OPTION (RECOMPILE);'


select *
from #tmp

drop table #tmp