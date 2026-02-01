use exlink
go
-- =============================================================================
-- BATCH INSERT SCRIPT: Region Table (E01)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @RegionCount INT = 0;

-- Temporary table to hold the source data
CREATE TABLE #SourceData (
    RegionCode NVARCHAR(10),
    RegionName NVARCHAR(100),
    Commodities NVARCHAR(255)
);

-- Inserting data from E01.txt 
INSERT INTO #SourceData (RegionCode, RegionName, Commodities) VALUES
('ADL', 'ADELAIDE', 'M,D,G,H,W,S,I'),
('BNE', 'BRISBANE', 'M,D,G,H,W,S,I'),
('CBR', 'CANBERRA', 'M,D,G,H,W,S,I'),
('DRW', 'DARWIN', 'M,D,W,S,I'),
('FLT', 'DUBBO', 'M,W,S,I'),
('HBA', 'HOBART', 'M,D,W,S,I'),
('MEL', 'MELBOURNE', 'M,D,G,H,W,S,I'),
('PER', 'PERTH', 'M,D,G,H,W,S,I'),
('SYD', 'SYDNEY', 'M,D,G,H,W,S,I'),
('TST', 'TEST REGION', 'M,D,F,G,H,W,S,I,E'),
('AD2', 'ADELAIDE', 'D,F,G,H,E'),
('BR2', 'BRISBANE - HORT GRAIN', 'D,F,G,H,E'),
('CNS', 'CAIRNS', 'D,F,G,H,E'),
('DR2', 'DARWIN', 'D,F,G,H,E'),
('HB2', 'HOBART', 'D,F,G,H,E'),
('ME2', 'MELBOURNE', 'D,F,G,H,E'),
('PE2', 'PERTH', 'D,F,E'),
('SY2', 'SYDNEY', 'D,F,G,H,E'),
('TSV', 'TOWNSVILLE', 'D,F,G,H,E'),
('BDB', 'BUNDABERG', 'G,H'),
('CB2', 'CANBERRA - NON MEAT', 'G,H'),
('EAG', 'EAGLE FARM', 'G,H'),
('HMA', 'HORTICULTURE ADMINISTRATOR', 'G,H'),
('ME3', 'MELBOURNE - GRAIN AND HORT', 'G,H'),
('MKY', 'MACKAY', 'G,H'),
('NTL', 'NEWCASTLE', 'G,H'),
('PE3', 'PERTH - GRAIN AND HORT', 'G,H'),
('PKL', 'PORT KEMBLA', 'G,H'),
('PTJ', 'PORTLAND', 'G,H'),
('RLM', 'ROCKLEA', 'G,H');

-- Insert only if the RegionCode doesn't already exist in the target table
INSERT INTO [Region] (RegionCode, RegionName, Commodities)
SELECT s.RegionCode, s.RegionName, s.Commodities
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [Region] t 
    WHERE t.RegionCode = s.RegionCode
);

SET @RegionCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @RegionCount > 0
    PRINT CAST(@RegionCount AS NVARCHAR(10)) + ' records inserted successfully into Table Region.';
ELSE
    PRINT 'No new records were inserted into Table Region (all records already exist).';

COMMIT TRANSACTION;
GO