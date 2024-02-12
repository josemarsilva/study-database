-- ----------------------------------------------------------------------------
-- filename: query_dm_requests_x_session.sql
-- purpose : Query Request and Sessions on server processing now
-- revision: 2024-02-12 17:45 - josemarsilva -
-- remarks : 
--			* https://learn.microsoft.com/pt-br/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-sessions-transact-sql?view=sql-server-ver16
--			* https://learn.microsoft.com/pt-br/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-requests-transact-sql?view=sql-server-ver16
-- ----------------------------------------------------------------------------


SELECT
	TOP 100
    s.session_id,
	s.is_user_process,
	s.login_name,
	s.status,
    s.host_name,
    s.program_name,
	s.login_name,
    s.client_interface_name,
	s.cpu_time,
	s.total_elapsed_time,
	s.row_count,
	s.reads,
	s.writes,
	s.logical_reads,
	r.query_hash,
	r.query_plan_hash
FROM sys.dm_exec_requests r
INNER JOIN sys.dm_exec_sessions AS s ON r.session_id = s.session_id
WHERE 1=1
	-- Filter by ...
AND   s.host_name IS NOT NULL
AND   s.status IN ( 'sleeping', 'running' )
ORDER BY 
	-- Order by ...
	s.session_id, s.login_name, s.host_name, s.total_elapsed_time
