-- =============================================================================
-- BATCH INSERT SCRIPT: NatureOfCommodity Table (E33)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @NatureCommCount INT = 0;

CREATE TABLE #SourceData (
    NatureOfCommodityCode NVARCHAR(10),
    Description NVARCHAR(255)
);

-- Inserting data from E33.txt
INSERT INTO #SourceData (NatureOfCommodityCode, Description) VALUES
('AL', 'ALMONDS'),
('ALR', 'ROASTED ALMONDS'),
('AQ', 'AQUACULTURE'),
('BA', 'BASIL (HOLY, SWEET)'),
('BAR', 'BASMATI RICE FOR HUMAN CONSUMPTION'),
('BE', 'BETEL LEAVES'),
('BG', 'GREEN BEANS'),
('BM', 'BITTER MELON (MOMORDICA CHARANTIA)'),
('BN', 'BRAZIL NUTS IN SHELL'),
('BP', 'ANIMAL BY-PRODUCT'),
('BV', 'BRASSICA VEGETABLES'),
('BYR', 'YARDLONG BEANS (VIGNA UNGUICULATA SPP. SESQUIPEDALIS)'),
('CC', 'CHINESE CELERY (APIUM GRAVEOLENS)'),
('CHF', 'CHEESE FONDUES'),
('CI', 'CHILLI PRODUCTS (CURRY)'),
('CL', 'CORIANDER LEAVES'),
('CQ', 'CARCASS-QUARTERS'),
('CS', 'CARCASS-SIDE'),
('CT', 'CUTS'),
('CU', 'CURRY LEAVES (BERGERA/ MURRAYA KOENIGII)'),
('CW', 'CARCASS-WHOLE'),
('DA', 'DAIRY'),
('DF', 'DRAGON FRUIT'),
('DN', 'DRIED NOODLES'),
('EG', 'EGG'),
('EGP', 'EGG PRODUCTS'),
('FF', 'FULLY MARKED'),
('FGP', 'FIGS, PREPARED OR PRESERVED'),
('FI', 'FIGS'),
('FIF', 'FLOUR, MEAL AND POWDER OF FIGS'),
('FIP', 'FIG PASTE'),
('FM', 'FRESH MEAT (NOT MEAT MINCED, NOT MEAT PREPARATIONS)'),
('FP', 'FISHERY PRODUCTS'),
('FPC', 'FISHERY PRODUCTS, CANNED'),
('FPN', 'FISHERY PRODUCTS, NOT CANNED'),
('GA', 'GAME'),
('GAB', 'SMALL WILD GAME BIRDS'),
('GAF', 'FARMED GAME'),
('GAL', 'LARGE FARMED GAME'),
('GAS', 'SMALL WILD GAME'),
('GAW', 'WILD GAME'),
('GE', 'GELATIN');

INSERT INTO [NatureOfCommodity] (NatureOfCommodityCode, Description)
SELECT s.NatureOfCommodityCode, s.Description
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [NatureOfCommodity] t 
    WHERE t.NatureOfCommodityCode = s.NatureOfCommodityCode
);

SET @NatureCommCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @NatureCommCount > 0
    PRINT CAST(@NatureCommCount AS NVARCHAR(10)) + ' records inserted successfully into Table NatureOfCommodity.';
ELSE
    PRINT 'No new records were inserted into Table NatureOfCommodity.';

COMMIT TRANSACTION;
GO