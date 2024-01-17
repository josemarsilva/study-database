-- ----------------------------------------------------------------------------
-- filename: dbcc_freeproccache.sql
-- purpose : Refresh
-- revision: 2023-12-18 15:25 - josemarsilva - 
-- remarks : 
--          * https://learn.microsoft.com/pt-br/sql/t-sql/database-console-commands/dbcc-freeproccache-transact-sql?view=sql-server-ver16
-- ----------------------------------------------------------------------------

DECLARE @sql_handle VARBINARY(64) = 0x060006001ECA270EC0215D05000000000000000000000000;
DBCC FREEPROCCACHE ();
GO