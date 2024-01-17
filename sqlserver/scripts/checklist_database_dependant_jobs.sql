-- ----------------------------------------------------------------------------
-- filename: checklist_database_dependant_jobs
-- purpose : Script to List Database Dependent Jobs
-- revision: 2024-01-11 19:30 - josemarsilva - 
-- remarks : 
--			* https://www.mssqltips.com/sqlservertip/1936/sql-server-database-migration-checklist/
-- ----------------------------------------------------------------------------

select 
 distinct 
 name,
 database_name
from sysjobs sj
INNER JOIN sysjobsteps sjt on sj.job_id = sjt.job_id
