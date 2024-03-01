-- ----------------------------------------------------------------------------
-- filename: query_sql_server_agent_jobs.sql
-- purpose : Query SQL Server Agent Jobs configurations
-- revision: 2024-03-01 18:25 - josemarsilva - 
-- remarks : 
--			- https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-max-degree-of-parallelism-server-configuration-option?view=sql-server-ver16
-- ----------------------------------------------------------------------------

SELECT
    j.name AS JobName,
    js.step_id,
    js.step_name,
    js.command,
    s.name AS ScheduleName,
    s.freq_type,
    s.freq_interval,
    s.freq_subday_type,
    s.freq_subday_interval
FROM msdb.dbo.sysjobs j
JOIN msdb.dbo.sysjobsteps js ON j.job_id = js.job_id
JOIN msdb.dbo.sysjobschedules jsch ON j.job_id = jsch.job_id
JOIN msdb.dbo.sysschedules s ON jsch.schedule_id = s.schedule_id;
