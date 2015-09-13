CREATE TABLE [dbo].[ADwell_known_sids](
[Name] [nvarchar](256) NULL,
[Description] [nvarchar](512) NULL,
[DistinguishedName] [nvarchar](512) NULL,
[DisplayName] [nvarchar](128) NULL,
[ObjectCategory] [nvarchar](128) NULL,
[ObjectClass] [nvarchar](64) NULL,
[SID] [nvarchar](128) NULL,
[ObjectGUID] [uniqueidentifier] NOT NULL,
CONSTRAINT [PK_WellKnownSIDsGUID] PRIMARY KEY CLUSTERED 
(
	[ObjectGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
