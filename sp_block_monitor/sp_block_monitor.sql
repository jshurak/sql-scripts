USE [msdb]
GO
/****** Object:  StoredProcedure [dbo].[sp_block_monitor]    Script Date: 07/24/2013 16:18:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_block_monitor]
AS
DECLARE @flag int

--check for blocking
select @flag = COUNT(*) from sys.dm_exec_requests where blocking_session_id <> 0

IF @flag = 0 
	RETURN
ELSE	
BEGIN

	--create the temporary table that will hold results from sp_whoisactive
	create table #BlockMonitor(
		ID int identity(1,1)
		,Session_id	smallint not null
		,[dd hh:mm:ss.mss] varchar(15)
		,[sql_command] xml
		,[sql_text] xml
		,[blocking_session_count] varchar(30)
		,[locks] xml
		,[host_name] sysname
		,[login_name] sysname
		,[database_name] sysname
		,[program_name] sysname
		,[start_time] datetime
		--,[stop_time] datetime
	)


	drop table #BlockMonitor
	
END	