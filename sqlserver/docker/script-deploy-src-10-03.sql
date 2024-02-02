--
-- script-deploy-src-10-03.sql
--

USE labdb
GO


CREATE OR ALTER VIEW vw_laboratory_2
AS  
SELECT
      [id]
      ,[new_column]
FROM tbl_laboratory