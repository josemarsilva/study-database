--
-- script-deploy-src-02-02.sql
--

SELECT 
	CONCAT(
        'EXEC sp_addrolemember ', r.name, ', ', u.name
    ) AS stmt_sp_addrolemember,
    '' AS dummy
FROM sys.server_principals u 
JOIN sys.server_role_members rm 
ON u.principal_id = rm.member_principal_id 
AND u.type IN ('S') 
JOIN sys.server_principals r 
ON r.principal_id = rm.role_principal_id 
AND r.type IN ('R');

GO
