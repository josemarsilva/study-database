-- ----------------------------------------------------------------------------
-- filename   : query_v_mystat_statname.sql
-- description: My Session dynamic statistics
-- revision   : 
--              * 2025-04-10 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------

SELECT 
    ms.sid, ms.con_id, sn.name, sn.class, ms.value
FROM
    v$mystat ms, 
    v$statname sn 
WHERE
    sn.name = 'consistent gets' 
    AND sn.statistic# = ms.statistic#
ORDER BY ms.sid, ms.con_id, sn.name ;

-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
