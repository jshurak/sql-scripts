/****************************************************/
/* Created by: SQL Server 2008 Profiler             */
/* Date: 07/23/2013  12:06:03 AM         */
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
exec sp_trace_setevent @TraceID, 137, 15, @on
exec sp_trace_setevent @TraceID, 137, 32, @on
exec sp_trace_setevent @TraceID, 137, 1, @on
exec sp_trace_setevent @TraceID, 137, 13, @on
exec sp_trace_setevent @TraceID, 137, 22, @on
exec sp_trace_setevent @TraceID, 148, 11, @on
exec sp_trace_setevent @TraceID, 148, 12, @on
exec sp_trace_setevent @TraceID, 148, 14, @on
exec sp_trace_setevent @TraceID, 148, 1, @on
exec sp_trace_setevent @TraceID, 26, 15, @on
exec sp_trace_setevent @TraceID, 26, 32, @on
exec sp_trace_setevent @TraceID, 26, 1, @on
exec sp_trace_setevent @TraceID, 26, 9, @on
exec sp_trace_setevent @TraceID, 26, 57, @on
exec sp_trace_setevent @TraceID, 26, 2, @on
exec sp_trace_setevent @TraceID, 26, 10, @on
exec sp_trace_setevent @TraceID, 26, 11, @on
exec sp_trace_setevent @TraceID, 26, 35, @on
exec sp_trace_setevent @TraceID, 26, 12, @on
exec sp_trace_setevent @TraceID, 26, 13, @on
exec sp_trace_setevent @TraceID, 26, 6, @on
exec sp_trace_setevent @TraceID, 26, 14, @on
exec sp_trace_setevent @TraceID, 26, 22, @on
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
exec sp_trace_setevent @TraceID, 60, 32, @on
exec sp_trace_setevent @TraceID, 60, 9, @on
exec sp_trace_setevent @TraceID, 60, 57, @on
exec sp_trace_setevent @TraceID, 60, 10, @on
exec sp_trace_setevent @TraceID, 60, 11, @on
exec sp_trace_setevent @TraceID, 60, 35, @on
exec sp_trace_setevent @TraceID, 60, 12, @on
exec sp_trace_setevent @TraceID, 60, 6, @on
exec sp_trace_setevent @TraceID, 60, 14, @on
exec sp_trace_setevent @TraceID, 60, 22, @on
exec sp_trace_setevent @TraceID, 189, 15, @on
exec sp_trace_setevent @TraceID, 189, 32, @on
exec sp_trace_setevent @TraceID, 189, 1, @on
exec sp_trace_setevent @TraceID, 189, 9, @on
exec sp_trace_setevent @TraceID, 189, 57, @on
exec sp_trace_setevent @TraceID, 189, 2, @on
exec sp_trace_setevent @TraceID, 189, 10, @on
exec sp_trace_setevent @TraceID, 189, 11, @on
exec sp_trace_setevent @TraceID, 189, 35, @on
exec sp_trace_setevent @TraceID, 189, 12, @on
exec sp_trace_setevent @TraceID, 189, 13, @on
exec sp_trace_setevent @TraceID, 189, 6, @on
exec sp_trace_setevent @TraceID, 189, 14, @on
exec sp_trace_setevent @TraceID, 189, 22, @on
exec sp_trace_setevent @TraceID, 45, 16, @on
exec sp_trace_setevent @TraceID, 45, 1, @on
exec sp_trace_setevent @TraceID, 45, 9, @on
exec sp_trace_setevent @TraceID, 45, 17, @on
exec sp_trace_setevent @TraceID, 45, 10, @on
exec sp_trace_setevent @TraceID, 45, 18, @on
exec sp_trace_setevent @TraceID, 45, 11, @on
exec sp_trace_setevent @TraceID, 45, 35, @on
exec sp_trace_setevent @TraceID, 45, 12, @on
exec sp_trace_setevent @TraceID, 45, 13, @on
exec sp_trace_setevent @TraceID, 45, 6, @on
exec sp_trace_setevent @TraceID, 45, 14, @on
exec sp_trace_setevent @TraceID, 45, 22, @on
exec sp_trace_setevent @TraceID, 45, 15, @on
exec sp_trace_setevent @TraceID, 44, 1, @on
exec sp_trace_setevent @TraceID, 44, 9, @on
exec sp_trace_setevent @TraceID, 44, 10, @on
exec sp_trace_setevent @TraceID, 44, 11, @on
exec sp_trace_setevent @TraceID, 44, 35, @on
exec sp_trace_setevent @TraceID, 44, 12, @on
exec sp_trace_setevent @TraceID, 44, 6, @on
exec sp_trace_setevent @TraceID, 44, 14, @on
exec sp_trace_setevent @TraceID, 44, 22, @on
exec sp_trace_setevent @TraceID, 41, 15, @on
exec sp_trace_setevent @TraceID, 41, 16, @on
exec sp_trace_setevent @TraceID, 41, 1, @on
exec sp_trace_setevent @TraceID, 41, 9, @on
exec sp_trace_setevent @TraceID, 41, 17, @on
exec sp_trace_setevent @TraceID, 41, 10, @on
exec sp_trace_setevent @TraceID, 41, 18, @on
exec sp_trace_setevent @TraceID, 41, 11, @on
exec sp_trace_setevent @TraceID, 41, 35, @on
exec sp_trace_setevent @TraceID, 41, 12, @on
exec sp_trace_setevent @TraceID, 41, 13, @on
exec sp_trace_setevent @TraceID, 41, 6, @on
exec sp_trace_setevent @TraceID, 41, 14, @on
exec sp_trace_setevent @TraceID, 40, 1, @on
exec sp_trace_setevent @TraceID, 40, 9, @on
exec sp_trace_setevent @TraceID, 40, 6, @on
exec sp_trace_setevent @TraceID, 40, 10, @on
exec sp_trace_setevent @TraceID, 40, 14, @on
exec sp_trace_setevent @TraceID, 40, 11, @on
exec sp_trace_setevent @TraceID, 40, 35, @on
exec sp_trace_setevent @TraceID, 40, 12, @on


-- Set the Filters
declare @intfilter int
declare @bigintfilter bigint

exec sp_trace_setfilter @TraceID, 10, 0, 7, N'SQL Server Profiler - f9fc9689-24f4-4139-a06a-f3595b83cb0f'
-- Set the trace status to start
exec sp_trace_setstatus @TraceID, 1

-- display trace id for future references
select TraceID=@TraceID
goto finish

error: 
select ErrorCode=@rc

finish: 
go
