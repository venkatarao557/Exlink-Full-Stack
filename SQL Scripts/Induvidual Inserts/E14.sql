/* DEVOPS READY DATA MIGRATION: Table [UnitOfMeasure] (E14)
   - Idempotent: Safe for multiple runs.
   - Integrity: Checks for existing UnitCode before insertion.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting automated data ingestion for [UnitOfMeasure]...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[UnitOfMeasure]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table for staging
        CREATE TABLE #RawUOM (
            [UCode] NVARCHAR(10),
            [UType] NVARCHAR(50),
            [UDesc] NVARCHAR(200)
        );

        INSERT INTO #RawUOM ([UCode], [UType], [UDesc])
        VALUES 
        ('CMT', 'LENGTH', 'CENTIMETRE'),
        ('DMT', 'LENGTH', 'DECIMETRE'),
        ('MTR', 'LENGTH', 'METRE'),
        ('CGM', 'MASS', 'CENTIGRAM'),
        ('CMK', 'MASS', 'CM²'),
        ('CU', 'MASS', 'CUBIC METRE'),
        ('CWI', 'MASS', 'HUNDRED WEIGHT(UK)'),
        ('DTN', 'MASS', 'DECITONNE'),
        ('GRM', 'MASS', 'GRAM'),
        ('GRN', 'MASS', 'GRAIN'),
        ('HGM', 'MASS', 'HECTOGRAM'),
        ('JCM', 'MASS', 'JAS CBM'),
        ('KGM', 'MASS', 'KILOGRAM'),
        ('KTN', 'MASS', 'KILOTONNE'),
        ('LBR', 'MASS', 'POUND'),
        ('LTN', 'MASS', 'TON(UK) OR LONGTON(US)'),
        ('MGM', 'MASS', 'MILLIGRAM'),
        ('MT', 'MASS', 'M/TONS'),
        ('MTK', 'MASS', 'METRIC TONNES OF 1,000 KILOS EACH'),
        ('MTN', 'MASS', 'METRIC TONS'),
        ('MTO', 'MASS', 'METRIC TON'),
        ('MTS', 'MASS', 'M/TS'),
        ('NO', 'MASS', 'NUMBER'),
        ('ONZ', 'MASS', 'OUNCE'),
        ('SM', 'MASS', 'SQUARE METRE'),
        ('SS', 'MASS', 'STEMS'),
        ('STI', 'MASS', 'STONE(UK)'),
        ('STN', 'MASS', 'TON (US) OR SHORT TON(UK/US)'),
        ('TN', 'MASS', 'TONNES'),
        ('TNE', 'MASS', 'TONNE (METRIC TONNE)'),
        ('BIL', 'NUMBER', 'BILLION(EUR)'),
        ('CEN', 'NUMBER', 'HUNDRED'),
        ('DZN', 'NUMBER', 'DOZEN'),
        ('GGR', 'NUMBER', 'GREAT GROSS'),
        ('GRO', 'NUMBER', 'GROSS'),
        ('HIU', 'NUMBER', 'HUNDRED INTERNATIONAL UNITS'),
        ('MIL', 'NUMBER', 'THOUSAND'),
        ('MIO', 'NUMBER', 'MILLION'),
        ('MIU', 'NUMBER', 'MILLION INTERNATIONAL UNITS'),
        ('MLD', 'NUMBER', 'MILLIARD'),
        ('NAR', 'NUMBER', 'NUMBER OF ARTICLES'),
        ('NBB', 'NUMBER', 'NUMBER OF BOBBINS'),
        ('NCL', 'NUMBER', 'NUMBER OF CELLS'),
        ('NIU', 'NUMBER', 'NUMBER OF INTERNATIONAL UNITS'),
        ('NMP', 'NUMBER', 'NUMBER OF PACKS'),
        ('NPL', 'NUMBER', 'NUMBER OF PARCELS'),
        ('NPR', 'NUMBER', 'NUMBER OF PAIRS'),
        ('NPT', 'NUMBER', 'NUMBER OF PARTS'),
        ('NR', 'NUMBER', 'NOT REQUIRED'),
        ('NRL', 'NUMBER', 'NUMBER OF ROLLS'),
        ('SCO', 'NUMBER', 'SCORE'),
        ('TRL', 'NUMBER', 'TRILLION(EUR)'),
        ('CEL', 'TEMPERATURE', 'CELSIUS'),
        ('FAH', 'TEMPERATURE', 'FAHRENHEIT'),
        ('BLD', 'VOLUME', 'DRY BARREL(US)'),
        ('BLL', 'VOLUME', 'BARREL (US)'),
        ('BUA', 'VOLUME', 'BUSHEL(US)'),
        ('BUI', 'VOLUME', 'BUSHEL(UK)'),
        ('CLT', 'VOLUME', 'CENTILITRE'),
        ('DAA', 'VOLUME', 'DECALITRE'),
        ('DLT', 'VOLUME', 'DECILITRE'),
        ('DLD', 'VOLUME', 'DRY DECALITRE(US)'),
        ('DLB', 'VOLUME', 'DRY DECILITRE(US)'),
        ('GLD', 'VOLUME', 'DRY GALLON(US)'),
        ('PTD', 'VOLUME', 'DRY PINT(US)'),
        ('QTD', 'VOLUME', 'DRY QUART(US)'),
        ('GLL', 'VOLUME', 'GALLON (UK)'),
        ('GLI', 'VOLUME', 'GALLON (UK)'),
        ('HLT', 'VOLUME', 'HECTOLITRE'),
        ('LTR', 'VOLUME', 'LITRE'),
        ('MLT', 'VOLUME', 'MILLILITRE'),
        ('OZM', 'VOLUME', 'FLUID OUNCE(UK)'),
        ('OZF', 'VOLUME', 'FLUID OUNCE(US)'),
        ('PTI', 'VOLUME', 'PINT (UK)'),
        ('PTL', 'VOLUME', 'PINT (US)'),
        ('QTI', 'VOLUME', 'QUART (UK)'),
        ('QTL', 'VOLUME', 'QUART (US)'),
        ('DLP', 'VOLUME', 'DRY CENTILITRE(US)'),
        ('DLA', 'VOLUME', 'DRY DECALITRE(US)'),
        ('DLB', 'VOLUME', 'DRY DECILITRE(US)'),
        ('DLR', 'VOLUME', 'DRY CENTILITRE(US)'),
        ('DLS', 'VOLUME', 'DRY CENTILITRE(US)'),
        ('DLT', 'VOLUME', 'DRY CENTILITRE(US)');

        -- Ingestion with duplication check based on UnitCode
        INSERT INTO [dbo].[UnitOfMeasure] ([UnitCode], [UnitType], [UnitDescription])
        SELECT 
            TRIM(src.[UCode]), 
            TRIM(src.[UType]), 
            TRIM(src.[UDesc])
        FROM #RawUOM src
        WHERE NOT EXISTS (
            SELECT 1 FROM [dbo].[UnitOfMeasure] target 
            WHERE target.[UnitCode] = TRIM(src.[UCode])
        );

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [UnitOfMeasure].';
        
        DROP TABLE #RawUOM;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[UnitOfMeasure] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [UnitOfMeasure] completed.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO