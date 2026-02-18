/* DEVOPS READY DATA MIGRATION: Table [DocumentType] (E18)
   - Idempotent: Safe for multiple runs.
   - Integrity: Synchronizes DocumentTypeCode and Description.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [DocumentType] (E18)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[DocumentType]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table to hold all records from E18.txt
        CREATE TABLE #StagingDocumentType (
            [Code] NVARCHAR(10),
            [Desc] NVARCHAR(255)
        );

        INSERT INTO #StagingDocumentType ([Code], [Desc])
        VALUES 
        ('AFM', 'AUSTRALIAN FISHERIES MANAGEMENT AUT'),
        ('AHB', 'AUSTRALIAN HONEY BOARD'),
        ('AHC', 'AUSTRALIAN HORTICULTURAL CORPORATIO'),
        ('AWB', 'AUSTRALIAN WHEAT BOARD'),
        ('CSH', 'DEPT OF HEALTH SERVICES - DRUG TREA'),
        ('HAL', 'HORTICULTURE AUSTRALIA LIMITED'),
        ('HBE', 'DEPT. OF HEALTH SERVICES - BLOOD EX'),
        ('HEA', 'DEPT. OF HEALTH SERVICES - GENERAL'),
        ('HIA', 'HORTICULTURE INNOVATION AUSTRALIA'),
        ('IMP', 'IMPORT PERMIT'),
        ('PWS', 'ENVIRONMENT AUSTRALIA'),
        ('WBC', 'AUSTRALIAN WINE AND BRANDY CORPORAT'),
        ('WEA', 'WHEAT EXPORT AUTHORITY');

        -- Use MERGE to ensure idempotency (Update if exists, Insert if new)
        MERGE INTO [dbo].[DocumentType] AS target
        USING #StagingDocumentType AS src
        ON (target.[DocumentTypeCode] = src.[Code])
        WHEN MATCHED THEN
            UPDATE SET target.[DocumentTypeDescription] = src.[Desc]
        WHEN NOT MATCHED THEN
            INSERT ([DocumentTypeCode], [DocumentTypeDescription])
            VALUES (src.[Code], src.[Desc]);

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [DocumentType].';
        
        DROP TABLE #StagingDocumentType;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[DocumentType] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [DocumentType] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO