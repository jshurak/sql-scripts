/****************************************************/
/* Created by: SQL Server 2012  Profiler          */
/* Date: 01/29/2014  02:17:37 PM         */
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
exec sp_trace_setevent @TraceID, 14, 1, @on
exec sp_trace_setevent @TraceID, 14, 9, @on
exec sp_trace_setevent @TraceID, 14, 10, @on
exec sp_trace_setevent @TraceID, 14, 11, @on
exec sp_trace_setevent @TraceID, 14, 6, @on
exec sp_trace_setevent @TraceID, 14, 12, @on
exec sp_trace_setevent @TraceID, 14, 14, @on
exec sp_trace_setevent @TraceID, 15, 11, @on
exec sp_trace_setevent @TraceID, 15, 6, @on
exec sp_trace_setevent @TraceID, 15, 9, @on
exec sp_trace_setevent @TraceID, 15, 10, @on
exec sp_trace_setevent @TraceID, 15, 12, @on
exec sp_trace_setevent @TraceID, 15, 13, @on
exec sp_trace_setevent @TraceID, 15, 14, @on
exec sp_trace_setevent @TraceID, 15, 15, @on
exec sp_trace_setevent @TraceID, 15, 16, @on
exec sp_trace_setevent @TraceID, 15, 17, @on
exec sp_trace_setevent @TraceID, 15, 18, @on
exec sp_trace_setevent @TraceID, 17, 1, @on
exec sp_trace_setevent @TraceID, 17, 9, @on
exec sp_trace_setevent @TraceID, 17, 10, @on
exec sp_trace_setevent @TraceID, 17, 11, @on
exec sp_trace_setevent @TraceID, 17, 6, @on
exec sp_trace_setevent @TraceID, 17, 12, @on
exec sp_trace_setevent @TraceID, 17, 14, @on
exec sp_trace_setevent @TraceID, 10, 9, @on
exec sp_trace_setevent @TraceID, 10, 2, @on
exec sp_trace_setevent @TraceID, 10, 10, @on
exec sp_trace_setevent @TraceID, 10, 6, @on
exec sp_trace_setevent @TraceID, 10, 11, @on
exec sp_trace_setevent @TraceID, 10, 12, @on
exec sp_trace_setevent @TraceID, 10, 13, @on
exec sp_trace_setevent @TraceID, 10, 14, @on
exec sp_trace_setevent @TraceID, 10, 15, @on
exec sp_trace_setevent @TraceID, 10, 16, @on
exec sp_trace_setevent @TraceID, 10, 17, @on
exec sp_trace_setevent @TraceID, 10, 18, @on
exec sp_trace_setevent @TraceID, 12, 1, @on
exec sp_trace_setevent @TraceID, 12, 9, @on
exec sp_trace_setevent @TraceID, 12, 11, @on
exec sp_trace_setevent @TraceID, 12, 6, @on
exec sp_trace_setevent @TraceID, 12, 10, @on
exec sp_trace_setevent @TraceID, 12, 12, @on
exec sp_trace_setevent @TraceID, 12, 13, @on
exec sp_trace_setevent @TraceID, 12, 14, @on
exec sp_trace_setevent @TraceID, 12, 15, @on
exec sp_trace_setevent @TraceID, 12, 16, @on
exec sp_trace_setevent @TraceID, 12, 17, @on
exec sp_trace_setevent @TraceID, 12, 18, @on
exec sp_trace_setevent @TraceID, 13, 1, @on
exec sp_trace_setevent @TraceID, 13, 9, @on
exec sp_trace_setevent @TraceID, 13, 11, @on
exec sp_trace_setevent @TraceID, 13, 6, @on
exec sp_trace_setevent @TraceID, 13, 10, @on
exec sp_trace_setevent @TraceID, 13, 12, @on
exec sp_trace_setevent @TraceID, 13, 14, @on
exec sp_trace_setevent @TraceID, 19, 1, @on
exec sp_trace_setevent @TraceID, 19, 9, @on
exec sp_trace_setevent @TraceID, 19, 2, @on
exec sp_trace_setevent @TraceID, 19, 66, @on
exec sp_trace_setevent @TraceID, 19, 10, @on
exec sp_trace_setevent @TraceID, 19, 3, @on
exec sp_trace_setevent @TraceID, 19, 4, @on
exec sp_trace_setevent @TraceID, 19, 6, @on
exec sp_trace_setevent @TraceID, 19, 7, @on
exec sp_trace_setevent @TraceID, 19, 8, @on
exec sp_trace_setevent @TraceID, 19, 11, @on
exec sp_trace_setevent @TraceID, 19, 12, @on
exec sp_trace_setevent @TraceID, 19, 14, @on
exec sp_trace_setevent @TraceID, 19, 21, @on
exec sp_trace_setevent @TraceID, 19, 25, @on
exec sp_trace_setevent @TraceID, 19, 26, @on
exec sp_trace_setevent @TraceID, 19, 35, @on
exec sp_trace_setevent @TraceID, 19, 41, @on
exec sp_trace_setevent @TraceID, 19, 49, @on
exec sp_trace_setevent @TraceID, 19, 50, @on
exec sp_trace_setevent @TraceID, 19, 51, @on
exec sp_trace_setevent @TraceID, 19, 60, @on
exec sp_trace_setevent @TraceID, 19, 64, @on
exec sp_trace_setevent @TraceID, 50, 1, @on
exec sp_trace_setevent @TraceID, 50, 9, @on
exec sp_trace_setevent @TraceID, 50, 3, @on
exec sp_trace_setevent @TraceID, 50, 11, @on
exec sp_trace_setevent @TraceID, 50, 4, @on
exec sp_trace_setevent @TraceID, 50, 6, @on
exec sp_trace_setevent @TraceID, 50, 7, @on
exec sp_trace_setevent @TraceID, 50, 8, @on
exec sp_trace_setevent @TraceID, 50, 10, @on
exec sp_trace_setevent @TraceID, 50, 12, @on
exec sp_trace_setevent @TraceID, 50, 13, @on
exec sp_trace_setevent @TraceID, 50, 14, @on
exec sp_trace_setevent @TraceID, 50, 15, @on
exec sp_trace_setevent @TraceID, 50, 21, @on
exec sp_trace_setevent @TraceID, 50, 25, @on
exec sp_trace_setevent @TraceID, 50, 26, @on
exec sp_trace_setevent @TraceID, 50, 34, @on
exec sp_trace_setevent @TraceID, 50, 35, @on
exec sp_trace_setevent @TraceID, 50, 41, @on
exec sp_trace_setevent @TraceID, 50, 49, @on
exec sp_trace_setevent @TraceID, 50, 50, @on
exec sp_trace_setevent @TraceID, 50, 51, @on
exec sp_trace_setevent @TraceID, 50, 60, @on
exec sp_trace_setevent @TraceID, 50, 64, @on
exec sp_trace_setevent @TraceID, 50, 66, @on
exec sp_trace_setevent @TraceID, 182, 1, @on
exec sp_trace_setevent @TraceID, 182, 9, @on
exec sp_trace_setevent @TraceID, 182, 3, @on
exec sp_trace_setevent @TraceID, 182, 11, @on
exec sp_trace_setevent @TraceID, 182, 4, @on
exec sp_trace_setevent @TraceID, 182, 6, @on
exec sp_trace_setevent @TraceID, 182, 7, @on
exec sp_trace_setevent @TraceID, 182, 8, @on
exec sp_trace_setevent @TraceID, 182, 10, @on
exec sp_trace_setevent @TraceID, 182, 12, @on
exec sp_trace_setevent @TraceID, 182, 14, @on
exec sp_trace_setevent @TraceID, 182, 23, @on
exec sp_trace_setevent @TraceID, 182, 26, @on
exec sp_trace_setevent @TraceID, 182, 31, @on
exec sp_trace_setevent @TraceID, 182, 35, @on
exec sp_trace_setevent @TraceID, 182, 41, @on
exec sp_trace_setevent @TraceID, 182, 49, @on
exec sp_trace_setevent @TraceID, 182, 50, @on
exec sp_trace_setevent @TraceID, 182, 51, @on
exec sp_trace_setevent @TraceID, 182, 60, @on
exec sp_trace_setevent @TraceID, 182, 64, @on
exec sp_trace_setevent @TraceID, 182, 66, @on
exec sp_trace_setevent @TraceID, 181, 1, @on
exec sp_trace_setevent @TraceID, 181, 9, @on
exec sp_trace_setevent @TraceID, 181, 3, @on
exec sp_trace_setevent @TraceID, 181, 11, @on
exec sp_trace_setevent @TraceID, 181, 4, @on
exec sp_trace_setevent @TraceID, 181, 6, @on
exec sp_trace_setevent @TraceID, 181, 7, @on
exec sp_trace_setevent @TraceID, 181, 8, @on
exec sp_trace_setevent @TraceID, 181, 10, @on
exec sp_trace_setevent @TraceID, 181, 12, @on
exec sp_trace_setevent @TraceID, 181, 14, @on
exec sp_trace_setevent @TraceID, 181, 26, @on
exec sp_trace_setevent @TraceID, 181, 35, @on
exec sp_trace_setevent @TraceID, 181, 41, @on
exec sp_trace_setevent @TraceID, 181, 49, @on
exec sp_trace_setevent @TraceID, 181, 50, @on
exec sp_trace_setevent @TraceID, 181, 51, @on
exec sp_trace_setevent @TraceID, 181, 60, @on
exec sp_trace_setevent @TraceID, 181, 64, @on
exec sp_trace_setevent @TraceID, 181, 66, @on
exec sp_trace_setevent @TraceID, 186, 1, @on
exec sp_trace_setevent @TraceID, 186, 9, @on
exec sp_trace_setevent @TraceID, 186, 3, @on
exec sp_trace_setevent @TraceID, 186, 11, @on
exec sp_trace_setevent @TraceID, 186, 4, @on
exec sp_trace_setevent @TraceID, 186, 6, @on
exec sp_trace_setevent @TraceID, 186, 7, @on
exec sp_trace_setevent @TraceID, 186, 8, @on
exec sp_trace_setevent @TraceID, 186, 10, @on
exec sp_trace_setevent @TraceID, 186, 12, @on
exec sp_trace_setevent @TraceID, 186, 14, @on
exec sp_trace_setevent @TraceID, 186, 21, @on
exec sp_trace_setevent @TraceID, 186, 23, @on
exec sp_trace_setevent @TraceID, 186, 26, @on
exec sp_trace_setevent @TraceID, 186, 31, @on
exec sp_trace_setevent @TraceID, 186, 35, @on
exec sp_trace_setevent @TraceID, 186, 41, @on
exec sp_trace_setevent @TraceID, 186, 49, @on
exec sp_trace_setevent @TraceID, 186, 50, @on
exec sp_trace_setevent @TraceID, 186, 51, @on
exec sp_trace_setevent @TraceID, 186, 60, @on
exec sp_trace_setevent @TraceID, 186, 64, @on
exec sp_trace_setevent @TraceID, 186, 66, @on
exec sp_trace_setevent @TraceID, 185, 1, @on
exec sp_trace_setevent @TraceID, 185, 9, @on
exec sp_trace_setevent @TraceID, 185, 3, @on
exec sp_trace_setevent @TraceID, 185, 11, @on
exec sp_trace_setevent @TraceID, 185, 4, @on
exec sp_trace_setevent @TraceID, 185, 6, @on
exec sp_trace_setevent @TraceID, 185, 7, @on
exec sp_trace_setevent @TraceID, 185, 8, @on
exec sp_trace_setevent @TraceID, 185, 10, @on
exec sp_trace_setevent @TraceID, 185, 12, @on
exec sp_trace_setevent @TraceID, 185, 14, @on
exec sp_trace_setevent @TraceID, 185, 21, @on
exec sp_trace_setevent @TraceID, 185, 26, @on
exec sp_trace_setevent @TraceID, 185, 35, @on
exec sp_trace_setevent @TraceID, 185, 41, @on
exec sp_trace_setevent @TraceID, 185, 49, @on
exec sp_trace_setevent @TraceID, 185, 50, @on
exec sp_trace_setevent @TraceID, 185, 51, @on
exec sp_trace_setevent @TraceID, 185, 60, @on
exec sp_trace_setevent @TraceID, 185, 64, @on
exec sp_trace_setevent @TraceID, 185, 66, @on
exec sp_trace_setevent @TraceID, 184, 2, @on
exec sp_trace_setevent @TraceID, 184, 66, @on
exec sp_trace_setevent @TraceID, 184, 10, @on
exec sp_trace_setevent @TraceID, 184, 3, @on
exec sp_trace_setevent @TraceID, 184, 11, @on
exec sp_trace_setevent @TraceID, 184, 4, @on
exec sp_trace_setevent @TraceID, 184, 6, @on
exec sp_trace_setevent @TraceID, 184, 7, @on
exec sp_trace_setevent @TraceID, 184, 8, @on
exec sp_trace_setevent @TraceID, 184, 9, @on
exec sp_trace_setevent @TraceID, 184, 12, @on
exec sp_trace_setevent @TraceID, 184, 14, @on
exec sp_trace_setevent @TraceID, 184, 23, @on
exec sp_trace_setevent @TraceID, 184, 26, @on
exec sp_trace_setevent @TraceID, 184, 31, @on
exec sp_trace_setevent @TraceID, 184, 35, @on
exec sp_trace_setevent @TraceID, 184, 41, @on
exec sp_trace_setevent @TraceID, 184, 49, @on
exec sp_trace_setevent @TraceID, 184, 50, @on
exec sp_trace_setevent @TraceID, 184, 51, @on
exec sp_trace_setevent @TraceID, 184, 60, @on
exec sp_trace_setevent @TraceID, 184, 64, @on
exec sp_trace_setevent @TraceID, 183, 3, @on
exec sp_trace_setevent @TraceID, 183, 11, @on
exec sp_trace_setevent @TraceID, 183, 4, @on
exec sp_trace_setevent @TraceID, 183, 12, @on
exec sp_trace_setevent @TraceID, 183, 6, @on
exec sp_trace_setevent @TraceID, 183, 7, @on
exec sp_trace_setevent @TraceID, 183, 8, @on
exec sp_trace_setevent @TraceID, 183, 9, @on
exec sp_trace_setevent @TraceID, 183, 10, @on
exec sp_trace_setevent @TraceID, 183, 14, @on
exec sp_trace_setevent @TraceID, 183, 26, @on
exec sp_trace_setevent @TraceID, 183, 35, @on
exec sp_trace_setevent @TraceID, 183, 41, @on
exec sp_trace_setevent @TraceID, 183, 49, @on
exec sp_trace_setevent @TraceID, 183, 50, @on
exec sp_trace_setevent @TraceID, 183, 51, @on
exec sp_trace_setevent @TraceID, 183, 60, @on
exec sp_trace_setevent @TraceID, 183, 64, @on
exec sp_trace_setevent @TraceID, 183, 66, @on
exec sp_trace_setevent @TraceID, 188, 1, @on
exec sp_trace_setevent @TraceID, 188, 9, @on
exec sp_trace_setevent @TraceID, 188, 3, @on
exec sp_trace_setevent @TraceID, 188, 11, @on
exec sp_trace_setevent @TraceID, 188, 4, @on
exec sp_trace_setevent @TraceID, 188, 6, @on
exec sp_trace_setevent @TraceID, 188, 7, @on
exec sp_trace_setevent @TraceID, 188, 8, @on
exec sp_trace_setevent @TraceID, 188, 10, @on
exec sp_trace_setevent @TraceID, 188, 12, @on
exec sp_trace_setevent @TraceID, 188, 14, @on
exec sp_trace_setevent @TraceID, 188, 21, @on
exec sp_trace_setevent @TraceID, 188, 23, @on
exec sp_trace_setevent @TraceID, 188, 26, @on
exec sp_trace_setevent @TraceID, 188, 31, @on
exec sp_trace_setevent @TraceID, 188, 35, @on
exec sp_trace_setevent @TraceID, 188, 41, @on
exec sp_trace_setevent @TraceID, 188, 49, @on
exec sp_trace_setevent @TraceID, 188, 50, @on
exec sp_trace_setevent @TraceID, 188, 51, @on
exec sp_trace_setevent @TraceID, 188, 60, @on
exec sp_trace_setevent @TraceID, 188, 64, @on
exec sp_trace_setevent @TraceID, 188, 66, @on
exec sp_trace_setevent @TraceID, 187, 1, @on
exec sp_trace_setevent @TraceID, 187, 9, @on
exec sp_trace_setevent @TraceID, 187, 3, @on
exec sp_trace_setevent @TraceID, 187, 11, @on
exec sp_trace_setevent @TraceID, 187, 4, @on
exec sp_trace_setevent @TraceID, 187, 6, @on
exec sp_trace_setevent @TraceID, 187, 7, @on
exec sp_trace_setevent @TraceID, 187, 8, @on
exec sp_trace_setevent @TraceID, 187, 10, @on
exec sp_trace_setevent @TraceID, 187, 12, @on
exec sp_trace_setevent @TraceID, 187, 14, @on
exec sp_trace_setevent @TraceID, 187, 21, @on
exec sp_trace_setevent @TraceID, 187, 26, @on
exec sp_trace_setevent @TraceID, 187, 35, @on
exec sp_trace_setevent @TraceID, 187, 41, @on
exec sp_trace_setevent @TraceID, 187, 49, @on
exec sp_trace_setevent @TraceID, 187, 50, @on
exec sp_trace_setevent @TraceID, 187, 51, @on
exec sp_trace_setevent @TraceID, 187, 60, @on
exec sp_trace_setevent @TraceID, 187, 64, @on
exec sp_trace_setevent @TraceID, 187, 66, @on
exec sp_trace_setevent @TraceID, 192, 1, @on
exec sp_trace_setevent @TraceID, 192, 9, @on
exec sp_trace_setevent @TraceID, 192, 3, @on
exec sp_trace_setevent @TraceID, 192, 11, @on
exec sp_trace_setevent @TraceID, 192, 4, @on
exec sp_trace_setevent @TraceID, 192, 6, @on
exec sp_trace_setevent @TraceID, 192, 7, @on
exec sp_trace_setevent @TraceID, 192, 8, @on
exec sp_trace_setevent @TraceID, 192, 10, @on
exec sp_trace_setevent @TraceID, 192, 12, @on
exec sp_trace_setevent @TraceID, 192, 14, @on
exec sp_trace_setevent @TraceID, 192, 23, @on
exec sp_trace_setevent @TraceID, 192, 26, @on
exec sp_trace_setevent @TraceID, 192, 31, @on
exec sp_trace_setevent @TraceID, 192, 35, @on
exec sp_trace_setevent @TraceID, 192, 41, @on
exec sp_trace_setevent @TraceID, 192, 49, @on
exec sp_trace_setevent @TraceID, 192, 50, @on
exec sp_trace_setevent @TraceID, 192, 51, @on
exec sp_trace_setevent @TraceID, 192, 54, @on
exec sp_trace_setevent @TraceID, 192, 60, @on
exec sp_trace_setevent @TraceID, 192, 64, @on
exec sp_trace_setevent @TraceID, 192, 66, @on
exec sp_trace_setevent @TraceID, 191, 1, @on
exec sp_trace_setevent @TraceID, 191, 9, @on
exec sp_trace_setevent @TraceID, 191, 3, @on
exec sp_trace_setevent @TraceID, 191, 11, @on
exec sp_trace_setevent @TraceID, 191, 4, @on
exec sp_trace_setevent @TraceID, 191, 6, @on
exec sp_trace_setevent @TraceID, 191, 7, @on
exec sp_trace_setevent @TraceID, 191, 8, @on
exec sp_trace_setevent @TraceID, 191, 10, @on
exec sp_trace_setevent @TraceID, 191, 12, @on
exec sp_trace_setevent @TraceID, 191, 14, @on
exec sp_trace_setevent @TraceID, 191, 26, @on
exec sp_trace_setevent @TraceID, 191, 35, @on
exec sp_trace_setevent @TraceID, 191, 41, @on
exec sp_trace_setevent @TraceID, 191, 49, @on
exec sp_trace_setevent @TraceID, 191, 50, @on
exec sp_trace_setevent @TraceID, 191, 51, @on
exec sp_trace_setevent @TraceID, 191, 60, @on
exec sp_trace_setevent @TraceID, 191, 64, @on
exec sp_trace_setevent @TraceID, 191, 66, @on
exec sp_trace_setevent @TraceID, 54, 2, @on
exec sp_trace_setevent @TraceID, 54, 66, @on
exec sp_trace_setevent @TraceID, 54, 10, @on
exec sp_trace_setevent @TraceID, 54, 3, @on
exec sp_trace_setevent @TraceID, 54, 11, @on
exec sp_trace_setevent @TraceID, 54, 4, @on
exec sp_trace_setevent @TraceID, 54, 6, @on
exec sp_trace_setevent @TraceID, 54, 7, @on
exec sp_trace_setevent @TraceID, 54, 8, @on
exec sp_trace_setevent @TraceID, 54, 9, @on
exec sp_trace_setevent @TraceID, 54, 12, @on
exec sp_trace_setevent @TraceID, 54, 14, @on
exec sp_trace_setevent @TraceID, 54, 21, @on
exec sp_trace_setevent @TraceID, 54, 22, @on
exec sp_trace_setevent @TraceID, 54, 24, @on
exec sp_trace_setevent @TraceID, 54, 25, @on
exec sp_trace_setevent @TraceID, 54, 26, @on
exec sp_trace_setevent @TraceID, 54, 35, @on
exec sp_trace_setevent @TraceID, 54, 41, @on
exec sp_trace_setevent @TraceID, 54, 49, @on
exec sp_trace_setevent @TraceID, 54, 51, @on
exec sp_trace_setevent @TraceID, 54, 60, @on
exec sp_trace_setevent @TraceID, 54, 64, @on


-- Set the Filters
declare @intfilter int
declare @bigintfilter bigint

set @intfilter = 1
exec sp_trace_setfilter @TraceID, 3, 0, 0, @intfilter

exec sp_trace_setfilter @TraceID, 10, 0, 7, N'SQL Server Profiler - 02f85365-b6c7-4933-88db-2d11ffe8b1bf'
-- Set the trace status to start
exec sp_trace_setstatus @TraceID, 1

-- display trace id for future references
select TraceID=@TraceID
goto finish

error: 
select ErrorCode=@rc

finish: 
go
