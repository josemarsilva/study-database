-- ----------------------------------------------------------------------------
-- filename: query_triggers.sql
-- purpose : Script to query database triggers
-- revision: 2024-01-11 19:30 - josemarsilva - 
-- remarks : 
--			* https://www.mssqltips.com/sqlservertip/1936/sql-server-database-migration-checklist/
-- ----------------------------------------------------------------------------

SELECT
    t.name AS TriggerName,
    o.name AS TableName,
    CASE 
        WHEN OBJECTPROPERTY(t.object_id, 'ExecIsUpdateTrigger') = 1 THEN 'UPDATE'
        WHEN OBJECTPROPERTY(t.object_id, 'ExecIsDeleteTrigger') = 1 THEN 'DELETE'
        WHEN OBJECTPROPERTY(t.object_id, 'ExecIsInsertTrigger') = 1 THEN 'INSERT'
        ELSE 'UNKNOWN'
    END AS TriggerEvent
FROM
    sys.triggers t
JOIN
    sys.objects o ON t.parent_id = o.object_id
