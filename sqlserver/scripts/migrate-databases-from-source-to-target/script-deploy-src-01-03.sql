--
-- script-deploy-src-01-03.sql
--

USE labdb
GO

--
INSERT INTO tbl_laboratory 
(
    -- id
    -- Business Columns
    key_info,
    data_info,
    -- Exact numerics
    bigint_info,
    numeric_info,
    bit_info,
    smallint_info,
    decimal_info,
    smallmoney_info,
    int_info,
    tinyint_info,
    money_info,
    -- Approximate numerics
    float_info,
    real_info,
    -- Date and time
    date_info,
    datetimeoffset_info,
    datetime2_info,
    smalldatetime_info,
    datetime_info,
    time_info,
    -- Character strings
    char_info,
    varchar_info,
    text_info,
    -- Unicode character strings
    nchar_info,
    nvarchar_info,
    ntext_info
    -- DML record control
    -- created_at
    -- updated_at
    -- created_by
    -- updatet_by
    -- is_removed
)
VALUES
(
                                                  -- id
    -- Business Columns                           
    'key_info_min',                               -- key_info
    'data_info_min',                              -- data_info
    -- Exact numerics                             
    -9223372036854775808,                         -- bigint_info
    00000,                                        -- numeric_info
    0,                                            -- bit_info
    -32768,                                       -- smallint_info
    -9999999999999.99,                            -- decimal_info
    -214748.3648,                                 -- smallmoney_info
    -2147483648,                                  -- int_info
    0,                                            -- tinyint_info
    -922337203685477.5808,                        -- money_info
    -- Approximate numerics                       
    -1.79E+308,                                   -- float_info
    -3.40E+38,                                    -- real_info
    -- Date and time                              
    CAST('0001-01-01' AS DATE),                   -- date_info
    CAST('0001-01-01' AS DATETIMEOFFSET),         -- datetimeoffset_info
    CAST('0001-01-01' AS DATETIME2),              -- datetime2_info
    CAST('1900-01-01 00:00:00' AS SMALLDATETIME), -- smalldatetime_info
    CAST('1753-01-01' AS DATETIME),               -- datetime_info
    CAST('00:00:00.0000000' AS TIME),             -- time_info
    -- Character strings                          
    'A',                                          -- char_info
    'ABCDEFGHIJKLMNOPQRSTUWYZ',                   -- varchar_info
    'ABCDEFGHIJKLMNOPQRSTUWYZ',                   -- text_info
    -- Unicode character strings                  
    'é',                                          -- nchar_info
    'ÁÉÍÓÚáéíóúÃãÕõÂâôôÀàç',                      -- nvarchar_info
    'ÁÉÍÓÚáéíóúÃãÕõÂâôôÀàç'                       -- ntext_info
    -- DML record control                         
                                                  -- created_at
                                                  -- updated_at
                                                  -- created_by
                                                  -- updatet_by
                                                  -- is_removed
)
GO

