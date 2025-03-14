/****** Object:  Table [dbo].[CopyActivityParameter] ******/
CREATE TABLE [dbo].[CopyActivityParameter](
	[CopyActivitySinkKey] [int] NOT NULL,
	[CopyActivityParameterName] [varchar](255) NOT NULL,
	[CopyActivityParameterValue] [varchar](255) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_CopyActivityParameter] PRIMARY KEY CLUSTERED 
(
	[CopyActivitySinkKey] ASC,
	[CopyActivityParameterName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CopyActivityParameter]  WITH CHECK ADD  CONSTRAINT [FK_CopyActivityParameter_CopyActivitySinkkey] FOREIGN KEY([CopyActivitySinkKey])
REFERENCES [dbo].[CopyActivitySink] ([CopyActivitySinkKey])
GO
ALTER TABLE [dbo].[CopyActivityParameter] CHECK CONSTRAINT [FK_CopyActivityParameter_CopyActivitySinkkey]
GO
