-- ----------------------------------------------------------------------------
-- filename: query_database_physical_file_path
-- purpose : Query all physical files and path for each databases
-- revision: 2024-01-02 16:55 - josemarsilva - 
-- remarks : 
-- ----------------------------------------------------------------------------

SELECT
    DB_NAME(database_id) AS database_name,
    type_desc AS file_type,
    physical_name AS file_path,
	name AS file_group_name
FROM
    sys.master_files
WHERE
	1=1
	-- Filter only these databases
    -- AND DB_NAME(database_id) IN ('Northwind') 
	-- Skip these databases
    AND DB_NAME(database_id) NOT IN ('master', 'model', 'msdb', 'tempdb') 
ORDER BY 1
