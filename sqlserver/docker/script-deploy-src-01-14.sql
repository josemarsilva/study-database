--
-- script-deploy-src-01-14.sql
--

USE labdb2
GO

INSERT INTO [labdb].[dbo].[tbl_deploy]
	( id, name, description, details )
SELECT
	17 AS id,
	'table' AS name,
	'Table name "tbl_test_2" created' AS Description,
	COALESCE(
		(
			SELECT CONCAT('object_id = ', CAST(o.object_id AS VARCHAR(30)), ', type_desc = "', o.type_desc, '"')
			FROM   sys.objects o
			WHERE  name = 'tbl_test_2' AND type = 'U' /* USER_TABLE */
		),
		'ERROR: Table name does not exist'
	) AS Details;
GO


--
--
--
USE labdb3
GO

INSERT INTO [labdb].[dbo].[tbl_deploy]
	( id, name, description, details )
SELECT
	18 AS id,
	'table' AS name,
	'Table name "tbl_test_3" created' AS Description,
	COALESCE(
		(
			SELECT CONCAT('object_id = ', CAST(o.object_id AS VARCHAR(30)), ', type_desc = "', o.type_desc, '"')
			FROM   sys.objects o
			WHERE  name = 'tbl_test_3' AND type = 'U' /* USER_TABLE */
		),
		'ERROR: Table name does not exist'
	) AS Details;
GO

--
--
--
USE labdb
GO

UPDATE tbl_deploy SET status = 'ERROR'   WHERE status IS NULL AND details LIKE 'ERROR%'
GO

UPDATE tbl_deploy SET status = 'SUCCESS' WHERE status IS NULL
GO

SELECT * FROM tbl_deploy ORDER BY id
GO
