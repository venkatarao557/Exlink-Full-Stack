-- =============================================================================
-- BATCH INSERT SCRIPT: ProductUseIndicator Table (E32)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @ProdUseCount INT = 0;

CREATE TABLE #SourceData (
    UseCode CHAR(1),
    Description NVARCHAR(100)
);

-- Inserting data from E32.txt
INSERT INTO #SourceData (UseCode, Description) VALUES
('H', 'Human Consumption'),
('A', 'Animal Feeding Stuff'),
('F', 'Further Process'),
('T', 'Technical Use'),
('O', 'Other');

INSERT INTO [ProductUseIndicator] (UseCode, Description)
SELECT s.UseCode, s.Description
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [ProductUseIndicator] t 
    WHERE t.UseCode = s.UseCode
);

SET @ProdUseCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @ProdUseCount > 0
    PRINT CAST(@ProdUseCount AS NVARCHAR(10)) + ' records inserted successfully into Table ProductUseIndicator.';
ELSE
    PRINT 'No new records were inserted into Table ProductUseIndicator.';

COMMIT TRANSACTION;
GO