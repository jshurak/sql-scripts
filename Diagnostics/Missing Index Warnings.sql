-- Find missing index warnings for cached plans in the current database  (Query 43) (Missing Index Warnings)
-- Note: This query could take some time on a busy instance
-- Helps you connect missing indexes to specific stored procedures
-- This can help you decide whether to add them or not


create table #tmp (
	[ObjectName] sysname
	,[Database Name] sysname
	,query_plan xml
	,objtype nvarchar(16)
	,usecounts int
)

insert into #tmp
exec sp_msforeachdb N' use [?]

SELECT TOP(25) OBJECT_NAME(objectid) AS [ObjectName], DB_NAME(DB_ID()) AS [Database Name],
               query_plan, cp.objtype, cp.usecounts
FROM sys.dm_exec_cached_plans AS cp WITH (NOLOCK)
CROSS APPLY sys.dm_exec_query_plan(cp.plan_handle) AS qp
WHERE CAST(query_plan AS NVARCHAR(MAX)) LIKE N''%MissingIndex%''
AND dbid = DB_ID()
ORDER BY cp.usecounts DESC OPTION (RECOMPILE);'

select *
from #tmp

drop table #tmp