-- Top Cached SPs By Avg Elapsed Time with execution time variability   (Query 35) (SP Avg Elapsed Variable Time)

-- This gives you some interesting information about the variability in the
-- execution time of your cached stored procedures, which is useful for tuning


CREATE TABLE #tmp(
	[SP_Name] sysname
	,[Database Name] sysname
	,execution_count bigint
	,min_elapsed_time bigint
	,[avg_elapsed_time] bigint
	,max_elapsed_time bigint
	,last_elapsed_time bigint
	,cached_time datetime
)
insert into #tmp
exec sp_MSforeachdb N'use [?]
SELECT TOP(25) p.name AS [SP Name], DB_NAME(DB_ID()) AS [Database Name],qs.execution_count, qs.min_elapsed_time,
qs.total_elapsed_time/qs.execution_count AS [avg_elapsed_time],
qs.max_elapsed_time, qs.last_elapsed_time,  qs.cached_time
FROM sys.procedures AS p WITH (NOLOCK)
INNER JOIN sys.dm_exec_procedure_stats AS qs WITH (NOLOCK)
ON p.[object_id] = qs.[object_id]
WHERE qs.database_id = DB_ID()
ORDER BY avg_elapsed_time DESC OPTION (RECOMPILE);'


select *
from #tmp

drop table #tmp