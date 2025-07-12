-- ----------------------------------------------------------------------------
-- filename   : gen-sqltune-report-sql-monitor.sql
-- description: Generate SQL MONITOR Tune Report
--              1. Run your query to identify SQL_ID
--              2. Identify your query
--              3. Create tuning task
--              4. Execute tuning task
--              5. Get tuning recommendations
--              * References:
--                - https://docs.oracle.com/en/database/oracle/oracle-database/19/arpls/DBMS_SQLTUNE.html
-- revision   : 
--              * 2025-05-08 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------


-- ----------------------------------------------------------------------------
-- 1. Run your query to identify SQL_ID
-- ----------------------------------------------------------------------------
SELECT
    id, name, code, since_at
FROM
    customers
WHERE
    since_at = TRUNC(SYSDATE)
;

-- ----------------------------------------------------------------------------
-- 2. Identify your query
-- ----------------------------------------------------------------------------
SELECT 
    sql_id, inst_id, sql_text
FROM
    gv$sql_monitor
WHERE
    1 = 1
    -- AND username = user
    AND upper(sql_text) like upper('%SELECT%customers%since_at%TRUNC(SYSDATE)%')
;

-- ----------------------------------------------------------------------------
-- 3. Create tuning task (required => granted the ADVISOR privilege)
-- ----------------------------------------------------------------------------
DECLARE
  l_sql_tune_task_id VARCHAR2(100);
BEGIN
  l_sql_tune_task_id := DBMS_SQLTUNE.CREATE_TUNING_TASK(
    sql_id      => '2fn2p3ph6rku6',
    scope       => 'COMPREHENSIVE',
    time_limit  => 60,
    task_name   => 'my_sql_tuning_task',
    description => 'Tuning Task for customers.since_at');
  DBMS_OUTPUT.PUT_LINE('Task Created: ' || l_sql_tune_task_id);
END;
/

-- ----------------------------------------------------------------------------
-- 4. Execute tuning task (required => granted the ADVISOR privilege)
-- ----------------------------------------------------------------------------
EXEC DBMS_SQLTUNE.EXECUTE_TUNING_TASK(task_name => 'my_sql_tuning_task');


-- ----------------------------------------------------------------------------
-- 5. Get tuning recommendations
-- ----------------------------------------------------------------------------
SELECT DBMS_SQLTUNE.REPORT_TUNING_TASK('my_sql_tuning_task') FROM dual;


-- ----------------------------------------------------------------------------
-- 6. Interpret ther Report
-- ----------------------------------------------------------------------------

-- DBA Human task


-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
