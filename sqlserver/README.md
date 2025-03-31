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
  * [powershell-deployer](./scripts/powershell-deployer/): Ferramenta construída em PowerShell para executar um conjunto de scripts (.sql) e (.ps1) segundo um arquivo de configuração JSON
  * [migrate-databases-from-source-to-target](./scripts/migrate-databases-from-source-to-target/): Ferramenta para migrar todas as bases de dados de uma instância **source** para outra instância **target**
  * scripts: `alter_database_set_readonly_readwrite.sql`, `alter_database_set_singleuser_multiuser.sql`, `alter_kill_sleeping_sessions.sql`, `checklist_database_dependant_jobs.sql`, `checklist_database_properties.sql`, `checklist_database_properties2.sql`, `checklist_disk_database_size.sql`, `checklist_linked_servers.sql`, `checklist_orphan_users.sql`, `checklist_set_database_readonly.sql`, `dbcc_freeproccache.sql`, `query_backup_set.sql`, `query_cardinality_selectivity.sql`, `query_database_logical_and_physical_name.sql`, `query_database_objects.sql`, `query_database_physical_file_path.sql`, `query_default_backup_path.sql`, `query_dm_locks.sql`, `query_dm_plan_exec.sql`, `query_dm_requests.sql`, `query_dm_requests_x_session.sql`, `query_dm_top_exec_qry_stats.sql`, `query_dm_unused_index.sql`, `query_index_fragmentation.sql`, `query_instance_params.sql`, `query_query_store_qry_pln_txt.sql`, `query_space_used.sql`, `query_sql_server_agent_jobs.sql`, `query_sys_db_config.sql`, `query_triggers.sql`, `query_version_cumulative_update.sql`, `set_statistics_io_time_on_show_execplan.sql`, `sp_helpindex2_show_indexes_includes.sql`, `sp_whoisactive.sql`, `template_tuning_query_roadmap.txt`


---

### 3.6. Laboratório sqlserver Database

* [labs](./labs/): Diversos **laboratórios** para SQLServer: 
  * [Ferramenta OStress](./labs/ostress/README.md)
  * [SqlQueryStress](./labs/sqlquerystress/README.md)
  * Scripts: `howto_pintable.sql`, `howto_table_partition.sql`, `lab-fake-sqlserver-statistics.sql`
