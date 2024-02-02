-- ----------------------------------------------------------------------------
-- filename: snap_dmv_objects_from_into_sqlserver.ps1
-- purpose : Snap SQLServer DMV (Dynamic Management Views) objects into SQL Server
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
$sqlFile = "snap_dmv_objects_into_tmptables.sql"
[array]$a_queries = @(
    [System.Tuple]::Create("SELECT * FROM #tmp_snap_exec",             "servername, dbname, datehour"),
    [System.Tuple]::Create("SELECT * FROM #tmp_snap_exec_query_stats", "sql_handle, execution_count, avg_worker_time")
)

$query = "SELECT * FROM #tmp_snap_exec"

# Define a conexão com o SQL Server
$connectionString = "Server=$server;Database=$database;User ID=$username;Password=$password;"

# Cria uma conexão com o SQL Server
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString
$connection.Open()

# Executa o script SQL usando Invoke-Sqlcmd
Invoke-Sqlcmd -ServerInstance $server -Database $database -Username $username -Password $password -InputFile $sqlFile -QueryTimeout 0 -Connection $connection

# Loop foreach queries
foreach ($query in $a_queries) {

	# Executa a query SQL e obtem o resultado
	$results = Invoke-Sqlcmd -ServerInstance $server -Database $database -Username $username -Password $password -Query $query.Item1 -QueryTimeout 0 -Connection $connection

	# Processa o resultado
    Write-Host $query.Item1 $query.Item2
	
	# Mostra coluna a coluna do resultado
	foreach ($row in $results) {
		Write-Host $row.column1, $row.column2, $row.column3
	}
	
}


# Fecha a conexão com o SQL Server
$connection.Close()
