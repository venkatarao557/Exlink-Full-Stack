/* DEVOPS READY DATA MIGRATION: Table [CertificateRequestStatus] (E31)
   - Idempotent: Safe for multiple runs.
   - Integrity: Synchronizes StatusCode and Description.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [CertificateRequestStatus] (E31)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[CertificateRequestStatus]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table for staging
        CREATE TABLE #StagingCertStatus (
            [Code] NVARCHAR(10),
            [Desc] NVARCHAR(255)
        );

        INSERT INTO #StagingCertStatus ([Code], [Desc])
        VALUES 
        ('A', 'The Certificate Request has been approved'),
        ('R', 'The Certificate Request is waiting to be reviewed by an AQIS Officer'),
        ('N', 'The Certificate Request has been rejected by an AQIS Officer');

        -- Use MERGE to ensure idempotency (Update if exists, Insert if new)
        MERGE INTO [dbo].[CertificateRequestStatus] AS target
        USING #StagingCertStatus AS src
        ON (target.[StatusCode] = src.[Code])
        WHEN MATCHED THEN
            UPDATE SET target.[Description] = src.[Desc]
        WHEN NOT MATCHED THEN
            INSERT ([StatusCode], [Description])
            VALUES (src.[Code], src.[Desc]);

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [CertificateRequestStatus].';
        
        DROP TABLE #StagingCertStatus;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[CertificateRequestStatus] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [CertificateRequestStatus] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO