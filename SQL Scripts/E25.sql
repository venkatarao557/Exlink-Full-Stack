-- =============================================================================
-- BATCH INSERT SCRIPT: SupplementaryCode Table (E25)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @SuppCodeCount INT = 0;

CREATE TABLE #SourceData (
    SupplementaryCode NVARCHAR(10),
    Description NVARCHAR(255),
    ApplicableCommodities NVARCHAR(100)
);

-- Inserting data from E25.txt
INSERT INTO #SourceData (SupplementaryCode, Description, ApplicableCommodities) VALUES
('A', 'AGED', 'M'),
('AQ', 'AQUACULTURE', 'F'),
('B', 'EXEMPTION', 'M'),
('BG', 'US BEEF FOR GRINDING', 'M'),
('C', 'ACCELERATED CONDITIONING', 'M'),
('CE', 'CALF INTESTINES FOR ENZYME EXTRACTI', 'M'),
('DM', 'MANUFACTURING GRADE', 'D'),
('E', 'ELECTRICAL STIMULATION', 'M'),
('EA', 'EU BALAI PRODUCT (ANNEX A)', 'S'),
('EB', 'EU BALAI PRODUCT (ANNEX A)', 'S'),
('EC', 'EU BALAI PRODUCT (ANNEX A)', 'S'),
('ED', 'EU BALAI PRODUCT (ANNEX A)', 'S'),
('EE', 'EU BALAI PRODUCT (ANNEX A)', 'S'),
('EF', 'EU BALAI PRODUCT (ANNEX A)', 'S'),
('EG', 'EU BALAI PRODUCT (ANNEX B)', 'S'),
('EH', 'EU BALAI PRODUCT (ANNEX B)', 'S'),
('EI', 'EU BALAI PRODUCT (ANNEX B)', 'S'),
('EJ', 'EU BALAI PRODUCT (ANNEX B)', 'S'),
('EK', 'EU BALAI PRODUCT (ANNEX B)', 'S'),
('EL', 'EU BALAI PRODUCT (ANNEX B)', 'S'),
('EM', 'EU BALAI PRODUCT (ANNEX B)', 'S'),
('EN', 'EU BALAI PRODUCT (ANNEX B)', 'S'),
('F', 'FARL', 'M'),
('G', 'GRAIN FED', 'M'),
('GC', 'CONSUMPTION', 'G,H'),
('GD', 'DECORATION', 'G,H'),
('GF', 'STOCKFEED', 'G,H'),
('GH', 'SPROUTING FOR CONSUMPTION', 'G,H'),
('GM', 'SPROUTING FOR CONSUMPTION', 'G,H'),
('GP', 'PROCESSING', 'G,H'),
('GR', 'RESEARCH', 'G,H'),
('GS', 'PLANTING', 'G,H'),
('H', 'COOKED', 'M,E'),
('HQ', 'GRAIN FED HIGH QUALITY BEEF', 'M'),
('I', 'IRRADIATED', 'M'),
('J', 'FOR US DEFENCE FORCES', 'M'),
('L', 'LOT FED', 'M'),
('LA', 'LIVE AQUACULTURE', 'F'),
('LW', 'LIVE WILD ORIGIN', 'F'),
('M', 'MILK FED', 'M'),
('O', 'ORGANIC', 'M'),
('PF', 'PERFORMANCE ENHANCEMENT FREE', 'M'),
('R', 'FED', 'M'), -- Derived from "RANGE FED" spanning lines
('S', 'GRASS FED', 'M'),
('T', 'TENDER STRETCHED', 'M'),
('T1', 'JJ', 'M'),
('TX', 'EU TRANSIT', 'M'),
('V', 'GILT PORK - SINGAPORE ONLY', 'M'),
('WO', 'NON VIABLE WILD ORIGIN', 'F'),
('X', 'BARROW PORK - SINGAPORE ONLY', 'M')[cite_start]; [cite: 15, 16]

INSERT INTO [SupplementaryCode] (SupplementaryCode, Description, ApplicableCommodities)
SELECT s.SupplementaryCode, s.Description, s.ApplicableCommodities
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [SupplementaryCode] t 
    WHERE t.SupplementaryCode = s.SupplementaryCode
);

SET @SuppCodeCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @SuppCodeCount > 0
    PRINT CAST(@SuppCodeCount AS NVARCHAR(10)) + ' records inserted successfully into Table SupplementaryCode.';
ELSE
    PRINT 'No new records were inserted into Table SupplementaryCode.';

COMMIT TRANSACTION;
GO