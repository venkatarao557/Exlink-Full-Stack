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

-- Inserting data from E12.txt
INSERT INTO #SourceData (WeightUnit, Description) VALUES
('CWI', 'HUNDRED WEIGHT(UK)'),
('LBR', 'POUND'), 
('LTN', 'TON(UK) OR LONGTON(US)'), 
('ONZ', 'OUNCE'), 
('STI', 'STONE(UK)[cite_start]'), 
('STN', 'TON (US) OR SHORT TON(UK/US)');

INSERT INTO [WeightUnitShort] (WeightUnit, Description)
SELECT s.WeightUnit, s.Description
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [WeightUnitShort] t 
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