-- ----------------------------------------------------------------------------
-- filename: query_version_cumulative_update.sql
-- purpose : Query SQL Server database version installed and cumulative updates
-- revision: 2024-02-27 18:30 - josemarsilva - 
-- remarks : 
--			* https://learn.microsoft.com/pt-br/sql/t-sql/functions/version-transact-sql-configuration-functions?view=sql-server-ver16
-- ----------------------------------------------------------------------------

SELECT @@SERVERNAME AS servername, @@SERVICENAME AS servicename, @@VERSION AS version
