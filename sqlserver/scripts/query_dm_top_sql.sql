-- ----------------------------------------------------------------------------
-- filename: query_dm_top_sql.sql
-- purpose : TOP SQL with PLAN
-- revision: 2023-12-29 15:30 - josemarsilva - qp.query_plan.value
-- remarks : 
--			* https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-query-stats-transact-sql?view=sql-server-ver16
--			* https://learn.microsoft.com/en-us/sql/relational-databases/xml/xml-data-type-and-columns-sql-server?view=sql-server-ver16
-- ----------------------------------------------------------------------------

WITH XMLNAMESPACES(DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/showplan')
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
	creation_time,
	last_execution_time,
	DATEDIFF(HOUR, creation_time, last_execution_time) AS diff_hour_time,
	total_rows,
	(total_rows/execution_count) AS avg_total_rows,
	last_rows,
	min_rows,
	max_rows,
	plan_generation_num AS num_recompiles,
	plan_handle,
	qp.query_plan,
    -- qp.query_plan.value('(/ShowPlanXML/BatchSequence/Batch/Statements/StmtSimple/QueryPlan/OptimizerHardwareDependentProperties/@EstimatedAvailableDegreeOfParallelism)[1]', 'INT') AS EstimatedAvailableDegreeOfParallelism,
    -- qp.query_plan.value('(/ShowPlanXML/BatchSequence/Batch/Statements/StmtSimple/@StatementSubTreeCost)[1]', 'DECIMAL') AS StatementSubTreeCost,
	-- st.text AS full_text,
	'' AS dummy
FROM
	sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(sql_handle) AS st
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) AS qp
WHERE	1=1
		-- Skip Filter tuning queries like this
AND     st.text NOT LIKE '%sys.dm%' AND st.text NOT LIKE '%query_store%'
		-- Filter by sql_handle, plan_sqlhandle or qp.query_plan XML attribute
-- AND     sql_handle = 0x0200000057626C058E2219E657905F1061DCDE747489E0F50000000000000000000000000000000000000000
-- AND     plan_sqlhandle = 0x06000600F564952C50BE8B195D02000001000000000000000000000000000000000000000000000000000000
-- AND     qp.query_plan.value('(/ShowPlanXML/BatchSequence/Batch/Statements/StmtSimple/QueryPlan/OptimizerHardwareDependentProperties/@EstimatedAvailableDegreeOfParallelism)[1]', 'INT') > 2
		--
ORDER BY
	-- Order by a criteria
	total_worker_time DESC
	-- avg_worker_time DESC
	-- total_elapsed_time / CONVERT(DECIMAL(12,2), execution_count)
	-- total_elapsed_time DESC
	-- execution_count ASC
	-- execution_count DESC
	-- max_rows DESC
	-- (total_logical_reads + total_logical_writes)/execution_count DESC
