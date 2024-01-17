-- ----------------------------------------------------------------------------
-- filename: query_database_objects
-- purpose : Script to query database object like Trigger, Functions, Procedures, etc
-- revision: 2024-01-11 19:30 - josemarsilva - 
-- remarks : 
--			* https://www.mssqltips.com/sqlservertip/1936/sql-server-database-migration-checklist/
-- ----------------------------------------------------------------------------

SELECT name, type_desc, modify_date
FROM sys.objects
WHERE 1=1
AND   type IN ('TR', 'P', 'FN') -- TR: Trigger, P: Procedure, FN: Function
