﻿DECLARE @ADpath nvarchar(64) = 'LDAP://DC=contoso,DC=com';
EXECUTE [dbo].[usp_UpdateADwell_known_sids] @ADpath;
