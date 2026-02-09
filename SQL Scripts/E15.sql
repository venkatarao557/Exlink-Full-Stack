-- =============================================================================
-- BATCH INSERT SCRIPT: WeightUnitAlternate Table (E15)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @WeightAltCount INT = 0;

CREATE TABLE #SourceData (
    WeightUnit NVARCHAR(10),
    Description NVARCHAR(100)
);

-- Inserting data from E15.txt 
INSERT INTO #SourceData (WeightUnit, Description) VALUES
('CGM', 'CENTIGRAM'), 
('CMK', 'CM²'), 
('CU ', 'CUBIC METRE'), 
('DTN', 'DECITONNE'), 
('GRM', 'GRAM'), 
('GRN', 'GRAIN'), 
('HGM', 'HECTOGRAM'), 
('JCM', 'JAS CBM'), 
('KGM', 'KILOGRAM'), 
('KTN', 'KILOTONNE'), 
('MGM', 'MILLIGRAM'), 
('MT ', 'M/TONS'), 
('MTK', 'METRIC TONNES OF 1,000 KILOS EACH'), 
('MTN', 'METRIC TONS'), 
('MTO', 'METRIC TON'), 
('MTS', 'M/TS'), 
('NO ', 'NUMBER'), 
('SM ', 'SQUARE METRE'), 
('SS ', 'STEMS'), 
('TN ', 'TONNES'), 
('TNE', 'TONNE (METRIC TONNE)'); 

INSERT INTO [WeightUnitAlternate] (WeightUnit, Description)
SELECT s.WeightUnit, s.Description
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [WeightUnitAlternate] t 
    WHERE t.WeightUnit = s.WeightUnit
);

SET @WeightAltCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @WeightAltCount > 0
    PRINT CAST(@WeightAltCount AS NVARCHAR(10)) + ' records inserted successfully into Table WeightUnitAlternate.';
ELSE
    PRINT 'No new records were inserted into Table WeightUnitAlternate.';

COMMIT TRANSACTION;
GO