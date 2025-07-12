-- ----------------------------------------------------------------------------
-- filename   : query-v$mystat-join-v$statname.sql
-- description: My Session dynamic statistics
--              * References:
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/V-MYSTAT.html
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
