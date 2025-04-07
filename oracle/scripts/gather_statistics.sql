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
-- Option n. 2: Collect table statistics estimate percental of table
--

EXEC DBMS_STATS.GATHER_TABLE_STATS(
    ownname      => 'STUDY',
    tabname      => 'CUSTOMERS',
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE, -- Automatically chooses sample size
    method_opt   => 'FOR ALL COLUMNS SIZE AUTO' -- Collect histograms if beneficial
);


--
-- Option n. 3: Collect table statistics for specific columns with histograms
--

BEGIN
  DBMS_STATS.GATHER_TABLE_STATS(
    ownname => 'STUDY',
    tabname => 'CUSTOMERS',
    method_opt => 'FOR COLUMNS customer_status_id SIZE AUTO'
  );
END;
/


--
-- Option n. 4: Collect index statistics for specific table
--
BEGIN
  DBMS_STATS.GATHER_INDEX_STATS(
    ownname => 'SEU_SCHEMA',
    indname => 'IDX_COD_STATUS',
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
    degree => DBMS_STATS.AUTO_DEGREE,
    granularity => 'ALL'
  );
END;
/