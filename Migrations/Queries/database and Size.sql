select d.name, DataSizeMB,LogSizeMB
from sys.databases d
inner join
(
	select database_id, cast(sum(size/1.0)*8/1024 as decimal(12,2)) as DataSizeMB
	from sys.master_files
	where type = 0
	group by database_id
) as s on d.database_id = s.database_id
inner join
(
	select database_id, cast(sum(size/1.0)*8/1024 as decimal(12,2)) as LogSizeMB
	from sys.master_files
	where type = 1
	group by database_id
) as l on d.database_id = l.database_id

	