-- Lists the top statements by average input/output usage for the current database  (Query 40) (Top IO Statements)
-- Helps you find the most expensive statements for I/O by SP

create table #tmp(
	[sp_name] sysname
	,[database name] sysname
	,[avg_io] bigint
	,[Query_text] varchar(max)
)

insert into #tmp
exec sp_msforeachdb N'use [?]
SELECT TOP(50) OBJECT_NAME(qt.objectid) AS [SP Name],DB_NAME(DB_ID()) AS [Database Name],
(qs.total_logical_reads + qs.total_logical_writes) /qs.execution_count AS [Avg IO],
SUBSTRING(qt.[text],qs.statement_start_offset/2, 
	(CASE 
		WHEN qs.statement_end_offset = -1 
	 THEN LEN(CONVERT(nvarchar(max), qt.[text])) * 2 
		ELSE qs.statement_end_offset 
	 END - qs.statement_start_offset)/2) AS [Query Text]	
FROM sys.dm_exec_query_stats AS qs WITH (NOLOCK)
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS qt
WHERE qt.[dbid] = DB_ID()
ORDER BY [Avg IO] DESC OPTION (RECOMPILE);'

select *
from #tmp

drop table #tmp