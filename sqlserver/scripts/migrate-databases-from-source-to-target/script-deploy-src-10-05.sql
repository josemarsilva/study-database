--
-- script-deploy-src-10-05.sql
--

USE labdb
GO

CREATE OR ALTER FUNCTION new_function()
RETURNS INT
AS
BEGIN
	RETURN 0
END;

