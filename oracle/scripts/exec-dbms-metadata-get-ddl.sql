-- ----------------------------------------------------------------------------
-- filename   : exec-dbms-metadata-get-ddl.sql
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
-- 1. Setup behavior
-- ----------------------------------------------------------------------------
BEGIN
  -- Set to omit storage clauses in the DDL
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'STORAGE', FALSE);
  -- Optionally omit other parts:
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'TABLESPACE', FALSE);
  DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM, 'SEGMENT_ATTRIBUTES', FALSE);
END;
/


-- ----------------------------------------------------------------------------
-- 2. TABLE
-- ----------------------------------------------------------------------------
SELECT DBMS_METADATA.GET_DDL('TABLE', 'ORDERS', 'STUDY') FROM DUAL;


-- ----------------------------------------------------------------------------
-- 3. INDEX
-- ----------------------------------------------------------------------------
SELECT DBMS_METADATA.GET_DDL('INDEX', 'FK_ORDERITEMS_ORDERID', 'STUDY') FROM DUAL;


-- ----------------------------------------------------------------------------
-- 4. PROCEDURE
-- ----------------------------------------------------------------------------
SELECT DBMS_METADATA.GET_DDL('PROCEDURE', 'LOAD_CUSTOMERS', 'STUDY') FROM DUAL;


-- ----------------------------------------------------------------------------
-- 5. FUNCTION
-- ----------------------------------------------------------------------------
SELECT DBMS_METADATA.GET_DDL('FUNCTION', 'GET_ARRAY_ELEMENT', 'STUDY') FROM DUAL;


-- ----------------------------------------------------------------------------
-- 6. SEQUENCE
-- ----------------------------------------------------------------------------
SELECT DBMS_METADATA.GET_DDL('SEQUENCE', 'CUSTOMERS_SEQ', 'STUDY') FROM DUAL;


-- ----------------------------------------------------------------------------
-- 7. CONSTRAINTS
-- ----------------------------------------------------------------------------
-- #UNDER-CONSTRUCTION


-- ----------------------------------------------------------------------------
-- 
-- ----------------------------------------------------------------------------
