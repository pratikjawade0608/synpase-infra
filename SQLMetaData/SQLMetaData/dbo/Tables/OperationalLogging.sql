/****** Object:  Table [dbo].[OperationalLogging] ******/
CREATE TABLE [dbo].[OperationalLogging](
	[LogMessage] [nvarchar](max) NULL,
	[notebookPath] [nvarchar](max) NULL,
	[timestamp] [nvarchar](max) NULL,
	[notebookContext] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
