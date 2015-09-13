-- =============================================
-- Author:		Snorri Kristjansson
-- Create date: 07.09.2015
-- Description:	Update ADusersPhotos table with data from Active Directory.
-- @ADpath = Domain e.g. 'LDAP://DC=contoso,DC=com'
-- =============================================
CREATE PROCEDURE usp_UpdateADusersPhotos 
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
	-- Users photos
	-------------------
	SET @CurrentOp = 'Get Users photos';
	SET @TableName = 'ADusersPhotos';
	PRINT '------------------------------------------------------------------------';
	PRINT @CurrentOp + ' from AD INTO ' + @TableName + ' table.';

	BEGIN TRY
		-- Create (global) temp table dynamically. Note is global cuz of scope issue.
		SET @table_name = 'dbo.' + @TableName;
		SET @tempTableName = '##' + @TableName;
		EXECUTE [dbo].[usp_GenerateTempTableScript] @table_name, @tempTableName, @SQL OUTPUT;
		EXEC (@SQL);

		-- Get all photos from AD into temp table
		SET @ADfilter = '(&(objectCategory=person)(objectClass=user))';
		INSERT INTO ##ADusersPhotos EXEC clr_GetADusersPhotos @ADpath, @ADfilter;
		PRINT @CurrentOp + ' from AD into temp table: ' + CAST(@@ROWCOUNT AS nvarchar(64)) + ' rows.';

		-- Generate MERGE statement dynamically from table definition.
		EXECUTE [dbo].[usp_GenerateMergeStatement] @TableName, @tempTableName, @SQL OUTPUT

		-- Execute MERGE statement.
		PRINT 'MERGE ' + @TableName;
		EXECUTE (@SQL)

		-- DROP temp table.
		SET @SQL = 'DROP TABLE ' + @tempTableName + ';';
		EXECUTE (@SQL)
	END TRY
	BEGIN CATCH
		PRINT 'Error - ' + @CurrentOp + ' - Operation aborted.';
		THROW;
	END CATCH
	RETURN;
	CREATE TABLE ##ADusersPhotos (foo int);
END
