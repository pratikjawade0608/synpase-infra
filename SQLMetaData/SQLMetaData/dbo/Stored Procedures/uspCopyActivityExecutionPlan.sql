/****** Object:  StoredProcedure [dbo].[uspCopyActivityExecutionPlan] ******/
CREATE PROCEDURE [dbo].[uspCopyActivityExecutionPlan]
AS
BEGIN
DECLARE @Counter INT = 1
DECLARE @RowCount INT
DECLARE @SQLData NVARCHAR(MAX)
DECLARE @SQLQuery VARCHAR (MAX)
SET @RowCount = (SELECT COUNT(1) FROM [dbo].[CopyActivityExecutionPlan_Staging])

DROP TABLE IF EXISTS #CopyActivityExecutionPlan_Staging
SELECT ROW_NUMBER() OVER(ORDER BY [SQL Script to Merge] ASC) AS ID
,[SQL Script to Merge]
INTO #CopyActivityExecutionPlan_Staging
FROM 
[dbo].[CopyActivityExecutionPlan_Staging]

--DELETE FROM [dbo].[CopyActivityExecutionPlan]

WHILE (@Counter <= @RowCount)
BEGIN
SET @SQLData = (SELECT STUFF ([SQL Script to Merge],CHARINDEX('UNION ALL',[SQL Script to Merge]),10,'') FROM #CopyActivityExecutionPlan_Staging WHERE ID = @Counter)  
SET @SQLQuery = N'  
MERGE dbo.CopyActivityExecutionPlan AS t
  USING (
  '+@SQLData+'
  ) as s
		(
			 CopyActivitySinkKey
			,ContainerKey
			,CopyActivityExecutionGroupKey
			,CopyActivityOrder
            ,IsActive
            ,IsEmailEnabled
            ,IsRestart
            ,CreatedDate
            ,ModifiedDate
		)
ON ( t.CopyActivitySinkKey = s.CopyActivitySinkKey AND t.ContainerKey=s.ContainerKey AND t.CopyActivityExecutionGroupKey=s.CopyActivityExecutionGroupKey)
WHEN MATCHED THEN 
	UPDATE SET   CopyActivityOrder = s.CopyActivityOrder
	            ,IsActive=s.IsActive
				,IsEmailEnabled=s.IsEmailEnabled
				,IsRestart=s.IsRestart
				,ModifiedDate = s.ModifiedDate
WHEN NOT MATCHED BY TARGET THEN
    INSERT(
			 CopyActivitySinkKey
			,ContainerKey
			,CopyActivityExecutionGroupKey
			,CopyActivityOrder
            ,IsActive
            ,IsEmailEnabled
            ,IsRestart
			,CreatedDate
			,ModifiedDate
		  )	
    VALUES(
			 s.CopyActivitySinkKey
			,s.ContainerKey
			,s.CopyActivityExecutionGroupKey
			,s.CopyActivityOrder
            ,s.IsActive
            ,s.IsEmailEnabled
            ,s.IsRestart
			,s.CreatedDate
			,s.ModifiedDate
		  );'
EXEC (@SQLQuery)
SET @Counter = @Counter + 1
END

END
GO
