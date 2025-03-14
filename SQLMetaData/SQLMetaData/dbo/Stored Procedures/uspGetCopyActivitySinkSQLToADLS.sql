/****** Object:  StoredProcedure [dbo].[uspGetCopyActivitySinkSQLToADLS] ******/
CREATE PROCEDURE [dbo].[uspGetCopyActivitySinkSQLToADLS] 
(
	@CopyActivitySinkName		varchar(100)
)
AS
BEGIN

	SET NOCOUNT ON

	SELECT cas.[CopyActivitySinkName]
      ,cads.[CopyActivityDataSQLScriptName]
      ,cads.[CopyActivityDataSqlScript]
	    ,cadsadls.[CopyActivityDataADLSName]
	    ,cadsadls.[CopyActivityDataADLSContainerName]
      ,cadsadls.CopyActivityDataADLSFolderPath
	    ,cadsadls.[CopyActivityDataADLSFileName]
			,cap.[CopyActivityParameterValue] AS 'DBConnectionString'
    FROM CopyActivitySink cas
  INNER JOIN [dbo].[CopyActivityDataSQLScript] cads ON
  cads.[CopyActivityDataSQLScriptKey] = cas.CopyActivitySinkDataKey
  INNER JOIN [dbo].[CopyActivityDataType] cadstn ON
  cadstn.[CopyActivityDataTypeKey] = cas.CopyActivitySinkDataTypeKey
  INNER JOIN [dbo].[CopyActivityDataADLS] cadsadls ON
  cadsadls.CopyActivityDataADLSKey= cas.CopyActivitySinkDataTargetKey
  INNER JOIN [dbo].[CopyActivityDataType] cadstnt ON
  cadstnt.[CopyActivityDataTypeKey] = cas.CopyActivitySinkDataTargetTypeKey
	INNER JOIN [dbo].[CopyActivityParameter] cap
	ON cas.[CopyActivitySinkKey] = cap.[CopyActivitySinkKey]
  where cadstn.[CopyActivityDataTypeName] = 'SQL Server'
  and cadstnt.[CopyActivityDataTypeName] = 'Azure Data Lake Store'
	and cap.[CopyActivityParameterName] = 'dbConnectionSecret'
  and cas.CopyActivitySinkName = @CopyActivitySinkName

END
GO