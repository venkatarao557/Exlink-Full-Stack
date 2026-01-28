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
-- 1. Region Management
CREATE TABLE [Regions] (
    [RegionCode]  NVARCHAR(10) NOT NULL,
    [RegionName]  NVARCHAR(100) NOT NULL,
    [Commodities] NVARCHAR(255), -- List of supported commodity codes
    CONSTRAINT PK_Regions PRIMARY KEY ([RegionCode])
);
GO

-- 2. Country-Commodity Mapping (Reference Table)
CREATE TABLE [CountryCommodities] (
    [CountryCode] NVARCHAR(5) NOT NULL,
    [CountryName] NVARCHAR(100) NOT NULL,
    [Commodities] NVARCHAR(255),
    CONSTRAINT PK_CountryCommodities PRIMARY KEY ([CountryCode])
);
GO

-- 3. Port Master Data
CREATE TABLE [Ports] (
    [PortCode] NVARCHAR(10) NOT NULL,
    [PortName] NVARCHAR(150) NOT NULL,
    CONSTRAINT PK_Ports PRIMARY KEY ([PortCode])
);
CREATE INDEX IX_Ports_Name ON [Ports] ([PortName]);
GO

-- 4. Commodity Master Data
CREATE TABLE [Commodities] (
    [CommodityCode] NVARCHAR(5) NOT NULL,
    [Description]   NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_Commodities PRIMARY KEY ([CommodityCode])
);
GO

-- 5. Global Country Master
CREATE TABLE [Countries] (
    [CountryCode] NVARCHAR(5) NOT NULL,
    [CountryName] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_Countries PRIMARY KEY ([CountryCode])
);
GO

-- 6. Currency Master Data
CREATE TABLE [Currencies] (
    [CurrencyUnit] NVARCHAR(10) NOT NULL,
    [Description]  NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_Currencies PRIMARY KEY ([CurrencyUnit])
);
GO

-- 7. Meat Cut Specifications
CREATE TABLE [MeatCuts] (
    [CutCode]               NVARCHAR(20) NOT NULL,
    [Description]           NVARCHAR(255) NOT NULL,
    [CommodityCode]         NVARCHAR(5),
    [IsBoneIn]              CHAR(1), -- 'I' for In, 'O' for Out
    [IsBeefVeal]            CHAR(1), -- 'Y' or 'N'
    [IsChemicalLean]        CHAR(1), -- 'Y' or 'N'
    CONSTRAINT PK_MeatCuts PRIMARY KEY ([CutCode]),
    CONSTRAINT FK_MeatCuts_Commodities FOREIGN KEY ([CommodityCode]) 
        REFERENCES [Commodities] ([CommodityCode])
);
GO

-- 8. Declaration Indicators
CREATE TABLE [DeclarationIndicators] (
    [IndicatorCode] CHAR(1) NOT NULL,
    [Description]   NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_DeclarationIndicators PRIMARY KEY ([IndicatorCode])
);
GO

-- 9. European/Specific Country List
CREATE TABLE [SpecificCountries] (
    [CountryCode] NVARCHAR(5) NOT NULL,
    [CountryName] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_SpecificCountries PRIMARY KEY ([CountryCode])
);
GO

-- 10. Commodity Configuration (Packing and Preservation)
CREATE TABLE [CommodityConfigurations] (
    [CommodityCode]     NVARCHAR(5) NOT NULL,
    [PreservationCode]  NVARCHAR(5) NOT NULL,
    [ProductTypeCode]   NVARCHAR(10) NOT NULL,
    [PackTypeCode]      NVARCHAR(10) NOT NULL,
    [SupplementaryCode] NVARCHAR(10) NOT NULL DEFAULT '',
    CONSTRAINT PK_CommodityConfigs PRIMARY KEY (
        [CommodityCode], 
        [PreservationCode], 
        [ProductTypeCode], 
        [PackTypeCode], 
        [SupplementaryCode]
    ),
    CONSTRAINT FK_Configs_Commodities FOREIGN KEY ([CommodityCode]) 
        REFERENCES [Commodities] ([CommodityCode])
);
GO

