-- ----------------------------------------------------------------------------
-- filename   : query_tab_col_ind_statistics.sql
-- description: Table Statistics, Columns Statistics, Indexes Statistics, Indexed Columns Statistics
-- revision   : 
--              * 2025-04-07 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------


--
-- Option n. 1: Table Statistics
--

SELECT table_name, TO_CHAR(last_analyzed, 'DD-MON-YYYY HH24:MI:SSSS') AS last_analyzed, num_rows, blocks, avg_row_len
FROM all_tab_statistics
WHERE owner = 'STUDY' 
AND table_name = 'CUSTOMERS'
ORDER BY owner, table_name;


--
-- Option n. 2: Columns Statistics
--

SELECT table_name, column_name, num_distinct, density, num_nulls,  UTL_RAW.CAST_TO_VARCHAR2(low_value) AS low_value, UTL_RAW.CAST_TO_VARCHAR2(high_value) AS high_value, histogram, TO_CHAR(last_analyzed, 'DD-MON-YYYY HH24:MI:SSSS') AS last_analyzed
FROM all_tab_col_statistics
WHERE owner = 'STUDY' AND table_name = 'CUSTOMERS'
ORDER BY owner, table_name;


--
-- Option n. 3: Index Statistics
--

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
FROM all_indexes i
WHERE i.owner = 'STUDY' 
  AND i.table_name = 'CUSTOMERS'
ORDER BY i.index_name;


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
FROM all_indexes i
JOIN all_ind_columns ic ON i.index_name = ic.index_name AND i.owner = ic.index_owner
WHERE i.owner = 'STUDY'
  AND i.table_name = 'CUSTOMERS'
ORDER BY i.index_name, ic.column_position;

