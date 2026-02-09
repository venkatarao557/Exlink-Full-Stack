-- =============================================================================
-- BATCH INSERT SCRIPT: PackageType Table (E17)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @PackageTypeCount INT = 0;

CREATE TABLE #SourceData (
    PackageTypeCode NVARCHAR(10),
    Description NVARCHAR(255)
);

-- Inserting data from E17.txt 
INSERT INTO #SourceData (PackageTypeCode, Description) VALUES
('BE', 'BUNDLES'), 
('BG', 'BAGS'), 
('BI', 'BULK BINS'), 
('BK', 'BLOCKS'), 
('BL', 'BALES'), 
('BO', 'BOTTLES'), 
('BP', 'BULK PACK'), 
('BX', 'BOX'), 
('CA', 'CANS'), 
('CB', 'CUTTINGS'), 
('CD', 'SIDES'), 
('CF', 'COFFINS'), 
('CK', 'CASKS'), 
('CN', 'CONTAINER'), 
('CQ', 'QUARTERS'), 
('CR', 'CRATE'), 
('CT', 'CARTONS'), 
('CW', 'CARCASES'), 
('DR', 'DRUMS'), 
('DZ', 'DOZENS'), 
('EN', 'ENVELOPES'), 
('FE', 'FLEXITANK'), 
('FL', 'FLASKS'), 
('JA', 'JARS'), 
('MX', 'MIXED SHIPMENTS'), 
('OC', 'OCTOBINS'), 
('PA', 'PACKETS'), 
('PB', 'POLYSTYRENE BOX'), 
('PC', 'PIECES'), 
('PF', 'PALLETS'), 
('PJ', 'PUNNETS'), 
('PL', 'PAILS'), 
('PM', 'PLANTS'), 
('PP', 'PIECE'), 
('PR', 'PLASTIC RECEPTACLE'), 
('PS', 'PACKS'), 
('PW', 'PARCEL'), 
('QR', 'POLYSTYRENE BOX'), 
('RO', 'ROLLS'), 
('SC', 'SACHETS'), 
('SO', 'SPOOLS'), 
('SS', 'STEMS'), 
('TB', 'TUBES'), 
('TK', 'TANK'), 
('TP', 'TRAY PACKED'), 
('TU', 'TUBS'), 
('UP', 'ULTIMATE PACKS'), 
('VI', 'VIALS'), 
('VL', 'BULK LIQUID'), 
('VR', 'BULK'); 

INSERT INTO [PackageType] (PackageTypeCode, Description)
SELECT s.PackageTypeCode, s.Description
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [PackageType] t 
    WHERE t.PackageTypeCode = s.PackageTypeCode
);

SET @PackageTypeCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @PackageTypeCount > 0
    PRINT CAST(@PackageTypeCount AS NVARCHAR(10)) + ' records inserted successfully into Table PackageType.';
ELSE
    PRINT 'No new records were inserted into Table PackageType.';

COMMIT TRANSACTION;
GO