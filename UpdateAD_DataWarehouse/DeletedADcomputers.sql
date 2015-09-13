﻿CREATE TABLE [dbo].[DeletedADcomputers](
	[Name] [nvarchar](256) NULL,
	[DNSHostName] [nvarchar](128) NULL,
	[Description] [nvarchar](256) NULL,
	[Location] [nvarchar](128) NULL,
	[OperatingSystem] [nvarchar](64) NULL,
	[OperatingSystemVersion] [nvarchar](16) NULL,
	[OperatingSystemServicePack] [nvarchar](32) NULL,
	[ManagedBy] [nvarchar](256) NULL,
	[Enabled] [bit] NULL,
	[LockedOut] [bit] NULL,
	[MNSLogonAccount] [bit] NULL,
	[CannotChangePassword] [bit] NULL,
	[PasswordExpired] [bit] NULL,
	[PasswordNeverExpires] [bit] NULL,
	[PasswordNotRequired] [bit] NULL,
	[SmartcardLogonRequired] [bit] NULL,
	[DoesNotRequirePreAuth] [bit] NULL,
	[AllowReversiblePasswordEncryption] [bit] NULL,
	[AccountNotDelegated] [bit] NULL,
	[TrustedForDelegation] [bit] NULL,
	[TrustedToAuthForDelegation] [bit] NULL,
	[UseDESKeyOnly] [bit] NULL,
	[LastBadPasswordAttempt] [datetime] NULL,
	[BadLogonCount] [int] NULL,
	[LastLogonDate] [datetime] NULL,
	[logonCount] [int] NULL,
	[PasswordLastSet] [datetime] NULL,
	[AccountLockoutTime] [datetime] NULL,
	[AccountExpirationDate] [datetime] NULL,
	[Created] [datetime] NULL,
	[Modified] [datetime] NULL,
	[CN] [nvarchar](256) NULL,
	[DisplayName] [nvarchar](128) NULL,
	[DistinguishedName] [nvarchar](512) NULL,
	[PrimaryGroupID] [int] NULL,
	[SamAccountName] [nvarchar](128) NULL,
	[userAccountControl] [int] NULL,
	[ObjectCategory] [nvarchar](128) NULL,
	[ObjectClass] [nvarchar](64) NULL,
	[SID] [nvarchar](128) NOT NULL,
	[ObjectGUID] [uniqueidentifier] NOT NULL,
	[DeletedDate] datetime2 NOT NULL,
 CONSTRAINT [PK_DeletedComputerGUID] PRIMARY KEY CLUSTERED 
(
	[DeletedDate] ASC,
	[ObjectGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
