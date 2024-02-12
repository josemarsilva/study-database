--
-- script-deploy-tgt-99-03.sql
--

CREATE DATABASE {deploy_database}
GO

USE {deploy_database}
GO

CREATE TABLE tbl_test (
    id                  INT              NOT NULL IDENTITY(1,1), 
    key_info            NVARCHAR(30)     NOT NULL,
    CONSTRAINT pk_test PRIMARY KEY CLUSTERED 
        (
            id ASC
        )
);
GO

