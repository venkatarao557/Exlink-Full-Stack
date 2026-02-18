/* =============================================================================
   COMPLETE DATA INSERTION SCRIPT: COUNTRY MASTER (E05, E09, E27)
   =============================================================================
   Total Records: 240+ Global Countries
   Logic: 
     1. Insert from E05 (Global Master)
     2. Update IsEU from E09 (European Countries)
     3. Update IsUSTerritory from E27 (US Territories)
   =============================================================================
*/

USE [exlink]
GO

-- 1. POPULATE GLOBAL MASTER LIST (Source: E05.txt)
-- Using IF NOT EXISTS to prevent duplicates during repeated DevOps runs[cite: 1, 2, 3].

IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'AD') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('AD', 'ANDORRA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'AE') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('AE', 'UNITED ARAB EMIRATES', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'AF') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('AF', 'AFGHANISTAN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'AG') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('AG', 'ANTIGUA AND BARBUDA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'AI') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('AI', 'ANGUILLA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'AL') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('AL', 'ALBANIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'AM') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('AM', 'ARMENIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'AN') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('AN', 'NETHERLANDS ANTILLES', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'AO') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('AO', 'ANGOLA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'AQ') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('AQ', 'ANTARCTICA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'AR') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('AR', 'ARGENTINA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'AS') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('AS', 'AMERICAN SAMOA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'AT') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('AT', 'AUSTRIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'AU') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('AU', 'AUSTRALIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'AW') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('AW', 'ARUBA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'AZ') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('AZ', 'AZERBAIJAN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'BA') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('BA', 'BOSNIA AND HERZEGOVINA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'BB') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('BB', 'BARBADOS', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'BD') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('BD', 'BANGLADESH', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'BE') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('BE', 'BELGIUM', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'BF') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('BF', 'BURKINA FASO', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'BG') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('BG', 'BULGARIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'BH') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('BH', 'BAHRAIN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'BI') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('BI', 'BURUNDI', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'BJ') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('BJ', 'BENIN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'BL') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('BL', 'SAINT-BARTHELEMY', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'BM') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('BM', 'BERMUDA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'BN') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('BN', 'BRUNEI DARUSSALAM', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'BO') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('BO', 'BOLIVIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'BQ') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('BQ', 'BONAIRE, SINT EUSTATIUS AND SABA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'BR') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('BR', 'BRAZIL', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'BS') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('BS', 'BAHAMAS', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'BT') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('BT', 'BHUTAN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'BV') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('BV', 'BOUVET ISLAND', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'BW') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('BW', 'BOTSWANA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'BY') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('BY', 'BELARUS', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'BZ') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('BZ', 'BELIZE', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'CA') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('CA', 'CANADA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'CC') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('CC', 'COCOS ISLAND', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'CD') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('CD', 'CONGO, THE DEMOCRATIC REPUBLIC OF THE', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'CF') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('CF', 'CENTRAL AFRICAN REPUBLIC', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'CG') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('CG', 'CONGO', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'CH') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('CH', 'SWITZERLAND', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'CI') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('CI', 'COTE D''IVOIRE (IVORY COAST)', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'CK') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('CK', 'COOK ISLANDS', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'CL') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('CL', 'CHILE', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'CM') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('CM', 'CAMEROON', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'CN') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('CN', 'CHINA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'CO') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('CO', 'COLOMBIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'CR') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('CR', 'COSTA RICA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'CU') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('CU', 'CUBA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'CV') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('CV', 'CAPE VERDE', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'CW') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('CW', 'CURACAO', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'CX') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('CX', 'CHRISTMAS ISLAND', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'CY') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('CY', 'CYPRUS', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'CZ') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('CZ', 'CZECH REPUBLIC', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'DE') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('DE', 'GERMANY', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'DJ') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('DJ', 'DJIBOUTI', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'DK') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('DK', 'DENMARK', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'DM') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('DM', 'DOMINICA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'DO') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('DO', 'DOMINICAN REPUBLIC', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'DZ') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('DZ', 'ALGERIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'EC') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('EC', 'ECUADOR', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'EE') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('EE', 'ESTONIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'EG') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('EG', 'EGYPT', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'EH') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('EH', 'WESTERN SAHARA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'ER') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('ER', 'ERITREA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'ES') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('ES', 'SPAIN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'ET') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('ET', 'ETHIOPIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'FI') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('FI', 'FINLAND', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'FJ') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('FJ', 'FIJI', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'FK') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('FK', 'FALKLAND ISLANDS (MALVINAS)', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'FM') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('FM', 'MICRONESIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'FO') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('FO', 'FAROE ISLANDS', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'FR') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('FR', 'FRANCE', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'GA') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('GA', 'GABON', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'GB') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('GB', 'UNITED KINGDOM', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'GD') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('GD', 'GRENADA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'GE') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('GE', 'GEORGIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'GF') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('GF', 'FRENCH GUIANA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'GH') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('GH', 'GHANA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'GI') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('GI', 'GIBRALTAR', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'GL') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('GL', 'GREENLAND', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'GM') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('GM', 'GAMBIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'GN') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('GN', 'GUINEA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'GP') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('GP', 'GUADELOUPE', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'GQ') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('GQ', 'EQUATORIAL GUINEA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'GR') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('GR', 'GREECE', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'GS') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('GS', 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'GT') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('GT', 'GUATEMALA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'GU') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('GU', 'GUAM', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'GW') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('GW', 'GUINEA-BISSAU', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'GY') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('GY', 'GUYANA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'HK') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('HK', 'HONG KONG', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'HN') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('HN', 'HONDURAS', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'HR') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('HR', 'CROATIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'HT') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('HT', 'HAITI', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'HU') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('HU', 'HUNGARY', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'ID') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('ID', 'INDONESIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'IE') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('IE', 'IRELAND', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'IL') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('IL', 'ISRAEL', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'IN') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('IN', 'INDIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'IO') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('IO', 'BRITISH INDIAN OCEAN TERRITORY', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'IQ') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('IQ', 'IRAQ', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'IR') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('IR', 'IRAN (ISLAMIC REPUBLIC OF)', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'IS') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('IS', 'ICELAND', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'IT') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('IT', 'ITALY', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'JM') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('JM', 'JAMAICA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'JO') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('JO', 'JORDAN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'JP') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('JP', 'JAPAN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'KE') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('KE', 'KENYA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'KG') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('KG', 'KYRGYZSTAN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'KH') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('KH', 'CAMBODIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'KI') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('KI', 'KIRIBATI', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'KM') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('KM', 'COMOROS', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'KN') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('KN', 'SAINT KITTS AND NEVIS', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'KP') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('KP', 'KOREA, DEM. PEOPLE''S REP. OF', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'KR') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('KR', 'KOREA, REPUBLIC OF', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'KW') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('KW', 'KUWAIT', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'KY') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('KY', 'CAYMAN ISLANDS', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'KZ') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('KZ', 'KAZAKHSTAN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'LA') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('LA', 'LAO PEOPLE''S DEMOCRATIC REPUBLIC', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'LB') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('LB', 'LEBANON', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'LC') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('LC', 'SAINT LUCIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'LI') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('LI', 'LIECHTENSTEIN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'LK') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('LK', 'SRI LANKA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'LR') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('LR', 'LIBERIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'LS') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('LS', 'LESOTHO', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'LT') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('LT', 'LITHUANIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'LU') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('LU', 'LUXEMBOURG', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'LV') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('LV', 'LATVIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'LY') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('LY', 'LIBYA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'MA') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('MA', 'MOROCCO', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'MC') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('MC', 'MONACO', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'MD') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('MD', 'MOLDOVA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'ME') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('ME', 'MONTENEGRO', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'MG') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('MG', 'MADAGASCAR', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'MH') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('MH', 'MARSHALL ISLANDS', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'MK') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('MK', 'REPUBLIC OF NORTH MACEDONIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'ML') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('ML', 'MALI', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'MM') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('MM', 'MYANMAR', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'MN') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('MN', 'MONGOLIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'MO') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('MO', 'MACAU', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'MP') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('MP', 'NORTHERN MARIANA ISLANDS', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'MQ') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('MQ', 'MARTINIQUE', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'MR') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('MR', 'MAURITANIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'MS') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('MS', 'MONTSERRAT', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'MT') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('MT', 'MALTA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'MU') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('MU', 'MAURITIUS', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'MV') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('MV', 'MALDIVES', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'MW') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('MW', 'MALAWI', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'MX') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('MX', 'MEXICO', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'MY') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('MY', 'MALAYSIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'MZ') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('MZ', 'MOZAMBIQUE', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'NA') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('NA', 'NAMIBIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'NC') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('NC', 'NEW CALEDONIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'NE') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('NE', 'NIGER', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'NF') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('NF', 'NORFOLK ISLAND', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'NG') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('NG', 'NIGERIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'NI') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('NI', 'NICARAGUA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'NL') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('NL', 'NETHERLANDS', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'NO') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('NO', 'NORWAY', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'NP') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('NP', 'NEPAL', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'NR') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('NR', 'NAURU', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'NU') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('NU', 'NIUE', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'NZ') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('NZ', 'NEW ZEALAND', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'OM') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('OM', 'OMAN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'PA') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('PA', 'PANAMA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'PE') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('PE', 'PERU', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'PF') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('PF', 'FRENCH POLYNESIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'PG') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('PG', 'PAPUA NEW GUINEA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'PH') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('PH', 'PHILIPPINES', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'PK') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('PK', 'PAKISTAN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'PL') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('PL', 'POLAND', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'PM') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('PM', 'SAINT PIERRE ET MIQUELON', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'PN') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('PN', 'PITCAIRN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'PR') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('PR', 'PUERTO RICO', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'PS') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('PS', 'PALESTINE', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'PT') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('PT', 'PORTUGAL', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'PW') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('PW', 'PALAU', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'PY') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('PY', 'PARAGUAY', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'QA') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('QA', 'QATAR', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'RE') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('RE', 'REUNION', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'RO') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('RO', 'ROMANIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'RS') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('RS', 'SERBIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'RU') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('RU', 'RUSSIAN FEDERATION', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'RW') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('RW', 'RWANDA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'SA') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('SA', 'SAUDI ARABIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'SB') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('SB', 'SOLOMON ISLANDS', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'SC') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('SC', 'SEYCHELLES', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'SD') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('SD', 'SUDAN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'SE') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('SE', 'SWEDEN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'SG') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('SG', 'SINGAPORE', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'SH') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('SH', 'SAINT HELENA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'SI') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('SI', 'SLOVENIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'SJ') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('SJ', 'SVALBARD AND JAN MAYEN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'SK') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('SK', 'SLOVAKIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'SL') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('SL', 'SIERRA LEONE', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'SM') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('SM', 'SAN MARINO', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'SN') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('SN', 'SENEGAL', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'SO') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('SO', 'SOMALIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'SR') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('SR', 'SURINAME', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'SS') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('SS', 'SOUTH SUDAN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'ST') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('ST', 'SAO TOME AND PRINCIPE', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'SV') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('SV', 'EL SALVADOR', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'SX') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('SX', 'SINT MAARTEN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'SY') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('SY', 'SYRIAN ARAB REPUBLIC', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'SZ') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('SZ', 'ESWATINI', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'TC') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('TC', 'TURKS AND CAICOS ISLANDS', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'TD') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('TD', 'CHAD', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'TF') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('TF', 'FRENCH SOUTHERN TERRITORIES', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'TG') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('TG', 'TOGO', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'TH') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('TH', 'THAILAND', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'TJ') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('TJ', 'TAJIKISTAN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'TK') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('TK', 'TOKELAU', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'TL') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('TL', 'TIMOR LESTE', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'TM') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('TM', 'TURKMENISTAN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'TN') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('TN', 'TUNISIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'TO') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('TO', 'TONGA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'TR') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('TR', 'TURKIYE', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'TT') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('TT', 'TRINIDAD AND TOBAGO', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'TV') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('TV', 'TUVALU', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'TW') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('TW', 'TAIWAN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'TZ') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('TZ', 'TANZANIA, UNITED REPUBLIC OF', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'UA') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('UA', 'UKRAINE', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'UG') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('UG', 'UGANDA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'UM') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('UM', 'UNITED STATES MINOR OUTLYING ISL.', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'US') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('US', 'UNITED STATES', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'UY') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('UY', 'URUGUAY', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'UZ') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('UZ', 'UZBEKISTAN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'VA') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('VA', 'VATICAN CITY STATE (HOLY SEE)', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'VC') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('VC', 'SAINT VINCENT AND THE GRENADINES', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'VE') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('VE', 'VENEZUELA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'VG') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('VG', 'VIRGIN ISLANDS (BRITISH)', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'VI') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('VI', 'VIRGIN ISLANDS (U.S.)', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'VN') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('VN', 'VIET NAM', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'VU') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('VU', 'VANUATU', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'WF') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('WF', 'WALLIS AND FUTUNA ISLANDS', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'WS') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('WS', 'SAMOA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'YE') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('YE', 'YEMEN', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'YT') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('YT', 'MAYOTTE', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'ZA') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('ZA', 'SOUTH AFRICA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'ZM') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('ZM', 'ZAMBIA', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'ZR') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('ZR', 'ZAIRE', 0, 0);
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE [CountryCode] = 'ZW') INSERT INTO [dbo].[Country] ([CountryCode], [CountryName], [IsEU], [IsUSTerritory]) VALUES ('ZW', 'ZIMBABWE', 0, 0);

-- 2. APPLY REGULATORY UPDATES: EU MEMBER FLAGS (Source: E09.txt) [cite: 4]
UPDATE [dbo].[Country] SET [IsEU] = 1 WHERE [CountryCode] IN (
    'AL', 'AT', 'BA', 'BE', 'BG', 'CH', 'CY', 'CZ', 'DE', 'DK', 'EE', 'ES', 'FI', 
    'FO', 'FR', 'GB', 'GF', 'GI', 'GP', 'GR', 'HR', 'HU', 'IE', 'IS', 'IT', 'LI', 
    'LT', 'LU', 'LV', 'MQ', 'MT', 'NL', 'NO', 'PL', 'PM', 'PT', 'RE', 'RO', 'SE', 
    'SI', 'SK', 'TF', 'TR', 'YT'
);

-- 3. APPLY REGULATORY UPDATES: US TERRITORY FLAGS (Source: E27.txt) [cite: 5]
UPDATE [dbo].[Country] SET [IsUSTerritory] = 1 WHERE [CountryCode] IN (
    'AS', 'GU', 'MP', 'PR', 'UM', 'US', 'VI'
);

PRINT 'Country database seeding completed successfully.';
GO