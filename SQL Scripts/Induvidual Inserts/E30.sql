/* DEVOPS READY DATA MIGRATION: Table [Treatment] (E30)
   - Idempotent: Safe for multiple runs.
   - Integrity: Synchronizes TreatmentCode and Description.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [Treatment] (E30)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[Treatment]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table for staging records
        CREATE TABLE #StagingTreatment (
            [Code] NVARCHAR(10),
            [Desc] NVARCHAR(200)
        );

        INSERT INTO #StagingTreatment ([Code], [Desc])
        VALUES 
        ('ACID', 'ACIDIFICATION'), ('BDR', 'BATCH DRY RENDERING'), ('CHEMCL', 'CHEMICAL'),
        ('COLD', 'COLD TREATMENT'), ('D HEAT', 'DRY HEAT'), ('DEBARK', 'DEBARKING'),
        ('DEVIT', 'DEVITALIZATION'), ('DIHEAT', 'DIELECTRIC HEATING'), ('DIPPED', 'DIPPED'),
        ('DISINF', 'COLD DISINFESTATION TREATMENT'), ('DRENCH', 'DRENCHED'), ('DUSTED', 'DUSTED'),
        ('FLOOD', 'FLOOD SPRAYED'), ('FUMIG', 'FUMIGATED'), ('FUNGIC', 'FUNGICIDE TREATED'),
        ('HEAT', 'HEAT TREATED'), ('HWTRET', 'HOT WATER TREATMENT'), ('IMMERS', 'FULL IMMERSION'),
        ('INSECT', 'WIDE SPECTRUM INSECTICIDE'), ('INTRAN', 'SUBJECT TO IN-TRANSIT'), ('IRRAD', 'IRRADIATION'),
        ('KILN', 'KILN DRIED'), ('M HEAT', 'MOIST HEAT'), ('NEMAT', 'NEMATICIDE TREATED'),
        ('OTHPST', 'OTHER PESTICIDE'), ('PASTEU', 'PASTEURISED'), ('PC DES', 'SEED TREATED AS DESCRIBED ABOVE'),
        ('PRECOL', 'FRUIT PRECOOLED'), ('RE-CON', 'RE-CONDITIONED FUMIGATED'), ('REFER', 'DECLARATION OF TREATMENT AS ATTACHED'),
        ('SEDCOT', 'SEED COATING'), ('SLURRY', 'SLURRY TREATMENT -'), ('SPRAY', 'SPRAYED'),
        ('V HEAT', 'VAPOUR HEAT'), ('W HEAT', 'WET HEAT');

        -- Use MERGE to ensure idempotency (Update if exists, Insert if new)
        MERGE INTO [dbo].[Treatment] AS target
        USING #StagingTreatment AS src
        ON (target.[TreatmentCode] = src.[Code])
        WHEN MATCHED THEN
            UPDATE SET target.[TreatmentDescription] = src.[Desc]
        WHEN NOT MATCHED THEN
            INSERT ([TreatmentCode], [TreatmentDescription])
            VALUES (src.[Code], src.[Desc]);

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [Treatment].';
        
        DROP TABLE #StagingTreatment;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[Treatment] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [Treatment] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO