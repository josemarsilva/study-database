-- ----------------------------------------------------------------------------
-- filename: query_query_store_qry_pln_txt.sql
-- purpose : Query on QueryStore filtering by query_id retrieving Query Transac, Query Plan and Query Text
-- revision: 2024-02-12 16:45 - josemarsilva -
-- remarks : 
--          * https://learn.microsoft.com/pt-br/sql/relational-databases/system-catalog-views/sys-query-store-query-transact-sql?view=sql-server-ver16
--			* https://learn.microsoft.com/pt-br/sql/relational-databases/system-catalog-views/sys-query-store-query-text-transact-sql?view=sql-server-ver16
--			* https://learn.microsoft.com/pt-br/sql/relational-databases/system-catalog-views/sys-query-store-plan-transact-sql?view=sql-server-ver16
-- ----------------------------------------------------------------------------

WITH XMLNAMESPACES(DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/showplan')
SELECT 
    txt.query_text_id,
	txt.query_sql_text,
	qry.query_hash,
	qry.count_compiles,
	qry.avg_compile_duration,
	pln.query_plan,
	pln.is_forced_plan
FROM sys.query_store_plan AS pln
INNER JOIN sys.query_store_query AS qry ON pln.query_id = qry.query_id
INNER JOIN sys.query_store_query_text AS txt ON qry.query_text_id = txt.query_text_id
WHERE 1=1
      -- Filter by ...
AND   pln.query_id = 30252585
