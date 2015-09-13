-- =============================================
-- Author:		Snorri Kristjansson
-- Create date: 07.09.2015
-- Description:	Update AD table with data from Active Directory.
-- @ADpath = Domain e.g. 'LDAP://DC=contoso,DC=com'
-- =============================================
CREATE PROCEDURE usp_UpdateADgroups 
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
	-- Groups
	-------------------
	SET @CurrentOp = 'Get Groups';
	SET @TableName = 'ADgroups';
	PRINT '------------------------------------------------------------------------';
	PRINT @CurrentOp + ' from AD INTO ' + @TableName + ' table.';

	BEGIN TRY
		-- Create (global) temp table dynamically. Note is global cuz of scope issue.
		SET @table_name = 'dbo.' + @TableName;
		SET @tempTableName = '##' + @TableName;
		EXECUTE [dbo].[usp_GenerateTempTableScript] @table_name, @tempTableName, @SQL OUTPUT;
		EXEC (@SQL);

		-- Get all groups from AD into temp table - Note group members returned in @Members as XML.
		SET @ADfilter = '(objectCategory=group)';
		INSERT INTO ##ADgroups EXEC dbo.clr_GetADobjects @ADpath, @ADfilter, @Members OUTPUT;
		PRINT @CurrentOp + ' from AD into temp table: ' + CAST(@@ROWCOUNT AS nvarchar(64)) + ' rows.';

		-- Insert into DeletedADgroups table all rows from ADgroups table that don't exist in the temp table.
		-- (i.e. the rows that will be deleted by the MERGE statement.)
		INSERT INTO [dbo].[DeletedADgroups]
			SELECT a.*, GETDATE() AS [DeletedDate]
			FROM [dbo].[ADgroups] a
			WHERE ObjectGUID NOT IN (SELECT ObjectGUID FROM ##ADgroups);
		PRINT @CurrentOp + ' - deleted: ' + CAST(@@ROWCOUNT AS nvarchar(64)) + ' rows.';

		-- Generate MERGE statement dynamically from table definition.
		EXECUTE [dbo].[usp_GenerateMergeStatement] @TableName, @tempTableName, @SQL OUTPUT

		-- Execute MERGE statement.
		PRINT 'MERGE ' + @TableName;
		EXECUTE (@SQL)

		-- DROP temp table.
		SET @SQL = 'DROP TABLE ' + @tempTableName + ';';
		EXECUTE (@SQL)


		PRINT 'Get Group members from XML data.';

		-- Create (global) temp table dynamically. Note is global cuz of scope issue.
		SET @table_name = 'dbo.ADgroup_members';
		SET @tempTableName = '##ADgroup_members';
		EXECUTE [dbo].[usp_GenerateTempTableScript] @table_name, @tempTableName, @SQL OUTPUT;
		EXEC (@SQL);

		-- INSERT group members into temp table.
		WITH MemberList AS ( -- Process group members XML data.
		select Tg.Cg.value('@GrpDS', 'nvarchar(256)') as GroupDS,
				Tm.Cm.value('@MemberDS', 'nvarchar(256)') as MemberDS
		from @Members.nodes('/body') as Tb(Cb)
		  outer apply Tb.Cb.nodes('Group') as Tg(Cg)
		  outer apply Tg.Cg.nodes('Member') AS Tm(Cm)
		)
		INSERT INTO ##ADgroup_members 
		  SELECT 
			G.ObjectGUID AS GroupGUID,
			COALESCE(U.ObjectGUID, GM.ObjectGUID, C.ObjectGUID, CN.ObjectGUID, W.ObjectGUID) AS MemberGUID,
			COALESCE(U.ObjectClass, GM.ObjectClass, C.ObjectClass, CN.ObjectClass, W.ObjectClass) AS MemberType,
			M.GroupDS AS GroupDistinguishedName,
			M.MemberDS AS [MemberDistinguishedName]
		FROM MemberList M
		LEFT JOIN dbo.ADgroups G ON M.GroupDS = G.DistinguishedName
		LEFT JOIN dbo.ADgroups GM ON M.MemberDS = GM.DistinguishedName
		LEFT JOIN dbo.ADcomputers C ON M.MemberDS = C.DistinguishedName
		LEFT JOIN dbo.ADusers U ON M.MemberDS = U.DistinguishedName
		LEFT JOIN dbo.ADcontacts CN ON M.MemberDS = CN.DistinguishedName
		LEFT JOIN dbo.ADwell_known_sids W ON M.MemberDS = W.DistinguishedName;
		PRINT @CurrentOp + '(members) from XML into temp table: ' + CAST(@@ROWCOUNT AS nvarchar(64)) + ' rows.';

		-- Insert into DeletedADgroup_members table all rows from ADgroup_members 
		-- table that don't exist in the temp table.
		-- (i.e. the rows that will be deleted by the MERGE statement.)
		INSERT INTO [dbo].[DeletedADgroup_members]
			SELECT gm.*, GETDATE() AS [DeletedDate]
			  FROM [dbo].[ADgroup_members] gm
			  LEFT JOIN ##ADgroup_members t ON gm.GroupGUID = t.GroupGUID AND gm.MemberGUID = t.MemberGUID
			  WHERE t.GroupGUID IS NULL;
			--SELECT a.*, GETDATE() AS [DeletedDate]
			--FROM [dbo].[ADgroup_members] a
			--WHERE ObjectGUID NOT IN (SELECT ObjectGUID FROM ##ADgroup_members);
		PRINT @CurrentOp + '(members) - deleted: ' + CAST(@@ROWCOUNT AS nvarchar(64)) + ' rows.';

		PRINT 'MERGE Group members';
		MERGE dbo.ADgroup_members WITH (HOLDLOCK) AS T
		USING ##ADgroup_members AS S 
		ON (T.GroupGUID = S.GroupGUID AND T.MemberGUID = S.MemberGUID) 
		WHEN MATCHED THEN 
		UPDATE SET 
		T.MemberType = S.MemberType,
		T.[GroupDistinguishedName] = S.[GroupDistinguishedName],
		T.[MemberDistinguishedName] = S.[MemberDistinguishedName]
		WHEN NOT MATCHED BY TARGET THEN 
		INSERT (GroupGUID, MemberGUID, MemberType, [GroupDistinguishedName], [MemberDistinguishedName]) 
		VALUES (S.GroupGUID, S.MemberGUID, S.MemberType, S.[GroupDistinguishedName], S.[MemberDistinguishedName]) 
		WHEN NOT MATCHED BY SOURCE THEN 
		DELETE;

		DROP TABLE ##ADgroup_members;
	END TRY
	BEGIN CATCH
		PRINT 'Error - ' + @CurrentOp + ' - Operation aborted.';
		THROW;
	END CATCH
	RETURN;
	CREATE TABLE ##ADgroups (foo int);
	CREATE TABLE ##ADgroup_members (foo int);
END
