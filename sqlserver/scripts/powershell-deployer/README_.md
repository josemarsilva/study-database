README
======

# 1. Introduction

The `deployer.ps1` is a powershell script to run scripts: SQLServer (.sql) and another Powershell scripts (.ps1).

# 2. How does it works?

* Invoke `deployer.ps1` with a JSON file parameter `deploy-sample.json`.
* `deployer.ps1` script will read parameters of `deploy-sample.json` with SQL Server connection, a "list of  databases" to be Backuped or Restored and a "list of scripts" (.sql) or (.ps1) to be executed for each databses.
* `deployer.ps1` script connect to database and execute each script of "list of scripts". Before execution of script, `deployer.ps1` replace variables like `{databse_deploy}` with the item of "list of databases"
* if script return any data then `deployer.ps1` can capture the result into Tab Separated Value (.tsv) file

```ps1
PS:> powershell -f deployer.ps1 deploy-sample.json
```

```ps1
PS C:\> Get-Content deploy-sample.json
{
    "server": "127.0.0.1",
    "database": "master",
    "username": "sa",
    "password": "Password@123",
    "options": ";TrustServerCertificate=True;",
    "deploy_databases": ["master"],
    "deploy_sql_stmts": [
        ["script", "deploy-script-sample-01.sql", ""],
        ["script", "deploy-script-sample-02.sql", "deploy-script-sample-02_{deploy_database}.tsv"]
    ]
}

```


## 2.1. Files Contents explanation

1. `deployer.ps1`: main PS scripts invoked with a parameter .json configuration file
2. `deploy-sample.json`: JSON configuration file read by `deployer.ps1` and used to configure tasks steps of a Task Group


## 2.2. How to run demo?

* Command line to Launch SQLServer 2019 Container with volume

```ps1
PS:> docker run --name mssql-labdb-2019 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Password@123" -p 1433:1433 -d mcr.microsoft.com/mssql/server:2019-latest
```

* Command line to stop and remove Docker Container with SQLServer 2019 with a local volume:

```ps1
PS:> docker stop mssql-labdb-2019
PS:> docker rm -f mssql-labdb-2019
```


## 2.3. Diagram

![DeployDiagram-sqlserver-docker-migration-source-to-target.drawio.png](../../../doc/diagrams/DeployDiagram-sqlserver-docker-migration-source-to-target.drawio.png) 


![DeployDiagram-sqlserver-docker-migration-source-to-target-GroupedTasks-StepByStep.drawio.png](../../../doc/diagrams/DeployDiagram-sqlserver-docker-migration-source-to-target-GroupedTasks-StepByStep.drawio.png) 

