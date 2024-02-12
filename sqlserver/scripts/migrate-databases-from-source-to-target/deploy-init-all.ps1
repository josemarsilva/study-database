Write-Output "Copying AdventureWorks2019.bak ..."
Copy-Item -Path "C:\Apps\iso-installer-ova-etc\AdventureWorks2019.bak" -Destination "C:\Users\josemarsilva\githome\shared-volumes\mssql\AdventureWorks2019.bak" -Force

Write-Output "Removing mssql-labdb-2019 container ..."
docker rm -f  mssql-labdb-2019

Write-Output "Lauching mssql-labdb-2019 container ..."
docker run --name mssql-labdb-2019 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Password@123" -p 1433:1433 -v C:\Users\josemarsilva\githome\shared-volumes\mssql\:/mnt/share -d mcr.microsoft.com/mssql/server:2019-latest

Write-Output "Sleeping 30 sec waiting for SQLServer startup ..."
Start-Sleep -Seconds 30

powershell -f .\deploy-src-AdventureWorks2019.ps1 $args[0] $args[1] $args[2] $args[3] $args[4] $args[5] $args[6] $args[7]
powershell -f .\deploy-src-Northwind.ps1          $args[0] $args[1] $args[2] $args[3] $args[4] $args[5] $args[6] $args[7]
powershell -f .\deploy-src-labdb.ps1              $args[0] $args[1] $args[2] $args[3] $args[4] $args[5] $args[6] $args[7]
powershell -f .\deploy-src-labdb2-labdb3.ps1      $args[0] $args[1] $args[2] $args[3] $args[4] $args[5] $args[6] $args[7]
