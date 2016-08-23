DECLARE @rc INT
DECLARE @TraceID INT
DECLARE @MaxFiles INT
DECLARE @MaxFileSize BIGINT
DECLARE @EndTime DATETIME
DECLARE @OutputFileName NVARCHAR(256)
 
SET @MaxFileSize = 100
SET @MaxFiles = 4
SET @OutputFileName = 'C:\Trace_Output\queries_' +
    CONVERT(VARCHAR(20), GETDATE(),112) +
    REPLACE(CONVERT(VARCHAR(20), GETDATE(),108),':','')
SET @EndTime = DATEADD(mi,30,getdate())
 
exec @rc = sp_trace_create @TraceID output, 1, @OutputFileName, @MaxFileSize, @EndTime,@filecount=@MaxFiles
 
-- Set the events and columns
declare @on bit
set @on = 1
exec sp_trace_setevent @TraceID, 10, 35, @on
exec sp_trace_setevent @TraceID, 10, 16, @on
exec sp_trace_setevent @TraceID, 10, 1,  @on
exec sp_trace_setevent @TraceID, 10, 17, @on
exec sp_trace_setevent @TraceID, 10, 18, @on
exec sp_trace_setevent @TraceID, 10, 12, @on
exec sp_trace_setevent @TraceID, 10, 13, @on
exec sp_trace_setevent @TraceID, 10, 14, @on
exec sp_trace_setevent @TraceID, 12, 35, @on
exec sp_trace_setevent @TraceID, 12, 16, @on
exec sp_trace_setevent @TraceID, 12, 1,  @on
exec sp_trace_setevent @TraceID, 12, 17, @on
exec sp_trace_setevent @TraceID, 12, 14, @on
exec sp_trace_setevent @TraceID, 12, 18, @on
exec sp_trace_setevent @TraceID, 12, 12, @on
exec sp_trace_setevent @TraceID, 12, 13, @on
 
-- Set the trace status to start
exec sp_trace_setstatus @TraceID, 1
--exec sp_trace_setstatus 1, 2

select * from sys.traces