--
-- script-deploy-src-15-01.sql
--

--
-- Step#01: USE {deploy_database} - Replaced by current deploy database
--
USE {deploy_database}


--
-- Step#02: DROP temporary table if exists
--
BEGIN TRY
    DROP TABLE #temp_objects;
END TRY
BEGIN CATCH
    -- OK!
END CATCH;

--
-- Step#03: RE-CREATE temporary table
--
CREATE TABLE #temp_objects
(
    id               INT           IDENTITY(1,1) PRIMARY KEY,
    server_name      VARCHAR(128),
	database_name    VARCHAR(128),
	schema_name      VARCHAR(128),
	object_name      VARCHAR(128),
	object_type_desc VARCHAR(30),
	create_date      DATETIME,
	modify_date      DATETIME,
	property_int     INT,
	property_varchar VARCHAR(MAX)
);


--
-- Step#04: INSERT into temporary table query sys.objects
--
INSERT INTO #temp_objects
(
    server_name,
	database_name,
	schema_name,
	object_name,
	object_type_desc,
    create_date,
	modify_date,
	property_int,
	property_varchar
)
SELECT
	SUBSTRING(CAST(SERVERPROPERTY('ServerName') AS VARCHAR(128)), 1, 128) AS server_name,
	SUBSTRING(DB_NAME(), 1, 128)  AS database_name,
	SUBSTRING(s.name, 1, 128) AS schema_name,
	SUBSTRING(o.name, 1, 128) AS object_name, 
	SUBSTRING(CONCAT(o.type, ' - ', o.type_desc), 1, 30) AS object_type_desc, 
    o.create_date AS create_date,
	o.modify_date AS modify_date, 
	NULL AS property_int,
	NULL AS property_varchar 
FROM
	sys.objects o
INNER JOIN sys.schemas s ON o.schema_id = s.schema_id
WHERE	1=1
AND		o.type NOT IN 
	(
		-- 'C'   -- CHECK_CONSTRAINT
		-- ,'D'  -- DEFAULT_CONSTRAINT
		-- ,'F'  -- FOREIGN_KEY_CONSTRAINT
		-- ,'FN' -- SQL_SCALAR_FUNCTION
		'IT' -- INTERNAL_TABLE
		-- ,'P'  -- SQL_STORED_PROCEDURE
		-- ,'PK' -- PRIMARY_KEY_CONSTRAINT
		,'S'  -- SYSTEM_TABLE
		-- ,'SQ' -- SERVICE_QUEUE
		-- ,'U'  -- USER_TABLE
		-- ,'V'  -- VIEW
	)
;


--
-- Step#05: INSERT into temporary table query indexes
--
INSERT INTO #temp_objects
(
    server_name,
	database_name,
	schema_name,
	object_name,
	object_type_desc,
    create_date,
	modify_date,
	property_int,
	property_varchar
)
SELECT
	SUBSTRING(CAST(SERVERPROPERTY('ServerName') AS VARCHAR(128)), 1, 128) AS server_name,
	SUBSTRING(DB_NAME(), 1, 128)  AS database_name,
	SUBSTRING(s.name, 1, 128) AS schema_name,
	SUBSTRING(i.name, 1, 128) AS object_name, 
	SUBSTRING(CONCAT(i.type, ' - INDEX ', i.type_desc), 1, 30) AS object_type_desc, 
    NULL AS create_date,
	GETDATE() AS modify_date, 
	NULL AS property_int,
	CONCAT(
		t.name, ' ( ', STRING_AGG(c.name, ', ') WITHIN GROUP (ORDER BY ic.key_ordinal), ' )'
	) AS property_varchar
FROM
    sys.tables t
	INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
    INNER JOIN sys.indexes i ON t.object_id = i.object_id
    INNER JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
    INNER JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
GROUP BY
	s.name,
    t.name,
    i.name,
	i.type,
    i.type_desc
ORDER BY
	s.name,
    t.name,
    i.name;


--
-- Step#06: INSERT into temporary table query de server properties
--
INSERT INTO #temp_objects
(
    server_name,
	database_name,
	schema_name,
	object_name,
	object_type_desc,
    create_date,
	modify_date,
	property_int,
	property_varchar
)
SELECT
	SUBSTRING(CAST(SERVERPROPERTY('ServerName') AS VARCHAR(128)), 1, 128) AS server_name,
	NULL AS database_name,
	NULL AS schema_name,
	NULL AS object_name, 
	'SRVPROPS - SERVERPROPERTY()' AS object_type_desc, 
    GETDATE() AS create_date,
	GETDATE() AS modify_date, 
	NULL AS property_int,
	SUBSTRING(CONCAT(
		'Collation=', CAST(SERVERPROPERTY('Collation') AS VARCHAR(128)),
		', CollationId=', CAST(SERVERPROPERTY('CollationId') AS VARCHAR(128)),
		', InstanceName=', CAST(SERVERPROPERTY('InstanceName') AS VARCHAR(128)),
		', MachineName=', CAST(SERVERPROPERTY('MachineName') AS VARCHAR(128)),
		', Processors=', CAST(SERVERPROPERTY('Processors') AS VARCHAR(128)),
		', SqlCharSet=', CAST(SERVERPROPERTY('SqlCharSet') AS VARCHAR(128)),
		', SqlCharSetName=', CAST(SERVERPROPERTY('SqlCharSetName') AS VARCHAR(128)),
		', SqlVersion=', CAST(SERVERPROPERTY('SqlVersion') AS VARCHAR(128)),
		''
	),1,8000) AS property_varchar 
;

--
-- Step#07: INSERT into temporary table query database users
--
INSERT INTO #temp_objects
(
    server_name,
	database_name,
	schema_name,
	object_name,
	object_type_desc,
    create_date,
	modify_date,
	property_int,
	property_varchar
)
SELECT
	SUBSTRING(CAST(SERVERPROPERTY('ServerName') AS VARCHAR(128)), 1, 128) AS server_name,
	SUBSTRING(DB_NAME(), 1, 128)  AS database_name,
	NULL AS schema_name,
	SUBSTRING(dp.name, 1, 128) AS object_name, 
	SUBSTRING(CONCAT(dp.type, ' - ', dp.type_desc), 1, 30) AS object_type_desc, 
	dp.create_date AS create_date, 
	dp.modify_date AS modify_date, 
	NULL AS property_int,
	SUBSTRING(CONCAT(
		'principal_id=', CAST(dp.principal_id AS VARCHAR(30)),
		', authentication_type_desc=', dp.authentication_type_desc,
		''
	),1,8000) AS property_varchar
FROM	sys.database_principals dp
;

--
-- Step#08: INSERT into temporary table query server logins
--
INSERT INTO #temp_objects
(
    server_name,
	database_name,
	schema_name,
	object_name,
	object_type_desc,
    create_date,
	modify_date,
	property_int,
	property_varchar
)
SELECT
	SUBSTRING(CAST(SERVERPROPERTY('ServerName') AS VARCHAR(128)), 1, 128) AS server_name,
	NULL AS database_name,
	NULL AS schema_name,
	SUBSTRING(sp.name, 1, 128) AS object_name, 
	SUBSTRING(CONCAT(sp.type, ' - ', sp.type_desc), 1, 30) AS object_type_desc, 
	sp.create_date AS create_date, 
	sp.modify_date AS modify_date, 
	NULL AS property_int,
	SUBSTRING(CONCAT(
		'principal_id=', CAST(sp.principal_id AS VARCHAR(30)),
		', is_disabled=', CAST(sp.is_disabled AS VARCHAR(30)),
		''
	),1,8000) AS property_varchar
FROM	sys.server_principals sp
;

--
-- Step#09: UPDATE temporary table SET table count(*)
--
BEGIN
DECLARE @schema_name NVARCHAR(128);
DECLARE @object_name NVARCHAR(128);
DECLARE @count INT;
DECLARE @sql NVARCHAR(MAX);

DECLARE cur_objects CURSOR FOR
SELECT schema_name, object_name
FROM #temp_objects
WHERE object_type_desc LIKE 'U  - USER_TABLE';

OPEN cur_objects;

FETCH NEXT FROM cur_objects INTO @schema_name, @object_name;

WHILE @@FETCH_STATUS = 0
BEGIN
	--
	SET @sql = 'SELECT @count = COUNT(*) FROM ' + QUOTENAME(@schema_name) + '.' + QUOTENAME(@object_name);
	EXEC sp_executesql @sql, N'@count INT OUTPUT', @count = @count OUTPUT;
    PRINT 'table_name: ' + @schema_name + '.' + @object_name + ', record_count: ' + CAST(@count AS VARCHAR(10)) + ', @count: ' + CAST(@count AS VARCHAR(10));
	--
	SET @sql = 'UPDATE #temp_objects SET property_int = ' + CAST(@count AS VARCHAR(10)) + ' WHERE schema_name = ''' + @schema_name + ''' AND object_name = ''' + @object_name + ''' ' ;
    PRINT @sql
	EXEC sp_executesql @sql;
	--
	FETCH NEXT FROM cur_objects INTO @schema_name, @object_name;
END;

CLOSE cur_objects;
DEALLOCATE cur_objects;
END;


--
-- Step#10: QUERY temporary table
--
SELECT
    server_name,
	database_name,
	schema_name,
	object_name,
	object_type_desc,
	CONVERT(VARCHAR(19), create_date, 120),
	CONVERT(VARCHAR(19), modify_date, 120),
	property_int,
	property_varchar
FROM
    #temp_objects
ORDER BY
	server_name, database_name, schema_name, object_name, object_type_desc
;

