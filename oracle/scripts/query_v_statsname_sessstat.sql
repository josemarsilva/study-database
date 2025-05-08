-- ----------------------------------------------------------------------------
-- filename   : query_v_statsname_sessstat.sql
-- description: Session dynamic statistics
-- revision   : 
--              * 2025-04-10 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------

SELECT n.name, s.value
FROM   v$statname n, v$sesstat s
WHERE  n.statistic# = s.statistic#
AND    s.sid = SYS_CONTEXT('USERENV','SID')
AND    n.name LIKE '%table scan%';

-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
