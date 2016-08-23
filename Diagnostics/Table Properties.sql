-- Get some key table properties (Query 46) (Table Properties)
-- Gives you some good information about your tables

Create Table #tmp(
	[Database Name] sysname
	,[name] sysname
	,[create_date] datetime
	,[lock_on_bulk_load] bit
	,[is_replicated] bit
	,[has_replication_filer] bit
	,[is_tracked_by_cdc] bit
	,[lock_escalaction_desc] nvarchar(60)
)

insert into #tmp
exec sp_msforeachdb N' use [?]
SELECT DB_NAME(DB_ID()) AS [Database Name],[name], create_date, lock_on_bulk_load, is_replicated, has_replication_filter, 
       is_tracked_by_cdc, lock_escalation_desc
FROM sys.tables WITH (NOLOCK) 
ORDER BY [name] OPTION (RECOMPILE);'

select *
from #tmp

drop table #tmp