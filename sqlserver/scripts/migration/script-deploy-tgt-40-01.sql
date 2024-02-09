--
-- Task script-deploy-tgt-40-02-01: USE
--
USE [master]


--
-- Task script-deploy-tgt-40-02-02: COPY physical data files from stage to source
--
/* ps1

docker cp 'C:\Users\josemarsilva\githome\shared-volumes\AdventureWorks2019.mdf'     mssql-labdb-2019:/var/opt/mssql/data/AdventureWorks2019.mdf 
docker cp 'C:\Users\josemarsilva\githome\shared-volumes\AdventureWorks2019_log.ldf' mssql-labdb-2019:/var/opt/mssql/data/AdventureWorks2019_log.ldf 

 */


--
-- Task script-deploy-tgt-40-02-03: CREATE DATABASE ... FOR ATTACH
--
CREATE DATABASE AdventureWorks2019
    ON (FILENAME = '/var/opt/mssql/data/AdventureWorks2019.mdf'),
       (FILENAME = '/var/opt/mssql/data/AdventureWorks2019_log.ldf')
    FOR ATTACH;

/* Message

Msg 5172, Level 16, State 15, Line 1
The header for file '/var/opt/mssql/data/AdventureWorks2019_log.ldf' is not a valid database file header. The FILE SIZE property is incorrect.
Msg 1802, Level 16, State 7, Line 1
CREATE DATABASE failed. Some file names listed could not be created. Check related errors.

Completion time: 2024-02-09T20:32:52.2529753-03:00

*/

GO

