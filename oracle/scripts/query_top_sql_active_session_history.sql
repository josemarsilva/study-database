-- ----------------------------------------------------------------------------
-- filename   : query_top_sql_active_session_history.sql
-- description: Top SQL by Active Session History
--              1. Top SQL by Active Session History
--              2. Top Active Sessions (User/Program Breakdown)
-- revision   : 
--              * 2025-05-12 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------


-- ----------------------------------------------------------------------------
-- 1. Top SQL by Active Session History
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
-- 2. Top Active Sessions (User/Program Breakdown)
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
