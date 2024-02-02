--
-- script-deploy-src-01-12.sql
--

CREATE DATABASE labdb2
GO

USE labdb2
GO

CREATE TABLE tbl_test_2 (
    id                  INT              NOT NULL IDENTITY(1,1), 
    key_info            NVARCHAR(30)     NOT NULL,
    CONSTRAINT pk_test_2 PRIMARY KEY CLUSTERED 
        (
            id ASC
        )
);
GO

