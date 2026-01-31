-- =============================================================================
-- BATCH INSERT SCRIPT: UnitOfMeasure Table (E14)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @UOMCount INT = 0;

CREATE TABLE #SourceData (
    UnitCode NVARCHAR(10),
    UnitType NVARCHAR(50),
    Description NVARCHAR(100)
);

[cite_start]-- Inserting data from E14.txt [cite: 4]
INSERT INTO #SourceData (UnitCode, UnitType, Description) VALUES
('CMT', 'LENGTH', 'CENTIMETRE')[cite_start], -- [cite: 4]
('DMT', 'LENGTH', 'DECIMETRE')[cite_start], -- [cite: 4]
('MTR', 'LENGTH', 'METRE')[cite_start], -- [cite: 4]
('CGM', 'MASS', 'CENTIGRAM')[cite_start], -- [cite: 4]
('CMK', 'MASS', 'CM²')[cite_start], -- [cite: 4]
('CU ', 'MASS', 'CUBIC METRE')[cite_start], -- [cite: 4]
('CWI', 'MASS', 'HUNDRED WEIGHT(UK)[cite_start]'), -- [cite: 4]
('DTN', 'MASS', 'DECITONNE')[cite_start], -- [cite: 4]
('GRM', 'MASS', 'GRAM')[cite_start], -- [cite: 4]
('GRN', 'MASS', 'GRAIN')[cite_start], -- [cite: 4]
('HGM', 'MASS', 'HECTOGRAM')[cite_start], -- [cite: 4]
('JCM', 'MASS', 'JAS CBM')[cite_start], -- [cite: 4]
('KGM', 'MASS', 'KILOGRAM')[cite_start], -- [cite: 4]
('KTN', 'MASS', 'KILOTONNE')[cite_start], -- [cite: 4]
('LBR', 'MASS', 'POUND')[cite_start], -- [cite: 4]
('LTN', 'MASS', 'TON(UK) [cite_start]OR LONGTON(US)'), -- [cite: 4]
('MGM', 'MASS', 'MILLIGRAM')[cite_start], -- [cite: 4]
('MT ', 'MASS', 'M/TONS')[cite_start], -- [cite: 4]
('MTK', 'MASS', 'METRIC TONNES OF 1,000 KILOS EACH')[cite_start], -- [cite: 4]
('MTN', 'MASS', 'METRIC TONS')[cite_start], -- [cite: 4]
('MTO', 'MASS', 'METRIC TON')[cite_start], -- [cite: 4]
('MTS', 'MASS', 'M/TS')[cite_start], -- [cite: 4]
('NO ', 'MASS', 'NUMBER')[cite_start], -- [cite: 4]
('ONZ', 'MASS', 'OUNCE')[cite_start], -- [cite: 4]
('SM ', 'MASS', 'SQUARE METRE')[cite_start], -- [cite: 4]
('SS ', 'MASS', 'STEMS')[cite_start], -- [cite: 4]
('STI', 'MASS', 'STONE(UK)[cite_start]'), -- [cite: 4]
('STN', 'MASS', 'TON (US) [cite_start]OR SHORT TON(UK/US)'), -- [cite: 4]
('TN ', 'MASS', 'TONNES')[cite_start], -- [cite: 4]
('TNE', 'MASS', 'TONNE (METRIC TONNE)[cite_start]'), -- [cite: 4]
('BIL', 'NUMBER', 'BILLION(EUR)[cite_start]'), -- [cite: 4]
('CEN', 'NUMBER', 'HUNDRED')[cite_start], -- [cite: 4]
('DZN', 'NUMBER', 'DOZEN')[cite_start], -- [cite: 4]
('GGR', 'NUMBER', 'GREAT GROSS')[cite_start], -- [cite: 4]
('GRO', 'NUMBER', 'GROSS')[cite_start], -- [cite: 4]
('HIU', 'NUMBER', 'HUNDRED INTERNATIONAL UNITS')[cite_start], -- [cite: 4]
('MIL', 'NUMBER', 'THOUSAND')[cite_start], -- [cite: 4]
('MIO', 'NUMBER', 'MILLION')[cite_start], -- [cite: 4]
('MIU', 'NUMBER', 'MILLION INTERNATIONAL UNITS')[cite_start], -- [cite: 4]
('MLD', 'NUMBER', 'MILLIARD')[cite_start], -- [cite: 4]
('NAR', 'NUMBER', 'NUMBER OF ARTICLES')[cite_start], -- [cite: 4]
('NBB', 'NUMBER', 'NUMBER OF BOBBINS')[cite_start], -- [cite: 4]
('NCL', 'NUMBER', 'NUMBER OF CELLS')[cite_start], -- [cite: 4]
('NIU', 'NUMBER', 'NUMBER OF INTERNATIONAL UNITS')[cite_start], -- [cite: 4]
('NMP', 'NUMBER', 'NUMBER OF PACKS')[cite_start], -- [cite: 4]
('NPL', 'NUMBER', 'NUMBER OF PARCELS')[cite_start], -- [cite: 4]
('NPR', 'NUMBER', 'NUMBER OF PAIRS')[cite_start], -- [cite: 4]
('NPT', 'NUMBER', 'NUMBER OF PARTS')[cite_start], -- [cite: 4]
('NR ', 'NUMBER', 'NOT REQUIRED')[cite_start], -- [cite: 4]
('NRL', 'NUMBER', 'NUMBER OF ROLLS')[cite_start], -- [cite: 4]
('SCO', 'NUMBER', 'SCORE')[cite_start], -- [cite: 4]
('TRL', 'NUMBER', 'TRILLION(EUR)[cite_start]'), -- [cite: 4]
('CEL', 'TEMPERATURE', 'CELSIUS')[cite_start], -- [cite: 4]
('FAH', 'TEMPERATURE', 'FAHRENHEIT')[cite_start], -- [cite: 4]
('BLD', 'VOLUME', 'DRY BARREL(US)[cite_start]'), -- [cite: 4]
('BLL', 'VOLUME', 'BARREL (US)[cite_start]'), -- [cite: 4]
('BUA', 'VOLUME', 'BUSHEL(US)[cite_start]'), -- [cite: 4]
('BUI', 'VOLUME', 'BUSHEL(UK)[cite_start]'), -- [cite: 4]
('CLT', 'VOLUME', 'CENTILITRE')[cite_start], -- [cite: 4]
('CMQ', 'VOLUME', 'CUBIC CENTIMETRE')[cite_start], -- [cite: 4]
('CT ', 'VOLUME', 'CARTONS')[cite_start], -- [cite: 4]
('DLT', 'VOLUME', 'DECILITRE')[cite_start], -- [cite: 4]
('DMQ', 'VOLUME', 'CUBIC DECIMETRE')[cite_start], -- [cite: 4]
('FTQ', 'VOLUME', 'CUBIC FOOT')[cite_start], -- [cite: 4]
('GLD', 'VOLUME', 'DRY GALLON(US)[cite_start]'), -- [cite: 4]
('GLI', 'VOLUME', 'GALLON(UK)[cite_start]'), -- [cite: 4]
('GLL', 'VOLUME', 'GALLON(US)[cite_start]'), -- [cite: 4]
('HLT', 'VOLUME', 'HECTOLITRE')[cite_start], -- [cite: 4]
('INQ', 'VOLUME', 'CUBIC INCH')[cite_start], -- [cite: 4]
('LTR', 'VOLUME', 'LITRE')[cite_start], -- [cite: 4]
('MAL', 'VOLUME', 'MEGA LITRE')[cite_start], -- [cite: 4]
('MLT', 'VOLUME', 'MILLITRE')[cite_start], -- [cite: 4]
('MMQ', 'VOLUME', 'CUBIC MILLIMETRE')[cite_start], -- [cite: 4]
('MTQ', 'VOLUME', 'CUBIC METRE')[cite_start], -- [cite: 4]
('OZA', 'VOLUME', 'FLUID OUNCE(US)[cite_start]'), -- [cite: 4]
('OZI', 'VOLUME', 'FLUID OUNCE(UK)[cite_start]'), -- [cite: 4]
('PTD', 'VOLUME', 'DRY PINT(US)[cite_start]'), -- [cite: 4]
('PTI', 'VOLUME', 'PINT(UK)[cite_start]'), -- [cite: 4]
('PTL', 'VOLUME', 'LIQUID PINT(US)[cite_start]'), -- [cite: 4]
('QTD', 'VOLUME', 'DRY QUART(US)[cite_start]'), -- [cite: 4]
('QTI', 'VOLUME', 'QUART(UK)[cite_start]'), -- [cite: 4]
('QTL', 'VOLUME', 'LIQUID QUART(US)[cite_start]'), -- [cite: 4]
('YDQ', 'VOLUME', 'CUBIC YARD'); [cite_start]-- [cite: 4]

INSERT INTO [UnitOfMeasure] (UnitCode, UnitType, Description)
SELECT s.UnitCode, s.UnitType, s.Description
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [UnitOfMeasure] t 
    WHERE t.UnitCode = s.UnitCode
);

SET @UOMCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @UOMCount > 0
    PRINT CAST(@UOMCount AS NVARCHAR(10)) + ' records inserted successfully into Table UnitOfMeasure.';
ELSE
    PRINT 'No new records were inserted into Table UnitOfMeasure.';

COMMIT TRANSACTION;
GO