DECLARE @rc INT
DECLARE @TraceID INT
DECLARE @MaxFiles INT
DECLARE @MaxFileSize BIGINT
DECLARE @EndTime DATETIME
DECLARE @OutputFileName NVARCHAR(256)
 
SET @MaxFileSize = 100  -- max file size, ex. it will grow to 100MB before creating a new file
SET @MaxFiles = 4 -- total number of files sql server will create.  once this number has been reached, it will overwrite the oldest file
SET @OutputFileName = 'C:\Trace_Output\deadlocks_' +   --Change this to output location. It must exist before running trace
    CONVERT(VARCHAR(20), GETDATE(),112) +
    REPLACE(CONVERT(VARCHAR(20), GETDATE(),108),':','')
SET @EndTime = DATEADD(mi,30,getdate())  -- change these parameters to set max run time ex. dateadd(dd,10,getdate()) will run for 10 days
 
exec @rc = sp_trace_create @TraceID output, 2, @OutputFileName, @MaxFileSize, @EndTime,@filecount=@MaxFiles
 
-- Set the events and columns
declare @on bit
set @on = 1

exec sp_trace_setevent @TraceID, 148, 11, @on
exec sp_trace_setevent @TraceID, 148, 12, @on
exec sp_trace_setevent @TraceID, 148, 14, @on
exec sp_trace_setevent @TraceID, 148, 1, @on
exec sp_trace_setevent @TraceID, 25, 15, @on
exec sp_trace_setevent @TraceID, 25, 32, @on
exec sp_trace_setevent @TraceID, 25, 1, @on
exec sp_trace_setevent @TraceID, 25, 9, @on
exec sp_trace_setevent @TraceID, 25, 57, @on
exec sp_trace_setevent @TraceID, 25, 2, @on
exec sp_trace_setevent @TraceID, 25, 10, @on
exec sp_trace_setevent @TraceID, 25, 11, @on
exec sp_trace_setevent @TraceID, 25, 35, @on
exec sp_trace_setevent @TraceID, 25, 12, @on
exec sp_trace_setevent @TraceID, 25, 13, @on
exec sp_trace_setevent @TraceID, 25, 6, @on
exec sp_trace_setevent @TraceID, 25, 14, @on
exec sp_trace_setevent @TraceID, 25, 22, @on
exec sp_trace_setevent @TraceID, 59, 32, @on
exec sp_trace_setevent @TraceID, 59, 1, @on
exec sp_trace_setevent @TraceID, 59, 57, @on
exec sp_trace_setevent @TraceID, 59, 2, @on
exec sp_trace_setevent @TraceID, 59, 14, @on
exec sp_trace_setevent @TraceID, 59, 22, @on
exec sp_trace_setevent @TraceID, 59, 35, @on
exec sp_trace_setevent @TraceID, 59, 12, @on

 
-- Set the trace status to start
exec sp_trace_setstatus @TraceID, 1   --this starts the trace
--exec sp_trace_setstatus 2,0  --this stops the trace, query below to get trace id and replace the first paramter with id
--exec sp_trace_setstatus 2,2  -- this cleans up trace information, replace with trace id from query below

select * from sys.traces