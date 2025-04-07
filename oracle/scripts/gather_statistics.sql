-- ----------------------------------------------------------------------------
-- filename   : gather_statistics.sql
-- description: Gather Table, Columns and Indexes Statistics
-- revision   : 
--              * 2025-04-07 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------

--
-- Option n. 1: 
--

EXEC DBMS_STATS.GATHER_TABLE_STATS('STUDY', 'CUSTOMERS');


--
-- Option n. 2: 
--

EXEC DBMS_STATS.GATHER_TABLE_STATS(
    ownname      => 'STUDY',
    tabname      => 'CUSTOMERS',
    estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE, -- Automatically chooses sample size
    method_opt   => 'FOR ALL COLUMNS SIZE AUTO' -- Collect histograms if beneficial
);
