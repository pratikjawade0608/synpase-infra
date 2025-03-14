/****** Object:  Table [dbo].[CopyActivityExcelSpreadSheets] ******/
CREATE TABLE [dbo].[CopyActivityExcelSpreadSheets](
	[ID] [int] NOT NULL,
	[ExcelName] [nvarchar](50) NULL,
	[ExcelSpreadsheetName] [nvarchar](50) NULL,
	[IsActive] [int] NOT NULL,
 CONSTRAINT [PK_ExcelSpreadSheets] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
