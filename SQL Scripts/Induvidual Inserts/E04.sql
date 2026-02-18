/* DEVOPS READY DATA MIGRATION: Table [Commodity] (E04)
   - Idempotent: Can be run multiple times without error.
   - Integrity: Checks for existing CommodityCodes before insertion.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [Commodity]...';

BEGIN TRANSACTION;
BEGIN TRY
    -- Check if the Commodity table exists from the schema
    IF OBJECT_ID('[dbo].[Commodity]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table to hold flat file data from E04.txt
        CREATE TABLE #NewCommodities (
            [Code] NVARCHAR(5),
            [Name] NVARCHAR(100)
        );

        INSERT INTO #NewCommodities ([Code], [Name])
        VALUES 
        ('A', 'HONEY'),
        ('D', 'DAIRY'),
        ('E', 'EGGS'),
        ('F', 'FISH'),
        ('G', 'GRAINS & SEEDS'),
        ('H', 'HORTICULTURE'),
        ('I', 'INEDIBLE MEAT'),
        ('M', 'MEAT'),
        ('S', 'SKINS AND HIDES'),
        ('W', 'WOOL'),
        ('X', 'OTHER GOODS');

        -- Final Merge/Insert with anti-duplicate check
        INSERT INTO [dbo].[Commodity] ([CommodityCode], [CommodityName])
        SELECT TRIM(src.[Code]), TRIM(src.[Name])
        FROM #NewCommodities src
        WHERE NOT EXISTS (
            SELECT 1 FROM [dbo].[Commodity] target 
            WHERE target.[CommodityCode] = TRIM(src.[Code])
        );

        DECLARE @InsertedRows INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@InsertedRows AS VARCHAR(10)) + ' new records inserted into [Commodity].';
        
        DROP TABLE #NewCommodities;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[Commodity] does not exist. Please run schema script first.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [Commodity] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR in data migration: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO