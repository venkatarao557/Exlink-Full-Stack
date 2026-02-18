/* DEVOPS READY DATA MIGRATION: Table [Currency] (E06)
   - Updated: Added [Symbol] column support.
   - Idempotent: Safe for multiple runs.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [Currency] with Symbols...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[Currency]', 'U') IS NOT NULL
    BEGIN
        -- Ensure the Symbol column exists
        IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('[dbo].[Currency]') AND name = 'Symbol')
        BEGIN
            ALTER TABLE [dbo].[Currency] ADD [Symbol] NVARCHAR(10) NULL;
            PRINT 'Column [Symbol] added to [Currency] table.';
        END

        -- Temporary staging table
        CREATE TABLE #StagingCurrency (
            [Unit] NVARCHAR(10),
            [Desc] NVARCHAR(100),
            [Sym]  NVARCHAR(10)
        );

        INSERT INTO #StagingCurrency ([Unit], [Desc], [Sym])
        VALUES 
        ('AT', 'AUSTRIAN SCHILLING', 'S'),
        ('AUD', 'AUSTRALIAN DOLLAR', '$'),
        ('BE', 'BELGIAN/LUXEMBOURG FRANC', 'fr.'),
        ('BR', 'BRAZILLIAN CRUZEIRO', 'Cr$'),
        ('CA', 'CANADIAN DOLLAR', '$'),
        ('CH', 'SWISS FRANC', 'CHF'),
        ('CN', 'CHINESE RENMINBI', '¥'),
        ('DE', 'DEUTSCHE MARK', 'DM'),
        ('DK', 'DANISH KRONE', 'kr'),
        ('ES', 'SPANISH PESETA', '₧'),
        ('EUR', 'EURO DOLLAR', '€'),
        ('FI', 'FINNISH MARKKA', 'mk'),
        ('FJ', 'FIJI DOLLAR', '$'),
        ('FR', 'FRENCH FRANC', '₣'),
        ('GB', 'UK POUND', '£'),
        ('GR', 'GREEK DRACHMA', '₯'),
        ('HK', 'HONG KONG DOLLAR', '$'),
        ('ID', 'INDONESIAN RUPIAH', 'Rp'),
        ('IE', 'IRISH POUND', '£'),
        ('IL', 'ISRAELI SHEKEL', '₪'),
        ('IN', 'INDIAN RUPEE', '₹'),
        ('IQ', 'IRAQI DINAR', 'د.ع'),
        ('IT', 'ITALIAN LIRA', '₤'),
        ('JP', 'JAPANESE YEN', '¥'),
        ('KR', 'KOREA, REP OF, WON', '₩'),
        ('LK', 'SRI LANKA RUPEE', '₨'),
        ('MX', 'MEXICAN PESO', '$'),
        ('MY', 'MALAYSIAN RINGGIT', 'RM'),
        ('NL', 'NETHERLANDS GUILDER', 'ƒ'),
        ('NO', 'NORWEGIAN KRONE', 'kr'),
        ('NZ', 'NEW ZEALAND DOLLAR', '$'),
        ('PG', 'PNG KINA', 'K'),
        ('PH', 'PHILIPPINE PESO', '₱'),
        ('PK', 'PAKISTAN RUPEE', '₨'),
        ('PT', 'PORTUGUESE ESCUDO', '$'),
        ('SA', 'SAUDI RIYAL', '﷼'),
        ('SB', 'SOLOMON ISLANDS DOLLAR', '$'),
        ('SE', 'SWEDISH KRONA', 'kr'),
        ('SG', 'SINGAPORE DOLLAR', '$'),
        ('TH', 'THAI BAHT', '฿'),
        ('TW', 'NEW TAIWAN DOLLAR', '$'),
        ('US', 'US DOLLAR', '$'),
        ('ZA', 'SOUTH AFRICAN RAND', 'R');

        -- Update existing records with symbols or insert new ones
        MERGE INTO [dbo].[Currency] AS target
        USING #StagingCurrency AS src
        ON (target.[CurrencyUnit] = src.[Unit])
        WHEN MATCHED THEN
            UPDATE SET target.[Symbol] = src.[Sym], target.[Description] = src.[Desc]
        WHEN NOT MATCHED THEN
            INSERT ([CurrencyUnit], [Description], [Symbol])
            VALUES (src.[Unit], src.[Desc], src.[Sym]);

        PRINT 'SUCCESS: Currency records synchronized with symbols.';
        DROP TABLE #StagingCurrency;
    END
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO