use exlink
go
-- =============================================================================
-- BATCH INSERT SCRIPT: Country Table (E05)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @CountryInsertCount INT = 0;

-- Temporary table to hold the source data from E05.txt
CREATE TABLE #E05Source (
    CountryCode NVARCHAR(5),
    CountryName NVARCHAR(150)
);

-- Inserting data from E05.txt [cite: 444, 445, 446]
INSERT INTO #E05Source (CountryCode, CountryName) VALUES
('AD', 'ANDORRA'), ('AE', 'UNITED ARAB EMIRATES'), ('AF', 'AFGHANISTAN'), ('AG', 'ANTIGUA AND BARBUDA'),
('AI', 'ANGUILLA'), ('AL', 'ALBANIA'), ('AM', 'ARMENIA'), ('AN', 'NETHERLANDS ANTILLES'),
('AO', 'ANGOLA'), ('AQ', 'ANTARCTICA'), ('AR', 'ARGENTINA'), ('AS', 'AMERICAN SAMOA'),
('AT', 'AUSTRIA'), ('AU', 'AUSTRALIA'), ('AW', 'ARUBA'), ('AZ', 'AZERBAIJAN'),
('BA', 'BOSNIA AND HERZEGOVINA'), ('BB', 'BARBADOS'), ('BD', 'BANGLADESH'), ('BE', 'BELGIUM'),
('BF', 'BURKINA FASO'), ('BG', 'BULGARIA'), ('BH', 'BAHRAIN'), ('BI', 'BURUNDI'),
('BJ', 'BENIN'), ('BL', 'SAINT-BARTHELEMY'), ('BM', 'BERMUDA'), ('BN', 'BRUNEI DARUSSALAM'),
('BO', 'BOLIVIA'), ('BQ', 'BONAIRE, SINT EUSTATIUS AND SABA'), ('BR', 'BRAZIL'), ('BS', 'BAHAMAS'),
('BT', 'BHUTAN'), ('BV', 'BOUVET ISLAND'), ('BW', 'BOTSWANA'), ('BY', 'BELARUS'),
('BZ', 'BELIZE'), ('CA', 'CANADA'), ('CC', 'COCOS ISLAND'), ('CD', 'CONGO, THE DEMOCRATIC REPUBLIC OF THE'),
('CF', 'CENTRAL AFRICAN REPUBLIC'), ('CG', 'CONGO'), ('CH', 'SWITZERLAND'), ('CI', 'COTE D''IVOIRE (IVORY COAST)'),
('CK', 'COOK ISLANDS'), ('CL', 'CHILE'), ('CM', 'CAMEROON'), ('CN', 'CHINA'),
('CO', 'COLOMBIA'), ('CR', 'COSTA RICA'), ('CU', 'CUBA'), ('CV', 'CAPE VERDE'),
('CW', 'CURACAO'), ('CX', 'CHRISTMAS ISLAND'), ('CY', 'CYPRUS'), ('CZ', 'CZECH REPUBLIC'),
('DE', 'GERMANY'), ('DJ', 'DJIBOUTI'), ('DK', 'DENMARK'), ('DM', 'DOMINICA'),
('DO', 'DOMINICAN REPUBLIC'), ('DZ', 'ALGERIA'), ('EC', 'ECUADOR'), ('EE', 'ESTONIA'),
('EG', 'EGYPT'), ('EH', 'WESTERN SAHARA'), ('ER', 'ERITREA'), ('ES', 'SPAIN'),
('ET', 'ETHIOPIA'), ('FI', 'FINLAND'), ('FJ', 'FIJI'), ('FK', 'FALKLAND ISLANDS (MALVINAS)'),
('FM', 'MICRONESIA'), ('FO', 'FAROE ISLANDS'), ('FR', 'FRANCE'), ('GA', 'GABON'),
('GB', 'UNITED KINGDOM'), ('GD', 'GRENADA'), ('GE', 'GEORGIA'), ('GF', 'FRENCH GUIANA'),
('GH', 'GHANA'), ('GI', 'GIBRALTAR'), ('GL', 'GREENLAND'), ('GM', 'GAMBIA'),
('GN', 'GUINEA'), ('GP', 'GUADELOUPE'), ('GQ', 'EQUATORIAL GUINEA'), ('GR', 'GREECE'),
('GS', 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS'), ('GT', 'GUATEMALA'), ('GU', 'GUAM'), ('GW', 'GUINEA-BISSAU'),
('GY', 'GUYANA'), ('HK', 'HONG KONG'), ('HN', 'HONDURAS'), ('HR', 'CROATIA'),
('HT', 'HAITI'), ('HU', 'HUNGARY'), ('ID', 'INDONESIA'), ('IE', 'IRELAND'),
('IL', 'ISRAEL'), ('IN', 'INDIA'), ('IO', 'BRITISH INDIAN OCEAN TERRITORY'), ('IQ', 'IRAQ'),
('IR', 'IRAN (ISLAMIC REPUBLIC OF)'), ('IS', 'ICELAND'), ('IT', 'ITALY'), ('JM', 'JAMAICA'),
('JO', 'JORDAN'), ('JP', 'JAPAN'), ('KE', 'KENYA'), ('KG', 'KYRGYZSTAN'),
('KH', 'CAMBODIA'), ('KI', 'KIRIBATI'), ('KM', 'COMOROS'), ('KN', 'SAINT KITTS AND NEVIS'),
('KP', 'KOREA, DEM. PEOPLE''S REP. OF'), ('KR', 'KOREA, REPUBLIC OF'), ('KW', 'KUWAIT'), ('KY', 'CAYMAN ISLANDS'),
('KZ', 'KAZAKHSTAN'), ('LA', 'LAO PEOPLE''S DEMOCRATIC REPUBLIC'), ('LB', 'LEBANON'), ('LC', 'SAINT LUCIA'),
('LI', 'LIECHTENSTEIN'), ('LK', 'SRI LANKA'), ('LR', 'LIBERIA'), ('LS', 'LESOTHO'),
('LT', 'LITHUANIA'), ('LU', 'LUXEMBOURG'), ('LV', 'LATVIA'), ('LY', 'LIBYA'),
('MA', 'MOROCCO'), ('MC', 'MONACO'), ('MD', 'MOLDOVA'), ('ME', 'MONTENEGRO'),
('MG', 'MADAGASCAR'), ('MH', 'MARSHALL ISLANDS'), ('MK', 'REPUBLIC OF NORTH MACEDONIA'), ('ML', 'MALI'),
('MM', 'MYANMAR'), ('MN', 'MONGOLIA'), ('MO', 'MACAU'), ('MP', 'NORTHERN MARIANA ISLANDS'),
('MQ', 'MARTINIQUE'), ('MR', 'MAURITANIA'), ('MS', 'MONTSERRAT'), ('MT', 'MALTA'),
('MU', 'MAURITIUS'), ('MV', 'MALDIVES'), ('MW', 'MALAWI'), ('MX', 'MEXICO'),
('MY', 'MALAYSIA'), ('MZ', 'MOZAMBIQUE'), ('NA', 'NAMIBIA'), ('NC', 'NEW CALEDONIA'),
('NE', 'NIGER'), ('NF', 'NORFOLK ISLAND'), ('NG', 'NIGERIA'), ('NI', 'NICARAGUA'),
('NL', 'NETHERLANDS'), ('NO', 'NORWAY'), ('NP', 'NEPAL'), ('NR', 'NAURU'),
('NU', 'NIUE'), ('NZ', 'NEW ZEALAND'), ('OM', 'OMAN'), ('PA', 'PANAMA'),
('PE', 'PERU'), ('PF', 'FRENCH POLYNESIA'), ('PG', 'PAPUA NEW GUINEA'), ('PH', 'PHILIPPINES'),
('PK', 'PAKISTAN'), ('PL', 'POLAND'), ('PM', 'SAINT PIERRE ET MIQUELON'), ('PN', 'PITCAIRN'),
('PR', 'PUERTO RICO'), ('PS', 'PALESTINE'), ('PT', 'PORTUGAL'), ('PW', 'PALAU'),
('PY', 'PARAGUAY'), ('QA', 'QATAR'), ('RE', 'REUNION'), ('RO', 'ROMANIA'),
('RS', 'SERBIA'), ('RU', 'RUSSIAN FEDERATION'), ('RW', 'RWANDA'), ('SA', 'SAUDI ARABIA'),
('SB', 'SOLOMON ISLANDS'), ('SC', 'SEYCHELLES'), ('SD', 'SUDAN'), ('SE', 'SWEDEN'),
('SG', 'SINGAPORE'), ('SH', 'SAINT HELENA'), ('SI', 'SLOVENIA'), ('SJ', 'SVALBARD AND JAN MAYEN'),
('SK', 'SLOVAKIA'), ('SL', 'SIERRA LEONE'), ('SM', 'SAN MARINO'), ('SN', 'SENEGAL'),
('SO', 'SOMALIA'), ('SR', 'SURINAME'), ('SS', 'SOUTH SUDAN'), ('ST', 'SAO TOME AND PRINCIPE'),
('SV', 'EL SALVADOR'), ('SX', 'SINT MAARTEN'), ('SY', 'SYRIAN ARAB REPUBLIC'), ('SZ', 'ESWATINI'),
('TC', 'TURKS AND CAICOS ISLANDS'), ('TD', 'CHAD'), ('TF', 'FRENCH SOUTHERN TERRITORIES'), ('TG', 'TOGO'),
('TH', 'THAILAND'), ('TJ', 'TAJIKISTAN'), ('TK', 'TOKELAU'), ('TL', 'TIMOR LESTE'),
('TM', 'TURKMENISTAN'), ('TN', 'TUNISIA'), ('TO', 'TONGA'), ('TR', 'TURKIYE'),
('TT', 'TRINIDAD AND TOBAGO'), ('TV', 'TUVALU'), ('TW', 'TAIWAN'), ('TZ', 'TANZANIA, UNITED REPUBLIC OF'),
('UA', 'UKRAINE'), ('UG', 'ANDA'), ('UM', 'UNITED STATES MINOR OUTLYING ISL.'), ('US', 'UNITED STATES'),
('UY', 'URUGUAY'), ('UZ', 'UZBEKISTAN'), ('VA', 'VATICAN CITY STATE (HOLY SEE)'), ('VC', 'SAINT VINCENT AND THE GRENADINES'),
('VE', 'VENEZUELA'), ('VG', 'VIRGIN ISLANDS (BRITISH)'), ('VI', 'VIRGIN ISLANDS (U.S.)'), ('VN', 'VIET NAM'),
('VU', 'VANUATU'), ('WF', 'WALLIS AND FUTUNA ISLANDS'), ('WS', 'SAMOA'), ('YE', 'YEMEN'),
('YT', 'MAYOTTE'), ('ZA', 'SOUTH AFRICA'), ('ZM', 'ZAMBIA'), ('ZR', 'ZAIRE'),
('ZW', 'ZIMBABWE');

-- Insert only if the CountryCode doesn't already exist in the target table
INSERT INTO [Country] (CountryCode, CountryName)
SELECT s.CountryCode, s.CountryName
FROM #E05Source s
WHERE NOT EXISTS (
    SELECT 1 FROM [Country] t 
    WHERE t.CountryCode = s.CountryCode
);

SET @CountryInsertCount = @@ROWCOUNT;

DROP TABLE #E05Source;

IF @CountryInsertCount > 0
    PRINT CAST(@CountryInsertCount AS NVARCHAR(10)) + ' records inserted successfully into [exlink].[Country].';
ELSE
    PRINT 'No new records were inserted into [exlink].[Country] (all records already exist).';

COMMIT TRANSACTION;
GO