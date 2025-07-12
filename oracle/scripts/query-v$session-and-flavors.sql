-- ----------------------------------------------------------------------------
-- filename   : query-v$session-and-flavors.sql
-- description: Session-Level Performance by SQL ID
--              1. gv$session: information about what a session is doing any given time, status can be 'ACTIVE', 'INACTIVE'
--              2. gv$active_session_history: every 1 sec interval history what are ACTIVE session doing
--              3. dba_hist_active_session_history: last 60 min, 1 in 10 sec what are ACTIVE session doing
--              * References:
--                  - https://www.youtube.com/watch?v=VdcHH2V1imo
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/V-SESSION.html
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/V-SESSION_BLOCKERS.html
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/V-SESSION_CONNECT_INFO.html
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/V-SESSION_EVENT.html
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/V-SESSION_LONGOPS.html
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/V-SESSION_WAIT.html
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/V-SESSION_WAIT_CLASS.html
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/V-SESSION_WAIT_HISTORY.html
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/V-SESSIONS_COUNT.html
-- revision   : 
--              * 2025-05-12 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------


-- ----------------------------------------------------------------------------
-- 1. v$session
-- ----------------------------------------------------------------------------
SELECT 
        *
FROM
        gv$session s
WHERE
        1=1
        AND    s.sid = 42951
        AND    s.serial# = 9343
        AND    s.user# = 197
        AND    s.username = 'STUDY'
        AND    s.status = 'INACTIVE'
        AND    s.machine = 'LP2317'
        AND    s.program = 'SQL Developer'
        AND    s.sql_id = '2ygnt73ck3jk8'
        AND    s.blocking_session IS NULL
        AND    s.wait_class = 'Idle'
        AND    s.seconds_in_wait > 300 -- 5 min
;


-- ----------------------------------------------------------------------------
-- 2. gv$active_session_history
-- ----------------------------------------------------------------------------
SELECT 
    ash.sql_id,
    sql.sql_text,
    COUNT(*) AS db_time,
    ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 2) AS pct_db_time,
    COUNT(DISTINCT ash.session_id||':'||ash.session_serial#) AS sessions
FROM 
    gv$active_session_history ash
    LEFT OUTER JOIN v$sql sql ON (ash.sql_id = sql.sql_id)
WHERE 
    ash.sample_time BETWEEN SYSDATE - interval '30' minute AND SYSDATE
    AND ash.sql_id IS NOT NULL
GROUP BY 
    ash.sql_id, sql.sql_text
ORDER BY 
    db_time DESC
;


-- ----------------------------------------------------------------------------
-- 3. v$active_session_history
-- ----------------------------------------------------------------------------
SELECT
    *
FROM
    gv$active_session_history sh
WHERE
        1=1
        AND    sh.session_id = 44365
        AND    sh.session_serial# = 99
;



-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
