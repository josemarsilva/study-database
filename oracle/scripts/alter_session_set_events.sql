-- ----------------------------------------------------------------------------
-- filename   : alter_session_set_events.sql
-- description: Session dynamic statistics
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
