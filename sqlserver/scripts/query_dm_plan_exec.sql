-- ----------------------------------------------------------------------------
-- filename: query_dm_plan_exec.sql
-- purpose : Execution plan of a query
-- revision: 2024-01-02 16:55 - josemarsilva - st.text AS full_text
-- remarks : 
--			* https://learn.microsoft.com/pt-br/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-query-plan-transact-sql?view=azuresqldb-current
-- ----------------------------------------------------------------------------

WITH XMLNAMESPACES(DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/showplan')
SELECT
	TOP 25
	qs.sql_handle,
	(
		SELECT
			SUBSTRING(st.text, qs.statement_start_offset/2 + 1, (
					CASE
					WHEN
							qs.statement_end_offset = -1
					THEN
							LEN(CONVERT(nvarchar(MAX), st.text)) * 2
					ELSE
							qs.statement_end_offset
					END - qs.statement_start_offset)/2)
		FROM
			sys.dm_exec_sql_text(sql_handle)
	) AS query_text,
	CONCAT( CAST(qs.statement_start_offset AS VARCHAR), ':', CAST(qs.statement_end_offset AS VARCHAR) ) AS stmt_offset,
	st.text AS full_text,
	qs.plan_handle,
	qp.query_plan,
    qp.query_plan.value('(/ShowPlanXML/BatchSequence/Batch/Statements/StmtSimple/@StatementText)[1]', 'nvarchar(max)') AS statement_text,
    qp.query_plan.value('(/ShowPlanXML/BatchSequence/Batch/Statements/StmtSimple/QueryPlan/@ParameterList)[1]', 'nvarchar(max)') AS parameter_list,
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
-- AND     qs.sql_handle = 0x02000000026D621F0EA92BB78C3D648784DFC7DFD27058C70000000000000000000000000000000000000000
-- AND     qs.plan_handle = 0x06000600026D621F401D1A635D02000001000000000000000000000000000000000000000000000000000000
		--
ORDER BY
	-- Order by a criteria
	qs.sql_handle, qs.statement_start_offset, qs.plan_handle
