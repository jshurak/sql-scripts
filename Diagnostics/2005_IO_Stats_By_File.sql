-- Calculates average stalls per read, per write, and per total input/output for each database file  (Query 15) (IO Stalls by File)
-- Helps you determine which database files on the entire instance have the most I/O bottlenecks
-- This can help you decide whether certain LUNs are overloaded and whether you might
-- want to move some files to a different location



create table #tmp(
	[Database Name] sysname
	,[file_id] smallint
	,[num_of_reads] bigint
	,[num_of_writes] bigint
	,[io_stall_read_ms] bigint
	,[io_stall_write_ms] bigint
	,[IO Stall Reads Pct] Decimal(10,1)
	,[IO Stall Writes Pct] Decimal(10,1)
	,[Writes + Reads] bigint
	,[num_of_bytes_read] bigint
	,[num_of_bytes_written] bigint
	,[# Reads Pct] decimal(10,1)
	,[# Writes Pct] decimal(10,1)
	,[Read Bytes Pct] decimal(10,1)
	,[Writes Bytes Pct] decimal(10,1)
)


EXEC sp_MSforeachdb N' use[?]
insert into #tmp
SELECT DB_NAME(DB_ID()) AS [Database Name],[file_id], num_of_reads, num_of_writes, 
io_stall_read_ms, io_stall_write_ms,
CAST(100. * io_stall_read_ms/(io_stall_read_ms + io_stall_write_ms) AS DECIMAL(10,1)) AS [IO Stall Reads Pct],
CAST(100. * io_stall_write_ms/(io_stall_write_ms + io_stall_read_ms) AS DECIMAL(10,1)) AS [IO Stall Writes Pct],
(num_of_reads + num_of_writes) AS [Writes + Reads], num_of_bytes_read, num_of_bytes_written,
CAST(100. * num_of_reads/(num_of_reads + num_of_writes) AS DECIMAL(10,1)) AS [# Reads Pct],
CAST(100. * num_of_writes/(num_of_reads + num_of_writes) AS DECIMAL(10,1)) AS [# Write Pct],
CAST(100. * num_of_bytes_read/(num_of_bytes_read + num_of_bytes_written) AS DECIMAL(10,1)) AS [Read Bytes Pct],
CAST(100. * num_of_bytes_written/(num_of_bytes_read + num_of_bytes_written) AS DECIMAL(10,1)) AS [Written Bytes Pct]
FROM sys.dm_io_virtual_file_stats(DB_ID(), NULL) OPTION (RECOMPILE);
'

select *
from #tmp

drop table #tmp