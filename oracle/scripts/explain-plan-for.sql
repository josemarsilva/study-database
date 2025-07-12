-- ----------------------------------------------------------------------------
-- filename   : explain-plan-for.sql
-- description: Execution Plan and Statistics metrics
--              * References:
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/arpls/DBMS_XPLAN.html
-- revision   : 
--              * 2025-04-07 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------

--
-- Option no. 1: SET AUTOT ... EXPLAIN PLAN FOR ... 
--

SET AUTOT TRACE 
EXPLAIN PLAN FOR
  SELECT * FROM customers WHERE id = 100000;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
--SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_AWR('sql_id', NULL, NULL, 'ADVANCED'));
--SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR('sql_id', NULL, 'ADVANCED'));

SET AUTOT OFF

--
-- Option no. 2: On SQLDeveloper :: "Autotrace ... (F6)"
--

SELECT * FROM customers WHERE id = 100000;


--
-- Option no. 3: On SQL*Plus
--

-- Turn AUTOTRACE TRACEONLY ON
set autot trace
-- Turn AUTOTRACE TRACEONLY ON with option EXPLAIN STATISTICS
set autot trace exp stat 
-- Turn AUTOTRACE OFF
set autot trace OFF


-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
