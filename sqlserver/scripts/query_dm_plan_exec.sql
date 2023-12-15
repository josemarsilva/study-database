-- ----------------------------------------------------------------------------
-- filename: query_dm_plan_exec.sql
-- purpose : Execution plan of a query
-- revision: 2023-12-15 18:35 - josemarsilva@inmetrics.com.br - 
-- remarks : https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-query-plan-transact-sql?view=azuresqldb-current
-- ----------------------------------------------------------------------------

SELECT query_plan
FROM   sys.dm_exec_query_plan( 
		CONVERT(
			VARBINARY(64), 
			--
			-- Put your "plan_handle" here!
			--
			'0x06000500F9A88D1A70B8C309BB02000001000000000000000000000000000000000000000000000000000000', 
			1
		) 
	)
