-- Top Cached SPs By Execution Count (SQL 2008) (Query 33) (SP Execution Counts)

-- Tells you which cached stored procedures are called the most often
-- This helps you characterize and baseline your workload

create table #tmp(
	[text]  varchar(max)
	,[Database Name] sysname
	,[Execution Count] bigint
	,[Calls/Second] int
	,[AvgWorkerTime] int
	,[TotalWorkerTime] bigint
	,[AvgElapsedTime] int
	,[max_logical_reads] bigint
	,[max_logical_writes] bigint
	,[total_physical_reads] bigint
	,[Age in Cache] int
)
insert into #tmp
exec sp_MSforeachdb N' Use [?] 
SELECT  TOP(25) qt.[text] AS [SP Name], DB_NAME(DB_ID()) AS [Database Name], qs.execution_count AS [Execution Count],  
qs.execution_count/DATEDIFF(Second, qs.creation_time, GETDATE()) AS [Calls/Second],
qs.total_worker_time/qs.execution_count AS [AvgWorkerTime],
qs.total_worker_time AS [TotalWorkerTime],
qs.total_elapsed_time/qs.execution_count AS [AvgElapsedTime],
qs.max_logical_reads, qs.max_logical_writes, qs.total_physical_reads, 
DATEDIFF(Minute, qs.creation_time, GetDate()) AS [Age in Cache]
FROM sys.dm_exec_query_stats AS qs WITH (NOLOCK)
CROSS APPLY sys.dm_exec_sql_text(qs.[sql_handle]) AS qt
WHERE qt.[dbid] = DB_ID() -- Filter by current database
ORDER BY qs.execution_count DESC OPTION (RECOMPILE);'

select *
from #tmp

drop table #tmp
