# [study-database - Oracle](../README.md) - Performance

## Mind Map - Oracle - Performance
![Mind Map - Oracle - Performance](../../doc/mind-maps/MindMapDiagram-DatabaseStudy-Oracle-Performance.png) 


## Index

* [1. Physical Structure of the Oracle Database](#1-physical-structure-of-the-oracle-database)
  * [1.1. Datafiles](#11-datafiles)
  * [Control Files](#12-control-files)
  * [Redo Log Files](#13-redo-log-files)
  * [Archive Log Files](#14-archive-log-files)
  * [Undo Tablespace](#15-undo-tablespace)
  * [Temporary Tablespace](#16-temporary-tablespace)
  * [Best Practices for Performance Optimization](#17-best-practices-for-performance-optimization)
* [2. Logical Structure of the Oracle Database](#2-logical-structure-of-the-oracle-database)
  * [Tablespaces](#2-logical-structure-of-the-oracle-database)
  * [Segments](#21-tablespaces)
  * [Extents](#22-segments)
  * [Data Blocks](#23-extents)
* [3. Understanding the Oracle Optimizer](#3-understanding-the-oracle-optimizer)
  * [How the Optimizer Works](#31-how-the-optimizer-works)
  * [Execution Plan (EXPLAIN PLAN)](#32-execution-plan-explain-plan)
* [4. Identifying Performance Bottlenecks](#4-identifying-performance-bottlenecks)
  * [Using v$ views for Query Monitoring](#41-using-v-views-for-query-monitoring)
* [5. Optimizing SQL Queries](#5-optimizing-sql-queries)
  * [5.1. Indexing Strategies](#51-indexing-strategies)
  * [5.2. Bind Variables vs. Literals](#52-bind-variables-vs-literals)
  * [5.3. Avoiding SELECT](#53-avoiding-select)
  * [5.4. EXISTS vs. IN](#54-exists-vs-in)

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

```sql
-- Check active sessions and wait events
SELECT event, state, wait_time, seconds_in_wait
FROM v$session_wait
WHERE wait_class != 'Idle';
```

```sql
-- Find queries consuming the most CPU
SELECT sql_id, executions, buffer_gets, cpu_time
FROM v$sql
ORDER BY cpu_time DESC FETCH FIRST 10 ROWS ONLY;
```


---

## 5. Optimizing SQL Queries

### 5.1. Indexing Strategies

* Indexes improve query performance but can also degrade insert/update performance if overused.
  * **B-tree Index**: Best for selective queries.
  * **Bitmap Index**: Good for low-cardinality columns (e.g., gender, status).
  * **Function-Based Index**: Useful when queries involve functions:

```sql
CREATE INDEX idx_upper_lastname ON employees (UPPER(last_name));
Partitioned Index: Improves performance for large tables.
```

* Check index usage:

```sql
SELECT index_name, table_name, used FROM v$object_usage;
```


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