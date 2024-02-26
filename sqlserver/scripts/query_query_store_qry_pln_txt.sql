-- ----------------------------------------------------------------------------
-- filename: query_query_store_qry_pln_txt.sql
-- purpose : Query on QueryStore filtering by query_id retrieving Query Transac, Query Plan and Query Text
-- revision: 2024-02-16 15:45 - josemarsilva -
-- remarks : 
--          * https://learn.microsoft.com/pt-br/sql/relational-databases/system-catalog-views/sys-query-store-query-transact-sql?view=sql-server-ver16
--			* https://learn.microsoft.com/pt-br/sql/relational-databases/system-catalog-views/sys-query-store-query-text-transact-sql?view=sql-server-ver16
--			* https://learn.microsoft.com/pt-br/sql/relational-databases/system-catalog-views/sys-query-store-plan-transact-sql?view=sql-server-ver16
-- ----------------------------------------------------------------------------

WITH XMLNAMESPACES(DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/showplan')
SELECT 
	qry.query_id,
	qry.query_hash,
	pln.plan_id,
	pln.last_execution_time,
	qry.count_compiles,
	qry.avg_compile_duration,
	qry.avg_bind_duration,
	qry.avg_bind_cpu_time,
	qry.avg_optimize_duration,
	qry.avg_optimize_cpu_time,
	qry.avg_compile_memory_kb,
	qry.last_execution_time,
    txt.query_text_id,
	txt.query_sql_text,
	pln.query_plan,
	pln.is_forced_plan
FROM sys.query_store_query AS qry 
INNER JOIN sys.query_store_query_text AS txt ON txt.query_text_id = qry.query_text_id 
INNER JOIN sys.query_store_plan AS pln ON pln.query_id = qry.query_id
WHERE   1=1
	-- Filter by ...
AND	pln.query_id = 3233992
ORDER  BY
	-- Order by ...
	qry.query_id, txt.query_text_id, pln.last_execution_time DESC, pln.plan_id