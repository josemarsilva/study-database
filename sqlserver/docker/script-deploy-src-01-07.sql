--
-- script-deploy-src-01-07.sql
--

USE labdb
GO

CREATE OR ALTER FUNCTION id_for_max_int_info()
RETURNS INT
AS
BEGIN
    DECLARE @id INT = NULL;
	SELECT @id = MAX(id)
	FROM tbl_laboratory
	WHERE int_info = ( SELECT MAX(int_info) FROM tbl_laboratory );
	--
	RETURN @id
	--
END;

