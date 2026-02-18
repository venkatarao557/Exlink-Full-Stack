/* DEVOPS READY DATA MIGRATION: Table [ProductCondition] (E43)
   - Idempotent: Can be run multiple times without error.
   - Integrity: Checks for existing ConditionCode before insertion.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [ProductCondition]...';

BEGIN TRANSACTION;
BEGIN TRY
    -- Check if the ProductCondition table exists from the schema
    IF OBJECT_ID('[dbo].[ProductCondition]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table to hold flat file data from E43.txt
        CREATE TABLE #NewConditions (
            [Code] NVARCHAR(10),
            [Name] NVARCHAR(100)
        );

        INSERT INTO #NewConditions ([Code], [Name])
        VALUES 
        ('0001', 'ROOTED'),
        ('0002', 'UNROOTED'),
        ('0003', 'BARE-ROOTED'),
        ('0004', 'WITHOUT LEAVES OR FLOWERS'),
        ('0005', 'DORMANT'),
        ('0006', 'WITH BARK'),
        ('0007', 'DEBARKED'),
        ('0008', 'BARK-FREE'),
        ('0009', 'DRIED'),
        ('0010', 'CHOPPED'),
        ('0011', 'PEELED'),
        ('0012', 'SHELLED'),
        ('0013', 'FRESH'),
        ('0014', 'FROZEN'),
        ('0015', 'WITH GROWING MEDIUM'),
        ('0016', 'POTTED'),
        ('0017', 'CHEMICAL PRESSURE IMPREGNATED'),
        ('0018', 'HEAT TREATED'),
        ('0019', 'DUST'),
        ('0020', 'SHAVINGS'),
        ('0021', 'ROUND'),
        ('0022', 'SAWN'),
        ('0023', 'CHIPS'),
        ('0024', 'CUT');

        -- Final Merge/Insert with anti-duplicate check
        INSERT INTO [dbo].[ProductCondition] ([ConditionCode], [ConditionName])
        SELECT 
            TRIM(src.[Code]), 
            TRIM(src.[Name])
        FROM #NewConditions src
        WHERE NOT EXISTS (
            SELECT 1 FROM [dbo].[ProductCondition] target 
            WHERE target.[ConditionCode] = TRIM(src.[Code])
        );

        DECLARE @InsertedRows INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@InsertedRows AS VARCHAR(10)) + ' new records processed for [ProductCondition].';
        
        DROP TABLE #NewConditions;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[ProductCondition] does not exist. Please run schema script first.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [ProductCondition] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR in data migration: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO