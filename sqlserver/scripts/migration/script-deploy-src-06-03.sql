--
-- script-deploy-src-06-03.sql
--

USE labdb
GO


CREATE OR ALTER VIEW vw_laboratory
AS  
SELECT
      [id]
      -- NEW COLUMN
      ,[new_column]
      --
      ,[key_info]
      ,[data_info]
      ,[bigint_info]
      ,[numeric_info]
      ,[bit_info]
      ,[smallint_info]
      ,[decimal_info]
      ,[smallmoney_info]
      ,[int_info]
      ,[tinyint_info]
      ,[money_info]
      ,[float_info]
      ,[real_info]
      ,[date_info]
      ,[datetimeoffset_info]
      ,[datetime2_info]
      ,[smalldatetime_info]
      ,[datetime_info]
      ,[time_info]
      ,[char_info]
      ,[varchar_info]
      ,[text_info]
      ,[nchar_info]
      ,[nvarchar_info]
      ,[ntext_info]
      ,[created_at]
      ,[updated_at]
      ,[created_by]
      ,[updatet_by]
      ,[is_removed]
FROM tbl_laboratory