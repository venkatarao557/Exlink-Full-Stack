/* =============================================================================
   DATA INSERTION SCRIPT FOR E01 (REGIONS) - 3NF NORMALIZED
   =============================================================================
*/

USE [exlink]
GO

-- 1. ADL - ADELAIDE
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'ADL')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('ADL', 'ADELAIDE');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'ADL' AND c.[CommodityCode] IN ('M','D','G','H','W','S','I');

-- 2. BNE - BRISBANE
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'BNE')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('BNE', 'BRISBANE');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'BNE' AND c.[CommodityCode] IN ('M','D','G','H','W','S','I');

-- 3. CBR - CANBERRA
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'CBR')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('CBR', 'CANBERRA');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'CBR' AND c.[CommodityCode] IN ('M','D','G','H','W','S','I');

-- 4. DRW - DARWIN
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'DRW')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('DRW', 'DARWIN');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'DRW' AND c.[CommodityCode] IN ('M','D','W','S','I');

-- 5. FLT - DUBBO
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'FLT')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('FLT', 'DUBBO');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'FLT' AND c.[CommodityCode] IN ('M','W','S','I');

-- 6. HBA - HOBART
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'HBA')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('HBA', 'HOBART');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'HBA' AND c.[CommodityCode] IN ('M','D','W','S','I');

-- 7. MEL - MELBOURNE
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'MEL')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('MEL', 'MELBOURNE');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'MEL' AND c.[CommodityCode] IN ('M','D','G','H','W','S','I');

-- 8. PER - PERTH
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'PER')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('PER', 'PERTH');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'PER' AND c.[CommodityCode] IN ('M','D','G','H','W','S','I');

-- 9. SYD - SYDNEY
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'SYD')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('SYD', 'SYDNEY');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'SYD' AND c.[CommodityCode] IN ('M','D','G','H','W','S','I');

-- 10. TST - TEST REGION
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'TST')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('TST', 'TEST REGION');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'TST' AND c.[CommodityCode] IN ('M','D','F','G','H','W','S','I','E');

-- 11. AD2 - ADELAIDE
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'AD2')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('AD2', 'ADELAIDE');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'AD2' AND c.[CommodityCode] IN ('D','F','G','H','E');

-- 12. BR2 - BRISBANE - HORT GRAIN
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'BR2')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('BR2', 'BRISBANE - HORT GRAIN');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'BR2' AND c.[CommodityCode] IN ('D','F','G','H','E');

-- 13. CNS - CAIRNS
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'CNS')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('CNS', 'CAIRNS');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'CNS' AND c.[CommodityCode] IN ('D','F','G','H','E');

-- 14. DR2 - DARWIN
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'DR2')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('DR2', 'DARWIN');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'DR2' AND c.[CommodityCode] IN ('D','F','G','H','E');

-- 15. HB2 - HOBART
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'HB2')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('HB2', 'HOBART');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'HB2' AND c.[CommodityCode] IN ('D','F','G','H','E');

-- 16. ME2 - MELBOURNE
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'ME2')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('ME2', 'MELBOURNE');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'ME2' AND c.[CommodityCode] IN ('D','F','G','H','E');

-- 17. PE2 - PERTH
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'PE2')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('PE2', 'PERTH');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'PE2' AND c.[CommodityCode] IN ('D','F','E');

-- 18. SY2 - SYDNEY
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'SY2')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('SY2', 'SYDNEY');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'SY2' AND c.[CommodityCode] IN ('D','F','G','H','E');

-- 19. TSV - TOWNSVILLE
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'TSV')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('TSV', 'TOWNSVILLE');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'TSV' AND c.[CommodityCode] IN ('D','F','G','H','E');

-- 20. BDB - BUNDABERG
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'BDB')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('BDB', 'BUNDABERG');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'BDB' AND c.[CommodityCode] IN ('G','H');

-- 21. CB2 - CANBERRA - NON MEAT
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'CB2')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('CB2', 'CANBERRA - NON MEAT');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'CB2' AND c.[CommodityCode] IN ('G','H');

-- 22. EAG - EAGLE FARM
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'EAG')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('EAG', 'EAGLE FARM');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'EAG' AND c.[CommodityCode] IN ('G','H');

-- 23. HMA - HORTICULTURE ADMINISTRATOR
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'HMA')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('HMA', 'HORTICULTURE ADMINISTRATOR');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'HMA' AND c.[CommodityCode] IN ('G','H');

-- 24. ME3 - MELBOURNE - GRAIN AND HORT
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'ME3')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('ME3', 'MELBOURNE - GRAIN AND HORT');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'ME3' AND c.[CommodityCode] IN ('G','H');

-- 25. MKY - MACKAY
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'MKY')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('MKY', 'MACKAY');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'MKY' AND c.[CommodityCode] IN ('G','H');

-- 26. NTL - NEWCASTLE
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'NTL')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('NTL', 'NEWCASTLE');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'NTL' AND c.[CommodityCode] IN ('G','H');

-- 27. PE3 - PERTH - GRAIN AND HORT
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'PE3')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('PE3', 'PERTH - GRAIN AND HORT');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'PE3' AND c.[CommodityCode] IN ('G','H');

-- 28. PKL - PORT KEMBLA
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'PKL')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('PKL', 'PORT KEMBLA');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'PKL' AND c.[CommodityCode] IN ('G','H');

-- 29. PTJ - PORTLAND
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'PTJ')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('PTJ', 'PORTLAND');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'PTJ' AND c.[CommodityCode] IN ('G','H');

-- 30. RLM - ROCKLEA
IF NOT EXISTS (SELECT 1 FROM [dbo].[Region] WHERE [RegionCode] = 'RLM')
    INSERT INTO [dbo].[Region] ([RegionCode], [RegionName]) VALUES ('RLM', 'ROCKLEA');

INSERT INTO [dbo].[RegionCommodityMapping] ([RegionID], [CommodityID])
SELECT r.[RegionID], c.[CommodityID] 
FROM [dbo].[Region] r, [dbo].[Commodity] c 
WHERE r.[RegionCode] = 'RLM' AND c.[CommodityCode] IN ('G','H');

GO