-- SQL Server 2022 Table Creation Script (Files E11-E20)

-- 1. Certificate Printing Methods (E11.txt)
CREATE TABLE [CertificatePrintIndicators] (
    [IndicatorCode] CHAR(1) NOT NULL,
    [Description]   NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_CertificatePrintIndicators PRIMARY KEY ([IndicatorCode])
);
GO

-- 2. Weight Unit Master - Short List (E12.txt)
CREATE TABLE [WeightUnitsShort] (
    [WeightUnit]  NVARCHAR(10) NOT NULL,
    [Description] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_WeightUnitsShort PRIMARY KEY ([WeightUnit])
);
GO

-- 3. Location Qualifiers (E13.txt)
-- Note: Data contains single values like 'Australian', 'Tasmanian'
CREATE TABLE [LocationQualifiers] (
    [LocationQualifier] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_LocationQualifiers PRIMARY KEY ([LocationQualifier])
);
GO

-- 4. Comprehensive Unit of Measure Master (E14.txt)
CREATE TABLE [UnitsOfMeasure] (
    [UnitCode]    NVARCHAR(10) NOT NULL,
    [UnitType]    NVARCHAR(50) NOT NULL, -- e.g., MASS, LENGTH, VOLUME
    [Description] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_UnitsOfMeasure PRIMARY KEY ([UnitCode])
);
CREATE INDEX IX_UnitsOfMeasure_Type ON [UnitsOfMeasure] ([UnitType]);
GO

-- 5. Weight Unit Master - Alternative List (E15.txt)
CREATE TABLE [WeightUnitsAlternate] (
    [WeightUnit]  NVARCHAR(10) NOT NULL,
    [Description] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_WeightUnitsAlternate PRIMARY KEY ([WeightUnit])
);
GO

-- 6. Commodity Pack Types (E16.txt)
CREATE TABLE [PackTypes] (
    [PackTypeCode] NVARCHAR(10) NOT NULL,
    [Description]  NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_PackTypes PRIMARY KEY ([PackTypeCode])
);
GO

-- 7. General Package Types (E17.txt)
CREATE TABLE [PackageTypes] (
    [PackageTypeCode] NVARCHAR(10) NOT NULL,
    [Description]     NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_PackageTypes PRIMARY KEY ([PackageTypeCode])
);
GO

-- 8. Regulatory Document Types & Authorities (E18.txt)
CREATE TABLE [RegulatoryDocuments] (
    [DocumentTypeCode] NVARCHAR(10) NOT NULL,
    [Description]      NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_RegulatoryDocuments PRIMARY KEY ([DocumentTypeCode])
);
GO

-- 9. Preservation Methods (E19.txt)
CREATE TABLE [PreservationTypes] (
    [PreservationCode] CHAR(1) NOT NULL,
    [Description]      NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_PreservationTypes PRIMARY KEY ([PreservationCode])
);
GO

-- 10. Establishment Process Types (E20.txt)
CREATE TABLE [ProcessTypes] (
    [ProcessTypeCode] NVARCHAR(10) NOT NULL,
    [Description]     NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_ProcessTypes PRIMARY KEY ([ProcessTypeCode])
);
GO

-- SQL Server 2022 Table Creation Script (Files E21-E30)

-- 1. Product Type Master with Scientific Names (E21.txt)
CREATE TABLE [ProductTypes] (
    [CommodityCode]   NVARCHAR(5) NOT NULL,
    [ProductTypeCode] NVARCHAR(10) NOT NULL,
    [Description]     NVARCHAR(255) NOT NULL,
    [ScientificName]  NVARCHAR(255),
    CONSTRAINT PK_ProductTypes PRIMARY KEY ([CommodityCode], [ProductTypeCode])
);
GO

-- 2. Quality Qualifiers (E22.txt)
CREATE TABLE [QualityQualifiers] (
    [QualityQualifier] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_QualityQualifiers PRIMARY KEY ([QualityQualifier])
);
GO

