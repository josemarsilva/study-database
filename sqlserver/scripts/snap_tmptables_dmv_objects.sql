-- ----------------------------------------------------------------------------
-- filename: snap_dmv_objects_into_tmptables.sql
-- purpose : Snap SQLServer DMV (Dynamic Management Views) objects into #tmpTables
-- revision: 2024-01-22 00:12 - josemarsilva - 
-- remarks : 
--			* https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-query-stats-transact-sql?view=sql-server-ver16
--			* https://stackoverflow.com/questions/67268792/querying-data-from-sql-server-table-with-powershell
--			* https://learn.microsoft.com/en-us/powershell/module/sqlserver/invoke-sqlcmd?view=sqlserver-ps
--			* https://www.itprotoday.com/powershell/how-connect-sql-server-database-powershell#close-modal
-- ----------------------------------------------------------------------------

--
-- Step#1. Temporary Table: #tmp_snap_exec	
--
SELECT 
	@@servername AS servername, 
	DB_NAME() dbname, 
	GETDATE() datehour
INTO #tmp_snap_exec
GO

--
-- Step#2. Temporary Table: #tmp_snap_exec_query_stats
--
WITH XMLNAMESPACES(DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/showplan')
SELECT
	TOP 1000
	qs.sql_handle,
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
	qs.statement_start_offset,
	qs.statement_end_offset,
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
	qs.plan_handle
INTO #tmp_snap_exec_query_stats
FROM
	sys.dm_exec_query_stats qs WITH(NOLOCK)
CROSS APPLY 
	sys.dm_exec_sql_text(qs.sql_handle) AS st
WHERE	1=1
		-- Skip Filter tuning queries like this
AND     st.text NOT LIKE '%sys.dm%' AND st.text NOT LIKE '%query_store%'
		--
ORDER BY
	-- Order by a criteria
	qs.total_worker_time DESC
GO

--
-- Step#3. Temporary Table: #tmp_snap_exec_sql_text
--
SELECT
	qs.sql_handle,
	st.text
INTO #tmp_snap_exec_sql_text
FROM  
	(
		SELECT DISTINCT sql_handle FROM #tmp_snap_exec_query_stats
	) qs
CROSS APPLY 
	sys.dm_exec_sql_text(qs.sql_handle) AS st

--
-- Step#4. Temporary Table: #tmp_snap_query_plan
--
SELECT
	qs.plan_handle,
	qp.query_plan
INTO #tmp_snap_query_plan
FROM  
	(
		SELECT DISTINCT plan_handle FROM #tmp_snap_exec_query_stats
	) qs
CROSS APPLY 
	sys.dm_exec_query_plan(qs.plan_handle) AS qp

