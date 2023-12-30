-- ----------------------------------------------------------------------------
-- filename: query_cardinality_selectivity.sql
-- purpose : Gather cardinality and selectivity from objects
-- revision: 2023-12-21 11:00 - josemarsilva@inmetrics.com.br - 
-- remarks : https://github.com/josemarsilva/study-database/tree/master/sqlserver/scripts
-- ----------------------------------------------------------------------------

--
-- Table
--
SELECT 
	CONCAT( 
		'UNION ALL SELECT /* sys.dm_exec */ ''1-Table'' AS [ObjType], ',
		'''', table_name, '''',
		' AS [ObjName], ', 
		'COUNT(1) AS [Rows],', 
		'NULL AS [OfTotals], ', 
		'NULL AS [Pct%] ', 
		'FROM ', table_name, ' WITH(NOLOCK)'
	)
FROM
	information_schema.tables WITH (NOLOCK)
WHERE
	table_name IN (
		--
		-- Put your "tables" above
		--
		'cliente_variavel_negociacao',
		'cliente',
		'tipo_cobranca',
		--
	NULL
	)
--
UNION ALL
--
-- Column(Where)
--
SELECT 
	CONCAT( 
		'UNION ALL SELECT /* sys.dm_exec */ ''2-Column(Where)'' AS [ObjType], ',
		'''', table_name, '.', column_name, '''',
		' AS [ObjName], ',
		'COUNT(DISTINCT ', column_name, ') AS [Rows], ', 
		'COUNT(1) AS [OfTotals], ', 
		'COUNT(DISTINCT ', column_name, ') / CONVERT(DECIMAL(15,2), COUNT(1)) * 100 AS [Pct%] ', 
		'FROM ', table_name, ' WITH(NOLOCK)'
	)
FROM
	information_schema.columns WITH (NOLOCK)
WHERE
	CONCAT(table_name, '.', column_name) IN (
		--
		-- Put your "tables.columns" from your WHERE above
		--
		'cliente_variavel_negociacao.status',
		'cliente_variavel_negociacao.id_marca',
		'cliente_variavel_negociacao.id_negociacao_origem',
		'cliente_variavel_negociacao.valor_variavel',
		'cliente.id_tipo_cliente',
		'tipo_cobranca.id_tipo_cobranca',
		--
	NULL
	)
UNION ALL
--
-- Column(Join)
--
SELECT 
	CONCAT( 
		'UNION ALL SELECT /* sys.dm_exec */ ''3-Column(Join)'' AS [ObjType], ',
		'''', table_name, '.', column_name, '''',
		' AS [ObjName], ',
		'COUNT(DISTINCT ', column_name, ') AS [Rows], ', 
		'COUNT(1) AS [OfTotals], ', 
		'COUNT(DISTINCT ', column_name, ') / CONVERT(DECIMAL(15,2), COUNT(1)) * 100 AS [Pct%] ', 
		'FROM ', table_name, ' WITH(NOLOCK)'
	)
FROM
	information_schema.columns WITH (NOLOCK)
WHERE
	CONCAT(table_name, '.', column_name) IN (
		--
		-- Put your "tables.columns" from your JOIN above
		--
		'cliente_variavel_negociacao.id_cliente',
		'cliente.id_cliente',
		'cliente.id_tipo_cobranca',
		'tipo_cobranca.id_tipo_cobranca',
		--
	NULL
	)
--
--
-- ORDER BY
--
ORDER BY 1 ASC
;
