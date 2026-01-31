-- =============================================================================
-- BATCH INSERT SCRIPT: Treatment Table (E30)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @TreatmentCount INT = 0;

-- Temporary table to hold the source data
CREATE TABLE #SourceData (
    TreatmentCode NVARCHAR(10),
    Description NVARCHAR(255)
);

-- Inserting data from E30.txt
INSERT INTO #SourceData (TreatmentCode, Description) VALUES
('ACID', 'ACIDIFICATION'),
('BDR', 'BATCH DRY RENDERING'),
('CHEMCL', 'CHEMICAL'),
('COLD', 'COLD TREATMENT'),
('D HEAT', 'DRY HEAT'),
('DEBARK', 'DEBARKING'),
('DEVIT', 'DEVITALIZATION'),
('DIHEAT', 'DIELECTRIC HEATING'),
('DIPPED', 'DIPPED'),
('DISINF', 'COLD DISINFESTATION TREATMENT'),
('DRENCH', 'DRENCHED'),
('DUSTED', 'DUSTED'),
('FLOOD', 'FLOOD SPRAYED'),
('FUMIG', 'FUMIGATED'),
('FUNGIC', 'FUNGICIDE TREATED'),
('HEAT', 'HEAT TREATED'),
('HWTRET', 'HOT WATER TREATMENT'),
('IMMERS', 'FULL IMMERSION'),
('INSECT', 'WIDE SPECTRUM INSECTICIDE'),
('INTRAN', 'SUBJECT TO IN-TRANSIT'),
('IRRAD', 'IRRADIATION'),
('KILN', 'KILN DRIED'),
('M HEAT', 'MOIST HEAT'),
('NEMAT', 'NEMATICIDE TREATED'),
('OTHPST', 'OTHER PESTICIDE'),
('PASTEU', 'PASTEURISED'),
('PC DES', 'SEED TREATED AS DESCRIBED ABOVE'),
('PRECOL', 'FRUIT PRECOOLED'),
('RE-CON', 'RE-CONDITIONED FUMIGATED'),
('REFER', 'DECLARATION OF TREATMENT AS ATTACHED'),
('SEDCOT', 'SEED COATING'),
('SLURRY', 'SLURRY TREATMENT -'),
('SPRAY', 'SPRAYED'),
('V HEAT', 'VAPOUR HEAT'),
('W HEAT', 'WET HEAT');

-- Insert only if the TreatmentCode doesn't already exist in the target table
INSERT INTO [Treatment] (TreatmentCode, Description)
SELECT s.TreatmentCode, s.Description
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [Treatment] t 
    WHERE t.TreatmentCode = s.TreatmentCode
);

SET @TreatmentCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @TreatmentCount > 0
    PRINT CAST(@TreatmentCount AS NVARCHAR(10)) + ' records inserted successfully into Table Treatment.';
ELSE
    PRINT 'No new records were inserted into Table Treatment (all records already exist).';

COMMIT TRANSACTION;
GO