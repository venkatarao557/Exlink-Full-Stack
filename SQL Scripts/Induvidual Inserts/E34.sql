/* DEVOPS READY DATA MIGRATION: Table [TreatmentType] (E34)
   - Idempotent: Safe for multiple runs.
   - Integrity: Synchronizes TreatmentTypeCode and Description.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [TreatmentType] (E34)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[TreatmentType]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table for high-performance staging
        CREATE TABLE #StagingTreatmentType (
            [Code] NVARCHAR(10),
            [Desc] NVARCHAR(150)
        );

        INSERT INTO #StagingTreatmentType ([Code], [Desc])
        VALUES 
        ('BI', 'BONE IN'), ('BO', 'DEBONED'), ('CA', 'CANNED'), ('CH', 'REFRIGERATED'),
        ('CHIL', 'CHILLED'), ('CHT', 'COMBINED HEAT TREATMENT'), ('COO', 'COOKED'), ('DR', 'DRIED'),
        ('EV', 'EVISCERATED'), ('FR', 'FROZEN'), ('FRE', 'FRESH'), ('HOM', 'HOMOGENISATION'),
        ('IS', 'IN SHELL'), ('LI', 'LIVE'), ('MI', 'MINCED'), ('MT', 'MATURED'),
        ('NRTE', 'NOT READY TO EAT'), ('NT', 'NO TERMAL TREATMENT'), ('PA', 'PASTEURISATION'), ('PC', 'PROCESSED'),
        ('PL', 'PLUCKED'), ('PR', 'PRESERVED'), ('PRE', 'PREPARED'), ('RM', 'RAW MILK'),
        ('RO', 'ROASTED'), ('RTE', 'READY TO EAT'), ('SA', 'SALTED'), ('SH', 'SHELLED'),
        ('SHT', 'SINGLE HEAT TREATMENT'), ('SK', 'SKINNED'), ('SM', 'SMOKED'), ('TR', 'TREATED'),
        ('UN', 'UNEVISCERATED'), ('UNP', 'UNPLUCKED'), ('US', 'UNSKINNED');

        -- Final Ingestion using MERGE for idempotency
        MERGE INTO [dbo].[TreatmentType] AS target
        USING #StagingTreatmentType AS src
        ON (target.[TreatmentTypeCode] = src.[Code])
        WHEN MATCHED THEN
            UPDATE SET target.[TreatmentTypeDescription] = src.[Desc]
        WHEN NOT MATCHED THEN
            INSERT ([TreatmentTypeCode], [TreatmentTypeDescription])
            VALUES (src.[Code], src.[Desc]);

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [TreatmentType].';
        
        DROP TABLE #StagingTreatmentType;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[TreatmentType] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [TreatmentType] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO