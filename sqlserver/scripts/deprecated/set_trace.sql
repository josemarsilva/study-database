-- ----------------------------------------------------------------------------
-- filename: set_trace.sql
-- purpose : Script to SET traces
-- revision: 2024-01-17 15:25 - josemarsilva - 
-- remarks : 
--          * https://learn.microsoft.com/pt-br/sql/t-sql/database-console-commands/dbcc-freeproccache-transact-sql?view=sql-server-ver16
-- ----------------------------------------------------------------------------

----------- DISABLE
select T.id as [Id],
       case T.status when 0 then N'stopped' else N'running' end as [Status],
       T.path as [Path],
       case T.is_rowset when 0 then N'false' else N'true' end as [Rowset],
       case T.is_shutdown when 0 then N'disabled' else N'enabled' end as [Shutdown option],
       T.start_time as [Start],
       T.stop_time as [Stop]
from sys.traces as T
where T.is_default <> 1;

--turn on the trace
exec sp_trace_setstatus @traceid, 1 ---start trace

--exec sp_trace_setstatus @traceid=2, @status = 0 ---stop trace, you must know the traceid to stop it
--exec sp_trace_setstatus @traceid=2, @status = 2 ---close trace you must know the traceid to delete it


-----------



/****************************************************/
/* Created by: SQL Server 2008 R2 Profiler          */
/* Date: 23/12/2016  12:02:54         */
/****************************************************/


-- Create a Queue
declare @rc int
declare @TraceID int
declare @maxfilesize bigint
set     @maxfilesize = 1024 

-- Please replace the text InsertFileNameHere, with an appropriate
-- filename prefixed by a path, e.g., c:\MyFolder\MyTrace. The .trc extension
-- will be appended to the filename automatically. If you are writing from
-- remote server to local drive, please use UNC path and make sure server has
-- write access to your network share

exec @rc = sp_trace_create @TraceID output, 0, N'C:\temp\trace1105', @maxfilesize, NULL 
if (@rc != 0) goto error

-- Client side File and Table cannot be scripted

-- Set the events
declare @on bit
set @on = 1
exec sp_trace_setevent @TraceID, 10, 15, @on
exec sp_trace_setevent @TraceID, 10, 16, @on
exec sp_trace_setevent @TraceID, 10, 48, @on
exec sp_trace_setevent @TraceID, 10, 1, @on
exec sp_trace_setevent @TraceID, 10, 17, @on
exec sp_trace_setevent @TraceID, 10, 18, @on
exec sp_trace_setevent @TraceID, 10, 3, @on
exec sp_trace_setevent @TraceID, 10, 11, @on
exec sp_trace_setevent @TraceID, 10, 35, @on
exec sp_trace_setevent @TraceID, 10, 12, @on
exec sp_trace_setevent @TraceID, 10, 13, @on
exec sp_trace_setevent @TraceID, 10, 14, @on
exec sp_trace_setevent @TraceID, 45, 16, @on
exec sp_trace_setevent @TraceID, 45, 48, @on
exec sp_trace_setevent @TraceID, 45, 1, @on
exec sp_trace_setevent @TraceID, 45, 17, @on
exec sp_trace_setevent @TraceID, 45, 18, @on
exec sp_trace_setevent @TraceID, 45, 3, @on
exec sp_trace_setevent @TraceID, 45, 11, @on
exec sp_trace_setevent @TraceID, 45, 35, @on
exec sp_trace_setevent @TraceID, 45, 12, @on
exec sp_trace_setevent @TraceID, 45, 28, @on
exec sp_trace_setevent @TraceID, 45, 13, @on
exec sp_trace_setevent @TraceID, 45, 14, @on
exec sp_trace_setevent @TraceID, 45, 15, @on
exec sp_trace_setevent @TraceID, 12, 15, @on
exec sp_trace_setevent @TraceID, 12, 16, @on
exec sp_trace_setevent @TraceID, 12, 48, @on
exec sp_trace_setevent @TraceID, 12, 1, @on
exec sp_trace_setevent @TraceID, 12, 17, @on
exec sp_trace_setevent @TraceID, 12, 14, @on
exec sp_trace_setevent @TraceID, 12, 18, @on
exec sp_trace_setevent @TraceID, 12, 3, @on
exec sp_trace_setevent @TraceID, 12, 11, @on
exec sp_trace_setevent @TraceID, 12, 35, @on
exec sp_trace_setevent @TraceID, 12, 12, @on
exec sp_trace_setevent @TraceID, 12, 13, @on


-- Set the Filters
declare @intfilter int
declare @bigintfilter bigint

set @bigintfilter = 50000 -- 50ms
exec sp_trace_setfilter @TraceID, 13, 0, 4, @bigintfilter

exec sp_trace_setfilter @TraceID, 35, 0, 6, N'WISEIT_PROD'
-- Set the trace status to start
exec sp_trace_setstatus @TraceID, 1

-- display trace id for future references
select TraceID=@TraceID
goto finish

error: 
select ErrorCode=@rc

finish: 
go
