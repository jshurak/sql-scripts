--Top 10 codes that takes maximum time
select top 10 source_code,stats.total_elapsed_time/1000000 as seconds,
last_execution_time from sys.dm_exec_query_stats as stats
cross apply
(SELECT text as source_code FROM sys.dm_exec_sql_text(sql_handle))
AS query_text
order by total_elapsed_time desc