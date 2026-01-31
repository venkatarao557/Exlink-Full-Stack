-- =============================================================================
-- BATCH INSERT SCRIPT: CustomsWeightUnit Table (E36)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @CustomsWeightCount INT = 0;

CREATE TABLE #SourceData (
    WeightUnit NVARCHAR(10)
);

-- Inserting data from E36.txt
INSERT INTO #SourceData (WeightUnit) VALUES
('CT'),
('CU'),
('KGM'),
('KGS'),
('LTR'),
('NO'),
('NR'),
('SM'),
('TNE');

INSERT INTO [CustomsWeightUnit] (WeightUnit)
SELECT s.WeightUnit
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [CustomsWeightUnit] t 
    WHERE t.WeightUnit = s.WeightUnit
);

SET @CustomsWeightCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @CustomsWeightCount > 0
    PRINT CAST(@CustomsWeightCount AS NVARCHAR(10)) + ' records inserted successfully into Table CustomsWeightUnit.';
ELSE
    PRINT 'No new records were inserted into Table CustomsWeightUnit.';

COMMIT TRANSACTION;
GO