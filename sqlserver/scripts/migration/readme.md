README
======

#1. Introduction

The `migration` sub-folder has automation scripts to Backup and Restore all databases from a Server. 

#2. How does it works?

#2.1. How does it works?

* Invoke `deploy.ps1` with a JSON file parameter `deploy-src-tskgrp-02.json`.

```ps1
PS:> powershell -f deploy.ps1 deploy-src-tskgrp-02.json
```

* Script will read parameters of `deploy-src-tskgrp-02.json` with SQL Server connection, a list of  atabases to be Backuped or Restored and a list of scripts (.sql) to be executed for each databses.

#2.2. Files Contents explanation are:

1. `deploy.ps1`: main PS scripts invoked with a parameter .json configuration file
2. `deploy-src-tskgrp-*.json`: JSON configuration file read by `deploy.ps1` and used to configure tasks steps of **Backup*** of a Task Group
3. `deploy-tgt-tskgrp-*.json`: JSON configuration file read by `deploy.ps1` and used to configure tasks steps of **Restore** of a Task Group
4. `script-deploy-src-*-*.sql`: Scripts sequencially executed in a Task Group to **Backup** database
5. `script-deploy-tgt-*-*.sql`: Scripts sequencially executed in a Task Group to **Restore** database
6. Command line startup Docker Container with SQLServer 2019 with a local volume:

```ps1
PS:> docker run --name mssql-labdb-2019 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Password@123" -p 1433:1433 -v C:\Users\josemarsilva\githome\shared-volumes\mssql\:/mnt/share -d mcr.microsoft.com/mssql/server:2019-latest
```
7. Command line stop and remove Docker Container with SQLServer 2019 with a local volume:

```ps1
PS:> docker stop mssql-labdb-2019
PS:> docker rm -f mssql-labdb-2019
```

8. Power Shell "bundle" scripts 

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