-- 3. RFP Compliance Status Codes (E23.txt)
CREATE TABLE [RFPComplianceStatuses] (
    [StatusCode]  NVARCHAR(10) NOT NULL,
    [Description] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_RFPComplianceStatuses PRIMARY KEY ([StatusCode])
);
GO

-- 4. RFP Transaction Reason Codes (E24.txt)
CREATE TABLE [RFPReasons] (
    [ReasonCode]  INT NOT NULL,
    [Description] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_RFPReasons PRIMARY KEY ([ReasonCode])
);
GO

-- 5. Supplementary Commodity Codes (E25.txt)
CREATE TABLE [SupplementaryCodes] (
    [SupplementaryCode] NVARCHAR(10) NOT NULL,
    [Description]       NVARCHAR(255) NOT NULL,
    [ApplicableCommodities] NVARCHAR(100), -- Comma separated list of commodity codes
    CONSTRAINT PK_SupplementaryCodes PRIMARY KEY ([SupplementaryCode])
);
GO

-- 6. Transport Mode Master (E26.txt)
CREATE TABLE [TransportModes] (
    [ModeCode]    INT NOT NULL,
    [Description] NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_TransportModes PRIMARY KEY ([ModeCode])
);
GO

-- 7. US Specific Territory List (E27.txt)
CREATE TABLE [USTerritories] (
    [CountryCode] CHAR(2) NOT NULL,
    [CountryName] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_USTerritories PRIMARY KEY ([CountryCode])
);
GO

-- 8. Certificate Request Reason Codes (E28.txt)
CREATE TABLE [CertificateReasons] (
    [ReasonCode]  INT NOT NULL,
    [Description] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_CertificateReasons PRIMARY KEY ([ReasonCode])
);
GO

-- 9. Regional/State Office Master (E29.txt)
CREATE TABLE [Offices] (
    [OfficeCode] NVARCHAR(10) NOT NULL,
    [OfficeName] NVARCHAR(150) NOT NULL,
    [State]      NVARCHAR(10) NOT NULL,
    CONSTRAINT PK_Offices PRIMARY KEY ([OfficeCode])
);
CREATE INDEX IX_Offices_State ON [Offices] ([State]);
GO

-- 10. Treatment and Disinfestation Methods (E30.txt)
CREATE TABLE [Treatments] (
    [TreatmentCode] NVARCHAR(10) NOT NULL,
    [Description]   NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_Treatments PRIMARY KEY ([TreatmentCode])
);
GO

-- SQL Server 2022 Table Creation Script (Files E31-E40)

-- 1. Certificate Request Status (E31.txt)
CREATE TABLE [CertificateRequestStatuses] (
    [StatusCode]  CHAR(1) NOT NULL,
    [Description] NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_CertificateRequestStatuses PRIMARY KEY ([StatusCode])
);
GO

-- 2. Product End-Use Indicators (E32.txt)
CREATE TABLE [ProductUseIndicators] (
    [UseCode]     CHAR(1) NOT NULL,
    [Description] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_ProductUseIndicators PRIMARY KEY ([UseCode])
);
GO

-- 3. Nature of Commodity Master (E33.txt)
CREATE TABLE [CommodityNatures] (
    [NatureCode]  NVARCHAR(10) NOT NULL,
    [Description] NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_CommodityNatures PRIMARY KEY ([NatureCode])
);
GO

-- 4. Treatment Type Master (E34.txt)
CREATE TABLE [TreatmentTypes] (
    [TreatmentTypeCode] NVARCHAR(10) NOT NULL,
    [Description]       NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_TreatmentTypes PRIMARY KEY ([TreatmentTypeCode])
);
GO

-- 5. State/Territory Master (E35.txt)
CREATE TABLE [States] (
    [StateCode] CHAR(3) NOT NULL,
    [StateName] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_States PRIMARY KEY ([StateCode])
);
GO

