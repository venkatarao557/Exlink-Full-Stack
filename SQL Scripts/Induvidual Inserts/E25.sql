/* DEVOPS READY DATA MIGRATION: Table [SupplementaryCode] (E25)
   - Idempotent: Safe for multiple runs.
   - Integrity: Synchronizes SupplementaryCode, Description, and Commodities.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [SupplementaryCode] (E25)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[SupplementaryCode]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table for staging records from E25.txt
        CREATE TABLE #StagingSuppCode (
            [Code] NVARCHAR(10),
            [Desc] NVARCHAR(255),
            [Comm] NVARCHAR(50)
        );

        INSERT INTO #StagingSuppCode ([Code], [Desc], [Comm])
        VALUES 
        ('A',  'AGED', 'M'),
        ('AQ', 'AQUACULTURE', 'F'),
        ('B',  'EXEMPTION', 'M'),
        ('BG', 'US BEEF FOR GRINDING', 'M'),
        ('C',  'ACCELERATED CONDITIONING', 'M'),
        ('CE', 'CALF INTESTINES FOR ENZYME EXTRACTI', 'M'),
        ('DM', 'MANUFACTURING GRADE', 'D'),
        ('E',  'ELECTRICAL STIMULATION', 'M'),
        ('EA', 'EU BALAI PRODUCT (ANNEX A)', 'S'),
        ('EB', 'EU BALAI PRODUCT (ANNEX A)', 'S'),
        ('EC', 'EU BALAI PRODUCT (ANNEX A)', 'S'),
        ('ED', 'EU BALAI PRODUCT (ANNEX A)', 'S'),
        ('EE', 'EU BALAI PRODUCT (ANNEX A)', 'S'),
        ('EF', 'EU BALAI PRODUCT (ANNEX A)', 'S'),
        ('EG', 'EU BALAI PRODUCT (ANNEX B)', 'S'),
        ('EH', 'EU BALAI PRODUCT (ANNEX B)', 'S'),
        ('EI', 'EU BALAI PRODUCT (ANNEX B)', 'S'),
        ('EJ', 'EU BALAI PRODUCT (ANNEX B)', 'S'),
        ('EK', 'EU BALAI PRODUCT (ANNEX B)', 'S'),
        ('EL', 'EU BALAI PRODUCT (ANNEX B)', 'S'),
        ('EM', 'EU BALAI PRODUCT (ANNEX B)', 'S'),
        ('EN', 'EU BALAI PRODUCT (ANNEX B)', 'S'),
        ('F',  'FARL', 'M'),
        ('G',  'GRAIN FED', 'M'),
        ('GC', 'CONSUMPTION', 'G,H'),
        ('GD', 'DECORATION', 'G,H'),
        ('GF', 'STOCKFEED', 'G,H'),
        ('GH', 'SPROUTING FOR CONSUMPTION', 'G,H'),
        ('GM', 'SPROUTING FOR CONSUMPTION', 'G,H'),
        ('GP', 'PROCESSING', 'G,H'),
        ('GR', 'RESEARCH', 'G,H'),
        ('GS', 'PLANTING', 'G,H'),
        ('H',  'COOKED', 'M,E'),
        ('HQ', 'GRAIN FED HIGH QUALITY BEEF', 'M'),
        ('I',  'IRRADIATED', 'M'),
        ('J',  'FOR US DEFENCE FORCES', 'M'),
        ('L',  'LOT FED', 'M'),
        ('LA', 'LIVE AQUACULTURE', 'F'),
        ('LW', 'LIVE WILD ORIGIN', 'F'),
        ('M',  'MILK FED', 'M'),
        ('O',  'ORGANIC', 'M'),
        ('PF', 'PERFORMANCE ENHANCEMENT FREE', 'M'),
        ('R',  'RANGE FED', 'M'),
        ('S',  'GRASS FED', 'M'),
        ('T',  'TENDER STRETCHED', 'M'),
        ('T1', 'JJ', 'M'),
        ('TX', 'EU TRANSIT', 'M'),
        ('V',  'GILT PORK - SINGAPORE ONLY', 'M'),
        ('WO', 'NON VIABLE WILD ORIGIN', 'F'),
        ('X',  'BARROW PORK - SINGAPORE ONLY', 'M');

        -- Use MERGE to ensure idempotency (Update if exists, Insert if new)
        MERGE INTO [dbo].[SupplementaryCode] AS target
        USING #StagingSuppCode AS src
        ON (target.[SupplementaryCode] = src.[Code])
        WHEN MATCHED THEN
            UPDATE SET target.[Description] = src.[Desc],
                       target.[Commodities] = src.[Comm]
        WHEN NOT MATCHED THEN
            INSERT ([SupplementaryCode], [Description], [Commodities])
            VALUES (src.[Code], src.[Desc], src.[Comm]);

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [SupplementaryCode].';
        
        DROP TABLE #StagingSuppCode;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[SupplementaryCode] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [SupplementaryCode] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO