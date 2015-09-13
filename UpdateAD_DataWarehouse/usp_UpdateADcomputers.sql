-- =============================================
-- Author:		Snorri Kristjansson
-- Create date: 07.09.2015
-- Description:	Update ADcomputers table with data from Active Directory.
-- @ADpath = Domain e.g. 'LDAP://DC=contoso,DC=com'
-- =============================================
CREATE PROCEDURE usp_UpdateADcomputers 
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
	-- Computers
	-------------------
	SET @CurrentOp = 'Get Computers';
	SET @TableName = 'ADcomputers';
	PRINT '------------------------------------------------------------------------';
	PRINT @CurrentOp + ' from AD INTO ' + @TableName + ' table.';

	BEGIN TRY
		-- Create (global) temp table dynamically. Note is global cuz of scope issue.
		SET @table_name = 'dbo.' + @TableName;
		SET @tempTableName = '##' + @TableName;
		EXECUTE [dbo].[usp_GenerateTempTableScript] @table_name, @tempTableName, @SQL OUTPUT;
		EXEC (@SQL);

		-- Get all computers from AD into temp table
		SET @ADfilter = '(objectCategory=computer)';
		INSERT INTO ##ADcomputers EXEC dbo.clr_GetADobjects @ADpath, @ADfilter, @Members OUTPUT;
		PRINT @CurrentOp + ' from AD into temp table: ' + CAST(@@ROWCOUNT AS nvarchar(64)) + ' rows.';

		-- Insert into DeletedADcomputers table all rows from ADcomputers table that don't exist in the temp table.
		-- (i.e. the rows that will be deleted by the MERGE statement.)
		INSERT INTO [dbo].[DeletedADcomputers]
			SELECT a.*, GETDATE() AS [DeletedDate]
			FROM [dbo].[ADcomputers] a
			WHERE ObjectGUID NOT IN (SELECT ObjectGUID FROM ##ADcomputers);
		PRINT @CurrentOp + ' - deleted: ' + CAST(@@ROWCOUNT AS nvarchar(64)) + ' rows.';

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
	CREATE TABLE ##ADcomputers (foo int);
END
