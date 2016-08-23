-- Top Cached SPs By Total Physical Reads (SQL 2008). Physical reads relate to disk I/O pressure  (Query 38) (SP Physical Reads)

-- This helps you find the most expensive cached stored procedures from a read I/O perspective
-- You should look at this if you see signs of I/O pressure or of memory pressure

CREATE TABLE #tmp (
	[SP_name] sysname
	,[Database Name] sysname
	,[total_physical_reads] bigint
	,[avg_physical_reads] bigint
	,[execution_count] bigint
	,[total_logical_reads] bigint
	,[total_elapsed_time] bigint
	,[avg_elapsed_time] bigint
	,[cached_time] datetime
);

insert into #tmp
exec sp_msforeachdb N' use [?]
SELECT TOP(25) p.name AS [SP Name],DB_NAME(DB_ID()) AS [Database Name],qs.total_physical_reads AS [TotalPhysicalReads], 
qs.total_physical_reads/qs.execution_count AS [AvgPhysicalReads], qs.execution_count, 
qs.total_logical_reads,qs.total_elapsed_time, qs.total_elapsed_time/qs.execution_count 
AS [avg_elapsed_time], qs.cached_time 
FROM sys.procedures AS p WITH (NOLOCK)
INNER JOIN sys.dm_exec_procedure_stats AS qs WITH (NOLOCK)
ON p.[object_id] = qs.[object_id]
WHERE qs.database_id = DB_ID()
AND qs.total_physical_reads > 0
ORDER BY qs.total_physical_reads DESC, qs.total_logical_reads DESC OPTION (RECOMPILE);'

select *
from #tmp;

drop table #tmp;

