select es.last_request_start_time,percent_complete,wait_type,estimated_completion_time, substring(text,statement_start_offset/2+1,(statement_end_offset-statement_start_offset)/2+1)as [current statement]
from sys.dm_exec_requests er
join sys.dm_exec_sessions es
on er.session_id = es.session_id
cross apply sys.dm_exec_sql_text(er.sql_handle)
where er.session_id = 59