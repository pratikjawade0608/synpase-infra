/****** Object:  Table [dbo].[CopyActivityExecutionLog] ******/
CREATE TABLE [dbo].[CopyActivityExecutionLog](
	[CopyActivityExecutionLogKey] [bigint] IDENTITY(1,1) NOT NULL,
	[CopyActivityTriggerID] [uniqueidentifier] NOT NULL,
	[CopyActivitySinkKey] [int] NOT NULL,
	[MachineName] [varchar](255) NOT NULL,
	[UserName] [varchar](255) NOT NULL,
	[CopyActivityStartDate] [datetime] NOT NULL,
	[CopyActivityEndDate] [datetime] NULL,
	[CopyActivityStatus] [varchar](50) NOT NULL,
	[ParentCopyActivityExecutionLogKey] [bigint] NULL,
	[CopyActivityDataRead] [bigint] NULL,
	[CopyActivityDataWrite] [bigint] NULL,
	[CopyActivityFilesRead] [bigint] NULL,
	[CopyActivityFilesWrite] [bigint] NULL,
	[CopyActivityRowsCopied] [bigint] NULL,
	[CopyActivityRowsSkipped] [bigint] NULL,
	[CopyActivityThroughput] [float] NULL,
	[CopyActivityCopyDuration] [int] NULL,
	[CopyActivityUsedCloudDataMovementUnits] [int] NULL,
	[CopyActivityUsedParallelCopies] [int] NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PKcael] PRIMARY KEY CLUSTERED 
(
	[CopyActivityExecutionLogKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
