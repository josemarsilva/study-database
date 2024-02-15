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

* add your fixed IP address `192.168.56.104` and name `oracle-centos7`

```/etc/hosts
127.0.0.1      localhost localhost.localdomain localhost4 localhost4.localdomain4
::1            localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.56.104 oracle-centos7 oracle-centos7.localdomain
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

* Oracle pre-install make a lot of changes that you do **not** need to maker manually

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

* Step-a: Set the password for the "oracle" user.

```bash
passwd oracle
```

* Step-b: Set secure Linux to permissive by editing the "/etc/selinux/config" file, making sure the SELINUX flag is set as follows.

```/etc/selinux/config
SELINUX=permissive
```

* Step-c: Once the change is complete, restart the server or run the following command.

```bash
setenforce Permissive
```

* Step-d: If you have the Linux firewall enabled, you will need to disable or configure it, as shown here. To disable it, do the following.

```bash
systemctl stop firewalld
systemctl disable firewalld
```

* Step-e: Create the directories in which the Oracle software will be installed.

```bash
mkdir -p /u01/app/oracle/product/19.0.0/dbhome_1
mkdir -p /u02/oradata
chown -R oracle:oinstall /u01 /u02
chmod -R 775 /u01 /u02
```

* Step-f(_SKIPPED_): Unless you are working from the console, or using SSH tunnelling, login as root and issue the following command.

```bash
xhost +<machine-name>
```

* Step-g: Create a "scripts" directory.

```bash
mkdir /home/oracle/scripts
```

* Step-h: Create an environment file called "setEnv.sh". The "$" characters are escaped using "\". If you are not creating the file with the cat command, you will need to remove the escape characters.

```bash
/home/oracle/scripts/setEnv.sh
cat > /home/oracle/scripts/setEnv.sh <<EOF
# Oracle Settings
export TMP=/tmp
export TMPDIR=\$TMP

export ORACLE_HOSTNAME=ol7-19.localdomain
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

* Step-g: Add a reference to the "setEnv.sh" file at the end of the "/home/oracle/.bash_profile" file.

```bash
echo ". /home/oracle/scripts/setEnv.sh" >> /home/oracle/.bash_profile
```

* Step-h: Create a "start_all.sh" and "stop_all.sh" script that can be called from a startup/shutdown service. Make sure the ownership and permissions are correct.

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

* _to-be-defined_

---

### 3.5. Database Creation

* _to-be-defined_

---

### 3.6. Post Installation

* _to-be-defined_

---


# References

* [https://oracle-base.com/articles/19c/oracle-db-19c-installation-on-oracle-linux-7]