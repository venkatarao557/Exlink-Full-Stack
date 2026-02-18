/* DEVOPS READY DATA MIGRATION: Table [CertificateReason] (E28)
   - Idempotent: Safe for multiple runs.
   - Integrity: Synchronizes ReasonCode and Description.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [CertificateReason] (E28)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[CertificateReason]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table for staging
        CREATE TABLE #StagingCertReason (
            [Code] NVARCHAR(10),
            [Desc] NVARCHAR(150)
        );

        INSERT INTO #StagingCertReason ([Code], [Desc])
        VALUES 
        ('9',  'Cert Request'),
        ('98', 'Cert Request Acknowledgement'),
        ('99', 'Remote Print Acknowledgement');

        -- Use MERGE to ensure idempotency (Update if exists, Insert if new)
        MERGE INTO [dbo].[CertificateReason] AS target
        USING #StagingCertReason AS src
        ON (target.[ReasonCode] = src.[Code])
        WHEN MATCHED THEN
            UPDATE SET target.[Description] = src.[Desc]
        WHEN NOT MATCHED THEN
            INSERT ([ReasonCode], [Description])
            VALUES (src.[Code], src.[Desc]);

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [CertificateReason].';
        
        DROP TABLE #StagingCertReason;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[CertificateReason] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [CertificateReason] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO