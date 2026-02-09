-- =============================================================================
-- BATCH INSERT SCRIPT: LocationQualifier Table (E13)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @LocQualCount INT = 0;

CREATE TABLE #SourceData (
    LocationQualifier NVARCHAR(100)
);

-- Inserting data from E13.txt [cite: 3]
INSERT INTO #SourceData (LocationQualifier) VALUES
('Australian'),
('Tasmanian'); 

INSERT INTO [LocationQualifier] (LocationQualifier)
SELECT s.LocationQualifier
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [LocationQualifier] t 
    WHERE t.LocationQualifier = s.LocationQualifier
);

SET @LocQualCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @LocQualCount > 0
    PRINT CAST(@LocQualCount AS NVARCHAR(10)) + ' records inserted successfully into Table LocationQualifier.';
ELSE
    PRINT 'No new records were inserted into Table LocationQualifier.';

COMMIT TRANSACTION;
GO