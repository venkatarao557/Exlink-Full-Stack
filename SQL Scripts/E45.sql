-- =============================================================================
-- BATCH INSERT SCRIPT: IntendedUse Table (E45)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @UseCount INT = 0;

CREATE TABLE #SourceData (
    UseCode NVARCHAR(10),
    IntendedUse NVARCHAR(100)
);

INSERT INTO #SourceData (UseCode, IntendedUse) VALUES
('0001', 'PLANTING'),
('0002', 'CONSUMPTION'),
('0003', 'PROCESSING'),
('0004', 'DECORATION'),
('0005', 'SPROUTING FOR CONSUMPTION'),
('0006', 'RESEARCH');

INSERT INTO [IntendedUse] (UseCode, IntendedUse)
SELECT s.UseCode, s.IntendedUse
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [IntendedUse] t 
    WHERE t.UseCode = s.UseCode
);

SET @UseCount = @@ROWCOUNT;
DROP TABLE #SourceData;

IF @UseCount > 0
    PRINT CAST(@UseCount AS NVARCHAR(10)) + ' records inserted successfully into Table IntendedUse.';

COMMIT TRANSACTION;
GO