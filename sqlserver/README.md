# study-database - SQLServer

## 1. Introdução ##

Esta seção **SQLServer** do repositório [Study Database](https://github.com/josemarsilva/study-database) aborda os seguintes assuntos:

* [Instalação sqlserver](#31-instalação-sqlserver)
* [Configuração sqlserver](#32-configuração-sqlserver)
* [Conexão sqlserver Database](#33-conexão-sqlserver-database)
* [Performance](#34-performance-sqlserver-database)
* [Scripts](#35-scripts-sqlserver-database)
* [Laboratório](#36-laboratório-sqlserver-database)

---

### 2. Mapa Mental

![Mapa Mental - sqlserver](../doc/mind-maps/MindMapDiagram-DatabaseStudy-SQLServer.png) 


---

### 3. Tópicos

### 3.1. Instalação sqlserver

* _under construction_

---

### 3.2. Configuração sqlserver

* Docker Container - MSSQL 2019

```wt
PS: > docker run --name mssql-labdb-2019 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Password@123" -p 1433:1433 -d mcr.microsoft.com/mssql/server:2019-latest
```

---

### 3.3. Conexão sqlserver Database

* _under construction_

---

### 3.4. Performance sqlserver Database

* _under construction_

---

### 3.5. Scripts sqlserver Database

* [scripts](./scripts/): Diversos **scripts** para SQLServer
  * [powershell-deployer](./scripts/powershell-deployer/README.md): Ferramenta construída em PowerShell para executar um conjunto de scripts (.sql) e (.ps1) segundo um arquivo de configuração JSON
  * [migrate-databases-from-source-to-target](./scripts/migrate-databases-from-source-to-target/README.md): Ferramenta para migrar todas as bases de dados de uma instância **source** para outra instância **target**

---

### 3.6. Laboratório sqlserver Database

* [labs](./labs/): Diversos **laboratórios** para SQLServer: `howto_pintable.sql`, `howto_table_partition.sql`, `lab-fake-sqlserver-statistics.sql`
