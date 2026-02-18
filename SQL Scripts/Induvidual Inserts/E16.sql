/* DEVOPS READY DATA MIGRATION: Table [PackType] (E16)
   - Idempotent: Safe for multiple runs.
   - Integrity: Synchronizes PackTypeCode and Description.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [PackType] (E16)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[PackType]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table to hold all records from E16.txt
        CREATE TABLE #StagingPackType (
            [Code] NVARCHAR(10),
            [Desc] NVARCHAR(200)
        );

        INSERT INTO #StagingPackType ([Code], [Desc])
        VALUES 
        ('BB', 'BAG IN A BOX'), ('BE', 'BUNDLES'), ('BG', 'BAGS'), ('BI', 'BINS'),
        ('BK', 'BLOCKS'), ('BL', 'BALES'), ('BP', 'BULK PACK'), ('BT', 'BULK TANK AS IN SHIPS HOLD'),
        ('BX', 'BOX'), ('CA', 'CANS'), ('CB', 'CUTTINGS'), ('CN', 'CONTAINERS'),
        ('CR', 'CRATE'), ('CS', 'BONE-IN CARCASE QUARTERS AND SIDES'), ('CT', 'CARTONS'), ('DM', 'DRUMS'),
        ('DZ', 'DOZENS'), ('EN', 'ENVELOPES'), ('ES', 'ESKY'), ('FE', 'FLEXITANK'),
        ('FL', 'FLASKS'), ('GP', 'GIFT PACK'), ('IV', 'INDIVIDUALLY WRAPPED/VACUUM PACKED'), ('IW', 'INDIVIDUALLY WRAPPED PACK'),
        ('JA', 'JARS'), ('LP', 'LAYER PACK'), ('LV', 'LAYER PACK/VACUUM PACKED'), ('MA', 'MODIFIED ATMOSPHERIC PACKAGING'),
        ('MV', 'MULTI WRAPPED/VACUUM PACKED'), ('MW', 'MULTI WRAPPED PACK'), ('OC', 'OCTOBINS'), ('PA', 'PACKETS'),
        ('PB', 'PLASTIC BOTTLES'), ('PC', 'PIECES'), ('PF', 'PALLETS'), ('PJ', 'PUNNETS'),
        ('PL', 'PAILS'), ('PM', 'PLANTS'), ('PP', 'PARCEL'), ('PR', 'PLASTIC RECEPTACLE'),
        ('PS', 'PACKS'), ('PX', 'POLYSTYRENE BOXES'), ('RO', 'ROLLS'), ('SC', 'SACHET'),
        ('SO', 'SPOOL'), ('SS', 'STEMS'), ('TB', 'TUBES'), ('TI', 'TINS'),
        ('TP', 'TRAY PACKED'), ('TU', 'TUBS'), ('TV', 'TRAY PACKED/VACUUM PACKED'), ('UP', 'ULTIMATE PACK'),
        ('VI', 'VIALS'), ('VL', 'BULK LIQUID'), ('VP', 'VACUUM PACKED'), ('VR', 'BULK'),
        ('WA', 'WAXED');

        -- Use MERGE to ensure idempotency (Update if exists, Insert if new)
        MERGE INTO [dbo].[PackType] AS target
        USING #StagingPackType AS src
        ON (target.[PackTypeCode] = src.[Code])
        WHEN MATCHED THEN
            UPDATE SET target.[PackTypeDescription] = src.[Desc]
        WHEN NOT MATCHED THEN
            INSERT ([PackTypeCode], [PackTypeDescription])
            VALUES (src.[Code], src.[Desc]);

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [PackType].';
        
        DROP TABLE #StagingPackType;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[PackType] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [PackType] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO