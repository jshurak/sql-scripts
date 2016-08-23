-- Top Cached SPs By Avg Elapsed Time (SQL 2008)  (Query 34) (SP Avg Elapsed Time)

-- This helps you find long-running cached stored procedures that
-- may be easy to optimize with standard query tuning techniques

create table #tmp (
	[SP_Name] sysname
	,[database_name] sysname
	,[avg_elapsed_time] bigint
	,total_elapsed_time bigint
	,execution_count bigint
	,[Calls/Second] int
	,[AvgWorkerTime] bigint
	,[TotalWorkerTime] bigint
	,cached_time datetime
)

insert into #tmp
exec sp_msforeachdb N' use [?]
SELECT TOP(25) p.name AS [SP Name], DB_NAME(DB_ID()) AS [Database Name],qs.total_elapsed_time/qs.execution_count AS [avg_elapsed_time], 
qs.total_elapsed_time, qs.execution_count, ISNULL(qs.execution_count/DATEDIFF(Second, qs.cached_time, 
GETDATE()), 0) AS [Calls/Second], qs.total_worker_time/qs.execution_count AS [AvgWorkerTime], 
qs.total_worker_time AS [TotalWorkerTime], qs.cached_time
FROM sys.procedures AS p WITH (NOLOCK)
INNER JOIN sys.dm_exec_procedure_stats AS qs WITH (NOLOCK)
ON p.[object_id] = qs.[object_id]
WHERE qs.database_id = DB_ID()
ORDER BY avg_elapsed_time DESC OPTION (RECOMPILE);'

select *
from #tmp

drop table #tmp