-- ----------------------------------------------------------------------------
-- filename: query_dm_top_sql.sql
-- purpose : TOP SQL with PLAN
-- revision: 2023-12-26 13:43 - josemarsilva - sql_handle sem apostrofo
-- remarks : https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-query-stats-transact-sql?view=sql-server-ver16
-- ----------------------------------------------------------------------------

SELECT
	TOP 25
	sql_handle,
	(
		SELECT
			SUBSTRING(text, statement_start_offset/2 + 1, (
					CASE
					WHEN
							statement_end_offset = -1
					THEN
							LEN(CONVERT(nvarchar(MAX),text)) * 2
					ELSE
							statement_end_offset
					END - statement_start_offset)/2)
		FROM
			sys.dm_exec_sql_text(sql_handle)
	) AS query_text,
	execution_count,
	(total_worker_time/execution_count) AS avg_worker_time,
	(total_logical_reads/execution_count) AS avg_logical_reads,
	(total_logical_writes/execution_count) AS avg_logical_writes,
	(total_physical_reads/execution_count) AS avg_phys_reads,
	(total_elapsed_time/execution_count) AS avg_elapsed_time,
	total_worker_time,
	total_logical_reads,
	total_logical_writes,
	total_physical_reads,
	total_elapsed_time,
	CONCAT( CAST(statement_start_offset AS VARCHAR), ':', CAST(statement_end_offset AS VARCHAR) ) AS stmt_offset,
	plan_generation_num AS num_recompiles,
	plan_handle,
	(
		SELECT
			query_plan
		FROM
			sys.dm_exec_query_plan(plan_handle)
	) AS query_plan,
	creation_time,
	last_execution_time,
	DATEDIFF(HOUR, creation_time, last_execution_time) AS diff_hour_time,
	total_rows,
	(total_rows/execution_count) AS avg_total_rows,
	last_rows,
	min_rows,
	max_rows	
	-- , st.text AS full_text
FROM
	sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS st
WHERE	1=1
		-- Skip Filter tuning queries like this
AND     st.text NOT LIKE '%sys.dm_exec%'
		-- Filter one sql_handle
-- AND     sql_handle = 0x0200000057626C058E2219E657905F1061DCDE747489E0F50000000000000000000000000000000000000000
		--
ORDER BY
	total_worker_time DESC
	-- avg_worker_time DESC
	-- total_elapsed_time / CONVERT(DECIMAL(12,2), execution_count)
	-- total_elapsed_time DESC
	-- execution_count ASC
	-- execution_count DESC
	-- max_rows DESC
	-- (total_logical_reads + total_logical_writes)/execution_count DESC
