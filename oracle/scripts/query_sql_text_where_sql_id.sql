-- ----------------------------------------------------------------------------
-- filename   : query_sql_text_where_sql_id.sql
-- description: Get SQL_TEXT from SQL_ID
--              1. Using V$SQLAREA (Simplest for quick checks)
--              2. Using V$SQLTEXT_WITH_NEWLINES (Maintains formatting)
--              3. Using V$SQLTEXT with LISTAGG (Single row output)
--              4. DBMS_XPLAN.DISPLAY_CURSOR (With execution plan)
--              5. Direct Query Combining V$SESSION with V$SQLAREA
--              6. Using XMLAGG for Very Long SQL Statements
--
--              Premisses: To run these queries, you need at least one of these privileges:
--              * SELECT_CATALOG_ROLE
--              * SELECT ANY DICTIONARY privilege
--              * SYSDBA, SYSOPER, or SYSASM privilege
-- revision   : 
--              * 2025-05-12 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------


-- ----------------------------------------------------------------------------
-- 1. Using V$SQLAREA (Simplest for quick checks)
-- ----------------------------------------------------------------------------
SELECT sql_fulltext
FROM   v$sqlarea
WHERE  sql_id = '7u8u5v1356amb'
;


-- ----------------------------------------------------------------------------
-- 2. Using V$SQLTEXT_WITH_NEWLINES (Maintains formatting)
-- ----------------------------------------------------------------------------
SELECT sql_text
FROM   v$sqltext_with_newlines
WHERE  sql_id = '7u8u5v1356amb'
ORDER BY piece
;


-- ----------------------------------------------------------------------------
-- 3. Using V$SQLTEXT with LISTAGG (Single row output)
-- ----------------------------------------------------------------------------
SELECT LISTAGG(sql_text) WITHIN GROUP (ORDER BY piece) AS complete_sql
FROM v$sqltext
WHERE sql_id = '7u8u5v1356amb'
;


-- ----------------------------------------------------------------------------
-- 4. DBMS_XPLAN.DISPLAY_CURSOR (With execution plan)
-- ----------------------------------------------------------------------------
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR('7u8u5v1356amb'))
;


-- ----------------------------------------------------------------------------
-- 5. Direct Query Combining V$SESSION with V$SQLAREA
-- ----------------------------------------------------------------------------
SELECT s.sid,
       s.serial#,
       s.username,
       s.machine,
       s.program,
       s.status,
       s.sql_id,
       q.sql_fulltext
FROM   v$session s
LEFT   JOIN v$sqlarea q ON s.sql_id = q.sql_id
WHERE  s.username IS NOT NULL
AND    s.sql_id = '7u8u5v1356amb'
--AND    s.status = 'ACTIVE'
;

-- ----------------------------------------------------------------------------
-- 6. Using XMLAGG for Very Long SQL Statements
-- ----------------------------------------------------------------------------
SELECT XMLAGG(XMLELEMENT(E, sql_text) ORDER BY piece).GETCLOBVAL() AS sql_text
FROM v$sqltext
WHERE sql_id = '7u8u5v1356amb'
;


-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
