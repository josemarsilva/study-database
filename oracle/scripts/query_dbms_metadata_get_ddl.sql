-- ----------------------------------------------------------------------------
-- filename   : query_dbms_metadata_get_ddl.sql
-- description: Get DDL Metadata
--              1. TABLE
--              2. INDEX
--              3. PROCEDURE
--              4. FUNCTION
--              5. SEQUENCE
--              # References
--                - https://docs.oracle.com/en/database/oracle/oracle-database/19/arpls/DBMS_METADATA.html#GUID-3EDAC04F-EB02-4FE5-87DD-712D3E926C3D
-- revision   : 
--              * 2025-05-13 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------


-- ----------------------------------------------------------------------------
-- 1. TABLE
-- ----------------------------------------------------------------------------
SELECT DBMS_METADATA.GET_DDL('TABLE', 'ORDERS', 'STUDY') FROM DUAL;


-- ----------------------------------------------------------------------------
-- 2. INDEX
-- ----------------------------------------------------------------------------
SELECT DBMS_METADATA.GET_DDL('INDEX', 'FK_ORDERITEMS_ORDERID', 'STUDY') FROM DUAL;


-- ----------------------------------------------------------------------------
-- 3. PROCEDURE
-- ----------------------------------------------------------------------------
SELECT DBMS_METADATA.GET_DDL('PROCEDURE', 'LOAD_CUSTOMERS', 'STUDY') FROM DUAL;


-- ----------------------------------------------------------------------------
-- 4. FUNCTION
-- ----------------------------------------------------------------------------
SELECT DBMS_METADATA.GET_DDL('FUNCTION', 'GET_ARRAY_ELEMENT', 'STUDY') FROM DUAL;


-- ----------------------------------------------------------------------------
-- 5. SEQUENCE
-- ----------------------------------------------------------------------------
SELECT DBMS_METADATA.GET_DDL('SEQUENCE', 'CUSTOMERS_SEQ', 'STUDY') FROM DUAL;


-- ----------------------------------------------------------------------------
-- 
-- ----------------------------------------------------------------------------
