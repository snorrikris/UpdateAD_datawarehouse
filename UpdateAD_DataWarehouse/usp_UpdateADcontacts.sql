﻿-- =============================================
-- Author:		Snorri Kristjansson
-- Create date: 07.09.2015
-- Description:	Update ADcontacts table with data from Active Directory.
-- @ADpath = Domain e.g. 'LDAP://DC=contoso,DC=com'
-- =============================================
CREATE PROCEDURE usp_UpdateADcontacts 
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
	-- Contacts
	-------------------
	SET @CurrentOp = 'Get Contacts';
	SET @TableName = 'ADcontacts';
	PRINT '------------------------------------------------------------------------';
	PRINT 'Update ADcontacts table with data from Active Directory.';
	PRINT @CurrentOp + ' from AD INTO ' + @TableName + ' table.';

	BEGIN TRY
		-- Create (global) temp table dynamically. Note is global cuz of scope issue.
		SET @table_name = 'dbo.' + @TableName;
		SET @tempTableName = '##' + @TableName;
		EXECUTE [dbo].[usp_GenerateTempTableScript] @table_name, @tempTableName, @SQL OUTPUT;
		EXEC (@SQL);

		-- Get all Contacts from AD into temp table
		SET @ADfilter = '(&(objectCategory=person)(objectClass=contact))';
		INSERT INTO ##ADcontacts EXEC dbo.clr_GetADobjects @ADpath, @ADfilter, @Members OUTPUT;
		PRINT @CurrentOp + ' from AD into temp table: ' + CAST(@@ROWCOUNT AS nvarchar(64)) + ' rows.';

		-- Insert into DeletedADcontacts table all rows from ADcontacts table that don't exist in the temp table.
		-- (i.e. the rows that will be deleted by the MERGE statement.)
		INSERT INTO [dbo].[DeletedADcontacts]
			SELECT a.*, GETDATE() AS [DeletedDate]
			FROM [dbo].[ADcontacts] a
			WHERE ObjectGUID NOT IN (SELECT ObjectGUID FROM ##ADcontacts);
		PRINT @CurrentOp + ' - deleted: ' + CAST(@@ROWCOUNT AS nvarchar(64)) + ' rows.';

		-- Generate MERGE statement dynamically from table definition.
		EXECUTE [dbo].[usp_GenerateMergeStatement] @TableName, @tempTableName, @SQL OUTPUT

		-- Execute MERGE statement.
		PRINT 'MERGE ' + @TableName;
		EXECUTE (@SQL)

		-- DROP temp table.
		SET @SQL = 'DROP TABLE ' + @tempTableName + ';';
		EXECUTE (@SQL)
		PRINT '------------------------------------------------------------------------';
	END TRY
	BEGIN CATCH
		PRINT 'Error - ' + @CurrentOp + ' - Operation aborted.';
		PRINT '------------------------------------------------------------------------';
		THROW;
	END CATCH
	RETURN;
	CREATE TABLE ##ADcontacts (foo int);
END
