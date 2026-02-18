/* DEVOPS READY DATA MIGRATION: Table [WeightUnitShort] (E12)
   - Idempotent: Safe for multiple runs.
   - Integrity: Synchronizes WeightUnitCode and Description.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [WeightUnitShort] (E12)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[WeightUnitShort]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table to hold all records from E12.txt
        CREATE TABLE #StagingWeightShort (
            [Code] NVARCHAR(10),
            [Desc] NVARCHAR(100)
        );

        INSERT INTO #StagingWeightShort ([Code], [Desc])
        VALUES 
        ('CWI', 'HUNDRED WEIGHT(UK)'),
        ('LBR', 'POUND'),
        ('LTN', 'TON(UK) OR LONGTON(US)'),
        ('ONZ', 'OUNCE'),
        ('STI', 'STONE(UK)'),
        ('STN', 'TON (US) OR SHORT TON(UK/US)');

        -- Use MERGE to ensure idempotency (Update if exists, Insert if new)
        MERGE INTO [dbo].[WeightUnitShort] AS target
        USING #StagingWeightShort AS src
        ON (target.[WeightUnitCode] = src.[Code])
        WHEN MATCHED THEN
            UPDATE SET target.[Description] = src.[Desc]
        WHEN NOT MATCHED THEN
            INSERT ([WeightUnitCode], [Description])
            VALUES (src.[Code], src.[Desc]);

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [WeightUnitShort].';
        
        DROP TABLE #StagingWeightShort;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[WeightUnitShort] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [WeightUnitShort] completed.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO