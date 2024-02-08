--
-- script-deploy-tgt-09-03.sql: Dynamically generated by script-deploy-tgt-08-02.ps1
--

--
-- Step#01: USE labdb3 - Replaced by current deploy database
--
USE labdb3


-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', '', 'SRVPROPS - SERVERPROPERTY()', '', '', '', 'Collation=SQL_Latin1_General_CP1_CI_AS, CollationId=872468488, InstanceName=, MachineName=b43137618dcd, Processors=, SqlCharSet=1, SqlCharSetName=iso_1, SqlVersion=')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', '##MS_AgentSigningCertificate##', 'C - CERTIFICATE_MAPPED_LOGIN', '', '', '', 'principal_id=258, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', '##MS_PolicyEventProcessingLogin##', 'S - SQL_LOGIN', '', '', '', 'principal_id=256, is_disabled=1')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', '##MS_PolicySigningCertificate##', 'C - CERTIFICATE_MAPPED_LOGIN', '', '', '', 'principal_id=105, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', '##MS_PolicyTsqlExecutionLogin##', 'S - SQL_LOGIN', '', '', '', 'principal_id=257, is_disabled=1')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', '##MS_SmoExtendedSigningCertificate##', 'C - CERTIFICATE_MAPPED_LOGIN', '', '', '', 'principal_id=106, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', '##MS_SQLAuthenticatorCertificate##', 'C - CERTIFICATE_MAPPED_LOGIN', '', '', '', 'principal_id=103, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', '##MS_SQLReplicationSigningCertificate##', 'C - CERTIFICATE_MAPPED_LOGIN', '', '', '', 'principal_id=102, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', '##MS_SQLResourceSigningCertificate##', 'C - CERTIFICATE_MAPPED_LOGIN', '', '', '', 'principal_id=101, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', 'BUILTIN\Administrators', 'G - WINDOWS_GROUP', '', '', '', 'principal_id=259, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', 'bulkadmin', 'R - SERVER_ROLE', '', '', '', 'principal_id=10, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', 'dbcreator', 'R - SERVER_ROLE', '', '', '', 'principal_id=9, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', 'diskadmin', 'R - SERVER_ROLE', '', '', '', 'principal_id=8, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', 'NT AUTHORITY\NETWORK SERVICE', 'U - WINDOWS_LOGIN', '', '', '', 'principal_id=261, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', 'NT AUTHORITY\SYSTEM', 'U - WINDOWS_LOGIN', '', '', '', 'principal_id=260, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', 'processadmin', 'R - SERVER_ROLE', '', '', '', 'principal_id=7, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', 'public', 'R - SERVER_ROLE', '', '', '', 'principal_id=2, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', 'sa', 'S - SQL_LOGIN', '', '', '', 'principal_id=1, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', 'securityadmin', 'R - SERVER_ROLE', '', '', '', 'principal_id=4, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', 'serveradmin', 'R - SERVER_ROLE', '', '', '', 'principal_id=5, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', 'setupadmin', 'R - SERVER_ROLE', '', '', '', 'principal_id=6, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', 'sysadmin', 'R - SERVER_ROLE', '', '', '', 'principal_id=3, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', 'user_1', 'S - SQL_LOGIN', '', '', '', 'principal_id=262, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', 'user_2', 'S - SQL_LOGIN', '', '', '', 'principal_id=263, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', 'user_3', 'S - SQL_LOGIN', '', '', '', 'principal_id=264, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', 'user_4', 'S - SQL_LOGIN', '', '', '', 'principal_id=265, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', 'user_5', 'S - SQL_LOGIN', '', '', '', 'principal_id=266, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', '', '', 'user_6', 'S - SQL_LOGIN', '', '', '', 'principal_id=267, is_disabled=0')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', 'labdb3', '', 'db_accessadmin', 'R - DATABASE_ROLE', '', '', '', 'principal_id=16385, authentication_type_desc=NONE')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', 'labdb3', '', 'db_backupoperator', 'R - DATABASE_ROLE', '', '', '', 'principal_id=16389, authentication_type_desc=NONE')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', 'labdb3', '', 'db_datareader', 'R - DATABASE_ROLE', '', '', '', 'principal_id=16390, authentication_type_desc=NONE')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', 'labdb3', '', 'db_datawriter', 'R - DATABASE_ROLE', '', '', '', 'principal_id=16391, authentication_type_desc=NONE')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', 'labdb3', '', 'db_ddladmin', 'R - DATABASE_ROLE', '', '', '', 'principal_id=16387, authentication_type_desc=NONE')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', 'labdb3', '', 'db_denydatareader', 'R - DATABASE_ROLE', '', '', '', 'principal_id=16392, authentication_type_desc=NONE')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', 'labdb3', '', 'db_denydatawriter', 'R - DATABASE_ROLE', '', '', '', 'principal_id=16393, authentication_type_desc=NONE')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', 'labdb3', '', 'db_owner', 'R - DATABASE_ROLE', '', '', '', 'principal_id=16384, authentication_type_desc=NONE')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', 'labdb3', '', 'db_securityadmin', 'R - DATABASE_ROLE', '', '', '', 'principal_id=16386, authentication_type_desc=NONE')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', 'labdb3', '', 'dbo', 'S - SQL_USER', '', '', '', 'principal_id=1, authentication_type_desc=INSTANCE')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', 'labdb3', '', 'guest', 'S - SQL_USER', '', '', '', 'principal_id=2, authentication_type_desc=NONE')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', 'labdb3', '', 'INFORMATION_SCHEMA', 'S - SQL_USER', '', '', '', 'principal_id=3, authentication_type_desc=NONE')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', 'labdb3', '', 'public', 'R - DATABASE_ROLE', '', '', '', 'principal_id=0, authentication_type_desc=NONE')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', 'labdb3', '', 'sys', 'S - SQL_USER', '', '', '', 'principal_id=4, authentication_type_desc=NONE')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', 'labdb3', 'dbo', 'EventNotificationErrorsQueue', 'SQ - SERVICE_QUEUE', '', '', '', '')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', 'labdb3', 'dbo', 'pk_test', '1 - INDEX CLUSTERED', '', '', '', 'tbl_test ( id )')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', 'labdb3', 'dbo', 'pk_test', 'PK - PRIMARY_KEY_CONSTRAINT', '', '', '', '')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', 'labdb3', 'dbo', 'QueryNotificationErrorsQueue', 'SQ - SERVICE_QUEUE', '', '', '', '')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', 'labdb3', 'dbo', 'ServiceBrokerQueue', 'SQ - SERVICE_QUEUE', '', '', '', '')

