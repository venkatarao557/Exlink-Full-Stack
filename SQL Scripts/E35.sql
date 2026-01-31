-- =============================================================================
-- BATCH INSERT SCRIPT: State Table (E35)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @StateCount INT = 0;

CREATE TABLE #SourceData (
    StateCode NVARCHAR(10),
    StateName NVARCHAR(100)
);

-- Inserting data from E35.txt
INSERT INTO #SourceData (StateCode, StateName) VALUES
('ACT', 'AUSTRALIAN CAPITAL TERRITORY'),
('FO', 'FOREIGN'),
('NSW', 'NEW SOUTH WALES'),
('NT', 'NORTHERN TERRITORY'),
('QLD', 'QUEENSLAND'),
('SA', 'SOUTH AUSTRALIA'),
('TAS', 'TASMANIA'),
('VIC', 'VICTORIA'),
('WA', 'WESTERN AUSTRALIA');

INSERT INTO [State] (StateCode, StateName)
SELECT s.StateCode, s.StateName
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [State] t 
    WHERE t.StateCode = s.StateCode
);

SET @StateCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @StateCount > 0
    PRINT CAST(@StateCount AS NVARCHAR(10)) + ' records inserted successfully into Table State.';
ELSE
    PRINT 'No new records were inserted into Table State.';

COMMIT TRANSACTION;
GO