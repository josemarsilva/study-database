-- ----------------------------------------------------------------------------
-- filename: checklist_disk_database_size.sql
-- purpose : Script to Check the Disk and Database Size
-- revision: 2024-01-11 19:30 - josemarsilva - 
-- remarks : 
--			* https://www.mssqltips.com/sqlservertip/1936/sql-server-database-migration-checklist/
-- ----------------------------------------------------------------------------

-- Procedure to check disc space
EXEC master..xp_fixeddrives
-- To Check database size
EXEC sp_helpdb [dbName]
-- or
USE [dbName]
SELECT STR(SUM(CONVERT(DEC(17,2),SIZE)) / 128,10,2)  + 'MB'
FROM dbo.sysfiles
GO