-- ----------------------------------------------------------------------------
-- filename: checklist_database_properties
-- purpose : Script to Check Database Properties
-- revision: 2024-01-11 19:30 - josemarsilva - 
-- remarks : 
--			* https://www.mssqltips.com/sqlservertip/1936/sql-server-database-migration-checklist/
-- ----------------------------------------------------------------------------

SELECT 
	sysDB.database_id,
	sysDB.Name as 'Database Name',
	syslogin.Name as 'DB Owner',
	sysDB.state_desc,
	sysDB.recovery_model_desc,
	sysDB.collation_name, 
	sysDB.user_access_desc,
	sysDB.compatibility_level, 
	sysDB.is_read_only,
	sysDB.is_auto_close_on,
	sysDB.is_auto_shrink_on,
	sysDB.is_auto_create_stats_on,
	sysDB.is_auto_update_stats_on,
	sysDB.is_fulltext_enabled,
	sysDB.is_trustworthy_on
FROM sys.databases sysDB
INNER JOIN sys.syslogins syslogin ON sysDB.owner_sid = syslogin.sid