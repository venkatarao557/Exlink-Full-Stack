/* ================================================================================
EXLINK MASTER SCHEMA (Optimized with Indexes)
--------------------------------------------------------------------------------
Description: Unified TABLE Creation Script with performance-optimized indexing.
Database: SQL Server 2022
================================================================================
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

    TreatmentConcentrationUnits (E42): Units of measure for treatment concentration.

5. Certification, RFP & Regulatory Logic

The logic-driven tables for the Request for Permit (RFP) and certification lifecycle.

    DeclarationIndicators (E8): Codes for specific health or customs declarations.

    CertificatePrintIndicators (E11): Rules for certificate printing methods.

    RegulatoryDocuments (E18): Types of documents and authorities required for trade.

    ProcessTypes (E20): Methods of establishment processing.

    RFPComplianceStatuses (E23): Tracks the compliance state of a permit request.

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

    CommodityNatures (E33): Defines the nature of the commodity.

    CustomsWeightUnits (E36): Specific units required for customs reporting.

*/
*/

-- 1. GEOGRAPHIC & ADMINISTRATIVE DATA
-- -----------------------------------------------------------------------------

CREATE TABLE [Countries] (
    [CountryCode] NVARCHAR(5) NOT NULL,
    [CountryName] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_Countries PRIMARY KEY ([CountryCode])
);
CREATE INDEX IX_Countries_Name ON [Countries] ([CountryName]);
GO

CREATE TABLE [States] (
    [StateCode] CHAR(3) NOT NULL,
    [StateName] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_States PRIMARY KEY ([StateCode])
);
GO

CREATE TABLE [Regions] (
    [RegionCode]  NVARCHAR(10) NOT NULL,
    [RegionName]  NVARCHAR(100) NOT NULL,
    [Commodities] NVARCHAR(255), 
    CONSTRAINT PK_Regions PRIMARY KEY ([RegionCode])
);
GO

CREATE TABLE [Ports] (
    [PortCode] NVARCHAR(10) NOT NULL,
    [PortName] NVARCHAR(150) NOT NULL,
    CONSTRAINT PK_Ports PRIMARY KEY ([PortCode])
);
CREATE INDEX IX_Ports_Name ON [Ports] ([PortName]);
GO

CREATE TABLE [Offices] (
    [OfficeCode] NVARCHAR(10) NOT NULL,
    [OfficeName] NVARCHAR(150) NOT NULL,
    [State]      NVARCHAR(10) NOT NULL,
    CONSTRAINT PK_Offices PRIMARY KEY ([OfficeCode])
);
CREATE INDEX IX_Offices_State ON [Offices] ([State]);
GO

CREATE TABLE [USTerritories] (
    [CountryCode] CHAR(2) NOT NULL,
    [CountryName] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_USTerritories PRIMARY KEY ([CountryCode])
);
GO

CREATE TABLE [SpecificCountries] (
    [CountryCode] NVARCHAR(5) NOT NULL,
    [CountryName] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_SpecificCountries PRIMARY KEY ([CountryCode])
);
GO

CREATE TABLE [LocationQualifiers] (
    [LocationQualifier] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_LocationQualifiers PRIMARY KEY ([LocationQualifier])
);
GO


-- 2. COMMODITY & PRODUCT MASTER DATA
-- -----------------------------------------------------------------------------

CREATE TABLE [Commodities] (
    [CommodityCode] NVARCHAR(5) NOT NULL,
    [Description]   NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_Commodities PRIMARY KEY ([CommodityCode])
);
GO

CREATE TABLE [ProductTypes] (
    [CommodityCode]   NVARCHAR(5) NOT NULL,
    [ProductTypeCode] NVARCHAR(10) NOT NULL,
    [Description]     NVARCHAR(255) NOT NULL,
    [ScientificName]  NVARCHAR(255),
    CONSTRAINT PK_ProductTypes PRIMARY KEY ([CommodityCode], [ProductTypeCode])
);
CREATE INDEX IX_ProductTypes_Commodity ON [ProductTypes] ([CommodityCode]);
GO

CREATE TABLE [MeatCuts] (
    [CutCode]               NVARCHAR(20) NOT NULL,
    [Description]           NVARCHAR(255) NOT NULL,
    [CommodityCode]         NVARCHAR(5),
    [IsBoneIn]              CHAR(1),
    [IsBeefVeal]            CHAR(1),
    [IsChemicalLean]        CHAR(1),
    CONSTRAINT PK_MeatCuts PRIMARY KEY ([CutCode]),
    CONSTRAINT FK_MeatCuts_Commodities FOREIGN KEY ([CommodityCode]) REFERENCES [Commodities] ([CommodityCode])
);
CREATE INDEX IX_MeatCuts_Commodity ON [MeatCuts] ([CommodityCode]);
GO

CREATE TABLE [DominantProducts] (
    [ProductName] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_DominantProducts PRIMARY KEY ([ProductName])
);
GO

CREATE TABLE [ProductConditions] (
    [ConditionCode] CHAR(4) NOT NULL,
    [Description]   NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_ProductConditions PRIMARY KEY ([ConditionCode])
);
GO

