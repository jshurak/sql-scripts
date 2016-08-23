-- Top Cached SPs By Total Logical Writes (SQL 2008)  (Query 39) (SP Logical Writes) 
-- Logical writes relate to both memory and disk I/O pressure 
-- This helps you find the most expensive cached stored procedures from a write I/O perspective
-- You should look at this if you see signs of I/O pressure or of memory pressure
create table #tmp (
	[SP_Name] sysname
	,[Database Name] sysname
	,[TotalLogicalWrites] bigint
	,[AvgLogicalWrites] bigint
	,[execution_count] bigint
	,[calls/second] int
	,[total_elapsed_time] bigint
	,[avg_elapsed_tim] bigint
	,[cached_time] datetime
)

insert into #tmp
exec sp_msforeachdb N'use [?]
SELECT TOP(25) p.name AS [SP Name], DB_NAME(DB_ID()) AS [Database Name],qs.total_logical_writes AS [TotalLogicalWrites], 
qs.total_logical_writes/qs.execution_count AS [AvgLogicalWrites], qs.execution_count,
ISNULL(qs.execution_count/DATEDIFF(Second, qs.cached_time, GETDATE()), 0) AS [Calls/Second],
qs.total_elapsed_time, qs.total_elapsed_time/qs.execution_count AS [avg_elapsed_time], 
qs.cached_time
FROM sys.procedures AS p WITH (NOLOCK)
INNER JOIN sys.dm_exec_procedure_stats AS qs WITH (NOLOCK)
ON p.[object_id] = qs.[object_id]
WHERE qs.database_id = DB_ID()
ORDER BY qs.total_logical_writes DESC OPTION (RECOMPILE);'

select *
from #tmp

drop table #tmp