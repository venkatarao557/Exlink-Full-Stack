/* DEVOPS READY DATA MIGRATION: Table [RfpReason] (E24)
   - Idempotent: Safe for multiple runs.
   - Integrity: Synchronizes ReasonCode and Description.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [RfpReason] (E24)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[RfpReason]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table to hold all records from E24.txt
        CREATE TABLE #StagingRfpReason (
            [Code] NVARCHAR(10),
            [Desc] NVARCHAR(150)
        );

        INSERT INTO #StagingRfpReason ([Code], [Desc])
        VALUES 
        ('1',  'Delete'),
        ('4',  'Amend'),
        ('5',  'Mini Amend'),
        ('7',  'Copy Advice'),
        ('11', 'RFP Acknowledgement'),
        ('13', 'Lodge'),
        ('16', 'Order'),
        ('18', 'Reissue'),
        ('31', 'Copy'),
        ('80', 'Forward Advice'),
        ('90', 'Transfer'),
        ('91', 'Transfer Advice'),
        ('92', 'Accept'),
        ('93', 'Accept Advice');

        -- Use MERGE to ensure idempotency (Update if exists, Insert if new)
        MERGE INTO [dbo].[RfpReason] AS target
        USING #StagingRfpReason AS src
        ON (target.[ReasonCode] = src.[Code])
        WHEN MATCHED THEN
            UPDATE SET target.[Description] = src.[Desc]
        WHEN NOT MATCHED THEN
            INSERT ([ReasonCode], [Description])
            VALUES (src.[Code], src.[Desc]);

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [RfpReason].';
        
        DROP TABLE #StagingRfpReason;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[RfpReason] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [RfpReason] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO