/* DEVOPS READY DATA MIGRATION: Table [CustomsWeightUnit] (E36)
   - Idempotent: Safe for multiple runs.
   - Integrity: Synchronizes WeightUnitCode and Description.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [CustomsWeightUnit] (E36)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[CustomsWeightUnit]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table to hold all records from E36.txt
        CREATE TABLE #StagingCustomsWeight (
            [Code] NVARCHAR(10),
            [Desc] NVARCHAR(150)
        );

        INSERT INTO #StagingCustomsWeight ([Code], [Desc])
        VALUES 
        ('GRM', 'GRAM'),
        ('KGM', 'KILOGRAM'),
        ('TNE', 'TONNE (METRIC TONNE)'),
        ('LBR', 'POUND'),
        ('STN', 'TON (US) OR SHORT TON(UK/US)'),
        ('LTN', 'TON(UK) OR LONGTON(US)');

        -- Use MERGE to ensure idempotency (Update if exists, Insert if new)
        MERGE INTO [dbo].[CustomsWeightUnit] AS target
        USING #StagingCustomsWeight AS src
        ON (target.[WeightUnitCode] = src.[Code])
        WHEN MATCHED THEN
            UPDATE SET target.[Description] = src.[Desc]
        WHEN NOT MATCHED THEN
            INSERT ([WeightUnitCode], [Description])
            VALUES (src.[Code], src.[Desc]);

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [CustomsWeightUnit].';
        
        DROP TABLE #StagingCustomsWeight;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[CustomsWeightUnit] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [CustomsWeightUnit] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO