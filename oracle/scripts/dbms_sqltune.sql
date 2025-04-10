-- ----------------------------------------------------------------------------
-- filename   : dbms_sqltune.sql
-- description: 
-- revision   : 
--              * 2025-04-10 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------

--
-- Step no. 0: Pre-requisites
--

-- * Require ADVISOR PRIVILEGES

--
-- Step no. 1: Create a Tune Task
--

DECLARE
  l_task_name VARCHAR2(30);
  l_sql_text  CLOB;
BEGIN
  -- Your query here!
  l_sql_text := 'SELECT * FROM customers WHERE customer_status_id = 0';
  
  l_task_name := DBMS_SQLTUNE.CREATE_TUNING_TASK(
    sql_text    => l_sql_text,
    bind_list   => NULL,
    user_name   => 'STUDY',
    scope       => 'COMPREHENSIVE',
    time_limit  => 60,
    task_name   => 'tune_customer_status_query', -- This name identifies task
    description => 'Tuning task for customer status query'
  );
  
  DBMS_OUTPUT.PUT_LINE('Task created: ' || l_task_name);
END;
/


--
-- Step no. 2: Execute Tuning Task
--

BEGIN
  DBMS_SQLTUNE.EXECUTE_TUNING_TASK(task_name => 'tune_customer_status_query');
END;
/


--
-- Step no. 3: Run Report Tuning 
--

SET LONG 1000000 PAGESIZE 0
SELECT DBMS_SQLTUNE.REPORT_TUNING_TASK('tune_customer_status_query') AS recommendations FROM DUAL;


--
-- Step no. 4: Remove Tuning Task
--
BEGIN
  DBMS_SQLTUNE.DROP_TUNING_TASK(task_name => 'tune_customer_status_query');
END;
/


-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
