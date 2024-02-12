--
-- script-deploy-tgt-06-01.sql
--
USE master
GO

--
--
--
DECLARE @backupType    NVARCHAR(30) = 'last'
DECLARE @sequence      NVARCHAR(30) = '06'
DECLARE @databaseName  NVARCHAR(30) = '{deploy_database}'
DECLARE @fromDisk      NVARCHAR(4000) = N'/mnt/share/{deploy_database}_' + @sequence + '_' + @backupType + '.bak'
DECLARE @toDiskTailLog NVARCHAR(4000) = N'/mnt/share/{deploy_database}_' + @sequence + '_' + 'tail' + '.bak'
DECLARE @name          NVARCHAR(4000) = N'Restore ' + @backupType + ' database [' + @databaseName + '] - TaskGroup ' + @sequence
DECLARE @sql           NVARCHAR(4000) = N''


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

RESTORE DATABASE @databaseName
    WITH RECOVERY;
--
-- SET READ_WRITE, MULTI_USER
--

ALTER DATABASE {deploy_database} SET READ_WRITE;
ALTER DATABASE {deploy_database} SET MULTI_USER;

GO

