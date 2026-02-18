/* DEVOPS READY DATA MIGRATION: Table [DominantProduct] (E38)
   - Idempotent: Can be run multiple times without error.
   - Integrity: Checks for existing ProductName before insertion.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [DominantProduct]...';

BEGIN TRANSACTION;
BEGIN TRY
    -- Check if the DominantProduct table exists from the schema
    IF OBJECT_ID('[dbo].[DominantProduct]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table to hold flat file data from E38.txt
        CREATE TABLE #NewDominantProducts (
            [Name] NVARCHAR(100)
        );

        INSERT INTO #NewDominantProducts ([Name])
        VALUES 
        ('BEEF'),
        ('BEEF/SHEEP'),
        ('CAMEL'),
        ('EMU'),
        ('GOAT'),
        ('KANGAROO'),
        ('LAMB'),
        ('MUTTON'),
        ('OSTRICH'),
        ('PORK'),
        ('RHEA'),
        ('VEAL');

        -- Final Merge/Insert with anti-duplicate check
        INSERT INTO [dbo].[DominantProduct] ([ProductName])
        SELECT TRIM(src.[Name])
        FROM #NewDominantProducts src
        WHERE NOT EXISTS (
            SELECT 1 FROM [dbo].[DominantProduct] target 
            WHERE target.[ProductName] = src.[Name]
        );

        DECLARE @InsertedRows INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@InsertedRows AS VARCHAR(10)) + ' new records processed for [DominantProduct].';
        
        DROP TABLE #NewDominantProducts;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[DominantProduct] does not exist. Please run schema script first.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [DominantProduct] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR in data migration: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO