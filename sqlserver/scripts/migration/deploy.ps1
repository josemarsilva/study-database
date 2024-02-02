## ############################################################################
## filename: deploy.ps1
## purpose : Deploy SQL scripts configured in JSON file
## revision: 2024-01-30 19:45 - josemarsilva - 
## remarks : 
##			* https://stackoverflow.com/questions/67268792/querying-data-from-sql-server-table-with-powershell
##			* https://learn.microsoft.com/en-us/powershell/module/sqlserver/invoke-sqlcmd?view=sqlserver-ps
##			* https://www.itprotoday.com/powershell/how-connect-sql-server-database-powershell#close-modal
##			* Pre-requisites:
##				- PS:> Install-Module -Name SqlServer
##				- PS:> Get-ExecutionPolicy
##				- PS:> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
##          * Parameters[]:
##              [0]: ConfigPath - Path to JSON File (.json) with configurations (required)
## ############################################################################

# Command line parameter
$ConfigPath = $args[0]
if (-not $ConfigPath) {
    Write-Error "ERROR-01: Script Command Line Parameter '-ConfigPath' not set. Usage: PS:> powershell -f deploy.ps1 deploy.json"
    return
}
$config = Get-Content -Path $ConfigPath -Raw | ConvertFrom-Json

# Import Modules required
Import-Module -Name SqlServer

# Define connection variables
$server = $config.server
$database = $config.database
$username = $config.username
$password = $config.password
$options = $config.options

# Define array of databases
[array]$a_deploy_databases = $config.deploy_databases

# Define array of SQL statements (scripts, queries, etc) to be executed
[array]$a_sql_stmts = $config.deploy_sql_stmts

# Define a conexão com o SQL Server
$connectionString = "Server=$server;Database=$database;User ID=$username;Password=$password;$options"

# Loop deploy databases
foreach ($deploy_database in $a_deploy_databases) {
	#
	Write-Output "Deploying database [$deploy_database] ..."

    # Loop foreach queries
    foreach ($sql_stmt in $a_sql_stmts ) {
        # Iteration
        Write-Output "Deploying '$($sql_stmt[0])' '$($sql_stmt[1])' on database [$deploy_database] ..."

        $results = $null
        # Switch case statement type of:
        if ($sql_stmt[0] -eq "script") {
            # Script
            $results = Invoke-Sqlcmd -ConnectionString $connectionString -InputFile $sql_stmt[1] -QueryTimeout 0
        } elseif ($sql_stmt[0] -eq "statement") {
            # Executa a query SQL e obtem o resultado
            $results = Invoke-Sqlcmd -ConnectionString $connectionString -Query $sql_stmt[1]
        } else {
            # Unexpected type
            Write-Output "Error: Unexpected type '$sql_stmt[0]'. List of values expected: ['script', 'query' ]"
        }

        # Result
        if (!([string]::IsNullOrEmpty($results) -or $results.Count -eq 0)) {
            $results
        } 

    }
    
}

