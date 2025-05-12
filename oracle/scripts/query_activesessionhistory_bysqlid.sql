-- ----------------------------------------------------------------------------
-- filename   : query_activesessionhistory_bysqlid.sql
-- description: Session-Level Performance by SQL ID
-- revision   : 
--              * 2025-05-12 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
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
--
-- ----------------------------------------------------------------------------
