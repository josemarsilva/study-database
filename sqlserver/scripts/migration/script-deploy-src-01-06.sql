--
-- script-deploy-src-01-06.sql
--

USE labdb
GO

CREATE OR ALTER PROCEDURE insert_duplicate_n_rows
	@id_template INT = 3,
	@n_rows      INT = 1000
AS
BEGIN
    DECLARE @i INT = 1;
    DECLARE @key_info_sufix INT = 1;
	
	SELECT @key_info_sufix = COALESCE(MAX(id),0) FROM tbl_laboratory;

    WHILE @i <= @n_rows
    BEGIN
		--
        INSERT INTO tbl_laboratory (
			key_info,
			data_info,
			bigint_info,
			numeric_info,
			bit_info,
			smallint_info,
			decimal_info,
			smallmoney_info,
			int_info,
			tinyint_info,
			money_info,
			float_info,
			real_info,
			date_info,
			datetimeoffset_info,
			datetime2_info,
			smalldatetime_info,
			datetime_info,
			time_info,
			char_info,
			varchar_info,
			text_info,
			nchar_info,
			nvarchar_info,
			ntext_info
		)
        SELECT 
			CONCAT(key_info, '_', CAST((@key_info_sufix + @i) AS VARCHAR(20))) AS key_info,
			data_info,
			bigint_info,
			numeric_info,
			bit_info,
			smallint_info,
			decimal_info,
			smallmoney_info,
			int_info,
			tinyint_info,
			money_info,
			float_info,
			real_info,
			date_info,
			datetimeoffset_info,
			datetime2_info,
			smalldatetime_info,
			datetime_info,
			time_info,
			char_info,
			varchar_info,
			text_info,
			nchar_info,
			nvarchar_info,
			ntext_info
        FROM
			tbl_laboratory
        WHERE id = 1;
		--
        SET @i = @i + 1;
		--
    END;
END;

