/* EXLINK Master Schema - Cleanup Script
   Database: SQL Server 2022
   Order: Dependencies handled first to avoid FK constraint errors
*/
use exlink
-- 1. DROP TABLES WITH FOREIGN KEY DEPENDENCIES
DROP TABLE IF EXISTS [AHECCProductMapping]; -- References MeatCut and ProductType
DROP TABLE IF EXISTS [MeatCut];              -- References Commodity
DROP TABLE IF EXISTS [ProductType];          -- References Commodity
DROP TABLE IF EXISTS [CommodityConfiguration]; -- References Commodity
GO

-- 2. DROP REMAINING COMMODITY & PRODUCT TABLES
DROP TABLE IF EXISTS [Commodity];
DROP TABLE IF EXISTS [DominantProduct];
DROP TABLE IF EXISTS [ProductCondition];
DROP TABLE IF EXISTS [ProductPart];
DROP TABLE IF EXISTS [CommodityNature];
GO

-- 3. DROP GEOGRAPHIC & ADMINISTRATIVE TABLES
DROP TABLE IF EXISTS [Region];
DROP TABLE IF EXISTS [CountryCommodity];
DROP TABLE IF EXISTS [Port];
DROP TABLE IF EXISTS [Country];
DROP TABLE IF EXISTS [SpecificCountry];
DROP TABLE IF EXISTS [USTerritory];
DROP TABLE IF EXISTS [Office];
DROP TABLE IF EXISTS [State];
DROP TABLE IF EXISTS [LocationQualifier];
GO

-- 4. DROP CLASSIFICATION TABLES
DROP TABLE IF EXISTS [ClassificationMaster];
DROP TABLE IF EXISTS [ProductClassification];
GO

-- 5. DROP PACKAGING, PRESERVATION & TREATMENT TABLES
DROP TABLE IF EXISTS [PackType];
DROP TABLE IF EXISTS [PackageType];
DROP TABLE IF EXISTS [PreservationType];
DROP TABLE IF EXISTS [Treatment];
DROP TABLE IF EXISTS [TreatmentType];
DROP TABLE IF EXISTS [TreatmentIngredient];
DROP TABLE IF EXISTS [TreatmentConcentrationUnit];
GO

-- 6. DROP CERTIFICATION & REGULATORY TABLES
DROP TABLE IF EXISTS [DeclarationIndicator];
DROP TABLE IF EXISTS [CertificatePrintIndicator];
DROP TABLE IF EXISTS [RegulatoryDocument];
DROP TABLE IF EXISTS [ProcessType];
DROP TABLE IF EXISTS [RFPComplianceStatus];
DROP TABLE IF EXISTS [RFPReason];
DROP TABLE IF EXISTS [CertificateReason];
DROP TABLE IF EXISTS [CertificateRequestStatus];
DROP TABLE IF EXISTS [ProductUseIndicator];
DROP TABLE IF EXISTS [IntendedUse];
DROP TABLE IF EXISTS [ApprovedCertifier];
GO

-- 7. DROP MEASUREMENT & UNIT TABLES
DROP TABLE IF EXISTS [Currency];
DROP TABLE IF EXISTS [WeightUnitShort];
DROP TABLE IF EXISTS [UnitOfMeasure];
DROP TABLE IF EXISTS [WeightUnitAlternate];
DROP TABLE IF EXISTS [QualityQualifier];
DROP TABLE IF EXISTS [SupplementaryCode];
DROP TABLE IF EXISTS [TransportMode];
DROP TABLE IF EXISTS [CustomsWeightUnit];
GO