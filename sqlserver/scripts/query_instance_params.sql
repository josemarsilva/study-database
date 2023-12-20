-- ----------------------------------------------------------------------------
-- filename: query_intance_params.sql
-- purpose : Query SQL Server instance params
-- revision: 2023-12-20 14:45 - josemarsilva - 
-- remarks : 
--			* https://www.sqlshack.com/execution-plans-in-sql-server/
--          * https://learn.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-configure-transact-sql?view=sql-server-ver16
-- ----------------------------------------------------------------------------

SELECT * 
FROM   SYS.SYSCONFIGURES 
WHERE  1=1
--AND    comment LIKE '%degree%'
ORDER  BY config
