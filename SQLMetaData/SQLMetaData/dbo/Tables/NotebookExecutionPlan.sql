/****** Object:  Table [dbo].[NotebookExecutionPlan] ******/
CREATE TABLE [dbo].[NotebookExecutionPlan](
	[NotebookKey] [int] NOT NULL,
	[NotebookExecutionGroupKey] [int] NOT NULL,
	[DataFactoryKey] [int] NOT NULL,
	[ContainerExecutionGroupKey] [int] NOT NULL,
	[ContainerKey] [int] NOT NULL,
	[NotebookOrder] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsEmailEnabled] [bit] NOT NULL,
	[IsRestart] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PKnbep8] PRIMARY KEY CLUSTERED 
(
	[NotebookKey] ASC,
	[NotebookExecutionGroupKey] ASC,
	[NotebookOrder] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[NotebookExecutionPlan]  WITH CHECK ADD  CONSTRAINT [RefNotebook28] FOREIGN KEY([NotebookKey])
REFERENCES [dbo].[Notebook] ([NotebookKey])
GO
ALTER TABLE [dbo].[NotebookExecutionPlan] CHECK CONSTRAINT [RefNotebook28]
GO
ALTER TABLE [dbo].[NotebookExecutionPlan]  WITH CHECK ADD  CONSTRAINT [RefNotebookExecutionGroup29] FOREIGN KEY([NotebookExecutionGroupKey])
REFERENCES [dbo].[NotebookExecutionGroup] ([NotebookExecutionGroupKey])
GO
ALTER TABLE [dbo].[NotebookExecutionPlan] CHECK CONSTRAINT [RefNotebookExecutionGroup29]
GO
