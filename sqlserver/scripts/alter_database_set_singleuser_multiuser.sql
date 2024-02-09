-- ----------------------------------------------------------------------------
-- filename: alter_database_set_singleuser_multiuser
-- purpose : Alterar o modo da base de dados para aceitar conexões SINGLE_USER ou MULTI_USER
-- revision: 2024-02-09 18:30 - josemarsilva - 
-- remarks : 
-- ----------------------------------------------------------------------------

--
-- SINGLE_USER: Only you that is connect can use
--
ALTER DATABASE [Northwind] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

--
-- MULTI_USER: Everybody connects
--
ALTER DATABASE [Northwind] SET MULTI_USER WITH ROLLBACK IMMEDIATE;