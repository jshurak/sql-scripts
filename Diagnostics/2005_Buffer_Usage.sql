-- Breaks down buffers used by current database by object (table, index) in the buffer cache  (Query 44) (Buffer Usage)
-- Note: This query could take some time on a busy instance

-- Tells you what tables and indexes are using the most memory in the buffer cache


create table #tmp(
	[Database Name] sysname
	,[ObjectName] sysname
	,[index_id] int
	,[buffer size(MB)] int
	,[buffer_count] int
)

insert into #tmp
exec sp_MSforeachdb N' Use [?]
SELECT DB_NAME(DB_ID()) AS [Database Name],OBJECT_NAME(p.[object_id]) AS [ObjectName], 
p.index_id, COUNT(*)/128 AS [buffer size(MB)],  COUNT(*) AS [buffer_count] 
FROM sys.allocation_units AS a
INNER JOIN sys.dm_os_buffer_descriptors AS b WITH (NOLOCK)
ON a.allocation_unit_id = b.allocation_unit_id
INNER JOIN sys.partitions AS p WITH (NOLOCK)
ON a.container_id = p.hobt_id
WHERE b.database_id = DB_ID()
AND p.[object_id] > 100
GROUP BY p.[object_id], p.index_id
ORDER BY buffer_count DESC OPTION (RECOMPILE);'

select *
from #tmp

drop table #tmp