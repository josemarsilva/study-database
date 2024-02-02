--
-- script-deploy-src-01-07.sql
--

USE labdb
GO

EXEC dbo.insert_duplicate_n_rows 3, 1000
