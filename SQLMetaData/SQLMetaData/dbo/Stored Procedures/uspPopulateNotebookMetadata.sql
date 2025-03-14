/****** Object:  StoredProcedure [dbo].[uspPopulateNotebookMetadata] ******/
CREATE PROCEDURE [dbo].[uspPopulateNotebookMetadata] ( @ExcelTabName NVARCHAR(20) ) 
AS 
  BEGIN 
    DECLARE @SQLQuery VARCHAR (max) 
    DECLARE @Counter  INT = 1 
    DECLARE @RowCount INT 	
    DECLARE @SQLData  NVARCHAR(max) 
	DECLARE @SqlVariables NVARCHAR (MAX) = N'
	DECLARE @ContainerExecutionGroupName VARCHAR(255) = ''IDW'';
	DECLARE @ContainerName varchar(255) = ''idw'';
	DECLARE @DataFactoryName VARCHAR(255) = ''TBD'';
	DECLARE @NotebookName varchar(100) = ''IDW_%'''
	IF (@ExcelTabName = 'Convert') 
    BEGIN 	  
	DECLARE @ConvertSubQuery NVARCHAR(MAX) = N'DECLARE @NotebookExecutionGroupName varchar(255) = @ContainerExecutionGroupName+'' Convert''
	SELECT @NotebookExecutionGroupName = @ContainerExecutionGroupName+'' Convert'';'
	  SET @RowCount = (SELECT COUNT(1) FROM [dbo].[Convert_Staging] WITH (NOLOCK))
      DROP TABLE IF EXISTS #convert_staging 
      SELECT   Row_number() OVER(ORDER BY [Convert] ASC) AS id, 
               [Convert] 
      INTO     #convert_staging 
      FROM     [dbo].[Convert_Staging] WITH (nolock) 
      WHILE (@Counter <= @RowCount) 
      BEGIN 
        SET @SQLData = 
		( 
               SELECT [Convert] 
               FROM   #convert_staging 
               WHERE  id = @Counter
		) 
		SET @SQLQuery = @SqlVariables + @ConvertSubQuery + @SQLData 
        EXEC (@SQLQuery) 
        SET @Counter = @Counter + 1 
      END 
    END 
    IF (@ExcelTabName = 'Ingest') 
    BEGIN 	  
	DECLARE @IngestSubQuery NVARCHAR(MAX) = N'DECLARE @NotebookExecutionGroupName varchar(255) = @ContainerExecutionGroupName+'' Convert''
	SELECT @NotebookExecutionGroupName = @ContainerExecutionGroupName+'' Ingest'';'
	  SET @RowCount = (SELECT COUNT(1) FROM [dbo].[Ingest_Staging] WITH (NOLOCK))
      DROP TABLE IF EXISTS #ingest_staging 
      SELECT   Row_number() OVER(ORDER BY [ExecutionScript] ASC) AS id, 
               [ExecutionScript] 
      INTO     #ingest_staging 
      FROM     [dbo].[Ingest_Staging] WITH (nolock) 
      WHILE (@Counter <= @RowCount) 
      BEGIN 
        SET @SQLData = 
		( 
               SELECT [ExecutionScript] 
               FROM   #ingest_staging 
               WHERE  id = @Counter
		) 
		SET @SQLQuery = @SqlVariables + @IngestSubQuery + @SQLData 
        EXEC (@SQLQuery) 
        SET @Counter = @Counter + 1 
      END 
    END 
	IF(@ExcelTabName = 'Enrich')
	BEGIN
	DECLARE @EnrichSubQuery NVARCHAR(MAX) = N'DECLARE @NotebookExecutionGroupName varchar(255) = @ContainerExecutionGroupName+'' Convert''
	SELECT @NotebookExecutionGroupName = @ContainerExecutionGroupName+'' Enrich'';'
	   SET @RowCount = (SELECT COUNT(1) FROM [dbo].[Enrich_Staging] WITH (NOLOCK))
      DROP TABLE IF EXISTS #Enrich_staging 
      SELECT   Row_number() OVER(ORDER BY [ExecutionScript] ASC) AS id, 
               [ExecutionScript] 
      INTO     #Enrich_staging 
      FROM     [dbo].[Enrich_Staging] WITH (nolock) 
      WHILE (@Counter <= @RowCount) 
      BEGIN 
        SET @SQLData = 
		( 
               SELECT [ExecutionScript] 
               FROM   #Enrich_staging 
               WHERE  id = @Counter
		) 
		SET @SQLQuery = @SqlVariables + @EnrichSubQuery + @SQLData
        EXEC (@SQLQuery) 
        SET @Counter = @Counter + 1 
      END 
	END
	IF(@ExcelTabName = 'Sanction')
	DECLARE @SanctionSubQuery NVARCHAR(MAX) = N'DECLARE @NotebookExecutionGroupName varchar(255) = @ContainerExecutionGroupName+'' Convert''
	SELECT @NotebookExecutionGroupName = @ContainerExecutionGroupName+'' Sanction'';'
	BEGIN
	   SET @RowCount = (SELECT COUNT(1) FROM [dbo].[Sanction_Staging] WITH (NOLOCK))
      DROP TABLE IF EXISTS #Sanction_staging 
      SELECT   Row_number() OVER(ORDER BY [ExecutionScript] ASC) AS id, 
               [ExecutionScript] 
      INTO     #Sanction_staging 
      FROM     [dbo].[Sanction_Staging] WITH (nolock) 
      WHILE (@Counter <= @RowCount) 
      BEGIN 
        SET @SQLData = 
		( 
               SELECT [ExecutionScript] 
               FROM   #Sanction_staging 
               WHERE  id = @Counter
		) 
		SET @SQLQuery = @SqlVariables+ @SanctionSubQuery + @SQLData
        EXEC (@SQLQuery) 
        SET @Counter = @Counter + 1 
      END 
	END
  END
GO
