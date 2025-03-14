/****** Object:  Table [dbo].[ContainerActivityType] ******/
CREATE TABLE [dbo].[ContainerActivityType](
	[ContainerActivityTypeKey] [int] IDENTITY(1,1) NOT NULL,
	[ContainerActivityTypeName] [varchar](20) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	CONSTRAINT [PKsgt] PRIMARY KEY CLUSTERED 
(
	[ContainerActivityTypeKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
