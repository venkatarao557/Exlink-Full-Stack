/* DEVOPS READY DATA MIGRATION: Table [NatureOfCommodity] (E33)
   - Idempotent: Safe for multiple runs without creating duplicates.
   - Integrity: Checks for existing NatureOfCommodityCode before insertion.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [NatureOfCommodity] (E33)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[NatureOfCommodity]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table to hold all records from E33.txt
        CREATE TABLE #StagingNature (
            [Code] NVARCHAR(10),
            [Description] NVARCHAR(255)
        );

        INSERT INTO #StagingNature ([Code], [Description])
        VALUES 
        ('AL', 'ALMONDS'), ('ALR', 'ROASTED ALMONDS'), ('AQ', 'AQUACULTURE'), ('BA', 'BASIL (HOLY, SWEET)'),
        ('BAR', 'BASMATI RICE FOR HUMAN CONSUMPTION'), ('BE', 'BETEL LEAVES'), ('BG', 'GREEN BEANS'),
        ('BM', 'BITTER MELON (MOMORDICA CHARANTIA)'), ('BN', 'BRAZIL NUTS IN SHELL'), ('BP', 'ANIMAL BY-PRODUCT'),
        ('BV', 'BRASSICA VEGETABLES'), ('BYR', 'YARDLONG BEANS (VIGNA UNGUICULATA SPP. SESQUIPEDALIS)'),
        ('CC', 'CHINESE CELERY (APIUM GRAVEOLENS)'), ('CHF', 'CHEESE FONDUES'), ('CI', 'CHILLI PRODUCTS (CURRY)'),
        ('CL', 'CORIANDER LEAVES'), ('CQ', 'CARCASS-QUARTERS'), ('CS', 'CARCASS-SIDE'), ('CT', 'CUTS'),
        ('CU', 'CURRY LEAVES (BERGERA/ MURRAYA KOENIGII)'), ('CW', 'CARCASS-WHOLE'), ('DA', 'DAIRY'),
        ('DF', 'DRAGON FRUIT'), ('DN', 'DRIED NOODLES'), ('EG', 'EGG'), ('EGP', 'EGG PRODUCTS'),
        ('FF', 'FULLY MARKED'), ('FGP', 'FIGS, PREPARED OR PRESERVED'), ('FI', 'FIGS'),
        ('FIF', 'FLOUR, MEAL AND POWDER OF FIGS'), ('FIP', 'FIG PASTE'), 
        ('FM', 'FRESH MEAT (NOT MEAT MINCED, NOT MEAT PREPARATIONS)'), ('FP', 'FISHERY PRODUCTS'),
        ('FPC', 'FISHERY PRODUCTS, CANNED'), ('FPN', 'FISHERY PRODUCTS, NOT CANNED'), ('GA', 'GAME'),
        ('GAB', 'SMALL WILD GAME BIRDS'), ('GAF', 'FARMED GAME'), ('GAL', 'LARGE FARMED GAME'),
        ('GAS', 'SMALL WILD GAME'), ('GAW', 'WILD GAME'), ('GE', 'GELATINE'), ('HO', 'HONEY'),
        ('HP', 'HORTICULTURE PRODUCTS'), ('IC', 'ICE CREAM'), ('KN', 'KOLA NUTS'), ('LA', 'LAMB'),
        ('ME', 'MEAT'), ('MF', 'MINCED MEAT'), ('MP', 'MEAT PREPARATIONS'), ('MPR', 'MEAT PRODUCTS'),
        ('MU', 'MUSHROOMS'), ('OL', 'OKRA (ABELMOSCHUS ESCULENTUS)'), ('PA', 'PAPAYA (CARICA PAPAYA)'),
        ('PE', 'PEAS'), ('PF', 'FROZEN PEAS'), ('PN', 'PEANUTS (GROUND-NUTS)'), ('PO', 'POULTRY'),
        ('PP', 'PISTACHIOS'), ('PR', 'PRODUCT'), ('RA', 'RABBIT'), ('RI', 'RICE'), ('RM', 'RAW MILK'),
        ('RS', 'ROUGHLY SAWN'), ('SA', 'SAUSAGES'), ('SH', 'SHEEP'), ('ST', 'STRAWBERRY'),
        ('SW', 'SWEET PEPPERS'), ('TA', 'TAPIOCA'), ('VE', 'VEGETABLES');

        -- Final Insert with anti-duplicate check
        INSERT INTO [dbo].[NatureOfCommodity] ([NatureOfCommodityCode], [NatureOfCommodityDescription])
        SELECT 
            TRIM(src.[Code]), 
            TRIM(src.[Description])
        FROM #StagingNature src
        WHERE NOT EXISTS (
            SELECT 1 FROM [dbo].[NatureOfCommodity] target 
            WHERE target.[NatureOfCommodityCode] = TRIM(src.[Code])
        );

        DECLARE @InsertedRows INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@InsertedRows AS VARCHAR(10)) + ' records processed for [NatureOfCommodity].';
        
        DROP TABLE #StagingNature;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[NatureOfCommodity] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [NatureOfCommodity] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO