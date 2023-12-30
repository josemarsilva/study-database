-- ----------------------------------------------------------------------------
-- filename: howto_pintable.sql
-- purpose : How to pin table in memory to prevent flush (deprecated > 2022)
-- revision: 2023-12-29 10:45 - josemarsilva@inmetrics.com.br - 
-- remarks : 
--			* https://www.mssqltips.com/sqlservertip/1317/keeping-data-available-in-the-sql-server-data-cache-with-pintable/
--			* https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/server-memory-server-configuration-options?view=sql-server-ver16
--			* https://learn.microsoft.com/en-us/sql/relational-databases/performance-monitor/sql-server-deprecated-features-object?view=sql-server-ver16
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