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

[cite_start]-- Inserting data from E19.txt [cite: 10]
INSERT INTO #SourceData (PreservationCode, Description) VALUES
('C', 'CHILLED')[cite_start], -- [cite: 10]
('F', 'FROZEN')[cite_start], -- [cite: 10]
('U', 'UNREFRIGERATED')[cite_start], -- [cite: 10]
('X', 'NULL'); [cite_start]-- [cite: 10]

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