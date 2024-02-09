-- ----------------------------------------------------------------------------
-- filename: query_space_used.sql
-- purpose : Formas de obter o tamanho do(s) database(s) de um servidor
-- revision: 2024-02-09 18:30 - josemarsilva - 
-- remarks : 
-- ----------------------------------------------------------------------------

--
-- Há 3 métodos listados aqui
--

--
-- 1. Método no. 01 - stored procedure sp_spaceused
--    Premissa: USE [datababase]
--

USE [AdventureWorks2019]
EXEC sp_spaceused;

/*
database_name     	database_size   unallocated space
------------------  -------------   ---------
AdventureWorks2019	272.00 MB       2.36 MB

reserved 	data    	index_size	unused
---------   --------    ----------    --------
202384 KB	96984 KB	85592 KB	19808 KB

*/


--
-- 2. Método no. 02 - query sys.master_files 
--    Premissa: USE [datababase]
--

USE [AdventureWorks2019]
SELECT
    database_name = DB_NAME(database_id),
    log_size_mb = CAST(SUM(CASE WHEN type_desc = 'LOG' THEN size END) * 8. / 1024 AS DECIMAL(8, 2)),
    row_size_mb = CAST(SUM(CASE WHEN type_desc = 'ROWS' THEN size END) * 8. / 1024 AS DECIMAL(8, 2)),
    total_size_mb = CAST(SUM(size) * 8. / 1024 AS DECIMAL(8, 2))
FROM sys.master_files WITH (NOWAIT)
WHERE database_id > 4 -- Exclui bancos de sistema (master, model, msdb, tempdb)
GROUP BY database_id;


/*
database_name     	log_size_mb	row_size_mb total_size_mb
------------------  ----------- ----------- -------------
AdventureWorks2019	72.00      	200.00     	272.00
Northwind         	72.00      	8.00       	80.00
labdb             	8.00       	8.00       	16.00
labdb2             	8.00       	8.00       	16.00
labdb3             	8.00       	8.00       	16.00

 */


--
-- 3. Método no. 03 - criando uma function customizada
--    Premissa: não pecisa do USE pois o database é passado no parametro
--

CREATE FUNCTION dbo.GetDBSize(@db_name NVARCHAR(100))
RETURNS TABLE
AS
RETURN
SELECT
    database_name = DB_NAME(database_id),
    log_size_mb = CAST(SUM(CASE WHEN type_desc = 'LOG' THEN size END) * 8. / 1024 AS DECIMAL(8, 2)),
    row_size_mb = CAST(SUM(CASE WHEN type_desc = 'ROWS' THEN size END) * 8. / 1024 AS DECIMAL(8, 2)),
    total_size_mb = CAST(SUM(size) * 8. / 1024 AS DECIMAL(8, 2))
FROM sys.master_files WITH (NOWAIT)
WHERE DB_NAME(database_id) = @db_name OR @db_name IS NULL
GROUP BY database_id;

SELECT * FROM dbo.GetDBSize('AdventureWorks2019');

