/* DEVOPS READY DATA MIGRATION: Table [TreatmentConcentrationUnit] (E42)
   - Idempotent: Safe for multiple runs.
   - Integrity: Synchronizes UnitCode and Description.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [TreatmentConcentrationUnit] (E42)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[TreatmentConcentrationUnit]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table to hold all records from E42.txt
        CREATE TABLE #StagingConcentrationUnit (
            [Code] NVARCHAR(10),
            [Desc] NVARCHAR(150)
        );

        INSERT INTO #StagingConcentrationUnit ([Code], [Desc])
        VALUES 
        ('A93', 'GRAM PER CUBIC METRE'),
        ('A95', 'GRAY'),
        ('GE',  'LB/GAL (US)'),
        ('GL',  'GRAM PER LITRE'),
        ('GM',  'GRAM PER SQUARE METRE'),
        ('KMQ', 'KILOGRAM PER CUBIC METRE'),
        ('KX',  'MILLILITRE PER KILOGRAM');

        -- Use MERGE to ensure idempotency (Update if exists, Insert if new)
        MERGE INTO [dbo].[TreatmentConcentrationUnit] AS target
        USING #StagingConcentrationUnit AS src
        ON (target.[ConcentrationUnitCode] = src.[Code])
        WHEN MATCHED THEN
            UPDATE SET target.[ConcentrationUnitDescription] = src.[Desc]
        WHEN NOT MATCHED THEN
            INSERT ([ConcentrationUnitCode], [ConcentrationUnitDescription])
            VALUES (src.[Code], src.[Desc]);

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [TreatmentConcentrationUnit].';
        
        DROP TABLE #StagingConcentrationUnit;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[TreatmentConcentrationUnit] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [TreatmentConcentrationUnit] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO

