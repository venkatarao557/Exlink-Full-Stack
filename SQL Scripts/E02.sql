-- =============================================================================
-- BATCH INSERT SCRIPT: CountryCommodity Table (E02)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @CountryCommCount INT = 0;

-- Temporary table to hold the source data from E02.txt
CREATE TABLE #E02Source (
    CountryCode NVARCHAR(5),
    CountryName NVARCHAR(100),
    Commodities NVARCHAR(255)
);

-- Inserting data from E02.txt 
INSERT INTO #E02Source (CountryCode, CountryName, Commodities) VALUES
('AU', 'AUSTRALIA', 'M,D,F,G,H'), -- 
('CC', 'COCOS ISLANDS', 'M,D,F'), -- 
('CX', 'CHRISTMAS ISLAND', 'M,D,F'), -- 
('HM', 'HEARD ISLAND AND MCDONALD ISLANDS', 'M,D,F,G,H'), -- 
('NF', 'NORFOLK ISLAND', 'M,D,F'); -- 

-- Insert only if the CountryCode doesn't already exist in the target table
INSERT INTO [CountryCommodity] (CountryCode, CountryName, Commodities)
SELECT s.CountryCode, s.CountryName, s.Commodities
FROM #E02Source s
WHERE NOT EXISTS (
    SELECT 1 FROM [CountryCommodity] t 
    WHERE t.CountryCode = s.CountryCode
);

SET @CountryCommCount = @@ROWCOUNT;

DROP TABLE #E02Source;

IF @CountryCommCount > 0
    PRINT CAST(@CountryCommCount AS NVARCHAR(10)) + ' records inserted successfully into Table CountryCommodity.';
ELSE
    PRINT 'No new records were inserted into Table CountryCommodity (all records already exist).';

COMMIT TRANSACTION;
GO