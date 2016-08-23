select er.session_id,er.start_time, er.percent_complete,substring(st.text,(statement_start_offset/2)-1,(statement_end_offset/2)-1) as text
from sys.dm_exec_requests er
cross apply sys.dm_exec_sql_text(er.sql_handle) st
where session_id = (
select top 1 r1.blocking_session_id
from sys.dm_exec_requests r1
right outer join sys.dm_exec_requests r2
on r1.session_id = r2.blocking_session_id
where r1.blocking_session_id <> 0
)