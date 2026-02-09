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

-- Inserting data from E14.txt 
INSERT INTO #SourceData (UnitCode, UnitType, Description) VALUES
('CMT', 'LENGTH', 'CENTIMETRE'), 
('DMT', 'LENGTH', 'DECIMETRE'), 
('MTR', 'LENGTH', 'METRE'), 
('CGM', 'MASS', 'CENTIGRAM'), 
('CMK', 'MASS', 'CM²'), 
('CU ', 'MASS', 'CUBIC METRE'), 
('CWI', 'MASS', 'HUNDRED WEIGHT(UK)'), 
('DTN', 'MASS', 'DECITONNE'), 
('GRM', 'MASS', 'GRAM'), 
('GRN', 'MASS', 'GRAIN'), 
('HGM', 'MASS', 'HECTOGRAM'), 
('JCM', 'MASS', 'JAS CBM'), 
('KGM', 'MASS', 'KILOGRAM'), 
('KTN', 'MASS', 'KILOTONNE'), 
('LBR', 'MASS', 'POUND'), 
('LTN', 'MASS', 'TON(UK) OR LONGTON(US)'), 
('MGM', 'MASS', 'MILLIGRAM'), 
('MT ', 'MASS', 'M/TONS'), 
('MTK', 'MASS', 'METRIC TONNES OF 1,000 KILOS EACH'), 
('MTN', 'MASS', 'METRIC TONS'), 
('MTO', 'MASS', 'METRIC TON'), 
('MTS', 'MASS', 'M/TS'), 
('NO ', 'MASS', 'NUMBER'), 
('ONZ', 'MASS', 'OUNCE'), 
('SM ', 'MASS', 'SQUARE METRE'), 
('SS ', 'MASS', 'STEMS'), 
('STI', 'MASS', 'STONE(UK)'), 
('STN', 'MASS', 'TON (US) OR SHORT TON(UK/US)'), 
('TN ', 'MASS', 'TONNES'), 
('TNE', 'MASS', 'TONNE (METRIC TONNE)'), 
('BIL', 'NUMBER', 'BILLION(EUR)'), 
('CEN', 'NUMBER', 'HUNDRED'), 
('DZN', 'NUMBER', 'DOZEN'), 
('GGR', 'NUMBER', 'GREAT GROSS'), 
('GRO', 'NUMBER', 'GROSS'), 
('HIU', 'NUMBER', 'HUNDRED INTERNATIONAL UNITS'), 
('MIL', 'NUMBER', 'THOUSAND'), 
('MIO', 'NUMBER', 'MILLION'), 
('MIU', 'NUMBER', 'MILLION INTERNATIONAL UNITS'), 
('MLD', 'NUMBER', 'MILLIARD'), 
('NAR', 'NUMBER', 'NUMBER OF ARTICLES'), 
('NBB', 'NUMBER', 'NUMBER OF BOBBINS'), 
('NCL', 'NUMBER', 'NUMBER OF CELLS'), 
('NIU', 'NUMBER', 'NUMBER OF INTERNATIONAL UNITS'), 
('NMP', 'NUMBER', 'NUMBER OF PACKS'), 
('NPL', 'NUMBER', 'NUMBER OF PARCELS'), 
('NPR', 'NUMBER', 'NUMBER OF PAIRS'), 
('NPT', 'NUMBER', 'NUMBER OF PARTS'), 
('NR ', 'NUMBER', 'NOT REQUIRED'), 
('NRL', 'NUMBER', 'NUMBER OF ROLLS'), 
('SCO', 'NUMBER', 'SCORE'), 
('TRL', 'NUMBER', 'TRILLION(EUR)'), 
('CEL', 'TEMPERATURE', 'CELSIUS'), 
('FAH', 'TEMPERATURE', 'FAHRENHEIT'), 
('BLD', 'VOLUME', 'DRY BARREL(US)'), 
('BLL', 'VOLUME', 'BARREL (US)'), 
('BUA', 'VOLUME', 'BUSHEL(US)'), 
('BUI', 'VOLUME', 'BUSHEL(UK)'), 
('CLT', 'VOLUME', 'CENTILITRE'), 
('CMQ', 'VOLUME', 'CUBIC CENTIMETRE'), 
('CT ', 'VOLUME', 'CARTONS'), 
('DLT', 'VOLUME', 'DECILITRE'), 
('DMQ', 'VOLUME', 'CUBIC DECIMETRE'), 
('FTQ', 'VOLUME', 'CUBIC FOOT'), 
('GLD', 'VOLUME', 'DRY GALLON(US)'), 
('GLI', 'VOLUME', 'GALLON(UK)'), 
('GLL', 'VOLUME', 'GALLON(US)'), 
('HLT', 'VOLUME', 'HECTOLITRE'), 
('INQ', 'VOLUME', 'CUBIC INCH'), 
('LTR', 'VOLUME', 'LITRE'), 
('MAL', 'VOLUME', 'MEGA LITRE'), 
('MLT', 'VOLUME', 'MILLITRE'), 
('MMQ', 'VOLUME', 'CUBIC MILLIMETRE'), 
('MTQ', 'VOLUME', 'CUBIC METRE'), 
('OZA', 'VOLUME', 'FLUID OUNCE(US)'), 
('OZI', 'VOLUME', 'FLUID OUNCE(UK)'), 
('PTD', 'VOLUME', 'DRY PINT(US)'), 
('PTI', 'VOLUME', 'PINT(UK)'), 
('PTL', 'VOLUME', 'LIQUID PINT(US)'), 
('QTD', 'VOLUME', 'DRY QUART(US)'), 
('QTI', 'VOLUME', 'QUART(UK)'), 
('QTL', 'VOLUME', 'LIQUID QUART(US)'), 
('YDQ', 'VOLUME', 'CUBIC YARD'); 

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