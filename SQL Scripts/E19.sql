-- =============================================================================
-- BATCH INSERT SCRIPT: PreservationType Table (E19)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @PreservTypeCount INT = 0;

CREATE TABLE #SourceData (
    PreservationCode CHAR(1),
    Description NVARCHAR(50)
);

-- Inserting data from E19.txt 
INSERT INTO #SourceData (PreservationCode, Description) VALUES
('C', 'CHILLED'), 
('F', 'FROZEN'), 
('U', 'UNREFRIGERATED'), 
('X', 'NULL'); 

INSERT INTO [PreservationType] (PreservationCode, Description)
SELECT s.PreservationCode, s.Description
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [PreservationType] t 
    WHERE t.PreservationCode = s.PreservationCode
);

SET @PreservTypeCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @PreservTypeCount > 0
    PRINT CAST(@PreservTypeCount AS NVARCHAR(10)) + ' records inserted successfully into Table PreservationType.';
ELSE
    PRINT 'No new records were inserted into Table PreservationType.';

COMMIT TRANSACTION;
GO