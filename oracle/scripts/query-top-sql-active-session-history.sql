-- ----------------------------------------------------------------------------
-- filename   : query-top-sql-active-session-history.sql
-- description: Top SQL by Active Session History
--              1. Active (v$session)
--              2. Top SQL by Active Session History (v$active_session_history samples Breakdown)
--              3. Top Active Sessions (v$active_session_history User/Program Breakdown)
--              * Important:
--                - gv$session: information about what a session is doing any given time, status can be 'ACTIVE', 'INACTIVE'
--                - gv$active_session_history: every 1 sec interval history what are ACTIVE session doing
--                - dba_hist_active_session_history: last 60 min, 1 in 10 sec what are ACTIVE session doing
--                - gv$session.last_call_et seconds executions
--                - https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/V-SESSION.html
--              * References:
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/V-ACTIVE_SESSION_HISTORY.html
-- revision   : 
--              * 2025-05-13 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- 1. Top SQL by Active Session (v$session)
-- ----------------------------------------------------------------------------
SELECT
    -- gv$session - basic
    s.inst_id, s.SADDR, s.AUDSID, s.PADDR, s.USER#, s.COMMAND, s.OWNERID, s.TADDR, s.SERVER,
    s.SCHEMA#, s.SCHEMANAME, s.OSUSER, s.PROCESS, s.MACHINE, s.PORT, s.TERMINAL, s.PROGRAM, s.TYPE, s.MODULE, s.MODULE_HASH, s.ACTION, s.ACTION_HASH, s.CLIENT_INFO,
    s.SID, s.SERIAL#, s.USERNAME, s.LOCKWAIT, s.STATUS,
    -- gv$sqlarea - basic
    s.SQL_ID, 
    sql.sql_text, /* sql.sql_fulltext, */
    sql.plan_hash_value, sql.bind_data, sql.full_plan_hash_value,
    sql.fetches, sql.executions, sql.px_servers_executions,
    sql.cpu_time, sql.elapsed_time, sql.application_wait_time, sql.concurrency_wait_time, sql.cluster_wait_time, sql.user_io_wait_time, sql.plsql_exec_time, sql.java_exec_time,
    sql.rows_processed, sql.parse_calls, sql.disk_reads, sql.direct_reads, sql.direct_writes, sql.buffer_gets, sql.physical_read_requests, sql.physical_read_bytes, sql.physical_write_requests, sql.physical_write_bytes, 
    -- gv$session
    s.SQL_ADDRESS, s.SQL_HASH_VALUE, s.SQL_CHILD_NUMBER, s.PREV_SQL_ADDR, s.PREV_HASH_VALUE, s.PREV_SQL_ID, s.PREV_CHILD_NUMBER, s.PREV_EXEC_START, s.PREV_EXEC_ID, s.PLSQL_ENTRY_OBJECT_ID, s.PLSQL_ENTRY_SUBPROGRAM_ID, s.PLSQL_OBJECT_ID, s.PLSQL_SUBPROGRAM_ID,
    TO_CHAR(s.SQL_EXEC_START, 'YYYY-MM-DD HH24:MI:SS') AS SQL_EXEC_START, s.SQL_EXEC_ID, s.FIXED_TABLE_SEQUENCE, s.ROW_WAIT_OBJ#, s.ROW_WAIT_FILE#, s.ROW_WAIT_BLOCK#, s.ROW_WAIT_ROW#, s.TOP_LEVEL_CALL#,
    TO_CHAR(s.LOGON_TIME, 'YYYY-MM-DD HH24:MI:SS') AS LOGON_TIME, s.LAST_CALL_ET,
    s.PDML_ENABLED, s.FAILOVER_TYPE, s.FAILOVER_METHOD, s.FAILED_OVER, s.RESOURCE_CONSUMER_GROUP, s.PDML_STATUS, s.PDDL_STATUS, s.PQ_STATUS, s.CURRENT_QUEUE_DURATION, s.CLIENT_IDENTIFIER,
    s.BLOCKING_SESSION_STATUS, s.BLOCKING_INSTANCE, s.BLOCKING_SESSION, s.FINAL_BLOCKING_SESSION_STATUS, s.FINAL_BLOCKING_INSTANCE, s.FINAL_BLOCKING_SESSION,
    s.SEQ#, s.EVENT#, s.EVENT, s.P1TEXT, s.P1, s.P1RAW, s.P2TEXT, s.P2, s.P2RAW, s.P3TEXT, s.P3, s.P3RAW,
    s.WAIT_CLASS_ID, s.WAIT_CLASS#, s.WAIT_CLASS, s.WAIT_TIME, s.SECONDS_IN_WAIT, s.STATE, s.WAIT_TIME_MICRO, s.TIME_REMAINING_MICRO, s.TOTAL_TIME_WAITED_MICRO, s.HEUR_TIME_WAITED_MICRO, s.TIME_SINCE_LAST_WAIT_MICRO,
    s.SERVICE_NAME, s.SQL_TRACE, s.SQL_TRACE_WAITS, s.SQL_TRACE_BINDS, s.SQL_TRACE_PLAN_STATS, s.SESSION_EDITION_ID, s.CREATOR_ADDR, s.CREATOR_SERIAL#, s.ECID, s.SQL_TRANSLATION_PROFILE_ID, s.PGA_TUNABLE_MEM, s.SHARD_DDL_STATUS, s.CON_ID, s.EXTERNAL_NAME, s.PLSQL_DEBUGGER_CONNECTED,
    -- gv$sqlarea
    sql.sharable_mem, sql.persistent_mem, sql.sorts, sql.version_count, sql.loaded_versions, sql.open_versions, sql.users_opening, sql.end_of_fetch_count, sql.users_executing, sql.loads, sql.invalidations,
    sql.command_type, sql.optimizer_mode, sql.optimizer_cost, sql.optimizer_env, sql.optimizer_env_hash_value, sql.parsing_user_id, sql.parsing_schema_id, sql.parsing_schema_name, sql.kept_versions, sql.address, sql.hash_value, sql.old_hash_value, sql.module, sql.module_hash, sql.action, sql.action_hash, sql.serializable_aborts, sql.outline_category, sql.outline_sid, sql.last_active_child_address, sql.remote, sql.object_status, sql.literal_hash_value, sql.runtime_mem,
    sql.first_load_time, sql.last_load_time, sql.last_active_time,
    sql.is_obsolete, sql.is_bind_sensitive, sql.is_bind_aware, sql.child_latch, sql.sql_profile, sql.sql_patch, sql.sql_plan_baseline, sql.program_id, sql.program_line#, sql.exact_matching_signature, sql.force_matching_signature, sql.typecheck_mem, sql.io_cell_offload_eligible_bytes, sql.io_interconnect_bytes, sql.optimized_phy_read_requests, sql.locked_total, sql.pinned_total, sql.io_cell_uncompressed_bytes, sql.io_cell_offload_returned_bytes, sql.con_id, sql.is_reoptimizable, sql.is_resolved_adaptive_plan, sql.result_cache_executions
