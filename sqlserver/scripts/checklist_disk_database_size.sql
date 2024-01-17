-- ----------------------------------------------------------------------------
-- filename: checklist_disk_database_size.sql
-- purpose : Script to Check the Disk and Database Size
-- revision: 2024-01-11 19:30 - josemarsilva - 
-- remarks : 
--			* https://www.mssqltips.com/sqlservertip/1936/sql-server-database-migration-checklist/
-- ----------------------------------------------------------------------------

-- Procedure to check disc space
exec master..xp_fixeddrives
-- To Check database size
exec sp_helpdb [dbName]
or
use [dbName]
select str(sum(convert(dec(17,2),size)) / 128,10,2)  + 'MB'
from dbo.sysfiles
GO