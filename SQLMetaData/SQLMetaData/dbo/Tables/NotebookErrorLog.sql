/****** Object:  Table [dbo].[NotebookErrorLog] ******/
CREATE TABLE [dbo].[NotebookErrorLog](
	[NotebookErrorLogKey] [bigint] IDENTITY(1,1) NOT NULL,
	[NotebookExecutionLogKey] [bigint] NOT NULL,
	[SourceName] [varchar](255) NOT NULL,
	[ErrorCode] [int] NULL,
	[ErrorDescription] [varchar](2000) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PKnberrorl] PRIMARY KEY CLUSTERED 
(
	[NotebookErrorLogKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[NotebookErrorLog]  WITH CHECK ADD  CONSTRAINT [RefNotebookErrorLog7] FOREIGN KEY([NotebookExecutionLogKey])
REFERENCES [dbo].[NotebookExecutionLog] ([NotebookExecutionLogKey])
GO
ALTER TABLE [dbo].[NotebookErrorLog] CHECK CONSTRAINT [RefNotebookErrorLog7]
GO
