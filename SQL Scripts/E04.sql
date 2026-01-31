-- =============================================================================
-- BATCH INSERT SCRIPT: Commodity Table (E04)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @CommInsertCount INT = 0;

-- Temporary table to hold the source data from E04.txt
CREATE TABLE #E04Source (
    CommodityCode NVARCHAR(1),
    CommodityDescription NVARCHAR(100)
);

-- Inserting data from E04.txt 
INSERT INTO #E04Source (CommodityCode, CommodityDescription) VALUES
('A', 'HONEY'),
('D', 'DAIRY'),
('E', 'EGGS'),
('F', 'FISH'),
('G', 'GRAINS & SEEDS'),
('H', 'HORTICULTURE'),
('I', 'INEDIBLE MEAT'),
('M', 'MEAT'),
('S', 'SKINS AND HIDES'),
('W', 'WOOL'),
('X', 'OTHER GOODS');

-- Insert only if the CommodityCode doesn't already exist in the target table
INSERT INTO [exlink].[Commodity] (CommodityCode, CommodityDescription)
SELECT s.CommodityCode, s.CommodityDescription
FROM #E04Source s
WHERE NOT EXISTS (
    SELECT 1 FROM [exlink].[Commodity] t 
    WHERE t.CommodityCode = s.CommodityCode
);

SET @CommInsertCount = @@ROWCOUNT;

DROP TABLE #E04Source;

IF @CommInsertCount > 0
    PRINT CAST(@CommInsertCount AS NVARCHAR(10)) + ' records inserted successfully into [exlink].[Commodity].';
ELSE
    PRINT 'No new records were inserted into [exlink].[Commodity] (all records already exist).';

COMMIT TRANSACTION;
GO