-- 6. Customs Weight Unit Master (E36.txt)
CREATE TABLE [CustomsWeightUnits] (
    [UnitCode] NVARCHAR(10) NOT NULL,
    CONSTRAINT PK_CustomsWeightUnits PRIMARY KEY ([UnitCode])
);
GO

-- 7. AHECC to Product Mapping (E37.txt)
CREATE TABLE [AHECCProductMappings] (
    [AHECCCode]       NVARCHAR(20) NOT NULL,
    [CutCode]         NVARCHAR(20) NOT NULL,
    [ProductTypeCode] NVARCHAR(10) NOT NULL,
    [Description]     NVARCHAR(255),
    CONSTRAINT PK_AHECCProductMappings PRIMARY KEY ([AHECCCode], [CutCode], [ProductTypeCode])
);
GO

-- 8. Dominant Species/Products (E38.txt)
CREATE TABLE [DominantProducts] (
    [ProductName] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_DominantProducts PRIMARY KEY ([ProductName])
);
GO

-- 9. Approved Certification Authorities (E39.txt)
CREATE TABLE [ApprovedCertifiers] (
    [CertifierCode] NVARCHAR(10) NOT NULL,
    [CertifierName] NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_ApprovedCertifiers PRIMARY KEY ([CertifierCode])
);
GO

-- 10. CN/AHECC Classification Master (E40.txt)
CREATE TABLE [ClassificationMaster] (
    [CNCode]        NVARCHAR(20) NOT NULL,
    [AHECCCode]     NVARCHAR(20) NOT NULL DEFAULT '',
    [Description]   NVARCHAR(MAX) NOT NULL,
    [StartDate]     DATETIME2(7) NOT NULL,
    [EndDate]       DATETIME2(7) NULL,
    CONSTRAINT PK_ClassificationMaster PRIMARY KEY ([CNCode], [AHECCCode], [StartDate])
);
CREATE INDEX IX_Classification_AHECC ON [ClassificationMaster] ([AHECCCode]);
GO

/* SQL Server 2022 Table Creation Script 
   Derived from uploaded data files: E40, E41, E42, E43, E44, E45
*/

-- 1. Product Classification Table (E40) 
-- Primary Key is a composite of CN_CODE and AHECC as CN_CODE repeats for different sub-codes.
CREATE TABLE ProductClassification (
    CN_CODE NVARCHAR(20) NOT NULL,
    AHECC NVARCHAR(20) NOT NULL,
    CN_DESCRIPTION NVARCHAR(MAX) NOT NULL,
    START_DATE DATETIME2 NOT NULL,
    END_DATE DATETIME2 NULL,
    CONSTRAINT PK_ProductClassification PRIMARY KEY (CN_CODE, AHECC)
);
-- Index on AHECC for faster specific code lookups 
CREATE INDEX IX_ProductClassification_AHECC ON ProductClassification (AHECC);
GO

-- 41. Treatment Active Ingredients
CREATE TABLE [TreatmentIngredients] (
    [IngredientCode] INT NOT NULL,
    [Description]    NVARCHAR(500) NOT NULL,
    CONSTRAINT PK_TreatmentIngredients PRIMARY KEY ([IngredientCode])
);
GO

-- 42. Treatment Concentration Units
CREATE TABLE [TreatmentConcentrationUnits] (
    [UnitCode]    NVARCHAR(10) NOT NULL,
    [Description] NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_TreatmentConcentrationUnits PRIMARY KEY ([UnitCode])
);
GO

-- 43. Product Condition Types
CREATE TABLE [ProductConditions] (
    [ConditionCode] CHAR(4) NOT NULL,
    [Description]   NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_ProductConditions PRIMARY KEY ([ConditionCode])
);
GO

-- 44. Product Part Types
CREATE TABLE [ProductParts] (
    [PartCode]    CHAR(4) NOT NULL,
    [Description] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_ProductParts PRIMARY KEY ([PartCode])
);
GO

-- 45. Intended Use Types
CREATE TABLE [IntendedUses] (
    [UseCode]     CHAR(4) NOT NULL,
    [Description] NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_IntendedUses PRIMARY KEY ([UseCode])
);
GO

