-- ----------------------------------------------------------------------------
-- filename: query-cdb-vs-pdb-con-name.sql
-- description : Show and demonstrate differences between CDB - Container Database and PDB Pluggable Database
--              * References:
--          		- https://dbaparadise.com/2023/02/4-ways-of-connecting-to-a-pdb/
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/dynamic-performance-views.html
--                  - https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/static-data-dictionary-views.html
-- revision: 2024-02-15 19:30 - josemarsilva - 
-- ----------------------------------------------------------------------------

--
-- 1. Connect to CDB - Container Database
--

-- sqlplus system/oracle@localhost:1521/free

-- 1.1. Show CONtainer name

show con_name;
/*
CON_NAME
------------------------------
CDB$ROOT

*/


-- 1.2. SELECT some functions to understand where you are connected

SELECT SYS_CONTEXT('USERENV', 'CON_NAME') FROM dual;
/*
SYS_CONTEXT('USERENV','CON_NAME')
--------------------------------------------------------------------------------
CDB$ROOT

*/

SELECT SYS_CONTEXT('USERENV', 'CON_ID') FROM dual;
/*
SYS_CONTEXT('USERENV','CON_ID')
--------------------------------------------------------------------------------
1

*/

-- 1.3. SELECT pdb's
COLUMN NAME FORMAT A15
SELECT CON_ID, DBID, NAME, OPEN_MODE FROM v$pdbs ORDER BY CON_ID;
/*
    CON_ID	   DBID NAME		OPEN_MODE
---------- ------------ --------------- ----------
	 2    858304067 PDB$SEED	READ ONLY
	 3   4002313426 FREEPDB1	READ WRITE


*/


--
-- 2. Connect to PDB - Pluggable Database
--

-- sqlplus system/oracle@localhost:1521/freepdb1

-- 2.1. Show CONtainer name

show con_name;
/*
CON_NAME
------------------------------
FREEPDB1

*/


-- 2.2. SELECT some functions to understand where you are connected

SELECT SYS_CONTEXT('USERENV', 'CON_NAME') FROM dual;
/*
SYS_CONTEXT('USERENV','CON_NAME')
--------------------------------------------------------------------------------
FREEPDB1

*/

SELECT SYS_CONTEXT('USERENV', 'CON_ID') FROM dual;
/*
SYS_CONTEXT('USERENV','CON_ID')
--------------------------------------------------------------------------------
3

*/

-- 2.3. SELECT pdb's
COLUMN NAME FORMAT A15
SELECT CON_ID, DBID, NAME, OPEN_MODE FROM v$pdbs ORDER BY CON_ID;
/*
    CON_ID	 DBID NAME	      OPEN_MODE
---------- ---------- --------------- ----------
	 3 4002313426 FREEPDB1	      READ WRITE

*/


-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