FROM
  gv$session s
LEFT OUTER JOIN gv$sqlarea sql ON sql.sql_id = s.sql_id AND sql.inst_id = s.inst_id
WHERE 1=1
  AND s.username IS NOT NULL -- not background process
  AND s.LAST_CALL_ET > 120 -- seconds
;


-- ----------------------------------------------------------------------------
-- 2. Top SQL by Active Session History (v$active_session_history samples Breakdown)
-- ----------------------------------------------------------------------------
SELECT sql_id,
       COUNT(*) AS samples,
       ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 1) AS pct_total,
       MIN(sample_time) AS first_seen,
       MAX(sample_time) AS last_seen
FROM v$active_session_history
WHERE sample_time > SYSDATE - 1/24 -- Last 1 hour
  AND session_state = 'ON CPU' -- or remove this filter for all states
GROUP BY sql_id
ORDER BY samples DESC FETCH FIRST 10 ROWS ONLY
;


-- ----------------------------------------------------------------------------
-- 3. Top Active Sessions (v$active_session_history User/Program Breakdown)
-- ----------------------------------------------------------------------------
SELECT session_id,
       session_serial#,
       user_id,
       program,
       COUNT(*) AS samples
FROM v$active_session_history
WHERE sample_time > SYSDATE - 1/24
GROUP BY session_id, session_serial#, user_id, program
ORDER BY samples DESC FETCH FIRST 30 ROWS ONLY
;


-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
