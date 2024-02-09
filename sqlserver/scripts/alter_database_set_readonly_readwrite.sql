-- ----------------------------------------------------------------------------
-- filename: alter_database_set_readonly_readwrite.sql
-- purpose : Alterar o modo da base de dados para [não/sim] aceitar modificação [READONLY / READWRITE]
-- revision: 2024-02-09 18:30 - josemarsilva - 
-- remarks : 
-- ----------------------------------------------------------------------------

--
-- READ_ONLY: Only read transactions are allowed
--
ALTER DATABASE [Northwind] SET READ_ONLY ;
--
-- READ_ONLY: Any read or write transactions are allowed
--
ALTER DATABASE [Northwind] SET READ_WRITE ;
