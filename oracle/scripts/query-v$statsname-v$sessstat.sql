-- ----------------------------------------------------------------------------
-- filename   : query-v$statsname-v$sessstat.sql
-- description: Session dynamic statistics
--              * References:
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/V-SESSTAT.html
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/V-STATNAME.html
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
