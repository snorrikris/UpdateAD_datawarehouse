-- =============================================
-- Author:		Snorri Kristjansson
-- Create date: 07.09.2015
-- Description:	Update ADusers table with data from Active Directory.
-- @ADpath = Domain e.g. 'LDAP://DC=contoso,DC=com'
-- =============================================
CREATE PROCEDURE usp_UpdateADusers 
	@ADpath nvarchar(64)
AS
BEGIN
	SET NOCOUNT ON;

	-- Declare vars used.
	DECLARE @table_name sysname;
	DECLARE @tempTableName nvarchar(50), @TableName nvarchar(64),  @ADfilter nvarchar(4000), @CurrentOp nvarchar(50);
	DECLARE @SQL nvarchar(max);
	DECLARE @Members XML;

	-------------------
	-- Users
	-------------------
	SET @CurrentOp = 'Get Users';
	SET @TableName = 'ADusers';
	PRINT '------------------------------------------------------------------------';
	PRINT @CurrentOp + ' from AD INTO ' + @TableName + ' table.';

	BEGIN TRY
		-- Create (global) temp table dynamically. Note is global cuz of scope issue.
		SET @table_name = 'dbo.' + @TableName;
		SET @tempTableName = '##' + @TableName;
		EXECUTE [dbo].[usp_GenerateTempTableScript] @table_name, @tempTableName, @SQL OUTPUT;
		EXEC (@SQL);

		-- Get all users from AD into temp table
		SET @ADfilter = '(&(objectCategory=person)(objectClass=user))';
		INSERT INTO ##ADusers EXEC dbo.clr_GetADobjects @ADpath, @ADfilter, @Members OUTPUT;
		PRINT @CurrentOp + ' from AD into temp table: ' + CAST(@@ROWCOUNT AS nvarchar(64)) + ' rows.';

		-- Insert into DeletedADusers table all rows from ADusers table that don't exist in the temp table.
		-- (i.e. the rows that will be deleted by the MERGE statement.)
		INSERT INTO [dbo].[DeletedADusers]
			SELECT a.*, GETDATE() AS [DeletedDate]
			FROM [dbo].[ADusers] a
			WHERE ObjectGUID NOT IN (SELECT ObjectGUID FROM ##ADusers);
		PRINT @CurrentOp + ' - deleted: ' + CAST(@@ROWCOUNT AS nvarchar(64)) + ' rows.';

		-- Generate MERGE statement dynamically from table definition.
		EXECUTE [dbo].[usp_GenerateMergeStatement] @TableName, @tempTableName, @SQL OUTPUT;

		-- Execute MERGE statement.
		PRINT 'MERGE ' + @TableName;
		EXECUTE (@SQL)

		-- DROP temp table.
		SET @SQL = 'DROP TABLE ' + @tempTableName + ';';
		EXECUTE (@SQL)

		-- UPDATE [ManagerGUID]
		--UPDATE [dbo].[ADusers] 
		--SET [ManagerGUID] = (SELECT [ObjectGUID] FROM [dbo].[ADusers] WHERE a.[Manager] = DistinguishedName)
		--FROM [dbo].[ADusers] a WHERE Manager IS NOT NULL

		--Example query
		--SELECT [DisplayName],[Title],[Department],[Company]
		--	  ,CASE WHEN [ManagerGUID] IS NULL THEN '' 
		--			WHEN [ManagerGUID] IS NOT NULL THEN (SELECT DisplayName FROM [dbo].[ADusers] WHERE a.[ManagerGUID] = [ObjectGUID])
		--	  END AS ManagerName
		--FROM [dbo].[ADusers] a WHERE ManagerGUID IS NOT NULL

		-- UPDATE UserMustChangePasswordAtNextLogon
		--UPDATE [dbo].[ADusers] 
		--SET UserMustChangePasswordAtNextLogon = (CASE WHEN [PasswordLastSet] IS NULL AND [PasswordNeverExpires] = 0 AND [PasswordNotRequired] = 0 THEN 1 ELSE 0 END);
	END TRY
	BEGIN CATCH
		PRINT 'Error - ' + @CurrentOp + ' - Operation aborted.';
		THROW;
	END CATCH
	RETURN;
	CREATE TABLE ##ADusers (foo int);	-- <-- To get rid of VS compiler Warning SQL71502
END
