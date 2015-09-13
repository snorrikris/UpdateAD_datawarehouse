DECLARE @ADpath nvarchar(64) = 'LDAP://DC=veca,DC=is';
EXECUTE [dbo].[usp_UpdateADgroups] @ADpath;
