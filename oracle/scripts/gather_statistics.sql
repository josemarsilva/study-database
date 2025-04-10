-- ----------------------------------------------------------------------------
-- filename   : gather_statistics.sql
-- description: Gather Table, Columns and Indexes Statistics
-- revision   : 
--              * 2025-04-07 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------

--
-- Option n. 1: Collect table statistics
--

EXEC DBMS_STATS.GATHER_TABLE_STATS('STUDY', 'CUSTOMERS');


--
-- Option n. 2: Collect table statistics for specific columns with histograms
--

DECLARE
BEGIN
  DBMS_STATS.GATHER_TABLE_STATS(
    ownname      => 'STUDY',
    tabname      => 'CUSTOMERS',
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE, -- Automatically chooses sample size
    method_opt   => 'FOR ALL COLUMNS SIZE AUTO'      -- Collect histograms if beneficial
  );
END;
/


--
-- Option n. 3: Collect Index statistics for specific table
--
EXEC DBMS_STATS.GATHER_INDEX_STATS('STUDY', 'idx_customers_address_state');


--
-- Option n. 4: Collect Table Index statistics for specific table
--
BEGIN
  DBMS_STATS.GATHER_INDEX_STATS(
    ownname => 'STUDY',
    indname => 'idx_customers_address_state',
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
    degree => DBMS_STATS.AUTO_DEGREE,
    granularity => 'ALL'
  );
END;
/


-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
