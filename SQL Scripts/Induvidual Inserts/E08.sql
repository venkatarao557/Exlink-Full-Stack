/* DEVOPS READY DATA MIGRATION: Table [DeclarationEstimateIndicator] (E08)
   - Idempotent: Safe for multiple runs.
   - Integrity: Synchronizes EstimateIndicatorCode and Description.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [DeclarationEstimateIndicator] (E08)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[DeclarationEstimateIndicator]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table for staging records from E08.txt
        CREATE TABLE #StagingEstimateIndicator (
            [Code] NVARCHAR(10),
            [Desc] NVARCHAR(150)
        );

        INSERT INTO #StagingEstimateIndicator ([Code], [Desc])
        VALUES 
        ('C', 'Confirming'),
        ('M', 'Multiline'),
        ('N', 'Non-Confirming');

        -- Use MERGE to ensure idempotency (Update if exists, Insert if new)
        MERGE INTO [dbo].[DeclarationEstimateIndicator] AS target
        USING #StagingEstimateIndicator AS src
        ON (target.[EstimateIndicatorCode] = src.[Code])
        WHEN MATCHED THEN
            UPDATE SET target.[Description] = src.[Desc]
        WHEN NOT MATCHED THEN
            INSERT ([EstimateIndicatorCode], [Description])
            VALUES (src.[Code], src.[Desc]);

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [DeclarationEstimateIndicator].';
        
        DROP TABLE #StagingEstimateIndicator;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[DeclarationEstimateIndicator] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [DeclarationEstimateIndicator] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO