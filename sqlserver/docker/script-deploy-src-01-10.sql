--
-- script-deploy-src-01-10.sql
--

USE labdb
GO

CREATE TABLE tbl_deploy (
    id                  INT            NOT NULL , 
	name                NVARCHAR(30)   NOT NULL,
	description         NVARCHAR(100)  NOT NULL,
	details             NVARCHAR(4000),
    status              NVARCHAR(10),
    CONSTRAINT pk_deploy PRIMARY KEY CLUSTERED 
        (
            id ASC
        )
);
GO



