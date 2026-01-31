-- =============================================================================
-- BATCH INSERT SCRIPT: ProductCondition Table (E43)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @ConditionCount INT = 0;

CREATE TABLE #SourceData (
    ConditionCode NVARCHAR(10),
    ConditionName NVARCHAR(100)
);

INSERT INTO #SourceData (ConditionCode, ConditionName) VALUES
('0001', 'ROOTED'),
('0002', 'UNROOTED'),
('0003', 'BARE-ROOTED'),
('0004', 'WITHOUT LEAVES OR FLOWERS'),
('0005', 'DORMANT'),
('0006', 'WITH BARK'),
('0007', 'DEBARKED'),
('0008', 'BARK-FREE'),
('0009', 'DRIED'),
('0010', 'CHOPPED'),
('0011', 'PEELED'),
('0012', 'SHELLED'),
('0013', 'FRESH'),
('0014', 'FROZEN'),
('0015', 'WITH GROWING MEDIUM'),
('0016', 'POTTED'),
('0017', 'CHEMICAL PRESSURE IMPREGNATED'),
('0018', 'HEAT TREATED'),
('0019', 'DUST'),
('0020', 'SHAVINGS'),
('0021', 'ROUND'),
('0022', 'SAWN'),
('0023', 'CHIPS'),
('0024', 'CUT');

INSERT INTO [ProductCondition] (ConditionCode, ConditionName)
SELECT s.ConditionCode, s.ConditionName
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [ProductCondition] t 
    WHERE t.ConditionCode = s.ConditionCode
);

SET @ConditionCount = @@ROWCOUNT;
DROP TABLE #SourceData;

IF @ConditionCount > 0
    PRINT CAST(@ConditionCount AS NVARCHAR(10)) + ' records inserted successfully into Table ProductCondition.';

COMMIT TRANSACTION;
GO