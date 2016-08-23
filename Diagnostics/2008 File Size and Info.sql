create table #tmp (
	[File Name] varchar(60)
	,[Physical Name] varchar(300)
	,[Total Size in MB] numeric(20,5)
	,[Available Space in MB] numeric(20,5)
	,[file_id] int
	,[FileGoup Name] sysname null
)

insert into #tmp
EXEC sp_MSforeachdb N'USE [?]
SELECT f.name AS [File Name] , f.physical_name AS [Physical Name], 
CAST((f.size/128.0) AS decimal(15,2)) AS [Total Size in MB],
CAST(f.size/128.0 - CAST(FILEPROPERTY(f.name, ''SpaceUsed'') AS int)/128.0 AS decimal(15,2)) 
AS [Available Space In MB], [file_id], fg.name AS [Filegroup Name]
FROM sys.database_files AS f WITH (NOLOCK) 
LEFT OUTER JOIN sys.data_spaces AS fg WITH (NOLOCK) 
ON f.data_space_id = fg.data_space_id OPTION (RECOMPILE);'

select *
from #tmp

drop table #tmp