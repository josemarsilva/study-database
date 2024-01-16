-- ----------------------------------------------------------------------------
-- filename: query_dm_top_sql.sql
-- purpose : TOP SQL with PLAN
-- revision: 2023-12-30 00:12 - josemarsilva - qp.query_plan.value
-- remarks : 
--			* https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-query-stats-transact-sql?view=sql-server-ver16
--			* https://learn.microsoft.com/en-us/sql/relational-databases/xml/xml-data-type-and-columns-sql-server?view=sql-server-ver16
-- ----------------------------------------------------------------------------

WITH XMLNAMESPACES(DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/showplan')
SELECT
	TOP 100
	qs.sql_handle,
	(
		SELECT
			SUBSTRING(text, qs.statement_start_offset/2 + 1, (
					CASE
					WHEN
							qs.statement_end_offset = -1
					THEN
							LEN(CONVERT(nvarchar(MAX),st.text)) * 2
					ELSE
							qs.statement_end_offset
					END - qs.statement_start_offset)/2)
		FROM
			sys.dm_exec_sql_text(sql_handle)
	) AS query_text,
	qs.execution_count,
	(qs.total_worker_time/execution_count) AS avg_worker_time,
	(qs.total_logical_reads/execution_count) AS avg_logical_reads,
	(qs.total_logical_writes/execution_count) AS avg_logical_writes,
	(qs.total_physical_reads/execution_count) AS avg_phys_reads,
	(qs.total_elapsed_time/execution_count) AS avg_elapsed_time,
	qs.total_worker_time,
	qs.total_logical_reads,
	qs.total_logical_writes,
	qs.total_physical_reads,
	qs.total_elapsed_time,
	CONCAT( CAST(qs.statement_start_offset AS VARCHAR), ':', CAST(qs.statement_end_offset AS VARCHAR) ) AS stmt_offset,
	qs.creation_time,
	qs.last_execution_time,
	DATEDIFF(HOUR, qs.creation_time, qs.last_execution_time) AS diff_hour_time,
	qs.total_rows,
	(qs.total_rows/execution_count) AS avg_total_rows,
	qs.last_rows,
	qs.min_rows,
	qs.max_rows,
	qs.plan_generation_num AS num_recompiles,
	qs.plan_handle,
	qp.query_plan,
    -- qp.query_plan.value('(/ShowPlanXML/BatchSequence/Batch/Statements/StmtSimple/QueryPlan/OptimizerHardwareDependentProperties/@EstimatedAvailableDegreeOfParallelism)[1]', 'INT') AS estimated_available_degree_of_parallelism,
    -- qp.query_plan.value('(/ShowPlanXML/BatchSequence/Batch/Statements/StmtSimple/@StatementSubTreeCost)[1]', 'DECIMAL') AS statement_sub_tree_cost,
    -- qp.query_plan.value('(/ShowPlanXML/BatchSequence/Batch/Statements/StmtSimple/QueryPlan/ParameterList)[1]', 'nvarchar(max)') AS parameter_list,
	-- st.text AS full_text,
	'' AS dummy
FROM
	sys.dm_exec_query_stats qs WITH(NOLOCK)
CROSS APPLY 
	sys.dm_exec_sql_text(qs.sql_handle) AS st
CROSS APPLY 
	sys.dm_exec_query_plan(qs.plan_handle) AS qp
WHERE	1=1
		-- Skip Filter tuning queries like this
AND     st.text NOT LIKE '%sys.dm%' AND st.text NOT LIKE '%query_store%'
		-- Filter by sql_handle, plan_sqlhandle or qp.query_plan XML attribute
-- AND     qs.sql_handle = 0x0200000054E2330203E104C83843AB15EFF202BA6F289F260000000000000000000000000000000000000000
-- AND     qs.plan_handle = 0x0600050054E23302E0BDB4A5DB01000001000000000000000000000000000000000000000000000000000000
-- AND     qp.query_plan.value('(/ShowPlanXML/BatchSequence/Batch/Statements/StmtSimple/QueryPlan/OptimizerHardwareDependentProperties/@EstimatedAvailableDegreeOfParallelism)[1]', 'INT') > 2
		--
ORDER BY
	-- Order by a criteria
	qs.total_worker_time DESC
	-- qs.avg_worker_time DESC
	-- qs.total_elapsed_time / CONVERT(DECIMAL(12,2), qs.execution_count)
	-- qs.total_elapsed_time DESC
	-- qs.execution_count ASC
	-- qs.execution_count DESC
	-- qs.max_rows DESC
	-- (qs.total_logical_reads + qs.total_logical_writes)/qs.execution_count DESC
