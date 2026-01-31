-- =============================================================================
-- BATCH INSERT SCRIPT: QualityQualifier Table (E22)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @QualityQualCount INT = 0;

-- Temporary table to hold the source data
CREATE TABLE #SourceData (
    QualityQualifier NVARCHAR(100)
);

-- Inserting data from E22.txt (Header only in source)
-- INSERT INTO #SourceData (QualityQualifier) VALUES
-- ('Example Quality'); 

-- Insert only if the QualityQualifier doesn't already exist
INSERT INTO [QualityQualifier] (QualityQualifier)
SELECT s.QualityQualifier
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [QualityQualifier] t 
    WHERE t.QualityQualifier = s.QualityQualifier
);

SET @QualityQualCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @QualityQualCount > 0
    PRINT CAST(@QualityQualCount AS NVARCHAR(10)) + ' records inserted successfully into Table QualityQualifier.';
ELSE
    PRINT 'No new records were inserted into Table QualityQualifier (file contained header only).';

COMMIT TRANSACTION;
GO