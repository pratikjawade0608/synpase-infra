/****** Object:  Table [dbo].[ContainerType] ******/
CREATE TABLE [dbo].[ContainerType](
	[ContainerTypeKey] [int] IDENTITY(1,1) NOT NULL,
	[ContainerTypeName] [varchar](255) NOT NULL,
	[ContainerTypeDate] [datetime] NULL,
	[ContainerTypeCreatedBy] [varchar](255) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	CONSTRAINT [PKcg] PRIMARY KEY CLUSTERED 
(
	[ContainerTypeKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