--
INSERT INTO tbl_laboratory 
(
    -- id
    -- Business Columns
    key_info,
    data_info,
    -- Exact numerics
    bigint_info,
    numeric_info,
    bit_info,
    smallint_info,
    decimal_info,
    smallmoney_info,
    int_info,
    tinyint_info,
    money_info,
    -- Approximate numerics
    float_info,
    real_info,
    -- Date and time
    date_info,
    datetimeoffset_info,
    datetime2_info,
    smalldatetime_info,
    datetime_info,
    time_info,
    -- Character strings
    char_info,
    varchar_info,
    text_info,
    -- Unicode character strings
    nchar_info,
    nvarchar_info,
    ntext_info
    -- DML record control
    -- created_at
    -- updated_at
    -- created_by
    -- updatet_by
    -- is_removed
)
VALUES
(
                                                  -- id
    -- Business Columns                           
    'key_info_max',                               -- key_info
    'data_info_max',                              -- data_info
    -- Exact numerics                             
    9223372036854775807,                          -- bigint_info
    99999,                                        -- numeric_info
    1,                                            -- bit_info
    32767,                                        -- smallint_info
    9999999999999.99,                             -- decimal_info
    214748.3647,                                  -- smallmoney_info
    2147483647,                                   -- int_info
    0,                                            -- tinyint_info
    922337203685477.5807,                         -- money_info
    -- Approximate numerics                       
    2.23E-308,                                    -- float_info
    3.40E+38,                                     -- real_info
    -- Date and time                              
    CAST('9999-12-31' AS DATE),                   -- date_info
    CAST('9999-12-31' AS DATETIMEOFFSET),         -- datetimeoffset_info
    CAST('9999-12-31' AS DATETIME2),              -- datetime2_info
    CAST('2007-05-09 23:59:59' AS SMALLDATETIME), -- smalldatetime_info
    CAST('9999-12-31' AS DATETIME),               -- datetime_info
    CAST('23:59:59.9999999' AS TIME),             -- time_info
    -- Character strings                    
    'A',                                          -- char_info
    'ABCDEFGHIJKLMNOPQRSTUWYZ',                   -- varchar_info
    'ABCDEFGHIJKLMNOPQRSTUWYZ',                   -- text_info
    -- Unicode character strings                  
    'é',                                          -- nchar_info
    'ÁÉÍÓÚáéíóúÃãÕõÂâôôÀàç',                      -- nvarchar_info
    'ÁÉÍÓÚáéíóúÃãÕõÂâôôÀàç'                       -- ntext_info
    -- DML record control                         
                                                  -- created_at
                                                  -- updated_at
                                                  -- created_by
                                                  -- updatet_by
                                                  -- is_removed
)
GO

--
INSERT INTO tbl_laboratory 
(
    -- id
    -- Business Columns
    key_info,
    data_info,
    -- Exact numerics
    bigint_info,
    numeric_info,
    bit_info,
    smallint_info,
    decimal_info,
    smallmoney_info,
    int_info,
    tinyint_info,
    money_info,
    -- Approximate numerics
    float_info,
    real_info,
    -- Date and time
    date_info,
    datetimeoffset_info,
    datetime2_info,
    smalldatetime_info,
    datetime_info,
    time_info,
    -- Character strings
    char_info,
    varchar_info,
    text_info,
    -- Unicode character strings
    nchar_info,
    nvarchar_info,
    ntext_info
    -- DML record control
    -- created_at
    -- updated_at
    -- created_by
    -- updatet_by
    -- is_removed
)
VALUES
(
                                                  -- id
    -- Business Columns                           
    'key_info',                                   -- key_info
    'data_info',                                  -- data_info
    -- Exact numerics                             
    10000,                                        -- bigint_info
    10000,                                        -- numeric_info
    1,                                            -- bit_info
    10000,                                        -- smallint_info
    10000.00,                                     -- decimal_info
    10000.00,                                     -- smallmoney_info
    10000,                                        -- int_info
    0,                                            -- tinyint_info
    10000.00,                                     -- money_info
    -- Approximate numerics                       
    10000,                                        -- float_info
    10000,                                        -- real_info
    -- Date and time                              
    CAST('1969-04-25' AS DATE),                   -- date_info
    CAST('1969-04-25' AS DATETIMEOFFSET),         -- datetimeoffset_info
    CAST('1969-04-25' AS DATETIME2),              -- datetime2_info
    CAST('1969-04-25 19:45:00' AS SMALLDATETIME), -- smalldatetime_info
    CAST('1969-04-25' AS DATETIME),               -- datetime_info
    CAST('19:45:00.0000000' AS TIME),             -- time_info
    -- Character strings                          
    'A',                                          -- char_info
    'ABCDEFGHIJKLMNOPQRSTUWYZ',                   -- varchar_info
    'ABCDEFGHIJKLMNOPQRSTUWYZ',                   -- text_info
    -- Unicode character strings                  
    'é',                                          -- nchar_info
    'ÁÉÍÓÚáéíóúÃãÕõÂâôôÀàç',                      -- nvarchar_info
    'ÁÉÍÓÚáéíóúÃãÕõÂâôôÀàç'                       -- ntext_info
    -- DML record control                         
                                                  -- created_at
                                                  -- updated_at
                                                  -- created_by
                                                  -- updatet_by
                                                  -- is_removed
)
GO

