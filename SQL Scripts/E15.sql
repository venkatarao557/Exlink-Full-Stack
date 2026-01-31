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

[cite_start]-- Inserting data from E15.txt [cite: 5]
INSERT INTO #SourceData (WeightUnit, Description) VALUES
('CGM', 'CENTIGRAM')[cite_start], -- [cite: 5]
('CMK', 'CM²')[cite_start], -- [cite: 5]
('CU ', 'CUBIC METRE')[cite_start], -- [cite: 5]
('DTN', 'DECITONNE')[cite_start], -- [cite: 5]
('GRM', 'GRAM')[cite_start], -- [cite: 5]
('GRN', 'GRAIN')[cite_start], -- [cite: 5]
('HGM', 'HECTOGRAM')[cite_start], -- [cite: 5]
('JCM', 'JAS CBM')[cite_start], -- [cite: 5]
('KGM', 'KILOGRAM')[cite_start], -- [cite: 5]
('KTN', 'KILOTONNE')[cite_start], -- [cite: 5]
('MGM', 'MILLIGRAM')[cite_start], -- [cite: 5]
('MT ', 'M/TONS')[cite_start], -- [cite: 5]
('MTK', 'METRIC TONNES OF 1,000 KILOS EACH')[cite_start], -- [cite: 5]
('MTN', 'METRIC TONS')[cite_start], -- [cite: 5]
('MTO', 'METRIC TON')[cite_start], -- [cite: 5]
('MTS', 'M/TS')[cite_start], -- [cite: 5]
('NO ', 'NUMBER')[cite_start], -- [cite: 5]
('SM ', 'SQUARE METRE')[cite_start], -- [cite: 5]
('SS ', 'STEMS')[cite_start], -- [cite: 5]
('TN ', 'TONNES')[cite_start], -- [cite: 5]
('TNE', 'TONNE (METRIC TONNE)'); [cite_start]-- [cite: 5]

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