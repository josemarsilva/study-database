-- ----------------------------------------------------------------------------
-- filename: checklist_orphan_users
-- purpose : Script to List Orphan Users
-- revision: 2024-01-11 19:30 - josemarsilva - 
-- remarks : 
--			* https://www.mssqltips.com/sqlservertip/1936/sql-server-database-migration-checklist/
-- ----------------------------------------------------------------------------

sp_change_users_login 'report'
GO
