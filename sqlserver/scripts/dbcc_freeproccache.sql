-- ----------------------------------------------------------------------------
-- filename : dbcc_freeproccache.sql
-- purpose  : Refresh
-- revision : 2023-12-18 15:25 - josemarsilva@inmetrics.com.br - 
-- reference: https://learn.microsoft.com/pt-br/sql/t-sql/database-console-commands/dbcc-freeproccache-transact-sql?view=sql-server-ver16
-- ----------------------------------------------------------------------------

DBCC FREEPROCCACHE (0x060006001ECA270EC0215D05000000000000000000000000);
GO