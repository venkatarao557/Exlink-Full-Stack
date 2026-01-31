-- =============================================================================
-- BATCH INSERT SCRIPT: TreatmentType Table (E34)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @TreatTypeCount INT = 0;

CREATE TABLE #SourceData (
    TreatmentTypeCode NVARCHAR(10),
    Description NVARCHAR(100)
);

-- Inserting data from E34.txt
INSERT INTO #SourceData (TreatmentTypeCode, Description) VALUES
('BI', 'BONE IN'),
('BO', 'DEBONED'),
('CA', 'CANNED'),
('CH', 'REFRIGERATED'),
('CHIL', 'CHILLED'),
('CHT', 'COMBINED HEAT TREATMENT'),
('COO', 'COOKED'),
('DR', 'DRIED'),
('EV', 'EVISCERATED'),
('FR', 'FROZEN'),
('FRE', 'FRESH'),
('HOM', 'HOMOGENISATION'),
('IS', 'IN SHELL'),
('LI', 'LIVE'),
('MI', 'MINCED'),
('MT', 'MATURED'),
('NRTE', 'NOT READY TO EAT'),
('NT', 'NO TERMAL TREATMENT'),
('PA', 'PASTEURISATION'),
('PC', 'PROCESSED'),
('PL', 'PLUCKED'),
('PR', 'PRESERVED'),
('PRE', 'PREPARED'),
('RM', 'RAW MILK'),
('RO', 'ROASTED'),
('RTE', 'READY TO EAT'),
('SA', 'SALTED'),
('SH', 'SHELLED'),
('SHT', 'SINGLE HEAT TREATMENT'),
('SK', 'SKINNED'),
('SM', 'SMOKED'),
('TR', 'TREATED'),
('UN', 'UNEVISCERATED'),
('UNP', 'UNPLUCKED'),
('US', 'UNSKINNED');

INSERT INTO [TreatmentType] (TreatmentTypeCode, Description)
SELECT s.TreatmentTypeCode, s.Description
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [TreatmentType] t 
    WHERE t.TreatmentTypeCode = s.TreatmentTypeCode
);

SET @TreatTypeCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @TreatTypeCount > 0
    PRINT CAST(@TreatTypeCount AS NVARCHAR(10)) + ' records inserted successfully into Table TreatmentType.';
ELSE
    PRINT 'No new records were inserted into Table TreatmentType.';

COMMIT TRANSACTION;
GO