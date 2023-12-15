-- ----------------------------------------------------------------------------
-- filename: query_index_fragmentation.sql
-- purpose : Query index fragmentation
-- revision: 2023-12-15 18:25 - josemarsilva - 
-- remarks : 
-- ----------------------------------------------------------------------------


SELECT
        QUOTENAME(OBJECT_NAME(ip.OBJECT_ID)) AS [tablename],
        OBJECT_SCHEMA_NAME (ip.OBJECT_ID) AS [owner],
        avg_fragmentation_in_percent,
        i.name AS [index_name],
        'ALTER INDEX '       + i.name + ' ON ' + OBJECT_SCHEMA_NAME (ip.OBJECT_ID) + '.' + QUOTENAME(OBJECT_NAME(ip.OBJECT_ID)) + ' REBUILD WITH (ONLINE = ON, SORT_IN_TEMPDB = ON, MAXDOP = 1)' AS [alter_index_stmt],
        'UPDATE STATISTICS ' + OBJECT_SCHEMA_NAME (ip.OBJECT_ID) + '.' + QUOTENAME(OBJECT_NAME(ip.OBJECT_ID)) AS [update_statistics_stmt]
FROM
        sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ip
JOIN
        sys.indexes i WITH(NOLOCK)
ON
        i.object_id = ip.object_id
AND     i.index_id  = ip.index_id
WHERE
	1=1
AND     avg_fragmentation_in_percent >= 10
-- AND  avg_fragmentation_in_percent > 30
AND     i.name is not null
-- AND  OBJECT_SCHEMA_NAME (ip.OBJECT_ID) in ('cliente_variavel_negociacao', 'cliente_marca_variavel_padronizada', 'unidade', 'cliente')
ORDER BY
        avg_fragmentation_in_percent desc