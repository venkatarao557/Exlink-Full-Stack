-- =============================================================================
-- BATCH INSERT SCRIPT: Currency Table (E06)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @CurrInsertCount INT = 0;

-- Temporary table to hold the source data from E06.txt
CREATE TABLE #E06Source (
    CurrencyUnit NVARCHAR(10),
    Description NVARCHAR(100)
);

-- Inserting data from E06.txt 
INSERT INTO #E06Source (CurrencyUnit, Description) VALUES
('AT', 'AUSTRIAN SCHILLING'), ('AUD', 'AUSTRALIAN DOLLAR'), ('BE', 'BELGIAN/LUXEMBOURG FRANC'),
('BR', 'BRAZILLIAN CRUZEIRO'), ('CA', 'CANADIAN DOLLAR'), ('CH', 'SWISS FRANC'),
('CN', 'CHINESE RENMINBI'), ('DE', 'DEUTSCHE MARK'), ('DK', 'DANISH KRONE'),
('ES', 'SPANISH PESETA'), ('EUR', 'EURO DOLLAR'), ('FI', 'FINNISH MARKKA'),
('FJ', 'FIJI DOLLAR'), ('FR', 'FRENCH FRANC'), ('GB', 'UK POUND'),
('GR', 'GREEK DRACHMA'), ('HK', 'HONG KONG DOLLAR'), ('ID', 'INDONESIAN RUPIAH'),
('IE', 'IRISH POUND'), ('IL', 'ISRAELI SHEKEL'), ('IN', 'INDIAN RUPEE'),
('IQ', 'IRAQI DINAR'), ('IT', 'ITALIAN LIRA'), ('JP', 'JAPANESE YEN'),
('KR', 'KOREA, REP OF, WON'), ('LK', 'SRI LANKA RUPEE'), ('MX', 'MEXICAN PESO'),
('MY', 'MALAYSIAN RINGGIT'), ('NL', 'NETHERLANDS GUILDER'), ('NO', 'NORWEGIAN KRONE'),
('NZ', 'NEW ZEALAND DOLLAR'), ('PG', 'PNG KINA'), ('PH', 'PHILIPPINE PESO'),
('PK', 'PAKISTAN RUPEE'), ('PT', 'PORTUGUESE ESCUDO'), ('SA', 'SAUDI RIYAL'),
('SB', 'SOLOMON ISLANDS DOLLAR'), ('SE', 'SWEDISH KRONA'), ('SG', 'SINGAPORE DOLLAR'),
('TH', 'THAI BAHT'), ('TW', 'NEW TAIWAN DOLLAR'), ('US', 'US DOLLAR'),
('ZA', 'SOUTH AFRICAN RAND');

-- Insert only if the CurrencyUnit doesn't already exist in the target table
INSERT INTO [Currency] (CurrencyUnit, Description)
SELECT s.CurrencyUnit, s.Description
FROM #E06Source s
WHERE NOT EXISTS (
    SELECT 1 FROM [Currency] t 
    WHERE t.CurrencyUnit = s.CurrencyUnit
);

SET @CurrInsertCount = @@ROWCOUNT;

DROP TABLE #E06Source;

IF @CurrInsertCount > 0
    PRINT CAST(@CurrInsertCount AS NVARCHAR(10)) + ' records inserted successfully into [Currency].';
ELSE
    PRINT 'No new records were inserted into [Currency] (all records already exist).';

COMMIT TRANSACTION;
GO