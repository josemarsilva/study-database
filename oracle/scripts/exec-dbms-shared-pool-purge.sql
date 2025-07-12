-- ----------------------------------------------------------------------------
-- filename   : exec-dbms-shared-pool-purge.sql
-- description: Force dirty cache SQLPLAN for a SQLID
--              * References:
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/arpls/DBMS_SHARED_POOL.html
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/dynamic-performance-views.html
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/static-data-dictionary-views.html
-- revision   : 
--              * 2025-07-11 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------


-- ----------------------------------------------------------------------------
-- 1. Get address and hashvalue for execution
-- ----------------------------------------------------------------------------
SELECT
    ADDRESS, HASH_VALUE, SQL_ID, SQL_TEXT
FROM
    GV$SQL
WHERE
    SQL_ID = 'XXXXXXXXXXXX'
;


-- ----------------------------------------------------------------------------
-- 2. Execution
-- ----------------------------------------------------------------------------

EXEC SYS.DBMS_SHARED_POOL.PURGE('0000000085BD59BD70,422871542', 'C' /* CURSOR */ )

-- ----------------------------------------------------------------------------
-- 
-- ----------------------------------------------------------------------------
