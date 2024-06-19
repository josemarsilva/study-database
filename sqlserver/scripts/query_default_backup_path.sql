-- ----------------------------------------------------------------------------
-- filename: query_default_backup_path.sql
-- purpose : Query default Backup Path 
-- revision: 2024-03-13 15:45 - josemarsilva -
-- remarks : 
--          * https://stackoverflow.com/questions/8791352/how-can-i-obtain-the-default-backup-path-for-sql-server-2008-express-r2-programm
--          * https://www.sqlservercentral.com/forums/topic/t-sql-to-get-the-default-backup-path
-- ----------------------------------------------------------------------------

--
-- Option #1:
--
SELECT  TOP 1 @regread = substring(registry_key,6,len(registry_key)-16)
FROM    sys.dm_server_registry
WHERE   registry_key like '%Parameters'
GROUP   BY registry_key
--
-- Option #2:
--
EXECUTE [master].dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'SOFTWARE\Microsoft\MSSQLServer\MSSQLServer', N'BackupDirectory'
