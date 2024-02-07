Write-Output "Removing mssql-labdb-2019 container ..."
docker rm -f  mssql-labdb-2019

Write-Output "Lauching mssql-labdb-2019 container ..."
docker run --name mssql-labdb-2019 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Password@123" -p 1433:1433 -v C:\Users\josemarsilva\githome\shared-volumes\mssql\:/mnt/share -d mcr.microsoft.com/mssql/server:2019-latest

Write-Output "Sleeping 15 sec waiting for SQLServer startup ..."
Start-Sleep -Seconds 15

powershell -f .\deploy.ps1 deploy-tgt-tskgrp-30.json $args[0] $args[1] $args[2] $args[3] $args[4] $args[5] $args[6] $args[7]
