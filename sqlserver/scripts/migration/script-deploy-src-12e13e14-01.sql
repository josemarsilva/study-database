--
-- script-deploy-src-12e13e14-01.sql
--
USE master
GO

--
--
--
DECLARE @backupType   NVARCHAR(30) = 'last'
DECLARE @sequence     NVARCHAR(30) = '06'
DECLARE @databaseName NVARCHAR(30) = '{deploy_database}'
DECLARE @toDisk       NVARCHAR(4000) = N'/mnt/share/{deploy_database}_' + @sequence + '_' + @backupType + '.bak'
DECLARE @name         NVARCHAR(4000) = N'Backup ' + @backupType + ' database [' + @databaseName + '] - TaskGroup ' + @sequence
DECLARE @sql          NVARCHAR(4000)
--
--
--
SET @sql = N'ALTER DATABASE ' + QUOTENAME(@databaseName) + N' SET SINGLE_USER WITH ROLLBACK IMMEDIATE;'
EXEC sp_executesql @sql;

PRINT 'BACKUP'
PRINT '   TO DISK ' + @toDisk
PRINT '   NAME    ' + @name

BACKUP DATABASE @databaseName
    TO DISK = @toDisk WITH DIFFERENTIAL,
    NOFORMAT,
    NOINIT,
    NAME = @name,
    SKIP,
    NOREWIND,
    NOUNLOAD,
    STATS = 10,
    CHECKSUM;

--
--
--

SET @sql = N'ALTER DATABASE ' + QUOTENAME(@databaseName) + N' SET READ_ONLY;'
PRINT @sql
EXEC sp_executesql @sql;

SET @sql = N'ALTER DATABASE ' + QUOTENAME(@databaseName) + N' SET MULTI_USER;'
PRINT @sql
EXEC sp_executesql @sql;

GO

