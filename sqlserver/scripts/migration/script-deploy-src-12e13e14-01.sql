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
-- SET SINGLE_USER, BACKUP
--
ALTER DATABASE {deploy_database} SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

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
-- SET READ_ONLY, MULTI_USER
--

ALTER DATABASE {deploy_database} SET READ_ONLY;
ALTER DATABASE {deploy_database} SET MULTI_USER;

GO

