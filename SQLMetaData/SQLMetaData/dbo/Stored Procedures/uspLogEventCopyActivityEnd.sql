/****** Object:  StoredProcedure [dbo].[uspLogEventCopyActivityEnd] ******/
CREATE PROCEDURE [dbo].[uspLogEventCopyActivityEnd] 

(    
	  @CopyActivityExecutionLogKey	bigint						--User::CopyActivityExecutionLogKey
    , @CopyActivityStatus			varchar(50)
	, @CopyActivitySinkName					varchar(255)
	, @CopyActivityExecutionGroupName varchar(255)
	, @CopyActivityDataRead				bigint
	, @CopyActivityDataWrite				bigint
	, @CopyActivityFilesRead				bigint
	, @CopyActivityFilesWrite				bigint
	, @CopyActivityRowsCopied				bigint
	, @CopyActivityRowsSkipped				bigint
	, @CopyActivityThroughput				float
	, @CopyActivityCopyDuration				int
	, @CopyActivityUsedCloudDataMovementUnits	int
	, @CopyActivityUsedParallelCopies int	
)
AS
BEGIN

	SET NOCOUNT ON
    
    UPDATE CopyActivityExecutionLog
	   SET CopyActivityStatus = @CopyActivityStatus,
		   CopyActivityDataRead = @CopyActivityDataRead,
		   CopyActivityDataWrite = @CopyActivityDataWrite,
		   CopyActivityFilesRead = @CopyActivityFilesRead,
		   CopyActivityFilesWrite = @CopyActivityFilesWrite,
		   CopyActivityRowsCopied = @CopyActivityRowsCopied,
		   CopyActivityRowsSkipped = @CopyActivityRowsSkipped,
		   CopyActivityThroughput = @CopyActivityThroughput,
		   CopyActivityCopyDuration = @CopyActivityCopyDuration,
		   CopyActivityUsedCloudDataMovementUnits = @CopyActivityUsedCloudDataMovementUnits,
		   CopyActivityUsedParallelCopies = @CopyActivityUsedParallelCopies,
		   CopyActivityEndDate = GetDate(),
		   ModifiedDate = GetDate()
     WHERE CopyActivityExecutionLogKey = @CopyActivityExecutionLogKey

	 IF(@CopyActivityStatus = 'SUCCEEDED')
		BEGIN
			UPDATE CopyActivityExecutionPlan
			SET IsRestart = 0 
			FROM	CopyActivityExecutionPlan pep
			INNER JOIN CopyActivitySink p ON
				p.CopyActivitySinkKey = pep.CopyActivitySinkKey
            INNER JOIN CopyActivityExecutionGroup peg ON
				pep.CopyActivityExecutionGroupKey = peg.CopyActivityExecutionGroupKey
			WHERE 
				peg.CopyActivityExecutionGroupName = @CopyActivityExecutionGroupName AND 
				p.CopyActivitySinkName = @CopyActivitySinkName AND
				peg.IsActive = 1 AND
				pep.IsRestart = 1
		END    
END
GO
