/* DEVOPS READY DATA MIGRATION: Table [CertificatePrintIndicator] (E11)
   - Idempotent: Safe for multiple runs.
   - Integrity: Synchronizes PrintIndicatorCode and Description.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [CertificatePrintIndicator] (E11)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[CertificatePrintIndicator]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table for staging records from E11.txt
        CREATE TABLE #StagingPrintIndicator (
            [Code] NVARCHAR(10),
            [Desc] NVARCHAR(150)
        );

        INSERT INTO #StagingPrintIndicator ([Code], [Desc])
        VALUES 
        ('A', 'Automatic'),        -- 
        ('C', 'Custom Certificate'), -- 
        ('M', 'Manual'),            -- 
        ('N', 'Not Required');      -- 

        -- Use MERGE to ensure idempotency (Update if exists, Insert if new)
        MERGE INTO [dbo].[CertificatePrintIndicator] AS target
        USING #StagingPrintIndicator AS src
        ON (target.[PrintIndicatorCode] = src.[Code])
        WHEN MATCHED THEN
            UPDATE SET target.[Description] = src.[Desc]
        WHEN NOT MATCHED THEN
            INSERT ([PrintIndicatorCode], [Description])
            VALUES (src.[Code], src.[Desc]);

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [CertificatePrintIndicator].';
        
        DROP TABLE #StagingPrintIndicator;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[CertificatePrintIndicator] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [CertificatePrintIndicator] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO