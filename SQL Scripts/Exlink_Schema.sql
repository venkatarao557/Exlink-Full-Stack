-- SQL Server 2022 Table Creation Script
/*
1. Geographic & Administrative Master Data

These tables define the "where" and "who" of the regulatory and shipping process.

    Regions (E1): Manages regional groupings and supported commodity codes.

    CountryCommodities (E2): Reference table mapping countries to their specific allowed commodities.

    Ports (E3): Master list of international and domestic port codes and names.

    Countries (E5): Global master list of country names and codes.

    SpecificCountries (E9): Specific list for European or other targeted trade-group countries.

    USTerritories (E27): Mapping for US-governed territories and codes.

    Offices (E29): Master list of Regional and State administrative offices.

    States (E35): Master list of states and territories.

2. Commodity & Product Specifications

Detailed definitions of the goods being traded.

    Commodities (E4): High-level master data for all commodity types.

    MeatCuts (E7): Detailed specifications for meat, including bone-in and chemical lean indicators.

    ProductTypes (E21): Links commodities to specific product codes and scientific nomenclature.

    DominantProducts (E38): A list of primary species or dominant product names.

    ProductConditions (E43): Defines the physical state of the product (e.g., Fresh, Frozen).

    ProductParts (E44): Specifies the part of the animal or plant (e.g., Carcass, Trimmings).

3. Classifications & International Mapping

Translation tables between internal codes and international standards (AHECC/CN).

    AHECCProductMappings (E37): Maps AHECC codes to internal product types and cuts.

    ClassificationMaster (E40): Primary master for CN and AHECC classifications with date-effective logic.

    ProductClassifications (E40-B): Standardized version of the classification master for code lookups.

4. Packaging, Preservation & Treatment

Technical data regarding the handling, safety, and shelf-life of products.

    CommodityConfigurations (E10): Links commodities to preservation, product, and pack types.

    PackTypes (E16): Master list of commodity-specific packing methods.

    PackageTypes (E17): General container types used for transport (e.g., Cartons, Pallets).

    PreservationTypes (E19): Methods used to preserve goods (e.g., Chilled, Salted).

    Treatments (E30): Master list of disinfestation and treatment methods.

    TreatmentTypes (E34): Categorization of treatment applications.

    TreatmentIngredients (E41): Active chemical ingredients used in treatments.

    TreatmentConcentrations (E42): Units of measure for treatment concentration.

5. Certification, RFP & Regulatory Logic

The logic-driven tables for the Request for Permit (RFP) and certification lifecycle.

    DeclarationIndicators (E8): Codes for specific health or customs declarations.

    CertificatePrintIndicators (E11): Rules for certificate printing methods.

    RegulatoryDocuments (E18): Types of documents and authorities required for trade.

    ProcessTypes (E20): Methods of establishment processing.

    RFPStatuses (E23): Tracks the compliance state of a permit request.

    RFPReasons (E24): Reason codes for RFP transactions.

    CertificateReasons (E28): Reasons for requesting or re-issuing certificates.

    CertificateRequestStatuses (E31): Current lifecycle state of a certificate request.

    ProductUseIndicators (E32): High-level indicators for product end-use.

    IntendedUses (E45): Detailed descriptions of the product's intended use.

    ApprovedCertifiers (E39): Authorities authorized to issue documentation.

6. Measurements, Units & Qualifiers

Supporting tables for numeric data and descriptive attributes.

    Currencies (E6): Master list of currency units.

    WeightUnitsShort (E12): Standard short-list for weight measurements.

    LocationQualifiers (E13): Regional qualifiers (e.g., "Australian").

    UnitsOfMeasure (E14): Comprehensive UOM master (Mass, Volume, Length).

    WeightUnitsAlternate (E15): Secondary or alternative weight units.

    QualityQualifiers (E22): Codes describing product quality or grade.

    SupplementaryCodes (E25): Additional codes for specific tariff requirements.

    TransportModes (E26): Methods of transport (e.g., Air, Sea).

    NatureOfCommoditys (E33): Defines the nature of the commodity.

    CustomsWeightUnits (E36): Specific units required for customs reporting.

*/


