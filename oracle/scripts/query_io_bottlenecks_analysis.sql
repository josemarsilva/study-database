-- ----------------------------------------------------------------------------
-- filename   : query_io_bottlenecks_analysis.sql
-- description: I/O bottlenecks analysis
--              1. I/O Bottleneck Analysis
--              2. Helps find hot tables or indexes contributing to I/O waits.
-- revision   : 
--              * 2025-05-12 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------


-- ----------------------------------------------------------------------------
--  1. I/O Bottleneck Analysis
-- ----------------------------------------------------------------------------
SELECT 
    current_obj#, 
    o.object_name, 
    o.object_type,
    COUNT(*) AS io_operations
FROM 
    gv$active_session_history ash
    JOIN dba_objects o ON ash.current_obj# = o.object_id
WHERE 
    sample_time BETWEEN SYSDATE - interval '1' hour AND SYSDATE
    AND event LIKE 'db file%'
GROUP BY 
    current_obj#, o.object_name, o.object_type
ORDER BY 
    io_operations DESC
;


-- ----------------------------------------------------------------------------
-- 2. Helps find hot tables or indexes contributing to I/O waits.
-- ----------------------------------------------------------------------------
SELECT o.owner, o.object_name, o.object_type,
       COUNT(*) AS samples
FROM v$active_session_history ash
JOIN dba_objects o ON ash.current_obj# = o.object_id
WHERE ash.sample_time > SYSDATE - 1/24
  AND ash.session_state = 'WAITING'
  AND ash.event LIKE 'db file%'
GROUP BY o.owner, o.object_name, o.object_type
ORDER BY samples DESC
;


-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
