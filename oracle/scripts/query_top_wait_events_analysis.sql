-- ----------------------------------------------------------------------------
-- filename   : query_top_wait_events_analysis.sql
-- description: Top Wait Events Analysis - Help to identify dominant wait events (e.g., I/O, locks, latch contention).
--              * Important:
--                - v$session: information about what a session is doing any given time, status can be 'ACTIVE', 'INACTIVE'
--                - v$active_session_history: every 1 sec interval history what are ACTIVE session doing
--                - dba_hist_active_session_history: last 60 min, 1 in 10 sec what are ACTIVE session doing
--              References:
--              - https://www.youtube.com/watch?v=VdcHH2V1imo
-- revision   : 
--              * 2025-05-12 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------


SELECT 
    event, 
    COUNT(*) AS waits,
    ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 2) AS pct,
    ROUND(SUM(TIME_WAITED) / 1000000, 2) AS time_waited_secs
FROM 
    gv$active_session_history
WHERE
    1=1
    AND sample_time BETWEEN SYSDATE - interval '1' hour AND SYSDATE
    AND session_state = 'WAITING'
GROUP BY 
    event
ORDER BY 
    waits DESC
;


-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