use exlink
go

-- =============================================================================
-- 1. GEOGRAPHIC & ADMINISTRATIVE DATA (MASTER)
-- =============================================================================

-- Table 1: Region (E1)
IF OBJECT_ID('[Region]', 'U') IS NULL
BEGIN
    CREATE TABLE [Region] (
        [RegionID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [RegionCode] NVARCHAR(10) NOT NULL,
        [RegionName] NVARCHAR(100) NOT NULL,
        [Commodities] NVARCHAR(255), 
        CONSTRAINT UQ_Region_Code UNIQUE ([RegionCode])
    );
    PRINT 'Table Region created successfully';
END
ELSE PRINT 'Table Region already exists';
GO

-- Table 5: Country (E5)
IF OBJECT_ID('[Country]', 'U') IS NULL
BEGIN
    CREATE TABLE [Country] (
        [CountryID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [CountryCode] NVARCHAR(5) NOT NULL,
        [CountryName] NVARCHAR(100) NOT NULL,
        CONSTRAINT UQ_Country_Code UNIQUE ([CountryCode])
    );
    CREATE INDEX IX_Country_Name ON [Country] ([CountryName]);
    PRINT 'Table Country created successfully';
END
ELSE PRINT 'Table Country already exists';
GO

-- Table 2: CountryCommodity Mapping (E2)
IF OBJECT_ID('[CountryCommodity]', 'U') IS NULL
BEGIN
    CREATE TABLE [CountryCommodity] (
        [CountryCommodityID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [CountryCode] NVARCHAR(5) NOT NULL,
        [CountryName] NVARCHAR(100) NOT NULL,
        [Commodities] NVARCHAR(255),
        CONSTRAINT UQ_CountryComm_Code UNIQUE ([CountryCode])
    );
    PRINT 'Table CountryCommodity created successfully';
END
ELSE PRINT 'Table CountryCommodity already exists';
GO

-- Table 3: Port (E3)
IF OBJECT_ID('[Port]', 'U') IS NULL
BEGIN
    CREATE TABLE [Port] (
        [PortID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [PortCode] NVARCHAR(10) NOT NULL,
        [PortName] NVARCHAR(150) NOT NULL,
        CONSTRAINT UQ_Port_Code UNIQUE ([PortCode])
    );
    CREATE INDEX IX_Port_Name ON [Port] ([PortName]);
    PRINT 'Table Port created successfully';
END
ELSE PRINT 'Table Port already exists';
GO

-- Table 9: EUCountry (E9)
IF OBJECT_ID('[EUCountry]', 'U') IS NULL
BEGIN
    CREATE TABLE [EUCountry] (
        [EUCountryID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [EUCountryCode] NVARCHAR(5) NOT NULL,
        [EUCountryName] NVARCHAR(100) NOT NULL,
        CONSTRAINT UQ_EUCountry_Code UNIQUE ([EUCountryCode])
    );
    PRINT 'Table EUCountry created successfully';
END
ELSE PRINT 'Table EUCountry already exists';
GO

-- Table 27: USTerritory (E27)
IF OBJECT_ID('[USTerritory]', 'U') IS NULL
BEGIN
    CREATE TABLE [USTerritory] (
        [USTerritoryID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [CountryCode] CHAR(2) NOT NULL,
        [CountryName] NVARCHAR(100) NOT NULL,
        CONSTRAINT UQ_USTerritory_Code UNIQUE ([CountryCode])
    );
    PRINT 'Table USTerritory created successfully';
END
ELSE PRINT 'Table USTerritory already exists';
GO

-- Table 35: State (E35)
IF OBJECT_ID('[State]', 'U') IS NULL
BEGIN
    CREATE TABLE [State] (
        [StateID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [StateCode] CHAR(3) NOT NULL,
        [StateName] NVARCHAR(100) NOT NULL,
        CONSTRAINT UQ_State_Code UNIQUE ([StateCode])
    );
    PRINT 'Table State created successfully';
END
ELSE PRINT 'Table State already exists';
GO

-- Table 29: RegionalOffice (E29)
IF OBJECT_ID('[RegionalOffice]', 'U') IS NULL
BEGIN
    CREATE TABLE [RegionalOffice] (
        [OfficeID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [OfficeCode] NVARCHAR(10) NOT NULL,
        [OfficeName] NVARCHAR(150) NOT NULL,
        [State] NVARCHAR(10) NOT NULL,
        CONSTRAINT UQ_Office_Code UNIQUE ([OfficeCode])
    );
    CREATE INDEX IX_RegionalOffice_State ON [RegionalOffice] ([State]);
    PRINT 'Table RegionalOffice created successfully';
END
ELSE PRINT 'Table RegionalOffice already exists';
GO

-- Table 13: LocationQualifier (E13)
IF OBJECT_ID('[LocationQualifier]', 'U') IS NULL
BEGIN
    CREATE TABLE [LocationQualifier] (
        [LocationQualID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [LocationQualifier] NVARCHAR(100) NOT NULL,
        CONSTRAINT UQ_LocQual_Name UNIQUE ([LocationQualifier])
    );
    PRINT 'Table LocationQualifier created successfully';
END
ELSE PRINT 'Table LocationQualifier already exists';
GO

-- =============================================================================
-- 2. COMMODITY & PRODUCT SPECIFICATIONS (MASTER)
-- =============================================================================

-- Table 4: Commodity (E4)
IF OBJECT_ID('[Commodity]', 'U') IS NULL
BEGIN
    CREATE TABLE [Commodity] (
        [CommodityID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [CommodityCode] NVARCHAR(5) NOT NULL,
        [Description] NVARCHAR(100) NOT NULL,
        CONSTRAINT UQ_Commodity_Code UNIQUE ([CommodityCode]),
        CONSTRAINT UQ_Commodity_ID UNIQUE ([CommodityID])
    );
    PRINT 'Table Commodity created successfully';
END
ELSE PRINT 'Table Commodity already exists';
GO

-- Table 38: DominantProduct (E38)
IF OBJECT_ID('[DominantProduct]', 'U') IS NULL
BEGIN
    CREATE TABLE [DominantProduct] (
        [DominantProductID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [ProductName] NVARCHAR(100) NOT NULL,
        CONSTRAINT UQ_DominantProduct_Name UNIQUE ([ProductName])
    );
    PRINT 'Table DominantProduct created successfully';
END
ELSE PRINT 'Table DominantProduct already exists';
GO

-- Table 43: ProductCondition (E43)
IF OBJECT_ID('[ProductCondition]', 'U') IS NULL
BEGIN
    CREATE TABLE [ProductCondition] (
        [ConditionID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [ConditionCode] CHAR(4) NOT NULL,
        [ConditionName] NVARCHAR(100) NOT NULL,
        CONSTRAINT UQ_ProdCondition_Code UNIQUE ([ConditionCode])
    );
    PRINT 'Table ProductCondition created successfully';
END
ELSE PRINT 'Table ProductCondition already exists';
GO

-- Table 44: ProductPart (E44)
IF OBJECT_ID('[ProductPart]', 'U') IS NULL
BEGIN
    CREATE TABLE [ProductPart] (
        [ProductPartID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [PartCode] CHAR(4) NOT NULL,
        [PartName] NVARCHAR(100) NOT NULL,
        CONSTRAINT UQ_ProdPart_Code UNIQUE ([PartCode])
    );
    PRINT 'Table ProductPart created successfully';
END
ELSE PRINT 'Table ProductPart already exists';
GO

-- Table 33: NatureOfCommodity (E33)
IF OBJECT_ID('[NatureOfCommodity]', 'U') IS NULL
BEGIN
    CREATE TABLE [NatureOfCommodity] (
        [NatureID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [NatureOfCommodityCode] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        CONSTRAINT UQ_CommNature_Code UNIQUE ([NatureOfCommodityCode])
    );
    PRINT 'Table NatureOfCommodity created successfully';
END
ELSE PRINT 'Table NatureOfCommodity already exists';
GO

-- =============================================================================
-- 3. MEASUREMENTS, UNITS & QUALIFIERS (MASTER)
-- =============================================================================

-- Table 6: Currency (E6)
IF OBJECT_ID('[Currency]', 'U') IS NULL
BEGIN
    CREATE TABLE [Currency] (
        [CurrencyID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [CurrencyUnit] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(100) NOT NULL,
        CONSTRAINT UQ_Currency_Unit UNIQUE ([CurrencyUnit])
    );
    PRINT 'Table Currency created successfully';
END
ELSE PRINT 'Table Currency already exists';
GO

-- Table 12: WeightUnitShort (E12)
IF OBJECT_ID('[WeightUnitShort]', 'U') IS NULL
BEGIN
    CREATE TABLE [WeightUnitShort] (
        [WeightUnitShortID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [WeightUnit] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(100) NOT NULL,
        CONSTRAINT UQ_WeightShort_Code UNIQUE ([WeightUnit])
    );
    PRINT 'Table WeightUnitShort created successfully';
END
ELSE PRINT 'Table WeightUnitShort already exists';
GO

-- Table 14: UnitOfMeasure (E14)
IF OBJECT_ID('[UnitOfMeasure]', 'U') IS NULL
BEGIN
    CREATE TABLE [UnitOfMeasure] (
        [UOMID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [UnitCode] NVARCHAR(10) NOT NULL,
        [UnitType] NVARCHAR(50) NOT NULL,
        [Description] NVARCHAR(100) NOT NULL,
        CONSTRAINT UQ_UOM_Code UNIQUE ([UnitCode])
    );
    CREATE INDEX IX_UOM_Type ON [UnitOfMeasure] ([UnitType]);
    PRINT 'Table UnitOfMeasure created successfully';
END
ELSE PRINT 'Table UnitOfMeasure already exists';
GO

-- Table 15: WeightUnitAlternate (E15)
IF OBJECT_ID('[WeightUnitAlternate]', 'U') IS NULL
BEGIN
    CREATE TABLE [WeightUnitAlternate] (
        [WeightUnitAltID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [WeightUnit] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(100) NOT NULL,
        CONSTRAINT UQ_WeightAlt_Code UNIQUE ([WeightUnit])
    );
    PRINT 'Table WeightUnitAlternate created successfully';
END
ELSE PRINT 'Table WeightUnitAlternate already exists';
GO

-- Table 22: QualityQualifier (E22)
IF OBJECT_ID('[QualityQualifier]', 'U') IS NULL
BEGIN
    CREATE TABLE [QualityQualifier] (
        [QualityQualifierID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [QualityQualifier] NVARCHAR(100) NOT NULL,
        CONSTRAINT UQ_QualityQual_Name UNIQUE ([QualityQualifier])
    );
    PRINT 'Table QualityQualifier created successfully';
END
ELSE PRINT 'Table QualityQualifier already exists';
GO

-- Table 25: SupplementaryCode (E25)
IF OBJECT_ID('[SupplementaryCode]', 'U') IS NULL
BEGIN
    CREATE TABLE [SupplementaryCode] (
        [SupplementaryCodeID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [SupplementaryCode] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        [ApplicableCommodities] NVARCHAR(100), 
        CONSTRAINT UQ_SuppCode UNIQUE ([SupplementaryCode])
    );
    PRINT 'Table SupplementaryCode created successfully';
END
ELSE PRINT 'Table SupplementaryCode already exists';
GO

-- Table 26: TransportMode (E26)
IF OBJECT_ID('[TransportMode]', 'U') IS NULL
BEGIN
    CREATE TABLE [TransportMode] (
        [TransportModeID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [ModeCode] INT NOT NULL,
        [Description] NVARCHAR(50) NOT NULL,
        CONSTRAINT UQ_TransMode_Code UNIQUE ([ModeCode])
    );
    PRINT 'Table TransportMode created successfully';
END
ELSE PRINT 'Table TransportMode already exists';
GO

-- Table 36: CustomsWeightUnit (E36)
IF OBJECT_ID('[CustomsWeightUnit]', 'U') IS NULL
BEGIN
    CREATE TABLE [CustomsWeightUnit] (
        [CustomsWeightID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [UnitCode] NVARCHAR(10) NOT NULL,
        CONSTRAINT UQ_CustomsWeight_Code UNIQUE ([UnitCode])
    );
    PRINT 'Table CustomsWeightUnit created successfully';
END
ELSE PRINT 'Table CustomsWeightUnit already exists';
GO

-- =============================================================================
-- 4. PRESERVATION, PACKAGING & TREATMENT (MASTER)
-- =============================================================================

-- Table 16: PackType (E16)
IF OBJECT_ID('[PackType]', 'U') IS NULL
BEGIN
    CREATE TABLE [PackType] (
        [PackTypeID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [PackTypeCode] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        CONSTRAINT UQ_PackType_Code UNIQUE ([PackTypeCode])
    );
    PRINT 'Table PackType created successfully';
END
ELSE PRINT 'Table PackType already exists';
GO

-- Table 17: PackageType (E17)
IF OBJECT_ID('[PackageType]', 'U') IS NULL
BEGIN
    CREATE TABLE [PackageType] (
        [PackageTypeID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [PackageTypeCode] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        CONSTRAINT UQ_PackageType_Code UNIQUE ([PackageTypeCode])
    );
    PRINT 'Table PackageType created successfully';
END
ELSE PRINT 'Table PackageType already exists';
GO

-- Table 19: PreservationType (E19)
IF OBJECT_ID('[PreservationType]', 'U') IS NULL
BEGIN
    CREATE TABLE [PreservationType] (
        [PreservationTypeID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [PreservationCode] CHAR(1) NOT NULL,
        [Description] NVARCHAR(50) NOT NULL,
        CONSTRAINT UQ_Preservation_Code UNIQUE ([PreservationCode])
    );
    PRINT 'Table PreservationType created successfully';
END
ELSE PRINT 'Table PreservationType already exists';
GO

-- Table 30: Treatment (E30)
IF OBJECT_ID('[Treatment]', 'U') IS NULL
BEGIN
    CREATE TABLE [Treatment] (
        [TreatmentID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [TreatmentCode] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        CONSTRAINT UQ_Treatment_Code UNIQUE ([TreatmentCode])
    );
    PRINT 'Table Treatment created successfully';
END
ELSE PRINT 'Table Treatment already exists';
GO

-- Table 34: TreatmentType (E34)
IF OBJECT_ID('[TreatmentType]', 'U') IS NULL
BEGIN
    CREATE TABLE [TreatmentType] (
        [TreatmentTypeID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [TreatmentTypeCode] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(100) NOT NULL,
        CONSTRAINT UQ_TreatmentType_Code UNIQUE ([TreatmentTypeCode])
    );
    PRINT 'Table TreatmentType created successfully';
END
ELSE PRINT 'Table TreatmentType already exists';
GO

-- Table 41: TreatmentIngredient (E41)
IF OBJECT_ID('[TreatmentIngredient]', 'U') IS NULL
BEGIN
    CREATE TABLE [TreatmentIngredient] (
        [IngredientID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [IngredientCode] INT NOT NULL,
        [Description] NVARCHAR(500) NOT NULL,
        CONSTRAINT UQ_Ingredient_Code UNIQUE ([IngredientCode])
    );
    PRINT 'Table TreatmentIngredient created successfully';
END
ELSE PRINT 'Table TreatmentIngredient already exists';
GO

-- Table 42: TreatmentConcentration (E42)
IF OBJECT_ID('[TreatmentConcentration]', 'U') IS NULL
BEGIN
    CREATE TABLE [TreatmentConcentration] (
        [ConcentrationUnitID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [UnitCode] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        CONSTRAINT UQ_TreatConcUnit_Code UNIQUE ([UnitCode])
    );
    PRINT 'Table TreatmentConcentration created successfully';
END
ELSE PRINT 'Table TreatmentConcentration already exists';
GO

-- =============================================================================
-- 5. CERTIFICATION, RFP & REGULATORY LOGIC (MASTER)
-- =============================================================================

-- Table 8: DeclarationIndicator (E8)
IF OBJECT_ID('[DeclarationIndicator]', 'U') IS NULL
BEGIN
    CREATE TABLE [DeclarationIndicator] (
        [DeclarationID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [IndicatorCode] CHAR(1) NOT NULL,
        [Description] NVARCHAR(100) NOT NULL,
        CONSTRAINT UQ_DeclInd_Code UNIQUE ([IndicatorCode])
    );
    PRINT 'Table DeclarationIndicator created successfully';
END
ELSE PRINT 'Table DeclarationIndicator already exists';
GO

-- Table 11: CertificatePrintIndicator (E11)
IF OBJECT_ID('[CertificatePrintIndicator]', 'U') IS NULL
BEGIN
    CREATE TABLE [CertificatePrintIndicator] (
        [PrintIndicatorID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [IndicatorCode] CHAR(1) NOT NULL,
        [Description] NVARCHAR(100) NOT NULL,
        CONSTRAINT UQ_CertPrint_Code UNIQUE ([IndicatorCode])
    );
    PRINT 'Table CertificatePrintIndicator created successfully';
END
ELSE PRINT 'Table CertificatePrintIndicator already exists';
GO

-- Table 18: RegulatoryDocument (E18)
IF OBJECT_ID('[RegulatoryDocument]', 'U') IS NULL
BEGIN
    CREATE TABLE [RegulatoryDocument] (
        [RegulatoryDocID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [DocumentTypeCode] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        CONSTRAINT UQ_RegDoc_Code UNIQUE ([DocumentTypeCode])
    );
    PRINT 'Table RegulatoryDocument created successfully';
END
ELSE PRINT 'Table RegulatoryDocument already exists';
GO

-- Table 20: ProcessType (E20)
IF OBJECT_ID('[ProcessType]', 'U') IS NULL
BEGIN
    CREATE TABLE [ProcessType] (
        [ProcessTypeID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [ProcessTypeCode] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(100) NOT NULL,
        CONSTRAINT UQ_ProcessType_Code UNIQUE ([ProcessTypeCode])
    );
    PRINT 'Table ProcessType created successfully';
END
ELSE PRINT 'Table ProcessType already exists';
GO

-- Table 23: RFPStatus (E23)
IF OBJECT_ID('[RFPStatus]', 'U') IS NULL
BEGIN
    CREATE TABLE [RFPStatus] (
        [StatusID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [StatusCode] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(100) NOT NULL,
        CONSTRAINT UQ_RFPStatus_Code UNIQUE ([StatusCode])
    );
    PRINT 'Table RFPStatus created successfully';
END
ELSE PRINT 'Table RFPStatus already exists';
GO

-- Table 24: RFPReason (E24)
IF OBJECT_ID('[RFPReason]', 'U') IS NULL
BEGIN
    CREATE TABLE [RFPReason] (
        [ReasonID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [ReasonCode] INT NOT NULL,
        [Description] NVARCHAR(100) NOT NULL,
        CONSTRAINT UQ_RFPReason_Code UNIQUE ([ReasonCode])
    );
    PRINT 'Table RFPReason created successfully';
END
ELSE PRINT 'Table RFPReason already exists';
GO

-- Table 28: CertificateReason (E28)
IF OBJECT_ID('[CertificateReason]', 'U') IS NULL
BEGIN
    CREATE TABLE [CertificateReason] (
        [ReasonID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [ReasonCode] INT NOT NULL,
        [Description] NVARCHAR(100) NOT NULL,
        CONSTRAINT UQ_CertReason_Code UNIQUE ([ReasonCode])
    );
    PRINT 'Table CertificateReason created successfully';
END
ELSE PRINT 'Table CertificateReason already exists';
GO

-- Table 31: CertificateRequestStatus (E31)
IF OBJECT_ID('[CertificateRequestStatus]', 'U') IS NULL
BEGIN
    CREATE TABLE [CertificateRequestStatus] (
        [RequestStatusID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [StatusCode] CHAR(1) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        [DateEffective] DATETIME2 DEFAULT GETDATE(),
        CONSTRAINT UQ_CertReqStatus_Code UNIQUE ([StatusCode])
    );
    PRINT 'Table CertificateRequestStatus created successfully';
END
ELSE PRINT 'Table CertificateRequestStatus already exists';
GO

-- Table 32: ProductUseIndicator (E32)
IF OBJECT_ID('[ProductUseIndicator]', 'U') IS NULL
BEGIN
    CREATE TABLE [ProductUseIndicator] (
        [ProductUseID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [UseCode] CHAR(1) NOT NULL,
        [Description] NVARCHAR(100) NOT NULL,
        CONSTRAINT UQ_ProdUse_Code UNIQUE ([UseCode])
    );
    PRINT 'Table ProductUseIndicator created successfully';
END
ELSE PRINT 'Table ProductUseIndicator already exists';
GO

-- Table 45: IntendedUse (E45)
IF OBJECT_ID('[IntendedUse]', 'U') IS NULL
BEGIN
    CREATE TABLE [IntendedUse] (
        [IntendedUseID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [UseCode] CHAR(4) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        CONSTRAINT UQ_IntendedUse_Code UNIQUE ([UseCode])
    );
    PRINT 'Table IntendedUse created successfully';
END
ELSE PRINT 'Table IntendedUse already exists';
GO

-- Table 39: ApprovedCertifier (E39)
IF OBJECT_ID('[ApprovedCertifier]', 'U') IS NULL
BEGIN
    CREATE TABLE [ApprovedCertifier] (
        [CertifierID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [CertifierCode] NVARCHAR(10) NOT NULL,
        [CertifierName] NVARCHAR(255) NOT NULL,
        CONSTRAINT UQ_Certifier_Code UNIQUE ([CertifierCode])
    );
    PRINT 'Table ApprovedCertifier created successfully';
END
ELSE PRINT 'Table ApprovedCertifier already exists';
GO

-- =============================================================================
-- 6. CLASSIFICATIONS (MASTER)
-- =============================================================================
-- Table 40: ProductClassification
IF OBJECT_ID('[ProductClassification]', 'U') IS NULL
BEGIN
    CREATE TABLE [ProductClassification] (
        [ProductClassificationID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [CNCode] NVARCHAR(20) NOT NULL,
        [AHECC] NVARCHAR(20) NOT NULL,
        [Description] NVARCHAR(MAX) NOT NULL,
        [StartDate] DATETIME2 NOT NULL,
        [EndDate] DATETIME2 NULL
    );
    CREATE INDEX IX_ProdClass_AHECC ON [ProductClassification] ([AHECC]);
    PRINT 'Table ProductClassification created successfully';
END
ELSE PRINT 'Table ProductClassification already exists';
GO

-- =============================================================================
-- 7. DEPENDENT TABLES (CHILDREN)
-- =============================================================================

-- Table 7: CutType (E7) 
IF OBJECT_ID('[CutType]', 'U') IS NULL
BEGIN
    CREATE TABLE [CutType] (
        [CutTypeID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [CommodityID] UNIQUEIDENTIFIER NULL,
        [CutCode] NVARCHAR(20) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        [BoneInIndicator] CHAR(1),
        [BeefVealIndicator] CHAR(1),
        [ChemicalLeanIndicator] CHAR(1),
        CONSTRAINT UQ_CutType_Code UNIQUE ([CutCode]),
        CONSTRAINT FK_CutType_Commodity FOREIGN KEY ([CommodityID]) REFERENCES [Commodity]([CommodityID])
    );
    CREATE INDEX IX_CutType_CommID ON [CutType] ([CommodityID]);
    PRINT 'Table CutType created successfully';
END
ELSE PRINT 'Table CutType already exists';
GO

-- Table 21: ProductType (E21)
IF OBJECT_ID('[ProductType]', 'U') IS NULL
BEGIN
    CREATE TABLE [ProductType] (
        [ProductTypeID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [CommodityCode] NVARCHAR(5) NOT NULL,
        [ProductTypeCode] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(255) NOT NULL,
        [ScientificName] NVARCHAR(255),
        CONSTRAINT UQ_ProductType_Logic UNIQUE ([CommodityCode], [ProductTypeCode]),
        CONSTRAINT UQ_ProductType_Code UNIQUE ([ProductTypeCode]), -- Required for referencing in Table 10
        CONSTRAINT FK_ProductType_Commodity FOREIGN KEY ([CommodityCode]) REFERENCES [Commodity]([CommodityCode])
    );
    PRINT 'Table ProductType created successfully';
END
ELSE PRINT 'Table ProductType already exists';
GO

-- Table 37: AHECCProductMapping (E37)
IF OBJECT_ID('[AHECCProductMapping]', 'U') IS NULL
BEGIN
    CREATE TABLE [AHECCProductMapping] (
        [MappingID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [AHECC] NVARCHAR(20) NOT NULL,
        [CutCode] NVARCHAR(20) NOT NULL,
        [ProductTypeCode] NVARCHAR(10) NOT NULL,
        [Description] NVARCHAR(255) NULL,
        CONSTRAINT FK_AHECC_CutType_Code FOREIGN KEY ([CutCode]) REFERENCES [CutType]([CutCode]),
        CONSTRAINT FK_AHECC_ProductType_Code FOREIGN KEY ([ProductTypeCode]) REFERENCES [ProductType]([ProductTypeCode]),
        CONSTRAINT UQ_AHECC_Natural_Mapping UNIQUE ([AHECC], [CutCode], [ProductTypeCode])
    );
    CREATE INDEX IX_AHECC_Lookup ON [AHECCProductMapping] ([AHECC], [ProductTypeCode]);
    PRINT 'Table AHECCProductMapping created successfully with Natural Keys';
END
ELSE PRINT 'Table AHECCProductMapping already exists';
GO


-- Table 10: CommodityConfiguration (E10) / Product
IF OBJECT_ID('[Product]', 'U') IS NULL
BEGIN
    CREATE TABLE [Product] (
        [ProductID] UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
        [CommodityCode] NVARCHAR(5) NOT NULL,
        [PreservationCode] CHAR(1) NOT NULL,
        [ProductTypeCode] NVARCHAR(10) NOT NULL,
        [PackTypeCode] NVARCHAR(10) NOT NULL,
        CONSTRAINT FK_Product_Comm FOREIGN KEY ([CommodityCode]) REFERENCES [Commodity]([CommodityCode]),
        CONSTRAINT FK_Product_Pres FOREIGN KEY ([PreservationCode]) REFERENCES [PreservationType]([PreservationCode]),
        CONSTRAINT FK_Product_Type FOREIGN KEY ([ProductTypeCode]) REFERENCES [ProductType]([ProductTypeCode]),
        CONSTRAINT FK_Product_Pack FOREIGN KEY ([PackTypeCode]) REFERENCES [PackType]([PackTypeCode])
    );
    PRINT 'Table Product created successfully';
END
ELSE PRINT 'Table Product already exists';
GO