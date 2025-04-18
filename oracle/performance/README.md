# [study-database - Oracle](../README.md) - Performance

## Mind Map - Oracle - Performance
![Mind Map - Oracle - Performance](../../doc/mind-maps/MindMapDiagram-DatabaseStudy-Oracle-Performance.png) 


## Index

* [1. Physical Structure of the Oracle Database](#1-physical-structure-of-the-oracle-database)
  * [1.1. Datafiles](#11-datafiles)
  * [1.2. Control Files](#12-control-files)
  * [1.3. Redo Log Files](#13-redo-log-files)
  * [1.4. Archive Log Files](#14-archive-log-files)
  * [1.5. Undo Tablespace](#15-undo-tablespace)
  * [1.6. Temporary Tablespace](#16-temporary-tablespace)
  * [1.7. Best Practices for Performance Optimization](#17-best-practices-for-performance-optimization)
  * [1.8. References](#18-references)
* [2. Logical Structure of the Oracle Database](#2-logical-structure-of-the-oracle-database)
  * [2.1. Tablespaces](#21-tablespaces)
  * [2.2. Segments](#22-segments)
  * [2.3. Extents](#23-extents)
  * [2.4. Data Blocks](#24-data-blocks)
  * [2.5. Best Practices for Performance Optimization](#25-best-practices-for-performance-optimization)
  * [2.6. References](#26-references)
* [3. Understanding the Oracle Optimizer](#3-understanding-the-oracle-optimizer)
  * [3.1. How the Optimizer Works](#31-how-the-optimizer-works)
  * [3.2. Execution Plan (EXPLAIN PLAN)](#32-execution-plan-explain-plan)
  * [3.3. Execution Plan (SQLDeveloper)](#33-execution-plan-sqldeveloper) ![star-icon.png](../../doc/images/star-icon.png)
  * [3.4. Execution Plan (SQL*Plus)](#34-execution-plan-sqlplus)
  * [3.5. Statistics - Correlations, Extended Statistics, Cardinality and Selectivity](#35-statistics---correlations-extended-statistics-cardinality-and-selectivity)
  * [3.99. References](#399-references)
* [4. Identifying Performance Bottlenecks](#4-identifying-and-diagnosticing-performance-bottlenecks)
  * [4.1 Using v$ views for Query Monitoring](#41-using-v-views-for-query-monitoring)
  * [4.2 Monitoring Performance over Time AWR](#42-monitoring-performance-over-time-with-awr-and-ash)
  * [4.3 Look for Locks and DeadLocks](#43-look-for-locks-and-deadlocks)
  * [4.4 Diagnostics with Oracle Enterprise Manager OEM](#44-diagnostics-with-oracle-enterprise-manager-oem)
* [5. Optimizing Performance Issues Identified](#5-optimizing-performance-issues-identified)
  * [5.1. Optimizing SQL Queries - Indexing Strategies](#51-optimizing-sql-queries---indexing-strategies)
    * [5.1.a. B-tree Index](#51a-b-tree-index)
    * [5.1.b. Bitmap Index](#51b-bitmap-index)
    * [5.1.c. Function-Based Index](#51c-function-based-index)
    * [5.1.d. Partitioned Index](#51d-partitioned-index)
    * [5.1.e. Check Index Usage](#51e-check-index-usage)
    * [5.1.f. Clustering Factor](#51f-clustering-factor)
    * [5.1.g. Index Reverse Key](#51g-index-reverse-key)
    * [5.1.h. Index Organized Table](#51h-index-organized-table)
  * [5.2. Optimizing SQL Queries - Others Strategies](#52-optimizing-sql-queries---others-strategies)
    * [5.2.a. Bind Variables vs. Literals](#52a-optimizing-sql-queries---bind-variables-vs-literals)
    * [5.2.b. Avoiding SELECT *](#52b-avoiding-select-)
    * [5.2.c. EXISTS vs. IN](#52c-exists-vs-in)
    * [5.2.d. In-Memory Table and Columns](#52d-in-memory-table-and-columns)
      * [5.2.d.1. On Regular Oracle Infrastructure (non-Exadata)](#52d1-on-regular-oracle-infrastructure-non-exadata)
      * [5.2.d.2. 5.2.d.2. On On Exadata](#52d2-on-on-exadata) ![star-icon.png](../../doc/images/star-icon.png)
    * [5.2.e. Cursor Optimization](#52e-cursor-optimization)
  * [5.3. Optimizing Joins and Aggregations](#53-optimizing-joins-and-aggregations)
      * [5.3.a. Choosing the Right Join Type](#531-choosing-the-right-join-type)
      * [5.3.b. Using the RIGHT Aggregation Strategy](#532-using-the-right-aggregation-strategy)
  * [5.4. Encoding issues: when using EBCDIC](#54-encoding-issues-when-using-ebcdic) ![star-icon.png](../../doc/images/star-icon.png)
    * [5.4.a. Character Set Conversion](#54a-character-set-conversion)
    * [5.4.b. NLS_LANG and charset mismatch](#54b-nls_lang-and-charset-mismatch)
    * [5.4.c. Data integrity during transfer](#54c-data-integrity-during-transfer)
    * [5.4.d. Performance considerations](#54d-performance-considerations)
    * [5.4.e. Indexing and Sorting](#54e-indexing-and-sorting)
    * [5.4.f. Application level handling](#54f-application-level-handling)
    * [5.4.g. Recommended strategy](#54g-recommended-strategy)
  * [5.5. Use of Hints](#55-use-of-hints) ![star-icon.png](../../doc/images/star-icon.png)
    * [5.5.a.Hints for Optimization Approaches and Goals](#55a-hints-for-optimization-approaches-and-goals)
    * [5.5.b.Hints for Access Paths](#55b-hints-for-access-paths)
    * [5.5.c.Hints for Query Transformations](#55c-hints-for-query-transformations)
    * [5.5.d.Hints for Join Orders](#55d-hints-for-join-orders)
    * [5.5.e.Hints for Join Operations](#55e-hints-for-join-operations)
    * [5.5.f.Hints for Parallel Execution](#55f-hints-for-parallel-execution)
    * [5.5.g. Additional Hints](#55g-additional-hints)
* [6. Table Partitioning](#6-table-partitioning)
  * [6.1. Range Partitioning](#61-range-partitioning)
  * [6.2. Hash Partitioning](#62-hash-partitioning)
  * [6.3. Partition Pruning](#63-partition-pruning)
  * [6.4. Partition zone maps Exadata](#64-partition-zone-maps-exadata)
  * [6.5. Drop Partition](#65-drop-partition)
  * [6.6. Query Partition](#66-query-partition)
* [7. Parallel Execution](#7-parallel-execution)
  * [7.1. Using Parallel Queries](#71-using-parallel-queries)
* [I. Laboratories](#i-laboratories) ![star-icon.png](../../doc/images/star-icon.png)
  * [I.1. Create Sample Tables using scripts](#ilab-1-create-sample-tables-using-scripts)
  * [I.2. Query metrics scenario INITIAL](#ilab-2-query-metrics-scenario-initial)
  * [I.3. Query by Indexed Primary Key Columns](#ilab-3-query-by-indexed-primary-key-columns)
  * [I.4. Query by Non Indexed Columns](#ilab-4-query-by-non-indexed-columns)
  * [I.5. Query by Non Indexed Columns vs Indexed Columns](#ilab-5-query-by-non-indexed-columns-vs-indexed-columns)
  * [I.6. Query by Indexed Columns, Low Selectivity, Data Skew](#ilab-6-query-by-indexed-columns-low-selectivity-data-skew)
  * [I.7. Query by Indexed Columns vs Selectivity vs Rule of Thumb](#ilab-7-query-by-indexed-columns-vs-selectivity-vs-rule-of-thumb)
  * [I.8. Query by Indexed Columns vs Selectivity vs Hint Use Index](#ilab-8-query-by-indexed-columns-vs-selectivity-vs-hint-use-index)
  * [I.9. Query by Indexed Columns vs Parallel vs Hint No Parallel](#ilab-9-query-by-indexed-columns-vs-parallel-vs-hint-no-parallel)
  * [I.10. Query by Indexed Columns vs High Clustering Factor](#ilab-10-query-by-indexed-columns-vs-high-clustering-factor)
  * [I.11. Query by Indexed Columns vs Function Based Index](#ilab-11-query-by-indexed-columns-vs-function-based-index)
* [II. Performance Tuning CheatSheet](#ii-performance-tuning-cheatsheet)
  * [II.1. Turn TRACE ON/OFF EXPLAIN PLAN](#ii-cheatsheet1-turn-trace-onof-explain-plan-execution-plan-golden-step)
  * [II.2. Query Object Statistics](#ii-cheatsheet2-query-object-statistics)
  * [II.3. Query Indexed Columns](#ii-cheatsheet3-query-indexed-columns)
  * [II.99. Quick Wins, Blogs, Vlogs, etc](#ii-cheatsheet99-quick-wins-blogs-vlogs-etc)
    * [II.99.a. Default Simple Response, Quick Wins, What should you do](#ii-cheatsheet99a-default-simple-response-quick-wins-what-should-you-do)
    * [II.99.b. Usefull Commands](#ii-cheatsheet99b-usefull-commands)
    * [II.99.c. Usefull Commands - Limit number of rows outputed](#ii-cheatsheet99c-usefull-commands---limit-number-of-rows-outputed)
    * [II.99.d. SQLDeveloper Hands On](#ii-cheatsheet99d-sqldeveloper-hands-on) ![star-icon.png](../../doc/images/star-icon.png)
      * [II.99.d.1. Execute one command on SQLDevelopers](#ii-cheatsheet99d1-execute-one-command-on-sqldevelopers)
      * [II.99.d.2. Execute more than one command at once](#ii-cheatsheet99d2-execute-more-than-one-command-at-once)
      * [II.99.d.3. Execute a command get execution plan (incomplete) and get statistics (incomplete) like using SET AUTOT TRACE EXPL STAT on SQLPlus](#ii-cheatsheet99d3-execute-a-command-get-execution-plan-incomplete-and-get-statistics-incomplete-like-using-set-autot-trace-expl-stat-on-sqlplus)
      * [II.99.d.4. Execute a command get execution plan like using SET AUTOT TRACE EXPL STAT on SQLPlus](#ii-cheatsheet99d4-execute-a-command-and-get-execution-plan-like-using-set-autot-trace-expl-stat-on-sqlplus)
      * [II.99.d.5. Execute a command, get execution plan using icon-button SQLDeveloper Explain Plan ... (F10)](#ii-cheatsheet99d5-execute-a-command-get-execution-plan-using-icon-button-sqldeveloper-explain-plan--f10)
      * [II.99.d.6. Execute a command, get execution plan and statistics like using SET AUTOT TRACE EXPL STAT on SQL*Plus](#ii-cheatsheet99d6-execute-a-command-get-execution-plan-and-statistics-like-using-set-autot-trace-expl-stat-on-sqlplus)
      * [II.99.d.7. Execute a command, get execution plan and statistics using icon-button SQLDeveloper Autotrace ... (F6)](#ii-cheatsheet99d7-execute-a-command-get-execution-plan-and-statistics-using-icon-button-sqldeveloper-autotrace--f6)
      * [II.99.d.7. User's GRANTS required to execute `Autotrace (F6) ...` On SQLDeveloper ](#ii-cheatsheet99d8-users-grants-required-to-execute-autotrace-f6--on-sqldeveloper)


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


### 1.8. References

* Official Documentation
  * [Oracle Database](https://docs.oracle.com/en/database/oracle/oracle-database/index.html)
  * [Oracle Database - Administration](https://docs.oracle.com/en/database/oracle/oracle-database/23/administration.html)
  * [Oracle Database - Administration - SQL Tuning Guide](https://docs.oracle.com/en/database/oracle/oracle-database/23/tgsql/index.html)
* Blog/Videos
  * [Video: Oracle Database Architecture - Part1](https://www.youtube.com/watch?v=cvx9wCQZnKw): Chapters: database & instance, memory structures, type of process, server process, background process, putting all together
* Laboratories / [Quick Wins, Blogs, Vlogs, etc](#ii-cheatsheet99-quick-wins-blogs-vlogs-etc)
  * `under-construction`

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


### 2.5. Best Practices for Performance Optimization

* Separate datafiles from redo logs and temporary files to distribute I/O load.
* Avoid uncontrolled autoextend to prevent excessive fragmentation.
* Use dedicated tablespaces for indexes and data to optimize read/write efficiency.
* Monitor undo and temporary tablespaces to prevent failures in large transactions.
* Utilize partitioning for large tables to improve query performance.


### 2.6. References

* Official Documentation
  * `under-construction`
* Blog/Videos
  * [Video: Oracle Database Architecture - Part1](https://www.youtube.com/watch?v=cvx9wCQZnKw): Chapters: single instance & RAC, logical storage structures
* Laboratories / [Quick Wins, Blogs, Vlogs, etc](#ii-cheatsheet99-quick-wins-blogs-vlogs-etc)
  * `under-construction`



---

## 3. Understanding the Oracle Optimizer

The Cost-Based Optimizer (CBO) is responsible for determining the most efficient way to execute a query.

### 3.1. How the Optimizer Works

* The CBO evaluates multiple execution plans and selects the one with the lowest estimated cost
* It relies on statistics (table size, index distribution, data distribution) to make decisions
* Uses histograms to improve accuracy for columns with skewed data distributions
* Performance Tip: Keep statistics up to date using


```sql
EXEC DBMS_STATS.GATHER_SCHEMA_STATS('your_schema');
-- or ...
EXEC DBMS_STATS.GATHER_TABLE_STATS('your_schema', 'your_table');
```

### 3.2. Execution Plan (EXPLAIN PLAN)

To analyze how Oracle executes a query, use:

```sql
EXPLAIN PLAN FOR
SELECT * FROM orders WHERE order_date = '2024-01-01';
-- or ...
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
```
Look for costly operations like TABLE ACCESS FULL, which usually indicates a full table scan.


### 3.3. Execution Plan (SQLDeveloper)

* Open `SQLDeveloper`
  * Click menu-item `SQLDeveloper` :: `Tools >> Preferences`
  * On dialog-box `Preferences` fill text-box left-top-level with value `autotr` 
  * On dialog-box `Preferences` list-box-hierarchical `Database >> Autotrace/Explain Plan` check-select auto-trace-listbox `Autotrace` the followings keys and click `OK`

```sqldeveloper-tools-preferences-dialog-box
Autotrace
 [LAST_OUTPUT_ROWS]
 [LAST_STARTS]

[X] Fetch all rows
```

Now in `SQLDeveloper` worksheet, when you choose (F6) or icon `Autotrace...` columns for metrics `LAST_OUTPUT_ROWS` AND `LAST_STARTS` will be shown


### 3.4. Execution Plan (SQL*Plus)

```sql
set lines 999
set pages 999
set autot trace exp stat 
set autot trace off
set timing on
```

### 3.5. Statistics - Correlations, Extended Statistics, Cardinality and Selectivity

* [Correlations](https://www.youtube.com/watch?v=IYWmauKtwXI&t=220s), [Extended Statistics](https://www.youtube.com/watch?v=IYWmauKtwXI&t=299s) and [Skews](https://www.youtube.com/watch?v=IYWmauKtwXI&t=330s) ![star-icon.png](../../doc/images/star-icon.png)
* Cardinality:
  - Cardinality: total rows of table. Ex: `select 1 / COUNT(1) from STUDY.customers`; Result: `200.000`
  - Cardinality(total rows operation): `rows estimated = Selectivity * Cardinality`; Ex: `0.5 * 200000`; Results: `200000`
* Selectivity:
  - Selectivity: proportion. ` 1 / number_of_distinct * total_rows`; Ex: `select 1 / COUNT(DISTINCT customer_type_id) /* 2: 'F', 'J' */ from STUDY.customers`; Result: `0.5`


### 3.6. Data Access Method

* [Data Access Method](https://techiedba.wordpress.com/2011/08/12/data-access-methods-in-oracle/):

#### 3.6.a. Full Table SCAN (FTS)

* `under-construction`

#### 3.6.b. Table Access by ROW-ID

* `under-construction`

#### 3.6.c. Index Unique Scan

* `under-construction`

#### 3.6.d. Index Range Scan

* `under-construction`

#### 3.6.e. Index Skip Scan

* `under-construction`

#### 3.6.f. Full Index Scan

* `under-construction`

#### 3.6.g. Fast Full Index Scans

* `under-construction`

#### 3.6.h. Index Joins

* `under-construction`

#### 3.6.i. Hash Access

* `under-construction`

#### 3.6.j. Cluster Access

* `under-construction`

#### 3.6.k. Bit Map Index

* `under-construction`


### 3.7. Join Method

* [Join Method - Explanation](https://gist.github.com/kzhangkzhang/2866c2530c5a0ec337c475879eecabc0#join-method): **Hash join**, **Nested Loop**, **(Sort) Merge join**, **Cartesian join**


### 3.99. References

* Official Documentation
  * `under-construction`
* Blog/Videos
    * [Join Method - Explanation](https://gist.github.com/kzhangkzhang/2866c2530c5a0ec337c475879eecabc0#join-method): **Hash join**, **Nested Loop**, **(Sort) Merge join**, **Cartesian join**
    * [Statistics](https://www.youtube.com/watch?v=IYWmauKtwXI) ![star-icon.png](../../doc/images/star-icon.png)
      - [Correlations](https://www.youtube.com/watch?v=IYWmauKtwXI&t=220s), [Extended Statistics](https://www.youtube.com/watch?v=IYWmauKtwXI&t=299s) and [Skews](https://www.youtube.com/watch?v=IYWmauKtwXI&t=330s) ![star-icon.png](../../doc/images/star-icon.png)
      - Cardinality and Selectivity
        - Selectivity: proportion. ` 1 / number_of_distinct * total_rows`; Ex: `select 1 / COUNT(DISTINCT customer_type_id) /* 2: 'F', 'J' */ from STUDY.customers`; Result: `0.5`
        - Cardinality: total rows of table. Ex: `select 1 / COUNT(1) from STUDY.customers`; Result: `200.000`
        - Cardinality(total rows operation): `rows estimated = Selectivity * Cardinality`; Ex: `0.5 * 200000`; Results: `200000`
    * [Executions Plan, consistent gets](https://www.youtube.com/watch?v=Mt67FqYww_w&)
* Laboratories / [Quick Wins, Blogs, Vlogs, etc](#ii-cheatsheet99-quick-wins-blogs-vlogs-etc)
  - [I.1. Create Sample Tables using scripts](#ilab-1-create-sample-tables-using-scripts) and [I.2. Query metrics scenario initial](#ilab-2-query-metrics-scenario-initial)
  - [Join Method - nested loop, hash, and merge joins](https://www.youtube.com/watch?v=pJWCwfv983Q) ![star-icon.png](../../doc/images/star-icon.png)
  - [Playlist Oracle Database for Developers](https://www.youtube.com/playlist?list=PL78V83xV2fYlT11CJXE77H0LD7C_gZmyf) ![star-icon.png](../../doc/images/star-icon.png)
  - [How to Read an Execution Plan](https://www.youtube.com/watch?v=NkXxRodAFUY)
  - [What are Optimizer Statistics](https://www.youtube.com/watch?v=IYWmauKtwXI)


---

## 4. Identifying and Diagnosticing Performance Bottlenecks

### 4.1. Using V$ Views for Query Monitoring

* Identify long-running SQL queries:

```sql
-- Identify long-running SQL queries
SELECT sql_id, elapsed_time, sql_text
FROM v$sql
ORDER BY elapsed_time DESC FETCH FIRST 10 ROWS ONLY;
```

* Identify active sessions and wait events 

```sql
-- Check active sessions and wait events
SELECT event, state, wait_time, seconds_in_wait
FROM v$session_wait
WHERE wait_class != 'Idle';
```

* Identify running queries by exectuions, buffer_gets or cpu_time

```sql
-- Find queries consuming the most CPU
SELECT sql_id, executions, buffer_gets, cpu_time
FROM v$sql
ORDER BY cpu_time DESC FETCH FIRST 10 ROWS ONLY;
```

```sql
-- V$SQLAREA
SELECT *
FROM V$SQLAREA
```


### 4.2. Monitoring Performance Over Time with AWR and ASH

Use AWR (Automatic Workload Repository) and ASH (Active Session History) reports.

```sql
@?/rdbms/admin/awrrpt.sql
```

```sql
SELECT * FROM dba_hist_sqlstat ORDER BY elapsed_time_total DESC FETCH FIRST 10 ROWS ONLY;
```

### 4.3. Look for Locks and Deadlocks

* `under-construction` V$LOCK e DBA_BLOCKERS

### 4.4. Diagnostics with Oracle Enterprise Manager (OEM)

* `under-construction` V$LOCK e DBA_BLOCKERS

### 4.5. Check Statistics Consistency

* `under-construction` Check Statistics Consistency

---

## 5. Optimizing Performance Issues Identified

## 5.1. Optimizing SQL Queries - Indexing Strategies

* VLog - Simple explanation [How to Create Database Indexes: Databases for Developers](https://www.youtube.com/watch?v=7wLFr7ZnKPU)
  * [How to Create Database Indexes - Balance](https://youtu.be/7wLFr7ZnKPU?t=234&si=EjEQDzSfHt5OsbUy)
  * [How to Create Database Indexes - Btree](https://youtu.be/7wLFr7ZnKPU?t=264&si=sMXhTgkCkK4S4WT9)
  * [How to Create Database Indexes - Index Full Scan](https://youtu.be/7wLFr7ZnKPU?t=403&si=1PsFg480zbiQ7bG-)
  * [How to Create Database Indexes - Multi Columns Indexes](https://youtu.be/7wLFr7ZnKPU?t=489&si=h5wrDCrxLv5Sp3gn)
* Indexes improve query performance but can also degrade insert/update performance if overused.
* Indexes on high-cardinality  could be beneficial for query performance.
* Indexes on column that has a high number of NULL values, should be considered in query design and indexing strategies.
* Avoid creating indexes on columns with low selectivity (few distinct values) as they may not be used.
* Regularly update statistics to ensure the optimizer makes accurate decisions about index usage.
* Index Selectivity:
  - Index selectivity is typically defined as `(Number of Distinct Values) / (Total Number of Rows)`
  - Oracle's Decision Process: 
    - The optimizer estimates the cost of two approaches: a) Using the index and then accessing the table; b) Performing a full table scan;
    - Threshold for Index Usage depends on various factors: a) Table size; b) Index clustering factor; c) Available system resources; d) Cost of random I/O vs. sequential I/O
    - General Rule of Thumb: indexes tend to be beneficial when they select less than 10-15% of the rows


#### 5.1.a. B-tree Index

* Best for selective queries
  * VLog - [How to Create Database Indexes - Balance](https://youtu.be/7wLFr7ZnKPU?t=234&si=EjEQDzSfHt5OsbUy)
  * VLog - [How to Create Database Indexes - Btree](https://youtu.be/7wLFr7ZnKPU?t=264&si=sMXhTgkCkK4S4WT9)


#### 5.1.b. Bitmap Index

* Good for **low-cardinality** columns (e.g., gender, status) but should be avoided in high-write environments


#### 5.1.c. Function-Based Index

* Useful when queries involve functions
  * [How to Create Database Indexes - Function Base Indexes](https://youtu.be/7wLFr7ZnKPU?t=697&si=XOX_0aeNGQBRzKSq)


```sql
CREATE INDEX idx_customers_email ON customers (LOWER(email));
```


#### 5.1.d. Partitioned Index

* `under-construction` Improves performance for large tables, partition key decision, partition type, partition pruning PSTART and PSTOP, partition drop, partition Zone maps


#### 5.1.e. Check Index Usage

* Oracle does not track index usage automatically by default However, Oracle can track index usage if you explicitly enable it.

```sql
-- Enable
ALTER INDEX STUDY.CUSTOMERS_IDX MONITORING USAGE;
-- Disable
ALTER INDEX STUDY.CUSTOMERS_IDX NOMONITORING USAGE;
```

```sql
SELECT index_name, table_name, used FROM v$object_usage;
```


#### 5.1.f. Clustering Factor

* The clustering factor is a measure of how well ordered the rows in a table are in relation to an index. It indicates how many data blocks Oracle would need to read to satisfy a full index scan.
  * The clustering factor can range from the number of blocks in the table **best case** to the number of rows in the table **worst case**
  * How it's calculated: Oracle calculates the clustering factor by walking through the index in order and counting the number of times it has to switch to a different data block to fetch the next row.
  * How to Improving clustering factor:
    - Reorganize the table (e.g., using ALTER TABLE ... MOVE)
    - Create a new table with ordered inserts and replace the old one
    - Use index-organized tables where appropriate
* VLogs - [Why Isn't My Query Using an Index? Databases for Developers](https://www.youtube.com/watch?v=7sS9bqdxM3g)


#### 5.1.g. Index Reverse Key

* `under-construction` normally better when **UNIQUE SCAN**


#### 5.1.h. Index Organized Table

* `under-construction`


### 5.2. Optimizing SQL Queries - Others Strategies

### 5.2.a. Optimizing SQL Queries - Bind Variables vs. Literals

* Using literals can cause hard parsing, slowing down execution.
  * Bad practice (causes hard parsing):

```sql
-- Bad practice using hard parse
SELECT * FROM customers WHERE id = 123;
```

```sql
-- Better practice avoid hard parse
SELECT * FROM customers WHERE id = :customer_id;
```

### 5.2.b. Avoiding SELECT *

* Fetching unnecessary columns increases memory usage and I/O.

```sql
-- Bad practice using *
SELECT * FROM customers;
```

```sql
-- Better practice using explicity only necessaries columnns
SELECT name, email FROM customers;
```

### 5.2.c. EXISTS vs. IN

* `EXISTS` is generally faster when checking for existence
* `EXISTS` AND `IN` are not "same things" nether produces "same execution plan"

```sql
-- Better: Exists only checks existence
SELECT name FROM customers c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id);
```


```sql
-- Bad: IN can be slower for large datasets:
SELECT name FROM customers c
WHERE customer_id IN (SELECT customer_id FROM orders);
```

### 5.2.d. In-Memory Table and Columns

### 5.2.d.1. On Regular Oracle Infrastructure (non-Exadata)

* Pinning a table in-memory (using INMEMORY PRIORITY CRITICAL) ensures that Oracle keeps that table resident in the In-Memory Column Store (IMCS)
* This reduces disk or buffer cache access and speeds up analytic queries significantly

### 5.2.d.2. On On Exadata

* Oracle Exadata introduces: `Smart Scan`, `Storage Indexes`, `Hybrid Columnar Compression`, and `Flash Cache`, all of which significantly optimize I/O and query execution even without IMCS
* Advantages of In-Memory on Exadata:
  * Still beneficial for complex analytics where vectorized execution and in-memory joins/aggregates shine
  * Eliminates some overhead of Smart Scan when the data is already in-memory
  * Works great when latency is critical and predictable performance is required
* Considerations:
  * Exadata already caches data very efficiently in its Smart Flash Cache, reducing the benefit of in-memory pinning
  * The Storage Cells in Exadata perform Smart Scans and push filtering/projections to storage layer — sometimes more efficient than IMCS, especially for large table scans
  * If memory is limited, pinning data in-memory may evict other useful segments that could be handled more efficiently by Exadata's storage tier
* Best Practice on Exadata:
  * Use In-Memory selectively: Don't pin all data — pin only the hot, frequently queried analytical tables
  * Test query performance with and without pinning, because Exadata Smart Scan may outperform in-memory in certain large-scale scenarios
  * Consider letting Oracle manage it dynamically (INMEMORY PRIORITY AUTO) unless you have solid reasons to pin


### 5.2.e. Cursor Optimization

* `under-construction`


### 5.3. Optimizing Joins and Aggregations

#### 5.3.1. Choosing the Right Join Type

* Nested Loops: Best for small datasets and indexed joins.
* Hash Join: Efficient for large, unindexed datasets.
* Sort Merge Join: Used when data is pre-sorted.

Check which join is being used with EXPLAIN PLAN.


#### 5.3.2. Using the RIGHT Aggregation Strategy

* Avoid DISTINCT if GROUP BY works

```sql
-- Better alternative:
SELECT DISTINCT department FROM employees;
```

```sql
-- Use analytic functions instead of GROUP BY when possible
SELECT department FROM employees GROUP BY department;
```

```sql
SELECT emp_id, salary, 
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank
FROM employees;
```

### 5.4. Encoding issues: when using EBCDIC

Using EBCDIC-encoded data in an Oracle Exadata environment is fairly uncommon today, but still relevant for organizations integrating with mainframe systems (like IBM z/OS). Since Oracle natively uses Unicode (AL32UTF8) or ASCII-based encodings, using EBCDIC introduces some unique challenges and precautions.

### 5.4.a. Character Set Conversion

* Oracle Database does not natively store EBCDIC — you’ll need to convert EBCDIC to a supported character set, typically AL32UTF8 or WE8ISO8859P1, during load
* Use Oracle SQL*Loader, External Tables, or Data Integrator (ODI) with proper conversion options
* Best Practice: Can be used in SQL*Loader control files if you're importing raw EBCDIC data.

```sql-loader-ctl-file
CHARACTERSET WE8EBCDIC1047
```


### 5.4.b. NLS_LANG and Charset Mismatch

* Setting the correct NLS_LANG on client environments is critical. A mismatch can result in:
  * Garbled characters
  * Inserted data becoming unreadable
  * Failed conversions
  * Examples:

```bash
export NLS_LANG=AMERICAN_AMERICA.WE8EBCDIC1047
```


### 5.4.c. Data Integrity During Transfer

* When moving data from EBCDIC to Exadata:
  * Use binary-safe transport (e.g., FTP in binary mode)
  * Avoid automatic conversions by network utilities (e.g., ASCII mode in FTP)

### 5.4.d. Performance Considerations

* Conversion overhead: If you're querying EBCDIC-encoded flat files via **external tables**, character set conversion can impact performance
* When loading EBCDIC data into Oracle tables, it's ideal to **convert once during ETL** and store in UTF-8 or a standard Oracle charset

### 5.4.e. Indexing and Sorting

* EBCDIC has a different sort order than ASCII/Unicode
* If not converted properly, sorting and indexing may behave unpredictably
  * For example: 'A' < 'a' in ASCII, but not necessarily in EBCDIC
* Always **normalize to Unicode** before relying on character-based operations


### 5.4.f. Application-Level Handling

* If your application expects EBCDIC and your database is UTF-8, make sure:
  * Your app layer performs encoding/decoding correctly
  * Or you use Oracle functions like CONVERT(..., 'WE8EBCDIC1047', 'AL32UTF8') appropriately

### 5.4.g. Recommended Strategy

1. Convert EBCDIC to UTF-8 during ETL
2. Store in Oracle using AL32UTF8
3. Use external tables or SQL*Loader with proper charset config
4. Validate with test data for round-trip correctness
5. Monitor performance if real-time conversion is needed


### 5.5. Use of Hints

* Complete Oracle Documentation References for [Optimizer Hints](https://docs.oracle.com/cd/B13789_01/server.101/b10752/hintsref.htm)
* Type of Hints: `Single-Table`, `Multi-Table`, `Query-Block`, `Statement`
* Hints sintax `{DELETE|INSERT|MERGE|SELECT|UPDATE}  /*+ hint [text] [hint[text]]... */`



#### 5.5.a. Hints for Optimization Approaches and Goals

#### 5.5.b. Hints for Access Paths

#### 5.5.c. Hints for Query Transformations

#### 5.5.d. Hints for Join Orders

#### 5.5.e. Hints for Join Operations

#### 5.5.f. Hints for Parallel Execution

* `PARALLEL`: The PARALLEL hint lets you specify the desired number of concurrent servers that can be used for a parallel operation. The hint applies to the SELECT, INSERT, UPDATE, and DELETE portions of a statement, as well as to the table scan portion.
* `NO_PARALLEL`: The NO_PARALLEL hint overrides a PARALLEL specification in the table clause.
* `PQ_DISTRIBUTE`: The PQ_DISTRIBUTE hint improves the performance of parallel join operations. Do this by specifying how rows of joined tables should be distributed among producer and consumer query servers. Using this hint overrides decisions the optimizer would normally make.
* `PARALLEL_INDEX`: The PARALLEL_INDEX hint specifies the desired number of concurrent servers that can be used to parallelize index range scans for partitioned indexes.
* `NO_PARALLEL_INDEX`: The NO_PARALLEL_INDEX hint overrides a PARALLEL attribute setting on an index to avoid a parallel index scan operation.

#### 5.5.g. Additional Hints

* `APPEND`: In direct-path INSERT, data is appended to the end of the table, rather than using existing space currently allocated to the table. As a result, direct-path INSERT can be considerably faster than conventional INSERT.
* `NOAPPEND`: The NOAPPEND hint enables conventional INSERT by disabling parallel mode for the duration of the INSERT statement.
* `CACHE`: The CACHE hint specifies that the blocks retrieved for the table are placed at the most recently used end of the LRU list in the buffer cache when a full table scan is performed. This option is useful for small lookup tables.
* `NOCACHE`: The NOCACHE hint specifies that the blocks retrieved for the table are placed at the least recently used end of the LRU list in the buffer cache when a full table scan is performed. This is the normal behavior of blocks in the buffer cache.
* `PUSH_PRED`: The PUSH_PRED hint forces pushing of a join predicate into the view.
* `NO_PUSH_PRED`: The NO_PUSH_PRED hint prevents pushing of a join predicate into the view.
* `PUSH_SUBQ`: The PUSH_SUBQ hint causes non-merged subqueries to be evaluated at the earliest possible step in the execution plan. Generally, subqueries that are not merged are executed as the last step in the execution plan. If the subquery is relatively inexpensive and reduces the number of rows significantly, then it improves performance to evaluate the subquery earlier.
* `NO_PUSH_SUBQ`: The NO_PUSH_SUBQ hint causes non-merged subqueries to be evaluated as the last step in the execution plan. 
* `QB_NAME`: Use the QB_NAME hint to define a name for a query block. This name can then be used in another query block to hint tables appearing in the named query block.
* `CURSOR_SHARING_EXACT`: Oracle can replace literals in SQL statements with bind variables, if it is safe to do so. This is controlled with the CURSOR_SHARING startup parameter. The CURSOR_SHARING_EXACT hint causes this behavior to be switched off. In other words, Oracle executes the SQL statement without any attempt to replace literals by bind variables.
* `DRIVING_SITE`: The DRIVING_SITE hint forces query execution to be done for the table at a different site than that selected by Oracle.
* `DYNAMIC_SAMPLING`: The DYNAMIC_SAMPLING hint lets you control dynamic sampling to improve server performance by determining more accurate predicate selectivity and statistics for tables and indexes. You can set the value of DYNAMIC_SAMPLING to a value from 0 to 10. The higher the level, the more effort the compiler puts into dynamic sampling and the more broadly it is applied. Sampling defaults to cursor level unless you specify a table.
* `SPREAD_MIN_ANALYSIS`: This hint omits some of the compile time optimizations of the rules, mainly detailed dependency graph analysis, on spreadsheets. Some optimizations such as creating filters to selectively populate spreadsheet access structures and limited rule pruning are still used.


---

## 6. Table Partitioning

Partitioning breaks large tables into smaller segments for better performance.

### 6.1. Range Partitioning

```sql
CREATE TABLE orders (
  order_id NUMBER,
  order_date DATE,
  customer_id NUMBER
) PARTITION BY RANGE (order_date) (
  PARTITION p2023 VALUES LESS THAN (TO_DATE('2024-01-01', 'YYYY-MM-DD')),
  PARTITION p2024 VALUES LESS THAN (TO_DATE('2025-01-01', 'YYYY-MM-DD'))
);
```

### 6.2. Hash Partitioning

* `under-construction` - Useful when data is evenly distributed but queries use different keys.


### 6.3. Partition Pruning

* `under-construction`

### 6.4. Partition zone maps Exadata

* `under-construction`

### 6.5. Drop Partition

* `under-construction`
  - Drop de partições onde a PK da tabela não faz parte da chave de particionamento, o índice da PK fica em status unusable

### 6.6. Query Partition 

* `under-construction`

*  com queries em tabelas particionadas, ficar atento aos itens PSTART e PSTOP


---

## I. Laboratories

Laboratories is a practical use of performance concepts

## I.Lab-1: Create Sample Tables using scripts

* Pre-requisites:
  * [Laboratory - Oracle OCI FreeTier](../labs/Oracle-OCI-FreeTier/README.md)

### I.Lab-1-Step-1: Create Tables, Constraints, Sequences, etc

* Run Script [`01_tables_pk_ak_seq_check.sql`](./sql/01_tables_pk_ak_seq_check.sql)

### I.Lab-1-Step-2: Create Function auxiliar

* Run Script [`11_function_get_array_element.sql`](./sql/11_function_get_array_element.sql)

### I.Lab-1-Step-3: Create Procedure Load Customers

* Run Script [`12_procedure_load_customers.sql`](./sql/12_procedure_load_customers.sql)

### I.Lab-1-Step-4: Load 200.000 rows into `customers` tables

* Run Script [`13_execute_load_customers.sql`](./sql/13_execute_load_customers.sql)

```sql
EXECUTE load_customers(200000) -- 200.000 rows
```

### I.Lab-1-Step-5: Load `cities` tables, one chaptal city for each state and a lot of cities for 'SP', 'MG', 'RJ'

* Run Script [`13_execute_load_cities.sql`](./sql/13_execute_load_cities.sql)


### I.Lab-1-Step-6: Understand table `STUDY.customers` on scenario 00 changes INITIAL: number of rows, columns, distinct values

* Describe `STUDY.customers`, `STUDY.customer_types`, `STUDY.customer_statuses`

```sql
DESCRIBE STUDY.customers

Name               Null?    Type           
------------------ -------- -------------- 
ID                 NOT NULL NUMBER         
NAME               NOT NULL VARCHAR2(100)  
CUSTOMER_TYPE_ID   NOT NULL VARCHAR2(1)    
CODE               NOT NULL VARCHAR2(14)   
CUSTOMER_STATUS_ID NOT NULL NUMBER(1)      
EMAIL              NOT NULL VARCHAR2(100)  
PHONE              NOT NULL VARCHAR2(30)   
ADDRESS_STREET              VARCHAR2(200)  
ADDRESS_UNIT                VARCHAR2(20)   
ADDRESS_DETAILS             VARCHAR2(30)   
ADDRESS_ZIP_CODE   NOT NULL NUMBER(8)      
ADDRESS_CITY       NOT NULL VARCHAR2(50)   
ADDRESS_STATE      NOT NULL VARCHAR2(2)    
SINCE_AT                    DATE           
LAST_ORDER_AT               DATE           
OBS                         VARCHAR2(1000) 
```

* CARDINALITY

```sql
SELECT COUNT(*) FROM customers -- 200.000
```

* SELECTIVITY

```sql
SELECT 
    COUNT(DISTINCT code),               -- 2 keys: (CPF;CNPJ)
    COUNT(DISTINCT name),               -- 200.000 keys
    COUNT(DISTINCT customer_type_id),   -- 2 keys: [ 'F', 'J' ]
    COUNT(DISTINCT customer_status_id), -- 1 keys: [ 0 ] 
    COUNT(DISTINCT address_state)       -- ['AC','AL',...,'TO']
FROM STUDY.customers;
```

### I.Lab-1-Step-7: Laboratory analysis and conclusions

* Table `customers` has 200.000 rows and occupies 7.174 blocks with avarage rows length 248 bytes
* Column `customers.customer_type_id` has 2 distinct values: (**F** Fisica, **J** Juridica)
* Column `customers.code` is alternate key CNPJ/CPF, has 200.000 distincts keys
* Column `customer_status_id` has a 6 distinct values: (0: INACTIVE; 1: ACTIVE; 2:BLOCKED; 3:RESTRICTED - ONLY WITHDRAWS, 4:RESTRICTED - ORDER <= CONFIG 1, 5:RESTRICTED - CUSTOM IN CONFIG )
* Column `customers.address_city` is 27 distinct values: 'Rio Branco', 'Maceio', ..., 'Palmas'
* Column `customers.address_state` is 27 distinct values: 'AC', 'AL', ..., 'TO'
* Column `customers.address_details` has 100.000 distincts values but another 100.000 NULL values
* Index Unique `customers.customer_code`



---

## I.Lab-2: Query metrics scenario INITIAL

* Pre-requisites:
  * [I.Lab-1: Create Sample Tables using scripts](#ilab-1-create-sample-tables-using-scripts)

### I.Lab-2-Step-1: Check if Table Has Statistics Collected

* [`query_tab_col_ind_statistics.sql`](../scripts/query_tab_col_ind_statistics.sql)


```sql
SELECT table_name, TO_CHAR(last_analyzed, 'DD-MON-YYYY HH24:MI:SSSS') AS last_analyzed, num_rows, blocks, avg_row_len
FROM all_tab_statistics 
WHERE owner = 'STUDY' 
AND table_name = 'CUSTOMERS';
```

```result
TABLE_NAME LAST_ANALYZED          NUM_ROWS BLOCKS AVG_ROW_LEN
---------- ---------------------- -------- ------ -----------
CUSTOMERS  04-APR-2025 17:24:4242 200000   7174   248
```

### I.Lab-2-Step-2: Check table columns statistics

```sql
SELECT table_name, column_name, num_distinct, density, num_nulls,  UTL_RAW.CAST_TO_VARCHAR2(low_value) AS low_value, UTL_RAW.CAST_TO_VARCHAR2(high_value) AS high_value, histogram, TO_CHAR(last_analyzed, 'DD-MON-YYYY HH24:MI:SSSS') AS last_analyzed
FROM all_tab_col_statistics
WHERE owner = 'STUDY' AND table_name = 'CUSTOMERS'
ORDER BY owner, table_name;
```

```result
TABLE_NAME COLUMN_NAME        NUM_DISTINCT DENSITY      NUM_NULLS LOW_VALUE HIGH_VALUE HISTOGRAM LAST_ANALYZED
---------  ------------------ ------------ --------     --------- -----------------------------------------------
CUSTOMERS  ID                 200000       0,000005               HYBRID    04-APR-2025 17:24:4242
CUSTOMERS  NAME               199760       0,000005     0         AAAATXDEDBQEZILCIGBI XPTADDHPLQHKQHOKUVORUJBDWELQYF GYFKREDIPEOK    ZZZVUXTGRDHLYGFXWZMQ MAMQEXFHELDWGKSLJTQFWCEGFJRVKG PEXLVEWFDZIW    HYBRID    04-APR-2025 17:24:4242
CUSTOMERS  CUSTOMER_TYPE_ID   2            0,0000025    0         F    J    FREQUENCY    04-APR-2025 17:24:4242
CUSTOMERS  CODE               200000       0,000005     0         10000018473    99999447843158    HYBRID    04-APR-2025 17:24:4242
CUSTOMERS  CUSTOMER_STATUS_ID 1            0,0000024977 0         FREQUENCY    04-APR-2025 17:24:4242
CUSTOMERS  EMAIL              200000       0,000005     0         aaaamhljwwjzxnythjmp@example.com    zzzyfsyhfwatwfsldgdy@example.com    HYBRID    04-APR-2025 17:24:4242
CUSTOMERS  PHONE              200000       0,000005     0         +55 11100000696    +55 11999998358    HYBRID    04-APR-2025 17:24:4242
CUSTOMERS  ADDRESS_STREET     200000       0,000005     0         Rua AABQMQdFysDnxLFpzanu aBmGVyhpTEIFuNHSljoyXwJvGWQHrr    Rua zzzVePqQJJjLbPtdqveg MQucctYONvmRHAiGDmvxmXciNZNBBe    HYBRID    04-APR-2025 17:24:4242
CUSTOMERS  ADDRESS_UNIT       898          0,001112     0         100    999    HYBRID    04-APR-2025 17:24:4242
CUSTOMERS  ADDRESS_DETAILS    100000       0,00001      100000    AAFFDAlKGahuDVVCBlJR    zzzjKSTdJZAhYVxQQEsD    HYBRID    04-APR-2025 17:24:4242
CUSTOMERS  ADDRESS_ZIP_CODE   200000       0,000005     0         L     db$    HYBRID    04-APR-2025 17:24:4242
CUSTOMERS  ADDRESS_CITY       27           0,0000025    0         Aracaju    Vitoria    FREQUENCY    04-APR-2025 17:24:4242
CUSTOMERS  ADDRESS_STATE      27           0,0000025    0         AC    TO    FREQUENCY    04-APR-2025 17:24:4242
CUSTOMERS  SINCE_AT                        0            0         200000            NONE    04-APR-2025 17:24:4242
CUSTOMERS  LAST_ORDER_AT                   0            0         200000            NONE    04-APR-2025 17:24:4242
CUSTOMERS  OBS                             0            0         200000            NONE    04-APR-2025 17:24:4242
```

### I.Lab-2-Step-3: Collect statistics 
  - Simple

* [`gather_statistics.sql`](../scripts/gather_statistics.sql)


```sql
-- This will collect row count, column statistics, and index statistics
EXEC DBMS_STATS.GATHER_TABLE_STATS('STUDY', 'CUSTOMERS');
```

* Estimate auto, histogram if benefical

```sql
DECLARE
BEGIN
  DBMS_STATS.GATHER_TABLE_STATS(
    ownname      => 'STUDY',
    tabname      => 'CUSTOMERS',
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE, -- Automatically chooses sample size
    method_opt   => 'FOR ALL COLUMNS SIZE AUTO' -- Collect histograms if beneficial
  );
END;
/
```

### I.Lab-2-Step-4: Laboratory analysis and conclusions

* Collected vs Actual table, columns and indexes statistics are OK
* Table Statistics:
  - Table `customers` has 200.000 rows and occupies 7.174 blocks with avarage rows length 248 bytes
* Columns Statistics:
  - Columns `ID`, `CODE`, `EMAIL`, `PHONE`, and `ADDRESS_STREET` have high cardinality (200,000 distinct values each). Indexes on high-cardinality could be beneficial for query performance.
  - Column `CUSTOMER_TYPE_ID` has low cardinality (2 distinct values).
  - Column `CUSTOMER_STATUS_ID` has very low cardinality (1 distinct value in this sample).
  - Column `ADDRESS_CITY` and ADDRESS_STATE both have 27 distinct values.
  - Column `ADDRESS_UNIT` has 898 distinct values.
  - Column `ADDRESS_DETAILS` has 100,000 distinct values and 100,000 NULL values (high number of NULL values) which should be considered in query design and indexing strategies.
* Histograms:
   - Most columns have `HYBRID` histograms, which is appropriate for columns with **skewed** data distribution.
   - `CUSTOMER_TYPE_ID`, `CUSTOMER_STATUS_ID`, `ADDRESS_CITY`, and `ADDRESS_STATE` have **FREQUENCY** histograms, which is suitable for **low-cardinality** columns.

---

## I.Lab-3: Query by Indexed Primary Key Columns

* Pre-requisites:
  * [I.2. Query metrics scenario initial](#ilab-2-query-metrics-scenario-initial)

### I.Lab-3-Step-1: Analyse Execution Plan query customer id = 100000

* [`explain_plan_for.sql`](./../scripts/explain_plan_for.sql)

```sql
-- On SQLDeveloper :: "Exec Plan ... (F10)" or "SET AUTOT ... EXPLAIN PLAN FOR ... SELECT TABLE(DBMS_XPLAN.DISPLAY) ... SET AUTOT OFF"
SET AUTOT TRACE 
EXPLAIN PLAN FOR
  SELECT * FROM customers WHERE id = 100000;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
SET AUTOT OFF
```

* Analysis:
  * INDEX UNIQUE SCAN using predicate WHERE id = 100000
  * 1 rows, low cost

```result
Plan hash value: 1323999688
 
-------------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                         | Name         | Rows  | Bytes | Cost (%CPU)| Time     |    TQ  |IN-OUT| PQ Distrib |
-------------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                  |              |     1 |   247 |     2   (0)| 00:00:01 |        |      |            |
|   1 |  PX COORDINATOR                   |              |       |       |            |          |        |      |            |
|   2 |   PX SEND QC (RANDOM)             | :TQ10001     |     1 |   247 |     2   (0)| 00:00:01 |  Q1,01 | P->S | QC (RAND)  |
|   3 |    TABLE ACCESS BY INDEX ROWID    | CUSTOMERS    |     1 |   247 |     2   (0)| 00:00:01 |  Q1,01 | PCWP |            |
|   4 |     BUFFER SORT                   |              |       |       |            |          |  Q1,01 | PCWC |            |
|   5 |      PX RECEIVE                   |              |     1 |       |     1   (0)| 00:00:01 |  Q1,01 | PCWP |            |
|   6 |       PX SEND HASH (BLOCK ADDRESS)| :TQ10000     |     1 |       |     1   (0)| 00:00:01 |  Q1,00 | S->P | HASH (BLOCK|
|   7 |        PX SELECTOR                |              |       |       |            |          |  Q1,00 | SCWC |            |
|*  8 |         INDEX UNIQUE SCAN         | SYS_C0056973 |     1 |       |     1   (0)| 00:00:01 |  Q1,00 | SCWP |            |
-------------------------------------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   8 - access("ID"=100000)
  :
```


### I.Lab-3-Step-2: Analyse statistics for query customer id = 100000

* [`explain_plan_for.sql`](./../scripts/explain_plan_for.sql)

```sql
-- On SQLDeveloper :: "Autotrace ... (F6)"
SELECT * FROM customers WHERE id = 100000;
```

* Analysis:
  * INDEX SYS_C0056973 UNIQUE SCAN, Filter Predicates: WHERE id = 100000
    * Card: 1, Cost: 2 (good)
    * Index is primary key
  * TABLE ACCESS CUSTOMERS BY ROWID
    * Card: 1, Cost: 2
  * Statistics v$statsname
    * consistent gets    3
   


```autotrace
:
consistent gets    3
consistent gets examination    3
consistent gets examination (fastpath)    3
consistent gets from cache    3
CPU used by this session    4
CPU used when call started    2
:
```

### I.Lab-3-Step-3: Laboratory analysis and conclusions

* Exec Plan access by index primary key (very good)
* Consistent get 3 (low)
* See more [5.1. Optimizing SQL Queries - Indexing Strategies](#51-optimizing-sql-queries---indexing-strategies)

---

## I.Lab-4: Query by Non Indexed Columns

* Pre-requisites:
  * [I.2. Query metrics scenario initial](#ilab-2-query-metrics-scenario-initial)

### I.Lab-4-Step-1: Analyse Execution Plan query customer by Non Indexed Columns

* [`explain_plan_for.sql`](./../scripts/explain_plan_for.sql)

```sql
SELECT * FROM customers WHERE email = 'dphicfzgjynepoykrxch@example.com';
SELECT * FROM customers WHERE name = 'DPLOSDEHZKDBQVLFJARP EAJZWPKZESQFUJUBRJCTEMOQXTZONN SPCQMZFWOXWUNUUYDHENYNNFGCUIOJ';
SELECT * FROM customers WHERE customer_type_id = 'F';
SELECT * FROM customers WHERE customer_status_id = 1;
SELECT * FROM customers WHERE address_details = 'lXUWcxeEuuNhnGCXOaAQ';
SELECT * FROM customers WHERE address_city = 'Sao Paulo';
```

* Analysis:
  * FULL TABLE ACCESS, filter predicates - each query filter by a different column:  email = '...' / name = '...' / customer_type_id = ...
  * **consistent gets 7692**
    - all predicates variations has the same consistent gets because de work is the same to get data throught database buffer caches
  * **Cost** 1082/1081 (sometimes with a little variations)
    - sometimes rounding differentes values
  * **Cardinality** sometimes 1 (email, name, customer_type_id, address_details); sometimes 200.000 (customer_status_id); sometimes 7.407 (address_city)
    - cardinality is a proportional calculated planned value using statistics

### I.Lab-4-Step-2: Laboratory analysis and conclusions

* Exec Plan access by full table
* Statname: "Consistent get" a metric of work to get data from buffers is the same, because optmizer should check all data blocks do find what he wants
* Sometimes a little cardinality variation because some distincts count values
* The work to check equality = for a column number and a string are very similar
* Statname: "bytes received via SQL*Net from client" are very different between conditions that results only one row and conditions that results a lot off rows. Usually the size of final results set does not matter
* Usually Low "Consistent get" represents low work efforts and better performance


---

## I.Lab-5: Query by Non Indexed Columns vs Indexed Columns

* Pre-requisites:
  * [I.2. Query metrics scenario initial](#ilab-2-query-metrics-scenario-initial)

### I.Lab-5-Step-1: SCENARIO 01 - Let's index all columns to compare performance between Non Indexed and Indexed columns

* Reference: [Optimizing SQL Queries - Indexing Strategies](#51-optimizing-sql-queries---indexing-strategies)

```sql
-- DROP INDEX (IF EXISTS)
DROP INDEX idx_customers_email              ;
DROP INDEX idx_customers_name               ;
DROP INDEX idx_customers_customer_type_id   ;
DROP INDEX idx_customers_customer_status_id ;
DROP INDEX idx_customers_address_details    ;
DROP INDEX idx_customers_address_city       ;

CREATE INDEX idx_customers_email              on customers(email);
CREATE INDEX idx_customers_name               on customers(name);
CREATE INDEX idx_customers_customer_type_id   on customers(customer_type_id);
CREATE INDEX idx_customers_customer_status_id on customers(customer_status_id);
CREATE INDEX idx_customers_address_details    on customers(address_details);
CREATE INDEX idx_customers_address_city       on customers(address_city);
```

```sql
EXEC DBMS_STATS.GATHER_TABLE_STATS('STUDY', 'customers');
```

```sql
SELECT * FROM customers WHERE email = 'dphicfzgjynepoykrxch@example.com';
SELECT * FROM customers WHERE name = 'DPLOSDEHZKDBQVLFJARP EAJZWPKZESQFUJUBRJCTEMOQXTZONN SPCQMZFWOXWUNUUYDHENYNNFGCUIOJ';
SELECT * FROM customers WHERE customer_type_id = 1;
SELECT * FROM customers WHERE customer_status_id = 1;
SELECT * FROM customers WHERE address_details = 'lXUWcxeEuuNhnGCXOaAQ';
SELECT * FROM customers WHERE address_city = 'Sao Paulo';
```

* Comparison Indexed non Indexed

```
+ ------------------------ + ---------------------------------- + ------------------------------------------------------------------------- +
|                          |     N o n        I n d e x e d     |               I   n   d   e   x   e   d                                   |
|                          + --------------------------- + ---- + ---------------- + ------------------------------ + -------------- + ---- +
| where predicate          | ACCESS     | Consistent get | Cost | ACCESS           | INDEX_NAME                     | Consistent get | Cost |
| ------------------------ + ---------- + -------------- + ---- + ---------------- + ------------------------------ + -------------- + ---- +
| email = ...              | FULL TABLE |      7692      | 1082 | INDEX RANGE SCAN | IDX_CUSTOMERS_EMAIL            |       4        |   3  |
| name = ...               | FULL TABLE |      7692      | 1082 | INDEX RANGE SCAN | IDX_CUSTOMERS_NAME             |       8        |   3  |
| customer_type_id = ...   | FULL TABLE |      7692      | 1082 | TABLE FULL       |                                |      7696      | 1082 |
| customer_status_id = ... | FULL TABLE |      7692      | 1082 | TABLE FULL       |                                |      7696      | 1082 |
| addresss_details = ...   | FULL TABLE |      7692      | 1082 | INDEX RANGE SCAN | IDX_CUSTOMERS_ADDRESS_DETAILS  |       3        |   1  |
| address_city = ....      | FULL TABLE |      7692      | 1082 | TABLE FULL       |                                |      7696      | 1082 |
| ------------------------ + ---------- + -------------- + ---- + ---------------- + ------------------------------ + -------------- + ---- + 
```


* Analysis:
  * Non Indexed Columns queries runs FULL TABLE ACCESS and produced consistent gets 7692
  * After Indexing Columns, **SOME** access changes to INDEX RANGE SCAN and produces **LOW** consistent gets between 3 and 8
  * Why not **ALL** access chagned to INDEXED?
    * All rows from table customers has customer_status_id = 1 and 50% of rows has customer_type_id = 'F'
    * using index in this circustances should produces 200.000 reads of index and the same 200.000 reads of data (customer_status_id = 1) and 100.000 reads of data (customer_type_id = 'F')
    * Sometimes when column selectivity is low, it is better do not use index
    * Avoid creating indexes on columns with low selectivity (few distinct values) as they may not be used
    * Regularly update statistics to ensure the optimizer makes accurate decisions about index usage.
  * What changed in Execution Plan?
    * because indexed access must first read index blocks and with rowid pointers read data from table
  * References
    * [Optimizing SQL Queries - Indexing Strategies](#51-optimizing-sql-queries---indexing-strategies)


### I.Lab-5-Step-2: Laboratory analysis and conclusions

* Some indexed columns produces INDEX RANGE SCAN to access index data and uses rowid to access table TABLE ACCESS BY INDEX ROWID
  - Index access consumes (low) 4 ~ 8 consistent gets and after using rowid information access table data directlry
  - lower consistent gets better performance


---

## I.Lab-6: Query by Indexed Columns, Low Selectivity, Data Skew

* Pre-requisites:
  * [I.5. Step 1 - SCENARIO 01](#ilab-5-step-1-scenario-01---lets-index-all-columns-to-compare-performance-between-non-indexed-and-indexed-columns)

### I.Lab-6-Step-1: SCENARIO 02 - Let's update an indexed column customer_status_id with abnormal data distribution: data skew

* customer_status_id = 1 for 199996 rows, and customer_status_id in (0,2,3,4,5) for only one row

```sql
-- UPDATE abnormal data distribution of column customer_status_id
-- ALL others rows has customer_status_id = 1
UPDATE customers SET customer_status_id = 0 WHERE id = 150000;
UPDATE customers SET customer_status_id = 2 WHERE id = 160000;
UPDATE customers SET customer_status_id = 3 WHERE id = 170000;
UPDATE customers SET customer_status_id = 4 WHERE id = 180000;
UPDATE customers SET customer_status_id = 5 WHERE id = 190000;
```

* [`gather_statistics.sql`](../scripts/gather_statistics.sql)

```sql
-- GATHER_TABLE_STATS
DECLARE
BEGIN
  DBMS_STATS.GATHER_TABLE_STATS(
    ownname      => 'STUDY',
    tabname      => 'CUSTOMERS',
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE, -- Automatically chooses sample size
    method_opt   => 'FOR ALL COLUMNS SIZE AUTO' -- Collect histograms if beneficial
  );
END;
/
```

### I.Lab-6-Step-2: SCENARIO 02 - Let's understand statistics

* [`query_tab_col_ind_statistics.sql`](../scripts/query_tab_col_ind_statistics.sql)

```sql
SELECT i.index_name, ic.column_name, ic.column_position, i.distinct_keys, i.num_rows, ic.column_length, i.uniqueness, i.index_type
FROM all_indexes i
JOIN all_ind_columns ic ON i.index_name = ic.index_name AND i.owner = ic.index_owner
WHERE i.owner = 'STUDY'
  AND i.table_name = 'CUSTOMERS'
  AND ic.column_name = 'CUSTOMER_STATUS_ID'
ORDER BY i.index_name, ic.column_position;
```

```result
INDEX_NAME                       COLUMN_NAME        COLUMN_POSITION DISTINCT_KEYS NUM_ROWS COLUMN_LENGTH UNIQUENESS INDEX_TYPE
-------------------------------- ------------------ --------------- ------------- -------- ------------- ---------- -----------
IDX_CUSTOMERS_CUSTOMER_STATUS_ID CUSTOMER_STATUS_ID 1               5             200000   22            NONUNIQUE  NORMAL
```

```sql
SELECT column_name, endpoint_number, endpoint_value, endpoint_actual_value
FROM   ALL_TAB_HISTOGRAMS
WHERE owner = 'STUDY' AND table_name = 'CUSTOMERS' AND column_name = 'CUSTOMER_STATUS_ID';
```

```results
COLUMN_NAME        ENDPOINT_NUMBER ENDPOINT_VALUE ENDPOINT_ACTUAL_VALUE
------------------ --------------- -------------- ---------------------
CUSTOMER_STATUS_ID 1               0              0
CUSTOMER_STATUS_ID 199996          1              1
CUSTOMER_STATUS_ID 199997          2              2
CUSTOMER_STATUS_ID 199998          3              3
CUSTOMER_STATUS_ID 199999          4              4
CUSTOMER_STATUS_ID 200000          5              5
```

### I.Lab-6-Step-3: SCENARIO 02 - Now, let's interpret the results:

1. COLUMN_NAME: Always 'CUSTOMER_STATUS_ID' in this case, as that's the column we're examining.
2. ENDPOINT_NUMBER: This represents the cumulative number of rows up to and including this endpoint value.
3. ENDPOINT_VALUE: This is the encoded representation of the column value at this endpoint.
4. ENDPOINT_ACTUAL_VALUE: This is the actual value of the column at this endpoint.

Interpreting the results:

1. The first row (0, 1) indicates that there is 1 row with CUSTOMER_STATUS_ID = 0.
2. The second row (1, 199996) indicates that there are 199,995 additional rows (199,996 - 1) with CUSTOMER_STATUS_ID = 1.
3. The third row (2, 199997) indicates there is 1 more row (199,997 - 199,996) with CUSTOMER_STATUS_ID = 2.
4. The fourth row (3, 199998) indicates 1 more row with CUSTOMER_STATUS_ID = 3.
5. The fifth row (4, 199999) indicates 1 more row with CUSTOMER_STATUS_ID = 4.
6. The last row (5, 200000) indicates 1 more row with CUSTOMER_STATUS_ID = 5.

This aligns with your UPDATE statements:
- 1 row each for status 0, 2, 3, 4, and 5
- All remaining rows (199,995) have status 1


### I.Lab-6-Step-4: SCENARIO 02 - Let's query customer_status_id = 1 that has a **(lot of) 199.996**  rows

```sql
SET AUTOT TRACE 
EXPLAIN PLAN FOR
    SELECT * FROM customers WHERE customer_status_id = 1;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
SET AUTOT OFF
```

```plan-table
        :
Plan hash value: 2487033814
 
---------------------------------------------------------------------------------------------------------------
| Id  | Operation            | Name      | Rows  | Bytes | Cost (%CPU)| Time     |    TQ  |IN-OUT| PQ Distrib |
---------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT     |           |   199K|    47M|  1082   (1)| 00:00:01 |        |      |            |
|   1 |  PX COORDINATOR      |           |       |       |            |          |        |      |            |
|   2 |   PX SEND QC (RANDOM)| :TQ10000  |   199K|    47M|  1082   (1)| 00:00:01 |  Q1,00 | P->S | QC (RAND)  |
|   3 |    PX BLOCK ITERATOR |           |   199K|    47M|  1082   (1)| 00:00:01 |  Q1,00 | PCWC |            |
|*  4 |     TABLE ACCESS FULL| CUSTOMERS |   199K|    47M|  1082   (1)| 00:00:01 |  Q1,00 | PCWP |            |
---------------------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   4 - filter("CUSTOMER_STATUS_ID"=1)

        :
```

### I.Lab-6-Step-5: SCENARIO 02 - Let's query customer_status_id = 0 that has **only (1) one** rows 

```sql
SET AUTOT TRACE 
EXPLAIN PLAN FOR
    SELECT * FROM customers WHERE customer_status_id = 0;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
SET AUTOT OFF
```

```plan-table
        :
Plan hash value: 1137980775
 
-------------------------------------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                             | Name                             | Rows  | Bytes | Cost (%CPU)| Time     |    TQ  |IN-OUT| PQ Distrib |
-------------------------------------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                      |                                  |     1 |   247 |     2   (0)| 00:00:01 |        |      |            |
|   1 |  PX COORDINATOR                       |                                  |       |       |            |          |        |      |            |
|   2 |   PX SEND QC (RANDOM)                 | :TQ10001                         |     1 |   247 |     2   (0)| 00:00:01 |  Q1,01 | P->S | QC (RAND)  |
|   3 |    TABLE ACCESS BY INDEX ROWID BATCHED| CUSTOMERS                        |     1 |   247 |     2   (0)| 00:00:01 |  Q1,01 | PCWP |            |
|   4 |     BUFFER SORT                       |                                  |       |       |            |          |  Q1,01 | PCWC |            |
|   5 |      PX RECEIVE                       |                                  |     1 |       |     1   (0)| 00:00:01 |  Q1,01 | PCWP |            |
|   6 |       PX SEND HASH (BLOCK ADDRESS)    | :TQ10000                         |     1 |       |     1   (0)| 00:00:01 |  Q1,00 | S->P | HASH (BLOCK|
|   7 |        PX SELECTOR                    |                                  |       |       |            |          |  Q1,00 | SCWC |            |
|*  8 |         INDEX RANGE SCAN              | IDX_CUSTOMERS_CUSTOMER_STATUS_ID |     1 |       |     1   (0)| 00:00:01 |  Q1,00 | SCWP |            |
-------------------------------------------------------------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   8 - access("CUSTOMER_STATUS_ID"=0)
        :
```


### I.Lab-6-Step-6: Laboratory analysis and conclusions

* Why there are different Exec Plan for similar queries, WHERE customer_status_id = 0 vs customer_status_id = 1
  * Explanation of Different Execution Plans:
    * Selectivity / Cost-Based Optimizer Decision:
      - For customer_status_id = 1, the query is highly non-selective (returns 99.998% of rows); Using the index would require scanning almost the entire index and then fetching almost all table rows; A full table scan is more efficient as it reads the table sequentially;
      - For customer_status_id = 0, the query is highly selective (returns 0.0005% of rows); The index can quickly identify the single row that matches;  It's much more efficient to use the index than to scan the entire table;
    * Statistics and Histograms:
      - The optimizer is aware of the data distribution thanks to accurate statistics and likely a histogram on the customer_status_id column
      - This allows it to make different decisions based on the specific value in the WHERE clause
  * Adaptive Plans: This demonstrates Oracle's ability to choose different plans based on the specific predicate values
  * Statistics Importance: Accurate and up-to-date statistics, including histograms, are crucial for the optimizer to make these intelligent decisions


---

## I.Lab-7: Query by Indexed Columns vs Selectivity vs Rule of thumb

* Pre-requisites:
  * [I.6. Step 1 - SCENARIO 02](#ilab-6-step-1-scenario-02---lets-update-an-indexed-column-customer_status_id-with-abnormal-data-distribution-data-skew)

### I.Lab-7-Step-1: SCENARIO 03 - Let's update an indexed column customer_status_id Selectivity: 10%, 12%, 13%, 15%, 20%, 30% with low clustering factor and internal fragmentation

* UPDATE controlled distribution of column customer_status_id Selectivity 10%, 12%, 13%, 15%, 20%, 30% with low clustering factor problem

```sql
-- DROP INDEX ON customer_status_id
DROP INDEX idx_customers_customer_status_id ;

-- UPDATE controlled Selectivity distribution
UPDATE customers SET customer_status_id = 0 WHERE id BETWEEN       1 AND      1 + 20000 - 1; -- 10%
COMMIT;
UPDATE customers SET customer_status_id = 1 WHERE id BETWEEN   20001 AND  20001 + 24000 - 1; -- 12%
COMMIT;
UPDATE customers SET customer_status_id = 2 WHERE id BETWEEN   44001 AND  44001 + 26000 - 1; -- 13%
COMMIT;
UPDATE customers SET customer_status_id = 3 WHERE id BETWEEN   70001 AND  70001 + 30000 - 1; -- 15%
COMMIT;
UPDATE customers SET customer_status_id = 4 WHERE id BETWEEN  100001 AND 100001 + 40000 - 1; -- 20%
COMMIT;
UPDATE customers SET customer_status_id = 5 WHERE id BETWEEN  140001 AND 140001 + 60000 - 1; -- 30%
COMMIT;

-- CREATE INDEX ON customer_status_id
CREATE INDEX idx_customers_customer_status_id on customers(customer_status_id);
```

* [`gather_statistics.sql`](../scripts/gather_statistics.sql)

```sql
-- GATHER_TABLE_STATS
DECLARE
BEGIN
  DBMS_STATS.GATHER_TABLE_STATS(
    ownname      => 'STUDY',
    tabname      => 'CUSTOMERS',
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE, -- Automatically chooses sample size
    method_opt   => 'FOR ALL COLUMNS SIZE AUTO' -- Collect histograms if beneficial
  );
END;
/
```

### I.Lab-7-Step-2: SCENARIO 02 - Let's understand statistics

* [`query_tab_col_ind_statistics.sql`](../scripts/query_tab_col_ind_statistics.sql)

```sql
SELECT column_name, endpoint_number, endpoint_value, endpoint_actual_value
FROM   ALL_TAB_HISTOGRAMS
WHERE owner = 'STUDY' AND table_name = 'CUSTOMERS' AND column_name = 'CUSTOMER_STATUS_ID';
```

```results
COLUMN_NAME        ENDPOINT_NUMBER ENDPOINT_VALUE ENDPOINT_ACTUAL_VALUE
------------------ --------------- -------------- ---------------------
CUSTOMER_STATUS_ID 20000           0              0
CUSTOMER_STATUS_ID 44000           1              1
CUSTOMER_STATUS_ID 70000           2              2
CUSTOMER_STATUS_ID 100000          3              3
CUSTOMER_STATUS_ID 140000          4              4
CUSTOMER_STATUS_ID 200000          5              5
```

* [Interpretation of results is the same](#ilab-6-step-4-scenario-02---now-lets-interpret-the-results)

### I.Lab-7-Step-3: SCENARIO 02 - Let's query customer_status_id = 0, 1, 2, ... What is the Rule of thumb Selectivity %

```sql
-- customer_status_id = 0 - Selectivity: 10%
SET AUTOT TRACE 
EXPLAIN PLAN FOR
    SELECT * FROM customers WHERE customer_status_id = 0 /* 10% */;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
SET AUTOT OFF

-- customer_status_id = 1 - Selectivity: 12%
SET AUTOT TRACE 
EXPLAIN PLAN FOR
    SELECT * FROM customers WHERE customer_status_id = 1 /* 12% */;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
SET AUTOT OFF

-- customer_status_id = 2 - Selectivity: 13%
SET AUTOT TRACE 
EXPLAIN PLAN FOR
    SELECT * FROM customers WHERE customer_status_id = 2 /* 13% */;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
SET AUTOT OFF

-- customer_status_id = 3 - Selectivity: 15%
SET AUTOT TRACE 
EXPLAIN PLAN FOR
    SELECT * FROM customers WHERE customer_status_id = 3 /* 15% */;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
SET AUTOT OFF

-- customer_status_id = 4 - Selectivity: 20%
SET AUTOT TRACE 
EXPLAIN PLAN FOR
    SELECT * FROM customers WHERE customer_status_id = 4 /* 20% */;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
SET AUTOT OFF

-- customer_status_id = 5 - Selectivity: 30%
SET AUTOT TRACE 
EXPLAIN PLAN FOR
    SELECT * FROM customers WHERE customer_status_id = 5 /* 30% */;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
SET AUTOT OFF
```

* Comparative 

```txt-table
Selectivity Predicate              consistent gets ACCESS           | Name                             | Rows  | Cost(%CPU)| Time     |
----------- ---------------------- --------------- ------------------------------------------------------------------------------------
10%         "CUSTOMER_STATUS_ID"=0             755 INDEX RANGE SCAN | IDX_CUSTOMERS_CUSTOMER_STATUS_ID | 20000 | 42(0)     | 00:00:01 |
12%         "CUSTOMER_STATUS_ID"=1             918 INDEX RANGE SCAN | IDX_CUSTOMERS_CUSTOMER_STATUS_ID | 24000 | 50(0)     | 00:00:01 |
13%         "CUSTOMER_STATUS_ID"=2             993 INDEX RANGE SCAN | IDX_CUSTOMERS_CUSTOMER_STATUS_ID | 26000 | 54(0)     | 00:00:01 |
15%         "CUSTOMER_STATUS_ID"=3            7700 TABLE ACCESS FULL| CUSTOMERS                        | 30000 | 1082(1)   | 00:00:01 |
20%         "CUSTOMER_STATUS_ID"=4            7709 TABLE ACCESS FULL| CUSTOMERS                        | 40000 | 1082(1)   | 00:00:01 |
30%         "CUSTOMER_STATUS_ID"=5            7709 TABLE ACCESS FULL| CUSTOMERS                        | 59999 | 1082(1)   | 00:00:01 |
```


### I.Lab-7-Step-4: Laboratory analysis and conclusions

* Why there are different Exec Plan for similar queries only changing the Predicate WHERE customer_status_id = ...?
  * There's a general Rule of Thumb in Oracle that when a query's **selectivity is around 15% or less**, the optimizer tends to prefer using an index (if available). When selectivity is higher than about 15%, a full table scan often becomes more efficient.
  * The presence of accurate statistics and histograms allows the optimizer to make these fine-grained decisions based on data distribution.
  * Notice how the consistent gets (logical I/Os) increase significantly for the full table scans, but the optimizer still deems this more efficient for higher selectivity queries.


---

## I.Lab-8: Query by Indexed Columns vs Selectivity vs Hint Use Index

* Pre-requisites:
  * [I.7. Step 1 - SCENARIO 03](#ilab-7-step-1-scenario-03---lets-update-an-indexed-column-customer_status_id-selectivity-10-12-13-15-20-30-with-low-clustering-factor-and-internal-fragmentation)

### I.Lab-8-Step-1: SCENARIO 03 - Let's force indexed access customer_status_id Selectivity: >= 15%, 20%, 30%

* Let's remember data distribution

```sql
SELECT customer_status_id, COUNT(*), COUNT(*)/200000*100 AS PCT_SELECTIVITY FROM customers GROUP BY customer_status_id ORDER BY 1;
```

```Query-Result
CUSTOMER_STATUS_ID COUNT(*) PCT_SELECTIVITY
------------------ -------- ---------------
0                  20000    10
1                  24000    12
2                  26000    13
3                  30000    15
4                  40000    20
5                  60000    30
```

* Let's remember Comparative table where Oracle Optimizer decided to FULL TABLE SCAN on Selectivity % > 15%

```txt-table
Selectivity Predicate              consistent gets ACCESS           | Name                             | Rows  | Cost(%CPU)| Time     |
----------- ---------------------- --------------- ------------------------------------------------------------------------------------
10%         "CUSTOMER_STATUS_ID"=0             755 INDEX RANGE SCAN | IDX_CUSTOMERS_CUSTOMER_STATUS_ID | 20000 | 42(0)     | 00:00:01 |
12%         "CUSTOMER_STATUS_ID"=1             918 INDEX RANGE SCAN | IDX_CUSTOMERS_CUSTOMER_STATUS_ID | 24000 | 50(0)     | 00:00:01 |
13%         "CUSTOMER_STATUS_ID"=2             993 INDEX RANGE SCAN | IDX_CUSTOMERS_CUSTOMER_STATUS_ID | 26000 | 54(0)     | 00:00:01 |
15%         "CUSTOMER_STATUS_ID"=3            7700 TABLE ACCESS FULL| CUSTOMERS                        | 30000 | 1082(1)   | 00:00:01 |
20%         "CUSTOMER_STATUS_ID"=4            7709 TABLE ACCESS FULL| CUSTOMERS                        | 40000 | 1082(1)   | 00:00:01 |
30%         "CUSTOMER_STATUS_ID"=5            7709 TABLE ACCESS FULL| CUSTOMERS                        | 59999 | 1082(1)   | 00:00:01 |
```


### I.Lab-8-Step-2: SCENARIO 02 - Let's query customer_status_id = 3 forcing Hint USE Index

```sql
-- customer_status_id = 3 - Selectivity: 15%
SET AUTOT TRACE 
EXPLAIN PLAN FOR
    SELECT  /*+ INDEX_RS(customers IDX_CUSTOMERS_CUSTOMER_STATUS_ID) */  * FROM customers WHERE customer_status_id = 3 /* 15% */;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
SET AUTOT OFF
```

```plan-table-output
		:
Plan hash value: 1137980775
 
-------------------------------------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                             | Name                             | Rows  | Bytes | Cost (%CPU)| Time     |    TQ  |IN-OUT| PQ Distrib |
-------------------------------------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                      |                                  | 30000 |  7236K|  1135   (1)| 00:00:01 |        |      |            |
|   1 |  PX COORDINATOR                       |                                  |       |       |            |          |        |      |            |
|   2 |   PX SEND QC (RANDOM)                 | :TQ10001                         | 30000 |  7236K|  1135   (1)| 00:00:01 |  Q1,01 | P->S | QC (RAND)  |
|   3 |    TABLE ACCESS BY INDEX ROWID BATCHED| CUSTOMERS                        | 30000 |  7236K|  1135   (1)| 00:00:01 |  Q1,01 | PCWP |            |
|   4 |     BUFFER SORT                       |                                  |       |       |            |          |  Q1,01 | PCWC |            |
|   5 |      PX RECEIVE                       |                                  | 30000 |       |    62   (0)| 00:00:01 |  Q1,01 | PCWP |            |
|   6 |       PX SEND HASH (BLOCK ADDRESS)    | :TQ10000                         | 30000 |       |    62   (0)| 00:00:01 |  Q1,00 | S->P | HASH (BLOCK|
|   7 |        PX SELECTOR                    |                                  |       |       |            |          |  Q1,00 | SCWC |            |
|*  8 |         INDEX RANGE SCAN              | IDX_CUSTOMERS_CUSTOMER_STATUS_ID | 30000 |       |    62   (0)| 00:00:01 |  Q1,00 | SCWP |            |
-------------------------------------------------------------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   8 - access("CUSTOMER_STATUS_ID"=3)
		:
```

```v$statsname
	:
consistent gets	1144
	:
```

* Threshold Analysis with Hint: Repeat the experiment forcing index usage for different selectivity levels (20%, 25%, 30%, etc.) and determine at what point forced index usage ceases to be beneficial.

```sql
  SELECT  /*+ INDEX_RS(customers IDX_CUSTOMERS_CUSTOMER_STATUS_ID) */  * FROM customers WHERE customer_status_id = 4 /* 20% */;
  SELECT  /*+ INDEX_RS(customers IDX_CUSTOMERS_CUSTOMER_STATUS_ID) */  * FROM customers WHERE customer_status_id = 5 /* 30% */;
  SELECT  /*+ INDEX_RS(customers IDX_CUSTOMERS_CUSTOMER_STATUS_ID) */  * FROM customers WHERE customer_status_id IN (0,1,2,3) /* 30% */;
```

```txt-table
                                   INDEX RANGE SCAN TABLE ACCESS FULL 
Selectivity Predicate              consistent  gets  consistent  gets
----------- ---------------------- ----------------  ----------------
10%         "CUSTOMER_STATUS_ID"=0              755
12%         "CUSTOMER_STATUS_ID"=1              918
13%         "CUSTOMER_STATUS_ID"=2              993
15%         "CUSTOMER_STATUS_ID"=3         (*) 1144              7700
20%         "CUSTOMER_STATUS_ID"=4         (*) 1690              7709
30%         "CUSTOMER_STATUS_ID"=5         (*) 2277              7709
50%         "... _ID" IN(0,1,2,3)          (*) 7651              7709

consistent gets	
(*) USE HINT to force index
```


### I.Lab-8-Step-5: Laboratory analysis and conclusions

* In this case forcing index reduces "consistent gets" from 7.700 to 1.144
* Using hints can force the optimizer to use an execution plan that may not be the most efficient. Use with caution.
* It's a good practice to test the query performance with and without the hint to ensure it's actually improving performance.
* In more recent versions of Oracle, you can also use the INDEX_RS hint (Index Range Scan) if you specifically want a range scan of the index

---

## I.Lab-9: Query by Indexed Columns vs Parallel vs Hint No Parallel

* Pre-requisites:
  * [I.8. Step 1 - SCENARIO 03](#ilab-8-step-1-scenario-03---lets-force-indexed-access-customer_status_id-selectivity--15-20-30)
  * [5.5.f.Hints for Parallel Execution](#55f-hints-for-parallel-execution)


### I.Lab-9-Step-1: SCENARIO 03 - Let's query customer_status_id = 4 /* 20% */

```sql
-- customer_status_id = 4 - Selectivity: 20%
SET AUTOT TRACE 
EXPLAIN PLAN FOR
    SELECT * FROM customers WHERE customer_status_id = 4 /* 20% */;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
SET AUTOT OFF
```

```plan-table-output
	:
Plan hash value: 2487033814
 
---------------------------------------------------------------------------------------------------------------
| Id  | Operation            | Name      | Rows  | Bytes | Cost (%CPU)| Time     |    TQ  |IN-OUT| PQ Distrib |
---------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT     |           | 40000 |  9648K|  1082   (1)| 00:00:01 |        |      |            |
|   1 |  PX COORDINATOR      |           |       |       |            |          |        |      |            |
|   2 |   PX SEND QC (RANDOM)| :TQ10000  | 40000 |  9648K|  1082   (1)| 00:00:01 |  Q1,00 | P->S | QC (RAND)  |
|   3 |    PX BLOCK ITERATOR |           | 40000 |  9648K|  1082   (1)| 00:00:01 |  Q1,00 | PCWC |            |
|*  4 |     TABLE ACCESS FULL| CUSTOMERS | 40000 |  9648K|  1082   (1)| 00:00:01 |  Q1,00 | PCWP |            |
---------------------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   4 - filter("CUSTOMER_STATUS_ID"=4)
	:
```

### I.Lab-9-Step-2: SCENARIO 03 - Let's query Hint NO_PARALLEL customer_status_id = 4 /* 20% */


```sql
-- customer_status_id = 4 - Selectivity: 20%
SET AUTOT TRACE 
EXPLAIN PLAN FOR
    SELECT /*+ NO_PARALLEL(customers) */ * FROM customers WHERE customer_status_id = 4 /* 20% */;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
SET AUTOT OFF
```

```plan-table-output
	:
Plan hash value: 238036326
 
------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                           | Name                             | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                    |                                  | 40000 |  9648K|  1514   (1)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| CUSTOMERS                        | 40000 |  9648K|  1514   (1)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN                  | IDX_CUSTOMERS_CUSTOMER_STATUS_ID | 40000 |       |    83   (0)| 00:00:01 |
------------------------------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   2 - access("CUSTOMER_STATUS_ID"=4)
	:
```

### I.Lab-9-Step-3: Analysis and Conclusions

* In Oracle, when parallelism is enabled for a query, the optimizer often favors full table scans over index access methods. This is because:
1. Full table scans can be easily parallelized, with different parallel execution servers reading different portions of the table simultaneously.
2. Index access methods are often less efficient to parallelize, especially for B-tree indexes, as the index structure is hierarchical and not as easily divided among parallel processes.
3. When dealing with a significant portion of a large table, parallel full table scans can often outperform index access, especially on systems with good I/O capabilities.
4. The overhead of coordinating parallel index access and then accessing the table can sometimes be higher than simply scanning the table in parallel.
This behavior is one reason why you might see the optimizer choosing a full table scan even when an apparently suitable index exists, particularly when the degree of parallelism is set to a value greater than 1 for the session or for the specific query.

---

## I.Lab-10: Query by Indexed Columns vs High Clustering Factor

* Pre-requisites:
  * [I.8. Step 1 - SCENARIO 03](#ilab-8-step-1-scenario-03---lets-force-indexed-access-customer_status_id-selectivity--15-20-30)
  * [5.1.f. Clustering Factor](#51f-clustering-factor)


### I.Lab-10-Step-1: SCENARIO 04 - Let's update customer_status_id to produce High Clustering Factor

```sql
-- DROP INDEX ON customer_status_id
DROP INDEX idx_customers_customer_status_id ;

-- UPDATE controlled Selectivity distribution
UPDATE customers SET customer_status_id = 1                     ; -- 100% - 10% = 90%
COMMIT;
UPDATE customers SET customer_status_id = 0 WHERE MOD(id,10) = 0; -- 10%
COMMIT;

-- CREATE INDEX ON customer_status_id
CREATE INDEX idx_customers_customer_status_id on customers(customer_status_id);
```

* [`gather_statistics.sql`](../scripts/gather_statistics.sql)

```sql
-- GATHER_TABLE_STATS
DECLARE
BEGIN
  DBMS_STATS.GATHER_TABLE_STATS(
    ownname      => 'STUDY',
    tabname      => 'CUSTOMERS',
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE, -- Automatically chooses sample size
    method_opt   => 'FOR ALL COLUMNS SIZE AUTO' -- Collect histograms if beneficial
  );
END;
/
```

### I.Lab-10-Step-2: Check if Table Has Statistics Collected High Clustering Factor

* [`query_tab_col_ind_statistics.sql`](../scripts/query_tab_col_ind_statistics.sql)

```sql
SELECT table_name, TO_CHAR(last_analyzed, 'DD-MON-YYYY HH24:MI:SSSS') AS last_analyzed, num_rows, blocks, avg_row_len
FROM   all_tab_statistics
WHERE  owner = 'STUDY' 
AND    table_name = 'CUSTOMERS'
ORDER  BY owner, table_name;
```

```Query-Result
TABLE_NAME LAST_ANALYZED          NUM_ROWS BLOCKS AVG_ROW_LEN
---------- ---------------------- -------- ------ -----------
CUSTOMERS  10-APR-2025 20:28:1111 200000   7174   247
```


```sql
SELECT table_name, column_name, num_distinct, density, num_nulls,  UTL_RAW.CAST_TO_VARCHAR2(low_value) AS low_value, UTL_RAW.CAST_TO_VARCHAR2(high_value) AS high_value, histogram, TO_CHAR(last_analyzed, 'DD-MON-YYYY HH24:MI:SSSS') AS last_analyzed
FROM   all_tab_col_statistics
WHERE  owner = 'STUDY' AND table_name = 'CUSTOMERS' AND column_name = 'CUSTOMER_STATUS_ID'
ORDER  BY owner, table_name;
```

```Query-Result
TABLE_NAME COLUMN_NAME        NUM_DISTINCT DENSITY   NUM_NULLS LOW_VALUE HIGH_VALUE HISTOGRAM LAST_ANALYZED
---------- ------------------ ------------ --------- --------- --------- ---------- --------- ----------------------
CUSTOMERS  CUSTOMER_STATUS_ID 2            0,0000025 0                              FREQUENCY 10-APR-2025 20:28:1111
```

```sql
SELECT i.index_name, 
       i.index_type, -- NORMAL, BITMAP, FUNCTION-BASED NORMAL
       i.table_name,
       i.uniqueness, -- UNIQUE or NONUNIQUE
       i.clustering_factor,
       i.num_rows,
       i.leaf_blocks,
       i.distinct_keys,
       i.avg_leaf_blocks_per_key,
       i.avg_data_blocks_per_key,
       TO_CHAR(i.last_analyzed, 'DD-MON-YYYY HH24:MI:SS') AS last_analyzed
FROM   all_indexes i
WHERE  i.owner = 'STUDY' 
  AND  i.table_name = 'CUSTOMERS'
  AND  i.index_name = 'IDX_CUSTOMERS_CUSTOMER_STATUS_ID'
ORDER  BY i.index_name;
```

```Query-Result
INDEX_NAME                       INDEX_TYPE TABLE_NAME UNIQUENESS CLUSTERING_FACTOR NUM_ROWS LEAF_BLOCKS DISTINCT_KEYS AVG_LEAF_BLOCKS_PER_KEY AVG_DATA_BLOCKS_PER_KEY LAST_ANALYZED
-------------------------------- ---------- ---------- ---------- ----------------- -------- ----------- ------------- ----------------------- ----------------------- -------------
IDX_CUSTOMERS_CUSTOMER_STATUS_ID NORMAL     CUSTOMERS  NONUNIQUE  14286             200000   413         2             206                     7143                    10-APR-2025 20:28:12
```

* Clustering Factor de 14.286 (high) 


### I.Lab-10-Step-3: Let's query Indexed column with High Clustering Factor

```sql
SET AUTOT TRACE 
EXPLAIN PLAN FOR
    SELECT * FROM customers WHERE customer_status_id = 0;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
SET AUTOT OFF
```

```plan-table-output
	:
Plan hash value: 2487033814
 
---------------------------------------------------------------------------------------------------------------
| Id  | Operation            | Name      | Rows  | Bytes | Cost (%CPU)| Time     |    TQ  |IN-OUT| PQ Distrib |
---------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT     |           | 20000 |  4824K|  1082   (1)| 00:00:01 |        |      |            |
|   1 |  PX COORDINATOR      |           |       |       |            |          |        |      |            |
|   2 |   PX SEND QC (RANDOM)| :TQ10000  | 20000 |  4824K|  1082   (1)| 00:00:01 |  Q1,00 | P->S | QC (RAND)  |
|   3 |    PX BLOCK ITERATOR |           | 20000 |  4824K|  1082   (1)| 00:00:01 |  Q1,00 | PCWC |            |
|*  4 |     TABLE ACCESS FULL| CUSTOMERS | 20000 |  4824K|  1082   (1)| 00:00:01 |  Q1,00 | PCWP |            |
---------------------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   4 - filter("CUSTOMER_STATUS_ID"=0)
	:
```

### I.Lab-10-Step-4: SCENARIO 05 - Let's update customer_status_id to produce Low Clustering Factor


```sql
-- DROP INDEX ON customer_status_id
DROP INDEX idx_customers_customer_status_id ;

-- UPDATE controlled Selectivity distribution
UPDATE customers SET customer_status_id = 1                     ; -- 100% - 10% = 90%
COMMIT;
UPDATE customers SET customer_status_id = 0 WHERE id <= 20000; -- 10%
COMMIT;

-- CREATE INDEX ON customer_status_id
CREATE INDEX idx_customers_customer_status_id on customers(customer_status_id);
```

* [`gather_statistics.sql`](../scripts/gather_statistics.sql)

```sql
-- GATHER_TABLE_STATS
DECLARE
BEGIN
  DBMS_STATS.GATHER_TABLE_STATS(
    ownname      => 'STUDY',
    tabname      => 'CUSTOMERS',
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE, -- Automatically chooses sample size
    method_opt   => 'FOR ALL COLUMNS SIZE AUTO' -- Collect histograms if beneficial
  );
END;
/
```

### I.Lab-10-Step-5: Check if Table Has Statistics Collected Low Clustering Factor

* [`query_tab_col_ind_statistics.sql`](../scripts/query_tab_col_ind_statistics.sql)

```sql
SELECT table_name, TO_CHAR(last_analyzed, 'DD-MON-YYYY HH24:MI:SSSS') AS last_analyzed, num_rows, blocks, avg_row_len
FROM   all_tab_statistics
WHERE  owner = 'STUDY' 
AND    table_name = 'CUSTOMERS'
ORDER  BY owner, table_name;
```

```Query-Result
TABLE_NAME LAST_ANALYZED          NUM_ROWS BLOCKS AVG_ROW_LEN
---------- ---------------------- -------- ------ -----------
CUSTOMERS  10-APR-2025 21:23:4747 200000   7174   247
```


```sql
SELECT table_name, column_name, num_distinct, density, num_nulls,  UTL_RAW.CAST_TO_VARCHAR2(low_value) AS low_value, UTL_RAW.CAST_TO_VARCHAR2(high_value) AS high_value, histogram, TO_CHAR(last_analyzed, 'DD-MON-YYYY HH24:MI:SSSS') AS last_analyzed
FROM   all_tab_col_statistics
WHERE  owner = 'STUDY' AND table_name = 'CUSTOMERS' AND column_name = 'CUSTOMER_STATUS_ID'
ORDER  BY owner, table_name;
```

```Query-Result
TABLE_NAME COLUMN_NAME        NUM_DISTINCT DENSITY   NUM_NULLS LOW_VALUE HIGH_VALUE HISTOGRAM LAST_ANALYZED
---------- ------------------ ------------ --------- --------- --------- ---------- --------- ----------------------
CUSTOMERS  CUSTOMER_STATUS_ID 2            0,0000025 0                              FREQUENCY 10-APR-2025 21:23:4747
```

```sql
SELECT i.index_name, 
       i.index_type, -- NORMAL, BITMAP, FUNCTION-BASED NORMAL
       i.table_name,
       i.uniqueness, -- UNIQUE or NONUNIQUE
       i.clustering_factor,
       i.num_rows,
       i.leaf_blocks,
       i.distinct_keys,
       i.avg_leaf_blocks_per_key,
       i.avg_data_blocks_per_key,
       TO_CHAR(i.last_analyzed, 'DD-MON-YYYY HH24:MI:SS') AS last_analyzed
FROM   all_indexes i
WHERE  i.owner = 'STUDY' 
  AND  i.table_name = 'CUSTOMERS'
  AND  i.index_name = 'IDX_CUSTOMERS_CUSTOMER_STATUS_ID'
ORDER  BY i.index_name;
```

```Query-Result
INDEX_NAME                       INDEX_TYPE TABLE_NAME UNIQUENESS CLUSTERING_FACTOR NUM_ROWS LEAF_BLOCKS DISTINCT_KEYS AVG_LEAF_BLOCKS_PER_KEY AVG_DATA_BLOCKS_PER_KEY LAST_ANALYZED
-------------------------------- ---------- ---------- ---------- ----------------- -------- ----------- ------------- ----------------------- ----------------------- -------------
IDX_CUSTOMERS_CUSTOMER_STATUS_ID NORMAL     CUSTOMERS  NONUNIQUE  7144              200000   412         2             206                     3572                    10-APR-2025 21:23:49
```

### I.Lab-10-Step-6: Let's query Indexed column with Low Clustering Factor

```sql
SET AUTOT TRACE 
EXPLAIN PLAN FOR
    SELECT * FROM customers WHERE customer_status_id = 0;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
SET AUTOT OFF
```

```plan-table-output
	:
Plan hash value: 1137980775
 
-------------------------------------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                             | Name                             | Rows  | Bytes | Cost (%CPU)| Time     |    TQ  |IN-OUT| PQ Distrib |
-------------------------------------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                      |                                  | 20000 |  4824K|   758   (1)| 00:00:01 |        |      |            |
|   1 |  PX COORDINATOR                       |                                  |       |       |            |          |        |      |            |
|   2 |   PX SEND QC (RANDOM)                 | :TQ10001                         | 20000 |  4824K|   758   (1)| 00:00:01 |  Q1,01 | P->S | QC (RAND)  |
|   3 |    TABLE ACCESS BY INDEX ROWID BATCHED| CUSTOMERS                        | 20000 |  4824K|   758   (1)| 00:00:01 |  Q1,01 | PCWP |            |
|   4 |     BUFFER SORT                       |                                  |       |       |            |          |  Q1,01 | PCWC |            |
|   5 |      PX RECEIVE                       |                                  | 20000 |       |    42   (0)| 00:00:01 |  Q1,01 | PCWP |            |
|   6 |       PX SEND HASH (BLOCK ADDRESS)    | :TQ10000                         | 20000 |       |    42   (0)| 00:00:01 |  Q1,00 | S->P | HASH (BLOCK|
|   7 |        PX SELECTOR                    |                                  |       |       |            |          |  Q1,00 | SCWC |            |
|*  8 |         INDEX RANGE SCAN              | IDX_CUSTOMERS_CUSTOMER_STATUS_ID | 20000 |       |    42   (0)| 00:00:01 |  Q1,00 | SCWP |            |
-------------------------------------------------------------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   8 - access("CUSTOMER_STATUS_ID"=0)
	:
```


### I.Lab-10-Step-3: Analysis and Conclusions

* Table customers has 7.174 BLOCKS and 200.000 NUM_ROWS
  * In First index creation data was MOD(id,10) 10% of rows but **High** CLUSTERING_FACTOR is 14.286
  * In Second index creation data was id <= 20000 10% of rows but **Low** CLUSTERING_FACTOR is 7.144
  * **Low** CLUSTERING_FACTOR ~ BLOCKS
  * **High** CLUSTERING_FACTOR ~ NUM_ROWS


---

## I.Lab-11: Query by Indexed Columns vs Function Based Index

* Pre-requisites:
  * [I.10. Step 4 - SCENARIO 05](#ilab-10-step-4-scenario-05---lets-update-customer_status_id-to-produce-low-clustering-factor)
  * [5.1.c. Function-Based Index](#51c-function-based-index)


### I.Lab-11-Step-1: SCENARIO 06 - Let's update indexed column email with UPPERCASE and lowercase but try to query only UPPERCASE

```sql
UPDATE customers SET email = 'JOSEMARSILVA@inmetrics.com.br' WHERE id = 100000;
COMMIT;
```

* Query CASE SENSITIVE will find record

```sql
SET AUTOT TRACE 
EXPLAIN PLAN FOR
    SELECT * FROM customers WHERE email = 'JOSEMARSILVA@inmetrics.com.br';
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
SET AUTOT OFF
```

```plan-table-output
	:
Plan hash value: 3924700570
 
------------------------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                             | Name                | Rows  | Bytes | Cost (%CPU)| Time     |    TQ  |IN-OUT| PQ Distrib |
------------------------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                      |                     |     1 |   247 |     4   (0)| 00:00:01 |        |      |            |
|   1 |  PX COORDINATOR                       |                     |       |       |            |          |        |      |            |
|   2 |   PX SEND QC (RANDOM)                 | :TQ10001            |     1 |   247 |     4   (0)| 00:00:01 |  Q1,01 | P->S | QC (RAND)  |
|   3 |    TABLE ACCESS BY INDEX ROWID BATCHED| CUSTOMERS           |     1 |   247 |     4   (0)| 00:00:01 |  Q1,01 | PCWP |            |
|   4 |     BUFFER SORT                       |                     |       |       |            |          |  Q1,01 | PCWC |            |
|   5 |      PX RECEIVE                       |                     |     1 |       |     3   (0)| 00:00:01 |  Q1,01 | PCWP |            |
|   6 |       PX SEND HASH (BLOCK ADDRESS)    | :TQ10000            |     1 |       |     3   (0)| 00:00:01 |  Q1,00 | S->P | HASH (BLOCK|
|   7 |        PX SELECTOR                    |                     |       |       |            |          |  Q1,00 | SCWC |            |
|*  8 |         INDEX RANGE SCAN              | IDX_CUSTOMERS_EMAIL |     1 |       |     3   (0)| 00:00:01 |  Q1,00 | SCWP |            |
------------------------------------------------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   8 - access("EMAIL"='JOSEMARSILVA@inmetrics.com.br')
	:
```

* Query CONVERTING CASE will find record BUT DO NOT USE INDEX

```sql
SET AUTOT TRACE 
EXPLAIN PLAN FOR
    SELECT * FROM customers WHERE LOWER(email) = LOWER('JOSEMARSILVA@inmetrics.com.br');
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
SET AUTOT OFF
```

```plan-table-output
	:
Plan hash value: 2487033814
 
---------------------------------------------------------------------------------------------------------------
| Id  | Operation            | Name      | Rows  | Bytes | Cost (%CPU)| Time     |    TQ  |IN-OUT| PQ Distrib |
---------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT     |           |  2000 |   482K|  1082   (1)| 00:00:01 |        |      |            |
|   1 |  PX COORDINATOR      |           |       |       |            |          |        |      |            |
|   2 |   PX SEND QC (RANDOM)| :TQ10000  |  2000 |   482K|  1082   (1)| 00:00:01 |  Q1,00 | P->S | QC (RAND)  |
|   3 |    PX BLOCK ITERATOR |           |  2000 |   482K|  1082   (1)| 00:00:01 |  Q1,00 | PCWC |            |
|*  4 |     TABLE ACCESS FULL| CUSTOMERS |  2000 |   482K|  1082   (1)| 00:00:01 |  Q1,00 | PCWP |            |
---------------------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   4 - filter(LOWER("EMAIL")='josemarsilva@inmetrics.com.br')
	:
```


### I.Lab-11-Step-2: Create a Function Based Index to match query predicate

* Create Function Based Index with expression LOWER(email)

```sql
CREATE INDEX idx_fb_customers_email ON customers (LOWER(email));
```

* Collect Statistics 

```sql
-- GATHER_TABLE_STATS
DECLARE
BEGIN
  DBMS_STATS.GATHER_TABLE_STATS(
    ownname      => 'STUDY',
    tabname      => 'CUSTOMERS',
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE, -- Automatically chooses sample size
    method_opt   => 'FOR ALL COLUMNS SIZE AUTO' -- Collect histograms if beneficial
  );
END;
/
```

* Query Uses Indexes - INDEX RANGE SCAN - IDX_FB_CUSTOMERS_EMAIL

```sql
SET AUTOT TRACE 
EXPLAIN PLAN FOR
    SELECT * FROM customers WHERE LOWER(email) = LOWER('JOSEMARSILVA@inmetrics.com.br');
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
SET AUTOT OFF
```

```plan-table-output
    :
Plan hash value: 1395743395
 
---------------------------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                             | Name                   | Rows  | Bytes | Cost (%CPU)| Time     |    TQ  |IN-OUT| PQ Distrib |
---------------------------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                      |                        |     1 |   280 |     4   (0)| 00:00:01 |        |      |            |
|   1 |  PX COORDINATOR                       |                        |       |       |            |          |        |      |            |
|   2 |   PX SEND QC (RANDOM)                 | :TQ10001               |     1 |   280 |     4   (0)| 00:00:01 |  Q1,01 | P->S | QC (RAND)  |
|   3 |    TABLE ACCESS BY INDEX ROWID BATCHED| CUSTOMERS              |     1 |   280 |     4   (0)| 00:00:01 |  Q1,01 | PCWP |            |
|   4 |     BUFFER SORT                       |                        |       |       |            |          |  Q1,01 | PCWC |            |
|   5 |      PX RECEIVE                       |                        |     1 |       |     3   (0)| 00:00:01 |  Q1,01 | PCWP |            |
|   6 |       PX SEND HASH (BLOCK ADDRESS)    | :TQ10000               |     1 |       |     3   (0)| 00:00:01 |  Q1,00 | S->P | HASH (BLOCK|
|   7 |        PX SELECTOR                    |                        |       |       |            |          |  Q1,00 | SCWC |            |
|*  8 |         INDEX RANGE SCAN              | IDX_FB_CUSTOMERS_EMAIL |     1 |       |     3   (0)| 00:00:01 |  Q1,00 | SCWP |            |
---------------------------------------------------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   8 - access(LOWER("EMAIL")='josemarsilva@inmetrics.com.br')
    :
```

### I.Lab-11-Step-3: Analysis and Conclusions

1. Index Effectiveness for Case-Sensitive Queries:
   - When querying with an exact case-sensitive match (e.g., `email = 'JOSEMARSILVA@inmetrics.com.br'`), the regular index (IDX_CUSTOMERS_EMAIL) is effectively used, resulting in an efficient INDEX RANGE SCAN.
2. Limitations of Regular Indexes with Functions:
   - When using a function in the query predicate (e.g., `LOWER(email) = LOWER('JOSEMARSILVA@inmetrics.com.br')`), the regular index becomes ineffective. This results in a full table scan, which is much less efficient, especially for large tables.
3. Function-Based Indexes as a Solution:
   - Creating a function-based index on `LOWER(email)` addresses the limitation of regular indexes when using functions in queries.
   - After creating the function-based index (IDX_FB_CUSTOMERS_EMAIL), queries using `LOWER(email)` in the predicate can utilize this index, reverting to an efficient INDEX RANGE SCAN.
4. Performance Implications:
   - Using the appropriate index (either regular or function-based) results in a significantly lower cost and faster execution time compared to a full table scan.
   - The execution plan shows a cost of 4 for index-based access vs. 1082 for a full table scan, demonstrating the substantial performance benefit of using the correct index.
5. Query Optimization Strategies:
   - For case-insensitive searches or when using functions in query predicates, function-based indexes can be a powerful optimization tool.
   - It's important to align the index creation with the actual query patterns to ensure optimal performance.
6. Importance of Statistics:
   - After creating new indexes, gathering statistics is crucial for the optimizer to make informed decisions about index usage.
---

## II. Performance Tuning CheatSheet

## II CheatSheet.1: Turn Trace On/Of, Explain Plan, Execution Plan Golden step

* **Scenario**:
  * Usefull when ... you have a query and want to determine how does this query costs
* **Analysis**:
  * Use autot expl to evaluate query metrics
* **Conclusion**:
  * Evaluate metrics to recommend query performance improvements

```sql
-- Turn AUTOTRACE TRACEONLY ON
set autot trace
-- Turn AUTOTRACE TRACEONLY ON with option EXPLAIN STATISTICS (explain statistics does not work on SQLDeveloper)
set autot trace exp stat 
-- Get execution plan from plan table
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
-- Turn AUTOTRACE OFF
set autot trace OFF
```

* VLog [Query Tuning Autotrace](https://www.youtube.com/watch?v=SH6os4zxvgM&list=PL78V83xV2fYnwnyghWzTcD9KN75QC2z1e)
  - [Query Tuning 101 What to Look for in Autotrace Output](https://www.youtube.com/watch?v=SH6os4zxvgM&list=PL78V83xV2fYnwnyghWzTcD9KN75QC2z1e&index=1&pp=iAQB)
  - [Query Tuning 101 How to Run Autotrace in SQL Developer](https://www.youtube.com/watch?v=GeCanC7u8cs&list=PL78V83xV2fYnwnyghWzTcD9KN75QC2z1e&index=2)
  - [Query Tuning 101 Why Use Autotrace](https://www.youtube.com/watch?v=BSkDMaOB0xQ&list=PL78V83xV2fYnwnyghWzTcD9KN75QC2z1e&index=3)
  - [Query Tuning 101: How to Compare Execution Plans](https://www.youtube.com/watch?v=9oxdORc0KAQ&list=PL78V83xV2fYnwnyghWzTcD9KN75QC2z1e&index=4)
  - [Query Tuning 101: Access vs. Filter Predicates In Execution Plans](https://www.youtube.com/watch?v=K0f2Yzue7yw&list=PL78V83xV2fYnwnyghWzTcD9KN75QC2z1e&index=5)



```sql
set serveroutput off
set linesize 400

variable app_session number;
variable app_id number;

BEGIN
    :app_session := 999;
    :app_id      := 666;
END;
/
-- end of special instruction for bind variables

SELECT /*+ gather_plan_statistics */ ...
FROM ...;

select * from table(dbms_xplan.display_cursor(format => 'ALLSTATS LAST +COST'));
select * from table(dbms_xplan.display_cursor(format => 'ALLSTATS LAST +COST +BYTES'));
```


## II CheatSheet.2: Query object statistics

* **Scenario**:
  * Usefull when ... you have a table and want do see if statistics are up to date
* **Analysis**:
  * Check how recent the LAST_ANALYZED timestamp is.
  * Check if NUM_ROWS is consistent with the expected volume of data.
  * Compare NUM_DISTINCT values for key columns (like alternate keys or filtering columns).
  * Evaluate if important columns have histograms when there is data skew.
* **Conclusion**:
  * Out-of-date or missing statistics may lead the optimizer to generate suboptimal execution plans.
  * If LAST_ANALYZED is null or very old, or if NUM_ROWS does not reflect reality, performance issues may arise.
  * Regularly collecting statistics (manually or via scheduled jobs) is essential for maintaining optimal performance.
  * It's especially critical after significant data loads, deletions, or structural changes to the table.

* [`query_tab_col_ind_statistics.sql`](../scripts/query_tab_col_ind_statistics.sql)

```sql
-- 
SELECT table_name, TO_CHAR(last_analyzed, 'DD-MON-YYYY HH24:MI:SSSS') AS last_analyzed, num_rows, blocks, avg_row_len
FROM all_tab_statistics -- or dba_tab_statistics (require dba privileges)
WHERE owner = 'STUDY' 
AND table_name = 'CUSTOMERS'
ORDER BY owner, table_name;
```

```sql
SELECT table_name, column_name, num_distinct, density, num_nulls,  UTL_RAW.CAST_TO_VARCHAR2(low_value) AS low_value, UTL_RAW.CAST_TO_VARCHAR2(high_value) AS high_value, histogram, TO_CHAR(last_analyzed, 'DD-MON-YYYY HH24:MI:SSSS') AS last_analyzed
FROM all_tab_col_statistics
WHERE owner = 'STUDY' AND table_name = 'CUSTOMERS'
ORDER BY owner, table_name;
```

## II CheatSheet.3: Query indexed columns

* **Scenario**:
  * Usefull when ... you want to identify what indexes does a table has
* **Analysis**:
  * Indexes, well used, can improve query performance
* **Conclusion**:
  * Analyse table indexes to recommend better Indexing Strategy

* [`query_tab_col_ind_statistics.sql`](../scripts/query_tab_col_ind_statistics.sql)

```sql
-- Query table Indexes
SELECT index_name, column_name, column_position, descend
FROM all_ind_columns
WHERE table_name = 'CUSTOMERS'
  AND index_owner = 'STUDY'
ORDER BY index_name, column_position;
```

```result
INDEX_NAME        COLUMN_NAME COLUMN_POSITION DESCEND
----------------- ----------- --------------- -------
AK_CUSTOMERS_CODE CODE        1               ASC
SYS_C0056973      ID          1               ASC
```


## II Cheatsheet.99: Quick Wins, Blogs, Vlogs, etc

## II Cheatsheet.99.a. Default Simple Response, Quick Wins, What should you do

* **Scenario**:
  * Usefull when ... someone asks you what do you do to improve performance
* **Analysis**:
  * someone insists you must answer generical response not null. Answers "it depends on ..." should not be accepted
* **Conclusion**:
  * SQL Query Tuning
    - Analyze execution plans
    - Use indexes effectively
    - Avoid full table scans
  * Database Configuration
    - Optimize SGA and PGA sizes
    - Adjust init.ora parameters
  * Monitoring and Troubleshooting
    - Use AWR, ASH, and ADDM reports
    - Monitor system performance metrics
  * General Tips:
    - [cardinality, column correlations, data skews, histograms](https://gist.github.com/kzhangkzhang/2866c2530c5a0ec337c475879eecabc0#general-tip)
    - keep all indexes small
    - use hints as temporary solutions
    - triggers on tables causes performance issues
  * General Concepts:
    - [What is a good plan for the Optimizer](https://gist.github.com/kzhangkzhang/2866c2530c5a0ec337c475879eecabc0#general-concept)
      - Optimizer different goals: 
        - **cost**: the cheap, the better; 
        - **performance**: the faster, the better
    - [Data Access Method](https://techiedba.wordpress.com/2011/08/12/data-access-methods-in-oracle/)
      - Full Table SCAN (FTS); Table Access by ROW-ID; Index Unique Scan; Index Range Scan; Index Skip Scan; Full Index Scan; Fast Full Index Scans; Index Joins; Hash Access; Cluster Access; Bit Map Index
    - [Join Method](https://www.youtube.com/watch?v=pJWCwfv983Q)
      - 


## II Cheatsheet.99.b. Usefull Commands

* Commands
  - Flush Shared Pool, Buffer Cache

```sql
alter system flush shared_pool;
alter system flush buffer_cache;
```

## II Cheatsheet.99.c. Usefull Commands - Limit number of rows outputed

* If you're using Oracle 12c or newer (most common now):

```sql
SELECT * 
FROM study.customers
ORDER BY id -- You should specify order before fetch here
FETCH FIRST 100 ROWS ONLY;

```

* If you're using Oracle 11g or earlier
  * `ROWNUM` is assigned before ORDER BY, so it may not work well if ordering is needed.

```sql
SELECT * 
FROM (
  SELECT * 
  FROM study.customers
) 
WHERE ROWNUM <= 100;
```


## II Cheatsheet.99.d. SQLDeveloper hands on

### II Cheatsheet.99.d.1. Execute one command on SQLDevelopers

  * On `SQLDeveloper` body-multiline-text fill your `sql`
  * On `SQLDeveloper` top-sheet icon-play `Run Statement (Ctrl+Enter)`

```sql
SELECT 1 / COUNT(DISTINCT customer_type_id) FROM STUDY.customers;
```


### II Cheatsheet.99.d.2. Execute more than one command at once

* On `SQLDeveloper` body-multiline-text fill your `sql` separating with `;`
* On `SQLDeveloper` body-multiline-text **select all** rows you want to run (they must be separeted by `;`);
* On `SQLDeveloper` top-sheet icon-play `Run Statement (Ctrl+Enter)`
* Each command line separeted by `;` will be shown in a differente `Query Result` result-sheet

```sql
SELECT 1 / COUNT(DISTINCT customer_status_id) AS selectivity FROM STUDY.customers;
SELECT 1 / COUNT(DISTINCT customer_type_id)   AS selectivity FROM STUDY.customers;
SELECT 1 / COUNT(DISTINCT address_state)      AS selectivity FROM STUDY.customers;
```

```Query-result(customer_status_id: 0, 1, 2, 3, 4, 5)
0,2
```

```Query-result-1(customer_type_id: F, J)
0,5
```

```Query-result-2(address_state: 27 values)
0,037037037037037037037037037037037037037
```

### II Cheatsheet.99.d.3. Execute a command, get execution plan (incomplete) and get statistics (incomplete) like using SET AUTOT TRACE EXPL STAT on SQL*Plus

* On `SQLDeveloper` body-multiline-text fill your `sql` separating with `;`
* On `SQLDeveloper` body-multiline-text select all rows you want to run;
* On `SQLDeveloper` top-sheet icon-play `Run Statement (Ctrl+Enter)`
* Each command line separeted by `;` will be shown in a differente `Query Result` result-sheet
* Statistics of execution will be shown in a `Script Output` result-sheet
* VLog [Query Tuning Autotrace](https://www.youtube.com/watch?v=SH6os4zxvgM&list=PL78V83xV2fYnwnyghWzTcD9KN75QC2z1e)


```sql
SET AUTOT TRACE EXPL STAT
SELECT 1 / COUNT(DISTINCT customer_type_id) FROM STUDY.customers;
SET AUTOT OFF
```

* But metrics shown are **INCOMPLETE AND SO POOR INFORMATIONS**! How to fix this?

```script-output
Autotrace TraceOnly
 Exhibits the performance statistics with silent query output
>>Query Run In:Query Result 1

PLAN_TABLE_OUTPUT                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SQL_ID: 0xt1gmwhjjw3t, child number: 0 cannot be found 
 

Statistics
-----------------------------------------------------------
            6958  RM usage
              10  non-idle wait count
               1  opened cursors cumulative
               1  opened cursors current
               1  pinned cursors current
               1  user calls
```

### II Cheatsheet.99.d.4. Execute a command and get execution plan like using SET AUTOT TRACE EXPL STAT on SQL*Plus

* You do not need to SET AUTOTRACE a second output tab `Query Result 1` shows de cursor display with execution plan
* **BUT** you still don't have metrics, how to get execution metrics?

```sql
EXPLAIN PLAN FOR
    SELECT 1 / COUNT(DISTINCT customer_type_id) FROM STUDY.customers;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
```

```plan-table-output
  :
SQL_ID  0xt1gmwhjjw3t, child number 2
-------------------------------------
SELECT 1 / COUNT(DISTINCT customer_type_id) FROM STUDY.customers
 
Plan hash value: 3095916820
 
------------------------------------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                      | Name                           | Starts | E-Rows | A-Rows |   A-Time   | Buffers |  OMem |  1Mem | Used-Mem |
------------------------------------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT               |                                |      1 |        |      1 |00:00:00.04 |       5 |       |       |          |
|   1 |  SORT AGGREGATE                |                                |      1 |      1 |      1 |00:00:00.04 |       5 |       |       |          |
|   2 |   PX COORDINATOR               |                                |      1 |        |      2 |00:00:00.04 |       5 | 73728 | 73728 |          |
|   3 |    PX SEND QC (RANDOM)         | :TQ10001                       |      0 |      1 |      0 |00:00:00.01 |       0 |       |       |          |
|   4 |     SORT AGGREGATE             |                                |      0 |      1 |      0 |00:00:00.01 |       0 |       |       |          |
|   5 |      VIEW                      | VW_DAG_0                       |      0 |      2 |      0 |00:00:00.01 |       0 |       |       |          |
|   6 |       HASH GROUP BY            |                                |      0 |      2 |      0 |00:00:00.01 |       0 |  2442K|  2442K|  522K (0)|
|   7 |        PX RECEIVE              |                                |      0 |      2 |      0 |00:00:00.01 |       0 |       |       |          |
|   8 |         PX SEND HASH           | :TQ10000                       |      0 |      2 |      0 |00:00:00.01 |       0 |       |       |          |
|   9 |          HASH GROUP BY         |                                |      0 |      2 |      0 |00:00:00.01 |       0 |  2442K|  2442K|  647K (0)|
|  10 |           PX BLOCK ITERATOR    |                                |      0 |    200K|      0 |00:00:00.01 |       0 |       |       |          |
|* 11 |            INDEX FAST FULL SCAN| IDX_CUSTOMERS_CUSTOMER_TYPE_ID |      0 |    200K|      0 |00:00:00.01 |       0 |       |       |          |
------------------------------------------------------------------------------------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
  11 - access(:Z>=:Z AND :Z<=:Z)
  :  
```

### II Cheatsheet.99.d.5. Execute a command, get execution plan using icon-button SQLDeveloper Explain Plan ... (F10)

* On `SQLDeveloper` body-multiline-text fill your `sql` separating with `;`
* On `SQLDeveloper` body-multiline-text **select all rows you want to run**;
* On `SQLDeveloper` top-sheet icon-play `Explain plan ...` or click (10)
* Statistics of execution will be shown in a `Autotrace` result-sheet

```sql
SELECT 1 / COUNT(DISTINCT customer_type_id) FROM STUDY.customers
```

* Image available [SQLDeveloper-ExecPlan.png](../../doc/images/SQLDeveloper-ExecPlan.png) 



### II Cheatsheet.99.d.6. Execute a command, get execution plan and statistics like using SET AUTOT TRACE EXPL STAT on SQL*Plus

* You do not need to SET AUTOTRACE a second output tab `Query Result 1` shows de cursor display with execution plan
* **BUT** you still don't have metrics, how to get execution metrics?

```sql
-- Step#1: Set statistics level
SHOW PARAMETER STATISTICS_LEVEL;
ALTER SESSION SET STATISTICS_LEVEL = ALL;

-- Step#2: Run your query
SELECT 1 / COUNT(DISTINCT customer_type_id) FROM STUDY.customers;

-- Step#3: Display cursor execution plan and statistics
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL, NULL, 'ADVANCED ALLSTATS LAST'));
```

* **BUT** you still don't have metrics, how to get execution metrics?

```Script-Output
NAME                    TYPE   VALUE   
----------------------- ------ ------- 
client_statistics_level string TYPICAL 
statistics_level        string TYPICAL 

Session altered.

>>Query Run In:Query Result
>>Query Run In:Query Result 1
```

```Query Result 1
SQL_ID  0xt1gmwhjjw3t, child number 2
-------------------------------------
SELECT 1 / COUNT(DISTINCT customer_type_id) FROM STUDY.customers
 
Plan hash value: 3095916820
 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                      | Name                           | Starts | E-Rows |E-Bytes| Cost (%CPU)| E-Time   |    TQ  |IN-OUT| PQ Distrib | A-Rows |   A-Time   | Buffers |  OMem |  1Mem | Used-Mem |
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT               |                                |      1 |        |       |    63 (100)|          |        |      |            |      1 |00:00:00.04 |       5 |       |       |          |
|   1 |  SORT AGGREGATE                |                                |      1 |      1 |     2 |            |          |        |      |            |      1 |00:00:00.04 |       5 |       |       |          |
|   2 |   PX COORDINATOR               |                                |      1 |        |       |            |          |        |      |            |      2 |00:00:00.04 |       5 | 73728 | 73728 |          |
|   3 |    PX SEND QC (RANDOM)         | :TQ10001                       |      0 |      1 |     2 |            |          |  Q1,01 | P->S | QC (RAND)  |      0 |00:00:00.01 |       0 |       |       |          |
|   4 |     SORT AGGREGATE             |                                |      0 |      1 |     2 |            |          |  Q1,01 | PCWP |            |      0 |00:00:00.01 |       0 |       |       |          |
|   5 |      VIEW                      | VW_DAG_0                       |      0 |      2 |     4 |    63   (7)| 00:00:01 |  Q1,01 | PCWP |            |      0 |00:00:00.01 |       0 |       |       |          |
|   6 |       HASH GROUP BY            |                                |      0 |      2 |     4 |    63   (7)| 00:00:01 |  Q1,01 | PCWP |            |      0 |00:00:00.01 |       0 |  2442K|  2442K|  522K (0)|
|   7 |        PX RECEIVE              |                                |      0 |      2 |     4 |    63   (7)| 00:00:01 |  Q1,01 | PCWP |            |      0 |00:00:00.01 |       0 |       |       |          |
|   8 |         PX SEND HASH           | :TQ10000                       |      0 |      2 |     4 |    63   (7)| 00:00:01 |  Q1,00 | P->P | HASH       |      0 |00:00:00.01 |       0 |       |       |          |
|   9 |          HASH GROUP BY         |                                |      0 |      2 |     4 |    63   (7)| 00:00:01 |  Q1,00 | PCWP |            |      0 |00:00:00.01 |       0 |  2442K|  2442K|  647K (0)|
|  10 |           PX BLOCK ITERATOR    |                                |      0 |    200K|   390K|    59   (0)| 00:00:01 |  Q1,00 | PCWC |            |      0 |00:00:00.01 |       0 |       |       |          |
|* 11 |            INDEX FAST FULL SCAN| IDX_CUSTOMERS_CUSTOMER_TYPE_ID |      0 |    200K|   390K|    59   (0)| 00:00:01 |  Q1,00 | PCWP |            |      0 |00:00:00.01 |       0 |       |       |          |
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
Query Block Name / Object Alias (identified by operation id):
-------------------------------------------------------------
  :
 
Outline Data
-------------
  :
Predicate Information (identified by operation id):
---------------------------------------------------
  :
 
Column Projection Information (identified by operation id):
-----------------------------------------------------------
  :
Note
-----
  :
Query Block Registry:
---------------------
  :
```


* Option-1: Script to get metrics **BEFORE** and **AFTER** execution and calculate difference

```sql
-- Step#1: Run this immediately **BEFORE** run your query
SELECT 
    ms.sid, ms.con_id, sn.name, sn.class, ms.value
FROM
    v$mystat ms, 
    v$statname sn 
WHERE
    sn.name = 'consistent gets' 
    AND sn.statistic# = ms.statistic#
ORDER BY ms.sid, ms.con_id, sn.name ;

-- Step#2: Run your query here
SELECT 1 / COUNT(DISTINCT customer_type_id) FROM STUDY.customers;

-- Step#3: Run this immediately **AFTER** run your query
SELECT 
    ms.sid, ms.con_id, sn.name, sn.class, ms.value
FROM
    v$mystat ms, 
    v$statname sn 
WHERE
    sn.name = 'consistent gets' 
    AND sn.statistic# = ms.statistic#
ORDER BY ms.sid, ms.con_id, sn.name ;

-- Step#4: Turn Statistics level off back again
ALTER SESSION SET STATISTICS_LEVEL = TYPICAL;
```

* Now you can calculate differences between after and before: 3771 - 3118 = 653

```Query Result 2
SID   CON_ID NAME            CLASS VALUE
----- ------ --------------- ----- -----
29579 116    consistent gets 8     3118
```

```Query Result 3
SID   CON_ID NAME            CLASS VALUE
----- ------ --------------- ----- -----
29579 116    consistent gets 8     3771
```

* Option-2: To discard or reinitialize a specific SQL statement from the shared pool

```sql
-- Step-1-Option-1: Discard/reinitialize cursor metrics
-- * Pre-requisites: GRANT ON DBMS_SHARED_POOL package
DECLARE
  v_address       VARCHAR2(200);
  v_hash_value    NUMBER;
BEGIN
  -- First, get the address and hash value for the SQL
  SELECT address, hash_value
  INTO v_address, v_hash_value
  FROM v$sqlarea
  WHERE sql_id = '0xt1gmwhjjw3t' AND plan_hash_value = 3095916820
  AND ROWNUM = 1;

  -- Now use these values to purge the SQL
  IF v_address IS NOT NULL THEN
    DBMS_SHARED_POOL.PURGE(
      name => v_address || ',' || v_hash_value,
      flag => 'C');
    DBMS_OUTPUT.PUT_LINE('SQL purged successfully');
  ELSE
    DBMS_OUTPUT.PUT_LINE('SQL not found in shared pool');
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('SQL not found in shared pool');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
```

```sql
-- Step#1: Run your query here
SELECT 1 / COUNT(DISTINCT customer_type_id) FROM STUDY.customers;

-- Step#1: Get metrics here
SELECT sql_id, plan_hash_value, executions, buffer_gets, disk_reads, rows_processed,  parse_calls, last_active_time, child_number
FROM V$SQL
WHERE sql_id = '0xt1gmwhjjw3t' AND plan_hash_value = 3095916820;
```

```Query-Result
SQL_ID        PLAN_HASH_VALUE EXECUTIONS BUFFER_GETS DISK_READS ROWS_PROCESSED PARSE_CALLS LAST_ACTIVE_TIME CHILD_NUMBER
------------- --------------- ---------- ----------- ---------- -------------- ----------- ---------------- ------------
0xt1gmwhjjw3t 3095916820       1           653          0           1               5      09/04/25         1
```


### II Cheatsheet.99.d.7. Execute a command, get execution plan and statistics using icon-button SQLDeveloper Autotrace ... (F6)

* On `SQLDeveloper` body-multiline-text fill your `sql` separating with `;`
* On `SQLDeveloper` body-multiline-text select all rows you want to run;
* On `SQLDeveloper` top-sheet icon-play `Autotrace ...` or click (F6)
* Statistics of execution will be shown in a `Autotrace` result-sheet
* Statistics V$STATNAME of execution will be shown above `Autotrace` result-sheet

```sql
SELECT 1 / COUNT(DISTINCT customer_type_id) FROM STUDY.customers
```

* Image available [SQLDeveloper-ExecPlan.png](../../doc/images/SQLDeveloper-ExecPlan.png) 


```autotrace-v$statsname
buffer is not pinned count 63
bytes received via SQL*Net from client 2693
bytes sent via SQL*Net to client 95855
calls to get snapshot scn: kcmgss 12
calls to kcmgcs 281
CCursor + sql area evicted 1
consistent gets 7447
consistent gets examination 7
consistent gets examination (fastpath) 7
consistent gets from cache 7447
consistent gets pin 7440
consistent gets pin (fastpath) 7440
CPU used by this session 8
CPU used when call started 3
DB time 22
DFO trees parallelized 1
enqueue conversions 8
enqueue releases 14
enqueue requests 18
enqueue waits 2
execute count 11
global enqueue gets sync 230
global enqueue releases 218
in call idle wait time 15
index fetch by key 3
logical read bytes from cache 61005824
messages sent 2
no work - consistent read gets 7174
non-idle wait count 86
opened cursors cumulative 12
OS Block input operations 166989796
OS Block output operations 126791960
OS Involuntary context switches 1460955
OS Maximum resident set size 3592724
OS Page reclaims 14677362
OS System time used 224014
OS User time used 2729163
OS Voluntary context switches 36523313
Parallel operations not downgraded 1
parse count (hard) 6
parse count (total) 14
parse time cpu 1
parse time elapsed 1
process last non-idle time 1
PX local messages recv'd 86
PX local messages sent 86
queries parallelized 1
recursive calls 26
recursive cpu usage 5
Requests to/from client 46
RM usage 90899
rows fetched via callback 1
scheduler wait time 1
session cursor cache hits 1
session logical reads 7447
session pga memory 458752
sorts (memory) 4
sorts (rows) 4062
sql area evicted 1
sql area purged 1
SQL*Net roundtrips to/from client 46
table fetch by rowid 1
table scan blocks gotten 7174
table scan disk non-IMC rows gotten 200000
table scan rows gotten 200000
table scans (long tables) 29
table scans (rowid ranges) 29
user calls 67
workarea executions - optimal 11
workarea memory allocated -11
```


### II Cheatsheet.99.d.8. User's GRANTS required to execute `Autotrace (F6) ...` On SQLDeveloper 

* Grants required for Autotrace and reconnect

```sql
GRANT SELECT_CATALOG_ROLE   TO STUDY;
GRANT SELECT ANY DICTIONARY TO STUDY;
-- reconnect required after grants
```
