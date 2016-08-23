-- Get the average full backup size by month for the current database (SQL 2008) (Query 52) (Database Size History)
-- This helps you understand your database growth over time
-- Adapted from Erin Stellato

-- The Backup Size (MB) (without backup compression) shows the true size of your database over time
-- This helps you track and plan your data size growth
-- It is possible that your data files may be larger on disk due to empty space within those files
CREATE TABLE #tmp (
	[Database Name] sysname
	,[Month] int
	,[Backup Size (MB)] decimal (15,2)
	,[Compressed Backup Size (MB)] decimal (15,2)
	,[Compression Ratio] decimal (3,2)
)

insert into #tmp
exec sp_msforeachdb N' use [?]
SELECT [database_name] AS [Database], DATEPART(month,[backup_start_date]) AS [Month],
CAST(AVG([backup_size]/1024/1024) AS DECIMAL(15,2)) AS [Backup Size (MB)],
CAST(AVG([compressed_backup_size]/1024/1024) AS DECIMAL(15,2)) AS [Compressed Backup Size (MB)],
CAST(AVG([backup_size]/[compressed_backup_size]) AS DECIMAL(15,2)) AS [Compression Ratio]
FROM msdb.dbo.backupset WITH (NOLOCK)
WHERE [database_name] = DB_NAME(DB_ID())
AND [type] = ''D''
AND backup_start_date >= DATEADD(MONTH, -12, GETDATE())
GROUP BY [database_name],DATEPART(mm,[backup_start_date]) OPTION (RECOMPILE);
'

select *
from #tmp

drop table #tmp