/* DEVOPS READY DATA MIGRATION: Table [Currency] (E06)
   - Idempotent: Safe for multiple runs.
   - Integrity: Checks for existing CurrencyUnit before insertion.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [Currency] (E06)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[Currency]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table to hold all records from E06.txt
        CREATE TABLE #StagingCurrency (
            [Unit] NVARCHAR(10),
            [Desc] NVARCHAR(100)
        );

        INSERT INTO #StagingCurrency ([Unit], [Desc])
        VALUES 
        ('AT', 'AUSTRIAN SCHILLING'),
        ('AUD', 'AUSTRALIAN DOLLAR'),
        ('BE', 'BELGIAN/LUXEMBOURG FRANC'),
        ('BR', 'BRAZILLIAN CRUZEIRO'),
        ('CA', 'CANADIAN DOLLAR'),
        ('CH', 'SWISS FRANC'),
        ('CN', 'CHINESE RENMINBI'),
        ('DE', 'DEUTSCHE MARK'),
        ('DK', 'DANISH KRONE'),
        ('ES', 'SPANISH PESETA'),
        ('EUR', 'EURO DOLLAR'),
        ('FI', 'FINNISH MARKKA'),
        ('FJ', 'FIJI DOLLAR'),
        ('FR', 'FRENCH FRANC'),
        ('GB', 'UK POUND'),
        ('GR', 'GREEK DRACHMA'),
        ('HK', 'HONG KONG DOLLAR'),
        ('ID', 'INDONESIAN RUPIAH'),
        ('IE', 'IRISH POUND'),
        ('IL', 'ISRAELI SHEKEL'),
        ('IN', 'INDIAN RUPEE'),
        ('IQ', 'IRAQI DINAR'),
        ('IT', 'ITALIAN LIRA'),
        ('JP', 'JAPANESE YEN'),
        ('KR', 'KOREA, REP OF, WON'),
        ('LK', 'SRI LANKA RUPEE'),
        ('MX', 'MEXICAN PESO'),
        ('MY', 'MALAYSIAN RINGGIT'),
        ('NL', 'NETHERLANDS GUILDER'),
        ('NO', 'NORWEGIAN KRONE'),
        ('NZ', 'NEW ZEALAND DOLLAR'),
        ('PG', 'PNG KINA'),
        ('PH', 'PHILIPPINE PESO'),
        ('PK', 'PAKISTAN RUPEE'),
        ('PT', 'PORTUGUESE ESCUDO'),
        ('SA', 'SAUDI RIYAL'),
        ('SB', 'SOLOMON ISLANDS DOLLAR'),
        ('SE', 'SWEDISH KRONA'),
        ('SG', 'SINGAPORE DOLLAR'),
        ('TH', 'THAI BAHT'),
        ('TW', 'NEW TAIWAN DOLLAR'),
        ('US', 'US DOLLAR'),
        ('ZA', 'SOUTH AFRICAN RAND');

        -- Final Insert with anti-duplicate check
        INSERT INTO [dbo].[Currency] ([CurrencyUnit], [Description])
        SELECT 
            TRIM(src.[Unit]), 
            TRIM(src.[Desc])
        FROM #StagingCurrency src
        WHERE NOT EXISTS (
            SELECT 1 FROM [dbo].[Currency] target 
            WHERE target.[CurrencyUnit] = TRIM(src.[Unit])
        );

        DECLARE @InsertedRows INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@InsertedRows AS VARCHAR(10)) + ' records processed for [Currency].';
        
        DROP TABLE #StagingCurrency;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[Currency] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [Currency] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO