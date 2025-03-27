# study-database - Oracle - Performance

## 1. Fundamentos do Oracle Database

Antes de aprofundar em performance tuning, é essencial conhecer a arquitetura do Oracle Database:

* **Estrutura Física e Lógica** : Datafiles, redo logs, control files, tablespaces, segmentos, extents e blocks.
* **Processos do Oracle** : PMON, SMON, DBWn, LGWR, CKPT, etc.
* **Arquitetura da SGA e PGA**: Shared Pool, Buffer Cache, Large Pool, Java Pool.
* **Modo de Execução e Processamento de Queries**


## 2. SQL Performance Tuning

* **Otimização de Queries**: Uso correto de índices, hints, subqueries vs. joins, partitioning.
* **Execution Plan (EXPLAIN PLAN)**: Saber interpretar os planos de execução e como ajustá-los.
* **Uso do SQL Trace e TKPROF**: Análise de gargalos em queries.
* **Bind Variables vs. Literals**: Impacto no parsing e performance.


## 3. Índices e Estratégias de Indexação

* **Tipos de índices**: B-tree, Bitmap, Function-based, Reverse Key.
* Como e quando criar e remover índices.
* Index Monitoring e uso de DBA_INDEX_USAGE.


## 4. Optimizer do Oracle (CBO - Cost-Based Optimizer)

* Como o CBO funciona e como ele toma decisões.
* Estatísticas e influência do DBMS_STATS.
* Adaptive Query Optimization (Oracle 12c+).
* Dynamic Sampling e Cardinality Estimation.


## 5. Gerenciamento da Memória

* SGA e PGA Tuning: Ajuste de memória dinâmica e manual.
* Shared Pool tuning: Redução de Hard Parsing.
* Automatic Memory Management (AMM) e Automatic Shared Memory Management (ASMM).


## 6. Ajuste de Storage e I/O Performance

* Configuração de redo logs e redo log groups.
* Controle de Undo Tablespace e Retenção.
* Análise de Wait Events com V$SESSION_WAIT e V$SYSTEM_EVENT.
* ASM (Automatic Storage Management) e impacto na performance.


## 7. Diagnóstico de Problemas de Performance

* Uso de AWR (Automatic Workload Repository) e ASH (Active Session History).
* Query para V$SESSION e V$SQLAREA para identificar queries pesadas.
* Locks e Deadlocks: Monitoramento com V$LOCK e DBA_BLOCKERS.
* Diagnóstico com Oracle Enterprise Manager (OEM).


## 8. Parallel Execution e Partitioning

* Como funciona a execução paralela no Oracle.
* Tipos de Partitioning: Range, List, Hash, Composite.
* Benefícios de parallel queries e partition pruning.


## 9. High Availability e Disaster Recovery

* Uso de Data Guard para replicação e failover.
* Oracle RAC (Real Application Clusters) para alta disponibilidade.
* Backup & Recovery com RMAN (Recovery Manager).


## 10. Automação e Monitoramento

* Como automatizar análises de performance com scripts SQL e PL/SQL.
* Uso de ferramentas como Prometheus + Grafana para métricas de banco.
* Alertas proativos via DBA_ALERT_HISTORY.


## 11. Soft Skills e Estratégia

* Comunicação eficiente com desenvolvedores para otimização de queries.
* Capacidade de análise e resolução de problemas complexos.
* Documentação clara das estratégias de tuning.
