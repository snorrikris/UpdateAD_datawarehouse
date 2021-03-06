﻿CREATE TABLE [dbo].[ADcontacts](
[GivenName] [nvarchar](128) NULL,
[Initials] [nvarchar](32) NULL,
[Surname] [nvarchar](256) NULL,
[DisplayName] [nvarchar](128) NULL,
[Description] [nvarchar](256) NULL,
[Office] [nvarchar](128) NULL,
[OfficePhone] [nvarchar](32) NULL,
[EmailAddress] [nvarchar](256) NULL,
[HomePage] [nvarchar](128) NULL,
[StreetAddress] [nvarchar](160) NULL,
[POBox] [nvarchar](32) NULL,
[City] [nvarchar](128) NULL,
[State] [nvarchar](64) NULL,
[PostalCode] [nvarchar](32) NULL,
[Country] [nvarchar](128) NULL,
[HomePhone] [nvarchar](32) NULL,
[Pager] [nvarchar](32) NULL,
[MobilePhone] [nvarchar](32) NULL,
[Fax] [nvarchar](128) NULL,
[Title] [nvarchar](128) NULL,
[Department] [nvarchar](128) NULL,
[Company] [nvarchar](128) NULL,
[Manager] [nvarchar](256) NULL,
[EmployeeID] [nvarchar](64) NULL,
[EmployeeNumber] [nvarchar](64) NULL,
[Division] [nvarchar](128) NULL,
[DistinguishedName] [nvarchar](512) NULL,
[Name] [nvarchar](256) NULL,
[CN] [nvarchar](256) NULL,
[Created] [datetime] NULL,
[Modified] [datetime] NULL,
[ObjectCategory] [nvarchar](128) NULL,
[ObjectClass] [nvarchar](64) NULL,
[ObjectGUID] [uniqueidentifier] NOT NULL,
CONSTRAINT [PK_ContactGUID] PRIMARY KEY CLUSTERED 
(
	[ObjectGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
