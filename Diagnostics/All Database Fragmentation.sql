-- Get fragmentation info for all indexes above a certain size in the current database  (Query 48) (Index Fragmentation)
-- Note: This could take some time on a very large database
-- Helps determine whether you have framentation in your relational indexes
-- and how effective your index maintenance strategy is
CREATE table #tmp (
	[Database Name] sysname
	,[object Name] sysname
	,[index name] sysname null
	,[index_id] int
	,[index type desc] nvarchar(60)
	,avg_fragmentation_in_percent float
	,fragment_count bigint
	,page_count bigint
)


insert into #tmp
exec sp_msforeachdb N' use [?]
SELECT DB_NAME(database_id) AS [Database Name], OBJECT_NAME(ps.OBJECT_ID) AS [Object Name], 
i.name AS [Index Name], ps.index_id, index_type_desc,
avg_fragmentation_in_percent, fragment_count, page_count
FROM sys.dm_db_index_physical_stats(DB_ID(),NULL, NULL, NULL ,N''LIMITED'') AS ps 
INNER JOIN sys.indexes AS i WITH (NOLOCK)
ON ps.[object_id] = i.[object_id] 
AND ps.index_id = i.index_id
WHERE database_id = DB_ID()
AND page_count > 1500
ORDER BY avg_fragmentation_in_percent DESC OPTION (RECOMPILE);'

select * from #tmp

drop table #tmp