-- =============================================================================
-- BATCH INSERT SCRIPT: Declaration Estimate Indicator Table (E08)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @E08InsertCount INT = 0;

-- Temporary table to hold the source data from E08.txt
CREATE TABLE #E08Source (
    [IndicatorCode] NCHAR(1),
    [Description] NVARCHAR(100)
);

-- Inserting data from E08.txt 
INSERT INTO #E08Source ([IndicatorCode], [Description]) VALUES
('C', 'Confirming'),    -- 
('M', 'Multiline'),     -- 
('N', 'Non-Confirming'); -- 

-- Insert only if the IndicatorCode doesn't already exist in the target table
INSERT INTO [DeclarationIndicator] (IndicatorCode, [Description])
SELECT s.[IndicatorCode], s.[Description]
FROM #E08Source s
WHERE NOT EXISTS (
    SELECT 1 FROM [DeclarationIndicator] t 
    WHERE t.IndicatorCode = s.IndicatorCode
);

SET @E08InsertCount = @@ROWCOUNT;

DROP TABLE #E08Source;

IF @E08InsertCount > 0
    PRINT CAST(@E08InsertCount AS NVARCHAR(10)) + ' records inserted successfully into [DeclarationIndicator].';
ELSE
    PRINT 'No new records were inserted into [DeclarationIndicator] (all records already exist).';

COMMIT TRANSACTION;
GO

