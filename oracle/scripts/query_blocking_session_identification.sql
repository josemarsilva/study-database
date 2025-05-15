-- ----------------------------------------------------------------------------
-- filename   : query_blocking_session_identification.sql
-- description: Blocking Sessions Identification
--              1. Blocker and Blockeds by active session history
--              2. DBA blockers view
--              Important:
--                - https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/V-SESSION_BLOCKERS.html
-- revision   : 
--              * 2025-05-12 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------


-- ----------------------------------------------------------------------------
-- 1. Blocker and Blockeds by active session history
-- ----------------------------------------------------------------------------
SELECT 
    blocked.sample_time,
    blocked.session_id AS blocked_session,
    blocked.sql_id AS blocked_sql_id,
    blocker.session_id AS blocking_session,
    blocker.sql_id AS blocking_sql_id,
    blocked.event AS wait_event
FROM 
    gv$active_session_history blocked
    JOIN gv$active_session_history blocker ON (blocked.blocking_session = blocker.session_id
                                         AND blocked.blocking_inst_id = blocker.inst_id)
WHERE 
    blocked.sample_time BETWEEN SYSDATE - interval '1' hour AND SYSDATE
    AND blocked.blocking_session IS NOT NULL
ORDER BY 
    blocked.sample_time
;


-- ----------------------------------------------------------------------------
-- 2. DBA blockers view
-- ----------------------------------------------------------------------------
SELECT *
FROM   dba_blockers
;



-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