-- source

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('source', 'b43137618dcd', 'labdb3', 'dbo', 'tbl_test', 'U  - USER_TABLE', '', '', '0', '')

GO


-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', '', '', '', 'SRVPROPS - SERVERPROPERTY()', '', '', '', 'Collation=SQL_Latin1_General_CP1_CI_AS, CollationId=872468488, InstanceName=, MachineName=19f59be879bd, Processors=, SqlCharSet=1, SqlCharSetName=iso_1, SqlVersion=')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', '', '', '##MS_AgentSigningCertificate##', 'C - CERTIFICATE_MAPPED_LOGIN', '', '', '', 'principal_id=258, is_disabled=0')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', '', '', '##MS_PolicyEventProcessingLogin##', 'S - SQL_LOGIN', '', '', '', 'principal_id=256, is_disabled=1')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', '', '', '##MS_PolicySigningCertificate##', 'C - CERTIFICATE_MAPPED_LOGIN', '', '', '', 'principal_id=105, is_disabled=0')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', '', '', '##MS_PolicyTsqlExecutionLogin##', 'S - SQL_LOGIN', '', '', '', 'principal_id=257, is_disabled=1')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', '', '', '##MS_SmoExtendedSigningCertificate##', 'C - CERTIFICATE_MAPPED_LOGIN', '', '', '', 'principal_id=106, is_disabled=0')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', '', '', '##MS_SQLAuthenticatorCertificate##', 'C - CERTIFICATE_MAPPED_LOGIN', '', '', '', 'principal_id=103, is_disabled=0')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', '', '', '##MS_SQLReplicationSigningCertificate##', 'C - CERTIFICATE_MAPPED_LOGIN', '', '', '', 'principal_id=102, is_disabled=0')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', '', '', '##MS_SQLResourceSigningCertificate##', 'C - CERTIFICATE_MAPPED_LOGIN', '', '', '', 'principal_id=101, is_disabled=0')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', '', '', 'BUILTIN\Administrators', 'G - WINDOWS_GROUP', '', '', '', 'principal_id=259, is_disabled=0')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', '', '', 'bulkadmin', 'R - SERVER_ROLE', '', '', '', 'principal_id=10, is_disabled=0')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', '', '', 'dbcreator', 'R - SERVER_ROLE', '', '', '', 'principal_id=9, is_disabled=0')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', '', '', 'diskadmin', 'R - SERVER_ROLE', '', '', '', 'principal_id=8, is_disabled=0')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', '', '', 'NT AUTHORITY\NETWORK SERVICE', 'U - WINDOWS_LOGIN', '', '', '', 'principal_id=260, is_disabled=0')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', '', '', 'NT AUTHORITY\SYSTEM', 'U - WINDOWS_LOGIN', '', '', '', 'principal_id=261, is_disabled=0')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', '', '', 'processadmin', 'R - SERVER_ROLE', '', '', '', 'principal_id=7, is_disabled=0')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', '', '', 'public', 'R - SERVER_ROLE', '', '', '', 'principal_id=2, is_disabled=0')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', '', '', 'sa', 'S - SQL_LOGIN', '', '', '', 'principal_id=1, is_disabled=0')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', '', '', 'securityadmin', 'R - SERVER_ROLE', '', '', '', 'principal_id=4, is_disabled=0')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', '', '', 'serveradmin', 'R - SERVER_ROLE', '', '', '', 'principal_id=5, is_disabled=0')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', '', '', 'setupadmin', 'R - SERVER_ROLE', '', '', '', 'principal_id=6, is_disabled=0')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', '', '', 'sysadmin', 'R - SERVER_ROLE', '', '', '', 'principal_id=3, is_disabled=0')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', 'labdb3', '', 'db_accessadmin', 'R - DATABASE_ROLE', '', '', '', 'principal_id=16385, authentication_type_desc=NONE')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', 'labdb3', '', 'db_backupoperator', 'R - DATABASE_ROLE', '', '', '', 'principal_id=16389, authentication_type_desc=NONE')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', 'labdb3', '', 'db_datareader', 'R - DATABASE_ROLE', '', '', '', 'principal_id=16390, authentication_type_desc=NONE')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', 'labdb3', '', 'db_datawriter', 'R - DATABASE_ROLE', '', '', '', 'principal_id=16391, authentication_type_desc=NONE')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', 'labdb3', '', 'db_ddladmin', 'R - DATABASE_ROLE', '', '', '', 'principal_id=16387, authentication_type_desc=NONE')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', 'labdb3', '', 'db_denydatareader', 'R - DATABASE_ROLE', '', '', '', 'principal_id=16392, authentication_type_desc=NONE')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', 'labdb3', '', 'db_denydatawriter', 'R - DATABASE_ROLE', '', '', '', 'principal_id=16393, authentication_type_desc=NONE')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', 'labdb3', '', 'db_owner', 'R - DATABASE_ROLE', '', '', '', 'principal_id=16384, authentication_type_desc=NONE')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', 'labdb3', '', 'db_securityadmin', 'R - DATABASE_ROLE', '', '', '', 'principal_id=16386, authentication_type_desc=NONE')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', 'labdb3', '', 'dbo', 'S - SQL_USER', '', '', '', 'principal_id=1, authentication_type_desc=INSTANCE')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', 'labdb3', '', 'guest', 'S - SQL_USER', '', '', '', 'principal_id=2, authentication_type_desc=NONE')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', 'labdb3', '', 'INFORMATION_SCHEMA', 'S - SQL_USER', '', '', '', 'principal_id=3, authentication_type_desc=NONE')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', 'labdb3', '', 'public', 'R - DATABASE_ROLE', '', '', '', 'principal_id=0, authentication_type_desc=NONE')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', 'labdb3', '', 'sys', 'S - SQL_USER', '', '', '', 'principal_id=4, authentication_type_desc=NONE')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', 'labdb3', 'dbo', 'EventNotificationErrorsQueue', 'SQ - SERVICE_QUEUE', '', '', '', '')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', 'labdb3', 'dbo', 'pk_test', '1 - INDEX CLUSTERED', '', '', '', 'tbl_test ( id )')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', 'labdb3', 'dbo', 'pk_test', 'PK - PRIMARY_KEY_CONSTRAINT', '', '', '', '')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', 'labdb3', 'dbo', 'QueryNotificationErrorsQueue', 'SQ - SERVICE_QUEUE', '', '', '', '')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', 'labdb3', 'dbo', 'ServiceBrokerQueue', 'SQ - SERVICE_QUEUE', '', '', '', '')

-- target

INSERT INTO migration_results (source_target, server_name, database_name, schema_name, object_name, object_type_desc, create_date, modify_date, property_int, property_varchar) VALUES ('target', '19f59be879bd', 'labdb3', 'dbo', 'tbl_test', 'U  - USER_TABLE', '', '', '0', '')

GO

