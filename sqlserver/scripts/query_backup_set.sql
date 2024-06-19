-- ----------------------------------------------------------------------------
-- filename: query_backup_set.sql
-- purpose : Matar sessoes inativas a mais de 24H, exceto uma @@spid
-- revision: 2024-02-09 18:30 - josemarsilva - 
-- remarks : 
-- ----------------------------------------------------------------------------

SELECT
    bs.backup_start_date,
    bmf.physical_device_name
FROM
    msdb.dbo.backupset AS bs
INNER JOIN
    msdb.dbo.backupmediafamily AS bmf ON bs.media_set_id = bmf.media_set_id
WHERE
    bs.database_name = 'NomeDoBancoDeDados'
    AND bs.type = 'D' -- Backup Completo
ORDER BY
    bs.backup_start_date DESC;
