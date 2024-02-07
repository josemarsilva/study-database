--
-- script-deploy-tgt-08-04.sql
--

--
-- Step#01: USE {deploy_database} - Replaced by current deploy database
--
USE {deploy_database}


--
-- Step#02: Query Checklist
--
SELECT
    '01 - Checklist objects_type_desc count' AS checklist_name,
    src_and_tgt.object_type_desc,
    '[databasename].[schema_name]' AS item_type,
    CONCAT(
        '[', src_and_tgt.database_name, '].[',
        src_and_tgt.schema_name, ']'
    ) AS item,
    CONCAT(
        CONVERT(VARCHAR(10), src.count_objects),
        ' x ',
        CONVERT(VARCHAR(10), tgt.count_objects)
    ) AS checked_values,
    (
        CASE 
            WHEN COALESCE(src.count_objects,0) = COALESCE(tgt.count_objects,0)
                THEN 'OK'
            ELSE
                'CHECK ERROR'
        END
    ) AS status
FROM 
    (
        SELECT 
            database_name,
            schema_name,
            object_type_desc
        FROM
            migration_results mr
        GROUP BY 
            database_name,
            schema_name,
            object_type_desc
    ) AS src_and_tgt
LEFT OUTER JOIN
    (
        SELECT 
            source_target,
            server_name,
            database_name,
            schema_name,
            object_type_desc,
            COUNT(1) AS count_objects
        FROM
            migration_results mr
        WHERE
            source_target = 'source'
        GROUP BY 
            source_target,
            server_name,
            database_name,
            schema_name,
            object_type_desc
    ) AS src
    ON  src.source_target = 'source'
    AND COALESCE(src.database_name,'') = COALESCE(src_and_tgt.database_name,'')
    AND COALESCE(src.schema_name,'') = COALESCE(src_and_tgt.schema_name,'')
    AND src.object_type_desc = src_and_tgt.object_type_desc
LEFT OUTER JOIN
    (
        SELECT 
            source_target,
            server_name,
            database_name,
            schema_name,
            object_type_desc,
            COUNT(1) AS count_objects
        FROM
            migration_results mr
        WHERE
            source_target = 'target'
        GROUP BY 
            source_target,
            server_name,
            database_name,
            schema_name,
            object_type_desc
    ) AS tgt
    ON  tgt.source_target = 'target'
    AND COALESCE(tgt.database_name,'') = COALESCE(src_and_tgt.database_name,'')
    AND COALESCE(tgt.schema_name,'') = COALESCE(src_and_tgt.schema_name,'')
    AND tgt.object_type_desc = src_and_tgt.object_type_desc
--
UNION ALL
SELECT
    '02 - Checklist Table count' AS checklist_name,
    src_and_tgt.object_type_desc,
    '[databasename].[schema_name].[object_name]' AS item_type,
    CONCAT(
        '[', src_and_tgt.database_name, '].[',
        src_and_tgt.schema_name, '].[',
        src_and_tgt.object_name, ']'
    ) AS item,
    CONCAT(
        CONVERT(VARCHAR(10), src.property_int),
        ' x ',
        CONVERT(VARCHAR(10), tgt.property_int)
    ) AS checked_values,
    (
        CASE 
            WHEN COALESCE(src.property_int,0) = COALESCE(tgt.property_int,0)
                THEN 'OK'
            ELSE
                'CHECK ERROR'
        END
    ) AS status
FROM 
    (
        SELECT 
            database_name,
            schema_name,
            object_name,
            object_type_desc
        FROM
            migration_results mr
        GROUP BY 
            database_name,
            schema_name,
            object_name,
            object_type_desc
    ) AS src_and_tgt
LEFT OUTER JOIN
    (
        SELECT 
            source_target,
            server_name,
            database_name,
            schema_name,
            object_name,
            object_type_desc,
            property_int
        FROM
            migration_results mr
        WHERE
            source_target = 'source'
    ) AS src
    ON  src.source_target = 'source'
    AND COALESCE(src.database_name,'') = COALESCE(src_and_tgt.database_name,'')
    AND COALESCE(src.schema_name,'') = COALESCE(src_and_tgt.schema_name,'')
    AND COALESCE(src.object_name,'') = COALESCE(src_and_tgt.object_name,'')
    AND src.object_type_desc = src_and_tgt.object_type_desc
