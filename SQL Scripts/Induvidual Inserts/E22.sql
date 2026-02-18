/* DEVOPS READY DATA MIGRATION: Table [QualityQualifier] (E22)
   - Idempotent: Safe for multiple runs.
   - Integrity: Synchronizes QualityCode and Description.
   - Note: Source file E22.txt currently contains no data records.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [QualityQualifier] (E22)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[QualityQualifier]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table for staging records
        CREATE TABLE #StagingQuality (
            [Code] NVARCHAR(10),
            [Desc] NVARCHAR(150)
        );

        /* INSERT INTO #StagingQuality ([Code], [Desc])
           VALUES 
           ('EXAMPLE', 'Example Description'); 
        */

        -- Use MERGE to ensure idempotency (Update if exists, Insert if new)
        MERGE INTO [dbo].[QualityQualifier] AS target
        USING #StagingQuality AS src
        ON (target.[QualityCode] = src.[Code])
        WHEN MATCHED THEN
            UPDATE SET target.[Description] = src.[Desc]
        WHEN NOT MATCHED THEN
            INSERT ([QualityCode], [Description])
            VALUES (src.[Code], src.[Desc]);

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [QualityQualifier].';
        
        DROP TABLE #StagingQuality;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[QualityQualifier] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [QualityQualifier] completed.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO