declare @ServerIO bigint

select @ServerIO = sum(num_of_reads) + sum(num_of_writes)
FROM sys.dm_io_virtual_file_stats(null,null)

select db_name(database_id) as Database_Name
	,SUM(num_of_reads) + sum(num_of_writes) as Total_IO
	,CAST(SUM(num_of_reads) * 1.0/(SUM(num_of_reads) + sum(num_of_writes)) * 100 AS DECIMAL(5,2)) AS Read_percent
	,CAST(SUM(num_of_writes) * 1.0/(SUM(num_of_reads) + sum(num_of_writes)) * 100 AS DECIMAL(5,2)) AS Write_percent
	,CAST(((SUM(num_of_reads) + sum(num_of_writes)) * 1.0)/@ServerIO * 100 AS decimal(5,2)) as ServerWeight
from sys.dm_io_virtual_file_stats(null,NULL)
group by database_id
order by Total_IO desc