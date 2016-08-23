alter table msdb.dbo.BlockMonitor
add [locks] [xml] NULL

USE [msdb]
GO
/****** Object:  StoredProcedure [dbo].[sp_block_monitor]    Script Date: 07/31/2013 12:56:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




ALTER PROCEDURE [dbo].[sp_block_monitor]
AS
DECLARE @flag int,@session_id smallint,@start_time datetime

--check for blocking
select @flag = COUNT(*) from sys.dm_exec_requests where blocking_session_id <> 0

IF @flag = 0 
	RETURN
ELSE	
BEGIN

CREATE TABLE [dbo].[#BlockMonitor](
	[dd hh:mm:ss.mss] [varchar](15) NULL,
	[session_id] [smallint] NOT NULL,
	[sql_text] [xml] NULL,
	[sql_command] [xml] NULL,
	[login_name] [nvarchar](128) NOT NULL,
	[wait_info] [nvarchar](4000) NULL,
	[tran_log_writes] [nvarchar](4000) NULL,
	[CPU] [varchar](30) NULL,
	[tempdb_allocations] [varchar](30) NULL,
	[tempdb_current] [varchar](30) NULL,
	[blocking_session_id] [smallint] NULL,
	[blocked_session_count] [varchar](30) NULL,
	[reads] [varchar](30) NULL,
	[writes] [varchar](30) NULL,
	[physical_reads] [varchar](30) NULL,
	[query_plan] [xml] NULL,
	[locks] [xml] NULL,
	[used_memory] [varchar](30) NULL,
	[status] [varchar](30) NOT NULL,
	[tran_start_time] [datetime] NULL,
	[open_tran_count] [varchar](30) NULL,
	[percent_complete] [varchar](30) NULL,
	[host_name] [nvarchar](128) NULL,
	[database_name] [nvarchar](128) NULL,
	[program_name] [nvarchar](128) NULL,
	[start_time] [datetime] NOT NULL,
	[request_id] [int] NULL,
	[collection_time] [datetime] NOT NULL
) 


	--begins looping and collections
	DECLARE @destination_table varchar(60) ;

	Set @destination_table = '#BlockMonitor';


			EXEC dbo.sp_WhoIsActive 
			@get_outer_command = 1
			,@get_transaction_info = 1
			,@get_plans = 1
			,@find_block_leaders = 1
			,@get_locks = 1
			,@DESTINATION_TABLE = @destination_table ;


	select top 1 
		@session_id = session_id
		,@start_time = start_time
	from #BlockMonitor
	where blocked_session_count > 0 
	order by blocked_session_count desc;		
	
	if not exists(select 1 from msdb.dbo.BlockMonitor where session_id = @session_id and start_time = @start_time)
	BEGIN
		Insert into msdb.dbo.blockmonitor(
			[dd hh:mm:ss.mss]
			,[session_id]
			,[sql_text]
			,[sql_command]
			,[login_name]
			,[wait_info]
			,[tran_log_writes]
			,[CPU]
			,[tempdb_allocations]
			,[tempdb_current]
			,[blocking_session_id]
			,[blocked_session_count]
			,[reads]
			,[writes]
			,[physical_reads]
			,[query_plan]
			,[locks]
			,[used_memory]
			,[status]
			,[tran_start_time]
			,[open_tran_count]
			,[percent_complete]
			,[host_name]
			,[database_name]
			,[program_name]
			,[start_time]
			,[request_id]
			,[collection_time])
		select top 1 
			[dd hh:mm:ss.mss]
			,[session_id]
			,[sql_text]
			,[sql_command]
			,[login_name]
			,[wait_info]
			,[tran_log_writes]
			,[CPU]
			,[tempdb_allocations]
			,[tempdb_current]
			,[blocking_session_id]
			,[blocked_session_count]
			,[reads]
			,[writes]
			,[physical_reads]
			,[query_plan]
			,[locks]
			,[used_memory]
			,[status]
			,[tran_start_time]
			,[open_tran_count]
			,[percent_complete]
			,[host_name]
			,[database_name]
			,[program_name]
			,[start_time]
			,[request_id]
			,[collection_time] 
		from #BlockMonitor
		where blocked_session_count > 0 
		order by blocked_session_count desc;
	END
	drop table #BlockMonitor

	
END	



