-- Give SharePoint sp_install account correct server role
USE [master]
GO
CREATE LOGIN [CONTOSO\sp_install] FROM WINDOWS WITH DEFAULT_DATABASE=[master]
GO
EXEC master..sp_addsrvrolemember @loginame = N'contoso\sp_install', @rolename = N'dbcreator'
GO
EXEC master..sp_addsrvrolemember @loginame = N'contoso\sp_install', @rolename = N'securityadmin'
GO

-- Set Max Degree of Parrallelism so SharePoint doesn't cry about it
EXEC sys.sp_configure N'show advanced options', N'1'  RECONFIGURE WITH OVERRIDE
GO
EXEC sys.sp_configure N'max degree of parallelism', N'1'
GO
RECONFIGURE WITH OVERRIDE
GO
EXEC sys.sp_configure N'show advanced options', N'0'  RECONFIGURE WITH OVERRIDE
GO

-- Restrict RAM to 10 GBish
EXEC sys.sp_configure N'show advanced options', N'1'  RECONFIGURE WITH OVERRIDE
GO
EXEC sys.sp_configure N'max server memory (MB)', N'10240'
GO
RECONFIGURE WITH OVERRIDE
GO
EXEC sys.sp_configure N'show advanced options', N'0'  RECONFIGURE WITH OVERRIDE
GO

-- Set Model database to Simple
USE [master]
GO
ALTER DATABASE [model] SET RECOVERY SIMPLE WITH NO_WAIT
GO
