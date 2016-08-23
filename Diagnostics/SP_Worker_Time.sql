-- Top Cached SPs By Total Worker time (SQL 2008). Worker time relates to CPU cost  (Query 36) (SP Worker Time)

-- This helps you find the most expensive cached stored procedures from a CPU perspective
-- You should look at this if you see signs of CPU pressure


CREATE TABLE #tmp (
	[SP_Name] sysname
	,[Database Name] sysname
	,[TotalWorkerTime] bigint
	,[AvgWorkerTime] bigint
	,[execution_count] bigint
	,[Calls/Second] int
	,[Total_elapsed_time] bigint
	,[avg_elapsed_time] bigint
	,[cached_time] datetime
);

-- Top Cached SPs By Total Worker time (SQL 2008). Worker time relates to CPU cost  (Query 36) (SP Worker Time)
-- This helps you find the most expensive cached stored procedures from a CPU perspective
-- You should look at this if you see signs of CPU pressure
insert into #tmp
exec sp_msforeachdb N' Use [?]

SELECT TOP(25) p.name AS [SP Name],DB_NAME(DB_ID()) AS [Database Name], qs.total_worker_time AS [TotalWorkerTime], 
qs.total_worker_time/qs.execution_count AS [AvgWorkerTime], qs.execution_count, 
ISNULL(qs.execution_count/DATEDIFF(Second, qs.cached_time, GETDATE()), 0) AS [Calls/Second],
qs.total_elapsed_time, qs.total_elapsed_time/qs.execution_count 
AS [avg_elapsed_time], qs.cached_time
FROM sys.procedures AS p WITH (NOLOCK)
INNER JOIN sys.dm_exec_procedure_stats AS qs WITH (NOLOCK)
ON p.[object_id] = qs.[object_id]
WHERE qs.database_id = DB_ID()
ORDER BY qs.total_worker_time DESC OPTION (RECOMPILE);'

select *
from #tmp

drop table #tmp

