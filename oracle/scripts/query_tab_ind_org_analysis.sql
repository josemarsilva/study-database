-- ----------------------------------------------------------------------------
-- filename   : query_tab_ind_org_analysis.sql
-- description: Table and Indexes Organization Analysis
--              1. Clustering Factor Analysis - Index Health Check
--              2. Index vs Table Analysis
--              3. Identifying High Table Row Chaining in Oracle
--              4. Find Large Tables with PCTFREE/PCTUSED Issues
-- revision   : 
--              * 2025-05-19 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- 1. Clustering Factor Analysis - Index Health Check
--    * GOOD: when ~ table.blocks; 
--    * BAD:  when table.num_rows
-- ----------------------------------------------------------------------------
SELECT 
    i.owner,
    i.index_name,
    i.table_name,
    i.blevel,
    i.leaf_blocks,
    i.num_rows,
    i.status,
    i.tablespace_name,
    ROUND(i.num_rows/DECODE(i.leaf_blocks,0,1,i.leaf_blocks),2) as "ROWS_PER_BLOCK",
    ROUND(((i.leaf_blocks*8192)/DECODE(i.num_rows,0,1,i.num_rows)),2) as "BYTES_PER_ROW",
    i.clustering_factor,
    ROUND(i.clustering_factor/DECODE(i.num_rows,0,1,i.num_rows),2) as "CF_RATIO",
    CASE 
        WHEN i.blevel > 3 THEN 'High B-Tree Levels'
        WHEN i.num_rows/DECODE(i.leaf_blocks,0,1,i.leaf_blocks) < 100 AND i.leaf_blocks > 100 THEN 'Low Row Density'
        WHEN i.clustering_factor > 2*i.num_rows THEN 'Poor Clustering'
        ELSE 'OK' 
    END as "STATUS_CHECK"
FROM 
    all_indexes i
WHERE 
    i.owner NOT IN ( 'SYS', 'MDSYS' )
    AND i.status = 'VALID'
    AND i.num_rows > 1000
ORDER BY 
    CASE WHEN i.clustering_factor > 2*i.num_rows THEN 0 ELSE 1 END,
    i.clustering_factor/DECODE(i.num_rows,0,1,i.num_rows) DESC;


-- ----------------------------------------------------------------------------
-- 2. Index vs Table Analysis
--    * ALTER TABLE your_table_name MOVE; -- Then rebuild all indexes on this table
--    * ALTER INDEX your_index_name REBUILD; -- Add ONLINE parameter if you have Enterprise Edition and need to minimize disruption
-- ----------------------------------------------------------------------------
SELECT 
    i.owner,
    i.index_name,
    i.table_name,
    i.blevel,
    i.leaf_blocks,
    i.num_rows as index_rows,
    t.num_rows as table_rows,
    i.status,
    i.clustering_factor,
    ROUND(i.clustering_factor/DECODE(t.num_rows,0,1,t.num_rows),2) as "CF_TO_ROWS_RATIO",
    CASE 
        WHEN i.blevel > 3 THEN 'YES (HIGH BLEVEL)' 
        WHEN i.clustering_factor > 1.5*t.num_rows THEN 'YES (POOR CLUSTERING)'
        WHEN i.status = 'UNUSABLE' THEN 'YES (UNUSABLE)'
        ELSE 'NO' 
    END as "REBUILD_RECOMMENDED"
FROM 
    all_indexes i,
    all_tables t
WHERE 
    i.owner NOT IN ( 'SYS', 'MSD' )
    AND i.table_name = t.table_name
    AND i.table_owner = t.owner
    AND t.num_rows > 100
ORDER BY 
    CASE WHEN i.clustering_factor > 1.5*t.num_rows THEN 0 ELSE 1 END,
    (i.clustering_factor/DECODE(t.num_rows,0,1,t.num_rows)) DESC;


-- ----------------------------------------------------------------------------
-- 3. Identifying High Table Row Chaining in Oracle
-- ----------------------------------------------------------------------------
SELECT
    table_name,
    num_rows,
    chain_cnt,
    ROUND((chain_cnt/DECODE(num_rows,0,1,num_rows))*100,2) as "CHAINED_ROW_PERCENT"
FROM
    all_tables
WHERE
    owner = 'STUDY'
    AND  table_name LIKE '%';


-- ----------------------------------------------------------------------------
-- 4. Find Large Tables with PCTFREE/PCTUSED Issues
-- ----------------------------------------------------------------------------
SELECT
    owner,
    table_name,
    pct_free,
    pct_used,
    avg_row_len,
    (SELECT value FROM v$parameter WHERE name = 'db_block_size') as db_block_size,
    ROUND((avg_row_len / ((SELECT value FROM v$parameter WHERE name = 'db_block_size') * (1-pct_free/100))),2) as row_to_block_ratio,
    CASE
        WHEN avg_row_len > ((SELECT value FROM v$parameter WHERE name = 'db_block_size') * (1-pct_free/100))*0.9
        THEN 'HIGH Chaining Risk'
        ELSE 'Normal'
    END as risk_level
FROM
    all_tables
WHERE
    owner NOT IN ( 'SYS', 'MDSYS', 'APEX_240200', 'CTXSYS', 'C##CLOUD$SERVICE', 'OML$METADATA', 'ODI_REPO_USER', 'SH', 'SSB' )
    AND num_rows > 1000
ORDER BY
    owner, row_to_block_ratio DESC;


-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
