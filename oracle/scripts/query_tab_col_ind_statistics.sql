-- ----------------------------------------------------------------------------
-- filename   : query_tab_col_ind_statistics.sql
-- description: Table Statistics, Columns Statistics, Indexes Statistics, Indexed Columns Statistics
-- revision   : 
--              * 2025-05-13 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------


--
-- Option n. 1: Table Statistics
--

SELECT table_name, TO_CHAR(last_analyzed, 'DD-MON-YYYY HH24:MI:SSSS') AS last_analyzed, num_rows, blocks, avg_row_len
FROM   all_tab_statistics
WHERE  owner = 'STUDY' 
AND    table_name = 'CUSTOMERS'
ORDER  BY owner, table_name;


--
-- Option n. 2: Columns Statistics
--

       
SELECT table_name, column_name, num_distinct, TRUNC(density, 6) AS DENSITY, num_nulls, RPAD(UTL_RAW.CAST_TO_VARCHAR2(low_value),10,' ') AS low_value, RPAD(UTL_RAW.CAST_TO_VARCHAR2(high_value),10,' ') AS high_value, RPAD(histogram,10,' ') AS HISTOGRAM, TO_CHAR(last_analyzed, 'DD-MON-YYYY HH24:MI:SSSS') AS last_analyzed
FROM   all_tab_col_statistics
WHERE  owner = 'STUDY' 
AND    table_name IN ('CUSTOMERS')
ORDER  BY owner, table_name;


--
-- Option n. 3: Index Statistics
--

SELECT i.table_name,
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
FROM   all_indexes i
WHERE  i.owner = 'STUDY' 
  AND  i.table_name = 'CUSTOMERS'
ORDER  BY i.table_name, i.index_name;


--
-- Option n. 4: Indexed Columns Statistics
--

SELECT i.index_name,
       ic.column_name,
       ic.column_position,
       i.distinct_keys,
       i.num_rows,
       ic.column_length,
       i.uniqueness, -- UNIQUE or NONUNIQUE
       i.index_type  -- NORMAL, BITMAP, FUNCTION-BASED NORMAL
FROM   all_indexes i
JOIN   all_ind_columns ic ON i.index_name = ic.index_name AND i.owner = ic.index_owner
WHERE  i.owner = 'STUDY'
  AND  i.table_name = 'CUSTOMERS'
ORDER  BY i.index_name, ic.column_position;

--
-- Option n. 5: TAB_STATISTICS
--

SELECT owner, table_name, partition_name, partition_position, subpartition_name, object_type, num_rows, blocks, empty_blocks, avg_row_len, sample_size, last_analyzed
FROM   ALL_TAB_STATISTICS
WHERE  owner = 'STUDY' AND table_name = 'CUSTOMERS';


--
-- Option n. 6: TAB_HISTOGRAMS
--

SELECT column_name, endpoint_number, endpoint_value, endpoint_actual_value
FROM   ALL_TAB_HISTOGRAMS
WHERE  owner = 'STUDY' AND table_name = 'CUSTOMERS' AND column_name = 'CUSTOMER_STATUS_ID';

-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
