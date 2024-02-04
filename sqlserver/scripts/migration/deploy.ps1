## ############################################################################
## filename: deploy.ps1
## purpose : Deploy SQL scripts configured in JSON file
## revision: 2024-02-03 18:45 - josemarsilva - 
## remarks : 
##			* https://stackoverflow.com/questions/67268792/querying-data-from-sql-server-table-with-powershell
##			* https://learn.microsoft.com/en-us/powershell/module/sqlserver/invoke-sqlcmd?view=sqlserver-ps
##			* https://www.itprotoday.com/powershell/how-connect-sql-server-database-powershell#close-modal
##			* Pre-requisites:
##				- PS:> Install-Module -Name SqlServer
##				- PS:> Get-ExecutionPolicy
##				- PS:> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
##          * Parameters[]:
##              [0]: configPath - Path to JSON File (.json) with configurations (required)
## ############################################################################

# Command line parameter:
$configPath = $args[0]
if (-not $configPath) {
    Write-Error "ERROR-01: Script Command Line Parameter '-configPath' not set. Usage: PS:> powershell -f deploy.ps1 deploy.json"
    return
}
$config = Get-Content -Path $configPath -Raw | ConvertFrom-Json

# $args[1] .. $args[n]
$keepTmpFile = $false
for ($i = 1; $i -le $args.Length; $i++) {
    if ($args[$i])  {
        if ($args[$i].ToLower() -eq "-keepTmpFile".ToLower()) {
            $keepTmpFile = $true
        }    
    }
}

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

        # SQL (.sql) script file replacements into TMP (.tmp) file
        $filenameSql = $sql_stmt[1]
        $filename = Split-Path -Path $filenameSql -Leaf
        $path = Split-Path -Path $filenameSql -Parent
        if ($path -eq "") {
            $path = "."
        }
        $filenameTmp = "$path\$($filename -replace '\.sql$', '.tmp')"
        (Get-Content -Path $filenameSql) -replace '{deploy_database}', $deploy_database | Out-File -FilePath $filenameTmp

        # Write Output Iteration
        $scriptType = $sql_stmt[0]
        Write-Output "Deploying '$($scriptType)' '$($filenameTmp)' on database [$deploy_database] ..."

        $results = $null
        # Switch case statement type of:
        if ($scriptType -eq "script") {
            # Script
            $results = Invoke-Sqlcmd -ConnectionString $connectionString -InputFile $filenameTmp -QueryTimeout 0
        } elseif ($scriptType -eq "statement") {
            # Executa a query SQL e obtem o resultado
            $results = Invoke-Sqlcmd -ConnectionString $connectionString -Query $filenameTmp
        } else {
            # Unexpected type
            Write-Error "Error: Unexpected type '$scriptType'. List of values expected: ['script', 'query' ]"
        }

        # Remove Temporary file (.tmp)
        If (-not $keepTmpFile) {
            Remove-Item -Path $filenameTmp
        } else {
            Write-Output "Warning: Temporary file was not removed ..."
        }

        # ($result is not null or not empty) AND ($result.count <> 0)
        if (!([string]::IsNullOrEmpty($results) -or $results.Count -eq 0)) {

            # Some results were returned
            if ($sql_stmt[2] -eq "") {
                Write-Output "Warning: Some results were returned but will not be saved ..."
            } else {
                # TSV (.tsv) filename replacement 
                $filenameTsv = $sql_stmt[2]
                $filename = Split-Path -Path $filenameTsv -Leaf
                $path = Split-Path -Path $filenameTsv -Parent
                if ($path -eq "") {
                    $path = "."
                }
                $filenameTsv = "$path\$($filename -replace '{deploy_database}', $deploy_database)"
                Write-Output "Saving results into '$($filenameTsv)' ..."
                $results | ConvertTo-Csv -Delimiter "`t" -NoTypeInformation | Out-File -FilePath $filenameTsv
                (Get-Content -Path $filenameTsv) | Foreach-Object {$_ -replace '"', ''} | Set-Content -Path $filenameTsv

            }

        } 

    }
    
}

