--
-- script-deploy-src-01-13.sql
--

CREATE DATABASE labdb3
GO

USE labdb3
GO

CREATE TABLE tbl_test_3 (
    id                  INT              NOT NULL IDENTITY(1,1), 
    key_info            NVARCHAR(30)     NOT NULL,
    CONSTRAINT pk_test_2 PRIMARY KEY CLUSTERED 
        (
            id ASC
        )
);
GO

