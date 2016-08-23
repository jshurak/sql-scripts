USE [msdb]
GO

/****** Object:  Table [dbo].[BlockMonitor]    Script Date: 07/29/2013 15:13:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BlockMonitor]') AND type in (N'U'))
DROP TABLE [dbo].[BlockMonitor]
GO

USE [msdb]
GO

/****** Object:  Table [dbo].[BlockMonitor]    Script Date: 07/29/2013 15:13:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[BlockMonitor](
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
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [msdb]
GO

/****** Object:  StoredProcedure [dbo].[sp_block_monitor]    Script Date: 07/29/2013 15:13:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_block_monitor]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_block_monitor]
GO

USE [msdb]
GO

/****** Object:  StoredProcedure [dbo].[sp_block_monitor]    Script Date: 07/29/2013 15:13:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_block_monitor]
AS
DECLARE @flag int

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
	DECLARE @numberOfRuns INT,  @msg NVARCHAR(1000),@destination_table varchar(60) ;
	SET @numberOfRuns = 2 ;
	Set @destination_table = '#BlockMonitor';

	WHILE @numberOfRuns > 0
		BEGIN;
			EXEC dbo.sp_WhoIsActive 
			@get_outer_command = 1
			,@get_transaction_info = 1
			,@get_plans = 1
			,@find_block_leaders = 1
			,@DESTINATION_TABLE = @destination_table ;

			SET @numberOfRuns = @numberOfRuns - 1 ;

			IF @numberOfRuns > 0
				BEGIN
					SET @msg = CONVERT(CHAR(19), GETDATE(), 121) + ': ' +
					 'Logged info. Waiting...'
					RAISERROR(@msg,0,0) WITH nowait ;

					WAITFOR DELAY '00:01:00'
				END
			ELSE
				BEGIN
					SET @msg = CONVERT(CHAR(19), GETDATE(), 121) + ': ' + 'Done.'
					RAISERROR(@msg,0,0) WITH nowait ;
				END

		END ;

	Insert into msdb.dbo.blockmonitor
	select top 1 * from #BlockMonitor
	order by blocked_session_count desc;		
	
	drop table #BlockMonitor

	
END	

GO

USE [msdb]
GO

/****** Object:  Job [Block Monitor]    Script Date: 07/29/2013 15:14:16 ******/
IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'Block Monitor')
EXEC msdb.dbo.sp_delete_job @job_id=N'dd33af14-0c1b-4ad1-81b2-a64f76411aff', @delete_unused_schedule=1
GO

USE [msdb]
GO

/****** Object:  Job [Block Monitor]    Script Date: 07/29/2013 15:14:16 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 07/29/2013 15:14:16 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Block Monitor', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'PSC\jshurak', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Execute Stored Procedure]    Script Date: 07/29/2013 15:14:17 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Execute Stored Procedure', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec msdb.dbo.sp_block_monitor', 
		@database_name=N'msdb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'2 minutes', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20130729, 
		@active_end_date=20130805, 
		@active_start_time=80000, 
		@active_end_time=170000--, 
		--@schedule_uid=N'0acf15bc-ba03-4033-8d75-70be8a71e3ab'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


