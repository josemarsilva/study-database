--
-- script-deploy-src-01-08.sql
--

USE labdb
GO

-- Cria logins para os usuários
CREATE LOGIN user_1 WITH PASSWORD = 'UserPassword@1';
CREATE LOGIN user_2 WITH PASSWORD = 'UserPassword@2';
CREATE LOGIN user_3 WITH PASSWORD = 'UserPassword@3';
CREATE LOGIN user_4 WITH PASSWORD = 'UserPassword@4';
CREATE LOGIN user_5 WITH PASSWORD = 'UserPassword@5';

-- Cria usuários para os logins
CREATE USER user_1 FOR LOGIN user_1;
CREATE USER user_2 FOR LOGIN user_2;
CREATE USER user_3 FOR LOGIN user_3;
CREATE USER user_4 FOR LOGIN user_4;
CREATE USER user_5 FOR LOGIN user_5;

-- Concede permissões para a base de dados
USE labdb;
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE TO user_1;
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE TO user_2;
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE TO user_3;
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE TO user_4;
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE TO user_5;

GO
