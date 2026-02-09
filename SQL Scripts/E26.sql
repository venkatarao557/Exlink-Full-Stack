-- =============================================================================
-- BATCH INSERT SCRIPT: TransportMode Table (E26)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @TransModeCount INT = 0;

CREATE TABLE #SourceData (
    ModeCode INT,
    Description NVARCHAR(50)
);

-- Inserting data from E26.txt
INSERT INTO #SourceData (ModeCode, Description) VALUES
(1, 'SEA'),
(4, 'AIR'),
(5, 'MAIL')

INSERT INTO [TransportMode] (ModeCode, Description)
SELECT s.ModeCode, s.Description
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [TransportMode] t 
    WHERE t.ModeCode = s.ModeCode
);

SET @TransModeCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @TransModeCount > 0
    PRINT CAST(@TransModeCount AS NVARCHAR(10)) + ' records inserted successfully into Table TransportMode.';
ELSE
    PRINT 'No new records were inserted into Table TransportMode.';

COMMIT TRANSACTION;
GO