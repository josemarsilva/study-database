# study-database - Oracle - Labs - Oracle db 19c installation on Oracle-linux-7

## 1. Introdução ##

Este laboratório `Oracle-db-19c-installation-on-oracle-linux-7` foi construído com base no artigo [Oracle Base - Oracle Database 19c Installation On Oracle Linux 7 (OL7)](https://oracle-base.com/articles/19c/oracle-db-19c-installation-on-oracle-linux-7) e aborda os seguintes assuntos:

* [Download Software](#31-download-software)
* [Hosts File](#32-hosts-file)
* [Oracle Installation Pre-requisites](#33-oracle-installation-pre-requisites)
  * [Automatic Setup](#3301-automatic-setup)
  * [Manual Setup](#3302-manual-setup)
  * [Additional Setup](#3303-additional-setup)
* [Installation](#34-installation)
* [Database Creation](#35-database-creation)
* [Post Installation](#36-post-installation)

* [References](#references)


---

### 2. Mapa Mental

* _n/a_

---

### 3. Tópicos

### 3.1. Download Software

Download software from:
1. [http://edelivery.oracle.com/]
  * `LINUX.X64_193000_db_home.zip`
2. [https://www.oracle.com/technetwork/database/enterprise-edition/downloads/oracle19c-linux-5462157.html]

---

### 3.2. Hosts File

* add your fixed IP address `192.168.56.106` and name `oracle-2`

```/etc/hosts
127.0.0.1      localhost localhost.localdomain localhost4 localhost4.localdomain4
::1            localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.56.106 oracle-2 oracle-2.localdomain
```

* Set the correct hostname in the `/etc/hostname` file.

```bash
hostnamectl set-hostname oracle-2.localdomain

cat /etc/hostname
```


---

### 3.3. Oracle Installation Pre-requisites

* add pre-install repository

```bash
yum install -y oracle-database-preinstall-19c
```

* update OS

```bash
yum update -y
```

---

#### 3.3.01. Automatic Setup

* If you are using RHEL7 or CentOS7, you can pick up the PRM from the OL7 repository and install it. It will pull the dependencies from your normal repositories.

```bash
curl -o oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm https://yum.oracle.com/repo/OracleLinux/OL7/latest/x86_64/getPackage/oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm

yum -y localinstall oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm
```

* Oracle pre-install made a lot of changes that you **dont** need to maker manually

```bash
cat /etc/sysctl.conf | grep oracle
```

```bash
cat /etc/passwd | grep oracle
```

```bash
cat /etc/group | grep oracle
```


---

#### 3.3.02. Manual Setup

* **SKIPPED**

---

#### 3.3.03. Additional Setup

* Step-01: Set the password for the "oracle" user.

```bash
passwd oracle
```

* Step-02: Set secure Linux to permissive by editing the "/etc/selinux/config" file, making sure the SELINUX flag is set as follows.

```/etc/selinux/config
SELINUX=permissive
```

* Step-03: Once the change is complete, restart the server or run the following command.

```bash
setenforce Permissive
```

* Step-04: If you have the Linux firewall enabled, you will need to disable or configure it, as shown here. To disable it, do the following.

```bash
systemctl stop firewalld
systemctl disable firewalld
```

* Step-05: Create the directories in which the Oracle software will be installed.

```bash
mkdir -p /u01/app/oracle/product/19.0.0/dbhome_1
mkdir -p /u02/oradata
chown -R oracle:oinstall /u01 /u02
chmod -R 775 /u01 /u02
```

* Step-06: (_SKIPPED_) Unless you are working from the console, or using SSH tunnelling, login as root and issue the following command.

```bash
xhost +<machine-name>
```

* Step-07: Create a "scripts" directory.

```bash
mkdir /home/oracle/scripts
```

* Step-08: Create an environment file called "setEnv.sh". The "$" characters are escaped using "\". If you are not creating the file with the cat command, you will need to remove the escape characters.

```bash
cat > /home/oracle/scripts/setEnv.sh <<EOF
# Oracle Settings
export TMP=/tmp
export TMPDIR=\$TMP

export ORACLE_HOSTNAME=oracle-2.localdomain
export ORACLE_UNQNAME=cdb1
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=\$ORACLE_BASE/product/19.0.0/dbhome_1
export ORA_INVENTORY=/u01/app/oraInventory
export ORACLE_SID=cdb1
export PDB_NAME=pdb1
export DATA_DIR=/u02/oradata

export PATH=/usr/sbin:/usr/local/bin:\$PATH
export PATH=\$ORACLE_HOME/bin:\$PATH

export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:/lib:/usr/lib
export CLASSPATH=\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib
EOF
```

* Step-09: Add a reference to the "setEnv.sh" file at the end of the "/home/oracle/.bash_profile" file.

```bash
echo ". /home/oracle/scripts/setEnv.sh" >> /home/oracle/.bash_profile
```

* Step-10: Create a "start_all.sh" and "stop_all.sh" script that can be called from a startup/shutdown service. Make sure the ownership and permissions are correct.

```bash
cat > /home/oracle/scripts/start_all.sh <<EOF
#!/bin/bash
. /home/oracle/scripts/setEnv.sh

export ORAENV_ASK=NO
. oraenv
export ORAENV_ASK=YES

dbstart \$ORACLE_HOME
EOF
```

```bash
cat > /home/oracle/scripts/stop_all.sh <<EOF
#!/bin/bash
. /home/oracle/scripts/setEnv.sh

export ORAENV_ASK=NO
. oraenv
export ORAENV_ASK=YES

dbshut \$ORACLE_HOME
EOF
```

```bash
chown -R oracle:oinstall /home/oracle/scripts
chmod u+x /home/oracle/scripts/*.sh
```

* Once the installation is complete and you've edited the "/etc/oratab", you should be able to start/stop the database with the following scripts run from the "oracle" user.

```bash
~/scripts/start_all.sh
~/scripts/stop_all.sh
```

* You can see how to create a Linux service to automatically start/stop the database here.
  * [Creating Linux Services](https://oracle-base.com/articles/linux/linux-services-systemd#creating-linux-services)



---

### 3.4. Installation

* Switch to the ORACLE_HOME directory, unzip the software directly into this path and start the Oracle Universal Installer (OUI) by issuing one of the following commands in the ORACLE_HOME directory. The interactive mode will display GUI installer screens to allow user input, while the silent mode will install the software without displaying any screens, as all required options are already specified on the command line.

```bash
mkdir -p /mnt/share
chmod 555 /mnt/share
```

* Step-01: Manually move binaries files to machine
  * Move file `LINUX.X64_193000_db_home.zip`            to `/mnt/share` and create if necessary
  * Move file `oracle-database-ee-19c-1.0-1.x86_64.rpm` to `/mnt/share` and create if necessary

```powershell
scp C:\Apps\iso-installer-ova-etc\LINUX.X64_193000_db_home.zip            root@192.168.56.106:/mnt/share/
scp C:\Apps\iso-installer-ova-etc\oracle-database-ee-19c-1.0-1.x86_64.rpm root@192.168.56.106:/mnt/share/
```


* Step-02: Go to $ORACLE_HOME and unzip installation

```bash
cd $ORACLE_HOME
unzip -oq /mnt/share/LINUX.X64_193000_db_home.zip
```

* Step-03: (_SKIPPED_) Run Oracle installer in GNOME GUI in Interactive mode GNOME GUI using `oracle` account

```bash
cd $ORACLE_HOME
# Interactive mode.
./runInstaller
```

* Step-04: Run Oracle installer Silent mode.

```bash
cd $ORACLE_HOME
# Silent mode.
./runInstaller -ignorePrereq -waitforcompletion -silent                        \
    -responseFile ${ORACLE_HOME}/install/response/db_install.rsp               \
    oracle.install.option=INSTALL_DB_SWONLY                                    \
    ORACLE_HOSTNAME=${ORACLE_HOSTNAME}                                         \
    UNIX_GROUP_NAME=oinstall                                                   \
    INVENTORY_LOCATION=${ORA_INVENTORY}                                        \
    SELECTED_LANGUAGES=en,en_GB                                                \
    ORACLE_HOME=${ORACLE_HOME}                                                 \
    ORACLE_BASE=${ORACLE_BASE}                                                 \
    oracle.install.db.InstallEdition=EE                                        \
    oracle.install.db.OSDBA_GROUP=dba                                          \
    oracle.install.db.OSBACKUPDBA_GROUP=dba                                    \
    oracle.install.db.OSDGDBA_GROUP=dba                                        \
    oracle.install.db.OSKMDBA_GROUP=dba                                        \
    oracle.install.db.OSRACDBA_GROUP=dba                                       \
    SECURITY_UPDATES_VIA_MYORACLESUPPORT=false                                 \
    DECLINE_SECURITY_UPDATES=true
```

* Step-05: Change user to `root`

* Run the root scripts when prompted.
* As a root user, execute the following script(s):

```bash
# su - root

/u01/app/oraInventory/orainstRoot.sh
/u01/app/oracle/product/19.0.0/dbhome_1/root.sh
```


---

### 3.5. Database Creation

* You create a database using the Database Configuration Assistant (DBCA). The interactive mode will display GUI screens to allow user input, while the silent mode will create the database without displaying any screens, as all required options are already specified on the command line.

* Step-01: Run this session *only* if you used Silent mode.

* Step-02: login as `oracle`

```bash
lsnrctl start
```

* Step-03: Run `dbca` to create database in silent mode

```bash
# Silent mode.
dbca -silent -createDatabase                                                   \
     -templateName General_Purpose.dbc                                         \
     -gdbname ${ORACLE_SID} -sid  ${ORACLE_SID} -responseFile NO_VALUE         \
     -characterSet AL32UTF8                                                    \
     -sysPassword SysPassword1                                                 \
     -systemPassword SysPassword1                                              \
     -createAsContainerDatabase true                                           \
     -numberOfPDBs 1                                                           \
     -pdbName ${PDB_NAME}                                                      \
     -pdbAdminPassword SysPassword1                                            \
     -databaseType MULTIPURPOSE                                                \
     -memoryMgmtType auto_sga                                                  \
     -totalMemory 2000                                                         \
     -storageType FS                                                           \
     -datafileDestination "${DATA_DIR}"                                        \
     -redoLogFileSize 50                                                       \
     -emConfiguration NONE                                                     \
     -ignorePreReqs
```

* You can read more about silent database creation [here](https://oracle-base.com/articles/misc/database-configuration-assistant-dbca-silent-mode).

---

### 3.6. Post Installation

* Step-01: configure restart flag from oratab
  * Edit the "/etc/oratab" file setting the restart flag for each instance to 'Y'.

```bash
cdb1:/u01/app/oracle/product/19.0.0/dbhome_1:Y
```

* Step-02: configure enable Oracle Managed File
  * Enable Oracle Managed Files (OMF) and make sure the PDB starts when the instance starts.

```bash
sqlplus / as sysdba <<EOF
alter system set db_create_file_dest='${DATA_DIR}';
alter pluggable database ${PDB_NAME} save state;
exit;
EOF
```


* Step-03: Create and configure a `tnsnames.ora`

```bash
cd $ORACLE_HOME

cat > $ORACLE_HOME/./network/admin/tnsnames.ora <<EOF
# Generated by script installation Oracle - https://github.com/josemarsilva/study-database/tree/master/oracle/labs/Oracle-db-19c-installation-on-oracle-linux-7#36-post-installation

CDB1 =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = CDB1)
    )
  )

LISTENER_CDB1=
  (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))


PDB1 =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = PDB1)
    )
  )
EOF
```

* Step-04: Stop / Start host machine to check everything is working fine after a cold reboot
  * Run script `/home/oracle/scripts/stop_all.sh`
  * Shutdown server

```bash
[oracle@oracle-2 ~]$ /home/oracle/scripts/stop_all.sh
The Oracle base remains unchanged with value /u01/app/oracle
Processing Database instance "cdb1": log file /u01/app/oracle/product/19.0.0/dbhome_1/rdbms/log/shutdown.log
[oracle@oracle-2 ~]$ su - root
Password: 
Last login: Thu Feb 15 12:05:52 -03 2024 on pts/0
[root@oracle-2 ~]# shutdown -h now
```


* Step-05: Check everything after reboot

  * _Check_: if Oracle process is running
  * _Expected_:  results: "... ora_pmon_ ..."
  * _Remmediation_: Run script start_all.sh

```bash
[oracle@oracle-2 ~]$ ps -ef | grep pmon
oracle    1885     1  0 12:18 ?        00:00:00 ora_pmon_cdb1
oracle    2357  1594  0 12:19 pts/0    00:00:00 grep --color=auto pmon
```

* _Remmediation_:

```bash
[oracle@oracle-2 ~]$ /home/oracle/scripts/start_all.sh 
The Oracle base remains unchanged with value /u01/app/oracle
Processing Database instance "cdb1": log file /u01/app/oracle/product/19.0.0/dbhome_1/rdbms/log/startup.log
```

* Step-06: Connect to **CDB** using internal oracle user authentication
  * _Check_: connect **CDB1** / as sysdba
  * _Expected_:  "... SQL> ..."

```bash
sqlplus / as sysdba
  :
SQL> exit
```

* Step-07: Connect to **CDB** using database login authentication and `tnsnames.ora` configuration
  * _Check_: connect **CDB1** 
  * _Expected_:  "... SQL> ..."

```bash
[oracle@oracle-2 ~]$ sqlplus sys/SysPassword1@CDB1 AS SYSDBA
  : 
SQL> SHOW CON_NAME;

CON_NAME
------------------------------
CDB$ROOT

SQL> COLUMN NAME FORMAT A15
SQL> SELECT name, open_mode FROM v$pdbs;

NAME            OPEN_MODE
--------------- ----------
PDB$SEED        READ ONLY
PDB1            READ WRITE

SQL> SELECT name, log_mode, cdb FROM v$database;

NAME            LOG_MODE     CDB
--------------- ------------ ---
CDB1            NOARCHIVELOG YES

SQL>
```

* Step-08: Connect to **PDB** using database login authentication and `tnsnames.ora` configuration
  * _Check_: connect **PDB1** 
  * _Expected_:  "... SQL> ..."

```bash
[oracle@oracle-2 ~]$ sqlplus sys/SysPassword1@PDB1 AS SYSDBA
  : 
SQL> SHOW CON_NAME;

CON_NAME
------------------------------
PDB1

SQL> COLUMN NAME FORMAT A15
SQL> SELECT name, open_mode FROM v$pdbs;

NAME            OPEN_MODE
--------------- ----------
PDB1            READ WRITE

SQL> SELECT name, log_mode, cdb FROM v$database;

NAME            LOG_MODE     CDB
--------------- ------------ ---
CDB1            NOARCHIVELOG YES

SQL>
```


* Step-09: Summary connect

```txt
+ ---------- + ------ + -------- + ------------ + ---------- + -------------------------------------------------- +
|  hostname  |  sid   | username | password     | role       | sqlplus connect command line                       |
+ ---------- + ------ + -------- + ------------ + ---------- + -------------------------------------------------- +
|  oracle-2  |  cdb1  | sys      | SysPassword1 | AS SYSDBA  | sqlplus sys/SysPassword1@cdb1 AS SYSDBA            |
|  oracle-2  |  cdb1  | system   | SysPassword1 |            | sqlplus system/SysPassword1@cdb1                   |
|  oracle-2  |  pdb1  | sys      | SysPassword1 | AS SYSDBA  | sqlplus sys/SysPassword1@pdb1 AS SYSDBA            |
|  oracle-2  |  pdb1  | system   | SysPassword1 |            | sqlplus system/SysPassword1@pdb1                   |
+ ---------- + ------ + -------- + ------------ + ---------- + -------------------------------------------------- +
```


---


# References

* [https://oracle-base.com/articles/19c/oracle-db-19c-installation-on-oracle-linux-7]
* For more informations see:
  * [Oracle Database 19c : Installation Guide for Linux](https://docs.oracle.com/en/database/oracle/oracle-database/19/ladbi/index.html)
  * [Automating Database Startup and Shutdown on Linux](https://oracle-base.com/articles/linux/automating-database-startup-and-shutdown-on-linux)
  * [Oracle Universal Installations (OUI) Silent Installations](https://oracle-base.com/articles/misc/oui-silent-installations)
  * [Database Configuration Assistant (DBCA) : Creating Databases in Silent Mode](https://oracle-base.com/articles/misc/database-configuration-assistant-dbca-silent-mode)
