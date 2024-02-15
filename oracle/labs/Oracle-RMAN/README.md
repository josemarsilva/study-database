# study-database - Oracle - Labs - Oracle RMAN

## 1. Introdução ##

Este laboratório `Oracle-RMAN` foi construído com base no treinamento da Udemy [Oracle RMAN - Configure advanced RMAN backups and scripts](https://www.udemy.com/course/oracle-rman-advanced-backups/?utm_source=adwords&utm_medium=udemyads&utm_campaign=Webindex_Catchall_la.EN_cc.BR&utm_term=_._ag_119370706961_._ad_488880694993_._kw__._de_c_._dm__._pl__._ti_dsa-49053582424_._li_9100413_._pd__._&matchtype=&gad_source=5&gclid=EAIaIQobChMIle7__P6ehAMV2FhIAB2aVwYzEAAYASAAEgJDyPD_BwE) e aborda os seguintes assuntos:

* [Introduction to RMAN](#31-introduction-to-rman)
* [RMAN Configuration Parameters](#32-rman-configuration-parameters)
  * [Connect Oracle Database Server](#step-3201-connect-oracle-database-server)
  * [Check  if database is running](#step-3202-check-if-database-is-running)
  * [Check enviroment variables](#step-3203-check-enviroment-variables)
  * [Run RMAN utility without connect to a database](#step-3204-run-rman-utility---without-connect-to-a-database)
  * [Run RMAN utility connect to your target database](#step-3205-run-rman-utility---connect-to-your-target-database)
  * [Run RMAN utility  show all parameters that govern rman utility](#step-3206-run-rman-utility---show-all-parameters-that-govern-rman-utility)
  * [Run RMAN configuration parameter - configure retention policy](#step-3207-run-rman-configuration-parameter---configure-retention-policy)
  * [Run RMAN configuration parameter - configure backup optimization](#step-3208-run-rman-configuration-parameter---configure-backup-optimization)
  * [Run RMAN configuration parameter - configure default device type to disk](#step-3209-run-rman-configuration-parameter---configure-default-device-type-to-disk)
  * [Run RMAN configuration parameter - configure controlfile autobackup](#step-3210-run-rman-configuration-parameter---configure-controlfile-autobackup)
  * [Run RMAN configuration parameter - configure controlfile autobackup format](#step-3211-run-rman-configuration-parameter---configure-controlfile-autobackup-format)
  * [Run RMAN configuration parameter - configure datafile backup copies for device type disk to 1](#step-3212-run-rman-configuration-parameter---configure-datafile-backup-copies-for-device-type-disk-to-1)
  * [Run RMAN configuration parameter - configure maxsetsize to unlimited](#step-3213-run-rman-configuration-parameter---configure-maxsetsize-to-unlimited)
  * [Run RMAN configuration parameter - configure encryption for database](#step-3214-run-rman-configuration-parameter---configure-encryption-for-database)
  * [Run RMAN configuration parameter - configure encryption algorithm](#step-3215-run-rman-configuration-parameter---configure-encryption-algorithm)
  * [Run RMAN configuration parameter - configure compression algorithm](#step-3216-run-rman-configuration-parameter---configure-compression-algorithm)
  * [Run RMAN configuration parameter - configure archivelog deletion policy to](#step-3217-run-rman-configuration-parameter---configure-archivelog-deletion-policy-to)
  * [Run RMAN configuration parameter - configure snapshot controlfile name to](#step-3218-run-rman-configuration-parameter---configure-snapshot-controlfile-name-to)
* [RMAN Channels and Parallelism](#33-rman-channels-and-parallelism)
  * [Configure default device type with parallelism 1](#step-3301-configure-default-device-type-with-parallelism-1)
* [RMAN First Backup](#34-rman-first-backup)
  * [Unsuccessfully try to run RMAN in a noarchivelog mode database](#step-3401-unsuccessfully-try-to-run-rman-in-a-noarchivelog-mode-database)
  * [Change your database mode from noarchiveog to archivelog](#step-3402-change-your-database-mode-from-noarchiveog-to-archivelog)
  * [Configure default device type with parallelism 2](#step-3403-configure-default-device-type-with-parallelism-2)
  * [Configure default channel](#step-3404-configure-default-channel)
* [RMAN Backup Types](#35-rman-backup-types)
* [Tracking RMAN Backups](#36-taking-rman-backups)
* [Summary](#37-summary)

* [References](#references)


---

### 2. Mapa Mental

* _n/a_

---

### 3. Tópicos

### 3.1. Introduction to RMAN

* Oracle RMAN is automation of backup and recovery automation
* Block level Backup vs File Level Backup:
  * **Block Level Backup**: Can backup only used data from datafiles, so backup size can be smaller
  * **File Level Backup**: backup datafile information, but some can be used or unused, so backup size should be same size of current database
* Parallelism:
  * in parallel you can take multiple backups at same time
  * supose a terabytes database, how much time to copy each byte
  * Channel mechanism are multiple background process wich are taking backups
* Detecting corruption in data files
  * you can validate your database
  * mechanism to identify and repair corruptions
* Validating Backup
  * mechanism to validate your backup
* Incremental Backup
  * the benefit is will take the incremental backup now from the last backup, saving spaces and time (backup)
* Recovery Catalog
  * mechanism reporting mechanism: "backups stored", "backups archived", "for how long I have backups"
  * backup metadata, can also be stored separated server 
  * separated server for metadata is intresting because if we loose the control file of database then we also loose backup metadata and you will not be able to recover database
* Multi destination Bacukps
* RMAN vs dtabase states
  * RMAN needs your database on minimum MOUNT STAGE when you are performing a backup and any state (from the scratch) when performing a restore
* You can take **BACKUP** of:
  * individual data file or tablespaces (collection of datafiles)
  * entire database backup
  * control file will be discussed later
* You can **RECOVER**:
  * individual data file or tablespaces (collection of datafiles)
  * entire database backup recovery / PITR (Point In Time Recovery)
  * datablock recovery
* RMAN reporting
* RMAN scripting: you can make only one script for multiple scenarios
* RMAN catalog: store metadata informations of your backups
* RMAN cloning: copy of your database
* RMAN Functionality
  * database has datafiles
  * RMAN executes commands / scripts to perform backup and restore
  * Backup Files are stored on Disks or Tapes
  * RMAN is a utility, runs in your server, connect to your server, stablishes channels with your server, channels are single connection background process that writes to one backup file per time and backup server databases to "backup files"
  * Parallelism can stablishes second channels to bacakup to a new backup files
* RMAN Utility
  * comes with Oracle Binaries, no special installation or license required, at command prompt just type rman, default connects to database environmental variables defined
  * RMAN utility can be used only when your dabase is at least MOUNT stage
  * RMAN is used while database is up and running and have very little performance impact if backup is running. Eventually some others resources should be allocated: CPU, Memory, etc


---

### 3.2. RMAN Configuration Parameters

* parameters which governs:
  * how to take backup, where to take backup, backup files properties
* must set proper parameters as per database
* can be over-written at RMAN command prompt
* proper RMAN configuration parameters results in high performance

#### Step-3.2.01: Connect Oracle Database Server

```wt
PS: > sh oracle@192.168.56.102
oracle@192.168.56.102's password: 
Activate the web console with: systemctl enable --now cockpit.socket
Last login: Wed Feb 14 14:25:00 2024
[oracle@localhost ~]$ 
```

#### Step-3.2.02: Check if database is running

```bash
[oracle@localhost ~]$  ps -ef | grep pmon
oracle      1837       1  0 14:24 ?        00:00:00 db_pmon_FREE
oracle      4097    3958  0 14:30 pts/2    00:00:00 grep --color=auto pmon
```

#### Step-3.2.03: Check enviroment variables

```bash
[oracle@localhost ~]$ env | grep ORA
ORACLE_UNQNAME=FREE
ORACLE_SID=FREE
ORACLE_BASE=/opt/oracle
ORACLE_HOME=/opt/oracle/product/23c/dbhomeFree
```

#### Step-3.2.04: Run RMAN utility - without connect to a database

```bash
[oracle@localhost ~]$ rman

Recovery Manager: Release 23.0.0.0.0 - Production on Wed Feb 14 14:37:39 2024
Version 23.3.0.23.09

Copyright (c) 1982, 2023, Oracle and/or its affiliates.  All rights reserved.

RMAN> exit
```

#### Step-3.2.05: Run RMAN utility - connect to your target database 

* Option no. 1: using identity and password directly on command line

```bash
[oracle@localhost ~]$ rman target sys/oracle

Recovery Manager: Release 23.0.0.0.0 - Production on Wed Feb 14 14:55:13 2024
Version 23.3.0.23.09

Copyright (c) 1982, 2023, Oracle and/or its affiliates.  All rights reserved.

connected to target database: FREE:FREEPDB1 (DBID=4002313426)

RMAN> exit
```

* Option no. 2: connection to (default) target database from RMAN Utility

```bash
[oracle@localhost ~]$ rman 
RMAN> connect target sys/oracle
connect target *
connected to target database: FREE:FREEPDB1 (DBID=4002313426)

RMAN> exit
```

* Option no. 3: connection to a specific target database (CDB) from RMAN Utility

```bash
[oracle@localhost ~]$ rman 
RMAN> connect target sys/oracle@FREE
connect target *
connected to target database: FREE (DBID=1419519205)

RMAN> exit
```

* Option no. 4: connection to a specific target database (PDB) from RMAN Utility

```bash
[oracle@localhost ~]$ rman 
RMAN> connect target sys/oracle@FREEPDB1
connect target *
connected to target database: FREE (DBID=1419519205)

RMAN> exit
```

#### Step-3.2.06: Run RMAN utility - show all parameters that govern RMAN utility


```bash
[oracle@localhost ~]$ rman 
RMAN> connect target sys/oracle
connect target *
connected to target database: FREE (DBID=1419519205)

RMAN> show all;
RMAN configuration parameters for database with db_unique_name FREE are:
CONFIGURE RETENTION POLICY TO REDUNDANCY 1; # default
CONFIGURE BACKUP OPTIMIZATION OFF; # default
CONFIGURE DEFAULT DEVICE TYPE TO DISK; # default
CONFIGURE CONTROLFILE AUTOBACKUP ON; # default
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '%F'; # default
CONFIGURE DEVICE TYPE DISK PARALLELISM 1 BACKUP TYPE TO BACKUPSET; # default
CONFIGURE DATAFILE BACKUP COPIES FOR DEVICE TYPE DISK TO 1; # default
CONFIGURE ARCHIVELOG BACKUP COPIES FOR DEVICE TYPE DISK TO 1; # default
CONFIGURE MAXSETSIZE TO UNLIMITED; # default
CONFIGURE ENCRYPTION FOR DATABASE OFF; # default
CONFIGURE ENCRYPTION ALGORITHM 'AES256'; # default
CONFIGURE COMPRESSION ALGORITHM 'BASIC' AS OF RELEASE 'DEFAULT' OPTIMIZE FOR LOAD TRUE ; # default
CONFIGURE RMAN OUTPUT TO KEEP FOR 7 DAYS; # default
CONFIGURE ARCHIVELOG DELETION POLICY TO NONE; # default
CONFIGURE SNAPSHOT CONTROLFILE NAME TO '/opt/oracle/product/23c/dbhomeFree/dbs/snapcf_FREE.f'; # default
```

#### Step-3.2.07: Run RMAN Configuration Parameter - CONFIGURE RETENTION POLICY

* There are 2 types of RETENTION POLICIES:
  * **REDUNDANCY**: configures number of copies. No backup turn obsolate in time. **strongly recommended**
  * **RECOVERY WINDOW**: configure number of last n days. Before n days all backups turn obsolete (cant be used for recovery)

```rman
RMAN> connect target sys/oracle@FREE

RMAN> CONFIGURE RETENTION POLICY TO REDUNDANCY 2;
CONFIGURE RETENTION POLICY TO REDUNDANCY 2;
old RMAN configuration parameters:
CONFIGURE RETENTION POLICY TO REDUNDANCY 1;
new RMAN configuration parameters:
CONFIGURE RETENTION POLICY TO REDUNDANCY 2;
new RMAN configuration parameters are successfully stored

RMAN> CONFIGURE RETENTION POLICY TO RECOVERY WINDOW OF 7 DAYS;
CONFIGURE RETENTION POLICY TO RECOVERY WINDOW OF 7 DAYS;
old RMAN configuration parameters:
CONFIGURE RETENTION POLICY TO REDUNDANCY 2;
new RMAN configuration parameters:
CONFIGURE RETENTION POLICY TO RECOVERY WINDOW OF 7 DAYS;
new RMAN configuration parameters are successfully stored

RMAN> CONFIGURE RETENTION POLICY TO REDUNDANCY 1;
      :
```

#### Step-3.2.08: Run RMAN Configuration Parameter - CONFIGURE BACKUP OPTIMIZATION

* There are 2 values for OPTIMIZATION:
  * **OFF**: No changes on files backuped. **strongly recommended**
  * **ON**: Optmization can suppress olders copies assuming that do not needs to copy twice data, but if you put your data on tape, you probably will not save all olders tapes for backup. So you can **LOST** data if you use this parameter without understading consequencies.

```rman
RMAN> connect target sys/oracle@FREE

RMAN> CONFIGURE BACKUP OPTIMIZATION OFF;
CONFIGURE BACKUP OPTIMIZATION OFF;
using target database control file instead of recovery catalog
new RMAN configuration parameters:
CONFIGURE BACKUP OPTIMIZATION OFF;
new RMAN configuration parameters are successfully stored
```


#### Step-3.2.09: Run RMAN Configuration Parameter - CONFIGURE DEFAULT DEVICE TYPE TO DISK

* There are 2 values for DEFAULT DEVICE TYPE TO:
  * **DISK**: Backup to disk
  * **TAPE**: Backup to tape

```rman
RMAN> connect target sys/oracle@FREE

RMAN> CONFIGURE DEFAULT DEVICE TYPE TO DISK;
CONFIGURE DEFAULT DEVICE TYPE TO DISK;
new RMAN configuration parameters:
CONFIGURE DEFAULT DEVICE TYPE TO DISK;
new RMAN configuration parameters are successfully stored
```

#### Step-3.2.10: Run RMAN Configuration Parameter - CONFIGURE CONTROLFILE AUTOBACKUP

* There are 2 values for CONTROLFILE AUTOBACKUP:
  * **OFF**: If you loose control file you also loose backups
  * **ON**: Copy entire controlefile to a backup. **strongly recommended**
* To perform PIT (Point in Time) recovery you also need Controle File
* 

```rman
RMAN> connect target sys/oracle@FREE

RMAN>  CONFIGURE CONTROLFILE AUTOBACKUP ON;
 CONFIGURE CONTROLFILE AUTOBACKUP ON;
old RMAN configuration parameters:
CONFIGURE CONTROLFILE AUTOBACKUP OFF;
new RMAN configuration parameters:
CONFIGURE CONTROLFILE AUTOBACKUP ON;
new RMAN configuration parameters are successfully stored
```

#### Step-3.2.11: Run RMAN Configuration Parameter - CONFIGURE CONTROLFILE AUTOBACKUP FORMAT

* There are 2 values for CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '%f':
  * **'%f'**: If you loose control file you also loose backups
* Works only if you enable CONFIGURE CONTROLFILE AUTOBACKUP ON
* This command has qualifier [ DISK, SBT ] disk or tape
* Fix format control_file name

```rman
RMAN> connect target sys/oracle@FREE

RMAN>  CONFIGURE CONTROLFILE AUTOBACKUP ON;
 CONFIGURE CONTROLFILE AUTOBACKUP ON;
old RMAN configuration parameters:
CONFIGURE CONTROLFILE AUTOBACKUP OFF;
new RMAN configuration parameters:
CONFIGURE CONTROLFILE AUTOBACKUP ON;
new RMAN configuration parameters are successfully stored
```

#### Step-3.2.12: Run RMAN Configuration Parameter - CONFIGURE DEVICE TYPE DISK PARELLELISM 1 BACKUP TYPE TO BACKUPSET

* There are 2 values for CONFIGURE DEVICE TYPE:
  * **DISK PARALLELISM n BACKUP TYPE BACKUPSET**: Use only 1 (one) channel allocated
* `SELECT * FROM V$DATAFILE` show all datafiles to be backuped

```rman
RMAN> connect target sys/oracle@FREE

RMAN> CONFIGURE DEVICE TYPE DISK PARALLELISM 1 BACKUP TYPE TO BACKUPSET;
CONFIGURE DEVICE TYPE DISK PARALLELISM 1 BACKUP TYPE TO BACKUPSET;
new RMAN configuration parameters:
CONFIGURE DEVICE TYPE DISK PARALLELISM 1 BACKUP TYPE TO BACKUPSET;
new RMAN configuration parameters are successfully stored
```

#### Step-3.2.12: Run RMAN Configuration Parameter - CONFIGURE DATAFILE BACKUP COPIES FOR DEVICE TYPE DISK TO 1;

* There are 2 values for CONFIGURE DATAFILE BACKUP COPIES FOR DEVICE TYPE DISK TO:
  * **<n>**: Number of copies of each file

```rman
RMAN> connect target sys/oracle@FREE

RMAN> CONFIGURE DATAFILE BACKUP COPIES FOR DEVICE TYPE DISK TO 1;
CONFIGURE DATAFILE BACKUP COPIES FOR DEVICE TYPE DISK TO 1;
new RMAN configuration parameters:
CONFIGURE DATAFILE BACKUP COPIES FOR DEVICE TYPE DISK TO 1;
new RMAN configuration parameters are successfully stored
```

#### Step-3.2.13: Run RMAN Configuration Parameter - CONFIGURE MAXSETSIZE TO UNLIMITED

* There are multiples values for CONFIGURE MAXSETSIZE TO :
  * **UNLIMITED**: Unlimited value
  * **<n>**: Limit size to n Bytes

```rman
RMAN> connect target sys/oracle@FREE

RMAN> CONFIGURE DATAFILE BACKUP COPIES FOR DEVICE TYPE DISK TO 1;
CONFIGURE DATAFILE BACKUP COPIES FOR DEVICE TYPE DISK TO 1;
new RMAN configuration parameters:
CONFIGURE DATAFILE BACKUP COPIES FOR DEVICE TYPE DISK TO 1;
new RMAN configuration parameters are successfully stored
```

#### Step-3.2.14: Run RMAN Configuration Parameter - CONFIGURE ENCRYPTION FOR DATABASE

* There are multiples values for CONFIGURE ENCRYPTION FOR DATABASE:
  * **OFF**: Backup set will not be encrypted
  * **ON**:  Backup set will be be encrypted before saving

```rman
RMAN> connect target sys/oracle@FREE

RMAN>  CONFIGURE ENCRYPTION FOR DATABASE ON;
 CONFIGURE ENCRYPTION FOR DATABASE ON;
new RMAN configuration parameters:
CONFIGURE ENCRYPTION FOR DATABASE ON;
new RMAN configuration parameters are successfully stored

RMAN>  CONFIGURE ENCRYPTION FOR DATABASE OFF;
 CONFIGURE ENCRYPTION FOR DATABASE OFF;
old RMAN configuration parameters:
CONFIGURE ENCRYPTION FOR DATABASE ON;
new RMAN configuration parameters:
CONFIGURE ENCRYPTION FOR DATABASE OFF;
new RMAN configuration parameters are successfully stored
```

#### Step-3.2.15: Run RMAN Configuration Parameter - CONFIGURE ENCRYPTION ALGORITHM

* There are multiples values for CONFIGURE ENCRYPTION ALGORITHM:
  * **'AES256'**: 'AES256' algorithm

```rman
RMAN> connect target sys/oracle@FREE

RMAN> CONFIGURE ENCRYPTION ALGORITHM 'AES256';
CONFIGURE ENCRYPTION ALGORITHM 'AES256';
new RMAN configuration parameters:
CONFIGURE ENCRYPTION ALGORITHM 'AES256';
new RMAN configuration parameters are successfully stored
```

#### Step-3.2.16: Run RMAN Configuration Parameter - CONFIGURE COMPRESSION ALGORITHM

* There are multiples values for CONFIGURE COMPRESSION ALGORITHM:
  * **'BASIC'**: 'BASIC' algorithm

```rman
RMAN> connect target sys/oracle@FREE

RMAN> CONFIGURE COMPRESSION ALGORITHM 'BASIC' AS OF RELEASE 'DEFAULT' OPTIMIZE FOR LOAD TRUE;
CONFIGURE COMPRESSION ALGORITHM 'BASIC' AS OF RELEASE 'DEFAULT' OPTIMIZE FOR LOAD TRUE;
new RMAN configuration parameters:
CONFIGURE COMPRESSION ALGORITHM 'BASIC' AS OF RELEASE 'DEFAULT' OPTIMIZE FOR LOAD TRUE;
new RMAN configuration parameters are successfully stored
```

#### Step-3.2.17: Run RMAN Configuration Parameter - CONFIGURE ARCHIVELOG DELETION POLICY TO

* There are multiples values for CONFIGURE ARCHIVELOG DELETION POLICY TO:
  * **NONE**: None policy

```rman
RMAN> connect target sys/oracle@FREE

RMAN>  CONFIGURE ARCHIVELOG DELETION POLICY TO NONE;
 CONFIGURE ARCHIVELOG DELETION POLICY TO NONE;
new RMAN configuration parameters:
CONFIGURE ARCHIVELOG DELETION POLICY TO NONE;
new RMAN configuration parameters are successfully stored
```

#### Step-3.2.18: Run RMAN Configuration Parameter - CONFIGURE SNAPSHOT CONTROLFILE NAME TO

* There are multiples values for CONFIGURE SNAPSHOT CONTROLFILE NAME TO:
  * **<path>**: Ex: '/opt/oracle/product/23c/dbhomeFree/dbs/snapcf_FREE.f';

```rman
RMAN> connect target sys/oracle@FREE

RMAN> CONFIGURE SNAPSHOT CONTROLFILE NAME TO '/opt/oracle/product/23c/dbhomeFree/dbs/snapcf_FREE.f';
CONFIGURE SNAPSHOT CONTROLFILE NAME TO '/opt/oracle/product/23c/dbhomeFree/dbs/snapcf_FREE.f';
new RMAN configuration parameters:
CONFIGURE SNAPSHOT CONTROLFILE NAME TO '/opt/oracle/product/23c/dbhomeFree/dbs/snapcf_FREE.f';
new RMAN configuration parameters are successfully stored
```

---

### 3.3. RMAN Channels and Parallelism

* Introduction to RMAN Channels and Parallelism
* Types of Channels in RMAN
  * Channels connect your database to backup pieces
  * There are 2 types:
    1. Automatic channels:
      * these types of channels are allocated when there is no channel explicitly specified during the backup command / script
      * Allocated when you run backup, estore, recover commands
    2. Manual channels:
      * these channels are allocated whenn you specify channels manually inside a backup script
      * if manually channles are allocated, automatich channels are ignored
      * defnied manually under RMAN run block
* Configure default device type with parallelism 1


#### Step-3.3.01: Configure default device type with parallelism 1

* this parameter can be over-written within RMAN block

```rman
RMAN> connect target sys/oracle@FREE

RMAN> show device type;
show device type;
RMAN configuration parameters for database with db_unique_name FREE are:
CONFIGURE DEVICE TYPE DISK PARALLELISM 1 BACKUP TYPE TO BACKUPSET;

RMAN> CONFIGURE DEVICE TYPE DISK PARALLELISM 2;
CONFIGURE DEVICE TYPE DISK PARALLELISM 2;
old RMAN configuration parameters:
CONFIGURE DEVICE TYPE DISK PARALLELISM 1 BACKUP TYPE TO BACKUPSET;
new RMAN configuration parameters:
CONFIGURE DEVICE TYPE DISK PARALLELISM 2 BACKUP TYPE TO BACKUPSET;
new RMAN configuration parameters are successfully stored

RMAN> CONFIGURE DEVICE TYPE DISK PARALLELISM 1;
CONFIGURE DEVICE TYPE DISK PARALLELISM 1;
using target database control file instead of recovery catalog
old RMAN configuration parameters:
CONFIGURE DEVICE TYPE DISK PARALLELISM 2 BACKUP TYPE TO BACKUPSET;
new RMAN configuration parameters:
CONFIGURE DEVICE TYPE DISK PARALLELISM 1 BACKUP TYPE TO BACKUPSET;
new RMAN configuration parameters are successfully stored
```

---

### 3.4. RMAN First Backup

* Databases on NOARCHIVELOG mode can not be backuped by RMAN
* First check your database archivelog mode and adjust configurations path


#### Step-3.4.01: Unsuccessfully try to run RMAN in a NOARCHIVELOG mode database

```rman
RMAN> BACKUP DATABASE;
BACKUP DATABASE;
Starting backup at 14-FEB-24
allocated channel: ORA_DISK_1
channel ORA_DISK_1: SID=262 device type=DISK
RMAN-00571: ===========================================================
RMAN-00569: =============== ERROR MESSAGE STACK FOLLOWS ===============
RMAN-00571: ===========================================================
RMAN-03002: failure of backup command at 02/14/2024 18:32:52
RMAN-06149: cannot BACKUP DATABASE in NOARCHIVELOG mode

RMAN> exit
```


#### Step-3.4.02: Change your database mode from NOARCHIVEOG to ARCHIVELOG

* Connect to FREE CDB instance as SYS

```bash
[oracle@localhost ~]$ sqlplus sys@localhost:1521/FREE as sysdba

SQL*Plus: Release 23.0.0.0.0 - Production on Wed Feb 14 19:32:15 2024
Version 23.3.0.23.09

Copyright (c) 1982, 2023, Oracle.  All rights reserved.

Enter password: 

Connected to:
Oracle Database 23c Free Release 23.0.0.0.0 - Develop, Learn, and Run for Free
Version 23.3.0.23.09

SQL> archive log list
Database log mode	       No Archive Mode
Automatic archival	       Disabled
Archive destination	       /opt/oracle/product/23c/dbhomeFree/dbs/arch
Oldest online log sequence     13
Current log sequence	       12

SQL> ! df -h /opt
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda3        25G  6.1G   19G  25% /


SQL> ! ls -la /opt/oracle/product/23c/dbhomeFree/dbs
total 24
drwxr-xr-x.  2 oracle oinstall   94 Feb 14 14:24 .
drwxrwxr-x. 63 oracle oinstall 4096 Sep 13 19:50 ..
-rw-rw----.  1 oracle oinstall 1544 Feb 14 14:24 hc_FREE.dat
-rw-r-----.  1 oracle oinstall 3079 May 14  2015 init.ora
-rw-r-----.  1 oracle oinstall   24 Sep 13 19:34 lkFREE
-rw-r-----.  1 oracle oracle   2048 Sep 13 19:36 orapwFREE
-rw-r-----.  1 oracle oinstall 3584 Feb 14 14:24 spfileFREE.ora

SQL> -- create sub-folder for ./arch
SQL> ! mkdir -p /opt/oracle/product/23c/dbhomeFree/dbs/arch

SQL> ! ls -la /opt/oracle/product/23c/dbhomeFree/dbs
total 24
drwxr-xr-x.  3 oracle oinstall  106 Feb 14 18:38 .
drwxrwxr-x. 63 oracle oinstall 4096 Sep 13 19:50 ..
drwxrwxr-x.  2 oracle oracle      6 Feb 14 18:38 arch
-rw-rw----.  1 oracle oinstall 1544 Feb 14 14:24 hc_FREE.dat
-rw-r-----.  1 oracle oinstall 3079 May 14  2015 init.ora
-rw-r-----.  1 oracle oinstall   24 Sep 13 19:34 lkFREE
-rw-r-----.  1 oracle oracle   2048 Sep 13 19:36 orapwFREE
-rw-r-----.  1 oracle oinstall 3584 Feb 14 14:24 spfileFREE.ora



--
-- ********************************************************************************
--
-- ********************************************************************************
--

SQL> -- configurar o archive para o scope=spfile
SQL> ALTER SYSTEM SET log_archive_dest_1='LOCATION=/opt/oracle/product/23c/dbhomeFree/dbs/arch' SCOPE=spfile;

System altered.

SQL> SHUTDOWN IMMEDIATE
Database closed.
Database dismounted.
ORACLE instance shut down.
ERROR:
ORA-12514: Cannot connect to database. Service FREE is not registered with the
listener at host 127.0.0.1 port 1521. (CONNECTION_ID=EV2RozTQKW3gYwEAAH/Wew==)
Help: https://docs.oracle.com/error-help/db/ora-12514/


Warning: You are no longer connected to ORACLE.

SQL> exit
Disconnected from Oracle Database 23c Free Release 23.0.0.0.0 - Develop, Learn, and Run for Free
Version 23.3.0.23.09


[oracle@localhost ~]$ sqlplus sys/oracle as sysdba

SQL*Plus: Release 23.0.0.0.0 - Production on Wed Feb 14 18:44:23 2024
Version 23.3.0.23.09

Copyright (c) 1982, 2023, Oracle.  All rights reserved.


Connected to:
Oracle Database 23c Free Release 23.0.0.0.0 - Develop, Learn, and Run for Free
Version 23.3.0.23.09

SQL> SELECT log_mode FROM v$database;

SQL> ALTER DATABASE ARCHIVELOG;
ALTER DATABASE ARCHIVELOG
*
ERROR at line 1:
ORA-65040: Operation is not allowed from within a pluggable database.
Help: https://docs.oracle.com/error-help/db/ora-65040/


SQL> 


SQL> -- repeat switch log some times to generate logs
SQL> ALTER SYSTEM SWITCH LOGFILE;
SQL> ALTER SYSTEM SWITCH LOGFILE;
SQL> ALTER SYSTEM SWITCH LOGFILE;

System altered.

SQL> 
```


#### Step-3.4.03: Configure default device type with parallelism 2

* _to-be-defined_

#### Step-3.4.04: Configure default channel

* _to-be-defined_


---

### 3.5. RMAN Backup Types

* _to-be-defined_

---

### 3.6. Taking RMAN Backups

* _to-be-defined_

---

### 3.7. Summary

* _to-be-defined_

---


# References

* https://docs.oracle.com/en/database/oracle/oracle-database/19/bradv/configuring-rman-client-basic.html#GUID-AD92E09D-0788-4AB5-8792-5F969C8D237A
* https://docs.oracle.com/en/database/oracle/oracle-database/21/rcmrf/quick-reference-rman-commands.html#GUID-82A8D1AB-D399-4DBD-B4D1-C90D2B7CC6AD