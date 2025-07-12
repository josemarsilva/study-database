-- ----------------------------------------------------------------------------
-- filename   : alter-session-set-events.sql
-- description: Session dynamic statistics
--              * References:
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/dynamic-performance-views.html
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/static-data-dictionary-views.html
-- revision   : 
--              * 2025-04-10 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------

-- Before
ALTER SESSION SET EVENTS '10053 trace name context forever, level 1';

-- Run your query here!

-- After
ALTER SESSION SET EVENTS '10053 trace name context off';


-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
