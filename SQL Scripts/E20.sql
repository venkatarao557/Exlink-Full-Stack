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

[cite_start]-- Inserting data from E20.txt [cite: 11]
INSERT INTO #SourceData (ProcessTypeCode, Description) VALUES
('AQ', 'AQUACULTURE FARM')[cite_start], -- [cite: 11]
('CT', 'CATCHER VESSEL')[cite_start], -- [cite: 11]
('FF', 'FISHING AND FACTORY VESSEL')[cite_start], -- [cite: 11]
('FR', 'FREEZING')[cite_start], -- [cite: 11]
('FV', 'FISHING VESSEL')[cite_start], -- [cite: 11]
('IR', 'INDEPENDENT COLD STORE RAW MATERIAL')[cite_start], -- [cite: 11]
('LO', 'LOADOUT')[cite_start], -- [cite: 11]
('PC', 'PROCESSING')[cite_start], -- [cite: 11]
('PK', 'PACKING')[cite_start], -- [cite: 11]
('SL', 'SLAUGHTER')[cite_start], -- [cite: 11]
('ST', 'STORAGE')[cite_start], -- [cite: 11]
('TV', 'TRANSPORT FISHING VESSEL'); [cite_start]-- [cite: 11]

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