LEFT OUTER JOIN
    (
        SELECT 
            source_target,
            server_name,
            database_name,
            schema_name,
            object_name,
            object_type_desc,
            property_int
        FROM
            migration_results mr
        WHERE
            source_target = 'target'
    ) AS tgt
    ON  tgt.source_target = 'target'
    AND COALESCE(tgt.database_name,'') = COALESCE(src_and_tgt.database_name,'')
    AND COALESCE(tgt.schema_name,'') = COALESCE(src_and_tgt.schema_name,'')
    AND COALESCE(tgt.object_name,'') = COALESCE(src_and_tgt.object_name,'')
    AND tgt.object_type_desc = src_and_tgt.object_type_desc
WHERE 1 = 1 
AND   src.object_type_desc = 'U  - USER_TABLE'
AND   tgt.object_type_desc = 'U  - USER_TABLE'
--
UNION ALL
SELECT
    '03 - Checklist View compare' AS checklist_name,
    src_and_tgt.object_type_desc,
    '[databasename].[schema_name].[object_name]' AS item_type,
    CONCAT(
        '[', src_and_tgt.database_name, '].[',
        src_and_tgt.schema_name, '].[',
        src_and_tgt.object_name, ']'
    ) AS item,
    'src x tgt' AS checked_values,
    (
        CASE 
            WHEN COALESCE(src.object_name,'') = COALESCE(tgt.object_name,'')
                THEN 'OK'
            ELSE
                'CHECK ERROR'
        END
    ) AS status
FROM 
    (
        SELECT 
            database_name,
            schema_name,
            object_name,
            object_type_desc
        FROM
            migration_results mr
        GROUP BY 
            database_name,
            schema_name,
            object_name,
            object_type_desc
    ) AS src_and_tgt
LEFT OUTER JOIN
    (
        SELECT 
            source_target,
            server_name,
            database_name,
            schema_name,
            object_name,
            object_type_desc,
            property_int
        FROM
            migration_results mr
        WHERE
            source_target = 'source'
    ) AS src
    ON  src.source_target = 'source'
    AND COALESCE(src.database_name,'') = COALESCE(src_and_tgt.database_name,'')
    AND COALESCE(src.schema_name,'') = COALESCE(src_and_tgt.schema_name,'')
    AND COALESCE(src.object_name,'') = COALESCE(src_and_tgt.object_name,'')
    AND src.object_type_desc = src_and_tgt.object_type_desc
LEFT OUTER JOIN
    (
        SELECT 
            source_target,
            server_name,
            database_name,
            schema_name,
            object_name,
            object_type_desc,
            property_int
        FROM
            migration_results mr
        WHERE
            source_target = 'target'
    ) AS tgt
    ON  tgt.source_target = 'target'
    AND COALESCE(tgt.database_name,'') = COALESCE(src_and_tgt.database_name,'')
    AND COALESCE(tgt.schema_name,'') = COALESCE(src_and_tgt.schema_name,'')
    AND COALESCE(tgt.object_name,'') = COALESCE(src_and_tgt.object_name,'')
    AND tgt.object_type_desc = src_and_tgt.object_type_desc
WHERE 1 = 1 
AND   src.object_type_desc = 'V  - VIEW'
AND   tgt.object_type_desc = 'V  - VIEW'
--
UNION ALL
SELECT
    '04 - Constraints PK, FK, CHK, DFLT and UK compare' AS checklist_name,
    src_and_tgt.object_type_desc,
    '[databasename].[schema_name].[object_name]' AS item_type,
    CONCAT(
        '[', src_and_tgt.database_name, '].[',
        src_and_tgt.schema_name, '].[',
        src_and_tgt.object_name, ']'
    ) AS item,
    'src x tgt' AS checked_values,
    (
        CASE 
            WHEN COALESCE(src.object_name,'') = COALESCE(tgt.object_name,'')
                THEN 'OK'
            ELSE
                'CHECK ERROR'
        END
    ) AS status
FROM 
    (
        SELECT 
            database_name,
            schema_name,
            object_name,
            object_type_desc
        FROM
            migration_results mr
        GROUP BY 
            database_name,
            schema_name,
            object_name,
            object_type_desc
    ) AS src_and_tgt
LEFT OUTER JOIN
    (
        SELECT 
            source_target,
            server_name,
            database_name,
            schema_name,
            object_name,
            object_type_desc,
            property_int
        FROM
            migration_results mr
        WHERE
            source_target = 'source'
    ) AS src
    ON  src.source_target = 'source'
    AND COALESCE(src.database_name,'') = COALESCE(src_and_tgt.database_name,'')
    AND COALESCE(src.schema_name,'') = COALESCE(src_and_tgt.schema_name,'')
    AND COALESCE(src.object_name,'') = COALESCE(src_and_tgt.object_name,'')
    AND src.object_type_desc = src_and_tgt.object_type_desc
