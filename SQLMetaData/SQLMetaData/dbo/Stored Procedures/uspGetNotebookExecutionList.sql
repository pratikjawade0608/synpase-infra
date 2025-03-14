/****** Object:  StoredProcedure [dbo].[uspGetNotebookExecutionList] ******/
CREATE PROCEDURE [dbo].[uspGetNotebookExecutionList]
(
	@NotebookExecutionGroupName		varchar(255)
	)
AS
BEGIN

	SET NOCOUNT ON

	SELECT	 p.NotebookName
			--,spp.NotebookParameterName
			--,spp.NotebookParameterValue
			--,spp2.NotebookParameterName as NotebookParameterName2
			--,spp2.NotebookParameterValue as NotebookParameterValue2
	--		,pep.IsRestart
	FROM	NotebookExecutionPlan pep
			INNER JOIN Notebook p ON
				p.NotebookKey = pep.NotebookKey
            INNER JOIN NotebookExecutionGroup peg ON
				pep.NotebookExecutionGroupKey = peg.NotebookExecutionGroupKey
			LEFT JOIN NotebookParameter spp ON
				p.NotebookKey = spp.NotebookKey AND
				spp.NotebookParameterName = 'numPartitions'  -- For now, we're just getting a single parameter for each stored procedure
		    LEFT JOIN NotebookParameter spp2 ON
				p.NotebookKey = spp2.NotebookKey AND
				spp2.NotebookParameterName = 'dropDuplicates'  -- For now, we're just getting a single parameter for each stored procedure
	
	WHERE 
			peg.NotebookExecutionGroupName = @NotebookExecutionGroupName 
			AND peg.IsActive = 1
			AND pep.IsActive = 1
			AND pep.IsRestart = 1 
	ORDER BY 
			pep.NotebookOrder

END
GO
