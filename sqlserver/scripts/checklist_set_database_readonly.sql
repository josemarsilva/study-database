-- ----------------------------------------------------------------------------
-- filename: checklist_set_database_readonly
-- purpose : Script to make the database readonly
-- revision: 2024-01-11 19:30 - josemarsilva - 
-- remarks : 
--			* https://www.mssqltips.com/sqlservertip/1936/sql-server-database-migration-checklist/
-- ----------------------------------------------------------------------------

-- Script to make the database readonly
USE [master]
GO
ALTER DATABASE [DBName] SET  READ_ONLY WITH NO_WAIT
GO
ALTER DATABASE [DBName] SET  READ_ONLY 
GO
