# study-database - Oracle - Performance

<p align="right">voltar para [study-database - Oracle](../README.md)</p>

## Índice

* 1. [Fundamentos do Oracle Database](#1-fundamentos-do-oracle-database)
  * 1.1. [Estrutura Física e Lógica](#11-estrutura-física-e-lógica)
  * 1.2. [Processos do Oracle](#12-processos-do-oracle)
  * 1.3. [Arquitetura da SGA e PGA](#13-arquitetura-da-sga-e-pga)
  * 1.4. Modo de Execução e Processamento de Queries
* 2. SQL Performance Tuning
  * 2.1. Otimização de Queries
  * 2.2. Execution Plan (EXPLAIN PLAN)
  * 2.3. Uso do SQL Trace e TKPROF
  * 2.4. Bind Variables vs. Literals
* 3. Índices e Estratégias de Indexação
  * 3.1. Tipos de Índices
  * 3.2. Como e quando criar e remover índices
  * 3.3. Index Monitoring e uso de DBA_INDEX_USAGE
* 4. Optimizer do Oracle (CBO - Cost-Based Optimizer)
  * 4.1. Como o CBO funciona e como ele toma decisões
  * 4.2. Estatísticas e influência do DBMS_STATS
  * 4.3. Adaptive Query Optimization (Oracle 12c+)
  * 4.4. Dynamic Sampling e Cardinality Estimation
* 5. Gerenciamento da Memória
  * 5.1. SGA e PGA Tuning
  * 5.2. Shared Pool tuning
  * 5.2. Automatic Memory Management (AMM) e Automatic Shared Memory Management (ASMM)
* 6. Ajuste de Storage e I/O Performance
  * 6.1. Configuração de redo logs e redo log groups
  * 6.2. Controle de Undo Tablespace e Retenção
  * 6.3. Análise de Wait Events com V$SESSION_WAIT e V$SYSTEM_EVENT
  * 6.4. ASM (Automatic Storage Management) e impacto na performance.
* 7. Diagnóstico de Problemas de Performance
  * 7.1. Uso de AWR (Automatic Workload Repository) e ASH (Active Session History)
  * 7.2. Query para V$SESSION e V$SQLAREA para identificar queries pesadas
  * 7.3. Locks e Deadlocks: Monitoramento com V$LOCK e DBA_BLOCKERS
  * 7.4. Diagnóstico com Oracle Enterprise Manager (OEM)
* 8. Parallel Execution e Partitioning
  * 8.1. Como funciona a execução paralela no Oracle
  * 8.2. Tipos de Partitioning: Range, List, Hash, Composite
  * 8.3. Benefícios de parallel queries e partition pruning
* 9. High Availability e Disaster Recovery
  * 9.1. Uso de Data Guard para replicação e failover
  * 9.2. Oracle RAC (Real Application Clusters) para alta disponibilidade
  * 9.3. Backup & Recovery com RMAN (Recovery Manager)
* 10. Automação e Monitoramento
  * 10.1. Como automatizar análises de performance com scripts SQL e PL/SQL
  * 10.2. Uso de ferramentas como Prometheus + Grafana para métricas de banco
  * 10.3. Alertas proativos via DBA_ALERT_HISTORY
* 11. Laboratório

---

## 1. Fundamentos do Oracle Database

Antes de aprofundar em performance tuning, é essencial conhecer a arquitetura do Oracle Database:

### 1.1. Estrutura Física e Lógica

Datafiles, redo logs, control files, tablespaces, segmentos, extents e blocks.


### 1.2. Processos do Oracle
PMON, SMON, DBWn, LGWR, CKPT, etc.

### 1.3. Arquitetura da SGA e PGA

Shared Pool, Buffer Cache, Large Pool, Java Pool.

### 1.4. Modo de Execução e Processamento de Queries


---

## 2. SQL Performance Tuning

### 2.1. Otimização de Queries

Uso correto de índices, hints, subqueries vs. joins, partitioning.

### 2.2. Execution Plan (EXPLAIN PLAN)

Saber interpretar os planos de execução e como ajustá-los.

### 2.3. Uso do SQL Trace e TKPROF

Análise de gargalos em queries.

### 2.4. Bind Variables vs. Literals

Impacto no parsing e performance.


---

## 3. Índices e Estratégias de Indexação

### 3.1. Tipos de índices

B-tree, Bitmap, Function-based, Reverse Key.

### 3.2. Como e quando criar e remover índices

### 3.3. Index Monitoring e uso de DBA_INDEX_USAGE


---

## 4. Optimizer do Oracle (CBO - Cost-Based Optimizer)

### 4.1. Como o CBO funciona e como ele toma decisões
### 4.2. Estatísticas e influência do DBMS_STATS
### 4.3. Adaptive Query Optimization (Oracle 12c+)
### 4.4. Dynamic Sampling e Cardinality Estimation


---

## 5. Gerenciamento da Memória

### 5.1. SGA e PGA Tuning

Ajuste de memória dinâmica e manual.

### 5.2. Shared Pool tuning

Redução de Hard Parsing.

### 5.2. Automatic Memory Management (AMM) e Automatic Shared Memory Management (ASMM)


---

## 6. Ajuste de Storage e I/O Performance

### 6.1. Configuração de redo logs e redo log groups

### 6.2. Controle de Undo Tablespace e Retenção

### 6.3. Análise de Wait Events com V$SESSION_WAIT e V$SYSTEM_EVENT

### 6.4. ASM (Automatic Storage Management) e impacto na performance.


---

## 7. Diagnóstico de Problemas de Performance

### 7.1. Uso de AWR (Automatic Workload Repository) e ASH (Active Session History)

### 7.2. Query para V$SESSION e V$SQLAREA para identificar queries pesadas

### 7.3. Locks e Deadlocks: Monitoramento com V$LOCK e DBA_BLOCKERS

### 7.4. Diagnóstico com Oracle Enterprise Manager (OEM)


---

## 8. Parallel Execution e Partitioning

### 8.1. Como funciona a execução paralela no Oracle
### 8.2. Tipos de Partitioning: Range, List, Hash, Composite
### 8.3. Benefícios de parallel queries e partition pruning


---

## 9. High Availability e Disaster Recovery

### 9.1. Uso de Data Guard para replicação e failover
### 9.2. Oracle RAC (Real Application Clusters) para alta disponibilidade
### 9.3. Backup & Recovery com RMAN (Recovery Manager)


---

## 10. Automação e Monitoramento

### 10.1. Como automatizar análises de performance com scripts SQL e PL/SQL
### 10.2. Uso de ferramentas como Prometheus + Grafana para métricas de banco
### 10.3. Alertas proativos via DBA_ALERT_HISTORY


---

## 11. Laboratório
