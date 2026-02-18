/* DEVOPS READY DATA MIGRATION: Table [State] (E35)
   - Idempotent: Can be run multiple times without error.
   - Integrity: Checks for existing StateCodes before insertion.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [State]...';

BEGIN TRANSACTION;
BEGIN TRY
    -- Check if the State table exists from the schema 
    IF OBJECT_ID('[dbo].[State]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table to hold flat file data from E35.txt 
        CREATE TABLE #NewStates (
            [Code] CHAR(3),
            [Name] NVARCHAR(100)
        );

        INSERT INTO #NewStates ([Code], [Name])
        VALUES 
        ('ACT', 'AUSTRALIAN CAPITAL TERRITORY'),
        ('FO ', 'FOREIGN'),
        ('NSW', 'NEW SOUTH WALES'),
        ('NT ', 'NORTHERN TERRITORY'),
        ('QLD', 'QUEENSLAND'),
        ('SA ', 'SOUTH AUSTRALIA'),
        ('TAS', 'TASMANIA'),
        ('VIC', 'VICTORIA'),
        ('WA ', 'WESTERN AUSTRALIA');

        -- Final Merge/Insert with anti-duplicate check [cite: 1, 3]
        INSERT INTO [dbo].[State] ([StateCode], [StateName])
        SELECT src.[Code], src.[Name]
        FROM #NewStates src
        WHERE NOT EXISTS (
            SELECT 1 FROM [dbo].[State] target 
            WHERE target.[StateCode] = src.[Code]
        );

        DECLARE @InsertedRows INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@InsertedRows AS VARCHAR(10)) + ' new records inserted into [State].';
        
        DROP TABLE #NewStates;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[State] does not exist. Please run schema script first.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [State] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR in data migration: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO