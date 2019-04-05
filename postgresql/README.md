# study-database - PostgreSQL

## 1. Introdução ##

Esta seção **PostgreSQL** do repositório [Study Database](https://github.com/josemarsilva/study-database) aborda os seguintes assuntos:

* [Instalação PostgreSQL](#31-instalação-postgresQL)
* [Configuração do PostgreSQL para acesso externo](#32-configuração-do-postgresQL-para-acesso-externo)
* [Criacao de database e usuarios](#32-criacao-de-database-e-usuarios)


### 2. Mapa Mental

![Mapa Mental](doc/images/MindMap%20-%20DatabaseStudy%20-%20PostgreSQL.png) 


### 3. Tópicos

### 3.1. Instalação PostgreSQL

#### a. Referências
* https://www.linode.com/docs/databases/postgresql/how-to-install-postgresql-relational-databases-on-centos-7/
* https://tecadmin.net/install-postgresql-on-centos-rhel-and-fedora/

#### b. Instalação CentOS 7

* Step-01: Instalação do pacote padrao do CentOS 7

```sh
# sudo yum update
# sudo yum install postgresql-server postgresql-contrib
# sudo postgresql-setup initdb
# sudo systemctl start postgresql
# sudo systemctl enable postgresql
```


### 3.2. Configuração do PostgreSQL para acesso externo

```sh
# vim /var/lib/pgsql/data/pg_hba.conf
  :
#host   all             all             127.0.0.1/32            ident
host    all             all             0.0.0.0/0               md5
  :

# vim /var/lib/pgsql/data/postgresql.conf
  :
listen_addresses = '*'
  :
# su - postgres # login 'postgres'
```


### 3.2. Criacao de database e usuarios

* Step-1: Criação de **database** e **user**

```sh
# su - postgres
$ psql
$ psql
postgres=# create database dbsample;
postgres=# CREATE USER dbuser WITH PASSWORD 'dbuser';
```


* Step-2: Teste de conexão remota

```sh
psql -h 127.0.0.1 dbsample -U dbuser 
Password for user dbuser: dbuser
dbsample=> \q
```


