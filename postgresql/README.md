# study-database - PostgreSQL

## 1. Introdução ##

Esta seção **PostgreSQL** do repositório [Study Database](https://github.com/josemarsilva/study-database) aborda os seguintes assuntos:

* [Instalação PostgreSQL](#31-instalação-postgresql)
  * [Instalação CentOS 7](#a-instalação-CentOS-7)
  * [Instalação CentOS 6](#b-instalação-CentOS-6)
  * [Instalação CentOS 6 - Baixando pacotes RPM manualmente](#c-instalação-manual-postgresql)
* [Configuração PostgreSQL](#32-configuração-postgresql)
  * [Regras de Firewall](#a-regras-de-firewall)
  * [Conectividade externa](#b-conectividade)
  * [Criação de database e usuario](#c-criacao-de-database-e-usuários)
* [Conexão PostgreSQL Database](#33-conexao-postgresql-database)
  * [Linha de comando](#a-linha-de-comando)
  * [JDBC Driver](#b-jdbc-driver)
  * [Python](#c-python)
    * [Pip library install](#i-psycopg2)
    * [Example Query Database](#ii-exemplo-query-database)
  * [NodeJS](#d-nodejs)

---
### 2. Mapa Mental

![Mapa Mental - PostgreSQL](../../doc/mind-maps/MindMapDiagram-DatabaseStudy-PostgreSQL.png) 


---
### 3. Tópicos

### 3.1. Instalação PostgreSQL

#### a. Instalação CentOS 7

* [Referências](https://www.linode.com/docs/databases/postgresql/how-to-install-postgresql-relational-databases-on-centos-7)
* Step-by-step: Instalação do pacote padrao do CentOS 7

```sh
# sudo yum update
# sudo yum install postgresql-server postgresql-contrib
# sudo postgresql-setup initdb
# sudo systemctl start postgresql
# sudo systemctl enable postgresql
```

---
#### b. Instalação CentOS 6

* [Referências](https://tecadmin.net/install-postgresql-on-centos-rhel-and-fedora/)
* Step-by-step: Instalação do pacote padrao do CentOS 6

```sh
# sudo yum update
# sudo yum install postgresql-server postgresql-contrib
# service postgresql initdb
# service postgresql start
# chkconfig postgresql on
```

---
#### c. Instalação manual PostgreSQL
* [Referências](https://yum.postgresql.org/rpmchart.php) e [Download RPM PostgreSQL 9.6](https://yum.postgresql.org/9.6/redhat/rhel-6-x86_64/repoview/)
* [Referências](https://www.tecmint.com/install-postgresql-on-centos-rhel-fedora/)

```sh
yum update
yum install wget -y
yum install curl -y
wget https://yum.postgresql.org/9.6/redhat/rhel-6-x86_64/postgresql96-9.6.12-1PGDG.rhel6.x86_64.rpm
wget https://yum.postgresql.org/9.6/redhat/rhel-6-x86_64/postgresql96-contrib-9.6.12-1PGDG.rhel6.x86_64.rpm
wget https://yum.postgresql.org/9.6/redhat/rhel-6-x86_64/postgresql96-libs-9.6.12-1PGDG.rhel6.x86_64.rpm
wget https://yum.postgresql.org/9.6/redhat/rhel-6-x86_64/postgresql96-server-9.6.12-1PGDG.rhel6.x86_64.rpm
wget http://mirror.centos.org/centos/6/os/x86_64/Packages/libxslt-1.1.26-2.el6_3.1.x86_64.rpm

yum install libxslt-1.1.26-2.el6_3.1.x86_64.rpm
yum install postgresql96-libs-9.6.12-1PGDG.rhel6.x86_64.rpm
yum install postgresql96-9.6.12-1PGDG.rhel6.x86_64.rpm
yum install postgresql96-server-9.6.12-1PGDG.rhel6.x86_64.rpm
yum install postgresql96-contrib-9.6.12-1PGDG.rhel6.x86_64.rpm

# Expected: Nothing to do
yum install postgresql96-server postgresql96 postgresql96-contrib 

# Expected: Initializing database: [  OK  ]
service postgresql-9.6 initdb

# Expected: Starting postgresql-9.6 service: [  OK  ]
service  postgresql-9.6 start
chkconfig postgresql-9.6 on

# Expected: psql (9.6.12) - List of databases ...
su - postgres
psql
postgres=# \l
postgres=# \q
```

---
#### d. Instalação Docker
* [Referências](https://github.com/josemarsilva/eval-virtualbox-vm-ubuntu-server#44-docker-composer---postgresql-96-pgadmin4)


---
#### e. Instalação Windows

* não disponível


---
### 3.2. Configuração PostgreSQL

#### a. Regras de Firewall

```sh
vim /etc/sysconfig/iptables
  :
-A INPUT -m state --state NEW -m tcp -p tcp --dport 5432 -j ACCEPT
  :

service iptables reload
```

```sh
vim /etc/sysconfig/ip6tables
  :
-A INPUT -m state --state NEW -m tcp -p tcp --dport 5432 -j ACCEPT
  :

service ip6tables reload
```

---
#### b. Conectividade

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

---
#### c. Criacao de database e usuários

* Step-1: Criação de **database** e **user**

```sh
# su - postgres
$ psql
$ psql
postgres=# create database dbsample;
postgres=# CREATE USER dbuser WITH PASSWORD 'dbuser';
\l
\q
```


* Step-2: Teste de conexão remota

```sh
psql -h 127.0.0.1 -U dbuser dbsample
Password for user dbuser: dbuser
dbsample=> \q
```

---
### 3.3. Conexão PostgreSQL Database

#### a. Linha de comando 

```sh
psql -h 127.0.0.1 -U dbuser dbsample
Password for user dbuser: dbuser
dbsample=> \q
```

---
#### b. JDBC driver

* to do


---
#### c. Python

##### i. Psycopg2

* Step-1: Instalar Psycopg2

```sh
sudo yum install python-psycopg2
# verifique instalação do psycopg, o resultado do comando deve ser algo parecido com este ...
yum list installed python-psycopg2 
Installed Packages
python-psycopg2.x86_64                     2.5.1-3.el7                     @base
```

* Referências:
  * [Installing Psycopg for Red Hat Enterprise Linux](https://www.luminanetworks.com/docs-lsc-610/Topics/SDN_Controller_Software_Installation_Guide/Appendix/Installing_Psycopg_for_Red_Hat_Enterprise_Linux_1.html)


##### ii. Exemplo query database

```sh
vim hello-world-psycopg.py
#!/usr/bin/python
import psycopg2
import sys

def main():
        conn_string = "host='127.0.0.1' dbname='dbsample' user='dbuser' password='dbuser'"
        print "Connecting to database\n ->%s" % (conn_string)
        conn = psycopg2.connect(conn_string)
        cursor = conn.cursor()
        print "Connected!\n"
        cursor.execute("""SELECT schemaname || '.' || tablename AS schema_table_name FROM pg_catalog.pg_tables ORDER BY schemaname, tablename""")
        rows = cursor.fetchall()
        print "\nShow me the databases:\n"
        for row in rows:
                print "   ", row[0]

if __name__ == "__main__":
        main()
```

```sh
# Executando script ...
python hello-world-psycopg.py
```

```sh
Connecting to database
 ->host='127.0.0.1' dbname='dbsample' user='dbuser' password='dbuser'
Connected!


Show me the databases:

    information_schema.sql_features
    information_schema.sql_implementation_info
    information_schema.sql_languages
      :
```

* Referências:
  * [Psycopg Tutorial](https://wiki.postgresql.org/wiki/Psycopg2_Tutorial)


#### d. NodeJS

##### i. 




---
### 3.3. Performance

* em construção
