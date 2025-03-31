# study-database - Oracle - Performance

<p align="right">voltar para [study-database - Oracle](../README.md)</p>

## Índice

* [Physical Structure of the Oracle Database](#1-physical-structure-of-the-oracle-database)
  * [Datafiles](#11-datafiles)
  * [Control Files](#12-control-files)
  * [Redo Log Files](#13-redo-log-files)
  * [Archive Log Files](#14-archive-log-files)
  * [Undo Tablespace](#15-undo-tablespace)
  * [Temporary Tablespace](#16-temporary-tablespace)
  * [Best Practices for Performance Optimization](#17-best-practices-for-performance-optimization)
* [2. Logical Structure of the Oracle Database
  * [Tablespaces](#2-logical-structure-of-the-oracle-database)
  * [Segments](#21-tablespaces)
  * [Extents](#22-segments)
  * [Data Blocks](#23-extents)


---

## 1. Physical Structure of the Oracle Database
The physical structure represents the operating system files that store the database data. These files include:

### 1.1. Datafiles

* Contain table data, indexes, and other objects.
* Associated with tablespaces, which organize logical storage.
* Can be placed on different disks for load balancing (I/O).
* Performance tuning: Monitor I/O, distribute across multiple disks, and use Bigfile Tablespaces for large data volumes.


### 1.2. Control Files

* Essential files that store the database structure.
* Contain information about datafiles, redo logs, checkpoint numbers, etc.
* Performance tuning: Should be multiplexed to avoid critical failures.


### 1.3. Redo Log Files

* Store all database changes before being written to datafiles.
* Used for recovery in case of failure.
* Performance tuning:
  * Proper sizing to avoid frequent checkpoints.
  * Multiplexing for reliability.
  * Using groups and multiple members for improved recovery.


### 1.4. Archive Log Files

* If the database is in ARCHIVELOG mode, contain copies of redo logs used for recovery.
* Performance tuning: 
  * Monitor disk space to prevent database downtime.


### 1.5. Undo Tablespace

* Stores information for rollbacks and consistency control.
* Performance tuning:
  * Proper Undo Tablespace sizing to prevent errors like "ORA-01555: snapshot too old".
  * Monitoring with V$UNDOSTAT.


### 1.6. Temporary Tablespace

* Used for operations requiring temporary space, such as sorting and complex joins.
* Performance tuning:
  * Monitoring with V$TEMPSEG_USAGE to prevent space errors.
  * Using BIGFILE TEMPORARY TABLESPACE for large data volumes.


### 1.7. Best Practices for Performance Optimization

* Separate datafiles from redo logs and temporary files to distribute I/O load.
* Avoid uncontrolled autoextend to prevent excessive fragmentation.
* Use dedicated tablespaces for indexes and data to optimize read/write efficiency.
* Monitor undo and temporary tablespaces to prevent failures in large transactions.
* Utilize partitioning for large tables to improve query performance.


---

## 2. Logical Structure of the Oracle Database

The logical structure organizes data within the physical files.

### 2.1. Tablespaces

* Logical groupings of data segments stored in **datafiles**.
* Important types of tablespaces:
  * SYSTEM and SYSAUX: Manage database metadata.
  * USERS: Store user data.
  * UNDO: Manage transactions and rollback.
  * TEMP: Used for temporary operations.
  * Performance tuning:
    * Separate data and index tablespaces to optimize read/write operations.
    * Use ASSM (Automatic Segment Space Management) for better space management.


### 2.2. Segments
Storage units within tablespaces.

* Types:
  * Table Segments: Store table data.
  * Index Segments: Contain indexes.
  * Undo Segments: Used for rollbacks.
  * Temporary Segments: Created during queries that use temporary space.

* Performance tuning:
  * Avoid excessive segmentation with properly configured Autoextend.
  * Monitor fragmentation using DBMS_SPACE.ADMIN_SEGMENT.


### 2.3. Extents

A set of data blocks allocated to a segment.

* Performance tuning:
  * Avoid excessive fragmentation by adjusting storage parameters (INITIAL, NEXT, PCTINCREASE).


### 2.4. Data Blocks

The smallest storage unit in Oracle (default size is 8 KB).

* Performance tuning:
  * Adjust DB_BLOCK_SIZE to optimize I/O operations.
  * Monitor PCTFREE and PCTUSED to optimize free space within blocks.


### 2.5. 3. Best Practices for Performance Optimization

* Separate datafiles from redo logs and temporary files to distribute I/O load.
* Avoid uncontrolled autoextend to prevent excessive fragmentation.
* Use dedicated tablespaces for indexes and data to optimize read/write efficiency.
* Monitor undo and temporary tablespaces to prevent failures in large transactions.
* Utilize partitioning for large tables to improve query performance.

---

