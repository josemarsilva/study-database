-- ----------------------------------------------------------------------------
-- filename   : alter-session-disable-parallel.sql.sql
-- description: Session dynamic statistics
--              * References:
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/dynamic-performance-views.html
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/static-data-dictionary-views.html
-- revision   : 
--              * 2025-04-11 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------


DECLARE
BEGIN
    -- Desabilitar paralelismo na sessão
    EXECUTE IMMEDIATE 'ALTER SESSION DISABLE PARALLEL DML';
    EXECUTE IMMEDIATE 'ALTER SESSION DISABLE PARALLEL QUERY';
END;
/


-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
