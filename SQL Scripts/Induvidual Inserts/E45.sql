/* DEVOPS READY DATA MIGRATION: Table [IntendedUse] (E45)
   - Idempotent: Safe for multiple runs.
   - Integrity: Synchronizes IntendedUseCode and Description.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [IntendedUse] (E45)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[IntendedUse]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table for staging
        CREATE TABLE #StagingIntendedUse (
            [Code] NVARCHAR(10),
            [Desc] NVARCHAR(150)
        );

        INSERT INTO #StagingIntendedUse ([Code], [Desc])
        VALUES 
        ('0001', 'PLANTING'),
        ('0002', 'CONSUMPTION'),
        ('0003', 'PROCESSING'),
        ('0004', 'DECORATION'),
        ('0005', 'SPROUTING FOR CONSUMPTION'),
        ('0006', 'RESEARCH');

        -- Use MERGE to ensure idempotency (Update if exists, Insert if new)
        MERGE INTO [dbo].[IntendedUse] AS target
        USING #StagingIntendedUse AS src
        ON (target.[IntendedUseCode] = src.[Code])
        WHEN MATCHED THEN
            UPDATE SET target.[IntendedUseDescription] = src.[Desc]
        WHEN NOT MATCHED THEN
            INSERT ([IntendedUseCode], [IntendedUseDescription])
            VALUES (src.[Code], src.[Desc]);

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [IntendedUse].';
        
        DROP TABLE #StagingIntendedUse;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[IntendedUse] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [IntendedUse] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO