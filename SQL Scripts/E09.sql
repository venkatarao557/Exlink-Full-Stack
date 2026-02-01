-- =============================================================================
-- BATCH INSERT SCRIPT: EU Country Table (E09)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @E09InsertCount INT = 0;

-- Temporary table to hold the source data from E09.txt
CREATE TABLE #E09Source (
    EUCountryCode NVARCHAR(5),
    EUCountryName NVARCHAR(150)
);

-- Inserting data from E09.txt 
INSERT INTO #E09Source (EUCountryCode, EUCountryName) VALUES
('AL', 'ALBANIA'), ('AT', 'AUSTRIA'), ('BA', 'BOSNIA AND HERZEGOVINA'), ('BE', 'BELGIUM'),
('BG', 'BULGARIA'), ('CH', 'SWITZERLAND'), ('CY', 'CYPRUS'), ('CZ', 'CZECH REPUBLIC'),
('DE', 'GERMANY'), ('DK', 'DENMARK'), ('EE', 'ESTONIA'), ('ES', 'SPAIN'),
('FI', 'FINLAND'), ('FO', 'FAROE ISLANDS'), ('FR', 'FRANCE'), ('GB', 'UNITED KINGDOM'),
('GF', 'FRENCH GUIANA'), ('GI', 'GIBRALTAR'), ('GP', 'GUADELOUPE'), ('GR', 'GREECE'),
('HR', 'CROATIA'), ('HU', 'HUNGARY'), ('IE', 'IRELAND'), ('IS', 'ICELAND'),
('IT', 'ITALY'), ('LI', 'LIECHTENSTEIN'), ('LT', 'LITHUANIA'), ('LU', 'LUXEMBOURG'),
('LV', 'LATVIA'), ('MQ', 'MARTINIQUE'), ('MT', 'MALTA'), ('NL', 'NETHERLANDS'),
('NO', 'NORWAY'), ('PL', 'POLAND'), ('PM', 'SAINT PIERRE ET MIQUELON'), ('PT', 'PORTUGAL'),
('RE', 'REUNION'), ('RO', 'ROMANIA'), ('SE', 'SWEDEN'), ('SI', 'SLOVENIA'),
('SK', 'SLOVAKIA'), ('TF', 'FRENCH SOUTHERN TERRITORIES'), ('TR', 'TURKIYE'), ('YT', 'MAYOTTE');

-- Insert only if the EUCountryCode doesn't already exist in the target table
-- Replace [EUCountry] with the specific table name in your schema
INSERT INTO [EUCountry] (EUCountryCode, EUCountryName)
SELECT s.EUCountryCode, s.EUCountryName
FROM #E09Source s
WHERE NOT EXISTS (
    SELECT 1 FROM [EUCountry] t 
    WHERE t.EUCountryCode = s.EUCountryCode
);

SET @E09InsertCount = @@ROWCOUNT;

DROP TABLE #E09Source;

IF @E09InsertCount > 0
    PRINT CAST(@E09InsertCount AS NVARCHAR(10)) + ' records inserted successfully into [EUCountry].';
ELSE
    PRINT 'No new records were inserted into [EUCountry] (all records already exist).';

COMMIT TRANSACTION;
GO