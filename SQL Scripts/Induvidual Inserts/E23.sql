/* DEVOPS READY DATA MIGRATION: Table [RfpComplianceStatus] (E23)
   - Idempotent: Safe for multiple runs.
   - Integrity: Synchronizes ComplianceStatusCode and Description.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [RfpComplianceStatus] (E23)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[RfpComplianceStatus]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table to hold all records from E23.txt
        CREATE TABLE #StagingRfpStatus (
            [Code] NVARCHAR(10),
            [Desc] NVARCHAR(150)
        );

        INSERT INTO #StagingRfpStatus ([Code], [Desc])
        VALUES 
        ('CANC', 'CANCEL'),
        ('COMP', 'COMPLETED'),
        ('EMHC', 'EMERGENCY HEALTH CERTIFICATE'),
        ('FINL', 'FINAL'),
        ('HCRD', 'HEALTH CERTIFICATE READY'),
        ('INIT', 'INITIAL'),
        ('INSP', 'INSPECTED'),
        ('ORDR', 'ORDER'),
        ('SUSP', 'SUSPENDED');

        -- Use MERGE to ensure idempotency (Update if exists, Insert if new)
        MERGE INTO [dbo].[RfpComplianceStatus] AS target
        USING #StagingRfpStatus AS src
        ON (target.[ComplianceStatusCode] = src.[Code])
        WHEN MATCHED THEN
            UPDATE SET target.[Description] = src.[Desc]
        WHEN NOT MATCHED THEN
            INSERT ([ComplianceStatusCode], [Description])
            VALUES (src.[Code], src.[Desc]);

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [RfpComplianceStatus].';
        
        DROP TABLE #StagingRfpStatus;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[RfpComplianceStatus] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [RfpComplianceStatus] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO