-- ----------------------------------------------------------------------------
-- filename   : query_session_module_action_client_info.sql
-- description: Query identify session
--              * References:
--                  - https://oracle-base.com/articles/8i/dbms_application_info
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/arpls/DBMS_APPLICATION_INFO.html
-- revision   : 
--              * 2025-07-07 - josemarsilva - 
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Step#1: get parameters address, hash_value
-- ----------------------------------------------------------------------------

SELECT 
    inst_id, 
    sid,
    serial#,
    username,
    osuser,
    module,
    action,
    client_info,
    program, 
    machine
FROM gv$session
WHERE SID = SYS_CONTEXT('USERENV', 'SID');



-- ----------------------------------------------------------------------------
-- Step#2: DBMS_APPLICATION_INFO
-- ----------------------------------------------------------------------------

EXEC DBMS_APPLICATION_INFO.set_module(module_name => 'add_order', action_name => 'insert into orders');

EXEC DBMS_APPLICATION_INFO.set_action(action_name => 'insert into order_lines');