CREATE TABLE [ProductParts] (
    [PartCode]    CHAR(4) NOT NULL,
    [Description] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_ProductParts PRIMARY KEY ([PartCode])
);
GO

CREATE TABLE [CommodityNatures] (
    [NatureCode]  NVARCHAR(10) NOT NULL,
    [Description] NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_CommodityNatures PRIMARY KEY ([NatureCode])
);
GO


-- 3. CLASSIFICATIONS & MAPPINGS
-- -----------------------------------------------------------------------------

CREATE TABLE [ClassificationMaster] (
    [CNCode]        NVARCHAR(20) NOT NULL,
    [AHECCCode]     NVARCHAR(20) NOT NULL DEFAULT '',
    [Description]   NVARCHAR(MAX) NOT NULL,
    [StartDate]     DATETIME2(7) NOT NULL,
    [EndDate]       DATETIME2(7) NULL,
    CONSTRAINT PK_ClassificationMaster PRIMARY KEY ([CNCode], [AHECCCode], [StartDate])
);
CREATE INDEX IX_Classification_AHECC ON [ClassificationMaster] ([AHECCCode]);
CREATE INDEX IX_Classification_Dates ON [ClassificationMaster] ([StartDate], [EndDate]);
GO

CREATE TABLE [AHECCProductMappings] (
    [AHECCCode]       NVARCHAR(20) NOT NULL,
    [CutCode]         NVARCHAR(20) NOT NULL,
    [ProductTypeCode] NVARCHAR(10) NOT NULL,
    [Description]     NVARCHAR(255),
    CONSTRAINT PK_AHECCProductMappings PRIMARY KEY ([AHECCCode], [CutCode], [ProductTypeCode])
);
CREATE INDEX IX_AHECCMapping_Codes ON [AHECCProductMappings] ([CutCode], [ProductTypeCode]);
GO

CREATE TABLE [CountryCommodities] (
    [CountryCode] NVARCHAR(5) NOT NULL,
    [CountryName] NVARCHAR(100) NOT NULL,
    [Commodities] NVARCHAR(255),
    CONSTRAINT PK_CountryCommodities PRIMARY KEY ([CountryCode])
);
GO

CREATE TABLE [ProductClassification_E40_Alt] (
    CN_CODE NVARCHAR(20) NOT NULL,
    AHECC NVARCHAR(20) NOT NULL,
    CN_DESCRIPTION NVARCHAR(MAX) NOT NULL,
    START_DATE DATETIME2 NOT NULL,
    END_DATE DATETIME2 NULL,
    CONSTRAINT PK_ProductClassification_Alt PRIMARY KEY (CN_CODE, AHECC)
);
CREATE INDEX IX_ProdClassAlt_AHECC ON [ProductClassification_E40_Alt] (AHECC);
GO


-- 4. PRESERVATION, PACKAGING & TREATMENT
-- -----------------------------------------------------------------------------

CREATE TABLE [CommodityConfigurations] (
    [CommodityCode]     NVARCHAR(5) NOT NULL,
    [PreservationCode]  NVARCHAR(5) NOT NULL,
    [ProductTypeCode]   NVARCHAR(10) NOT NULL,
    [PackTypeCode]      NVARCHAR(10) NOT NULL,
    [SupplementaryCode] NVARCHAR(10) NOT NULL DEFAULT '',
    CONSTRAINT PK_CommodityConfigs PRIMARY KEY (
        [CommodityCode], [PreservationCode], [ProductTypeCode], [PackTypeCode], [SupplementaryCode]
    ),
    CONSTRAINT FK_Configs_Commodities FOREIGN KEY ([CommodityCode]) REFERENCES [Commodities] ([CommodityCode])
);
CREATE INDEX IX_CommConfigs_Lookup ON [CommodityConfigurations] ([CommodityCode], [ProductTypeCode]);
GO

CREATE TABLE [PreservationTypes] (
    [PreservationCode] CHAR(1) NOT NULL,
    [Description]      NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_PreservationTypes PRIMARY KEY ([PreservationCode])
);
GO

CREATE TABLE [PackTypes] (
    [PackTypeCode] NVARCHAR(10) NOT NULL,
    [Description]  NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_PackTypes PRIMARY KEY ([PackTypeCode])
);
GO

CREATE TABLE [PackageTypes] (
    [PackageTypeCode] NVARCHAR(10) NOT NULL,
    [Description]     NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_PackageTypes PRIMARY KEY ([PackageTypeCode])
);
GO

CREATE TABLE [Treatments] (
    [TreatmentCode] NVARCHAR(10) NOT NULL,
    [Description]   NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_Treatments PRIMARY KEY ([TreatmentCode])
);
GO

CREATE TABLE [TreatmentTypes] (
    [TreatmentTypeCode] NVARCHAR(10) NOT NULL,
    [Description]       NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_TreatmentTypes PRIMARY KEY ([TreatmentTypeCode])
);
GO

CREATE TABLE [TreatmentIngredients] (
    [IngredientCode] INT NOT NULL,
    [Description]    NVARCHAR(500) NOT NULL,
    CONSTRAINT PK_TreatmentIngredients PRIMARY KEY ([IngredientCode])
);
GO

