-- =============================================================================
-- BATCH INSERT SCRIPT: DominantProduct Table (E38)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @DominantProdCount INT = 0;

CREATE TABLE #SourceData (
    ProductName NVARCHAR(100)
);

INSERT INTO #SourceData (ProductName) VALUES
('BEEF'),
('BEEF/SHEEP'),
('CAMEL'),
('EMU'),
('GOAT'),
('KANGAROO'),
('LAMB'),
('MUTTON'),
('OSTRICH'),
('PORK'),
('RHEA'),
('VEAL');

INSERT INTO [DominantProduct] (ProductName)
SELECT s.ProductName
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [DominantProduct] t 
    WHERE t.ProductName = s.ProductName
);

SET @DominantProdCount = @@ROWCOUNT;
DROP TABLE #SourceData;

IF @DominantProdCount > 0
    PRINT CAST(@DominantProdCount AS NVARCHAR(10)) + ' records inserted successfully into Table DominantProduct.';
ELSE
    PRINT 'No new records were inserted into Table DominantProduct.';

COMMIT TRANSACTION;
GO