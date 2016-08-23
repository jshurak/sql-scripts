select top 10 
	latch_class
	,waiting_requests_count
	,wait_time_ms
	,CASE
		WHEN wait_time_ms = 0 THEN 0
		ELSE CAST((wait_time_ms*1.0/waiting_requests_count) AS DECIMAL(10,3))
	END average_wait_time_ms
from sys.dm_os_latch_stats
where latch_class not in ('CLR_PROCEDURE_HASHTABLE'
,'CLR_UDX_STORE'
,'CLR_DATAT_ACCESS'
,'CLR_XVAR_PROXY_LIST'
,'DBCC_CHECK_AGGREGATE'
,'DBCC_CHECK_RESULTSET'
,'DBCC_CHECK_TABLE'
,'DBCC_CHECK_TABLE_INIT'
,'DBCC_CHECK_TRACE_LIST'
,'DBCC_FILE_CHECK_OBJECT'
,'DBCC_PFS_STATUS'
,'DBCC_OBJECT_METADATA'
,'DBCC_HASH_DLL'
,'EVENTING_CACHE'
,'FCB_REPLICA'
,'FILEGROUP_MANAGER'
,'FILE_MANAGER'
,'FILESTREAM_FCB'
,'FILESTREAM_FILE_MANAGER'
,'FILESTREAM_GHOST_FILES'
,'FILESTREAM_DFS_ROOT'
,'LOG_MANAGER'
,'FULLTEXT_DOCUMENT_ID'
,'FULLTEXT_DOCUMENT_ID_TRANSACTION'
,'FULLTEXT_DOCUMENT_ID_NOTIFY'
,'FULLTEXT_LOGS'
,'FULLTEXT_CRAWL_LOG'
,'FULLTEXT_ADMIN'
,'FULLTEXT_AMDIN_COMMAND_CACHE'
,'FULLTEXT_LANGUAGE_TABLE'
,'FULLTEXT_CRAWL_DM_LIST'
,'FULLTEXT_CRAWL_CATALOG'
,'FULLTEXT_FILE_MANAGER'
,'DATABASE_MIRRORING_REDO'
,'DATABASE_MIRRORING_SERVER'
,'DATABASE_MIRRORING_CONNECTION'
,'DATABASE_MIRRORING_STREAM'
,'QUERY_OPTIMIZER_VD_MANAGER'
,'QUERY_OPTIMIZER_ID_MANAGER'
,'QUERY_OPTIMIZER_VIEW_REP'
,'RECOVERY_BAD_PAGE_TABLE'
,'RECOVERY_MANAGER'
,'SECURITY_OPERATION_RULE_TABLE'
,'SECURITY_OBJPERM_CACHE'
,'SECURITY_CRYPTO'
,'SECURITY_KEY_RING'
,'SECURITY_KEY_LIST'
,'SERVICE_BROKER_CONNECTION_RECEIVE'
,'SERVICE_BROKER_TRANSMISSION'
,'SERVICE_BROKER_TRANSMISSION_UPDATE'
,'SERVICE_BROKER_TRANSMISSION_STATE'
,'SERVICE_BROKER_TRANSMISSION_ERRORS'
,'SSBXmitWork'
,'SERVICE_BROKER_MESSAGE_TRANSMISSION'
,'SERVICE_BROKER_MAP_MANAGER'
,'SERVICE_BROKER_HOST_NAME'
,'SERVICE_BROKER_READ_CACHE'
,'SERVICE_BROKER_WAITFOR_MANAGER'
,'SERVICE_BROKER_WAITFOR_TRANSACTION_DATA'
,'SERVICE_BROKER_TRANSMISSION_TRANSACTION_DATA'
,'SERVICE_BROKER_TRANSPORT'
,'SERVICE_BROKER_MIRROR_ROUTE'
,'TRACE_ID'
,'TRACE_AUDIT_ID'
,'TRACE'
,'TRACE_CONTROLLER'
,'TRACE_EVENT_QUEUE'
,'TRANSACTION_DISTRIBUTED_MARK'
,'TRANSACTION_OUTCOME'
,'NESTING_TRANSACTION_READONLY'
,'NESTING_TRANSACTION_FULL'
,'MSQL_TRANSACTION_MANAGER'
,'DATABASE_AUTONAME_MANAGER'
,'UTILITY_DYNAMIC_VECTOR'
,'UTILITY_SPARSE_BITMAP'
,'UTILITY_DATABASE_DROP'
,'UTILITY_DYNAMIC_MANAGER_VIEW'
,'UTILITY_DEBUG_FILESTREAM'
,'UTILITY_LOCK_INFORMATION'
,'VERSIONING_TRANSACTION'
,'VERSIONING_TRANSACTION_LIST'
,'VERSIONING_TRANSACTION_CHAIN'
,'VERSIONING_STATE'
,'VERSIONING_STATE_CHANGE'
,'KTM_VIRTUAL_CLOCK')
order by wait_time_ms desc