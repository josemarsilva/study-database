--
-- Task script-deploy-src-40-01 - 01: READ_ONLY
--
USE [master]
ALTER DATABASE [AdventureWorks2019] SET READ_ONLY ;


--
-- Task script-deploy-src-40-01 - 02: Query database physical files
--
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



--
-- Task script-deploy-src-40-01 - 03: COPY physical data files from source to stage
--
/* ps1

docker cp mssql-labdb-2019:/var/opt/mssql/data/AdventureWorks2019.mdf     'C:\Users\josemarsilva\githome\shared-volumes\'    
docker cp mssql-labdb-2019:/var/opt/mssql/data/AdventureWorks2019_log.ldf 'C:\Users\josemarsilva\githome\shared-volumes\'

 */


--
-- Task script-deploy-src-40-01 - 04: DEATTACH DATABASE
--
EXEC sp_detach_db @dbname = N'AdventureWorks2019';


GO

