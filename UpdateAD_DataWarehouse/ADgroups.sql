CREATE TABLE [dbo].[ADgroups](
[Name] [nvarchar](256) NULL,
[GroupCategory] [nvarchar](32) NULL,
[GroupScope] [nvarchar](32) NULL,
[Description] [nvarchar](512) NULL,
[EmailAddress] [nvarchar](256) NULL,
[ManagedBy] [nvarchar](256) NULL,
[DistinguishedName] [nvarchar](512) NULL,
[DisplayName] [nvarchar](128) NULL,
[Created] [datetime] NULL,
[Modified] [datetime] NULL,
[SamAccountName] [nvarchar](128) NULL,
[ObjectCategory] [nvarchar](128) NULL,
[ObjectClass] [nvarchar](64) NULL,
[SID] [nvarchar](128) NULL,
[ObjectGUID] [uniqueidentifier] NOT NULL,
CONSTRAINT [PK_GroupGUID] PRIMARY KEY CLUSTERED 
(
	[ObjectGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
