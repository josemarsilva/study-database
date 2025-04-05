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
  * [3.3. Execution Plan (SQL Developer)](#33-execution-plan-sqldeveloper)
  * [3.4. Execution Plan (SQL*Plus)](#34-execution-plan-sqlplus)
  * [3.99. References](#399-references)
* [4. Identifying Performance Bottlenecks](#4-identifying-and-diagnosticing-performance-bottlenecks)
  * [4.1 Using v$ views for Query Monitoring](#41-using-v-views-for-query-monitoring)
  * [4.2 Monitoring Performance over Time AWR](#42-monitoring-performance-over-time-with-awr-and-ash)
  * [4.3 Look for Locks and DeadLocks](#43-look-for-locks-and-deadlocks)
  * [4.4 Diagnostics with Oracle Enterprise Manager OEM](#44-diagnostics-with-oracle-enterprise-manager-oem)
* [5. Optimizing Performance Issues Identified](#5-optimizing-issues-identified)
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
* [6. Table Partitioning](#6-table-partitioning)
  * [6.1. Range Partitioning](#61-range-partitioning)
  * [6.2. Hash Partitioning](#62-hash-partitioning)
  * [6.3. Partition Pruning](#63-partition-pruning)
  * [6.4. Partition zone maps Exadata](#64-partition-zone-maps-exadata)
  * [6.5. Drop Partition](#65-drop-partition)
  * [6.6. Query Partition](#66-query-partition)
* [7. Parallel Execution](#7-parallel-execution)
  * [7.1. Using Parallel Queries](#71-using-parallel-queries)
* [I. Laboratories](#i-laboratories)
  * [I.1. Create Sample Tables using scripts](#ilab-1-create-sample-tables-using-scripts)
  * [I.2. Query metrics scenario initial](#ilab-2-query-metrics-scenario-initial)
* [II. Performance Tuning CheatSheet](#ii-performance-tuning-cheatsheet)
  * [II.1. Turn TRACE ON/OFF EXPLAIN PLAN](#ii-cheatsheet1-turn-trace-onof-explain-plan-execution-plan-golden-step)
  * [II.2. Query Object Statistics](#ii-cheatsheet2-query-object-statistics)
  * [II.3. Query Indexed Columns](#ii-cheatsheet3-query-indexed-columns)
  * [II.99. Quick Wins, Blogs, etc](#ii-cheatsheet99-quick-wins-blogs-vlogs-etc)


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
* Laboratories / [Quick Wins, Blogs, Vlogs, etc](#ii99-quick-wins-blogs-vlogs-etc)
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
* Laboratories / [Quick Wins, Blogs, Vlogs, etc](#ii99-quick-wins-blogs-vlogs-etc)
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

  * `under-construction`


### 3.4. Execution Plan (SQL*Plus)

  * `under-construction`


### 3.99. References

* Official Documentation
  * `under-construction`
* Blog/Videos
    * [Data Access Method](https://techiedba.wordpress.com/2011/08/12/data-access-methods-in-oracle/)
      - Full Table SCAN (FTS)
      - Table Access by ROW-ID
      - Index Unique Scan
      - Index Range Scan
      - Index Skip Scan
      - Full Index Scan
      - Fast Full Index Scans
      - Index Joins
      - Hash Access
      - Cluster Access
      - Bit Map Index
    * Join Method
      - [Join Method - Explanation](https://gist.github.com/kzhangkzhang/2866c2530c5a0ec337c475879eecabc0#join-method): **Hash join**, **Nested Loop**, **(Sort) Merge join**, **Cartesian join**
    * [Statistics](https://www.youtube.com/watch?v=IYWmauKtwXI) ![star-icon.png](../../doc/images/star-icon.png)
      - [Correlations](https://www.youtube.com/watch?v=IYWmauKtwXI&t=220s), [Extended Statistics](https://www.youtube.com/watch?v=IYWmauKtwXI&t=299s) and [Skews](https://www.youtube.com/watch?v=IYWmauKtwXI&t=330s) ![star-icon.png](../../doc/images/star-icon.png)
      - Cardinality and Selectivity
    * [Executions Plan, consistent gets](https://www.youtube.com/watch?v=Mt67FqYww_w&)
* Laboratories / [Quick Wins, Blogs, Vlogs, etc](#ii99-quick-wins-blogs-vlogs-etc)
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

* Indexes improve query performance but can also degrade insert/update performance if overused.


#### 5.1.a. B-tree Index

* Best for selective queries


#### 5.1.b. Bitmap Index

* Good for **low-cardinality** columns (e.g., gender, status) but should be avoided in high-write environments


#### 5.1.c. Function-Based Index

* Useful when queries involve functions

```sql
CREATE INDEX idx_customers_address_city ON customers (UPPER(idx_customers_address_city));
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

* `under-construction`


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

1.	Convert EBCDIC to UTF-8 during ETL
2.	Store in Oracle using AL32UTF8
3.	Use external tables or SQL*Loader with proper charset config
4.	Validate with test data for round-trip correctness
5.	Monitor performance if real-time conversion is needed


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

## 7. Parallel Execution

### 7.1. Using Parallel Queries

For large queries, you can enable parallel execution:

```sql
ALTER TABLE orders PARALLEL 4;
SELECT /*+ PARALLEL(o 4) */ * FROM orders o;
```


---

## I. Laboratories

Laboratories is a practical use of performance concepts

## I.Lab-1: Create Sample Tables using scripts

* Pre-requisites:
  * [Laboratory - Oracle OCI FreeTier](../labs/Oracle-OCI-FreeTier/README.md)

### I.Lab-1-Step-1: Create Tables, Constraints, Sequences, etc - Run Script [`01_tables_pk_ak_seq_check.sql`](./sql/01_tables_pk_ak_seq_check.sql)

### I.Lab-1-Step-2: Create Function auxiliar - Run Script [`11_function_get_array_element.sql`](./sql/11_function_get_array_element.sql)

### I.Lab-1-Step-3: Create Procedure Load Customers - Run Script [`12_procedure_load_customers.sql`](./sql/12_procedure_load_customers.sql)

### I.Lab-1-Step-4: Load 200.000 rows into `customers` tables - Run Script [`13_execute_load_customers.sql`](./sql/13_execute_load_customers.sql)

```sql
EXECUTE load_customers(200000) -- 200.000 rows
```

### I.Lab-1-Step-5: Understand table `STUDY.customers` on scenario 00-INITIAL: number of rows, columns, distinct values
  * Table `customers` has 200.000 rows
  * Column `customers.customer_type_id` has 2 distinct values: (**F** Fisica, **J** Juridica)
  * Column `customers.code` is alternate key CNPJ/CPF, has 200.000 distincts keys
  * Column `customer_status_id` has a 4 distinct values: (0: INACTIVE; 1: ACTIVE; 2:BLOCKED; 3:RESTRICTED - ONLY WITHDRAWS)
  * Column `customers.address_city` is 27 distinct values: 'Rio Branco', 'Maceio', ..., 'Palmas'
  * Column `customers.address_state` is 27 distinct values: 'AC', 'AL', ..., 'TO'
  * Index Unique `customers.customer_code`


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

```sql
DESCRIBE customer_types

Name Null?    Type         
---- -------- ------------ 
ID   NOT NULL VARCHAR2(1)  
NAME NOT NULL VARCHAR2(30) 
```

```sql
DESCRIBE customer_statuses
Name Null?    Type         
---- -------- ------------ 
ID   NOT NULL VARCHAR2(1)  
NAME NOT NULL VARCHAR2(30) 
```


* CARDINALITY

```sql
select count(*) from customers -- 200.000
```

* SELECTIVITY

```sql
SELECT 
    COUNT(DISTINCT code),               -- 2 keys: (CPF;CNPJ)
    COUNT(DISTINCT name),               -- 200.000 keys
    COUNT(DISTINCT customer_type_id),   -- 2 keys: [ 'F', 'J' ]
    COUNT(DISTINCT customer_status_id), -- 4 keys: [ 0, 1, 2, 3 ]
    COUNT(DISTINCT address_state)       -- ['AC','AL',...,'TO']
FROM STUDY.customers;
```


---

## I.Lab-2: Query metrics scenario INITIAL

* Pre-requisites:
  * [I.Lab-1: Create Sample Tables using scripts](#ilab-1-create-sample-tables-using-scripts)

* Step-1: Check if Table Has Statistics Collected

```sql
SELECT table_name, TO_CHAR(last_analyzed, 'DD-MON-YYYY HH24:MI:SSSS') AS last_analyzed, num_rows, blocks, avg_row_len
FROM all_tab_statistics 
WHERE owner = 'STUDY' 
AND table_name = 'CUSTOMERS';
```

```result
TABLE_NAME LAST_ANALYZED          NUM_ROWS BLOCKS AVG_ROW_LEN
---------- ---------------------- -------- ------ -----------
CUSTOMERS  04-APR-2025 12:40:5151 150500   5410   248
```

* Step-2: Check table columns statistics

```sql
SELECT table_name, column_name, num_distinct, density, num_nulls,  UTL_RAW.CAST_TO_VARCHAR2(low_value) AS low_value, UTL_RAW.CAST_TO_VARCHAR2(high_value) AS high_value, histogram, TO_CHAR(last_analyzed, 'DD-MON-YYYY HH24:MI:SSSS') AS last_analyzed
FROM all_tab_col_statistics
WHERE owner = 'STUDY' AND table_name = 'CUSTOMERS'
ORDER BY owner, table_name;
```

```result
TABLE_NAME COLUMN_NAME        NUM_DISTINCT DENSITY NUM_NULLS LOW_VALUE HIGH_VALUE HISTOGRAM LAST_ANALYZED
---------  ------------------ ------------ ------- --------- -----------------------------------------------
CUSTOMERS  ID                 150500    0,000007    0        HYBRID    04-APR-2025 12:40:5151
CUSTOMERS  NAME               150500    0,000007    0        AAAATXDEDBQEZILCIGBI XPTADDHPLQHKQHOKUVORUJBDWELQYF GYFKREDIPEOK    ZZZVUXTGRDHLYGFXWZMQ MAMQEXFHELDWGKSLJTQFWCEGFJRVKG PEXLVEWFDZIW    HYBRID    04-APR-2025 12:40:5151
CUSTOMERS  CUSTOMER_TYPE_ID   2         0,000003322 0        F    J    FREQUENCY    04-APR-2025 12:40:5151
CUSTOMERS  CODE               150500    0,000007    0        10000018473    99999447843158    HYBRID    04-APR-2025 12:40:5151
CUSTOMERS  CUSTOMER_STATUS_ID 1         0,000003331 0        FREQUENCY    04-APR-2025 12:40:5151
CUSTOMERS  EMAIL              150500    0,000007    0        aaaamhljwwjzxnythjmp@example.com    zzzyfsyhfwatwfsldgdy@example.com    HYBRID    04-APR-2025 12:40:5151
CUSTOMERS  PHONE              148167    0,000007    0        +55 11100000696    +55 11999998358    HYBRID    04-APR-2025 12:40:5151
CUSTOMERS  ADDRESS_STREET     150500    0,000007    0        Rua AABQMQdFysDnxLFpzanu aBmGVyhpTEIFuNHSljoyXwJvGWQHrr    Rua zzzVePqQJJjLbPtdqveg MQucctYONvmRHAiGDmvxmXciNZNBBe    HYBRID    04-APR-2025 12:40:5151
CUSTOMERS  ADDRESS_UNIT       898       0,001112    0        100    999    HYBRID    04-APR-2025 12:40:5151
CUSTOMERS  ADDRESS_DETAILS    75250     0,000013    75250    AAFFDAlKGahuDVVCBlJR    zzsghMctqSgSYixyEZiD    HYBRID    04-APR-2025 12:40:5151
CUSTOMERS  ADDRESS_ZIP_CODE   150500    0,000007    0        L    db    HYBRID    04-APR-2025 12:40:5151
CUSTOMERS  ADDRESS_CITY       27        0,000003322 0        Aracaju    Vitoria    FREQUENCY    04-APR-2025 12:40:5151
CUSTOMERS  ADDRESS_STATE      27        0,000003322 0        AC    TO    FREQUENCY    04-APR-2025 12:40:5151
CUSTOMERS  SINCE_AT                     0           0        150500            NONE    04-APR-2025 12:40:5151
CUSTOMERS  LAST_ORDER_AT                0           0        150500            NONE    04-APR-2025 12:40:5151
CUSTOMERS  OBS                          0           0        150500            NONE    04-APR-2025 12:40:5151
```

* Step-3: Collect statistics 
  - Simple

```sql
-- This will collect row count, column statistics, and index statistics
EXEC DBMS_STATS.GATHER_TABLE_STATS('STUDY', 'CUSTOMERS');
```

  - Estimate auto, histogram if benefical

```sql
-- More
EXEC DBMS_STATS.GATHER_TABLE_STATS(
    ownname      => 'STUDY',
    tabname      => 'CUSTOMERS',
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE, -- Automatically chooses sample size
    method_opt   => 'FOR ALL COLUMNS SIZE AUTO' -- Collect histograms if beneficial
);
```


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
-- Turn AUTOTRACE TRACEONLY ON with option EXPLAIN STATISTICS
set autot trace exp stat 
-- Turn AUTOTRACE OFF
set autot trace OFF
```

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


```sql
-- 
SELECT table_name, TO_CHAR(last_analyzed, 'DD-MON-YYYY HH24:MI:SSSS') AS last_analyzed, num_rows, blocks, avg_row_len
FROM all_tab_statistics -- or dba_tab_statistics (require dba privileges)
WHERE owner = 'STUDY' 
AND table_name = 'CUSTOMERS';
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


