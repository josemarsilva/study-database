--
-- script-deploy-src-05-01.sql
--
USE master
GO

--
--
--
DECLARE @backupType   NVARCHAR(30) = 'diff'
DECLARE @sequence     NVARCHAR(30) = '02'
DECLARE @databaseName NVARCHAR(30) = '{deploy_database}'
DECLARE @toDisk       NVARCHAR(4000) = N'/mnt/share/{deploy_database}_' + @sequence + '_' + @backupType + '.bak'
DECLARE @name         NVARCHAR(4000) = N'Backup ' + @backupType + ' database [' + @databaseName + '] - TaskGroup ' + @sequence

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
    CHECKSUM
GO
