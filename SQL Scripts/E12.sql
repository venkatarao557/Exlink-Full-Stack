-- =============================================================================
-- BATCH INSERT SCRIPT: WeightUnit Table (E12)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @WeightShortCount INT = 0;

CREATE TABLE #SourceData (
    WeightUnit NVARCHAR(10),
    Description NVARCHAR(100)
);

[cite_start]-- Inserting data from E12.txt [cite: 2]
INSERT INTO #SourceData (WeightUnit, Description) VALUES
('CWI', 'HUNDRED WEIGHT(UK)[cite_start]'), -- [cite: 2]
('LBR', 'POUND')[cite_start], -- [cite: 2]
('LTN', 'TON(UK) [cite_start]OR LONGTON(US)'), -- [cite: 2]
('ONZ', 'OUNCE')[cite_start], -- [cite: 2]
('STI', 'STONE(UK)[cite_start]'), -- [cite: 2]
('STN', 'TON (US) OR SHORT TON(UK/US)'); [cite_start]-- [cite: 2]

INSERT INTO [WeightUnit] (WeightUnit, Description)
SELECT s.WeightUnit, s.Description
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [WeightUnit] t 
    WHERE t.WeightUnit = s.WeightUnit
);

SET @WeightShortCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @WeightShortCount > 0
    PRINT CAST(@WeightShortCount AS NVARCHAR(10)) + ' records inserted successfully into Table WeightUnit.';
ELSE
    PRINT 'No new records were inserted into Table WeightUnit.';

COMMIT TRANSACTION;
GO