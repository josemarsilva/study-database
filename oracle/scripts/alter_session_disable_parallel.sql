-- ----------------------------------------------------------------------------
-- filename   : alter_session_set_events.sql
-- description: Session dynamic statistics
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
