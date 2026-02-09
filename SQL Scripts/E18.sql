-- =============================================================================
-- BATCH INSERT SCRIPT: RegulatoryDocument Table (E18)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @RegDocCount INT = 0;

CREATE TABLE #SourceData (
    DocumentTypeCode NVARCHAR(10),
    Description NVARCHAR(255)
);

-- Inserting data from E18.txt 
INSERT INTO #SourceData (DocumentTypeCode, Description) VALUES
('AFM', 'AUSTRALIAN FISHERIES MANAGEMENT AUT'), 
('AHB', 'AUSTRALIAN HONEY BOARD'), 
('AHC', 'AUSTRALIAN HORTICULTURAL CORPORATIO'), 
('AWB', 'AUSTRALIAN WHEAT BOARD'), 
('CSH', 'DEPT OF HEALTH SERVICES - DRUG TREA'), 
('HAL', 'HORTICULTURE AUSTRALIA LIMITED'), 
('HBE', 'DEPT. OF HEALTH SERVICES - BLOOD EX'), 
('HEA', 'DEPT. OF HEALTH SERVICES - GENERAL'), 
('HIA', 'HORTICULTURE INNOVATION AUSTRALIA'), 
('IMP', 'IMPORT PERMIT'), 
('PWS', 'ENVIRONMENT AUSTRALIA'), 
('WBC', 'AUSTRALIAN WINE AND BRANDY CORPORAT'), 
('WEA', 'WHEAT EXPORT AUTHORITY'); 

INSERT INTO [RegulatoryDocument] (DocumentTypeCode, Description)
SELECT s.DocumentTypeCode, s.Description
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [RegulatoryDocument] t 
    WHERE t.DocumentTypeCode = s.DocumentTypeCode
);

SET @RegDocCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @RegDocCount > 0
    PRINT CAST(@RegDocCount AS NVARCHAR(10)) + ' records inserted successfully into Table RegulatoryDocument.';
ELSE
    PRINT 'No new records were inserted into Table RegulatoryDocument.';

COMMIT TRANSACTION;
GO