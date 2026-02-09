-- =============================================================================
-- BATCH INSERT SCRIPT: ProcessType Table (E20)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @ProcessTypeCount INT = 0;

CREATE TABLE #SourceData (
    ProcessTypeCode NVARCHAR(10),
    Description NVARCHAR(100)
);

-- Inserting data from E20.txt 
INSERT INTO #SourceData (ProcessTypeCode, Description) VALUES
('AQ', 'AQUACULTURE FARM'), 
('CT', 'CATCHER VESSEL'), 
('FF', 'FISHING AND FACTORY VESSEL'), 
('FR', 'FREEZING'), 
('FV', 'FISHING VESSEL'), 
('IR', 'INDEPENDENT COLD STORE RAW MATERIAL'), 
('LO', 'LOADOUT'), 
('PC', 'PROCESSING'), 
('PK', 'PACKING'), 
('SL', 'SLAUGHTER'), 
('ST', 'STORAGE'), 
('TV', 'TRANSPORT FISHING VESSEL'); 

INSERT INTO [ProcessType] (ProcessTypeCode, Description)
SELECT s.ProcessTypeCode, s.Description
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [ProcessType] t 
    WHERE t.ProcessTypeCode = s.ProcessTypeCode
);

SET @ProcessTypeCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @ProcessTypeCount > 0
    PRINT CAST(@ProcessTypeCount AS NVARCHAR(10)) + ' records inserted successfully into Table ProcessType.';
ELSE
    PRINT 'No new records were inserted into Table ProcessType.';

COMMIT TRANSACTION;
GO