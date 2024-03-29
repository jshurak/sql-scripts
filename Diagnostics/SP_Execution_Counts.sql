CREATE TABLE #tmp (
	[SP_Name] sysname
	,[Database Name] sysname
	,[execution_count] bigint
	,[Calls/Second] int
	,[AvgWorkerTime] int
	,[TotalWorkerTime] bigint
	,total_elapsed_time bigint
	,[avg_elapsed_time] bigint
	,cached_time datetime
)

-- Top Cached SPs By Execution Count (SQL 2008) (Query 33) (SP Execution Counts)
insert into #tmp
exec sp_msforeachdb N'use [?]

SELECT TOP(250) p.name AS [SP Name],DB_NAME(DB_ID()) AS [Database Name], qs.execution_count,
ISNULL(qs.execution_count/DATEDIFF(Second, qs.cached_time, GETDATE()), 0) AS [Calls/Second],
qs.total_worker_time/qs.execution_count AS [AvgWorkerTime], qs.total_worker_time AS [TotalWorkerTime],  
qs.total_elapsed_time, qs.total_elapsed_time/qs.execution_count AS [avg_elapsed_time],
qs.cached_time
FROM sys.procedures AS p WITH (NOLOCK)
INNER JOIN sys.dm_exec_procedure_stats AS qs WITH (NOLOCK)
ON p.[object_id] = qs.[object_id]
WHERE qs.database_id = DB_ID()
ORDER BY qs.execution_count DESC OPTION (RECOMPILE);'

select *
from #tmp

drop table #tmp