-- ----------------------------------------------------------------------------
-- filename   : dbms_space_segments_bytes
-- description: 
-- revision   : 
--              * 2025-04-10 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------

--
-- Step no. 1: Query objects size by segments
--

SELECT 
    segment_type,
    segment_name,
    SUM(BYTES) / 1024 / 1024 AS SIZE_MB
FROM 
    USER_SEGMENTS 
WHERE 
    segment_name = NVL('',segment_name)
    AND segment_type = NVL('',segment_type) -- IN ('TABLE', 'INDEX')
GROUP BY 
    segment_type, segment_name
ORDER BY
    segment_type, segment_name;



--
-- Step no. 2: Query TABLE objects size based on Statistics
--

SELECT 
    table_name,
    num_rows,
    blocks,
    avg_row_len,
    blocks * 8192 / 1024 / 1024 AS estimated_size_mb, -- Se block size for 8K
    TO_CHAR(last_analyzed,'YYYY-MM-DD HH24:MI:SS') AS last_analyzed
FROM 
    ALL_TABLES
WHERE 
    owner = 'STUDY'
    AND table_name = 'CUSTOMERS'
ORDER BY owner, table_name;


--
-- Step no. 3: Query INDEX objects size based on Statistics
--

SELECT 
  table_owner,
  table_name,
  owner AS index_owner,
  index_name,
  leaf_blocks * 8192 / 1024 / 1024 AS estimated_size_mb, -- Se block size for 8K
  TO_CHAR(last_analyzed,'YYYY-MM-DD HH24:MI:SS') AS last_analyzed
FROM 
    ALL_INDEXES
WHERE 
    owner = 'STUDY'
    AND table_name = 'CUSTOMERS'
ORDER BY owner, table_name;


--
-- Step no. 4: PL/SQL anonymous block DBMS_SPACE
--

SET SERVEROUT ON SIZE 400000
DECLARE
  v_unformatted_blocks NUMBER;
  v_unformatted_bytes  NUMBER;
  v_fs1_blocks         NUMBER;
  v_fs1_bytes          NUMBER;
  v_fs2_blocks         NUMBER;
  v_fs2_bytes          NUMBER;
  v_fs3_blocks         NUMBER;
  v_fs3_bytes          NUMBER;
  v_fs4_blocks         NUMBER;
  v_fs4_bytes          NUMBER;
  v_full_blocks        NUMBER;
  v_full_bytes         NUMBER;
  v_segment_owner      VARCHAR2(100);
  v_segment_name       VARCHAR2(100);
  v_segment_type       VARCHAR2(100);
BEGIN
  --
  v_segment_owner := 'STUDY';
  v_segment_name  := 'CUSTOMERS';
  v_segment_type  := 'TABLE';
  --
  DBMS_SPACE.SPACE_USAGE(
    segment_owner      => v_segment_owner,
    segment_name       => v_segment_name,
    segment_type       => v_segment_type,
    unformatted_blocks => v_unformatted_blocks,
    unformatted_bytes  => v_unformatted_bytes,
    fs1_blocks         => v_fs1_blocks,
    fs1_bytes          => v_fs1_bytes,
    fs2_blocks         => v_fs2_blocks,
    fs2_bytes          => v_fs2_bytes,
    fs3_blocks         => v_fs3_blocks,
    fs3_bytes          => v_fs3_bytes,
    fs4_blocks         => v_fs4_blocks,
    fs4_bytes          => v_fs4_bytes,
    full_blocks        => v_full_blocks,
    full_bytes         => v_full_bytes
  );
  --
  DBMS_OUTPUT.PUT_LINE('Segment Owner:      ' || v_segment_owner);
  DBMS_OUTPUT.PUT_LINE('Segment Name:       ' || v_segment_name);
  DBMS_OUTPUT.PUT_LINE('Segment Type:       ' || v_segment_type);
  DBMS_OUTPUT.PUT_LINE('Unformatted Blocks: ' || v_unformatted_blocks);
  DBMS_OUTPUT.PUT_LINE('Unformatted Bytes:  ' || v_unformatted_bytes);
  DBMS_OUTPUT.PUT_LINE('Full Blocks:        ' || v_full_blocks);
  DBMS_OUTPUT.PUT_LINE('Full Bytes:         ' || v_full_bytes);
END;


-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
