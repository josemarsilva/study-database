WITH T1 AS (
select SUM(duration)/1000/1000 as totalDur, sum(cpu) totalCpu,sum(reads) totalReads,sum(writes) totalWrites, count(*) totalExecutions
FROM FN_TRACE_GETTABLE('C:\Users\ce.br.svc.sp-cluster\Desktop\st_wiseit_04052017.trc', 1)
where eventClass IN (41,45,12)
)
SELECT SUBSTRING(textData,1,100)         AS sqlText,
  eventClass                             AS eventClass,
  DatabaseName                           AS DataBase_name,
  COUNT(*)                               AS CountOfEExecutions,
  SUM(duration)/1000/1000                AS SumDurationSec,
  SUM(cpu)                               AS SumCpu,
  SUM(Writes)                            AS SumWrites,
  SUM(Reads)                             AS sumReads,
  AVG(Duration)/1000/1000                AS avgDuration,
  AVG(cpu)                               AS avgCpu,
  AVG(Reads)                             AS avgReads,
  AVG(Writes)                            AS avgWrites,
  AVG(ROWCOUNTS)                                AS avgROWCounts,
  100*count(*)/t1.totalExecutions           AS pct_excutions,
  100*(SUM(duration)/1000/1000)/t1.totalDur    AS pct_duration,
  100*SUM(cpu)/t1.totalCpu                 AS pct_cpu,
  100*SUM(Reads)/t1.totalReads                AS pct_reads,
  100*SUM(Writes)/t1.totalWrites            AS pct_writes
FROM FN_TRACE_GETTABLE('C:\Users\ce.br.svc.sp-cluster\Desktop\st_wiseit_04052017.trc', 1), T1
WHERE eventClass IN (41,45,12)
GROUP BY SUBSTRING(textData,1,100),
  eventClass,
  DatabaseName,
  t1.totalDur,
  t1.totalCpu,
  t1.totalWrites,
  t1.totalReads,
  t1.totalExecutions 
order by pct_duration desc