/* DEVOPS READY DATA MIGRATION: Table [ProductUseIndicator] (E32)
   - Idempotent: Safe for multiple runs.
   - Integrity: Synchronizes ProductUseCode and Description.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [ProductUseIndicator] (E32)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[ProductUseIndicator]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table for staging records from E32.txt
        CREATE TABLE #StagingProductUse (
            [Code] NVARCHAR(10),
            [Desc] NVARCHAR(150)
        );

        INSERT INTO #StagingProductUse ([Code], [Desc])
        VALUES 
        ('H', 'Human Consumption'),
        ('A', 'Animal Feeding Stuff'),
        ('F', 'Further Process'),
        ('T', 'Technical Use'),
        ('O', 'Other');

        -- Use MERGE to ensure idempotency (Update if exists, Insert if new)
        MERGE INTO [dbo].[ProductUseIndicator] AS target
        USING #StagingProductUse AS src
        ON (target.[ProductUseCode] = src.[Code])
        WHEN MATCHED THEN
            UPDATE SET target.[Description] = src.[Desc]
        WHEN NOT MATCHED THEN
            INSERT ([ProductUseCode], [Description])
            VALUES (src.[Code], src.[Desc]);

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [ProductUseIndicator].';
        
        DROP TABLE #StagingProductUse;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[ProductUseIndicator] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [ProductUseIndicator] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO