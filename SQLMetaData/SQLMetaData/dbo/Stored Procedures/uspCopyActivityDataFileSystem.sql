/****** Object:  StoredProcedure [dbo].[uspCopyActivityDataFileSystem] ******/
CREATE PROCEDURE [dbo].[uspCopyActivityDataFileSystem]
AS
BEGIN
DECLARE @Counter INT = 1
DECLARE @RowCount INT
DECLARE @SQLData NVARCHAR(MAX)
DECLARE @SQLQuery VARCHAR (MAX)
SET @RowCount = (SELECT COUNT(1) FROM [dbo].[CopyActivityDataFileSystem_Staging])

DROP TABLE IF EXISTS #CopyActivityDataFileSystem_Staging
SELECT ROW_NUMBER() OVER(ORDER BY [SQL DATA SCRIPT] ASC) AS ID
,[SQL DATA SCRIPT]
INTO #CopyActivityDataFileSystem_Staging
FROM 
[dbo].[CopyActivityDataFileSystem_Staging]

WHILE (@Counter <= @RowCount)
BEGIN
SET @SQLData = (SELECT STUFF([SQL DATA SCRIPT],LEN([SQL DATA SCRIPT]),1,'') FROM #CopyActivityDataFileSystem_Staging WHERE ID = @Counter)
SET @SQLQuery = N'
SET IDENTITY_INSERT dbo.CopyActivityDataFileSystem ON;

MERGE dbo.CopyActivityDataFileSystem AS t
  USING (
  VALUES 
  '+@SQLData+'
  ) as  s
		(   [CopyActivityDataFileSystemKey]
		   ,[CopyActivityDataFileSystemName]
           ,[CopyActivityDataFileSystemFolderPath]
           ,[CopyActivityDataFileSystemFileName]
           ,[IsActive]
           ,[LastRunDate]
           ,[CreateDate]
           ,[ModifiedDate]
           ,[ModifiedUser]
		   ,[CopyActivityDataFileSystemContainerName])
ON ( t.[CopyActivityDataFileSystemKey] = s.[CopyActivityDataFileSystemKey] )
WHEN MATCHED THEN 
	UPDATE SET   
		   [CopyActivityDataFileSystemName] = s.[CopyActivityDataFileSystemName]
           ,[CopyActivityDataFileSystemFolderPath] = s.[CopyActivityDataFileSystemFolderPath]
           ,[CopyActivityDataFileSystemFileName] = s.[CopyActivityDataFileSystemFileName]
           ,[IsActive] = s.[IsActive]
           ,[LastRunDate] = s.[LastRunDate]
           ,[CreateDate] = s.[CreateDate]
           ,[ModifiedDate] = s.[ModifiedDate]
           ,[ModifiedUser] = s.[ModifiedUser]
		   ,[CopyActivityDataFileSystemContainerName] = s.[CopyActivityDataFileSystemContainerName]
WHEN NOT MATCHED BY TARGET THEN
    INSERT(
			[CopyActivityDataFileSystemKey]
		   ,[CopyActivityDataFileSystemName]
           ,[CopyActivityDataFileSystemFolderPath]
           ,[CopyActivityDataFileSystemFileName]
           ,[IsActive]
           ,[LastRunDate]
           ,[CreateDate]
           ,[ModifiedDate]
           ,[ModifiedUser]
		   ,[CopyActivityDataFileSystemContainerName]
		  )	
    VALUES(
			 s.[CopyActivityDataFileSystemKey]
		   ,s.[CopyActivityDataFileSystemName]
           ,s.[CopyActivityDataFileSystemFolderPath]
           ,s.[CopyActivityDataFileSystemFileName]
           ,s.[IsActive]
           ,s.[LastRunDate]
           ,s.[CreateDate]
           ,s.[ModifiedDate]
           ,s.[ModifiedUser]
		   ,s.[CopyActivityDataFileSystemContainerName]
		  );
SET IDENTITY_INSERT dbo.CopyActivityDataFileSystem OFF;'
EXEC (@SQLQuery)
SET @Counter = @Counter + 1
END
END
GO
