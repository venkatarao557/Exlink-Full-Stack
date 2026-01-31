-- =============================================================================
-- BATCH INSERT SCRIPT: ProductPart Table (E44)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @PartCount INT = 0;

CREATE TABLE #SourceData (
    PartCode NVARCHAR(10),
    PartName NVARCHAR(100)
);

INSERT INTO #SourceData (PartCode, PartName) VALUES
('0001', 'SEEDS'),
('0002', 'PLANTS'),
('0003', 'BULBS'),
('0004', 'TUBERS'),
('0005', 'MINITUBERS'),
('0006', 'RHIZOMES'),
('0007', 'STOLONS'),
('0008', 'CORMS'),
('0009', 'BUDWOOD'),
('0010', 'CUTTINGS'),
('0011', 'POLLEN'),
('0012', 'BUDS'),
('0013', 'PLANTLETS'),
('0014', 'GRAIN'),
('0015', 'FLOWERS'),
('0016', 'FOLIAGE'),
('0017', 'BRANCHES'),
('0018', 'FRUITS'),
('0019', 'VEGETABLES'),
('0020', 'WOOD'),
('0021', 'WOOD PACKAGING MATERIAL'),
('0022', 'BARREL'),
('0023', 'FIREWOOD'),
('0024', 'BARK'),
('0025', 'SOIL'),
('0026', 'PEAT'),
('0027', 'MACHINERY');

INSERT INTO [ProductPart] (PartCode, PartName)
SELECT s.PartCode, s.PartName
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [ProductPart] t 
    WHERE t.PartCode = s.PartCode
);

SET @PartCount = @@ROWCOUNT;
DROP TABLE #SourceData;

IF @PartCount > 0
    PRINT CAST(@PartCount AS NVARCHAR(10)) + ' records inserted successfully into Table ProductPart.';

COMMIT TRANSACTION;
GO