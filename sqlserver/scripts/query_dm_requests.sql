-- ----------------------------------------------------------------------------
-- filename: query_dm_requests.sql
-- purpose : Request server is processing now
-- revision: 2023-12-15 19:45 - josemarsilva -
-- remarks : https://documentation.red-gate.com/display/SM5/List+of+common+wait+types
-- ----------------------------------------------------------------------------


SELECT
    TOP 25 st.text                             ,
    r.session_id                               ,
    r.status                                   ,
    r.wait_type                                ,
    r.wait_time                                ,
    r.command                                  ,
    DatabaseName = db_name(r.database_id)      ,
    r.cpu_time                                 ,
    r.total_elapsed_time                   /1000 elapsed_time_sec,
    DATEDIFF(minute,r.start_time,getdate())/60 diff_start_time   ,
    r.percent_complete                                           ,
    f.login_time                                                 ,
    f.host_name                                                  ,
    f.program_name                                               ,
    f.login_name                                                 ,
    f.original_login_name                                        ,
    qp.*
FROM
    sys.dm_exec_requests r
CROSS APPLY
    sys.dm_exec_sql_text(r.sql_handle) st
CROSS APPLY
    sys.dm_exec_query_plan (r.plan_handle) qp
INNER JOIN
    sys.dm_exec_sessions f
ON
    f.session_id = r.session_id
WHERE
    1           =1
AND st.text NOT LIKE '%sys.dm_exec%'
    -- AND r.session_id <> @@SPID
    -- AND r.wait_type not in ('SP_SERVER_DIAGNOSTICS_SLEEP')
ORDER BY
    command