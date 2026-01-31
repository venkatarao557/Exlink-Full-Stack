-- =============================================================================
-- BATCH INSERT SCRIPT: TreatmentConcentration Table (E42)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @ConcentrationCount INT = 0;

CREATE TABLE #SourceData (
    UnitCode NVARCHAR(10),
    Description NVARCHAR(255)
);

INSERT INTO #SourceData (UnitCode, Description) VALUES
('A93', 'GRAM PER CUBIC METRE'),
('A95', 'GRAY'),
('GE', 'LB/GAL (US)'),
('GL', 'GRAM PER LITRE'),
('GM', 'GRAM PER SQUARE METRE'),
('KMQ', 'KILOGRAM PER CUBIC METRE'),
('KX', 'MILLILITRE PER KILOGRAM');

INSERT INTO [TreatmentConcentration] (UnitCode, Description)
SELECT s.UnitCode, s.Description
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [TreatmentConcentration] t 
    WHERE t.UnitCode = s.UnitCode
);

SET @ConcentrationCount = @@ROWCOUNT;
DROP TABLE #SourceData;

IF @ConcentrationCount > 0
    PRINT CAST(@ConcentrationCount AS NVARCHAR(10)) + ' records inserted successfully into Table TreatmentConcentration.';

COMMIT TRANSACTION;
GO