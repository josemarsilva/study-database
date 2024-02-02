-- ----------------------------------------------------------------------------
-- filename: snap_dmv_objects_to_postgresql.ps1
-- purpose : Snap SQLServer DMV (Dynamic Management Views) objects into PostgreSQL
-- revision: 2024-01-22 10:15 - josemarsilva - 
-- remarks : 
--			* https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-query-stats-transact-sql?view=sql-server-ver16
--			* https://stackoverflow.com/questions/67268792/querying-data-from-sql-server-table-with-powershell
--			* https://learn.microsoft.com/en-us/powershell/module/sqlserver/invoke-sqlcmd?view=sqlserver-ps
--			* https://www.itprotoday.com/powershell/how-connect-sql-server-database-powershell#close-modal
-- ----------------------------------------------------------------------------


# Define as variáveis de conexão
$server = "myServer"
$database = "myDatabase"
$username = "myUsername"
$password = "myPassword"

# Define o caminho do arquivo SQL
$sqlFile = "C:\path\to\script.sql"

# Define a conexão com o PostgreSQL
$connectionString = "Driver={PostgreSQL Unicode(x64)};Server=$server;Port=5432;Database=$database;Uid=$username;Pwd=$password;"

# Cria a conexão
$connection = New-Object System.Data.Odbc.OdbcConnection($connectionString)

# Abre a conexão
$connection.Open()

# Lê o arquivo SQL
$sqlCommands = Get-Content $sqlFile -Raw

# Cria o objeto de comando
$command = New-Object System.Data.Odbc.OdbcCommand($sqlCommands, $connection)

# Executa os comandos SQL
$command.ExecuteNonQuery()

# Fecha a conexão
$connection.Close()
