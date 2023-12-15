-- ----------------------------------------------------------------------------
-- filename: query_dm_requests.sql
-- purpose : Request server is processing now
-- revision: 2023-12-15 19:45 - josemarsilva -
-- remarks : https://documentation.red-gate.com/display/SM5/List+of+common+wait+types
-- ----------------------------------------------------------------------------


SELECT
    GETDATE()    as date_time          ,
    a.session_id AS blocked_session_id ,
    b.session_id AS blocking_session_id,
    c.text       AS blocking_text      ,
    e.wait_type  AS blocking_resource  ,
    e.wait_duration_ms                 ,
    d.text AS blocked_text             ,
    a.cpu_time                         ,
    f.login_time                       ,
    f.host_name                        ,
    f.program_name                     ,
    f.login_name                       ,
    f.original_login_name
FROM
    sys.dm_exec_requests a
INNER JOIN
    sys.dm_exec_requests b
ON
    a.blocking_session_id = b.session_id
CROSS APPLY
    sys.Dm_exec_sql_text(b.sql_handle) c
CROSS APPLY
    sys.Dm_exec_sql_text(a.sql_handle) d
INNER JOIN
    sys.dm_os_waiting_tasks e
ON
    e.session_id = b.session_id
INNER join
    sys.dm_exec_sessions f
ON
    f.session_id = b.session_id

