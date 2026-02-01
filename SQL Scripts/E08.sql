-- =============================================================================
-- BATCH INSERT SCRIPT: Declaration Estimate Indicator Table (E08)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @E08InsertCount INT = 0;

-- Temporary table to hold the source data from E08.txt
CREATE TABLE #E08Source (
    Indicator NCHAR(1),
    [Description] NVARCHAR(100)
);

-- Inserting data from E08.txt 
INSERT INTO #E08Source (Indicator, [Description]) VALUES
('C', 'Confirming'),    -- 
('M', 'Multiline'),     -- 
('N', 'Non-Confirming'); -- 

-- Insert only if the Indicator doesn't already exist in the target table
INSERT INTO [exlink].[DeclarationIndicator] (Indicator, [Description])
SELECT s.Indicator, s.[Description]
FROM #E08Source s
WHERE NOT EXISTS (
    SELECT 1 FROM [exlink].[DeclarationIndicator] t 
    WHERE t.Indicator = s.Indicator
);

SET @E08InsertCount = @@ROWCOUNT;

DROP TABLE #E08Source;

IF @E08InsertCount > 0
    PRINT CAST(@E08InsertCount AS NVARCHAR(10)) + ' records inserted successfully into [exlink].[DeclarationIndicator].';
ELSE
    PRINT 'No new records were inserted into [exlink].[DeclarationIndicator] (all records already exist).';

COMMIT TRANSACTION;
GO