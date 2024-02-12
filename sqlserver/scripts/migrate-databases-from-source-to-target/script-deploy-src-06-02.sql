--
-- script-deploy-src-06-02.sql
--

USE labdb
GO

CREATE OR ALTER TRIGGER trg_laboratory_b_u
ON tbl_laboratory
INSTEAD OF UPDATE
AS
BEGIN
    -- NEW VERSION
    UPDATE tbl_laboratory
    SET 
        key_info            = inserted.key_info,
        data_info           = SUBSTRING(CONCAT(inserted.data_info,'+trg_laboratory_b_u'),1, 1000), 
        bigint_info         = inserted.bigint_info,
        numeric_info        = inserted.numeric_info,
        bit_info            = inserted.bit_info,
        smallint_info       = inserted.smallint_info,
        decimal_info        = inserted.decimal_info,
        smallmoney_info     = inserted.smallmoney_info,
        int_info            = inserted.int_info,
        tinyint_info        = inserted.tinyint_info,
        money_info          = inserted.money_info,
        float_info          = inserted.float_info,
        real_info           = inserted.real_info,
        date_info           = inserted.date_info,
        datetimeoffset_info = inserted.datetimeoffset_info,
        datetime2_info      = inserted.datetime2_info,
        smalldatetime_info  = inserted.smalldatetime_info,
        datetime_info       = inserted.datetime_info,
        time_info           = inserted.time_info,
        char_info           = inserted.char_info,
        varchar_info        = inserted.varchar_info,
        text_info           = inserted.text_info,
        nchar_info          = inserted.nchar_info,
        nvarchar_info       = inserted.nvarchar_info,
        ntext_info          = inserted.ntext_info,
        created_at          = inserted.created_at,
        updated_at          = GETDATE(),
        created_by          = inserted.created_by,
        updatet_by          = 'trg_laboratory_b_u',
        is_removed          = inserted.is_removed
    FROM tbl_laboratory
    INNER JOIN inserted ON tbl_laboratory.id = inserted.id;
END;

