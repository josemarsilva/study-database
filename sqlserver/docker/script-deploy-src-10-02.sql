--
-- script-deploy-src-10-02.sql
--

USE labdb
GO

CREATE OR ALTER TRIGGER trg_laboratory_a_i
ON tbl_laboratory
AFTER INSERT
AS
BEGIN
    PRINT 'trg_laboratory_a_i'
END;

