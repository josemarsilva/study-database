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
* [4. Identifying Performance Bottlenecks](#4-identifying-performance-bottlenecks)
  * [4.1 Using v$ views for Query Monitoring](#41-using-v-views-for-query-monitoring)
  * [4.2 Monitoring Performance over Time AWR](#42-monitoring-performance-over-time-with-awr-and-ash)
  * [4.3 Look for Locks and DeadLocks](#43-look-for-locks-and-deadlocks)
  * [4.4 Diagnostics with Oracle Enterprise Manager OEM](#44-diagnostics-with-oracle-enterprise-manager-oem)
* [5. Optimizing SQL Queries](#5-optimizing-sql-queries)
  * [5.1. Indexing Strategies](#51-indexing-strategies)
    * [5.1.1. B-tree Index](#511-b-tree-index)
    * [5.1.2. Bitmap Index](#512-bitmap-index)
    * [5.1.3. Function-Based Index](#513-function-based-index)
    * [5.1.4. Partitioned Index](#514-partitioned-index)
    * [5.1.5. Check Index Usage](#515-check-index-usage)
    * [5.1.6. Clustering Factor](#516-clustering-factor)
    * [5.1.7. Index Reverse Key](#517-index-reverse-key)
    * [5.1.8. Index Organized Table](#518-index-organized-table)
  * [5.2. Bind Variables vs. Literals](#52-bind-variables-vs-literals)
  * [5.3. Avoiding SELECT](#53-avoiding-select)
  * [5.4. EXISTS vs. IN](#54-exists-vs-in)
  * [5.5. In-Memory Table and Columns](#55-in-memory-table-and-columns)
  * [5.6. Cursor Optimization](#56-cursor-optimization)
  * [5.7. Optimizing Joins and Aggregations](#57-optimizing-joins-and-aggregations)
    * [5.7.1. Choosing the Right Join Type](#571-choosing-the-right-join-type)
    * [5.7.2. Using the RIGHT Aggregation Strategy](#572-using-the-right-aggregation-strategy)
* [6. Table Partitioning](#6-table-partitioning)
  * [6.1. Range Partitioning](#61-range-partitioning)
  * [6.2. Hash Partitioning](#62-hash-partitioning)
  * [6.3. Partition Pruning](#63-partition-pruning)
  * [6.4. Partition zone maps Exadata](#64-partition-zone-maps-exadata)
  * [6.5. Drop Partition](#65-drop-partition)
  * [6.6. Query Partition](#66-query-partition)
* [7. Parallel Execution](#7-parallel-execution)
  * [7.1. Using Parallel Queries](#71-using-parallel-queries)


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
  * [Oracle Database - Administration]https://docs.oracle.com/en/database/oracle/oracle-database/23/administration.html
  * [Oracle Database - Administration - SQL Tuning Guide](https://docs.oracle.com/en/database/oracle/oracle-database/23/tgsql/index.html)
* [Video: Oracle Database Architecture - Part1](https://www.youtube.com/watch?v=cvx9wCQZnKw)
  * Chapters: database & instance, memory structures, type of process, server process, background process, putting all together


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

* [Video: Oracle Database Architecture - Part1](https://www.youtube.com/watch?v=cvx9wCQZnKw)
  * Chapters: single instance & RAC, logical storage structures


---

## 3. Understanding the Oracle Optimizer

The Cost-Based Optimizer (CBO) is responsible for determining the most efficient way to execute a query.

### 3.1. How the Optimizer Works

* The CBO evaluates multiple execution plans and selects the one with the lowest estimated cost.
* It relies on statistics (table size, index distribution, data distribution) to make decisions.
* Uses histograms to improve accuracy for columns with skewed data distributions.

Performance Tip: Keep statistics up to date using:

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


---

## 4. Identifying Performance Bottlenecks

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

---

## 5. Optimizing SQL Queries

### 5.1. Indexing Strategies

* Indexes improve query performance but can also degrade insert/update performance if overused.

#### 5.1.1. B-tree Index

Best for selective queries.

#### 5.1.2. Bitmap Index

Good for low-cardinality columns (e.g., gender, status).

#### 5.1.3. Function-Based Index

Useful when queries involve functions:

```sql
CREATE INDEX idx_upper_lastname ON employees (UPPER(last_name));
```

#### 5.1.4. Partitioned Index

Improves performance for large tables.

#### 5.1.5. Check Index Usage

* Check index usage:

```sql
SELECT index_name, table_name, used FROM v$object_usage;
```


#### 5.1.6. Clustering Factor

* `under-construction`

#### 5.1.7. Index Reverse Key

* `under-construction` tabelas que sofrem unique scan

#### 5.1.8. Index Organized Table

* `under-construction`


### 5.2. Bind Variables vs. Literals

* Using literals can cause hard parsing, slowing down execution.
  * Bad practice (causes hard parsing):

```sql
-- Bad practice using hard parse
SELECT * FROM orders WHERE order_id = 123;
```

```sql
-- Better practice avoid hard parse
SELECT * FROM orders WHERE order_id = :order_id;
```

### 5.3. Avoiding SELECT

* Fetching unnecessary columns increases memory usage and I/O.

```sql
-- Bad practice using *
SELECT * FROM customers;
```

```sql
-- Better practice using explicity only necessaries columnns
SELECT name, email FROM customers;
```

### 5.4. EXISTS vs. IN

EXISTS is generally faster when checking for existence:

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

### 5.5. In-Memory Table and Columns

* `under-construction`


### 5.6. Cursor Optimization

* `under-construction`

### 5.7. Optimizing Joins and Aggregations

#### 5.7.1. Choosing the Right Join Type

* Nested Loops: Best for small datasets and indexed joins.
* Hash Join: Efficient for large, unindexed datasets.
* Sort Merge Join: Used when data is pre-sorted.

Check which join is being used with EXPLAIN PLAN.

#### 5.7.2. Using the RIGHT Aggregation Strategy

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

Useful when data is evenly distributed but queries use different keys.

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

## I.1. Lab-I.1: Create Sample Tables using scripts

* Pre-requisites:
  * [Laboratory - Oracle OCI FreeTier](../labs/Oracle-OCI-FreeTier/README.md)
* Step-1: Create Tables, Constraints, Sequences, etc - Run Script [`01_tables_pk_ak_seq_check.sql`](./sql/01_tables_pk_ak_seq_check.sql)
* Step-2: Create Function auxiliar - Run Script [`11_function_get_array_element.sql`](./sql/11_function_get_array_element.sql)
* Step-3: Create Procedure Load Customers - Run Script [`12_procedure_load_customers.sql`](./sql/12_procedure_load_customers.sql)
* Step-4: Load 200.000 rows into `customers` tables - Run Script [`13_execute_load_customers.sql`](./sql/13_execute_load_customers.sql)

```sql
EXECUTE load_customers(2000)
```

* Step-5: Understand table `STUDY.customers`: number of rows, columns, distinct values
  * Table `customers` has 200.000 rows
  * Column `customers.customer_code` is alternate key, so 200.000 distincts keys
  * Column `customers.customer_type` is 2 distinct values: **F** Fisica, **J** Juridica
  * Column `customers.address_city` is 27 distinct values: 'Rio Branco', 'Maceio', ..., 'Palmas'
  * Column `customers.address_state` is 27 distinct values: 'AC', 'AL', ..., 'TO'
  * Index Unique `customers.customer_code`

```sql
select count(*) from customers -- 200.000
```

```sql
DESCRIBE STUDY.customers
Name             Null?    Type           
---------------- -------- -------------- 
ID               NOT NULL NUMBER         
CUSTOMER_NAME    NOT NULL VARCHAR2(100)  
CUSTOMER_TYPE    NOT NULL VARCHAR2(1)    
CUSTOMER_CODE    NOT NULL VARCHAR2(14)   
CUSTOMER_STATUS  NOT NULL NUMBER(1)      
CUSTOMER_EMAIL            VARCHAR2(100)  
CUSTOMER_PHONE            VARCHAR2(30)   
ADDRESS_STREET   NOT NULL VARCHAR2(200)  
ADDRESS_UNIT     NOT NULL VARCHAR2(20)   
ADDRESS_DETAILS           VARCHAR2(30)   
ADDRESS_ZIP_CODE NOT NULL NUMBER(8)      
ADDRESS_CITY     NOT NULL VARCHAR2(50)   
ADDRESS_STATE    NOT NULL VARCHAR2(2)    
LAST_PURCHASE_AT          DATE           
OBS                       VARCHAR2(1000) 
```


```sql
SELECT 
    COUNT(DISTINCT customer_code),   -- CPF/CNPJ
    COUNT(DISTINCT customer_name),   -- name
    COUNT(DISTINCT customer_type),   -- [ 'F', 'J' ]
    COUNT(DISTINCT customer_status), -- [ 0, 1 ]
    COUNT(DISTINCT address_state)    -- ['AC','AL',...,'TO']
FROM STUDY.customers;

COUNT(DISTINCTCUSTOMER_TYPE) COUNT(DISTINCTCUSTOMER_TYPE) COUNT(DISTINCTCUSTOMER_STATUS) COUNT(DISTINCTADDRESS_STATE) COUNT(DISTINCTADDRESS_CITY)
---------------------------- ---------------------------- ------------------------------ ---------------------------- ----------------------------
200000                       2                            1                              27                           27
```


---

## I.2. Lab-I.2: Query metrics scenario INITIAL

* Pre-requisites:
  * [I.1. Lab-I.1: Create Sample Tables using scripts](#i1-lab-i1-create-sample-tables-using-scripts)

* Step-1: Check if Table Has Statistics Collected

```sql
SELECT table_name, last_analyzed, num_rows, blocks, avg_row_len
FROM dba_tab_statistics 
WHERE owner = 'STUDY' 
AND table_name = 'CUSTOMERS';
```

```result
TABLE_NAME LAST_ANALYZED NUM_ROWS BLOCKS AVG_ROW_LEN
---------- ------------- -------- ------ -----------
CUSTOMERS  NULL          NULL     NULL   NULL
```

* Step-2: Collect statistics 

```sql
-- This will collect row count, column statistics, and index statistics. Default method uses AUTO_SAMPLE_SIZE for better performance.
EXEC DBMS_STATS.GATHER_TABLE_STATS('STUDY', 'CUSTOMERS');
```

* New results after collect statistics

```result
TABLE_NAME LAST_ANALYZED NUM_ROWS BLOCKS AVG_ROW_LEN
---------- ------------- -------- ------ -----------
CUSTOMERS  02/04/25      200000   7174   247
```
