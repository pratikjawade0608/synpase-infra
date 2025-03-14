/****** Object:  Table [dbo].[NotebookExecutionLog] ******/
CREATE TABLE [dbo].[NotebookExecutionLog](
	[NotebookExecutionLogKey] [bigint] IDENTITY(1,1) NOT NULL,
	[NotebookKey] [int] NULL,
	[PipelineTriggerID] [uniqueidentifier] NULL,
	[PipelineRunId] [uniqueidentifier] NULL,
	[DataFactoryName] [varchar](255) NOT NULL,
	[PipelineTriggerName] [varchar](255) NOT NULL,
	[PipelineTriggerType] [varchar](255) NOT NULL,
	[NotebookStartDate] [datetime] NOT NULL,
	[NotebookEndDate] [datetime] NULL,
	[NotebookStatus] [varchar](50) NOT NULL,
	[ParentPipelineExecutionLogKey] [bigint] NULL,
	[CurrentUser] [varchar](255) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PKnbel] PRIMARY KEY CLUSTERED 
(
	[NotebookExecutionLogKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
