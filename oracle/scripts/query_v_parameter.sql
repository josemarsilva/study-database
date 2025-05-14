-- ----------------------------------------------------------------------------
-- filename   : query_v_parameter.sql
-- description: Parameter
-- revision   : 
--              * 2025-04-10 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------

SELECT name, value
FROM   v$parameter
WHERE  name IN (
    'parallel_max_servers', 
    'parallel_min_servers', 
    'parallel_servers_target', 
    'cpu_count', 
    'parallel_degree_policy'
);

-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
