--
-- script-deploy-src-08-01.sql
--

USE labdb
GO

-- Cria logins para os usuários
CREATE LOGIN user_6 WITH PASSWORD = 'UserPassword@5';

-- Cria usuários para os logins
CREATE USER user_6 FOR LOGIN user_6;

-- Concede permissões para a base de dados
USE labdb;
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE TO user_6;

GO
