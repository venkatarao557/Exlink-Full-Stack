/* DEVOPS READY DATA MIGRATION: Table [WeightUnitAlternate] (E15)
   - Idempotent: Safe for multiple runs.
   - Integrity: Synchronizes WeightUnitCode and Description.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [WeightUnitAlternate] (E15)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[WeightUnitAlternate]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table to hold all records from E15.txt
        CREATE TABLE #StagingWeightAlt (
            [Code] NVARCHAR(10),
            [Desc] NVARCHAR(150)
        );

        INSERT INTO #StagingWeightAlt ([Code], [Desc])
        VALUES 
        ('CGM', 'CENTIGRAM'),
        ('CMK', 'CM²'),
        ('CU',  'CUBIC METRE'),
        ('DTN', 'DECITONNE'),
        ('GRM', 'GRAM'),
        ('GRN', 'GRAIN'),
        ('HGM', 'HECTOGRAM'),
        ('JCM', 'JAS CBM'),
        ('KGM', 'KILOGRAM'),
        ('KTN', 'KILOTONNE'),
        ('MGM', 'MILLIGRAM'),
        ('MT',  'M/TONS'),
        ('MTK', 'METRIC TONNES OF 1,000 KILOS EACH'),
        ('MTN', 'METRIC TONS'),
        ('MTO', 'METRIC TON'),
        ('MTS', 'M/TS'),
        ('NO',  'NUMBER'),
        ('SM',  'SQUARE METRE'),
        ('SS',  'STEMS'),
        ('TN',  'TONNES'),
        ('TNE', 'TONNE (METRIC TONNE)');

        -- Use MERGE to ensure idempotency (Update if exists, Insert if new)
        MERGE INTO [dbo].[WeightUnitAlternate] AS target
        USING #StagingWeightAlt AS src
        ON (target.[WeightUnitCode] = src.[Code])
        WHEN MATCHED THEN
            UPDATE SET target.[Description] = src.[Desc]
        WHEN NOT MATCHED THEN
            INSERT ([WeightUnitCode], [Description])
            VALUES (src.[Code], src.[Desc]);

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [WeightUnitAlternate].';
        
        DROP TABLE #StagingWeightAlt;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[WeightUnitAlternate] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [WeightUnitAlternate] completed.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO