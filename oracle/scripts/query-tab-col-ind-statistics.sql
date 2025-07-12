-- ----------------------------------------------------------------------------
-- filename   : query-tab-col-ind-statistics.sql
-- description: Table Statistics, Columns Statistics, Indexes Statistics, Indexed Columns Statistics
-- revision   : 
--              * 2025-05-13 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------


--
-- Option n. 1: Table Statistics
--

UNDEFINE table_owner
UNDEFINE table_name
DEFINE   table_owner = 'STUDY'
DEFINE   table_name = 'CUSTOMERS'

SELECT
	owner,
    table_name,
	partition_name,
	subpartition_name,
	num_rows, 
	blocks, 
	avg_row_len,
	TO_CHAR(last_analyzed, 'DD-MON-YYYY HH24:MI:SSSS') AS last_analyzed
FROM
    all_tab_statistics
WHERE
    1=1
    AND    owner = '&table_owner' 
    AND    table_name = '&table_name'
ORDER BY
    owner, table_name;


--
-- Option n. 2: Table Columns Statistics
--

UNDEFINE table_owner
UNDEFINE table_name
UNDEFINE column_name
DEFINE   table_owner = 'STUDY'
DEFINE   table_name = 'CUSTOMERS'
DEFINE   column_name = '%'
       
SELECT
    table_name, 
	column_name, 
	num_distinct, 
	TRUNC(density, 6) AS DENSITY, 
	num_nulls, 
	RPAD(UTL_RAW.CAST_TO_VARCHAR2(low_value),10,' ') AS low_value, 
	RPAD(UTL_RAW.CAST_TO_VARCHAR2(high_value),10,' ') AS high_value, 
	RPAD(histogram,10,' ') AS HISTOGRAM, 
	TO_CHAR(last_analyzed, 'DD-MON-YYYY HH24:MI:SSSS') AS last_analyzed
FROM
    all_tab_col_statistics
WHERE  1=1
    AND    owner = '&table_owner' 
    AND    table_name = '&table_name'
    AND    column_name LIKE '&column_name'
ORDER BY
    owner, table_name;


--
-- Option n. 3: Index Statistics
--

UNDEFINE table_owner
UNDEFINE table_name
UNDEFINE index_name
DEFINE   table_owner = 'STUDY'
DEFINE   table_name = 'CUSTOMERS'
DEFINE   index_name = '%'

SELECT
	i.table_name,
	i.index_name, 
	i.index_type, -- NORMAL, BITMAP, FUNCTION-BASED NORMAL
	i.uniqueness, -- UNIQUE or NONUNIQUE
	i.clustering_factor,
	i.num_rows,
	i.leaf_blocks,
	i.distinct_keys,
	i.avg_leaf_blocks_per_key,
	i.avg_data_blocks_per_key,
	TO_CHAR(i.last_analyzed, 'DD-MON-YYYY HH24:MI:SS') AS last_analyzed
FROM
	all_indexes i
WHERE
	i.owner = '&table_owner' 
	AND  i.table_name = '&table_name'
	AND  i.index_name LIKE '&index_name'
ORDER  BY i.table_name, i.index_name;


--
-- Option n. 4: Table Partitions
--

UNDEFINE table_owner
UNDEFINE table_name
UNDEFINE partition_name
DEFINE   table_owner = 'STUDY'
DEFINE   table_name = 'P_RANGE_ORDERS'
DEFINE   partition_name = '%'

SELECT
	table_owner,
    table_name,
	partition_position,
	partition_name,
	subpartition_count,
	composite,
	high_value,
	num_rows,
	TO_CHAR(last_analyzed, 'DD-MON-YYYY HH24:MI:SS') AS last_analyzed
FROM
    all_tab_partitions
WHERE
	table_owner = '&table_owner' 
    AND table_name = '&table_name'
	AND partition_name LIKE '&partition_name'
ORDER BY
    table_owner, table_name, partition_position;



--
-- Option n. 5: Index Partitions
--


UNDEFINE table_owner
UNDEFINE table_name
UNDEFINE index_name
DEFINE   table_owner = 'STUDY'
DEFINE   table_name = 'P_RANGE_ORDERS'
DEFINE   index_name = '%'

SELECT
	i.index_name,
	i.index_type,
	i.table_owner,
	i.table_name,
	i.partitioned,
	ip.partition_position,
	ip.partition_name,
	ip.subpartition_count,
	ip.high_value,
	ip.status,
	ip.num_rows,
	TO_CHAR(ip.last_analyzed, 'DD-MON-YYYY HH24:MI:SS') AS last_analyzed
FROM
    all_indexes i,
	all_ind_partitions ip
WHERE
	i.table_owner = '&table_owner' 
    AND i.table_name = '&table_name'
	AND i.index_name LIKE '&index_name'
ORDER BY
	i.table_owner,
	i.table_name,
    i.index_name	
;


--
-- Option n. 6: Indexed Columns and expressions Statistics
--

UNDEFINE table_owner
UNDEFINE table_name
UNDEFINE index_name
DEFINE   table_owner = 'STUDY'
DEFINE   table_name = 'CUSTOMERS'
DEFINE   index_name = '%'

SELECT
	i.table_owner,
	i.table_name,
	i.index_name,
	ic.column_position,
    ic.column_name,
	i.distinct_keys,
	i.num_rows,
	ic.column_length,
	i.uniqueness, -- UNIQUE or NONUNIQUE
	i.index_type  -- NORMAL, BITMAP, FUNCTION-BASED NORMAL
FROM all_indexes i
JOIN all_ind_columns ic ON i.index_name = ic.index_name AND i.owner = ic.index_owner
LEFT OUTER JOIN all_ind_expressions ie ON ie.index_name = ic.index_name AND ie.column_position = ic.column_position
WHERE
	i.owner = '&table_owner' 
	AND  i.table_name = '&table_name'
	AND  i.index_name LIKE '&index_name'
ORDER BY
	i.table_owner,
	i.table_name,
	i.index_name
;

--
-- Option n. 7: TAB_STATISTICS
--

SELECT owner, table_name, partition_name, partition_position, subpartition_name, object_type, num_rows, blocks, empty_blocks, avg_row_len, sample_size, last_analyzed
FROM   ALL_TAB_STATISTICS
WHERE  owner = 'STUDY' AND table_name = 'CUSTOMERS';


--
-- Option n. 8: TAB_HISTOGRAMS
--

SELECT column_name, endpoint_number, endpoint_value, endpoint_actual_value
FROM   ALL_TAB_HISTOGRAMS
WHERE  owner = 'STUDY' AND table_name = 'CUSTOMERS' AND column_name = 'CUSTOMER_STATUS_ID';

-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
