/****** Object:  StoredProcedure [dbo].[uspInsertNotebook] ******/
CREATE PROCEDURE [dbo].[uspInsertNotebook]
 @NotebookName VARCHAR(255)
,@NotebookKey INT OUTPUT
AS
BEGIN
	DECLARE @tblNotebookKey AS TABLE (NotebookKey INT);

	SELECT @NotebookKey = NotebookKey
	FROM dbo.Notebook
	WHERE NotebookName = @NotebookName;

	IF @NotebookKey IS NULL
	BEGIN
		INSERT dbo.Notebook(NotebookName,CreatedDate)
		OUTPUT INSERTED.NotebookKey INTO @tblNotebookKey
		VALUES(@NotebookName,SYSDATETIME());

		SELECT TOP 1 @NotebookKey = NotebookKey FROM @tblNotebookKey;
	END
END
GO
