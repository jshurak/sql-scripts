/****************************************************/
/* Created by: SQL Server 2012  Profiler          */
/* Date: 01/20/2014  03:38:08 PM         */
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
exec sp_trace_setevent @TraceID, 16, 3, @on
exec sp_trace_setevent @TraceID, 16, 4, @on
exec sp_trace_setevent @TraceID, 16, 12, @on
exec sp_trace_setevent @TraceID, 16, 8, @on
exec sp_trace_setevent @TraceID, 16, 9, @on
exec sp_trace_setevent @TraceID, 16, 10, @on
exec sp_trace_setevent @TraceID, 16, 13, @on
exec sp_trace_setevent @TraceID, 16, 14, @on
exec sp_trace_setevent @TraceID, 16, 15, @on
exec sp_trace_setevent @TraceID, 16, 26, @on
exec sp_trace_setevent @TraceID, 16, 35, @on
exec sp_trace_setevent @TraceID, 16, 51, @on
exec sp_trace_setevent @TraceID, 16, 64, @on
exec sp_trace_setevent @TraceID, 137, 1, @on
exec sp_trace_setevent @TraceID, 137, 3, @on
exec sp_trace_setevent @TraceID, 137, 4, @on
exec sp_trace_setevent @TraceID, 137, 13, @on
exec sp_trace_setevent @TraceID, 137, 15, @on
exec sp_trace_setevent @TraceID, 137, 26, @on
exec sp_trace_setevent @TraceID, 137, 41, @on
exec sp_trace_setevent @TraceID, 137, 51, @on
exec sp_trace_setevent @TraceID, 137, 64, @on
exec sp_trace_setevent @TraceID, 41, 1, @on
exec sp_trace_setevent @TraceID, 41, 9, @on
exec sp_trace_setevent @TraceID, 41, 3, @on
exec sp_trace_setevent @TraceID, 41, 4, @on
exec sp_trace_setevent @TraceID, 41, 5, @on
exec sp_trace_setevent @TraceID, 41, 10, @on
exec sp_trace_setevent @TraceID, 41, 11, @on
exec sp_trace_setevent @TraceID, 41, 12, @on
exec sp_trace_setevent @TraceID, 41, 13, @on
exec sp_trace_setevent @TraceID, 41, 14, @on
exec sp_trace_setevent @TraceID, 41, 15, @on
exec sp_trace_setevent @TraceID, 41, 16, @on
exec sp_trace_setevent @TraceID, 41, 18, @on
exec sp_trace_setevent @TraceID, 41, 26, @on
exec sp_trace_setevent @TraceID, 41, 35, @on
exec sp_trace_setevent @TraceID, 41, 41, @on
exec sp_trace_setevent @TraceID, 41, 48, @on
exec sp_trace_setevent @TraceID, 41, 51, @on
exec sp_trace_setevent @TraceID, 40, 1, @on
exec sp_trace_setevent @TraceID, 40, 9, @on
exec sp_trace_setevent @TraceID, 40, 3, @on
exec sp_trace_setevent @TraceID, 40, 4, @on
exec sp_trace_setevent @TraceID, 40, 5, @on
exec sp_trace_setevent @TraceID, 40, 10, @on
exec sp_trace_setevent @TraceID, 40, 11, @on
exec sp_trace_setevent @TraceID, 40, 12, @on
exec sp_trace_setevent @TraceID, 40, 14, @on
exec sp_trace_setevent @TraceID, 40, 26, @on
exec sp_trace_setevent @TraceID, 40, 30, @on
exec sp_trace_setevent @TraceID, 40, 35, @on
exec sp_trace_setevent @TraceID, 40, 41, @on
exec sp_trace_setevent @TraceID, 40, 51, @on


-- Set the Filters
declare @intfilter int
declare @bigintfilter bigint

set @intfilter = 52
exec sp_trace_setfilter @TraceID, 3, 0, 0, @intfilter

exec sp_trace_setfilter @TraceID, 10, 0, 7, N'SQL Server Profiler - 02e6d1a5-d7d6-4cbe-bf07-c7ec415ffa4a'
-- Set the trace status to start
exec sp_trace_setstatus @TraceID, 1

-- display trace id for future references
select TraceID=@TraceID
goto finish

error: 
select ErrorCode=@rc

finish: 
go