CREATE TABLE [TreatmentConcentrationUnits] (
    [UnitCode]    NVARCHAR(10) NOT NULL,
    [Description] NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_TreatmentConcentrationUnits PRIMARY KEY ([UnitCode])
);
GO


-- 5. CERTIFICATION & REGULATORY LOGIC
-- -----------------------------------------------------------------------------

CREATE TABLE [RegulatoryDocuments] (
    [DocumentTypeCode] NVARCHAR(10) NOT NULL,
    [Description]      NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_RegulatoryDocuments PRIMARY KEY ([DocumentTypeCode])
);
GO

CREATE TABLE [ApprovedCertifiers] (
    [CertifierCode] NVARCHAR(10) NOT NULL,
    [CertifierName] NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_ApprovedCertifiers PRIMARY KEY ([CertifierCode])
);
CREATE INDEX IX_ApprovedCertifiers_Name ON [ApprovedCertifiers] ([CertifierName]);
GO

CREATE TABLE [DeclarationIndicators] (
    [IndicatorCode] CHAR(1) NOT NULL,
    [Description]   NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_DeclarationIndicators PRIMARY KEY ([IndicatorCode])
);
GO

CREATE TABLE [CertificatePrintIndicators] (
    [IndicatorCode] CHAR(1) NOT NULL,
    [Description]   NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_CertificatePrintIndicators PRIMARY KEY ([IndicatorCode])
);
GO

CREATE TABLE [ProcessTypes] (
    [ProcessTypeCode] NVARCHAR(10) NOT NULL,
    [Description]     NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_ProcessTypes PRIMARY KEY ([ProcessTypeCode])
);
GO

CREATE TABLE [RFPComplianceStatuses] (
    [StatusCode]  NVARCHAR(10) NOT NULL,
    [Description] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_RFPComplianceStatuses PRIMARY KEY ([StatusCode])
);
GO

CREATE TABLE [RFPReasons] (
    [ReasonCode]  INT NOT NULL,
    [Description] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_RFPReasons PRIMARY KEY ([ReasonCode])
);
GO

CREATE TABLE [CertificateReasons] (
    [ReasonCode]  INT NOT NULL,
    [Description] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_CertificateReasons PRIMARY KEY ([ReasonCode])
);
GO

CREATE TABLE [CertificateRequestStatuses] (
    [StatusCode]  CHAR(1) NOT NULL,
    [Description] NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_CertificateRequestStatuses PRIMARY KEY ([StatusCode])
);
GO

CREATE TABLE [ProductUseIndicators] (
    [UseCode]     CHAR(1) NOT NULL,
    [Description] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_ProductUseIndicators PRIMARY KEY ([UseCode])
);
GO

CREATE TABLE [IntendedUses] (
    [UseCode]     CHAR(4) NOT NULL,
    [Description] NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_IntendedUses PRIMARY KEY ([UseCode])
);
GO


-- 6. MEASUREMENTS, UNITS & QUALIFIERS
-- -----------------------------------------------------------------------------

CREATE TABLE [Currencies] (
    [CurrencyUnit] NVARCHAR(10) NOT NULL,
    [Description]  NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_Currencies PRIMARY KEY ([CurrencyUnit])
);
GO

CREATE TABLE [UnitsOfMeasure] (
    [UnitCode]    NVARCHAR(10) NOT NULL,
    [UnitType]    NVARCHAR(50) NOT NULL, 
    [Description] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_UnitsOfMeasure PRIMARY KEY ([UnitCode])
);
CREATE INDEX IX_UnitsOfMeasure_Type ON [UnitsOfMeasure] ([UnitType]);
GO

CREATE TABLE [WeightUnitsShort] (
    [WeightUnit]  NVARCHAR(10) NOT NULL,
    [Description] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_WeightUnitsShort PRIMARY KEY ([WeightUnit])
);
GO

CREATE TABLE [WeightUnitsAlternate] (
    [WeightUnit]  NVARCHAR(10) NOT NULL,
    [Description] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_WeightUnitsAlternate PRIMARY KEY ([WeightUnit])
);
GO

CREATE TABLE [CustomsWeightUnits] (
    [UnitCode] NVARCHAR(10) NOT NULL,
    CONSTRAINT PK_CustomsWeightUnits PRIMARY KEY ([UnitCode])
);
GO

CREATE TABLE [QualityQualifiers] (
    [QualityQualifier] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_QualityQualifiers PRIMARY KEY ([QualityQualifier])
);
GO

CREATE TABLE [SupplementaryCodes] (
    [SupplementaryCode] NVARCHAR(10) NOT NULL,
    [Description]       NVARCHAR(255) NOT NULL,
    [ApplicableCommodities] NVARCHAR(100), 
    CONSTRAINT PK_SupplementaryCodes PRIMARY KEY ([SupplementaryCode])
);
GO

CREATE TABLE [TransportModes] (
    [ModeCode]    INT NOT NULL,
    [Description] NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_TransportModes PRIMARY KEY ([ModeCode])
);
GO