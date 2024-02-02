--
-- script-deploy-src-01-02.sql
--

USE labdb
GO

CREATE TABLE tbl_laboratory (
    id                  BIGINT           NOT NULL IDENTITY(1,1), 
    key_info            NVARCHAR(30)     NOT NULL,
    data_info           NVARCHAR(MAX),
    -- Exact numerics
    bigint_info         BIGINT,
    numeric_info        NUMERIC(5),
    bit_info            BIT   ,
    smallint_info       SMALLINT,
    decimal_info        DECIMAL(15,2),
    smallmoney_info     SMALLMONEY,
    int_info            INT   ,
    tinyint_info        TINYINT,
    money_info          MONEY ,
    -- Approximate numerics
    float_info          FLOAT ,
    real_info           REAL  ,
    -- Date and time
    date_info           DATE,
    datetimeoffset_info DATETIMEOFFSET,
    datetime2_info      DATETIME2,
    smalldatetime_info  SMALLDATETIME,
    datetime_info       DATETIME,
    time_info           TIME,
    -- Character strings
    char_info           CHAR(1),
    varchar_info        VARCHAR(30),
    text_info           TEXT,
    -- Unicode character strings
    nchar_info          NCHAR(1),
    nvarchar_info       NVARCHAR(30),
    ntext_info          NTEXT,
    -- DML record control
    created_at     DATETIME      NOT NULL DEFAULT GETDATE(),
    updated_at     DATETIME      NOT NULL DEFAULT GETDATE(),
    created_by     NVARCHAR(100) NOT NULL DEFAULT 'unknown',
    updatet_by     NVARCHAR(100) NOT NULL DEFAULT 'unknown',
    is_removed     BIT           NOT NULL DEFAULT(0),
    CONSTRAINT pk_laboratory PRIMARY KEY CLUSTERED 
        (
            id ASC
        )
);
GO

ALTER TABLE tbl_laboratory ADD CONSTRAINT ak_laboratory UNIQUE (key_info);
GO
