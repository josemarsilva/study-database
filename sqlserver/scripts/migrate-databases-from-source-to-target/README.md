README
======

# 1. Introduction

The `migrate-databases-from-source-to-target` sub-folder has automation scripts to Backup and Restore all databases from a **source** Server to another **target** Server.

# 2. How does it works?

* `migrate-databases-from-source-to-target` uses tool `powershell-deployer` to make step-by-step group of tasks


## 2.1. Files Contents explanation

1. `deploy-src-tskgrp-*.json`: JSON configuration file read by `deploy.ps1` and used to configure tasks steps of **Backup*** of a Task Group
2. `deploy-tgt-tskgrp-*.json`: JSON configuration file read by `deploy.ps1` and used to configure tasks steps of **Restore** of a Task Group
3. `script-deploy-src-*-*.sql`: Scripts sequencially executed in a Task Group to **Backup** database
4. `script-deploy-tgt-*-*.sql`: Scripts sequencially executed in a Task Group to **Restore** database
5. Command line startup Docker Container with SQLServer 2019 with a local volume:


## 2.2. How to run demo?

* Command line to Launch SQLServer 2019 Container with volume

```ps1
PS:> docker run --name mssql-labdb-2019 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Password@123" -p 1433:1433 -v C:\Users\josemarsilva\githome\shared-volumes\mssql\:/mnt/share -d mcr.microsoft.com/mssql/server:2019-latest
```

* Command line to stop and remove Docker Container with SQLServer 2019 with a local volume:

```ps1
PS:> docker stop mssql-labdb-2019
PS:> docker rm -f mssql-labdb-2019
```

* Command line to Power Shell "bundle" scripts 

* init: Initial scenario all databases created on initial state
    * `deploy-init-all.ps1`: Docker MS SQLServer started and Script que chama os demais scripts apenas para iniciar o cenario criando todas as  bases de dados [AdventureWorks2019, Northwind, labdb, labdb2, labdb3]

* src: Source
    * `deploy-src-all-backup-full-diff-last.ps1`: Script backup full + differencial + last differencial para todas as bases de dados
    * `deploy-src-labdb.ps1`: Script deploy [labdb] database apenas cria o database
    * `deploy-src-labdb-backup-full-changes-diff-last.ps1`: Script backup full + differencial + last differencial [labdb] database
    * `deploy-src-labdb2-labdb3.ps1`: Script deploy [labdb2] e [labdb3] database

* tgt: Target
    * `deploy-tgt-labdb.ps1`: Script restore full + differencial + last differencial [labdb] database
    * `deploy-tgt-AdventureWorks2019.ps1`: Script Restore AdventureWorks2019.bak demo database
    * `deploy-tgt-Northwind.ps1`: Script deploy Northwind.sql demo database


## 2.3. Diagram

![DeployDiagram-sqlserver-docker-migration-source-to-target-GroupedTasks-StepByStep.drawio.png](../../../doc/diagrams/DeployDiagram-sqlserver-docker-migration-source-to-target-GroupedTasks-StepByStep.drawio.png) 

![DeployDiagram-sqlserver-docker-migration-source-to-target.drawio.png](../../../doc/diagrams/DeployDiagram-sqlserver-docker-migration-source-to-target.drawio.png) 

