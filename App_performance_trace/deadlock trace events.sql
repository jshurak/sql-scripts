/****************************************************/
/* Created by: SQL Server 2012  Profiler          */
/* Date: 10/03/2013  08:12:52 AM         */
/****************************************************/


-- Create a Queue
declare @rc int
declare @TraceID int
declare @maxfilesize bigint
set @maxfilesize = 5 

-- Please replace the text InsertFileNameHere, with an appropriate
-- filename prefixed by a path, e.g., c:\MyFolder\MyTrace. The .trc extension
-- will be appended to the filename automatically. If you are writing from
-- remote server to local drive, please use UNC path and make sure server has
-- write access to your network share

exec @rc = sp_trace_create @TraceID output, 0, N'InsertFileNameHere', @maxfilesize, NULL 
if (@rc != 0) goto error

-- Client side File and Table cannot be scripted

-- Set the events
declare @on bit
set @on = 1
exec sp_trace_setevent @TraceID, 148, 1, @on
exec sp_trace_setevent @TraceID, 148, 41, @on
exec sp_trace_setevent @TraceID, 148, 4, @on
exec sp_trace_setevent @TraceID, 148, 12, @on
exec sp_trace_setevent @TraceID, 148, 11, @on
exec sp_trace_setevent @TraceID, 148, 51, @on
exec sp_trace_setevent @TraceID, 148, 14, @on
exec sp_trace_setevent @TraceID, 148, 26, @on
exec sp_trace_setevent @TraceID, 148, 60, @on
exec sp_trace_setevent @TraceID, 148, 64, @on
exec sp_trace_setevent @TraceID, 25, 1, @on
exec sp_trace_setevent @TraceID, 25, 9, @on
exec sp_trace_setevent @TraceID, 25, 2, @on
exec sp_trace_setevent @TraceID, 25, 10, @on
exec sp_trace_setevent @TraceID, 25, 3, @on
exec sp_trace_setevent @TraceID, 25, 4, @on
exec sp_trace_setevent @TraceID, 25, 6, @on
exec sp_trace_setevent @TraceID, 25, 7, @on
exec sp_trace_setevent @TraceID, 25, 8, @on
exec sp_trace_setevent @TraceID, 25, 11, @on
exec sp_trace_setevent @TraceID, 25, 12, @on
exec sp_trace_setevent @TraceID, 25, 13, @on
exec sp_trace_setevent @TraceID, 25, 14, @on
exec sp_trace_setevent @TraceID, 25, 15, @on
exec sp_trace_setevent @TraceID, 25, 22, @on
exec sp_trace_setevent @TraceID, 25, 25, @on
exec sp_trace_setevent @TraceID, 25, 26, @on
exec sp_trace_setevent @TraceID, 25, 32, @on
exec sp_trace_setevent @TraceID, 25, 35, @on
exec sp_trace_setevent @TraceID, 25, 41, @on
exec sp_trace_setevent @TraceID, 25, 49, @on
exec sp_trace_setevent @TraceID, 25, 51, @on
exec sp_trace_setevent @TraceID, 25, 52, @on
exec sp_trace_setevent @TraceID, 25, 55, @on
exec sp_trace_setevent @TraceID, 25, 56, @on
exec sp_trace_setevent @TraceID, 25, 57, @on
exec sp_trace_setevent @TraceID, 25, 58, @on
exec sp_trace_setevent @TraceID, 25, 60, @on
exec sp_trace_setevent @TraceID, 25, 64, @on
exec sp_trace_setevent @TraceID, 59, 1, @on
exec sp_trace_setevent @TraceID, 59, 25, @on
exec sp_trace_setevent @TraceID, 59, 2, @on
exec sp_trace_setevent @TraceID, 59, 3, @on
exec sp_trace_setevent @TraceID, 59, 4, @on
exec sp_trace_setevent @TraceID, 59, 12, @on
exec sp_trace_setevent @TraceID, 59, 14, @on
exec sp_trace_setevent @TraceID, 59, 22, @on
exec sp_trace_setevent @TraceID, 59, 21, @on
exec sp_trace_setevent @TraceID, 59, 26, @on
exec sp_trace_setevent @TraceID, 59, 32, @on
exec sp_trace_setevent @TraceID, 59, 35, @on
exec sp_trace_setevent @TraceID, 59, 41, @on
exec sp_trace_setevent @TraceID, 59, 49, @on
exec sp_trace_setevent @TraceID, 59, 51, @on
exec sp_trace_setevent @TraceID, 59, 52, @on
exec sp_trace_setevent @TraceID, 59, 55, @on
exec sp_trace_setevent @TraceID, 59, 56, @on
exec sp_trace_setevent @TraceID, 59, 57, @on
exec sp_trace_setevent @TraceID, 59, 58, @on
exec sp_trace_setevent @TraceID, 59, 60, @on
exec sp_trace_setevent @TraceID, 59, 64, @on


-- Set the Filters
declare @intfilter int
declare @bigintfilter bigint

exec sp_trace_setfilter @TraceID, 10, 0, 7, N'SQL Server Profiler - 0ac1fb06-16ee-4ecb-bdfa-d9ad3a1c03e3'
-- Set the trace status to start
exec sp_trace_setstatus @TraceID, 1

-- display trace id for future references
select TraceID=@TraceID
goto finish

error: 
select ErrorCode=@rc

finish: 
go
