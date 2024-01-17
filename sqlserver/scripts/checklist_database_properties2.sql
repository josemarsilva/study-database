-- ----------------------------------------------------------------------------
-- filename: checklist_database_properties2
-- purpose : Script to Check Database Properties
-- revision: 2024-01-11 19:30 - josemarsilva - 
-- remarks : 
--          * https://www.mssqltips.com/sqlservertip/1936/sql-server-database-migration-checklist/
-- ----------------------------------------------------------------------------

declare @dbdesc varchar(max)
declare @name varchar(10)
set @name='Master'
SELECT @dbdesc = 'Status=' + convert(sysname,DatabasePropertyEx(@name,'Status'))  
SELECT @dbdesc = @dbdesc + ', Updateability=' + convert(sysname,DatabasePropertyEx(@name,'Updateability'))  
SELECT @dbdesc = @dbdesc + ', UserAccess=' + convert(sysname,DatabasePropertyEx(@name,'UserAccess'))  
SELECT @dbdesc = @dbdesc + ', Recovery=' + convert(sysname,DatabasePropertyEx(@name,'Recovery'))  
SELECT @dbdesc = @dbdesc + ', Version=' + convert(sysname,DatabasePropertyEx(@name,'Version'))  
  
 -- These props only available if db not shutdown  
 IF DatabaseProperty(@name, 'IsShutdown') = 0  
 BEGIN  
  SELECT @dbdesc = @dbdesc + ', Collation=' + convert(sysname,DatabasePropertyEx(@name,'Collation'))  
  SELECT @dbdesc = @dbdesc + ', SQLSortOrder=' + convert(sysname,DatabasePropertyEx(@name,'SQLSortOrder'))  
 END  
  
 -- These are the boolean properties  
 IF DatabasePropertyEx(@name,'IsAutoClose') = 1  
  SELECT @dbdesc = @dbdesc + ', ' + 'IsAutoClose'  
 IF DatabasePropertyEx(@name,'IsAutoShrink') = 1  
  SELECT @dbdesc = @dbdesc + ', ' + 'IsAutoShrink'  
 IF DatabasePropertyEx(@name,'IsInStandby') = 1  
  SELECT @dbdesc = @dbdesc + ', ' + 'IsInStandby'  
 IF DatabasePropertyEx(@name,'IsTornPageDetectionEnabled') = 1  
  SELECT @dbdesc = @dbdesc + ', ' + 'IsTornPageDetectionEnabled'  
 IF DatabasePropertyEx(@name,'IsAnsiNullDefault') = 1  
  SELECT @dbdesc = @dbdesc + ', ' + 'IsAnsiNullDefault'  
 IF DatabasePropertyEx(@name,'IsAnsiNullsEnabled') = 1  
  SELECT @dbdesc = @dbdesc + ', ' + 'IsAnsiNullsEnabled'  
 IF DatabasePropertyEx(@name,'IsAnsiPaddingEnabled') = 1  
  SELECT @dbdesc = @dbdesc + ', ' + 'IsAnsiPaddingEnabled'  
 IF DatabasePropertyEx(@name,'IsAnsiWarningsEnabled') = 1  
  SELECT @dbdesc = @dbdesc + ', ' + 'IsAnsiWarningsEnabled'  
 IF DatabasePropertyEx(@name,'IsArithmeticAbortEnabled') = 1  
  SELECT @dbdesc = @dbdesc + ', ' + 'IsArithmeticAbortEnabled'  
 IF DatabasePropertyEx(@name,'IsAutoCreateStatistics') = 1  
  SELECT @dbdesc = @dbdesc + ', ' + 'IsAutoCreateStatistics'  
 IF DatabasePropertyEx(@name,'IsAutoUpdateStatistics') = 1  
  SELECT @dbdesc = @dbdesc + ', ' + 'IsAutoUpdateStatistics'  
 IF DatabasePropertyEx(@name,'IsCloseCursorsOnCommitEnabled') = 1  
  SELECT @dbdesc = @dbdesc + ', ' + 'IsCloseCursorsOnCommitEnabled'  
 IF DatabasePropertyEx(@name,'IsFullTextEnabled') = 1  
  SELECT @dbdesc = @dbdesc + ', ' + 'IsFullTextEnabled'  
 IF DatabasePropertyEx(@name,'IsLocalCursorsDefault') = 1  
  SELECT @dbdesc = @dbdesc + ', ' + 'IsLocalCursorsDefault'  
 IF DatabasePropertyEx(@name,'IsNullConcat') = 1  
  SELECT @dbdesc = @dbdesc + ', ' + 'IsNullConcat'  
 IF DatabasePropertyEx(@name,'IsNumericRoundAbortEnabled') = 1  
  SELECT @dbdesc = @dbdesc + ', ' + 'IsNumericRoundAbortEnabled'  
 IF DatabasePropertyEx(@name,'IsQuotedIdentifiersEnabled') = 1  
  SELECT @dbdesc = @dbdesc + ', ' + 'IsQuotedIdentifiersEnabled'  
 IF DatabasePropertyEx(@name,'IsRecursiveTriggersEnabled') = 1  
  SELECT @dbdesc = @dbdesc + ', ' + 'IsRecursiveTriggersEnabled'  
 IF DatabasePropertyEx(@name,'IsMergePublished') = 1  
  SELECT @dbdesc = @dbdesc + ', ' + 'IsMergePublished'  
 IF DatabasePropertyEx(@name,'IsPublished') = 1  
  SELECT @dbdesc = @dbdesc + ', ' + 'IsPublished'  
 IF DatabasePropertyEx(@name,'IsSubscribed') = 1  
  SELECT @dbdesc = @dbdesc + ', ' + 'IsSubscribed'  
 IF DatabasePropertyEx(@name,'IsSyncWithBackup') = 1  
  SELECT @dbdesc = @dbdesc + ', ' + 'IsSyncWithBackup'  
SELECT @dbdesc