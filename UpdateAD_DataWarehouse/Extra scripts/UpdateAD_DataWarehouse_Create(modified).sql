-- Note - after project build, need to modify the Create script
--		remove create database code
--		remove create assembly
--		remove create clr SPs

USE [AD_DW];
GO
PRINT N'Creating [dbo].[ADwell_known_sids_lookup]...';


GO
CREATE TABLE [dbo].[ADwell_known_sids_lookup] (
    [SID]         NVARCHAR (128) NOT NULL,
    [DisplayName] NVARCHAR (128) NULL,
    [Description] NVARCHAR (512) NULL,
    CONSTRAINT [PK_WellKnownSIDsLookup] PRIMARY KEY CLUSTERED ([SID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creating [dbo].[DeletedADgroup_members]...';


GO
CREATE TABLE [dbo].[DeletedADgroup_members] (
    [GroupGUID]               UNIQUEIDENTIFIER NOT NULL,
    [MemberGUID]              UNIQUEIDENTIFIER NOT NULL,
    [MemberType]              NVARCHAR (64)    NOT NULL,
    [GroupDistinguishedName]  NVARCHAR (512)   NULL,
    [MemberDistinguishedName] NVARCHAR (512)   NULL,
    [DeletedDate]             DATETIME2 (7)    NOT NULL,
    CONSTRAINT [PK_DeletedGroupMemberGUIDs] PRIMARY KEY CLUSTERED ([DeletedDate] ASC, [GroupGUID] ASC, [MemberGUID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creating [dbo].[DeletedADgroups]...';


GO
CREATE TABLE [dbo].[DeletedADgroups] (
    [Name]              NVARCHAR (256)   NULL,
    [GroupCategory]     NVARCHAR (32)    NULL,
    [GroupScope]        NVARCHAR (32)    NULL,
    [Description]       NVARCHAR (512)   NULL,
    [EmailAddress]      NVARCHAR (256)   NULL,
    [ManagedBy]         NVARCHAR (256)   NULL,
    [DistinguishedName] NVARCHAR (512)   NULL,
    [DisplayName]       NVARCHAR (128)   NULL,
    [Created]           DATETIME         NULL,
    [Modified]          DATETIME         NULL,
    [SamAccountName]    NVARCHAR (128)   NULL,
    [ObjectCategory]    NVARCHAR (128)   NULL,
    [ObjectClass]       NVARCHAR (64)    NULL,
    [SID]               NVARCHAR (128)   NULL,
    [ObjectGUID]        UNIQUEIDENTIFIER NOT NULL,
    [DeletedDate]       DATETIME2 (7)    NOT NULL,
    CONSTRAINT [PK_DeletedGroupGUID] PRIMARY KEY CLUSTERED ([DeletedDate] ASC, [ObjectGUID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creating [dbo].[DeletedADcomputers]...';


GO
CREATE TABLE [dbo].[DeletedADcomputers] (
    [Name]                              NVARCHAR (256)   NULL,
    [DNSHostName]                       NVARCHAR (128)   NULL,
    [Description]                       NVARCHAR (256)   NULL,
    [Location]                          NVARCHAR (128)   NULL,
    [OperatingSystem]                   NVARCHAR (64)    NULL,
    [OperatingSystemVersion]            NVARCHAR (16)    NULL,
    [OperatingSystemServicePack]        NVARCHAR (32)    NULL,
    [ManagedBy]                         NVARCHAR (256)   NULL,
    [Enabled]                           BIT              NULL,
    [LockedOut]                         BIT              NULL,
    [MNSLogonAccount]                   BIT              NULL,
    [CannotChangePassword]              BIT              NULL,
    [PasswordExpired]                   BIT              NULL,
    [PasswordNeverExpires]              BIT              NULL,
    [PasswordNotRequired]               BIT              NULL,
    [SmartcardLogonRequired]            BIT              NULL,
    [DoesNotRequirePreAuth]             BIT              NULL,
    [AllowReversiblePasswordEncryption] BIT              NULL,
    [AccountNotDelegated]               BIT              NULL,
    [TrustedForDelegation]              BIT              NULL,
    [TrustedToAuthForDelegation]        BIT              NULL,
    [UseDESKeyOnly]                     BIT              NULL,
    [LastBadPasswordAttempt]            DATETIME         NULL,
    [BadLogonCount]                     INT              NULL,
    [LastLogonDate]                     DATETIME         NULL,
    [logonCount]                        INT              NULL,
    [PasswordLastSet]                   DATETIME         NULL,
    [AccountLockoutTime]                DATETIME         NULL,
    [AccountExpirationDate]             DATETIME         NULL,
    [Created]                           DATETIME         NULL,
    [Modified]                          DATETIME         NULL,
    [CN]                                NVARCHAR (256)   NULL,
    [DisplayName]                       NVARCHAR (128)   NULL,
    [DistinguishedName]                 NVARCHAR (512)   NULL,
    [PrimaryGroupID]                    INT              NULL,
    [SamAccountName]                    NVARCHAR (128)   NULL,
    [userAccountControl]                INT              NULL,
    [ObjectCategory]                    NVARCHAR (128)   NULL,
    [ObjectClass]                       NVARCHAR (64)    NULL,
    [SID]                               NVARCHAR (128)   NOT NULL,
    [ObjectGUID]                        UNIQUEIDENTIFIER NOT NULL,
    [DeletedDate]                       DATETIME2 (7)    NOT NULL,
    CONSTRAINT [PK_DeletedComputerGUID] PRIMARY KEY CLUSTERED ([DeletedDate] ASC, [ObjectGUID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creating [dbo].[DeletedADcontacts]...';


GO
CREATE TABLE [dbo].[DeletedADcontacts] (
    [GivenName]         NVARCHAR (128)   NULL,
    [Initials]          NVARCHAR (32)    NULL,
    [Surname]           NVARCHAR (256)   NULL,
    [DisplayName]       NVARCHAR (128)   NULL,
    [Description]       NVARCHAR (256)   NULL,
    [Office]            NVARCHAR (128)   NULL,
    [OfficePhone]       NVARCHAR (32)    NULL,
    [EmailAddress]      NVARCHAR (256)   NULL,
    [HomePage]          NVARCHAR (128)   NULL,
    [StreetAddress]     NVARCHAR (160)   NULL,
    [POBox]             NVARCHAR (32)    NULL,
    [City]              NVARCHAR (128)   NULL,
    [State]             NVARCHAR (64)    NULL,
    [PostalCode]        NVARCHAR (32)    NULL,
    [Country]           NVARCHAR (128)   NULL,
    [HomePhone]         NVARCHAR (32)    NULL,
    [Pager]             NVARCHAR (32)    NULL,
    [MobilePhone]       NVARCHAR (32)    NULL,
    [Fax]               NVARCHAR (128)   NULL,
    [Title]             NVARCHAR (128)   NULL,
    [Department]        NVARCHAR (128)   NULL,
    [Company]           NVARCHAR (128)   NULL,
    [Manager]           NVARCHAR (256)   NULL,
    [EmployeeID]        NVARCHAR (64)    NULL,
    [EmployeeNumber]    NVARCHAR (64)    NULL,
    [Division]          NVARCHAR (128)   NULL,
    [DistinguishedName] NVARCHAR (512)   NULL,
    [Name]              NVARCHAR (256)   NULL,
    [CN]                NVARCHAR (256)   NULL,
    [Created]           DATETIME         NULL,
    [Modified]          DATETIME         NULL,
    [ObjectCategory]    NVARCHAR (128)   NULL,
    [ObjectClass]       NVARCHAR (64)    NULL,
    [ObjectGUID]        UNIQUEIDENTIFIER NOT NULL,
    [DeletedDate]       DATETIME2 (7)    NOT NULL,
    CONSTRAINT [PK_DeletedContactGUID] PRIMARY KEY CLUSTERED ([DeletedDate] ASC, [ObjectGUID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creating [dbo].[ADusersPhotos]...';


GO
CREATE TABLE [dbo].[ADusersPhotos] (
    [ObjectGUID] UNIQUEIDENTIFIER NOT NULL,
    [Width]      INT              NULL,
    [Height]     INT              NULL,
    [Photo]      VARBINARY (MAX)  NULL,
    CONSTRAINT [PK_ADusersPhotosGUIDs] PRIMARY KEY CLUSTERED ([ObjectGUID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creating [dbo].[ADwell_known_sids]...';


GO
CREATE TABLE [dbo].[ADwell_known_sids] (
    [Name]              NVARCHAR (256)   NULL,
    [Description]       NVARCHAR (512)   NULL,
    [DistinguishedName] NVARCHAR (512)   NULL,
    [DisplayName]       NVARCHAR (128)   NULL,
    [ObjectCategory]    NVARCHAR (128)   NULL,
    [ObjectClass]       NVARCHAR (64)    NULL,
    [SID]               NVARCHAR (128)   NULL,
    [ObjectGUID]        UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_WellKnownSIDsGUID] PRIMARY KEY CLUSTERED ([ObjectGUID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creating [dbo].[ADgroup_members]...';


GO
CREATE TABLE [dbo].[ADgroup_members] (
    [GroupGUID]               UNIQUEIDENTIFIER NOT NULL,
    [MemberGUID]              UNIQUEIDENTIFIER NOT NULL,
    [MemberType]              NVARCHAR (64)    NOT NULL,
    [GroupDistinguishedName]  NVARCHAR (512)   NULL,
    [MemberDistinguishedName] NVARCHAR (512)   NULL,
    CONSTRAINT [PK_GroupMemberGUIDs] PRIMARY KEY CLUSTERED ([GroupGUID] ASC, [MemberGUID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creating [dbo].[ADgroups]...';


GO
CREATE TABLE [dbo].[ADgroups] (
    [Name]              NVARCHAR (256)   NULL,
    [GroupCategory]     NVARCHAR (32)    NULL,
    [GroupScope]        NVARCHAR (32)    NULL,
    [Description]       NVARCHAR (512)   NULL,
    [EmailAddress]      NVARCHAR (256)   NULL,
    [ManagedBy]         NVARCHAR (256)   NULL,
    [DistinguishedName] NVARCHAR (512)   NULL,
    [DisplayName]       NVARCHAR (128)   NULL,
    [Created]           DATETIME         NULL,
    [Modified]          DATETIME         NULL,
    [SamAccountName]    NVARCHAR (128)   NULL,
    [ObjectCategory]    NVARCHAR (128)   NULL,
    [ObjectClass]       NVARCHAR (64)    NULL,
    [SID]               NVARCHAR (128)   NULL,
    [ObjectGUID]        UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_GroupGUID] PRIMARY KEY CLUSTERED ([ObjectGUID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creating [dbo].[ADcomputers]...';


GO
CREATE TABLE [dbo].[ADcomputers] (
    [Name]                              NVARCHAR (256)   NULL,
    [DNSHostName]                       NVARCHAR (128)   NULL,
    [Description]                       NVARCHAR (256)   NULL,
    [Location]                          NVARCHAR (128)   NULL,
    [OperatingSystem]                   NVARCHAR (64)    NULL,
    [OperatingSystemVersion]            NVARCHAR (16)    NULL,
    [OperatingSystemServicePack]        NVARCHAR (32)    NULL,
    [ManagedBy]                         NVARCHAR (256)   NULL,
    [Enabled]                           BIT              NULL,
    [LockedOut]                         BIT              NULL,
    [MNSLogonAccount]                   BIT              NULL,
    [CannotChangePassword]              BIT              NULL,
    [PasswordExpired]                   BIT              NULL,
    [PasswordNeverExpires]              BIT              NULL,
    [PasswordNotRequired]               BIT              NULL,
    [SmartcardLogonRequired]            BIT              NULL,
    [DoesNotRequirePreAuth]             BIT              NULL,
    [AllowReversiblePasswordEncryption] BIT              NULL,
    [AccountNotDelegated]               BIT              NULL,
    [TrustedForDelegation]              BIT              NULL,
    [TrustedToAuthForDelegation]        BIT              NULL,
    [UseDESKeyOnly]                     BIT              NULL,
    [LastBadPasswordAttempt]            DATETIME         NULL,
    [BadLogonCount]                     INT              NULL,
    [LastLogonDate]                     DATETIME         NULL,
    [logonCount]                        INT              NULL,
    [PasswordLastSet]                   DATETIME         NULL,
    [AccountLockoutTime]                DATETIME         NULL,
    [AccountExpirationDate]             DATETIME         NULL,
    [Created]                           DATETIME         NULL,
    [Modified]                          DATETIME         NULL,
    [CN]                                NVARCHAR (256)   NULL,
    [DisplayName]                       NVARCHAR (128)   NULL,
    [DistinguishedName]                 NVARCHAR (512)   NULL,
    [PrimaryGroupID]                    INT              NULL,
    [SamAccountName]                    NVARCHAR (128)   NULL,
    [userAccountControl]                INT              NULL,
    [ObjectCategory]                    NVARCHAR (128)   NULL,
    [ObjectClass]                       NVARCHAR (64)    NULL,
    [SID]                               NVARCHAR (128)   NOT NULL,
    [ObjectGUID]                        UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_ComputerGUID] PRIMARY KEY CLUSTERED ([ObjectGUID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creating [dbo].[ADcontacts]...';


GO
CREATE TABLE [dbo].[ADcontacts] (
    [GivenName]         NVARCHAR (128)   NULL,
    [Initials]          NVARCHAR (32)    NULL,
    [Surname]           NVARCHAR (256)   NULL,
    [DisplayName]       NVARCHAR (128)   NULL,
    [Description]       NVARCHAR (256)   NULL,
    [Office]            NVARCHAR (128)   NULL,
    [OfficePhone]       NVARCHAR (32)    NULL,
    [EmailAddress]      NVARCHAR (256)   NULL,
    [HomePage]          NVARCHAR (128)   NULL,
    [StreetAddress]     NVARCHAR (160)   NULL,
    [POBox]             NVARCHAR (32)    NULL,
    [City]              NVARCHAR (128)   NULL,
    [State]             NVARCHAR (64)    NULL,
    [PostalCode]        NVARCHAR (32)    NULL,
    [Country]           NVARCHAR (128)   NULL,
    [HomePhone]         NVARCHAR (32)    NULL,
    [Pager]             NVARCHAR (32)    NULL,
    [MobilePhone]       NVARCHAR (32)    NULL,
    [Fax]               NVARCHAR (128)   NULL,
    [Title]             NVARCHAR (128)   NULL,
    [Department]        NVARCHAR (128)   NULL,
    [Company]           NVARCHAR (128)   NULL,
    [Manager]           NVARCHAR (256)   NULL,
    [EmployeeID]        NVARCHAR (64)    NULL,
    [EmployeeNumber]    NVARCHAR (64)    NULL,
    [Division]          NVARCHAR (128)   NULL,
    [DistinguishedName] NVARCHAR (512)   NULL,
    [Name]              NVARCHAR (256)   NULL,
    [CN]                NVARCHAR (256)   NULL,
    [Created]           DATETIME         NULL,
    [Modified]          DATETIME         NULL,
    [ObjectCategory]    NVARCHAR (128)   NULL,
    [ObjectClass]       NVARCHAR (64)    NULL,
    [ObjectGUID]        UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_ContactGUID] PRIMARY KEY CLUSTERED ([ObjectGUID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creating [dbo].[DeletedADusers]...';


GO
CREATE TABLE [dbo].[DeletedADusers] (
    [GivenName]                         NVARCHAR (128)   NULL,
    [Initials]                          NVARCHAR (32)    NULL,
    [Surname]                           NVARCHAR (256)   NULL,
    [DisplayName]                       NVARCHAR (128)   NULL,
    [Description]                       NVARCHAR (256)   NULL,
    [Office]                            NVARCHAR (128)   NULL,
    [OfficePhone]                       NVARCHAR (32)    NULL,
    [EmailAddress]                      NVARCHAR (256)   NULL,
    [HomePage]                          NVARCHAR (128)   NULL,
    [StreetAddress]                     NVARCHAR (160)   NULL,
    [POBox]                             NVARCHAR (32)    NULL,
    [City]                              NVARCHAR (128)   NULL,
    [State]                             NVARCHAR (64)    NULL,
    [PostalCode]                        NVARCHAR (32)    NULL,
    [Country]                           NVARCHAR (128)   NULL,
    [HomePhone]                         NVARCHAR (32)    NULL,
    [Pager]                             NVARCHAR (32)    NULL,
    [MobilePhone]                       NVARCHAR (32)    NULL,
    [Fax]                               NVARCHAR (128)   NULL,
    [Title]                             NVARCHAR (128)   NULL,
    [Department]                        NVARCHAR (128)   NULL,
    [Company]                           NVARCHAR (128)   NULL,
    [Manager]                           NVARCHAR (256)   NULL,
    [EmployeeID]                        NVARCHAR (64)    NULL,
    [EmployeeNumber]                    NVARCHAR (64)    NULL,
    [Division]                          NVARCHAR (128)   NULL,
    [Enabled]                           BIT              NULL,
    [LockedOut]                         BIT              NULL,
    [MNSLogonAccount]                   BIT              NULL,
    [CannotChangePassword]              BIT              NULL,
    [PasswordExpired]                   BIT              NULL,
    [PasswordNeverExpires]              BIT              NULL,
    [PasswordNotRequired]               BIT              NULL,
    [SmartcardLogonRequired]            BIT              NULL,
    [DoesNotRequirePreAuth]             BIT              NULL,
    [AllowReversiblePasswordEncryption] BIT              NULL,
    [AccountNotDelegated]               BIT              NULL,
    [TrustedForDelegation]              BIT              NULL,
    [TrustedToAuthForDelegation]        BIT              NULL,
    [UseDESKeyOnly]                     BIT              NULL,
    [HomedirRequired]                   BIT              NULL,
    [UserMustChangePasswordAtNextLogon] BIT              NULL,
    [LastBadPasswordAttempt]            DATETIME         NULL,
    [BadLogonCount]                     INT              NULL,
    [LastLogonDate]                     DATETIME         NULL,
    [LogonCount]                        INT              NULL,
    [PasswordLastSet]                   DATETIME         NULL,
    [PasswordExpiryTime]                DATETIME         NULL,
    [AccountLockoutTime]                DATETIME         NULL,
    [AccountExpirationDate]             DATETIME         NULL,
    [LogonWorkstations]                 NVARCHAR (128)   NULL,
    [HomeDirectory]                     NVARCHAR (128)   NULL,
    [HomeDrive]                         NVARCHAR (64)    NULL,
    [ProfilePath]                       NVARCHAR (128)   NULL,
    [ScriptPath]                        NVARCHAR (256)   NULL,
    [userAccountControl]                INT              NULL,
    [PrimaryGroupID]                    INT              NULL,
    [Name]                              NVARCHAR (256)   NULL,
    [CN]                                NVARCHAR (256)   NULL,
    [UserPrincipalName]                 NVARCHAR (256)   NULL,
    [SamAccountName]                    NVARCHAR (128)   NULL,
    [DistinguishedName]                 NVARCHAR (512)   NULL,
    [Created]                           DATETIME         NULL,
    [Modified]                          DATETIME         NULL,
    [ObjectCategory]                    NVARCHAR (128)   NULL,
    [ObjectClass]                       NVARCHAR (64)    NULL,
    [SID]                               NVARCHAR (128)   NOT NULL,
    [ObjectGUID]                        UNIQUEIDENTIFIER NOT NULL,
    [ManagerGUID]                       UNIQUEIDENTIFIER NULL,
    [DeletedDate]                       DATETIME2 (7)    NOT NULL,
    CONSTRAINT [PK_DeletedUserGUID] PRIMARY KEY CLUSTERED ([DeletedDate] ASC, [ObjectGUID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creating [dbo].[ADusers]...';


GO
CREATE TABLE [dbo].[ADusers] (
    [GivenName]                         NVARCHAR (128)   NULL,
    [Initials]                          NVARCHAR (32)    NULL,
    [Surname]                           NVARCHAR (256)   NULL,
    [DisplayName]                       NVARCHAR (128)   NULL,
    [Description]                       NVARCHAR (256)   NULL,
    [Office]                            NVARCHAR (128)   NULL,
    [OfficePhone]                       NVARCHAR (32)    NULL,
    [EmailAddress]                      NVARCHAR (256)   NULL,
    [HomePage]                          NVARCHAR (128)   NULL,
    [StreetAddress]                     NVARCHAR (160)   NULL,
    [POBox]                             NVARCHAR (32)    NULL,
    [City]                              NVARCHAR (128)   NULL,
    [State]                             NVARCHAR (64)    NULL,
    [PostalCode]                        NVARCHAR (32)    NULL,
    [Country]                           NVARCHAR (128)   NULL,
    [HomePhone]                         NVARCHAR (32)    NULL,
    [Pager]                             NVARCHAR (32)    NULL,
    [MobilePhone]                       NVARCHAR (32)    NULL,
    [Fax]                               NVARCHAR (128)   NULL,
    [Title]                             NVARCHAR (128)   NULL,
    [Department]                        NVARCHAR (128)   NULL,
    [Company]                           NVARCHAR (128)   NULL,
    [Manager]                           NVARCHAR (256)   NULL,
    [EmployeeID]                        NVARCHAR (64)    NULL,
    [EmployeeNumber]                    NVARCHAR (64)    NULL,
    [Division]                          NVARCHAR (128)   NULL,
    [Enabled]                           BIT              NULL,
    [LockedOut]                         BIT              NULL,
    [MNSLogonAccount]                   BIT              NULL,
    [CannotChangePassword]              BIT              NULL,
    [PasswordExpired]                   BIT              NULL,
    [PasswordNeverExpires]              BIT              NULL,
    [PasswordNotRequired]               BIT              NULL,
    [SmartcardLogonRequired]            BIT              NULL,
    [DoesNotRequirePreAuth]             BIT              NULL,
    [AllowReversiblePasswordEncryption] BIT              NULL,
    [AccountNotDelegated]               BIT              NULL,
    [TrustedForDelegation]              BIT              NULL,
    [TrustedToAuthForDelegation]        BIT              NULL,
    [UseDESKeyOnly]                     BIT              NULL,
    [HomedirRequired]                   BIT              NULL,
    [UserMustChangePasswordAtNextLogon] BIT              NULL,
    [LastBadPasswordAttempt]            DATETIME         NULL,
    [BadLogonCount]                     INT              NULL,
    [LastLogonDate]                     DATETIME         NULL,
    [LogonCount]                        INT              NULL,
    [PasswordLastSet]                   DATETIME         NULL,
    [PasswordExpiryTime]                DATETIME         NULL,
    [AccountLockoutTime]                DATETIME         NULL,
    [AccountExpirationDate]             DATETIME         NULL,
    [LogonWorkstations]                 NVARCHAR (128)   NULL,
    [HomeDirectory]                     NVARCHAR (128)   NULL,
    [HomeDrive]                         NVARCHAR (64)    NULL,
    [ProfilePath]                       NVARCHAR (128)   NULL,
    [ScriptPath]                        NVARCHAR (256)   NULL,
    [userAccountControl]                INT              NULL,
    [PrimaryGroupID]                    INT              NULL,
    [Name]                              NVARCHAR (256)   NULL,
    [CN]                                NVARCHAR (256)   NULL,
    [UserPrincipalName]                 NVARCHAR (256)   NULL,
    [SamAccountName]                    NVARCHAR (128)   NULL,
    [DistinguishedName]                 NVARCHAR (512)   NULL,
    [Created]                           DATETIME         NULL,
    [Modified]                          DATETIME         NULL,
    [ObjectCategory]                    NVARCHAR (128)   NULL,
    [ObjectClass]                       NVARCHAR (64)    NULL,
    [SID]                               NVARCHAR (128)   NOT NULL,
    [ObjectGUID]                        UNIQUEIDENTIFIER NOT NULL,
    [ManagerGUID]                       UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_UserGUID] PRIMARY KEY CLUSTERED ([ObjectGUID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creating [dbo].[usp_GenerateMergeStatement]...';


GO
-- =============================================
-- Author:		Snorri Kristjansson
-- Create date: 05.09.2015
-- Description:	Generate MERGE statement from table definition.
-- =============================================
CREATE PROCEDURE [dbo].[usp_GenerateMergeStatement]
	@TableName nvarchar(64),
	@tempTableName nvarchar(64),
	@MergeSQL nvarchar(max) OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	SET @MergeSQL = '';

	-- Get table columns as CSV
	DECLARE @CSV nvarchar(4000);
	SET @CSV = (SELECT LEFT(ColNames, LEN(ColNames) - 1)
	FROM (
	select '[' + c.name + '],' from sys.columns c 
	join sys.tables t on c.object_id = t.object_id
	where t.name = @TableName
	order by c.column_id
	FOR XML PATH('')
	) c (ColNames)) + CHAR(13);

	-- Get table columns as CSV formatted for MERGE INSERT clause
	DECLARE @CSV2 nvarchar(4000);
	SET @CSV2 = (SELECT LEFT(ColNames, LEN(ColNames) - 1)
	FROM (
	select 'T.[' + c.name + '] = S.[' + c.name + '],' from sys.columns c 
	join sys.tables t on c.object_id = t.object_id
	where t.name = @TableName AND c.name != 'ObjectGUID'
	order by c.column_id
	FOR XML PATH('')
	) c (ColNames)) + CHAR(13);

	-- Get table columns as CSV formatted for MERGE UPDATE clause - VALUES
	DECLARE @CSV3 nvarchar(4000);
	SET @CSV3 = (SELECT LEFT(ColNames, LEN(ColNames) - 1)
	FROM (
	select 'S.[' + c.name + '],' from sys.columns c 
	join sys.tables t on c.object_id = t.object_id
	where t.name = @TableName
	order by c.column_id
	FOR XML PATH('')
	) c (ColNames)) + CHAR(13);

	DECLARE @M1 nvarchar(1000) =
	  'MERGE dbo.' + @TableName + ' WITH (HOLDLOCK) AS T' + CHAR(13)
	+ 'USING ' + @tempTableName + ' AS S ' + CHAR(13)
	+ 'ON (T.ObjectGUID = S.ObjectGUID) ' + CHAR(13)
	+ 'WHEN MATCHED THEN ' + CHAR(13)
	+ 'UPDATE SET ' + CHAR(13);
	DECLARE @M2 nvarchar(1000) =
	  'WHEN NOT MATCHED BY TARGET THEN ' + CHAR(13)
	+ 'INSERT (' + CHAR(13);
	DECLARE @M3 nvarchar(1000) =
	  ') ' + CHAR(13)
	+ 'VALUES (' + CHAR(13);
	DECLARE @M4 nvarchar(1000) =
	+ ') ' + CHAR(13)
	+ 'WHEN NOT MATCHED BY SOURCE THEN ' + CHAR(13)
	+ 'DELETE;'
	SET @MergeSQL =
	  CAST(@M1 AS nvarchar(max))	-- Need to cast to nvarchar(max) because otherwise output will be truncated to 4000 chars.
	+ CAST(@CSV2 AS nvarchar(max))
	+ CAST(@M2 AS nvarchar(max))
	+ CAST(@CSV AS nvarchar(max))
	+ CAST(@M3 AS nvarchar(max))
	+ CAST(@CSV3 AS nvarchar(max))
	+ CAST(@M4 AS nvarchar(max));
END
GO
PRINT N'Creating [dbo].[usp_GenerateTempTableScript]...';


GO
-- =============================================
-- Author:		Snorri Kristjansson (and others)
-- Create date: 05.09.2015
-- Description:	Generate CREATE temp table script from table definition.
-- Source: http://stackoverflow.com/questions/706664/generate-sql-create-scripts-for-existing-tables-with-query
-- =============================================
CREATE PROCEDURE [dbo].[usp_GenerateTempTableScript] 
	@table_name SYSNAME,
	@tempTableName nvarchar(50),
	@SQL NVARCHAR(4000) OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	SET @SQL = '';
DECLARE 
      @object_name SYSNAME
    , @object_id INT

SELECT 
      @object_name = '[' + s.name + '].[' + o.name + ']'
    , @object_id = o.[object_id]
FROM sys.objects o WITH (NOWAIT)
JOIN sys.schemas s WITH (NOWAIT) ON o.[schema_id] = s.[schema_id]
WHERE s.name + '.' + o.name = @table_name
    AND o.[type] = 'U'
    AND o.is_ms_shipped = 0

SELECT @SQL = 'IF OBJECT_ID(''tempdb..' + @tempTableName + ''') IS NOT NULL DROP TABLE ' + @tempTableName + ';' + CHAR(13)
 + 'CREATE TABLE ' + @tempTableName + CHAR(13) + '(' + CHAR(13) + STUFF((
    SELECT CHAR(9) + ', [' + c.name + '] ' + 
        CASE WHEN c.is_computed = 1
            THEN 'AS ' + cc.[definition] 
            ELSE UPPER(tp.name) + 
                CASE WHEN tp.name IN ('varchar', 'char', 'varbinary', 'binary', 'text')
                       THEN '(' + CASE WHEN c.max_length = -1 THEN 'MAX' ELSE CAST(c.max_length AS VARCHAR(5)) END + ')'
                     WHEN tp.name IN ('nvarchar', 'nchar', 'ntext')
                       THEN '(' + CASE WHEN c.max_length = -1 THEN 'MAX' ELSE CAST(c.max_length / 2 AS VARCHAR(5)) END + ')'
                     WHEN tp.name IN ('datetime2', 'time2', 'datetimeoffset') 
                       THEN '(' + CAST(c.scale AS VARCHAR(5)) + ')'
                     WHEN tp.name = 'decimal' 
                       THEN '(' + CAST(c.[precision] AS VARCHAR(5)) + ',' + CAST(c.scale AS VARCHAR(5)) + ')'
                    ELSE ''
                END +
                CASE WHEN c.is_nullable = 1 THEN ' NULL' ELSE ' NOT NULL' END +
                CASE WHEN dc.[definition] IS NOT NULL THEN ' DEFAULT' + dc.[definition] ELSE '' END + 
                CASE WHEN ic.is_identity = 1 THEN ' IDENTITY(' + CAST(ISNULL(ic.seed_value, '0') AS CHAR(1)) + ',' + CAST(ISNULL(ic.increment_value, '1') AS CHAR(1)) + ')' ELSE '' END 
        END + CHAR(13)
    FROM sys.columns c WITH (NOWAIT)
    JOIN sys.types tp WITH (NOWAIT) ON c.user_type_id = tp.user_type_id
    LEFT JOIN sys.computed_columns cc WITH (NOWAIT) ON c.[object_id] = cc.[object_id] AND c.column_id = cc.column_id
    LEFT JOIN sys.default_constraints dc WITH (NOWAIT) ON c.default_object_id != 0 AND c.[object_id] = dc.parent_object_id AND c.column_id = dc.parent_column_id
    LEFT JOIN sys.identity_columns ic WITH (NOWAIT) ON c.is_identity = 1 AND c.[object_id] = ic.[object_id] AND c.column_id = ic.column_id
    WHERE c.[object_id] = @object_id
    ORDER BY c.column_id
    FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, CHAR(9) + ' ')
	+ ');';
END
GO
PRINT N'Creating [dbo].[usp_UpdateADusersPhotos]...';


GO
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
GO
PRINT N'Creating [dbo].[usp_UpdateADgroups]...';


GO
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
GO
PRINT N'Creating [dbo].[usp_UpdateADwell_known_sids]...';


GO
-- =============================================
-- Author:		Snorri Kristjansson
-- Create date: 07.09.2015
-- Description:	Update ADwell_known_sids table with data from Active Directory.
-- @ADpath = Domain e.g. 'LDAP://DC=contoso,DC=com'
-- =============================================
CREATE PROCEDURE usp_UpdateADwell_known_sids 
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
	-- Well known SIDs
	-------------------
	SET @CurrentOp = 'Get Well known SIDs';
	SET @TableName = 'ADwell_known_sids';
	PRINT '------------------------------------------------------------------------';
	PRINT @CurrentOp + ' from AD INTO ' + @TableName + ' table.';

	BEGIN TRY
		-- Create (global) temp table dynamically. Note is global cuz of scope issue.
		SET @table_name = 'dbo.' + @TableName;
		SET @tempTableName = '##' + @TableName;
		EXECUTE [dbo].[usp_GenerateTempTableScript] @table_name, @tempTableName, @SQL OUTPUT;
		EXEC (@SQL);

		-- Get all Well known SIDs from AD into temp table
		SET @ADfilter = '(|(objectSID=S-1-0)(objectSID=S-1-0-0)(objectSID=S-1-1)(objectSID=S-1-1-0)(objectSID=S-1-2)(objectSID=S-1-2-0)(objectSID=S-1-2-1)(objectSID=S-1-3)(objectSID=S-1-3-0)(objectSID=S-1-3-1)(objectSID=S-1-3-2)(objectSID=S-1-3-3)(objectSID=S-1-3-4)(objectSID=S-1-5-80-0)(objectSID=S-1-4)(objectSID=S-1-5)(objectSID=S-1-5-1)(objectSID=S-1-5-2)(objectSID=S-1-5-3)(objectSID=S-1-5-4)(objectSID=S-1-5-6)(objectSID=S-1-5-7)(objectSID=S-1-5-8)(objectSID=S-1-5-9)(objectSID=S-1-5-10)(objectSID=S-1-5-11)(objectSID=S-1-5-12)(objectSID=S-1-5-13)(objectSID=S-1-5-14)(objectSID=S-1-5-15)(objectSID=S-1-5-17)(objectSID=S-1-5-18)(objectSID=S-1-5-19)(objectSID=S-1-5-20)(objectSID=S-1-5-64-10)(objectSID=S-1-5-64-14)(objectSID=S-1-5-64-21)(objectSID=S-1-5-80)(objectSID=S-1-5-80-0)(objectSID=S-1-5-83-0)(objectSID=S-1-16-0)(objectSID=S-1-16-4096)(objectSID=S-1-16-8192)(objectSID=S-1-16-8448)(objectSID=S-1-16-12288)(objectSID=S-1-16-16384)(objectSID=S-1-16-20480)(objectSID=S-1-16-28672))';
		INSERT INTO ##ADwell_known_sids EXEC dbo.clr_GetADobjects @ADpath, @ADfilter, @Members OUTPUT;
		PRINT @CurrentOp + ' from AD into temp table: ' + CAST(@@ROWCOUNT AS nvarchar(64)) + ' rows.';

		-- Get DisplayName and Description from lookup table
		UPDATE ##ADwell_known_sids
		SET ##ADwell_known_sids.[DisplayName] = L.[DisplayName],
			##ADwell_known_sids.[Description] = L.[Description]
		FROM ##ADwell_known_sids W
		INNER JOIN dbo.ADwell_known_sids_lookup L ON W.[SID] = L.[SID] COLLATE Latin1_General_CI_AS

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
	CREATE TABLE ##ADwell_known_sids (foo int);
END
GO
PRINT N'Creating [dbo].[usp_UpdateADcomputers]...';


GO
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
GO
PRINT N'Creating [dbo].[usp_UpdateADcontacts]...';


GO
-- =============================================
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
GO
PRINT N'Creating [dbo].[usp_UpdateADusers]...';


GO
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
GO
PRINT N'Creating [dbo].[usp_UpdateADall_tables]...';


GO
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
GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
IF (SELECT COUNT(*) FROM [dbo].[ADwell_known_sids_lookup]) != 93 -- Current row count for 'this' data.
BEGIN
	INSERT [dbo].[ADwell_known_sids_lookup] ([SID], [DisplayName], [Description]) 
	VALUES 
	(N'S-1-0', N'Null Authority', N'An identifier authority.'), 
	(N'S-1-0-0', N'Nobody', N'No security principal.'), 
	(N'S-1-1', N'World Authority', N'An identifier authority.'), 
	(N'S-1-1-0', N'Everyone', N'A group that includes all users, even anonymous users and guests. Membership is controlled by the operating system.'), 
	(N'S-1-2', N'Local Authority', N'An identifier authority.'), 
	(N'S-1-2-0', N'Local', N'A group that includes all users who have logged on locally. '), 
	(N'S-1-2-1', N'Console Logon', N'A group that includes users who are logged on to the physical console. '), 
	(N'S-1-3', N'Creator Authority', N'An identifier authority.'), 
	(N'S-1-3-0', N'Creator Owner', N'A placeholder in an inheritable access control entry (ACE). When the ACE is inherited, the system replaces this SID with the SID for the object''s creator.'), 
	(N'S-1-3-1', N'Creator Group', N'A placeholder in an inheritable ACE. When the ACE is inherited, the system replaces this SID with the SID for the primary group of the object''s creator. The primary group is used only by the POSIX subsystem.'), 
	(N'S-1-3-2', N'Creator Owner Server', N'This SID is not used in Windows 2000.'), 
	(N'S-1-3-3', N'Creator Group Server', N'This SID is not used in Windows 2000.'), 
	(N'S-1-3-4', N'Owner Rights', N'A group that represents the current owner of the object. When an ACE that carries this SID is applied to an object, the system ignores the implicit READ_CONTROL and WRITE_DAC permissions for the object owner.'), 
	--(N'S-1-5-80-0', N'All Services ', N'A group that includes all service processes configured on the system. Membership is controlled by the operating system. '), 
	(N'S-1-4', N'Non-unique Authority', N'An identifier authority.'), 
	(N'S-1-5', N'NT Authority', N'An identifier authority.'), 
	(N'S-1-5-1', N'Dialup', N'A group that includes all users who have logged on through a dial-up connection. Membership is controlled by the operating system.'), 
	(N'S-1-5-2', N'Network', N'A group that includes all users that have logged on through a network connection. Membership is controlled by the operating system.'), 
	(N'S-1-5-3', N'Batch', N'A group that includes all users that have logged on through a batch queue facility. Membership is controlled by the operating system.'), 
	(N'S-1-5-4', N'Interactive', N'A group that includes all users that have logged on interactively. Membership is controlled by the operating system.'), 
	(N'S-1-5-5-X-Y', N'Logon Session', N'A logon session. The X and Y values for these SIDs are different for each session.'), 
	(N'S-1-5-6', N'Service', N'A group that includes all security principals that have logged on as a service. Membership is controlled by the operating system.'), 
	(N'S-1-5-7', N'Anonymous', N'A group that includes all users that have logged on anonymously. Membership is controlled by the operating system.'), 
	(N'S-1-5-8', N'Proxy', N'This SID is not used in Windows 2000.'), 
	(N'S-1-5-9', N'Enterprise Domain Controllers', N'A group that includes all domain controllers in a forest that uses an Active Directory directory service. Membership is controlled by the operating system.'), 
	(N'S-1-5-10', N'Principal Self', N'A placeholder in an inheritable ACE on an account object or group object in Active Directory. When the ACE is inherited, the system replaces this SID with the SID for the security principal who holds the account.'), 
	(N'S-1-5-11', N'Authenticated Users', N'A group that includes all users whose identities were authenticated when they logged on. Membership is controlled by the operating system.'), 
	(N'S-1-5-12', N'Restricted Code', N'This SID is reserved for future use.'), 
	(N'S-1-5-13', N'Terminal Server Users', N'A group that includes all users that have logged on to a Terminal Services server. Membership is controlled by the operating system.'), 
	(N'S-1-5-14', N'Remote Interactive Logon', N'A group that includes all users who have logged on through a terminal services logon. '), 
	(N'S-1-5-15', N'This Organization', N'A group that includes all users from the same organization. Only included with AD accounts and only added by a Windows Server 2003 or later domain controller. '), 
	(N'S-1-5-17', N'This Organization', N'An account that is used by the default Internet Information Services (IIS) user. '), 
	(N'S-1-5-18', N'Local System', N'A service account that is used by the operating system.'), 
	(N'S-1-5-19', N'NT Authority', N'Local Service'), 
	(N'S-1-5-20', N'NT Authority', N'Network Service'), 
	(N'S-1-5-21-domain-500', N'Administrator', N'A user account for the system administrator. By default, it is the only user account that is given full control over the system.'), 
	(N'S-1-5-21-domain-501', N'Guest', N'A user account for people who do not have individual accounts. This user account does not require a password. By default, the Guest account is disabled.'), 
	(N'S-1-5-21-domain-502', N'KRBTGT', N'A service account that is used by the Key Distribution Center (KDC) service.'), 
	(N'S-1-5-21-domain-512', N'Domain Admins', N'A global group whose members are authorized to administer the domain. By default, the Domain Admins group is a member of the Administrators group on all computers that have joined a domain, including the domain controllers. Domain Admins is the default owner of any object that is created by any member of the group.'), 
	(N'S-1-5-21-domain-513', N'Domain Users', N'A global group that, by default, includes all user accounts in a domain. When you create a user account in a domain, it is added to this group by default.'), 
	(N'S-1-5-21-domain-514', N'Domain Guests', N'A global group that, by default, has only one member, the domain''s built-in Guest account.'), 
	(N'S-1-5-21-domain-515', N'Domain Computers', N'A global group that includes all clients and servers that have joined the domain.'), 
	(N'S-1-5-21-domain-516', N'Domain Controllers', N'A global group that includes all domain controllers in the domain. New domain controllers are added to this group by default.'), 
	(N'S-1-5-21-domain-517', N'Cert Publishers', N'A global group that includes all computers that are running an enterprise certification authority. Cert Publishers are authorized to publish certificates for User objects in Active Directory.'), 
	(N'S-1-5-21-root domain-518', N'Schema Admins', N'A universal group in a native-mode domain; a global group in a mixed-mode domain. The group is authorized to make schema changes in Active Directory. By default, the only member of the group is the Administrator account for the forest root domain.'), 
	(N'S-1-5-21-root domain-519', N'Enterprise Admins', N'A universal group in a native-mode domain; a global group in a mixed-mode domain. The group is authorized to make forest-wide changes in Active Directory, such as adding child domains. By default, the only member of the group is the Administrator account for the forest root domain.'), 
	(N'S-1-5-21-domain-520', N'Group Policy Creator Owners', N'A global group that is authorized to create new Group Policy objects in Active Directory. By default, the only member of the group is Administrator.'), 
	(N'S-1-5-21-domain-553', N'RAS and IAS Servers', N'A domain local group. By default, this group has no members. Servers in this group have Read Account Restrictions and Read Logon Information access to User objects in the Active Directory domain local group. '), 
	(N'S-1-5-32-544', N'Administrators', N'A built-in group. After the initial installation of the operating system, the only member of the group is the Administrator account. When a computer joins a domain, the Domain Admins group is added to the Administrators group. When a server becomes a domain controller, the Enterprise Admins group also is added to the Administrators group.'), 
	(N'S-1-5-32-545', N'Users', N'A built-in group. After the initial installation of the operating system, the only member is the Authenticated Users group. When a computer joins a domain, the Domain Users group is added to the Users group on the computer.'), 
	(N'S-1-5-32-546', N'Guests', N'A built-in group. By default, the only member is the Guest account. The Guests group allows occasional or one-time users to log on with limited privileges to a computer''s built-in Guest account.'), 
	(N'S-1-5-32-547', N'Power Users', N'A built-in group. By default, the group has no members. Power users can create local users and groups; modify and delete accounts that they have created; remove users from the Power Users, Users, and Guests groups. Power users also can install programs; create, manage and delete local printers; and create and delete file shares.'), 
	(N'S-1-5-32-548', N'Account Operators', N'A built-in group that exists only on domain controllers. By default, the group has no members. By default, Account Operators have permission to create, modify, and delete accounts for users, groups, and computers in all containers and organizational units of Active Directory except the Builtin container and the Domain Controllers OU. Account Operators do not have permission to modify the Administrators and Domain Admins groups, nor modify the accounts for members of those groups.'), 
	(N'S-1-5-32-549', N'Server Operators', N'A built-in group that exists only on domain controllers. By default, the group has no members. Server Operators can log on to a server interactively; create and delete network shares; start and stop services; back up and restore files; format the hard disk of the computer; and shut down the computer.'), 
	(N'S-1-5-32-550', N'Print Operators', N'A built-in group that exists only on domain controllers. By default, the only member is the Domain Users group. Print Operators can manage printers and document queues.'), 
	(N'S-1-5-32-551', N'Backup Operators', N'A built-in group. By default, the group has no members. Backup Operators can back up and restore all files on a computer, regardless of the permissions that protect those files. Backup Operators also can log on to the computer and shut it down.'), 
	(N'S-1-5-32-552', N'Replicators', N'A built-in group that is used by the File Replication service on domain controllers. By default, the group has no members. Do not add users to this group.'), 
	(N'S-1-5-64-10', N'NTLM Authentication ', N'A SID that is used when the NTLM authentication package authenticated the client '), 
	(N'S-1-5-64-14', N'SChannel Authentication ', N'A SID that is used when the SChannel authentication package authenticated the client. '), 
	(N'S-1-5-64-21', N'Digest Authentication ', N'A SID that is used when the Digest authentication package authenticated the client. '), 
	(N'S-1-5-80', N'NT Service ', N'An NT Service account prefix'), 
	(N'S-1-5-80-0', N'NT SERVICES\ALL SERVICES', N'A group that includes all service processes that are configured on the system. Membership is controlled by the operating system.'), 
	(N'S-1-5-83-0', N'NT VIRTUAL MACHINE\Virtual Machines', N'A built-in group. The group is created when the Hyper-V role is installed. Membership in the group is maintained by the Hyper-V Management Service (VMMS). This group requires the "Create Symbolic Links" right (SeCreateSymbolicLinkPrivilege), and also the "Log on as a Service" right (SeServiceLogonRight). '), 
	(N'S-1-16-0', N'Untrusted Mandatory Level ', N'An untrusted integrity level. Note Added in Windows Vista and Windows Server 2008 '), 
	(N'S-1-16-4096', N'Low Mandatory Level ', N'A low integrity level. '), 
	(N'S-1-16-8192', N'Medium Mandatory Level ', N'A medium integrity level. '), 
	(N'S-1-16-8448', N'Medium Plus Mandatory Level ', N'A medium plus integrity level. '), 
	(N'S-1-16-12288', N'High Mandatory Level ', N'A high integrity level. '), 
	(N'S-1-16-16384', N'System Mandatory Level ', N'A system integrity level. '), 
	(N'S-1-16-20480', N'Protected Process Mandatory Level ', N'A protected-process integrity level. '), 
	(N'S-1-16-28672', N'Secure Process Mandatory Level ', N'A secure process integrity level. '), 
	(N'S-1-5-32-554', N'BUILTIN\Pre-Windows 2000 Compatible Access', N'An alias added by Windows 2000. A backward compatibility group which allows read access on all users and groups in the domain. '), 
	(N'S-1-5-32-555', N'BUILTIN\Remote Desktop Users', N'An alias. Members in this group are granted the right to logon remotely. '), 
	(N'S-1-5-32-556', N'BUILTIN\Network Configuration Operators', N'An alias. Members in this group can have some administrative privileges to manage configuration of networking features. '), 
	(N'S-1-5-32-557', N'BUILTIN\Incoming Forest Trust Builders', N'An alias. Members of this group can create incoming, one-way trusts to this forest. '), 
	(N'S-1-5-32-558', N'BUILTIN\Performance Monitor Users', N'An alias. Members of this group have remote access to monitor this computer. '), 
	(N'S-1-5-32-559', N'BUILTIN\Performance Log Users', N'An alias. Members of this group have remote access to schedule logging of performance counters on this computer. '), 
	(N'S-1-5-32-560', N'BUILTIN\Windows Authorization Access Group', N'An alias. Members of this group have access to the computed tokenGroupsGlobalAndUniversal attribute on User objects. '), 
	(N'S-1-5-32-561', N'BUILTIN\Terminal Server License Servers', N'An alias. A group for Terminal Server License Servers. When Windows Server 2003 Service Pack 1 is installed, a new local group is created.'), 
	(N'S-1-5-32-562', N'BUILTIN\Distributed COM Users', N'An alias. A group for COM to provide computerwide access controls that govern access to all call, activation, or launch requests on the computer.'), 
	(N'S-1-5-21-domain-498', N'Enterprise Read-only Domain Controllers ', N'A Universal group. Members of this group are Read-Only Domain Controllers in the enterprise '), 
	(N'S-1-5-21-domain-521', N'Read-only Domain Controllers', N'A Global group. Members of this group are Read-Only Domain Controllers in the domain'), 
	(N'S-1-5-32-569', N'BUILTIN\Cryptographic Operators', N'A Builtin Local group. Members are authorized to perform cryptographic operations.'), 
	(N'S-1-5-21-domain-571', N'Allowed RODC Password Replication Group ', N'A Domain Local group. Members in this group can have their passwords replicated to all read-only domain controllers in the domain. '), 
	(N'S-1-5-21-domain-572', N'Denied RODC Password Replication Group ', N'A Domain Local group. Members in this group cannot have their passwords replicated to any read-only domain controllers in the domain '), 
	(N'S-1-5-32-573', N'BUILTIN\Event Log Readers ', N'A Builtin Local group. Members of this group can read event logs from local machine. '), 
	(N'S-1-5-32-574', N'BUILTIN\Certificate Service DCOM Access ', N'A Builtin Local group. Members of this group are allowed to connect to Certification Authorities in the enterprise. '), 
	(N'S-1-5-21-domain-522', N'Cloneable Domain Controllers', N'A Global group. Members of this group that are domain controllers may be cloned.'), 
	(N'S-1-5-32-575', N'BUILTIN\RDS Remote Access Servers', N'A Builtin Local group. Servers in this group enable users of RemoteApp programs and personal virtual desktops access to these resources. In Internet-facing deployments, these servers are typically deployed in an edge network. This group needs to be populated on servers running RD Connection Broker. RD Gateway servers and RD Web Access servers used in the deployment need to be in this group.'), 
	(N'S-1-5-32-576', N'BUILTIN\RDS Endpoint Servers', N'A Builtin Local group. Servers in this group run virtual machines and host sessions where users RemoteApp programs and personal virtual desktops run. This group needs to be populated on servers running RD Connection Broker. RD Session Host servers and RD Virtualization Host servers used in the deployment need to be in this group.'), 
	(N'S-1-5-32-577', N'BUILTIN\RDS Management Servers', N'A Builtin Local group. Servers in this group can perform routine administrative actions on servers running Remote Desktop Services. This group needs to be populated on all servers in a Remote Desktop Services deployment. The servers running the RDS Central Management service must be included in this group.'), 
	(N'S-1-5-32-578', N'BUILTIN\Hyper-V Administrators', N'A Builtin Local group. Members of this group have complete and unrestricted access to all features of Hyper-V.'), 
	(N'S-1-5-32-579', N'BUILTIN\Access Control Assistance Operators', N'A Builtin Local group. Members of this group can remotely query authorization attributes and permissions for resources on this computer.'), 
	(N'S-1-5-32-580', N'BUILTIN\Remote Management Users', N'A Builtin Local group. Members of this group can access WMI resources over management protocols (such as WS-Management via the Windows Remote Management service). This applies only to WMI namespaces that grant access to the user.');
END
GO

GO
PRINT N'Update complete.';


GO
