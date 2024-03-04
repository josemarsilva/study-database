USE [master]
GO
EXEC master.dbo.sp_addlinkedserver @server = N'7964c8945fef', @srvproduct=N'SQLNCLI'
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'7964c8945fef',@useself=N'true',@locallogin=NULL,@rmtuser=N'NULL',@rmtpassword='########' GO
EXEC master.dbo.sp_serveroption @server=N'7964c8945fef', @optname=N'collation compatible', @optvalue=N'false' GO
EXEC master.dbo.sp_serveroption @server=N'7964c8945fef', @optname=N'data access', @optvalue=N'false' GO
EXEC master.dbo.sp_serveroption @server=N'7964c8945fef', @optname=N'dist', @optvalue=N'false' GO
EXEC master.dbo.sp_serveroption @server=N'7964c8945fef', @optname=N'pub', @optvalue=N'false' GO
EXEC master.dbo.sp_serveroption @server=N'7964c8945fef', @optname=N'rpc', @optvalue=N'true' GO
EXEC master.dbo.sp_serveroption @server=N'7964c8945fef', @optname=N'rpc out', @optvalue=N'true' GO
EXEC master.dbo.sp_serveroption @server=N'7964c8945fef', @optname=N'sub', @optvalue=N'false' GO
EXEC master.dbo.sp_serveroption @server=N'7964c8945fef', @optname=N'connect timeout', @optvalue=N'false' GO
EXEC master.dbo.sp_serveroption @server=N'7964c8945fef', @optname=N'lazy schema validation', @optvalue=N'false' GO
EXEC master.dbo.sp_serveroption @server=N'7964c8945fef', @optname=N'query timeout', @optvalue=N'false' GO
EXEC master.dbo.sp_serveroption @server=N'7964c8945fef', @optname=N'use remote collation', @optvalue=N'true' GO
EXEC master.dbo.sp_serveroption @server=N'7964c8945fef', @optname=N'remote proc transaction promotion', @optvalue=N'false' GO
GO

GO

