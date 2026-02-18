/* DEVOPS READY DATA MIGRATION: Table [ProcessType] (E20)
   - Idempotent: Safe for multiple runs.
   - Integrity: Synchronizes ProcessTypeCode and Description.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [ProcessType] (E20)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[ProcessType]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table for staging
        CREATE TABLE #StagingProcessType (
            [Code] NVARCHAR(10),
            [Desc] NVARCHAR(255)
        );

        INSERT INTO #StagingProcessType ([Code], [Desc])
        VALUES 
        ('AQ', 'AQUACULTURE FARM'),
        ('CT', 'CATCHER VESSEL'),
        ('FF', 'FISHING AND FACTORY VESSEL'),
        ('FR', 'FREEZING'),
        ('FV', 'FISHING VESSEL'),
        ('IR', 'INDEPENDENT COLD STORE RAW MATERIAL'),
        ('LO', 'LOADOUT'),
        ('PC', 'PROCESSING'),
        ('PK', 'PACKING'),
        ('SL', 'SLAUGHTER'),
        ('ST', 'STORAGE'),
        ('TV', 'TRANSPORT FISHING VESSEL');

        -- Use MERGE to ensure idempotency (Update if exists, Insert if new)
        MERGE INTO [dbo].[ProcessType] AS target
        USING #StagingProcessType AS src
        ON (target.[ProcessTypeCode] = src.[Code])
        WHEN MATCHED THEN
            UPDATE SET target.[ProcessTypeDescription] = src.[Desc]
        WHEN NOT MATCHED THEN
            INSERT ([ProcessTypeCode], [ProcessTypeDescription])
            VALUES (src.[Code], src.[Desc]);

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [ProcessType].';
        
        DROP TABLE #StagingProcessType;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[ProcessType] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [ProcessType] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO