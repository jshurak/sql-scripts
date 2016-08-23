create table #tmp (
	[index_advantage] decimal (18,2)
	,[Database Name] sysname
	,[last_user_seek] datetime
	,[Database.Schema.Table] varchar(4000)
	,equality_columns nvarchar(4000)
	,inequality_columns nvarchar(4000)
	,included_columns nvarchar(4000)
	,unique_compiles bigint
	,user_seeks bigint
	,avg_total_user_cost float
	,avg_user_impact float
	,[Table Name] sysname
	,[Table Rows] bigint
)

insert into #tmp
exec sp_msforeachdb N' Use [?]

SELECT DISTINCT CONVERT(decimal(18,2), user_seeks * avg_total_user_cost * (avg_user_impact * 0.01)) AS [index_advantage], DB_NAME(DB_ID()) AS [Database Name],
migs.last_user_seek, mid.[statement] AS [Database.Schema.Table],
mid.equality_columns, mid.inequality_columns, mid.included_columns,
migs.unique_compiles, migs.user_seeks, migs.avg_total_user_cost, migs.avg_user_impact,
OBJECT_NAME(mid.object_id) AS [Table Name], p.rows AS [Table Rows]
FROM sys.dm_db_missing_index_group_stats AS migs WITH (NOLOCK)
INNER JOIN sys.dm_db_missing_index_groups AS mig WITH (NOLOCK)
ON migs.group_handle = mig.index_group_handle
INNER JOIN sys.dm_db_missing_index_details AS mid WITH (NOLOCK)
ON mig.index_handle = mid.index_handle
INNER JOIN sys.partitions AS p WITH (NOLOCK)
ON p.object_id = mid.object_id
WHERE mid.database_id = DB_ID() -- Remove this to see for entire instance
ORDER BY index_advantage DESC OPTION (RECOMPILE);'

Select *
from #tmp

drop table #tmp