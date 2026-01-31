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

[cite_start]-- Inserting data from E17.txt [cite: 7]
INSERT INTO #SourceData (PackageTypeCode, Description) VALUES
('BE', 'BUNDLES')[cite_start], -- [cite: 7]
('BG', 'BAGS')[cite_start], -- [cite: 7]
('BI', 'BULK BINS')[cite_start], -- [cite: 7]
('BK', 'BLOCKS')[cite_start], -- [cite: 7]
('BL', 'BALES')[cite_start], -- [cite: 7]
('BO', 'BOTTLES')[cite_start], -- [cite: 7]
('BP', 'BULK PACK')[cite_start], -- [cite: 7]
('BX', 'BOX')[cite_start], -- [cite: 7]
('CA', 'CANS')[cite_start], -- [cite: 7]
('CB', 'CUTTINGS')[cite_start], -- [cite: 7]
('CD', 'SIDES')[cite_start], -- [cite: 7]
('CF', 'COFFINS')[cite_start], -- [cite: 7]
('CK', 'CASKS')[cite_start], -- [cite: 7]
('CN', 'CONTAINER')[cite_start], -- [cite: 7]
('CQ', 'QUARTERS')[cite_start], -- [cite: 7]
('CR', 'CRATE')[cite_start], -- [cite: 7]
('CT', 'CARTONS')[cite_start], -- [cite: 7]
('CW', 'CARCASES')[cite_start], -- [cite: 7]
('DR', 'DRUMS')[cite_start], -- [cite: 7]
('DZ', 'DOZENS')[cite_start], -- [cite: 7]
('EN', 'ENVELOPES')[cite_start], -- [cite: 7]
('FE', 'FLEXITANK')[cite_start], -- [cite: 7]
('FL', 'FLASKS')[cite_start], -- [cite: 7]
('JA', 'JARS')[cite_start], -- [cite: 7]
('MX', 'MIXED SHIPMENTS')[cite_start], -- [cite: 7]
('OC', 'OCTOBINS')[cite_start], -- [cite: 7]
('PA', 'PACKETS')[cite_start], -- [cite: 7]
('PB', 'POLYSTYRENE BOX')[cite_start], -- [cite: 7]
('PC', 'PIECES')[cite_start], -- [cite: 7]
('PF', 'PALLETS')[cite_start], -- [cite: 7]
('PJ', 'PUNNETS')[cite_start], -- [cite: 7]
('PL', 'PAILS')[cite_start], -- [cite: 7]
('PM', 'PLANTS')[cite_start], -- [cite: 7]
('PP', 'PIECE')[cite_start], -- [cite: 7]
('PR', 'PLASTIC RECEPTACLE')[cite_start], -- [cite: 7]
('PS', 'PACKS')[cite_start], -- [cite: 7]
('PW', 'PARCEL')[cite_start], -- [cite: 7]
('QR', 'POLYSTYRENE BOX')[cite_start], -- [cite: 7]
('RO', 'ROLLS')[cite_start], -- [cite: 7]
('SC', 'SACHETS')[cite_start], -- [cite: 7]
('SO', 'SPOOLS')[cite_start], -- [cite: 7]
('SS', 'STEMS')[cite_start], -- [cite: 7]
('TB', 'TUBES')[cite_start], -- [cite: 7]
('TK', 'TANK')[cite_start], -- [cite: 7]
('TP', 'TRAY PACKED')[cite_start], -- [cite: 7]
('TU', 'TUBS')[cite_start], -- [cite: 7]
('UP', 'ULTIMATE PACKS')[cite_start], -- [cite: 7]
('VI', 'VIALS')[cite_start], -- [cite: 7]
('VL', 'BULK LIQUID')[cite_start], -- [cite: 7]
('VR', 'BULK'); [cite_start]-- [cite: 7]

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