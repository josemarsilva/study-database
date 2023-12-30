-- ----------------------------------------------------------------------------
-- filename: query_sys_db_config.sql
-- purpose : Query Database instance scope configurations
-- revision: 2023-12-29 10:25 - josemarsilva@inmetrics.com.br - 
-- remarks : 
--			- https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-ver16
--			- https://www.sqlshack.com/configure-the-max-degree-of-parallelism-maxdop-in-azure-sql-database/
-- ----------------------------------------------------------------------------

--
-- Database Instance Scope configurations
--
SELECT 
	id, name, value, value_for_secondary, is_value_default
FROM
	sys.database_scoped_configurations 
WHERE 
	1=1
-- AND	[name] = 'MAXDOP';


--
-- Database System configurations
--
SELECT 
	name, value, minimum, maximum, value_in_use , description
FROM 
	sys.configurations
WHERE 
	1=1
-- AND name = 'cost threshold for parallelism'