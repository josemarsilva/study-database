--
-- script-deploy-src-04-02.sql
--

USE labdb
GO

INSERT INTO tbl_deploy 
	( id, name, description, details )
SELECT
	19 AS id,
	'table rows' AS name,
	'Table rows counter "tbl_laboratory" created' AS Description,
	COALESCE(
		(
			SELECT CONCAT('table name = "tbl_laboratory", count = ', COUNT(1) )
			FROM   dbo.tbl_laboratory lab
			HAVING COUNT(1) = 2003 
		),
		'ERROR: Table rows counter for "tbl_laboratory" is not 2003 '
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
