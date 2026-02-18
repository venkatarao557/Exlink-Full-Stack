/* DEVOPS READY DATA MIGRATION: Table [TransportMode] (E26)
   - Idempotent: Safe for multiple runs.
   - Integrity: Synchronizes TransportModeCode and Description.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [TransportMode] (E26)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[TransportMode]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table for staging records from E26.txt
        CREATE TABLE #StagingTransportMode (
            [Code] NVARCHAR(10),
            [Desc] NVARCHAR(150)
        );

        INSERT INTO #StagingTransportMode ([Code], [Desc])
        VALUES 
        ('1', 'SEA'),  -- 
        ('4', 'AIR'),  -- 
        ('5', 'MAIL'); -- 

        -- Use MERGE to ensure idempotency (Update if exists, Insert if new)
        MERGE INTO [dbo].[TransportMode] AS target
        USING #StagingTransportMode AS src
        ON (target.[TransportModeCode] = src.[Code])
        WHEN MATCHED THEN
            UPDATE SET target.[Description] = src.[Desc]
        WHEN NOT MATCHED THEN
            INSERT ([TransportModeCode], [Description])
            VALUES (src.[Code], src.[Desc]);

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [TransportMode].';
        
        DROP TABLE #StagingTransportMode;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[TransportMode] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [TransportMode] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO