--
-- script-deploy-tgt-02-01.sql
--

USE labdb
GO


--
--
--
INSERT INTO [labdb].[dbo].[tbl_deploy] 
	( id, name, description, details )
SELECT
	101 AS id,
	'table' AS name,
	'Table name "tbl_laboratory" created' AS Description,
	COALESCE(
		(
			SELECT CONCAT('object_id = ', CAST(o.object_id AS VARCHAR(30)), ', type_desc = "', o.type_desc, '"')
			FROM   sys.objects o
			WHERE  name = 'tbl_laboratory' AND type = 'U' /* USER_TABLE */
		),
		'ERROR: Table name does not exist'
	) AS Details;
GO

INSERT INTO [labdb].[dbo].[tbl_deploy] 
	( id, name, description, details )
SELECT
	102 AS id,
	'view' AS name,
	'View name "vw_laboratory" created' AS Description,
	COALESCE(
		(
			SELECT CONCAT('object_id = ', CAST(o.object_id AS VARCHAR(30)), ', type_desc = "', o.type_desc, '"')
			FROM   sys.objects o
			WHERE  name = 'vw_laboratory' AND type = 'V' /* VIEW */
		),
		'ERROR: View name does not exist'
	) AS Details;
GO

INSERT INTO [labdb].[dbo].[tbl_deploy] 
	( id, name, description, details )
SELECT
	103 AS id,
	'trigger' AS name,
	'Trigger name "trg_laboratory_b_u" created' AS Description,
	COALESCE(
		(
			SELECT CONCAT('object_id = ', CAST(o.object_id AS VARCHAR(30)), ', type_desc = "', o.type_desc, '"')
			FROM   sys.objects o
			WHERE  name = 'trg_laboratory_b_u' AND type = 'TR' /* SQL_TRIGGER */
		),
		'ERROR: Trigger name does not exist'
	) AS Details;
GO

INSERT INTO [labdb].[dbo].[tbl_deploy] 
	( id, name, description, details )
SELECT
	104 AS id,
	'procedure' AS name,
	'Procedure name "insert_duplicate_n_rows" created' AS Description,
	COALESCE(
		(
			SELECT CONCAT('object_id = ', CAST(o.object_id AS VARCHAR(30)), ', type_desc = "', o.type_desc, '"')
			FROM   sys.objects o
			WHERE  name = 'insert_duplicate_n_rows' AND type = 'P' /* SQL_STORED_PROCEDURE */
		),
		'ERROR: Procedure name does not exist'
	) AS Details;
GO

INSERT INTO [labdb].[dbo].[tbl_deploy] 
	( id, name, description, details )
SELECT
	105 AS id,
	'function' AS name,
	'Function name "id_for_max_int_info" created' AS Description,
	COALESCE(
		(
			SELECT CONCAT('object_id = ', CAST(o.object_id AS VARCHAR(30)), ', type_desc = "', o.type_desc, '"')
			FROM   sys.objects o
			WHERE  name = 'id_for_max_int_info' AND type = 'FN' /* SQL_SCALAR_FUNCTION */
		),
		'ERROR: Procedure name does not exist'
	) AS Details;
GO

INSERT INTO [labdb].[dbo].[tbl_deploy] 
	( id, name, description, details )
SELECT
	106 AS id,
	'database user' AS name,
	'Database user "user_1" created' AS Description,
	COALESCE(
		(
			SELECT CONCAT('principal_id = ', CAST(dp.principal_id AS VARCHAR(30)), ', type_desc = "', dp.type_desc, '"')
			FROM   sys.database_principals dp
			WHERE  name = 'user_1' AND type = 'S' /* SQL_USER */
		),
		'ERROR: Database user does not exist'
	) AS Details;
GO

INSERT INTO [labdb].[dbo].[tbl_deploy] 
	( id, name, description, details )
SELECT
	107 AS id,
	'database user' AS name,
	'Database user "user_2" created' AS Description,
	COALESCE(
		(
			SELECT CONCAT('principal_id = ', CAST(dp.principal_id AS VARCHAR(30)), ', type_desc = "', dp.type_desc, '"')
			FROM   sys.database_principals dp
			WHERE  name = 'user_2' AND type = 'S' /* SQL_USER */
		),
		'ERROR: Database user does not exist'
	) AS Details;
GO

INSERT INTO [labdb].[dbo].[tbl_deploy] 
	( id, name, description, details )
SELECT
	108 AS id,
	'database user' AS name,
	'Database user "user_3" created' AS Description,
	COALESCE(
		(
			SELECT CONCAT('principal_id = ', CAST(dp.principal_id AS VARCHAR(30)), ', type_desc = "', dp.type_desc, '"')
			FROM   sys.database_principals dp
			WHERE  name = 'user_3' AND type = 'S' /* SQL_USER */
		),
		'ERROR: Database user does not exist'
	) AS Details
--
UNION ALL
SELECT
	109 AS id,
	'database user' AS name,
	'Database user "user_4" created' AS Description,
	COALESCE(
		(
			SELECT CONCAT('principal_id = ', CAST(dp.principal_id AS VARCHAR(30)), ', type_desc = "', dp.type_desc, '"')
			FROM   sys.database_principals dp
			WHERE  name = 'user_4' AND type = 'S' /* SQL_USER */
		),
		'ERROR: Database user does not exist'
	) AS Details;
GO

INSERT INTO [labdb].[dbo].[tbl_deploy] 
	( id, name, description, details )
SELECT
	110 AS id,
	'database user' AS name,
	'Database user "user_5" created' AS Description,
	COALESCE(
		(
			SELECT CONCAT('principal_id = ', CAST(dp.principal_id AS VARCHAR(30)), ', type_desc = "', dp.type_desc, '"')
			FROM   sys.database_principals dp
			WHERE  name = 'user_5' AND type = 'S' /* SQL_USER */
		),
		'ERROR: Database user does not exist'
	) AS Details;
GO

INSERT INTO [labdb].[dbo].[tbl_deploy] 
	( id, name, description, details )
SELECT
	111 AS id,
	'server login' AS name,
	'Server login "user_1" created' AS Description,
	COALESCE(
		(
			SELECT CONCAT('principal_id = ', CAST(sp.principal_id AS VARCHAR(30)), ', type_desc = "', sp.type_desc, '"')
			FROM   sys.server_principals sp
			WHERE  name = 'user_1' AND type = 'S' /* SQL_USER */
		),
		'ERROR: Server login does not exist'
	) AS Details;
GO

INSERT INTO [labdb].[dbo].[tbl_deploy] 
	( id, name, description, details )
SELECT
	112 AS id,
	'server login' AS name,
	'Server login "user_2" created' AS Description,
	COALESCE(
		(
			SELECT CONCAT('principal_id = ', CAST(sp.principal_id AS VARCHAR(30)), ', type_desc = "', sp.type_desc, '"')
			FROM   sys.server_principals sp
			WHERE  name = 'user_2' AND type = 'S' /* SQL_USER */
		),
		'ERROR: Server login does not exist'
	) AS Details;
GO

INSERT INTO [labdb].[dbo].[tbl_deploy] 
	( id, name, description, details )
SELECT
	113 AS id,
	'server login' AS name,
	'Server login "user_3" created' AS Description,
	COALESCE(
		(
			SELECT CONCAT('principal_id = ', CAST(sp.principal_id AS VARCHAR(30)), ', type_desc = "', sp.type_desc, '"')
			FROM   sys.server_principals sp
			WHERE  name = 'user_3' AND type = 'S' /* SQL_USER */
		),
		'ERROR: Server login does not exist'
	) AS Details;
GO

INSERT INTO [labdb].[dbo].[tbl_deploy] 
	( id, name, description, details )
SELECT
	114 AS id,
	'server login' AS name,
	'Server login "user_4" created' AS Description,
	COALESCE(
		(
			SELECT CONCAT('principal_id = ', CAST(sp.principal_id AS VARCHAR(30)), ', type_desc = "', sp.type_desc, '"')
			FROM   sys.server_principals sp
			WHERE  name = 'user_4' AND type = 'S' /* SQL_USER */
		),
		'ERROR: Server login does not exist'
	) AS Details;
GO

INSERT INTO [labdb].[dbo].[tbl_deploy] 
	( id, name, description, details )
SELECT
	115 AS id,
	'server login' AS name,
	'Server login "user_5" created' AS Description,
	COALESCE(
		(
			SELECT CONCAT('principal_id = ', CAST(sp.principal_id AS VARCHAR(30)), ', type_desc = "', sp.type_desc, '"')
			FROM   sys.server_principals sp
			WHERE  name = 'user_5' AND type = 'S' /* SQL_USER */
		),
		'ERROR: Server login does not exist'
	) AS Details;
GO

INSERT INTO [labdb].[dbo].[tbl_deploy] 
	( id, name, description, details )
SELECT
	116 AS id,
	'table rows' AS name,
	'Table rows counter "tbl_laboratory" created' AS Description,
	COALESCE(
		(
			SELECT CONCAT('table name = "tbl_laboratory", count = ', COUNT(1) )
			FROM   dbo.tbl_laboratory lab
			HAVING COUNT(1) = 1003 
		),
		'ERROR: Table rows counter for "tbl_laboratory" is not 1003 '
	) AS Details;
GO


--
--
--
UPDATE tbl_deploy SET status = 'ERROR'   WHERE status IS NULL AND details LIKE 'ERROR%'
GO

UPDATE tbl_deploy SET status = 'SUCCESS' WHERE status IS NULL
GO

--
--
--
SELECT * FROM tbl_deploy ORDER BY id
GO
