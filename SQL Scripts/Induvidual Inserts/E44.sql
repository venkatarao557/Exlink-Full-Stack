/* DEVOPS READY DATA MIGRATION: Table [ProductPart] (E44)
   - Idempotent: Can be run multiple times without error.
   - Integrity: Checks for existing PartCode before insertion.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [ProductPart] (E44)...';

BEGIN TRANSACTION;
BEGIN TRY
    -- Check if the ProductPart table exists from the schema
    IF OBJECT_ID('[dbo].[ProductPart]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table to hold all records from E44.txt
        CREATE TABLE #NewParts (
            [Code] NVARCHAR(10),
            [Name] NVARCHAR(100)
        );

        INSERT INTO #NewParts ([Code], [Name])
        VALUES 
        ('0001', 'SEEDS'),
        ('0002', 'PLANTS'),
        ('0003', 'BULBS'),
        ('0004', 'TUBERS'),
        ('0005', 'MINITUBERS'),
        ('0006', 'RHIZOMES'),
        ('0007', 'STOLONS'),
        ('0008', 'CORMS'),
        ('0009', 'BUDWOOD'),
        ('0010', 'CUTTINGS'),
        ('0011', 'POLLEN'),
        ('0012', 'BUDS'),
        ('0013', 'PLANTLETS'),
        ('0014', 'GRAIN'),
        ('0015', 'FLOWERS'),
        ('0016', 'FOLIAGE'),
        ('0017', 'BRANCHES'),
        ('0018', 'FRUITS'),
        ('0019', 'VEGETABLES'),
        ('0020', 'WOOD'),
        ('0021', 'WOOD PACKAGING MATERIAL'),
        ('0022', 'BARREL'),
        ('0023', 'FIREWOOD'),
        ('0024', 'BARK'),
        ('0025', 'SOIL'),
        ('0026', 'PEAT'),
        ('0027', 'MACHINERY');

        -- Final Insert with anti-duplicate check based on PartCode
        INSERT INTO [dbo].[ProductPart] ([PartCode], [PartName])
        SELECT 
            TRIM(src.[Code]), 
            TRIM(src.[Name])
        FROM #NewParts src
        WHERE NOT EXISTS (
            SELECT 1 FROM [dbo].[ProductPart] target 
            WHERE target.[PartCode] = TRIM(src.[Code])
        );

        DECLARE @InsertedRows INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@InsertedRows AS VARCHAR(10)) + ' records processed for [ProductPart].';
        
        DROP TABLE #NewParts;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[ProductPart] does not exist. Please run schema script first.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [ProductPart] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO