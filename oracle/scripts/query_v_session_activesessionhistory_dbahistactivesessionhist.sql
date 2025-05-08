-- ----------------------------------------------------------------------------
-- filename   : query_v_session_activesessionhistory_dbahistactivesessionhist.sql
-- description: Session (looking for a session)
--              1. v$session: information about what a session is doing any given time, status can be 'ACTIVE', 'INACTIVE'
--              2. v$active_session_history: every 1 sec interval history what are ACTIVE session doing
--              3. dba_hist_active_session_history: last 60 min, 1 in 10 sec what are ACTIVE session doing
--              References:
--              - https://www.youtube.com/watch?v=VdcHH2V1imo
-- revision   : 
--              * 2025-05-08 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- 1. v$session
-- ----------------------------------------------------------------------------
SELECT 
        *
FROM
        v$session s
WHERE
        1=1
        AND    s.sid = 42951
        AND    s.serial# = 9343
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
-- 2. v$active_session_history
-- ----------------------------------------------------------------------------
SELECT
    *
FROM
    v$active_session_history sh
WHERE
        1=1
        AND    sh.sid = 42951
        AND    sh.serial# = 9343
;



-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
