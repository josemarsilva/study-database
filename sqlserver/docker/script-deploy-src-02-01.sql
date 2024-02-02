--
-- script-deploy-src-02-01.sql
--

SELECT 
	CASE
		WHEN sp.type = 'S' /* SQL_LOGIN */ OR sp.type = 'C' /* CERTIFICATE_MAPPED_LOGIN */
			THEN
				CONCAT('CREATE LOGIN [', name, '] WITH PASSWORD = ''Password@123'';'
		) 
		WHEN sp.type = 'U' /* WINDOWS_LOGIN */ OR sp.type = 'G' /* WINDOWS_GROUP */
			THEN
				CONCAT('CREATE LOGIN [', name, '] FROM WINDOWS ;'
		) 
		WHEN sp.type = 'R' /* SERVER_ROLE */
			THEN
				CONCAT('CREATE SERVER ROLE [', name, '];'
		) 
		ELSE
			''
	END AS stmt_create_login,
	CONCAT(
		'/* ', sp.type, ': ', sp.type_desc, ' */'
	) AS dummy
FROM   sys.server_principals sp
WHERE	1=1
AND		type IN ( 
			'C' /* CERTIFICATE_MAPPED_LOGIN */,
			'G' /* WINDOWS_GROUP */,
			'R' /* SERVER_ROLE */,
			'S' /* SQL_LOGIN */,
			'U' /* WINDOWS_LOGIN */
		)
AND		sp.name NOT IN 
		( 
			'sa', '##MS_PolicyEventProcessingLogin##', '##MS_PolicyTsqlExecutionLogin##', 
			'##MS_AgentSigningCertificate##','##MS_SQLResourceSigningCertificate##', '##MS_SQLReplicationSigningCertificate##', '##MS_SQLAuthenticatorCertificate##', '##MS_PolicySigningCertificate##', '##MS_SmoExtendedSigningCertificate##',
			'NT AUTHORITY\NETWORK SERVICE', 'NT AUTHORITY\SYSTEM', 
			'BUILTIN\Administrators',
			'bulkadmin', 'dbcreator', 'diskadmin', 'processadmin', 'public', 'securityadmin', 'serveradmin', 'setupadmin', 'sysadmin'
		)
ORDER  BY type, 1;

GO
