IF NOT EXISTS(SELECT 1 FROM sys.databases WHERE name='SDS')
BEGIN
    PRINT 'mssql_bootstrap.sql  Creating SDS'
    CREATE DATABASE [SDS]
END
GO
IF NOT EXISTS(SELECT 1 FROM sys.databases WHERE name='ODS')
BEGIN
    PRINT 'mssql_bootstrap.sql  Creating ODS'
    CREATE DATABASE [ODS]
END
GO