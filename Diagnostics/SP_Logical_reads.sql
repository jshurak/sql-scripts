CREATE TABLE #tmp (
	[SP_name] sysname
	,[Database Name] sysname
	,[TotalLogicalReads] bigint
	,[AvgLogicalReads] bigint
	,[execution_count] bigint
	,[Calls/Sec] bigint
	,[total_elapsed_time] bigint
	,[avg_elapsed_time] bigint
	,[cached_time] datetime

)


-- Top Cached SPs By Total Logical Reads (SQL 2008). Logical reads relate to memory pressure  (Query 37) (SP Logical Reads)
-- This helps you find the most expensive cached stored procedures from a memory perspective
-- You should look at this if you see signs of memory pressure

insert into #tmp
exec sp_msforeachdb N'use [?]
SELECT TOP(25) p.name AS [SP Name], DB_NAME(DB_ID()) AS [Database Name],qs.total_logical_reads AS [TotalLogicalReads], 
qs.total_logical_reads/qs.execution_count AS [AvgLogicalReads],qs.execution_count, 
ISNULL(qs.execution_count/DATEDIFF(Second, qs.cached_time, GETDATE()), 0) AS [Calls/Second], 
qs.total_elapsed_time, qs.total_elapsed_time/qs.execution_count 
AS [avg_elapsed_time], qs.cached_time
FROM sys.procedures AS p WITH (NOLOCK)
INNER JOIN sys.dm_exec_procedure_stats AS qs WITH (NOLOCK)
ON p.[object_id] = qs.[object_id]
WHERE qs.database_id = DB_ID()
ORDER BY qs.total_logical_reads DESC OPTION (RECOMPILE);'

select *
from #tmp

drop table #tmp