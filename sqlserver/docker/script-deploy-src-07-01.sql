--
-- script-deploy-src-07-01.sql
--
USE master
GO

--
--
--
DECLARE @backupType   NVARCHAR(30) = 'diff'
DECLARE @sequence     NVARCHAR(30) = '03'
DECLARE @databaseName NVARCHAR(30) = 'labdb'
DECLARE @toDisk       NVARCHAR(4000) = N'/mnt/share/labdb_' + @sequence + '_' + @backupType + '.bak'
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
