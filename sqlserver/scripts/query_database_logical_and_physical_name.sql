-- ----------------------------------------------------------------------------
-- filename: query_database_logical_and_physical_name
-- purpose : Query Logical and Physical databases names
-- revision: 2024-03182 20:38 - josemarsilva - 
-- remarks : 
-- ----------------------------------------------------------------------------

SELECT 
	d.name AS database_name, 
	f.name AS logical_name, 
	f.physical_name AS physical_name
FROM  sys.master_files f
INNER JOIN sys.databases d 
ON d.database_id = f.database_id
ORDER BY 1
