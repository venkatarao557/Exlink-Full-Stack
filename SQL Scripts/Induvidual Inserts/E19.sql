/* DEVOPS READY DATA MIGRATION: Table [PreservationType] (E19)
   - Idempotent: Safe for multiple runs.
   - Integrity: Synchronizes PreservationTypeCode and Description.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [PreservationType] (E19)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[PreservationType]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table for staging
        CREATE TABLE #StagingPreservation (
            [Code] NVARCHAR(10),
            [Desc] NVARCHAR(100)
        );

        INSERT INTO #StagingPreservation ([Code], [Desc])
        VALUES 
        ('C', 'CHILLED'),
        ('F', 'FROZEN'),
        ('U', 'UNREFRIGERATED'),
        ('X', 'NULL');

        -- Use MERGE to ensure idempotency (Update if exists, Insert if new)
        MERGE INTO [dbo].[PreservationType] AS target
        USING #StagingPreservation AS src
        ON (target.[PreservationTypeCode] = src.[Code])
        WHEN MATCHED THEN
            UPDATE SET target.[PreservationTypeDescription] = src.[Desc]
        WHEN NOT MATCHED THEN
            INSERT ([PreservationTypeCode], [PreservationTypeDescription])
            VALUES (src.[Code], src.[Desc]);

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [PreservationType].';
        
        DROP TABLE #StagingPreservation;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[PreservationType] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [PreservationType] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO