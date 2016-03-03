CREATE TABLE [dbo].[ADusersPhotos](
[ObjectGUID] [uniqueidentifier] NOT NULL,
[Width] [int] NULL,
[Height] [int] NULL,
[Format] NVARCHAR(4) NULL, 
[Photo] [varbinary](max) NULL,
    CONSTRAINT [PK_ADusersPhotosGUIDs] PRIMARY KEY CLUSTERED 
(
	[ObjectGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
