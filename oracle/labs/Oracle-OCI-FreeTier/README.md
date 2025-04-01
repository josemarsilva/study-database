# [study-database - Oracle](../README.md) - Labs - Oracle OCI FreeTier

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

## 4.1. Using Browser 

* Click menu button `Database Action` :: `SQL`
* SQLDeveloper on browser instance will be launched


## 4.2. Using SQL Developer

* On the database page, click DB Connection.
  * Download the wallet.zip file.
* In SQL Developer, create a new connection, select Cloud Wallet, and upload the downloaded file.

## 4.2. Using SQL*Plus or Other Clients

* Use the details from the DB Connection tab and connect with:

```cmd
sqlplus admin@<db_name>_high
```
