--
-- script-deploy-tgt-03-01.sql
--
USE master
GO

--
--
--
DECLARE @backupType    NVARCHAR(30) = 'diff'
DECLARE @sequence      NVARCHAR(30) = '03'
DECLARE @databaseName  NVARCHAR(30) = 'labdb'
DECLARE @fromDisk      NVARCHAR(4000) = N'/mnt/share/labdb_' + @sequence + '_' + @backupType + '.bak'
DECLARE @toDiskTailLog NVARCHAR(4000) = N'/mnt/share/labdb_' + @sequence + '_' + 'tail' + '.bak'
DECLARE @name          NVARCHAR(4000) = N'Restore ' + @backupType + ' database [' + @databaseName + '] - TaskGroup ' + @sequence
DECLARE @sql           NVARCHAR(4000) = N''


--
-- Only if database already exists
--
-- SET @sql = N'ALTER DATABASE ' + QUOTENAME(@databaseName) + N' SET SINGLE_USER WITH ROLLBACK IMMEDIATE;'
-- EXEC sp_executesql @sql;

PRINT ''
PRINT 'RESTORE DATABASE ' + @databaseName
PRINT '        FROM DISK = ' + @fromDisk
PRINT '        TYPE = ' + @backupType
PRINT ''

RESTORE DATABASE @databaseName
    FROM DISK = @fromDisk
    WITH FILE = 1, 
    NORECOVERY,
    STATS = 10;


--
--
--
-- SET @sql = N'ALTER DATABASE ' + QUOTENAME(@databaseName) + N' SET MULTI_USER;'
-- EXEC sp_executesql @sql;

GO
