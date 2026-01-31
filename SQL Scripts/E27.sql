-- =============================================================================
-- BATCH INSERT SCRIPT: USTerritory Table (E27)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @USTerritoryCount INT = 0;

CREATE TABLE #SourceData (
    CountryCode CHAR(2),
    CountryName NVARCHAR(100)
);

-- Inserting data from E27.txt
INSERT INTO #SourceData (CountryCode, CountryName) VALUES
('AS', 'AMERICAN SAMOA'),
('GU', 'GUAM'),
('MP', 'NORTHERN MARIANA ISLANDS'),
('PR', 'PUERTO RICO'),
('UM', 'UNITED STATES MINOR OUTLYING ISL.'),
('US', 'UNITED STATES'),
('VI', 'VIRGIN ISLANDS (U.S.)[cite_start]'); [cite: 18]

INSERT INTO [USTerritory] (CountryCode, CountryName)
SELECT s.CountryCode, s.CountryName
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [USTerritory] t 
    WHERE t.CountryCode = s.CountryCode
);

SET @USTerritoryCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @USTerritoryCount > 0
    PRINT CAST(@USTerritoryCount AS NVARCHAR(10)) + ' records inserted successfully into Table USTerritory.';
ELSE
    PRINT 'No new records were inserted into Table USTerritory.';

COMMIT TRANSACTION;
GO