LEFT OUTER JOIN
    (
        SELECT 
            source_target,
            server_name,
            database_name,
            schema_name,
            object_name,
            object_type_desc,
            property_int
        FROM
            migration_results mr
        WHERE
            source_target = 'target'
    ) AS tgt
    ON  tgt.source_target = 'target'
    AND COALESCE(tgt.database_name,'') = COALESCE(src_and_tgt.database_name,'')
    AND COALESCE(tgt.schema_name,'') = COALESCE(src_and_tgt.schema_name,'')
    AND COALESCE(tgt.object_name,'') = COALESCE(src_and_tgt.object_name,'')
    AND tgt.object_type_desc = src_and_tgt.object_type_desc
WHERE 1 = 1 
AND   src.object_type_desc IN ('PK - PRIMARY_KEY_CONSTRAINT', 'F  - FOREIGN_KEY_CONSTRAINT', 'C  - CHECK_CONSTRAINT', 'D  - DEFAULT_CONSTRAINT', 'UQ - UNIQUE_CONSTRAINT')
AND   tgt.object_type_desc IN ('PK - PRIMARY_KEY_CONSTRAINT', 'F  - FOREIGN_KEY_CONSTRAINT', 'C  - CHECK_CONSTRAINT', 'D  - DEFAULT_CONSTRAINT', 'UQ - UNIQUE_CONSTRAINT')
--
UNION ALL
SELECT
    '05 - Procedure, Function and Triggers compare' AS checklist_name,
    src_and_tgt.object_type_desc,
    '[databasename].[schema_name].[object_name]' AS item_type,
    CONCAT(
        '[', src_and_tgt.database_name, '].[',
        src_and_tgt.schema_name, '].[',
        src_and_tgt.object_name, ']'
    ) AS item,
    'src x tgt' AS checked_values,
    (
        CASE 
            WHEN COALESCE(src.object_name,'') = COALESCE(tgt.object_name,'')
                THEN 'OK'
            ELSE
                'CHECK ERROR'
        END
    ) AS status
FROM 
    (
        SELECT 
            database_name,
            schema_name,
            object_name,
            object_type_desc
        FROM
            migration_results mr
        GROUP BY 
            database_name,
            schema_name,
            object_name,
            object_type_desc
    ) AS src_and_tgt
LEFT OUTER JOIN
    (
        SELECT 
            source_target,
            server_name,
            database_name,
            schema_name,
            object_name,
            object_type_desc,
            property_int
        FROM
            migration_results mr
        WHERE
            source_target = 'source'
    ) AS src
    ON  src.source_target = 'source'
    AND COALESCE(src.database_name,'') = COALESCE(src_and_tgt.database_name,'')
    AND COALESCE(src.schema_name,'') = COALESCE(src_and_tgt.schema_name,'')
    AND COALESCE(src.object_name,'') = COALESCE(src_and_tgt.object_name,'')
    AND src.object_type_desc = src_and_tgt.object_type_desc
LEFT OUTER JOIN
    (
        SELECT 
            source_target,
            server_name,
            database_name,
            schema_name,
            object_name,
            object_type_desc,
            property_int
        FROM
            migration_results mr
        WHERE
            source_target = 'target'
    ) AS tgt
    ON  tgt.source_target = 'target'
    AND COALESCE(tgt.database_name,'') = COALESCE(src_and_tgt.database_name,'')
    AND COALESCE(tgt.schema_name,'') = COALESCE(src_and_tgt.schema_name,'')
    AND COALESCE(tgt.object_name,'') = COALESCE(src_and_tgt.object_name,'')
    AND tgt.object_type_desc = src_and_tgt.object_type_desc
WHERE 1 = 1 
AND   src.object_type_desc IN ('P  - SQL_STORED_PROCEDURE', 'FN - SQL_SCALAR_FUNCTION', 'TR - SQL_TRIGGER')
AND   tgt.object_type_desc IN ('P  - SQL_STORED_PROCEDURE', 'FN - SQL_SCALAR_FUNCTION', 'TR - SQL_TRIGGER')
--
UNION ALL
SELECT
    '06 - Indexes compare' AS checklist_name,
    src_and_tgt.object_type_desc,
    '[databasename].[schema_name].[object_name]' AS item_type,
    CONCAT(
        '[', src_and_tgt.database_name, '].[',
        src_and_tgt.schema_name, '].[',
        src_and_tgt.object_name, ']'
    ) AS item,
    CONCAT(
        COALESCE(src.property_varchar,''),
        ' x ',
        COALESCE(tgt.property_varchar,'')
    ) AS checked_values,
    (
        CASE 
            WHEN COALESCE(src.property_varchar,'') = COALESCE(tgt.property_varchar,'')
                THEN 'OK'
            ELSE
                'CHECK ERROR'
        END
    ) AS status
