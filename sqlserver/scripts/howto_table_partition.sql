-- ----------------------------------------------------------------------------
-- filename: howto_table_partition.sql
-- purpose : How to table partition and query partition information
-- revision: 2023-12-15 18:35 - josemarsilva@inmetrics.com.br - 
-- remarks : 
--			* https://learn.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-query-plan-transact-sql?view=azuresqldb-current
--			* https://pedrogalvaojunior.wordpress.com/tag/partition/
--			* https://database.guide/return-all-rows-from-a-specific-partition-in-sql-server-t-sql/
-- ----------------------------------------------------------------------------

--
-- Criar uma função de partição
--
CREATE PARTITION FUNCTION fn_partfunc_mypartitionedtable (char(1))
AS RANGE LEFT FOR VALUES ('A', 'I', 'P');

--
-- Criar um esquema de partições associado à função de partição
--
CREATE PARTITION SCHEME ps_partscheme_mypartitionedtable
AS PARTITION fn_partfunc_mypartitionedtable
TO PRIMARY; -- Azure SQL Server aceita apenas PRIMARY

--
-- Criar a tabela particionada
--
CREATE TABLE mypartitionedtable
(
    id BIGINT IDENTITY(1,1) NOT NULL,
    status char(1),
    othernumericcolumn INT,
    othersmallintcolumn SMALLINT,
    otherbigintcolumn BIGINT,
    othervarcharcolumn VARCHAR(30),
    othernvarcharcolumn VARCHAR(100),
    otherdatecolumn DATE,
    otherdatetimecolumn DATETIME,
    -- Outras colunas da tabela...
    CONSTRAINT pk_mypartitionedtable PRIMARY KEY CLUSTERED 
    (
        id ASC
    )
)
ON ps_partscheme_mypartitionedtable(status);

--
-- Criar um índice não clusterizado particionado include outras colunas
--
CREATE NONCLUSTERED INDEX ix_status_include_othernumericcolumn
ON mypartitionedtable(status)
INCLUDE (othernumericcolumn)
ON ps_partscheme_mypartitionedtable(status);

--
-- Criar um índice não clusterizado particionado com colunas fazendo parte da chave
--
CREATE NONCLUSTERED INDEX IX_status_othernumericcolumn_Include_others
ON mypartitionedtable(status, othernumericcolumn)
INCLUDE (othersmallintcolumn, otherbigintcolumn, othervarcharcolumn, otherdatecolumn, otherdatetimecolumn)
ON ps_partscheme_mypartitionedtable(status);

--
-- Criar um índice não clusterizado particionado com colunas fazendo parte da chave
--
CREATE NONCLUSTERED INDEX IX_status_othernumericcolumnothersmallintcolumn_Include_others
ON mypartitionedtable(status, othernumericcolumn, othersmallintcolumn)
INCLUDE (otherbigintcolumn, othervarcharcolumn, otherdatecolumn, otherdatetimecolumn)
ON ps_partscheme_mypartitionedtable(status);


--
-- Query partition vs filegroup
--
SELECT
    sys.partition_schemes.name AS name_scheme ,
    sys.data_spaces.name       AS name_filegroup
FROM
    sys.partition_schemes
INNER JOIN
    sys.destination_data_spaces
ON
    sys.destination_data_spaces.partition_scheme_id = sys.partition_schemes.data_space_id
INNER JOIN
    sys.data_spaces
ON
    sys.data_spaces.data_space_id = sys.destination_data_spaces.data_space_id
WHERE
    sys.partition_schemes.name = 'ps_particao_esquema'

--
--
--
SELECT
    *
FROM
    sys.partitions
WHERE
    object_id = OBJECT_ID('dbo.mypartitionedtable')
AND sys.partitions.index_id =
    (
        SELECT
            sys.indexes.index_id
        FROM
            sys.indexes
        WHERE
            object_id        = OBJECT_ID('dbo.mypartitionedtable')
        AND sys.indexes.name = 'IX_status_Include_othernumericcolumn' 
	)


--
-- 
--
SELECT
    sys.partition_functions.name ,
    sys.partition_range_values.* ,
    sys.partition_schemes.name AS name_scheme
FROM
    sys.partition_functions
INNER JOIN
    sys.partition_range_values
ON
    sys.partition_range_values.function_id = sys.partition_functions.function_id
INNER JOIN
    sys.partition_schemes
ON
    sys.partition_schemes.function_id = sys.partition_functions.function_id
WHERE
    sys.partition_functions.name = 'ps_particao_esquema'

--
-- Query example
--
SELECT 
	othervarcharcolumn, 
	MAX(otherbigintcolumn) 
FROM 
	mypartitionedtable 
WHERE status = 'A' 
AND othernumericcolumn = 1234 
AND othersmallintcolumn = 3 
GROUP BY othervarcharcolumn
