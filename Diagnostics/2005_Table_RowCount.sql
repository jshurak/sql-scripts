create table #tmp(
	[Database Name] sysname
	,[ObjectName] sysname
	,[RowCount] bigint
)
insert into #tmp
exec sp_MSforeachdb N' use [?]
SELECT DB_NAME(DB_ID()) AS [Database Name],OBJECT_NAME(object_id) AS [ObjectName], SUM(Rows) AS [RowCount]
FROM sys.partitions WITH (NOLOCK)
WHERE index_id < 2 --ignore the partitions from the non-clustered index if any
AND OBJECT_NAME(object_id) NOT LIKE N''sys%''
AND OBJECT_NAME(object_id) NOT LIKE N''queue_%'' 
AND OBJECT_NAME(object_id) NOT LIKE N''filestream_tombstone%''
AND OBJECT_NAME(object_id) NOT LIKE N''fulltext%''
GROUP BY [object_id]
ORDER BY SUM(Rows) DESC OPTION (RECOMPILE);'

select *
from #tmp

drop table #tmp