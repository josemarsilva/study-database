-- ----------------------------------------------------------------------------
-- filename: alter_kill_sleeping_sessions.sql
-- purpose : Matar sessoes inativas a mais de 24H, exceto uma @@spid
-- revision: 2024-02-09 18:30 - josemarsilva - 
-- remarks : 
-- ----------------------------------------------------------------------------

DECLARE @user INT
DECLARE CursorSessoes CURSOR FAST_FORWARD FOR
SELECT [SPID] FROM [master].dbo.sysprocesses (NOLOCK)
WHERE
    spid > 50
    AND [status] = 'sleeping'
    AND DATEDIFF(HOUR, last_batch, GETDATE()) >= 24
    AND spid <> @@spid

OPEN CursorSessoes
FETCH NEXT FROM CursorSessoes INTO @user

WHILE (@@FETCH_STATUS = 0)
BEGIN
    PRINT 'Killing ' + CONVERT(VARCHAR, @user)
    EXEC ('KILL ' + @user)
    FETCH NEXT FROM CursorSessoes INTO @user
END

CLOSE CursorSessoes
DEALLOCATE CursorSessoes
