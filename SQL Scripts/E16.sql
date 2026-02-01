-- =============================================================================
-- BATCH INSERT SCRIPT: PackType Table (E16)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @PackTypeCount INT = 0;

-- Temporary table to hold the source data from E16.txt 
CREATE TABLE #E16Source (
PackTypeCode NVARCHAR(10),
Description NVARCHAR(255)
);

-- Inserting data from E16.txt 
INSERT INTO #E16Source (PackTypeCode, Description) VALUES
('BB', 'BAG IN A BOX'), 
('BE', 'BUNDLES'), 
('BG', 'BAGS'), 
('BI', 'BINS'), 
('BK', 'BLOCKS'), 
('BL', 'BALES'), 
('BP', 'BULK PACK'), 
('BT', 'BULK TANK AS IN SHIPS HOLD'), 
('BX', 'BOX'), 
('CA', 'CANS'), 
('CB', 'CUTTINGS'), 
('CN', 'CONTAINERS'), 
('CR', 'CRATE'), 
('CS', 'BONE-IN CARCASE QUARTERS AND SIDES'), 
('CT', 'CARTONS'), 
('DM', 'DRUMS'), 
('DZ', 'DOZENS'), 
('EN', 'ENVELOPES'), 
('ES', 'ESKY'), 
('FE', 'FLEXITANK'), 
('FL', 'FLASKS'), 
('GP', 'GIFT PACK'), 
('IV', 'INDIVIDUALLY WRAPPED/VACUUM PACKED'), 
('IW', 'INDIVIDUALLY WRAPPED PACK'), 
('JA', 'JARS'), 
('LP', 'LAYER PACK'), 
('LV', 'LAYER PACK/VACUUM PACKED'), 
('MA', 'MODIFIED ATMOSPHERIC PACKAGING'), 
('MV', 'MULTI WRAPPED/VACUUM PACKED'), 
('MW', 'MULTI WRAPPED PACK'), 
('OC', 'OCTOBINS'), 
('PA', 'PACKETS'), 
('PB', 'PLASTIC BOTTLES'), 
('PC', 'PIECES'), 
('PF', 'PALLETS'), 
('PJ', 'PUNNETS'), 
('PL', 'PAILS'), 
('PM', 'PLANTS'), 
('PP', 'PARCEL'), 
('PR', 'PLASTIC RECEPTACLE'), 
('PS', 'PACKS'), 
('PX', 'POLYSTYRENE BOXES'), 
('RO', 'ROLLS'), 
('SC', 'SACHET'), 
('SO', 'SPOOL'), 
('SS', 'STEMS'), 
('TB', 'TUBES'), 
('TI', 'TINS'), 
('TP', 'TRAY PACKED'), 
('TU', 'TUBS'), 
('TV', 'TRAY PACKED/VACUUM PACKED'), 
('UP', 'ULTIMATE PACK'), 
('VI', 'VIALS'), 
('VL', 'BULK LIQUID'), 
('VP', 'VACUUM PACKED'), 
('VR', 'BULK'), 
('WA', 'WAXED'); 

-- Insert only if the PackTypeCode doesn't already exist in the target table
INSERT INTO [PackType] (PackTypeCode, Description)
SELECT s.PackTypeCode, s.Description
FROM #E16Source s
WHERE NOT EXISTS (
SELECT 1 FROM [PackType] t
WHERE t.PackTypeCode = s.PackTypeCode
);

SET @PackTypeCount = @@ROWCOUNT;

DROP TABLE #E16Source;

IF @PackTypeCount > 0
PRINT CAST(@PackTypeCount AS NVARCHAR(10)) + ' records inserted successfully into Table PackType.';
ELSE
PRINT 'No new records were inserted into Table PackType (all records already exist).';

COMMIT TRANSACTION;
GO
