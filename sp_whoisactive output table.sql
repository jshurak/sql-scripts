DECLARE @destination_table VARCHAR(4000), @msg NVARCHAR(1000) ;
	SET @destination_table = 'BlockMonitor_new';

	DECLARE @schema VARCHAR(4000) ;
	EXEC sp_WhoIsActive
	@get_outer_command = 1,
	@get_transaction_info = 1,
	@get_plans = 1,
	@find_block_leaders = 1,
	@get_locks = 1,
	@RETURN_SCHEMA = 1,
	@SCHEMA = @schema OUTPUT ;

	SET @schema = REPLACE(@schema, '<table_name>', @destination_table) ;

	PRINT @schema
	EXEC(@schema) ;