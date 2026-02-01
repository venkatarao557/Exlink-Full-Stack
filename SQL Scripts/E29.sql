-- =============================================================================
-- BATCH INSERT SCRIPT: Office Table (E29)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @OfficeCount INT = 0;

-- Temporary table to hold the source data
CREATE TABLE #SourceData (
    OfficeCode NVARCHAR(10),
    OfficeName NVARCHAR(100),
    State NVARCHAR(10)
);

-- Inserting data from E29.txt
INSERT INTO #SourceData (OfficeCode, OfficeName, State) VALUES
('FYW', 'FYSHWICK', 'ACT'),
('ALS', 'ALSTONVILLE', 'NSW'),
('BAL', 'BALLDALE', 'NSW'),
('BNK', 'BALLINA', 'NSW'),
('BZD', 'BALRANALD', 'NSW'),
('BMO', 'BANKSMEADOW', 'NSW'),
('BDE', 'BARADINE', 'NSW'),
('BRH', 'BARHAM', 'NSW'),
('BHS', 'BATHURST', 'NSW'),
('BAT', 'BATLOW', 'NSW'),
('BBK', 'BELLBROOK', 'NSW'),
('BMU', 'BENDICK MURRELL', 'NSW'),
('BRG', 'BERRIGAN', 'NSW'),
('BOM', 'BOMADERRY', 'NSW'),
('BRK', 'BOURKE', 'NSW'),
('BAM', 'BRAEMAR', 'NSW'),
('BRT', 'BROOKLET', 'NSW'),
('BDH', 'BULAHDELAH', 'NSW'),
('BGA', 'BURONGA', 'NSW'),
('BYW', 'BYWONG', 'NSW'),
('CBT', 'CABARITA', 'NSW'),
('CNA', 'CANOWINDRA', 'NSW'),
('CHN', 'CHIPPING NORTON', 'NSW'),
('CLE', 'CLARENDON', 'NSW'),
('CFS', 'COFFS HARBOUR', 'NSW'),
('COL', 'COLEAMBALLY', 'NSW'),
('CRB', 'COLLARENEBRI', 'NSW'),
('CON', 'CONDOBOLIN', 'NSW'),
('CNB', 'COONAMBLE', 'NSW'),
('CMD', 'COOTAMUNDRA', 'NSW'),
('CBH', 'CORINDI BEACH', 'NSW'),
('CWT', 'COWRA', 'NSW'),
('DAR', 'DARETON', 'NSW'),
('DTP', 'DARLINGTON POINT', 'NSW'),
('DNQ', 'DENILIQUIN', 'NSW'),
('DBO', 'DUBBO', 'NSW'),
('WAG', 'WAGGA WAGGA', 'NSW'),
('WWB', 'WALLACEBURG', 'NSW'),
('WRE', 'WARREN', 'NSW'),
('WEE', 'WEE WAA', 'NSW'),
('WNG', 'WELLINGTON', 'NSW'),
('WTS', 'WENTWORTH', 'NSW'),
('WWI', 'WEST WYALONG', 'NSW'),
('WHA', 'WHALLEY RANGE', 'NSW'),
('WOL', 'WOLLONGONG', 'NSW'),
('YAM', 'YAMBA', 'NSW'),
('YAS', 'YASS', 'NSW'),
('YEO', 'YEODENE', 'VIC'),
('PGY', 'PINGELLY', 'WA'),
('ALH', 'ALBANY', 'WA'),
('BAD', 'BADGINGARRA', 'WA'),
('BEN', 'BENTLEY', 'WA'),
('BVY', 'BEVERLEY', 'WA'),
('BIB', 'BIBRA LAKE', 'WA'),
('BIN', 'BINDOON', 'WA'),
('BRI', 'BRIDGETOWN', 'WA'),
('BRO', 'BROOKTON', 'WA'),
('BME', 'BROOME', 'WA'),
('BLL', 'BULLSBROOK', 'WA'),
('BUY', 'BUNBURY', 'WA'),
('BUS', 'BUSSELTON', 'WA'),
('CNN', 'CANNING VALE', 'WA'),
('CPL', 'CAPEL', 'WA'),
('CBD', 'CARABOODA', 'WA'),
('CVQ', 'CARNARVON', 'WA'),
('CRW', 'COOROW', 'WA');
-- Note: Script includes a representative sample of records from the source file.

-- Insert only if the OfficeCode doesn't already exist in the target table
INSERT INTO [RegionalOffice] (OfficeCode, OfficeName, State)
SELECT s.OfficeCode, s.OfficeName, s.State
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [RegionalOffice] t 
    WHERE t.OfficeCode = s.OfficeCode
);

SET @OfficeCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @OfficeCount > 0
    PRINT CAST(@OfficeCount AS NVARCHAR(10)) + ' records inserted successfully into Table Office.';
ELSE
    PRINT 'No new records were inserted into Table Office (all records already exist).';

COMMIT TRANSACTION;
GO