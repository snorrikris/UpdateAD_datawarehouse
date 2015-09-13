CREATE TABLE [dbo].[ADgroup_members](
[GroupGUID] [uniqueidentifier] NOT NULL,
[MemberGUID] [uniqueidentifier] NOT NULL,
[MemberType] [nvarchar](64) NOT NULL,
[GroupDistinguishedName] [nvarchar](512) NULL,
[MemberDistinguishedName] [nvarchar](512) NULL,
CONSTRAINT [PK_GroupMemberGUIDs] PRIMARY KEY CLUSTERED 
(
	[GroupGUID] ASC, [MemberGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
