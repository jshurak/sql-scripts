DECLARE @rc INT
DECLARE @TraceID INT
DECLARE @MaxFiles INT
DECLARE @MaxFileSize BIGINT
DECLARE @EndTime DATETIME
DECLARE @OutputFileName NVARCHAR(256)
 
SET @MaxFileSize = 100
SET @MaxFiles = 4
SET @OutputFileName = 'C:\Trace\BlockMonitor_' +
    CONVERT(VARCHAR(20), GETDATE(),112) +
    REPLACE(CONVERT(VARCHAR(20), GETDATE(),108),':','')
SET @EndTime = DATEADD(mi,10,getdate())
 
exec @rc = sp_trace_create @TraceID output, 1, @OutputFileName, @MaxFileSize, @EndTime,@filecount=@MaxFiles
 
-- Set the events and columns
declare @on bit
set @on = 1
exec sp_trace_setevent @TraceID, 137, 3, @on
exec sp_trace_setevent @TraceID, 137, 15, @on
exec sp_trace_setevent @TraceID, 137, 51, @on
exec sp_trace_setevent @TraceID, 137, 4, @on
exec sp_trace_setevent @TraceID, 137, 12, @on
exec sp_trace_setevent @TraceID, 137, 24, @on
exec sp_trace_setevent @TraceID, 137, 32, @on
exec sp_trace_setevent @TraceID, 137, 60, @on
exec sp_trace_setevent @TraceID, 137, 64, @on
exec sp_trace_setevent @TraceID, 137, 1, @on
exec sp_trace_setevent @TraceID, 137, 13, @on
exec sp_trace_setevent @TraceID, 137, 41, @on
exec sp_trace_setevent @TraceID, 137, 14, @on
exec sp_trace_setevent @TraceID, 137, 22, @on
exec sp_trace_setevent @TraceID, 137, 26, @on
 
-- Set the trace status to start
exec sp_trace_setstatus @TraceID, 1
--exec sp_trace_setstatus 1, 2

select * from sys.traces