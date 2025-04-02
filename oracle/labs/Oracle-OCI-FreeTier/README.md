# [study-database - Oracle](../../README.md) - Labs - Oracle OCI FreeTier

## 1. Introduction


Objective of this laboratory **Oracle-OCI-FreeTier** is to create an Oracle Autonomous database for testing in Oracle's cloud.

## 1.1. Pre-requisites

* **OCI** Oracle Cloud Infraestructure account free tier


## 2. Access Oracle Cloud Infrastructure (OCI)

* Go to Oracle Cloud `https://cloud.oracle.com/`
* Click Sign In and log in to your free account.
* In the top menu, click `☰ (hamburger menu) > Oracle Database`.

## 3. Creating an Oracle Autonomous Database (Easiest for Learning)

* In the `Oracle Database` panel, click `Autonomous Database`.
* Click `Create Autonomous Database`.
* Fill in the required fields:
  * Compartment: `josemarfuregatti (root)`
  * Display Name: `study`.
  * Database Name: `study`.
  * Workload Type: `[X] Choose Transaction Processing (for OLTP)`.
  * Database Configuration
    * `[X] Always Free`
    * Choose database version: `19c` 
  * Administrator credentials creation:
    * Username: `ADMIN`
    * Password: `*******`
  * Network access
    * `[X] Secure access from allowed IPs and VCNs only`
    * IP notation type: `IP address`
    * `[X] Add my IP address (x.x.x.x)`
    * `[ ] Require mutual TLS (mTLS) authentication`
  * Click `Create Autonomous Database`.


## 4. Connecting to the Database

Once the database is created, click on it and choose how to connect:

## 4.1. Using Web-Browser SQL Database Actions

* Click drop-down menu button `Database actions` :: `SQL`
* SQLDeveloper on browser instance will be launched
  * Execute following command

```sql
SELECT * FROM DBA_TABLES
```

![Oracle-OCI-DatabaseActions-SQL.png](../../../doc/images/Oracle-OCI-DatabaseActions-SQL.png) 

## 4.2. Create Database User

* Click drop-down menu button `Database users`
* On `Database Actions` :: `Database Users` click button `Create User` and fill form:
  - Username: `STUDY`
  - Password: `*********`
  - Quota on Tablespace DATA: `UNLIMITED`
  - Click button `Create User`


## 4.2. Using SQL Developer

### a. Download Wallet

* On the database page `Overview >> Autonomous Database >> Autonomous Database Details`, Click drop-down menu button `Database connection`
  * On `Download client credentials (Wallet)` document section click button `Download wallet`
  * On `Download wallet` dialog box inform de same password 
  * On `Connection strings` document section:
    - TLS authentication: `Mutual TLS` 
    - TNS name: `study_high` - `(description= (retry_count=20)(retry_delay=3)(address=(protocol=tcps)(port=1522)(host=adb.sa-vinhedo-1.oraclecloud.com))(connect_data=(service_name=xxxxxxxxxxxxxxx_study_high.adb.oraclecloud.com))(security=(ssl_server_dn_match=yes)))`

### b. Create SQLDeveloper Connection using ADMIN (user)

* Launch local program `SQLDeveloper`
  * Click on green `+` icon and after `Nova Conexão de Banco de Dados ...`
  * On `Nova conexão do Serviço de Esquema de Banco de dados` dialog-box fill in the fields as follows:
    - Connection Name: `Study_Connection_AS_ADMIN`
    - Nome do usuário: `ADMIN`
    - Senha: `***********`
    - Tipo de Conexão: `Wallet do Cloud`
    + Em detalhes
      - Arquivo de configuração: `C:\Users\josemarsilva\Downloads\Wallet_study.zip` (previous downloaded)
    - Click button `Testar` and wait for message `Success ...`

### c. Create SQLDeveloper Connection using STUDY (user)

* Launch local program `SQLDeveloper`
  * Click on green `+` icon and after `Nova Conexão de Banco de Dados ...`
  * On `Nova conexão do Serviço de Esquema de Banco de dados` dialog-box fill in the fields as follows:
    - Connection Name: `Study_Connection_AS_STUDY`
    - Nome do usuário: `STUDY`
    - Senha: `***********`
    - Tipo de Conexão: `Wallet do Cloud`
    + Em detalhes
      - Arquivo de configuração: `C:\Users\josemarsilva\Downloads\Wallet_study.zip` (previous downloaded)
    - Click button `Testar` and wait for message `Success ...`

### d. References
  * [Connecting to an Autonomous Transaction Processing database via SQLDeveloper](https://www.youtube.com/watch?v=RGPTMEPhrck)



## 4.3. Using SQL*Plus or Other Clients

* Unzip `Wallet*.zip` into local dir `C:\oracle\wallet`

* Edit `%ORACLE_HOME%/network/admin/sqlnet.ora`

```sqlnet.ora
WALLET_LOCATION = 
  (SOURCE = 
    (METHOD = file) 
    (METHOD_DATA = 
      (DIRECTORY = C:\oracle\wallet)  # Change this to your extracted wallet path
    )
  )

SSL_SERVER_DN_MATCH = yes
SSL_VERSION = 1.2
```


* Edit `%ORACLE_HOME%/network/admin/tnsnames.ora`

```tnsnames.ora
study_high =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCPS)(HOST = adb.sa-vinhedo-1.oraclecloud.com)(PORT = 1522))
    (CONNECT_DATA =
      (SERVICE_NAME = gd1a1273809afc5_study_high.adb.oraclecloud.com)
    )
    (SECURITY =
      (SSL_SERVER_DN_MATCH = yes)
    )
  )
```

* SET Environment variable `TNS_ADMIN`

```cmd
setx TNS_ADMIN C:\Apps\wallet     
```

* Use the details from the DB Connection tab and connect with:

```cmd
sqlplus admin/**************@study_high
```