FROM 
    (
        SELECT 
            database_name,
            schema_name,
            object_name,
            object_type_desc
        FROM
            migration_results mr
        GROUP BY 
            database_name,
            schema_name,
            object_name,
            object_type_desc
    ) AS src_and_tgt
LEFT OUTER JOIN
    (
        SELECT 
            source_target,
            server_name,
            database_name,
            schema_name,
            object_name,
            object_type_desc,
            property_varchar
        FROM
            migration_results mr
        WHERE
            source_target = 'source'
    ) AS src
    ON  src.source_target = 'source'
    AND COALESCE(src.database_name,'') = COALESCE(src_and_tgt.database_name,'')
    AND COALESCE(src.schema_name,'') = COALESCE(src_and_tgt.schema_name,'')
    AND COALESCE(src.object_name,'') = COALESCE(src_and_tgt.object_name,'')
    AND src.object_type_desc = src_and_tgt.object_type_desc
LEFT OUTER JOIN
    (
        SELECT 
            source_target,
            server_name,
            database_name,
            schema_name,
            object_name,
            object_type_desc,
            property_varchar
        FROM
            migration_results mr
        WHERE
            source_target = 'target'
    ) AS tgt
    ON  tgt.source_target = 'target'
    AND COALESCE(tgt.database_name,'') = COALESCE(src_and_tgt.database_name,'')
    AND COALESCE(tgt.schema_name,'') = COALESCE(src_and_tgt.schema_name,'')
    AND COALESCE(tgt.object_name,'') = COALESCE(src_and_tgt.object_name,'')
    AND tgt.object_type_desc = src_and_tgt.object_type_desc
WHERE 1 = 1 
AND   src.object_type_desc IN ('1 - INDEX CLUSTERED', '2 - INDEX NONCLUSTERED', '3 - INDEX XML')
AND   tgt.object_type_desc IN ('1 - INDEX CLUSTERED', '2 - INDEX NONCLUSTERED', '3 - INDEX XML')
--
UNION ALL
SELECT
    '07 - Server Properties compare' AS checklist_name,
    src_and_tgt.object_type_desc,
    '[databasename].[schema_name].[object_name]' AS item_type,
    CONCAT(
        '[', src_and_tgt.database_name, '].[',
        src_and_tgt.schema_name, '].[',
        src_and_tgt.object_name, ']'
    ) AS item,
    CONCAT(
        COALESCE(src.property_varchar,''),
        ' x ',
        COALESCE(tgt.property_varchar,'')
    ) AS checked_values,
    (
        CASE 
            WHEN COALESCE(src.property_varchar,'') = COALESCE(tgt.property_varchar,'')
                THEN 'OK'
            ELSE
                'CHECK ERROR'
        END
    ) AS status
FROM 
    (
        SELECT 
            database_name,
            schema_name,
            object_name,
            object_type_desc
        FROM
            migration_results mr
        GROUP BY 
            database_name,
            schema_name,
            object_name,
            object_type_desc
    ) AS src_and_tgt
LEFT OUTER JOIN
    (
        SELECT 
            source_target,
            server_name,
            database_name,
            schema_name,
            object_name,
            object_type_desc,
            property_varchar
        FROM
            migration_results mr
        WHERE
            source_target = 'source'
    ) AS src
    ON  src.source_target = 'source'
    AND COALESCE(src.database_name,'') = COALESCE(src_and_tgt.database_name,'')
    AND COALESCE(src.schema_name,'') = COALESCE(src_and_tgt.schema_name,'')
    AND COALESCE(src.object_name,'') = COALESCE(src_and_tgt.object_name,'')
    AND src.object_type_desc = src_and_tgt.object_type_desc
LEFT OUTER JOIN
    (
        SELECT 
            source_target,
            server_name,
            database_name,
            schema_name,
            object_name,
            object_type_desc,
            property_varchar
        FROM
            migration_results mr
        WHERE
            source_target = 'target'
    ) AS tgt
    ON  tgt.source_target = 'target'
    AND COALESCE(tgt.database_name,'') = COALESCE(src_and_tgt.database_name,'')
    AND COALESCE(tgt.schema_name,'') = COALESCE(src_and_tgt.schema_name,'')
    AND COALESCE(tgt.object_name,'') = COALESCE(src_and_tgt.object_name,'')
    AND tgt.object_type_desc = src_and_tgt.object_type_desc
WHERE 1 = 1 
AND   src.object_type_desc IN ('SRVPROPS - SERVERPROPERTY()')
AND   tgt.object_type_desc IN ('SRVPROPS - SERVERPROPERTY()')
--
ORDER BY 1, 2, 3, 4
GO
