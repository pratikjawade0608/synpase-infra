/****** Object:  StoredProcedure [dbo].[uspInsertContainer] ******/
CREATE   PROCEDURE [dbo].[uspInsertContainer]
 @ContainerName VARCHAR(255)
,@ContainerKey INT OUTPUT
AS
BEGIN
	DECLARE @tblContainerKey AS TABLE (ContainerKey INT);

	SELECT @ContainerKey = ContainerKey
	FROM dbo.Container
	WHERE ContainerName = @ContainerName;

	IF @ContainerKey IS NULL
	BEGIN
		INSERT dbo.Container (ContainerName
			,SystemKey
			,ContainerTypeKey
			,ContainerDate
			,ContainerCreatedBy
			,CreatedDate
			,ModifiedDate
		)
		OUTPUT INSERTED.ContainerKey INTO @tblContainerKey
		VALUES(@ContainerName,1,1,NULL,NULL,SYSDATETIME(),NULL);

		SELECT TOP 1 @ContainerKey = ContainerKey FROM @tblContainerKey;
	END
END
GO
