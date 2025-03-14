/****** Object:  StoredProcedure [dbo].[uspCopyActivityDataADLS] ******/
CREATE PROCEDURE [dbo].[uspCopyActivityDataADLS]
AS
BEGIN
DECLARE @Counter INT = 1
DECLARE @RowCount INT
DECLARE @SQLData NVARCHAR(MAX)
DECLARE @SQLQuery VARCHAR (MAX)
SET @RowCount = (SELECT COUNT(1) FROM [dbo].[CopyActivityDataADLS_Staging])

DROP TABLE IF EXISTS #CopyActivityDataADLS_Staging
SELECT ROW_NUMBER() OVER(ORDER BY [SQL Script To Merge] ASC) AS ID
,[SQL Script To Merge]
INTO #CopyActivityDataADLS_Staging
FROM 
[dbo].[CopyActivityDataADLS_Staging]

WHILE (@Counter <= @RowCount)
BEGIN
SET @SQLData = (SELECT STUFF([SQL Script To Merge],LEN([SQL Script To Merge]),1,'') FROM #CopyActivityDataADLS_Staging WHERE ID = @Counter)
SET @SQLQuery = N'
SET IDENTITY_INSERT dbo.CopyActivityDataADLS ON;

MERGE dbo.CopyActivityDataADLS AS t
  USING (
  VALUES 
  '+@SQLData+'
  ) as  s
		(   [CopyActivityDataADLSKey]
		   ,[CopyActivityDataADLSName]
           ,[CopyActivityDataADLSFolderPath]
           ,[CopyActivityDataADLSFileName]
           ,[IsActive]
           ,[LastRunDate]
           ,[CreateDate]
           ,[ModifiedDate]
           ,[ModifiedUser]
		   ,[CopyActivityDataADLSContainerName])
ON ( t.[CopyActivityDataADLSKey] = s.[CopyActivityDataADLSKey] )
WHEN MATCHED THEN 
	UPDATE SET   
		   [CopyActivityDataADLSName] = s.[CopyActivityDataADLSName]
           ,[CopyActivityDataADLSFolderPath] = s.[CopyActivityDataADLSFolderPath]
           ,[CopyActivityDataADLSFileName] = s.[CopyActivityDataADLSFileName]
           ,[IsActive] =s.[IsActive]
           ,[LastRunDate] = s.[LastRunDate]
           ,[CreateDate] = s.[CreateDate]
           ,[ModifiedDate] = s.[ModifiedDate]
           ,[ModifiedUser] = s.[ModifiedUser]
		   ,[CopyActivityDataADLSContainerName] = s.[CopyActivityDataADLSContainerName]
WHEN NOT MATCHED BY TARGET THEN
    INSERT(
			[CopyActivityDataADLSKey]
		   ,[CopyActivityDataADLSName]
           ,[CopyActivityDataADLSFolderPath]
           ,[CopyActivityDataADLSFileName]
           ,[IsActive]
           ,[LastRunDate]
           ,[CreateDate]
           ,[ModifiedDate]
           ,[ModifiedUser]
		   ,[CopyActivityDataADLSContainerName]
		  )	
    VALUES(
			 s.[CopyActivityDataADLSKey]
		   ,s.[CopyActivityDataADLSName]
           ,s.[CopyActivityDataADLSFolderPath]
           ,s.[CopyActivityDataADLSFileName]
           ,s.[IsActive]
           ,s.[LastRunDate]
           ,s.[CreateDate]
           ,s.[ModifiedDate]
           ,s.[ModifiedUser]
		   ,s.[CopyActivityDataADLSContainerName]
		  );
SET IDENTITY_INSERT dbo.CopyActivityDataADLS OFF;'
PRINT @SQLQUery
EXEC (@SQLQuery)
SET @Counter = @Counter + 1
END

END
GO
