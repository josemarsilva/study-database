-- ----------------------------------------------------------------------------
-- filename   : gen_awr_report.sql
-- description: Generate AWR Report (HTML)
-- revision   : 
--              * 2025-05-08 - josemarsilva - https://github.com/josemarsilva/study-database/blob/master/oracle/README.md
-- ----------------------------------------------------------------------------

DECLARE
  dbid         NUMBER;
  instance_id  NUMBER;
  start_id     NUMBER;
  end_id       NUMBER;
BEGIN
  dbms_output.enable(NULL);

  SELECT MAX(snap_id) - 1, MAX(snap_id) INTO start_id, end_id FROM dba_hist_snapshot;
  SELECT dbid INTO dbid FROM v$database;
  SELECT instance_number INTO instance_id FROM v$instance;

  -- Output HTML header
  dbms_output.put_line('<html><body>');

  FOR rc IN (
    SELECT output
    FROM TABLE(
      dbms_workload_repository.awr_report_html(
        dbid, instance_id, start_id, end_id
      )
    )
  ) LOOP
    dbms_output.put_line(rc.output);
  END LOOP;

  -- Output HTML footer
  dbms_output.put_line('</body></html>');
END;

-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
