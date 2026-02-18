/* DEVOPS READY DATA MIGRATION: Table [LocationQualifier] (E13)
   - Idempotent: Can be run multiple times without error.
   - Integrity: Checks for existing LocationQualifierName before insertion.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [LocationQualifier]...';

BEGIN TRANSACTION;
BEGIN TRY
    -- Check if the LocationQualifier table exists from the schema
    IF OBJECT_ID('[dbo].[LocationQualifier]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table to hold flat file data from E13.txt
        CREATE TABLE #NewQualifiers (
            [Name] NVARCHAR(100)
        );

        INSERT INTO #NewQualifiers ([Name])
        VALUES 
        ('Australian'),
        ('Tasmanian');

        -- Final Merge/Insert with anti-duplicate check
        INSERT INTO [dbo].[LocationQualifier] ([LocationQualifierName])
        SELECT TRIM(src.[Name])
        FROM #NewQualifiers src
        WHERE NOT EXISTS (
            SELECT 1 FROM [dbo].[LocationQualifier] target 
            WHERE target.[LocationQualifierName] = src.[Name]
        );

        DECLARE @InsertedRows INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@InsertedRows AS VARCHAR(10)) + ' new records inserted into [LocationQualifier].';
        
        DROP TABLE #NewQualifiers;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[LocationQualifier] does not exist. Please run schema script first.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [LocationQualifier] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR in data migration: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO