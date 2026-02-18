/* DEVOPS READY DATA MIGRATION: Table [CustomsOffice] (E29)
   - Idempotent: Can be run multiple times without error.
   - Integrity: Performs lookups for StateID via StateCode.
   - Constraints: Skips records if the StateCode does not exist in [State] table.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [CustomsOffice]...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[CustomsOffice]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table to hold raw flat file data
        CREATE TABLE #RawOfficeData (
            [OCode] NVARCHAR(10),
            [OName] NVARCHAR(150),
            [SCode] NVARCHAR(10)
        );

        INSERT INTO #RawOfficeData ([OCode], [OName], [SCode])
        VALUES 
        ('FYW', 'FYSHWICK', 'ACT'),
        ('ALS', 'ALSTONVILLE', 'NSW'), ('BAL', 'BALLDALE', 'NSW'), ('BNK', 'BALLINA', 'NSW'), ('BZD', 'BALRANALD', 'NSW'), 
        ('BMO', 'BANKSMEADOW', 'NSW'), ('BDE', 'BARADINE', 'NSW'), ('BRH', 'BARHAM', 'NSW'), ('BHS', 'BATHURST', 'NSW'), 
        ('BAT', 'BATLOW', 'NSW'), ('BBK', 'BELLBROOK', 'NSW'), ('BMU', 'BENDICK MURRELL', 'NSW'), ('BRG', 'BERRIGAN', 'NSW'), 
        ('BOM', 'BOMADERRY', 'NSW'), ('BRK', 'BOURKE', 'NSW'), ('BAM', 'BRAEMAR', 'NSW'), ('BRT', 'BROOKLET', 'NSW'), 
        ('BDH', 'BULAHDELAH', 'NSW'), ('BGA', 'BURONGA'), ('BYW', 'BYWONG', 'NSW'), ('CBT', 'CABARITA', 'NSW'), 
        ('CNA', 'CANOWINDRA', 'NSW'), ('CHN', 'CHIPPING NORTON', 'NSW'), ('CLE', 'CLARENDON', 'NSW'), ('CFS', 'COFFS HARBOUR', 'NSW'), 
        ('COL', 'COLEAMBALLY', 'NSW'), ('CRB', 'COLLARENEBRI', 'NSW'), ('CON', 'CONDOBOLIN', 'NSW'), ('CNB', 'COONAMBLE', 'NSW'), 
        ('CMD', 'COOTAMUNDRA', 'NSW'), ('CBH', 'CORINDI BEACH', 'NSW'), ('CWT', 'COWRA', 'NSW'), ('DAR', 'DARETON', 'NSW'), 
        ('DTP', 'DARLINGTON POINT', 'NSW'), ('DNQ', 'DENILIQUIN', 'NSW'), ('DBO', 'DUBBO', 'NSW'), ('EPH', 'EAST SEAHAM', 'NSW'), 
        ('EDG', 'EDGECLIFF', 'NSW'), ('EMA', 'EMMAVILLE', 'NSW'), ('ETT', 'ETTRICK', 'NSW'), ('FIN', 'FINLEY', 'NSW'), 
        ('FRB', 'FORBES', 'NSW'), ('GFN', 'GRAFTON'), ('GUL', 'GOULBURN', 'NSW'), ('GRI', 'GRIFFITH', 'NSW'), 
        ('GUH', 'GUNNEDAH', 'NSW'), ('HAY', 'HAY', 'NSW'), ('HIL', 'HILLSTON', 'NSW'), ('HOL', 'HOLBROOK', 'NSW'), 
        ('HUR', 'HURLSTONE PARK', 'NSW'), ('INV', 'INVERELL', 'NSW'), ('JER', 'JERILDERIE', 'NSW'), ('JUN', 'JUNEE', 'NSW'), 
        ('KEL', 'KELSO', 'NSW'), ('KPS', 'KEMPSEY', 'NSW'), ('KIL', 'KILLARA', 'NSW'), ('KYA', 'KYOGLE', 'NSW'), 
        ('LEI', 'LEICHHARDT', 'NSW'), ('LST', 'LISAROW', 'NSW'), ('LSY', 'LISMORE', 'NSW'), ('LIT', 'LITHGOW', 'NSW'), 
        ('MAI', 'MAITLAND', 'NSW'), ('MNG', 'MANILDRA', 'NSW'), ('MIA', 'MIRANDA', 'NSW'), ('MOA', 'MOAMA', 'NSW'), 
        ('MRZ', 'MOREE', 'NSW'), ('MOU', 'MOULAMEIN', 'NSW'), ('MUD', 'MUDGEE', 'NSW'), ('MUR', 'MURWILLUMBAH', 'NSW'), 
        ('NAA', 'NARRABRI', 'NSW'), ('NRA', 'NARRANDERA', 'NSW'), ('NTL', 'NEWCASTLE', 'NSW'), ('NOW', 'NOWRA', 'NSW'), 
        ('NYN', 'NYNGAN', 'NSW'), ('ORA', 'ORANGE', 'NSW'), ('PKE', 'PARKES', 'NSW'), ('PRM', 'PARRAMATTA', 'NSW'), 
        ('PKL', 'PORT KEMBLA', 'NSW'), ('PQQ', 'PORT MACQUARIE', 'NSW'), ('QUI', 'QUIRINDI', 'NSW'), ('RYD', 'RYDE', 'NSW'), 
        ('SGE', 'SCONE', 'NSW'), ('SIN', 'SINGLETON', 'NSW'), ('SMF', 'SMITHFIELD', 'NSW'), ('STP', 'ST PETERS', 'NSW'), 
        ('SYD', 'SYDNEY', 'NSW'), ('TAM', 'TAMWORTH', 'NSW'), ('TAR', 'TAREE', 'NSW'), ('TEM', 'TEMORA', 'NSW'), 
        ('TOC', 'TOCUMWAL', 'NSW'), ('TUM', 'TUMBARUMBA', 'NSW'), ('TUT', 'TUMUT', 'NSW'), ('TWE', 'TWEED HEADS', 'NSW'), 
        ('ULL', 'ULLADULLA', 'NSW'), ('WGA', 'WAGGA WAGGA', 'NSW'), ('WGE', 'WALGETT', 'NSW'), ('WEW', 'WEE WAA', 'NSW'), 
        ('WWY', 'WEST WYALONG', 'NSW'), ('WOL', 'WOLLONGONG', 'NSW'), ('YAM', 'YAMBA', 'NSW'), ('YAS', 'YASS', 'NSW'), 
        ('YOU', 'YOUNG', 'NSW'), ('DAR', 'DARWIN', 'NT'), ('ASP', 'ALICE SPRINGS', 'NT'), ('KAT', 'KATHERINE', 'NT'), 
        ('TEN', 'TENNANT CREEK', 'NT'), ('NHU', 'NHULUNBUY', 'NT'), ('AIR', 'AIRLIE BEACH', 'QLD'), ('AYR', 'AYR', 'QLD'), 
        ('BND', 'BUNDABERG', 'QLD'), ('CNS', 'CAIRNS', 'QLD'), ('CHV', 'CHARLEVILLE', 'QLD'), ('CHT', 'CHARTERS TOWERS', 'QLD'), 
        ('CLO', 'CLONCURRY', 'QLD'), ('DAL', 'DALBY', 'QLD'), ('EMD', 'EMERALD', 'QLD'), ('GLA', 'GLADSTONE', 'QLD'), 
        ('GOO', 'GOONDIWINDI', 'QLD'), ('GYM', 'GYMPIE', 'QLD'), ('INN', 'INNISFAIL', 'QLD'), ('ISA', 'MOUNT ISA', 'QLD'), 
        ('MAC', 'MACKAY', 'QLD'), ('MAR', 'MARYBOROUGH', 'QLD'), ('ROM', 'ROMA', 'QLD'), ('ROC', 'ROCKHAMPTON', 'QLD'), 
        ('TOO', 'TOOWOOMBA', 'QLD'), ('TSV', 'TOWNSVILLE', 'QLD'), ('ADL', 'ADELAIDE', 'SA'), ('MGB', 'MOUNT GAMBIER', 'SA'), 
        ('PPI', 'PORT PIRIE', 'SA'), ('PLN', 'PORT LINCOLN', 'SA'), ('WYA', 'WHYALLA', 'SA'), ('HBT', 'HOBART', 'TAS'), 
        ('LST', 'LAUNCESTON', 'TAS'), ('BUR', 'BURNIE', 'TAS'), ('DVP', 'DEVONPORT', 'TAS'), ('MEL', 'MELBOURNE', 'VIC'), 
        ('GEE', 'GEELONG', 'VIC'), ('BEN', 'BENDIGO', 'VIC'), ('BAL', 'BALLARAT', 'VIC'), ('SHP', 'SHEPPARTON', 'VIC'), 
        ('WRA', 'WANGARATTA', 'VIC'), ('WKB', 'WARRACKNABEL', 'VIC'), ('WRN', 'WERNETH', 'VIC'), ('WER', 'WERRIBEE', 'VIC'), 
        ('WFO', 'WEST FOOTSCRAY', 'VIC'), ('WHO', 'WHOROULY', 'VIC'), ('WNC', 'WINCHELSEA', 'VIC'), ('WOD', 'WODONGA', 'VIC'), 
        ('WPR', 'WONGA PARK', 'VIC'), ('W7W', 'WOOD WOOD', 'VIC'), ('WOO', 'WOORINEN', 'VIC'), ('WUN', 'WUNGHNU', 'VIC'), 
        ('WHP', 'WYCHEPROOF', 'VIC'), ('WYG', 'WYELANGTA', 'VIC'), ('YAK', 'YARCK', 'VIC'), ('YWO', 'YARRAWONGA', 'VIC'), 
        ('YAR', 'YARROWEYAH', 'VIC'), ('YEO', 'YEODENE', 'VIC'), ('PGY', 'PINGELLY', 'WA'), ('ALH', 'ALBANY', 'WA'), 
        ('BAD', 'BADGINGARRA', 'WA'), ('BEN', 'BENTLEY', 'WA'), ('BVY', 'BEVERLEY', 'WA'), ('BIB', 'BIBRA LAKE', 'WA'), 
        ('BIN', 'BINDOON', 'WA'), ('BRI', 'BRIDGETOWN', 'WA'), ('BRO', 'BROOKTON', 'WA'), ('BME', 'BROOME', 'WA'), 
        ('BLL', 'BULLSBROOK', 'WA'), ('BUY', 'BUNBURY', 'WA'), ('BUS', 'BUSSELTON', 'WA'), ('CNN', 'CANNING VALE', 'WA'), 
        ('CPL', 'CAPEL', 'WA'), ('CBD', 'CARABOODA', 'WA'), ('CVQ', 'CARNARVON', 'WA'), ('CRW', 'COOROW', 'WA');

        -- Final Ingestion with Foreign Key resolution and duplication check
        INSERT INTO [dbo].[CustomsOffice] ([OfficeCode], [OfficeName], [StateID])
        SELECT 
            TRIM(src.[OCode]), 
            TRIM(src.[OName]), 
            s.[StateID]
        FROM #RawOfficeData src
        INNER JOIN [dbo].[State] s ON TRIM(s.[StateCode]) = TRIM(src.[SCode])
        WHERE NOT EXISTS (
            SELECT 1 FROM [dbo].[CustomsOffice] target 
            WHERE target.[OfficeCode] = TRIM(src.[OCode])
        );

        DECLARE @InsertedRows INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@InsertedRows AS VARCHAR(10)) + ' records inserted into [CustomsOffice].';
        
        DROP TABLE #RawOfficeData;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[CustomsOffice] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [CustomsOffice] completed.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO