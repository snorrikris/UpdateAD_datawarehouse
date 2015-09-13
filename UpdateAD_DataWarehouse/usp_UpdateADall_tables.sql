-- =============================================
-- Author:		Snorri Kristjansson
-- Create date: 07.09.2015
-- Description:	Update all ADxxxxx tables with data from Active Directory.
-- @ADpath = Domain e.g. 'LDAP://DC=contoso,DC=com'
-- =============================================
CREATE PROCEDURE usp_UpdateADall_tables 
	@ADpath nvarchar(64)
AS
BEGIN
	SET NOCOUNT ON;

	EXECUTE [dbo].[usp_UpdateADusers] @ADpath;
	EXECUTE [dbo].[usp_UpdateADcontacts] @ADpath;
	EXECUTE [dbo].[usp_UpdateADcomputers] @ADpath;
	EXECUTE [dbo].[usp_UpdateADwell_known_sids] @ADpath;
	EXECUTE [dbo].[usp_UpdateADgroups] @ADpath;
	EXECUTE [dbo].[usp_UpdateADusersPhotos] @ADpath;
END
