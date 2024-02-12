--
-- script-deploy-tgt-09-01.sql
--

--
-- Step#01: USE {deploy_database} - Replaced by current deploy database
--
USE {deploy_database}


--
-- Step#02: DROP migration_results table if exists
--
DROP TABLE IF EXISTS migration_results;

--
-- Step#03: CREATE migration_results table
--
CREATE TABLE migration_results
(
    id               INT           IDENTITY(1,1) PRIMARY KEY,
    source_target    VARCHAR(30),
    server_name      VARCHAR(128),
    database_name    VARCHAR(128),
    schema_name      VARCHAR(128),
    object_name      VARCHAR(128),
    object_type_desc VARCHAR(30),
    create_date      DATETIME,
    modify_date      DATETIME,
    property_int     INT,
    property_varchar VARCHAR(MAX)
);

GO
