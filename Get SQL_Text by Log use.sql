select top 10 tdt.transaction_id,DB_NAME(tdt.database_id) as [DataBaseName], tdt.database_transaction_log_bytes_used,st.text
from sys.dm_tran_database_transactions tdt
join sys.dm_tran_session_transactions tst
on tdt.transaction_id = tst.transaction_id
join sys.dm_exec_requests er
on tst.session_id = er.session_id
CROSS APPLY sys.dm_exec_sql_text(er.sql_handle) as st
order by database_transaction_log_bytes_used desc

