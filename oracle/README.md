# study-database - Oracle

<p align="right">voltar para [study-database](../README.md)</p>

## 1. Introdução ##

Esta seção **Oracle** do repositório [Study Database](https://github.com/josemarsilva/study-database) aborda os seguintes assuntos:

* [Instalação Oracle](#31-instalação-oracle)
* [Configuração Oracle](#32-configuração-oracle)
* [Conexão Oracle Database](#33-conexão-oracle-database)
* [Performance](#34-performance-oracle-database)
* [Scripts](#35-scripts-oracle-database)
* [Laboratório](#35-scripts-oracle-database)

---

### 2. Mapa Mental

![Mapa Mental - Oracle](../doc/mind-maps/MindMapDiagram-DatabaseStudy-Oracle.png) 


---

### 3. Tópicos

### 3.1. Instalação Oracle

* Deploy Diagram - Oracle VirtualBox

![DeployDiagram-oracle-virtualbox.drawio.png](../doc/diagrams/DeployDiagram-oracle-virtualbox.drawio.png)

---

### 3.2. Configuração Oracle

* OVA file for Oracle Database 23c 
* https://www.oracle.com/database/technologies/databaseappdev-vm.html
* Configurations:
  * IP VirtualBox Host-Only: [`192.168.56.102`, `192.168.56.103`], host = `192.168.0.3`
  * ALL PASSWORDS ARE : oracle

---

### 3.3. Conexão Oracle Database


#### a. Using SQLPlus Command line

* Veja também [4 ways to connect to a pdb ](https://dbaparadise.com/2023/02/4-ways-of-connecting-to-a-pdb/)

1. Connect first Container Database(CDB) and for ther connect Pluggable Database (PDB):

```bash
sqlplus / as sysdba
alter session set container=freepdb1;
```

2. Connect using services `tnsnames.ora`

* Para se conectar ao Container Database (CDB), use:

```bash
sqlplus sys/oracle@localhost:1521/free as sysdba
```

* Para se conectar ao primeiro Pluggable Database (PDB), use:

```bash
sqlplus sys/oracle@localhost:1521/freepdb1 as sysdba
```

3. Connect using EZCONNECT

* Para se conectar ao Container Database (CDB) usando EZCONNECT e o service name, use:

```bash
sqlplus sys/oracle@//localhost:1521/free as sysdba
```

* Para se conectar ao Pluggable Database (PDB), usando EZCONNECT e o service name, use:

```bash
sqlplus sys/oracle@//localhost:1521/freepdb1 as sysdba
```

4. New way of connecting (>= 19c) use of an environment variable: ORACLE_PDB_SID

```bash
export ORACLE_PDB_SID=freepdb1
sqlplus / as sysdba
```


#### b. Using SQLDeveloper Client application

* Step-01: Start `sqldeveloper`
* Step-02: Add new connection to new database if not exists
  * sqldeveloper :: Connection (sheet) >> New (button) >> "New database connection"
  * On dialogbox "New / Select Database connection" follow these steps
    * "Name": `oracle-1`, "User Info" ("Username": `system`, "Password": `oracle`, "Connection type": `basic`, "Details": ("Hostname": `192.168.56.102`, "Port": `1521`, "SID": `free` ) )
    * Click "Test" (button) to test if connection is working good
    * Click "Save" (button) to save database connection configuration
* Step-03: Connect database using an existing connection
  * sqldeveloper :: Connection (sheet) >> Oracle Connections
    * Choose your connection and click on it. Ex: `oracle-1`


---

### 3.4. Performance Oracle Database

* [README.md Oracle Performance](./performance/README.md)

---

### 3.5. Scripts Oracle Database

* _under construction_

---

### 3.6. Laboratório Oracle Database

* [Oracle Database 19c Installation On Oracle Linux 7 (OL7)](./labs/Oracle-db-19c-installation-on-oracle-linux-7/README.md)
* [Oracle RMAN - Configure advanced RMAN backups and scripts](./labs/Oracle-RMAN/README.md)
