/****** Object:  Table [dbo].[NotebooksExcelSpreadSheets] ******/
CREATE TABLE [dbo].[NotebooksExcelSpreadSheets](
	[ID] [int] NOT NULL,
	[ExcelName] [nvarchar](50) NULL,
	[ExcelSpreadsheetName] [nvarchar](50) NULL,
	[IsActive] [int] NOT NULL,
 CONSTRAINT [PK_NotebooksExcelSpreadSheets] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
