# study-database - SQLServer - Labs - Ostress

## 1. Introdução ##

Este laboratório `ostress` foi construído com base no artigo [Stress Testing with oStress – SQL in Sixty Seconds #087](https://blog.sqlauthority.com/2020/05/07/stress-testing-with-ostress-sql-in-sixty-seconds-087/) e aborda os seguintes assuntos:

* [Instalação](#31-instalação)
* [Documentação Oficial](#32-documentação-oficial)
* [Demonstração](#33-demonstração)
  * [Step: Localizar os binários instalados](#3301-step-localizar-os-binários-instalados)
  * [Step: Ostress.exe - command line paramenters](#3302-step-ostressexe---command-line-parameters)

* [References](#references)


---

### 2. Mapa Mental

* _n/a_

---

### 3. Tópicos

### 3.1. Instalação

Faça o download do binário a partir da página [Replay Markup Language (RML) Utilities for SQL Server](https://learn.microsoft.com/en-us/troubleshoot/sql/tools/replay-markup-language-utility)
1. Na seção [Obtain the RML Utilities for SQL Server](https://learn.microsoft.com/en-us/troubleshoot/sql/tools/replay-markup-language-utility#obtain-the-rml-utilities-for-sql-server) clique link "Microsoft Download Center" para baixar o binário `RMLSetup.msi`
2. Execute o instalador baixado `RMLSetup.msi`
3. Clique "Next", "Next", ..., "Close"

---


### 3.2. Documentação Oficial

* [Replay Markup Language (RML) Utilities for SQL Server](https://learn.microsoft.com/en-us/troubleshoot/sql/tools/replay-markup-language-utility)
* [SQL Server stress testing using OStress](https://www.sqlshack.com/sql-server-stress-testing-using-ostress/)
* [Stress Testing with oStress – SQL in Sixty Seconds #087](https://blog.sqlauthority.com/2020/05/07/stress-testing-with-ostress-sql-in-sixty-seconds-087/)
* [Youtube - Stress Testing with oStress - SQL in Sixty Seconds #087](https://www.youtube.com/watch?v=FVU4X2Wm4ko)

---

### 3.3. Demonstração

#### 3.3.01. Step: Localizar os binário(s) instalados

```wt
Get-ChildItem "C:\Program Files\Microsoft Corporation\RMLUtils\*.exe -Name"
Expander.exe
ORCA.exe
ostress.exe
ReadTrace.exe
Reporter.exe
```

#### 3.3.02. Step: Ostress.exe - command line parameters

```wt
"C:\Program Files\Microsoft Corporation\RMLUtils\ostress.exe
OSTRESS, A Generic ODBC-Based Stress/Replay Utility.
Version 9.04.0102 built for x64.
Copyright ® 1997-2016 Microsoft. All Rights Reserved
            Computer: LP1764
         Base Module: C:\Program Files\Microsoft Corporation\RMLUtils\ostress.exe
          Process Id: 20008
 Active proc mask(0): 0x000000FF
        Architecture: 9
           Page size: 4096
                CPUs: 8
    Processor groups: 1
        Highest node: 0
  Proximity: 00  Node: 00
---------------------------------------
               Group: 0
---------------------------------------
        Processor(s): 0x00000003 Function units: Shared
        Processor(s): 0x0000000C Function units: Shared
        Processor(s): 0x00000030 Function units: Shared
        Package mask: 0x000000FF
        Processor(s): 0x000000C0 Function units: Shared
        Processor(s): 0x000000FF assigned to Numa node: 0
Current time bias: 180 minutes 3.00 hours DST not used
NOTE: All command line arguments are case sensitive.  No space is allowed between the parameter switch and its specified value.

USAGE:

  -S name of Microsoft SQL Server server to connect to
  -D ODBC data source name to use for connection
  -E use Windows auhentication to connect (default)
  -U login ID
  -P password
  -d database name
  -Q"single batch query to process"
  -i SQL/RML file name or file wildcard to process
  -n number of connections processing each input file/query - stress mode
  -r number of iterations for each connection to execute its input file/query
  -o output directory to write query results and log file
  -l login timeout (sec)
  -L integer value representing the language id
  -t query timeout (sec)
  -p network packet size for connections - SQL Server only
  -q quiet mode; suppress all query output
  -v verbose mode; show additional diagnostic output
  -m [stress | replay] run in stress or replay mode
  -a default password to use for SQL authentication during replay
  -c control file name - required for replay mode
  -T enable trace flag
  -fx write query results as XML
  -N disable "OSTRESS exiting" message
  -M Advanced setting: max threads allowed, 0 is default setting.
  -b Stop processing if an error is encountered during query execution.

EXAMPLE: ostress -E -dpubs -Q"select * from authors"
OSTRESS exiting due to error (-6)
```

---

#### 3.3.03. Step: Ostress.exe - command line parameters

* Premissa: Database de demonstração `Northwind` instalado 

```wt
& 'C:\Program Files\Microsoft Corporation\RMLUtils\ostress.exe' -S"127.0.0.1" -Usa –PPassword@123 -dNorthwind -Q"select OrderID, ProductID, UnitPrice, Quantity, Discount from [Order Details]" –n25 –r50 
---

# References

* [Stress Testing with oStress – SQL in Sixty Seconds #087](https://blog.sqlauthority.com/2020/05/07/stress-testing-with-ostress-sql-in-sixty-seconds-087/)