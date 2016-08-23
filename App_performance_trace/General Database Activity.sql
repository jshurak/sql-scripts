DECLARE @rc INT
DECLARE @TraceID INT
DECLARE @MaxFiles INT
DECLARE @MaxFileSize BIGINT
DECLARE @EndTime DATETIME
DECLARE @OutputFileName NVARCHAR(256)
 
SET @MaxFileSize = 100
SET @MaxFiles = 4
SET @OutputFileName = 'C:\Trace_Output\DatabaseAccess_' +
    CONVERT(VARCHAR(20), GETDATE(),112) +
    REPLACE(CONVERT(VARCHAR(20), GETDATE(),108),':','')
SET @EndTime = DATEADD(mi,30,getdate())
 
exec @rc = sp_trace_create @TraceID output, 2, @OutputFileName, @MaxFileSize, @EndTime,@filecount=@MaxFiles
 
-- Set the events
declare @on bit
set @on = 1
exec sp_trace_setevent @TraceID, 10, 10, @on
exec sp_trace_setevent @TraceID, 10, 3, @on
exec sp_trace_setevent @TraceID, 10, 6, @on
exec sp_trace_setevent @TraceID, 10, 11, @on
exec sp_trace_setevent @TraceID, 10, 12, @on
exec sp_trace_setevent @TraceID, 10, 14, @on
exec sp_trace_setevent @TraceID, 10, 15, @on
exec sp_trace_setevent @TraceID, 10, 35, @on
exec sp_trace_setevent @TraceID, 12, 1, @on
exec sp_trace_setevent @TraceID, 12, 3, @on
exec sp_trace_setevent @TraceID, 12, 11, @on
exec sp_trace_setevent @TraceID, 12, 6, @on
exec sp_trace_setevent @TraceID, 12, 10, @on
exec sp_trace_setevent @TraceID, 12, 12, @on
exec sp_trace_setevent @TraceID, 12, 14, @on
exec sp_trace_setevent @TraceID, 12, 15, @on
exec sp_trace_setevent @TraceID, 12, 35, @on
exec sp_trace_setevent @TraceID, 13, 1, @on
exec sp_trace_setevent @TraceID, 13, 3, @on
exec sp_trace_setevent @TraceID, 13, 11, @on
exec sp_trace_setevent @TraceID, 13, 6, @on
exec sp_trace_setevent @TraceID, 13, 10, @on
exec sp_trace_setevent @TraceID, 13, 12, @on
exec sp_trace_setevent @TraceID, 13, 14, @on
exec sp_trace_setevent @TraceID, 13, 35, @on


-- Set the Filters
declare @intfilter int
declare @bigintfilter bigint

exec sp_trace_setfilter @TraceID, 10, 0, 7, N'SQL Server Profiler - 8eefeb32-b8c2-4331-9b72-f87658b93c47'
exec sp_trace_setfilter @TraceID, 35, 0, 6, N'AdventureWorks'
exec sp_trace_setfilter @TraceID, 35, 1, 6, N'AdventureWorks2012'
-- Set the trace status to start
exec sp_trace_setstatus @TraceID, 1
--exec sp_trace_setstatus 2, 2

select * from sys.traces