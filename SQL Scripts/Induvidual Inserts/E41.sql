/* DEVOPS READY DATA MIGRATION: Table [TreatmentActiveIngredient] (E41)
   - Idempotent: Safe for multiple runs.
   - Integrity: Synchronizes ActiveIngredientCode and Description.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [TreatmentActiveIngredient] (E41)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[TreatmentActiveIngredient]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table for high-volume staging
        CREATE TABLE #StagingActiveIngredient (
            [Code] NVARCHAR(10),
            [Desc] NVARCHAR(255)
        );

        INSERT INTO #StagingActiveIngredient ([Code], [Desc])
        VALUES 
        ('1', 'ALDRIN AND DIELDRIN'), ('2', 'AZINPHOS-METHYL'), ('7', 'CAPTAN'), ('8', 'CARBARYL'),
        ('12', 'CHLORDANE'), ('15', 'CHLORMEQUAT'), ('17', 'CHLORPYRIFOS'), ('20', '2,4-D'),
        ('21', 'DDT'), ('22', 'DIAZINON'), ('25', 'DICHLORVOS'), ('26', 'DICOFOL'),
        ('27', 'DIMETHOATE'), ('30', 'DIPHENYLAMINE'), ('31', 'DIQUAT'), ('32', 'ENDOSULFAN'),
        ('33', 'ENDRIN'), ('34', 'ETHION'), ('35', 'ETHOXYQUIN'), ('37', 'FENITROTHION'),
        ('39', 'FENTHION'), ('41', 'FOLPET'), ('43', 'HEPTACHLOR'), ('46', 'HYDROGEN PHOSPHIDE'),
        ('48', 'LINDANE'), ('49', 'MALATHION'), ('51', 'METHIDATHION'), ('52', 'METHYL BROMIDE'),
        ('55', 'OMETHOATE'), ('56', '2-PHENYLPHENOL'), ('57', 'PARAQUAT'), ('58', 'PARATHION'),
        ('59', 'PARATHION-METHYL'), ('60', 'PHOSALONE'), ('62', 'PIPERONYL BUTOXIDE'), ('63', 'PYRETHRINS'),
        ('64', 'QUINTOZENE'), ('65', 'THIABENDAZOLE'), ('67', 'CYHEXATIN'), ('72', 'CARBENDAZIM'),
        ('74', 'DISULFOTON'), ('79', 'AMITROLE'), ('81', 'CHLOROTHALONIL'), ('84', 'DODINE'),
        ('85', 'FENAMIPHOS'), ('86', 'PIRIMIPHOS-METHYL'), ('87', 'DINOCAP'), ('90', 'CHLORPYRIFOS-METHYL'),
        ('94', 'METHOMYL'), ('95', 'ACEPHATE'), ('96', 'CARBOFURAN'), ('100', 'METHAMIDOPHOS'),
        ('101', 'PIRIMICARB'), ('102', 'MALEIC HYDRAZIDE'), ('103', 'PHOSMET'), ('105', 'DITHIOCARBAMATES'),
        ('106', 'ETHEPHON'), ('109', 'FENBUTATIN OXIDE'), ('110', 'IMAZALIL'), ('111', 'IPRODIONE'),
        ('112', 'PHORATE'), ('113', 'PROPARGITE'), ('114', 'GUAZATINE'), ('116', 'TRIFORINE'),
        ('117', 'ALDICARB'), ('118', 'CYPERMETHRINS (INCLUDING ALPHA- AND ZETA- CYPERMETHRIN)'), ('119', 'FENVALERATE'), ('120', 'PERMETHRIN'),
        ('122', 'AMITRAZ'), ('126', 'OXAMYL'), ('128', 'PHENTHOATE'), ('129', 'AZOCYCLOTIN'),
        ('130', 'DIFLUBENZURON'), ('132', 'METHIOCARB'), ('133', 'TRIADIMEFON'), ('135', 'DELTAMETHRIN'),
        ('138', 'METALAXYL'), ('142', 'PROCHLORAZ'), ('143', 'TRIAZOPHOS'), ('144', 'BITERTANOL'),
        ('145', 'CARBOSULFAN'), ('146', 'CYHALOTHRIN (INCLUDES LAMBDA-CYHALOTHRIN)'), ('147', 'METHOPRENE'), ('148', 'PROPAMOCARB'),
        ('149', 'ETHOPROPHOS'), ('151', 'DIMETHIPIN'), ('155', 'BENALAXYL'), ('156', 'CLOFENTEZINE'),
        ('157', 'CYFLUTHRIN/BETA-CYFLUTHRIN'), ('158', 'GLYPHOSATE'), ('159', 'VINCLOZOLIN'), ('160', 'PROPICONAZOLE'),
        ('165', 'FLUSILAZOLE'), ('166', 'OXYDEMETON-METHYL'), ('167', 'TERBUFOS'), ('168', 'TRIADIMENOL'),
        ('169', 'CYROMAZINE'), ('171', 'PROFENOFOS'), ('172', 'BENTAZONE'), ('173', 'BUPROFEZIN'),
        ('174', 'CADUSAFOS'), ('175', 'GLUFOSINATE-AMMONIUM'), ('176', 'HEXYTHIAZOX'), ('177', 'ABAMECTIN'),
        ('178', 'BIFENTHRIN'), ('179', 'CYCLOXYDIM'), ('180', 'DITHIANON'), ('181', 'MYCLOBUTANIL'),
        ('182', 'PENCONAZOLE'), ('184', 'ETOFENPROX'), ('185', 'FENPROPATHRIN'), ('187', 'CLETHODIM'),
        ('188', 'FENPROPIMORPH'), ('189', 'TEBUCONAZOLE'), ('190', 'TEFLUBENZURON'), ('191', 'TOLCLOFOS-METHYL'),
        ('193', 'FENPYROXIMATE'), ('194', 'HALOXYFOP'), ('195', 'FLUMETHRIN'), ('196', 'TEBUFENOZIDE'),
        ('197', 'FENBUCONAZOLE'), ('199', 'KRESOXIM-METHYL'), ('200', 'PYRIPROXYFEN'), ('201', 'CHLORPROPHAM'),
        ('202', 'FIPRONIL'), ('203', 'SPINOSAD'), ('204', 'ESFENVALERATE'), ('205', 'FLUTOLANIL'),
        ('206', 'IMIDACLOPRID'), ('207', 'CYPRODINIL'), ('208', 'FAMOXADONE'), ('209', 'METHOXYFENOZIDE'),
        ('210', 'PYRACLOSTROBIN'), ('211', 'FLUDIOXONIL'), ('213', 'TRIFLOXYSTROBIN'), ('214', 'DIMETHENAMID-P'),
        ('215', 'FENHEXAMID'), ('216', 'INDOXACARB'), ('217', 'NOVALURON'), ('218', 'SULFURYL FLUORIDE'),
        ('219', 'BIFENAZATE'), ('220', 'AMINOPYRALID'), ('221', 'BOSCALID'), ('222', 'QUINOXYFEN'),
        ('223', 'THIACLOPRID'), ('224', 'DIFENOCONAZOLE'), ('225', 'DIMETHOMORPH'), ('226', 'PYRIMETHANIL'),
        ('227', 'ZOXAMIDE'), ('229', 'AZOXYSTROBIN'), ('230', 'CHLORANTRANILIPROLE'), ('231', 'MANDIPROPAMID'),
        ('232', 'PROTHIOCONAZOLE'), ('233', 'SPINETORAM'), ('234', 'SPIROTETRAMAT'), ('235', 'FLUOPICOLIDE'),
        ('236', 'METAFLUMIZONE'), ('237', 'SPIRODICLOFEN'), ('238', 'CLOTHIANIDIN'), ('239', 'CYPROCONAZOLE'),
        ('240', 'DICAMBA'), ('241', 'ETOXAZOLE'), ('242', 'FLUBENDIAMIDE'), ('243', 'FLUOPYRAM'),
        ('244', 'MEPTYLDINOCAP'), ('245', 'THIAMETHOXAM'), ('246', 'ACETAMIPRID'), ('247', 'EMAMECTIN BENZOATE'),
        ('248', 'FLUTRIAFOL'), ('249', 'ISOPYRAZAM'), ('250', 'PROPYLENE OXIDE'), ('251', 'SAFLUFENACIL'),
        ('252', 'SULFOXAFLOR'), ('253', 'PENTHIOPYRAD'), ('254', 'CHLORFENAPYR'), ('255', 'DINOTEFURAN'),
        ('256', 'FLUXAPYROXAD'), ('257', 'MCPA'), ('258', 'PICOXYSTROBIN'), ('259', 'SEDAXANE'),
        ('260', 'AMETOCTRADIN'), ('261', 'BENZOVINDIFLUPYR'), ('262', 'BIXAFEN'), ('263', 'CYANTRANILIPROLE'),
        ('264', 'FENAMIDONE'), ('265', 'FLUENSULFONE'), ('266', 'IMAZAPIC'), ('267', 'IMAZAPYR'),
        ('268', 'ISOXAFLUTOLE'), ('269', 'TOLFENPYRAD'), ('270', 'TRIFLUMIZOLE'), ('271', 'TRINEXAPAC-ETHYL'),
        ('272', 'AMINOCYCLOPYRACHLOR'), ('273', 'CYFLUMETOFEN'), ('274', 'DICHLOBENIL'), ('275', 'FLUFENOXURON'),
        ('276', 'IMAZAMOX'), ('277', 'MESOTRIONE'), ('278', 'METRAFENONE'), ('279', 'PYMETROZINE'),
        ('280', 'ACETOCHLOR'), ('281', 'CYAZOFAMID'), ('282', 'FLONICAMID'), ('283', 'FLUAZIFOP-P-BUTYL'),
        ('284', 'FLUMIOXAZIN'), ('285', 'FLUPYRADIFURONE'), ('286', 'LUFENURON'), ('287', 'QUINCLORAC'),
        ('288', 'ACIBENZOLAR-S-METHYL'), ('289', 'IMAZETHAPYR'), ('290', 'ISOFETAMID'), ('291', 'OXATHIAPIPROLIN'),
        ('292', 'PENDIMETHALIN'), ('293', 'PINOXADEN'), ('294', 'SPIROMESIFEN'), ('295', 'BICYCLOPYRONE'),
        ('296', 'CYCLANILIPROLE'), ('297', 'FENAZAQUIN'), ('298', 'FENPYRAZAMINE'), ('299', 'ISOPROTHIOLANE'),
        ('300', 'NATAMYCIN'), ('301', 'PHOSPHONIC ACID'), ('302', 'FOSETYL AL'), ('303', 'TRIFLUMEZOPYRIM'),
        ('304', 'ETHIPROLE'), ('305', 'FENPICOXAMID'), ('307', 'MANDESTROBIN'), ('308', 'NORFLURAZON'),
        ('309', 'PYDIFLUMETOFEN'), ('310', 'PYRIOFENONE'), ('311', 'TIOXAZAFEN'), ('312', 'AFIDOPYROPEN'),
        ('313', 'METCONAZOLE'), ('315', 'PYRIDATE'), ('316', 'PYRIFLUQUINAZON'), ('317', 'TRIFLUMURON'),
        ('318', 'VALIFENALATE'), ('320', 'MEFENTRIFLUCONAZOLE');

        -- Final Ingestion using MERGE for idempotency
        MERGE INTO [dbo].[TreatmentActiveIngredient] AS target
        USING #StagingActiveIngredient AS src
        ON (target.[ActiveIngredientCode] = src.[Code])
        WHEN MATCHED THEN
            UPDATE SET target.[ActiveIngredientDescription] = src.[Desc]
        WHEN NOT MATCHED THEN
            INSERT ([ActiveIngredientCode], [ActiveIngredientDescription])
            VALUES (src.[Code], src.[Desc]);

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [TreatmentActiveIngredient].';
        
        DROP TABLE #StagingActiveIngredient;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[TreatmentActiveIngredient] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [TreatmentActiveIngredient] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO
[cite_start]``` [cite: 1, 2, 3, 4]

