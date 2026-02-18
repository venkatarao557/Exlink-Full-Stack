/* =============================================================================
   FULL IDEMPOTENT NORMALIZED EXPORT MANAGEMENT SCHEMA (3NF) - 45 TABLES
   =============================================================================
*/

USE [exlink]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================================================
-- 1. GEOGRAPHIC & ADMINISTRATIVE DATA
-- =============================================================================

-- Table 1: Region (E1)
IF OBJECT_ID('[dbo].[Region]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Region] (
        [RegionID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [RegionCode] NVARCHAR(10) NOT NULL,
        [RegionName] NVARCHAR(100) NOT NULL,
        CONSTRAINT [UQ_Region_Code] UNIQUE ([RegionCode])
    );
    PRINT 'Table [Region] created successfully.';
END
ELSE PRINT 'Table [Region] already exists.';
GO

-- Table 2: Country (Consolidated E5, E9, E27)
IF OBJECT_ID('[dbo].[Country]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Country] (
        [CountryID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [CountryCode] NVARCHAR(5) NOT NULL,
        [CountryName] NVARCHAR(100) NOT NULL,
        [IsEU] BIT DEFAULT 0,
        [IsUSTerritory] BIT DEFAULT 0,
        CONSTRAINT [UQ_Country_Code] UNIQUE ([CountryCode])
    );
    CREATE INDEX IX_Country_Name ON [dbo].[Country] ([CountryName]);
    PRINT 'Table [Country] created successfully.';
END
ELSE PRINT 'Table [Country] already exists.';
GO

-- Table 3: Port (E3)
IF OBJECT_ID('[dbo].[Port]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Port] (
        [PortID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [PortCode] NVARCHAR(10) NOT NULL,
        [PortName] NVARCHAR(150) NOT NULL,
        CONSTRAINT [UQ_Port_Code] UNIQUE ([PortCode])
    );
    PRINT 'Table [Port] created successfully.';
END
ELSE PRINT 'Table [Port] already exists.';
GO

-- Table 4: State (E35)
IF OBJECT_ID('[dbo].[State]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[State] (
        [StateID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [StateCode] CHAR(3) NOT NULL,
        [StateName] NVARCHAR(100) NOT NULL,
        [CountryID] UNIQUEIDENTIFIER NULL,
        CONSTRAINT [UQ_State_Code] UNIQUE ([StateCode]),
        CONSTRAINT [FK_State_Country] FOREIGN KEY ([CountryID]) REFERENCES [dbo].[Country]([CountryID])
    );
    PRINT 'Table [State] created successfully.';
END
ELSE PRINT 'Table [State] already exists.';
GO

-- Table 5: RegionalOffice (E29)
IF OBJECT_ID('[dbo].[RegionalOffice]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[RegionalOffice] (
        [OfficeID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [OfficeCode] NVARCHAR(10) NOT NULL,
        [OfficeName] NVARCHAR(150) NOT NULL,
        [StateID] UNIQUEIDENTIFIER NOT NULL,
        CONSTRAINT [UQ_Office_Code] UNIQUE ([OfficeCode]),
        CONSTRAINT [FK_Office_State] FOREIGN KEY ([StateID]) REFERENCES [dbo].[State]([StateID])
    );
    PRINT 'Table [RegionalOffice] created successfully.';
END
ELSE PRINT 'Table [RegionalOffice] already exists.';
GO

-- Table 6: LocationQualifier (E13)
IF OBJECT_ID('[dbo].[LocationQualifier]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[LocationQualifier] (
        [LocationQualID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [LocationQualifier] NVARCHAR(100) NOT NULL,
        CONSTRAINT [UQ_LocQual_Name] UNIQUE ([LocationQualifier])
    );
    PRINT 'Table [LocationQualifier] created successfully.';
END
ELSE PRINT 'Table [LocationQualifier] already exists.';
GO

-- =============================================================================
-- 2. COMMODITY & PRODUCT SPECIFICATIONS
-- =============================================================================

-- Table 7: Commodity (E4)
IF OBJECT_ID('[dbo].[Commodity]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Commodity] (
        [CommodityID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [CommodityCode] NVARCHAR(5) NOT NULL,
        [Description] NVARCHAR(100) NOT NULL,
        CONSTRAINT [UQ_Commodity_Code] UNIQUE ([CommodityCode])
    );
    PRINT 'Table [Commodity] created successfully.';
END
ELSE PRINT 'Table [Commodity] already exists.';
GO

-- Table 8: CutType / MeatCuts (E7)
IF OBJECT_ID('[dbo].[CutType]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[CutType] (
        [CutTypeID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [CutCode] NVARCHAR(20) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        [BoneInIndicator] CHAR(1) NULL,
        [BeefVealIndicator] CHAR(1) NULL,
        [ChemicalLeanIndicator] CHAR(1) NULL,
        CONSTRAINT [UQ_CutType_Code] UNIQUE ([CutCode])
    );
    PRINT 'Table [CutType] created successfully.';
END
ELSE PRINT 'Table [CutType] already exists.';
GO

-- Table 9: ProductType (E21)
IF OBJECT_ID('[dbo].[ProductType]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[ProductType] (
        [ProductTypeID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [TypeCode] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        [ScientificName] NVARCHAR(255) NULL,
        CONSTRAINT [UQ_ProductType_Code] UNIQUE ([TypeCode])
    );
    PRINT 'Table [ProductType] created successfully.';
END
ELSE PRINT 'Table [ProductType] already exists.';
GO

-- Table 10: DominantProduct (E38)
IF OBJECT_ID('[dbo].[DominantProduct]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[DominantProduct] (
        [DominantProductID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [ProductName] NVARCHAR(100) NOT NULL,
        CONSTRAINT [UQ_DominantProduct_Name] UNIQUE ([ProductName])
    );
    PRINT 'Table [DominantProduct] created successfully.';
END
ELSE PRINT 'Table [DominantProduct] already exists.';
GO

-- Table 11: ProductCondition (E43)
IF OBJECT_ID('[dbo].[ProductCondition]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[ProductCondition] (
        [ConditionID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [ConditionCode] CHAR(4) NOT NULL,
        [ConditionName] NVARCHAR(100) NOT NULL,
        CONSTRAINT [UQ_ProdCondition_Code] UNIQUE ([ConditionCode])
    );
    PRINT 'Table [ProductCondition] created successfully.';
END
ELSE PRINT 'Table [ProductCondition] already exists.';
GO

-- Table 12: ProductPart (E44)
IF OBJECT_ID('[dbo].[ProductPart]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[ProductPart] (
        [ProductPartID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [PartCode] CHAR(4) NOT NULL,
        [PartName] NVARCHAR(100) NOT NULL,
        CONSTRAINT [UQ_ProdPart_Code] UNIQUE ([PartCode])
    );
    PRINT 'Table [ProductPart] created successfully.';
END
ELSE PRINT 'Table [ProductPart] already exists.';
GO

-- Table 13: NatureOfCommodity (E33)
IF OBJECT_ID('[dbo].[NatureOfCommodity]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[NatureOfCommodity] (
        [NatureID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [NatureOfCommodityCode] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        CONSTRAINT [UQ_CommNature_Code] UNIQUE ([NatureOfCommodityCode])
    );
    PRINT 'Table [NatureOfCommodity] created successfully.';
END
ELSE PRINT 'Table [NatureOfCommodity] already exists.';
GO

-- =============================================================================
-- 3. MEASUREMENTS & UNITS
-- =============================================================================

-- Table 14: UnitOfMeasure (E14)
IF OBJECT_ID('[dbo].[UnitOfMeasure]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[UnitOfMeasure] (
        [UOMID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [UnitCode] NVARCHAR(10) NOT NULL,
        [UnitType] NVARCHAR(50) NOT NULL,
        [Description] NVARCHAR(100) NOT NULL,
        CONSTRAINT [UQ_UOM_Code] UNIQUE ([UnitCode])
    );
    PRINT 'Table [UnitOfMeasure] created successfully.';
END
ELSE PRINT 'Table [UnitOfMeasure] already exists.';
GO

-- Table 15: Currency (E6)
IF OBJECT_ID('[dbo].[Currency]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Currency] (
        [CurrencyID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [CurrencyUnit] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(100) NOT NULL,
        CONSTRAINT [UQ_Currency_Unit] UNIQUE ([CurrencyUnit])
    );
    PRINT 'Table [Currency] created successfully.';
END
ELSE PRINT 'Table [Currency] already exists.';
GO

-- Table 16: WeightUnitShort (E12)
IF OBJECT_ID('[dbo].[WeightUnitShort]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[WeightUnitShort] (
        [WeightUnitShortID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [WeightUnit] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(100) NOT NULL,
        CONSTRAINT [UQ_WeightShort_Code] UNIQUE ([WeightUnit])
    );
    PRINT 'Table [WeightUnitShort] created successfully.';
END
ELSE PRINT 'Table [WeightUnitShort] already exists.';
GO

-- Table 17: WeightUnitAlternate (E15)
IF OBJECT_ID('[dbo].[WeightUnitAlternate]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[WeightUnitAlternate] (
        [WeightUnitAltID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [WeightUnit] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(100) NOT NULL,
        CONSTRAINT [UQ_WeightAlt_Code] UNIQUE ([WeightUnit])
    );
    PRINT 'Table [WeightUnitAlternate] created successfully.';
END
ELSE PRINT 'Table [WeightUnitAlternate] already exists.';
GO

-- Table 18: CustomsWeightUnit (E36)
IF OBJECT_ID('[dbo].[CustomsWeightUnit]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[CustomsWeightUnit] (
        [CustomsWeightID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [UnitCode] NVARCHAR(10) NOT NULL,
        CONSTRAINT [UQ_CustomsWeight_Code] UNIQUE ([UnitCode])
    );
    PRINT 'Table [CustomsWeightUnit] created successfully.';
END
ELSE PRINT 'Table [CustomsWeightUnit] already exists.';
GO

-- =============================================================================
-- 4. PRESERVATION & PACKAGING
-- =============================================================================

-- Table 19: PackType (E16)
IF OBJECT_ID('[dbo].[PackType]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[PackType] (
        [PackTypeID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [PackTypeCode] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        CONSTRAINT [UQ_PackType_Code] UNIQUE ([PackTypeCode])
    );
    PRINT 'Table [PackType] created successfully.';
END
ELSE PRINT 'Table [PackType] already exists.';
GO

-- Table 20: PackageType (E17)
IF OBJECT_ID('[dbo].[PackageType]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[PackageType] (
        [PackageTypeID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [PackageTypeCode] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        CONSTRAINT [UQ_PackageType_Code] UNIQUE ([PackageTypeCode])
    );
    PRINT 'Table [PackageType] created successfully.';
END
ELSE PRINT 'Table [PackageType] already exists.';
GO

-- Table 21: PreservationType (E19)
IF OBJECT_ID('[dbo].[PreservationType]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[PreservationType] (
        [PreservationTypeID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [PreservationCode] CHAR(1) NOT NULL,
        [Description] NVARCHAR(50) NOT NULL,
        CONSTRAINT [UQ_Preservation_Code] UNIQUE ([PreservationCode])
    );
    PRINT 'Table [PreservationType] created successfully.';
END
ELSE PRINT 'Table [PreservationType] already exists.';
GO

-- =============================================================================
-- 5. TREATMENTS
-- =============================================================================

-- Table 22: Treatment (E30)
IF OBJECT_ID('[dbo].[Treatment]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Treatment] (
        [TreatmentID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [TreatmentCode] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        CONSTRAINT [UQ_Treatment_Code] UNIQUE ([TreatmentCode])
    );
    PRINT 'Table [Treatment] created successfully.';
END
ELSE PRINT 'Table [Treatment] already exists.';
GO

-- Table 23: TreatmentType (E34)
IF OBJECT_ID('[dbo].[TreatmentType]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[TreatmentType] (
        [TreatmentTypeID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [TypeCode] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        CONSTRAINT [UQ_TreatmentType_Code] UNIQUE ([TypeCode])
    );
    PRINT 'Table [TreatmentType] created successfully.';
END
ELSE PRINT 'Table [TreatmentType] already exists.';
GO

-- Table 24: TreatmentIngredient (E41)
IF OBJECT_ID('[dbo].[TreatmentIngredient]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[TreatmentIngredient] (
        [IngredientID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [IngredientCode] NVARCHAR(10) NOT NULL,
        [IngredientName] NVARCHAR(255) NOT NULL,
        CONSTRAINT [UQ_Ingredient_Code] UNIQUE ([IngredientCode])
    );
    PRINT 'Table [TreatmentIngredient] created successfully.';
END
ELSE PRINT 'Table [TreatmentIngredient] already exists.';
GO

-- Table 25: TreatmentConcentration (E42)
IF OBJECT_ID('[dbo].[TreatmentConcentration]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[TreatmentConcentration] (
        [ConcentrationUnitID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [UnitCode] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        CONSTRAINT [UQ_Concentration_Unit] UNIQUE ([UnitCode])
    );
    PRINT 'Table [TreatmentConcentration] created successfully.';
END
ELSE PRINT 'Table [TreatmentConcentration] already exists.';
GO

-- =============================================================================
-- 6. CERTIFICATION & REGULATORY LOGIC
-- =============================================================================

-- Table 26: RFPStatus (E23)
IF OBJECT_ID('[dbo].[RFPStatus]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[RFPStatus] (
        [RFPStatusID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [StatusCode] NVARCHAR(5) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        CONSTRAINT [UQ_RFPStatus_Code] UNIQUE ([StatusCode])
    );
    PRINT 'Table [RFPStatus] created successfully.';
END
ELSE PRINT 'Table [RFPStatus] already exists.';
GO

-- Table 27: RFPReason (E24)
IF OBJECT_ID('[dbo].[RFPReason]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[RFPReason] (
        [ReasonID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [ReasonCode] INT NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        CONSTRAINT [UQ_RFPReason_Code] UNIQUE ([ReasonCode])
    );
    PRINT 'Table [RFPReason] created successfully.';
END
ELSE PRINT 'Table [RFPReason] already exists.';
GO

-- Table 28: CertificateReason (E28)
IF OBJECT_ID('[dbo].[CertificateReason]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[CertificateReason] (
        [ReasonID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [ReasonCode] INT NOT NULL,
        [Description] NVARCHAR(100) NOT NULL,
        CONSTRAINT [UQ_CertReason_Code] UNIQUE ([ReasonCode])
    );
    PRINT 'Table [CertificateReason] created successfully.';
END
ELSE PRINT 'Table [CertificateReason] already exists.';
GO

-- Table 29: CertificateRequestStatus (E31)
IF OBJECT_ID('[dbo].[CertificateRequestStatus]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[CertificateRequestStatus] (
        [RequestStatusID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [StatusCode] CHAR(1) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        [DateEffective] DATETIME2(7) NULL,
        CONSTRAINT [UQ_CertReqStatus_Code] UNIQUE ([StatusCode])
    );
    PRINT 'Table [CertificateRequestStatus] created successfully.';
END
ELSE PRINT 'Table [CertificateRequestStatus] already exists.';
GO

-- Table 30: RegulatoryDocument (E18)
IF OBJECT_ID('[dbo].[RegulatoryDocument]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[RegulatoryDocument] (
        [RegulatoryDocID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [DocumentTypeCode] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        CONSTRAINT [UQ_DocType_Code] UNIQUE ([DocumentTypeCode])
    );
    PRINT 'Table [RegulatoryDocument] created successfully.';
END
ELSE PRINT 'Table [RegulatoryDocument] already exists.';
GO

-- Table 31: ApprovedCertifier (E39)
IF OBJECT_ID('[dbo].[ApprovedCertifier]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[ApprovedCertifier] (
        [CertifierID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [CertifierCode] NVARCHAR(10) NOT NULL,
        [CertifierName] NVARCHAR(255) NOT NULL,
        CONSTRAINT [UQ_Certifier_Code] UNIQUE ([CertifierCode])
    );
    PRINT 'Table [ApprovedCertifier] created successfully.';
END
ELSE PRINT 'Table [ApprovedCertifier] already exists.';
GO

-- Table 32: ProcessType (E20)
IF OBJECT_ID('[dbo].[ProcessType]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[ProcessType] (
        [ProcessTypeID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [ProcessTypeCode] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(100) NOT NULL,
        CONSTRAINT [UQ_ProcessType_Code] UNIQUE ([ProcessTypeCode])
    );
    PRINT 'Table [ProcessType] created successfully.';
END
ELSE PRINT 'Table [ProcessType] already exists.';
GO

-- Table 33: IntendedUse (E45)
IF OBJECT_ID('[dbo].[IntendedUse]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[IntendedUse] (
        [IntendedUseID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [UseCode] CHAR(4) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        CONSTRAINT [UQ_IntendedUse_Code] UNIQUE ([UseCode])
    );
    PRINT 'Table [IntendedUse] created successfully.';
END
ELSE PRINT 'Table [IntendedUse] already exists.';
GO

-- =============================================================================
-- 7. INDICATORS & QUALIFIERS
-- =============================================================================

-- Table 34: DeclarationIndicator (E8)
IF OBJECT_ID('[dbo].[DeclarationIndicator]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[DeclarationIndicator] (
        [DeclarationID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [IndicatorCode] CHAR(1) NOT NULL,
        [Description] NVARCHAR(100) NOT NULL,
        CONSTRAINT [UQ_DeclInd_Code] UNIQUE ([IndicatorCode])
    );
    PRINT 'Table [DeclarationIndicator] created successfully.';
END
ELSE PRINT 'Table [DeclarationIndicator] already exists.';
GO

-- Table 35: CertificatePrintIndicator (E11)
IF OBJECT_ID('[dbo].[CertificatePrintIndicator]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[CertificatePrintIndicator] (
        [PrintIndicatorID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [IndicatorCode] CHAR(1) NOT NULL,
        [Description] NVARCHAR(100) NOT NULL,
        CONSTRAINT [UQ_CertPrint_Code] UNIQUE ([IndicatorCode])
    );
    PRINT 'Table [CertificatePrintIndicator] created successfully.';
END
ELSE PRINT 'Table [CertificatePrintIndicator] already exists.';
GO

-- Table 36: ProductUseIndicator (E32)
IF OBJECT_ID('[dbo].[ProductUseIndicator]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[ProductUseIndicator] (
        [ProductUseID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [UseCode] CHAR(1) NOT NULL,
        [Description] NVARCHAR(100) NOT NULL,
        CONSTRAINT [UQ_ProdUse_Code] UNIQUE ([UseCode])
    );
    PRINT 'Table [ProductUseIndicator] created successfully.';
END
ELSE PRINT 'Table [ProductUseIndicator] already exists.';
GO

-- Table 37: QualityQualifier (E22)
IF OBJECT_ID('[dbo].[QualityQualifier]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[QualityQualifier] (
        [QualityQualifierID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [QualityQualifier] NVARCHAR(100) NOT NULL,
        CONSTRAINT [UQ_QualityQual_Name] UNIQUE ([QualityQualifier])
    );
    PRINT 'Table [QualityQualifier] created successfully.';
END
ELSE PRINT 'Table [QualityQualifier] already exists.';
GO

-- Table 38: TransportMode (E26)
IF OBJECT_ID('[dbo].[TransportMode]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[TransportMode] (
        [TransportModeID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [ModeCode] INT NOT NULL,
        [Description] NVARCHAR(50) NOT NULL,
        CONSTRAINT [UQ_TransMode_Code] UNIQUE ([ModeCode])
    );
    PRINT 'Table [TransportMode] created successfully.';
END
ELSE PRINT 'Table [TransportMode] already exists.';
GO

-- Table 39: SupplementaryCode (E25)
IF OBJECT_ID('[dbo].[SupplementaryCode]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[SupplementaryCode] (
        [SupplementaryCodeID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [SupplementaryCode] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        CONSTRAINT [UQ_SuppCode] UNIQUE ([SupplementaryCode])
    );
    PRINT 'Table [SupplementaryCode] created successfully.';
END
ELSE PRINT 'Table [SupplementaryCode] already exists.';
GO

-- =============================================================================
-- 8. CLASSIFICATIONS & MAPPINGS
-- =============================================================================

-- Table 40: ClassificationMaster (E40)
IF OBJECT_ID('[dbo].[ClassificationMaster]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[ClassificationMaster] (
        [ClassificationID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [CNCode] NVARCHAR(20) NOT NULL,
        [AHECC] NVARCHAR(20) NOT NULL,
        [Description] NVARCHAR(MAX) NOT NULL,
        [StartDate] DATETIME2(7) NOT NULL,
        [EndDate] DATETIME2(7) NULL
    );
    PRINT 'Table [ClassificationMaster] created successfully.';
END
ELSE PRINT 'Table [ClassificationMaster] already exists.';
GO

-- Table 41: ProductClassification (E40-B)
IF OBJECT_ID('[dbo].[ProductClassification]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[ProductClassification] (
        [ProductClassificationID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [CNCode] NVARCHAR(20) NOT NULL,
        [AHECC] NVARCHAR(20) NOT NULL,
        [Description] NVARCHAR(MAX) NOT NULL,
        [StartDate] DATETIME2(7) NOT NULL,
        [EndDate] DATETIME2(7) NULL
    );
    PRINT 'Table [ProductClassification] created successfully.';
END
ELSE PRINT 'Table [ProductClassification] already exists.';
GO

-- Table 42: AHECCProductMapping (E37)
IF OBJECT_ID('[dbo].[AHECCProductMapping]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[AHECCProductMapping] (
        [MappingID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [AHECC] NVARCHAR(20),
        [CutCode] NVARCHAR(20) NOT NULL,
        [ProductTypeCode] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(255) NULL
    );
    PRINT 'Table [AHECCProductMapping] created successfully.';
END
ELSE PRINT 'Table [AHECCProductMapping] already exists.';
GO

-- =============================================================================
-- 9. CONFIGURATION & JUNCTION TABLES (3NF)
-- =============================================================================

-- Table 43: Product (Commodity Configuration - E10)
IF OBJECT_ID('[dbo].[Product]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Product] (
        [ProductID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [CommodityCode] NVARCHAR(5) NOT NULL,
        [PreservationCode] CHAR(1) NOT NULL,
        [ProductTypeCode] NVARCHAR(10) NOT NULL,
        [PackTypeCode] NVARCHAR(10) NOT NULL,
        [SupplementaryCode] NVARCHAR(10) NULL
    );
    PRINT 'Table [Product] created successfully.';
END
ELSE PRINT 'Table [Product] already exists.';
GO

-- Table 44: CountryCommodityMapping (E2 3NF Junction)
IF OBJECT_ID('[dbo].[CountryCommodityMapping]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[CountryCommodityMapping] (
        [CountryID] UNIQUEIDENTIFIER NOT NULL,
        [CommodityID] UNIQUEIDENTIFIER NOT NULL,
        PRIMARY KEY ([CountryID], [CommodityID]),
        FOREIGN KEY ([CountryID]) REFERENCES [dbo].[Country]([CountryID]),
        FOREIGN KEY ([CommodityID]) REFERENCES [dbo].[Commodity]([CommodityID])
    );
    PRINT 'Junction Table [CountryCommodityMapping] created successfully.';
END
ELSE PRINT 'Junction Table [CountryCommodityMapping] already exists.';
GO

-- Table 45: RegionCommodityMapping (E1 3NF Junction)
IF OBJECT_ID('[dbo].[RegionCommodityMapping]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[RegionCommodityMapping] (
        [RegionID] UNIQUEIDENTIFIER NOT NULL,
        [CommodityID] UNIQUEIDENTIFIER NOT NULL,
        PRIMARY KEY ([RegionID], [CommodityID]),
        FOREIGN KEY ([RegionID]) REFERENCES [dbo].[Region]([RegionID]),
        FOREIGN KEY ([CommodityID]) REFERENCES [dbo].[Commodity]([CommodityID])
    );
    PRINT 'Junction Table [RegionCommodityMapping] created successfully.';
END
ELSE PRINT 'Junction Table [RegionCommodityMapping] already exists.';
GO

/* =============================================================================
   END OF FULL IDEMPOTENT SCHEMA SCRIPT
   =============================================================================
*/