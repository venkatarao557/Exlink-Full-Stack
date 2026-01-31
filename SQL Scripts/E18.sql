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

[cite_start]-- Inserting data from E18.txt [cite: 8, 9]
INSERT INTO #SourceData (DocumentTypeCode, Description) VALUES
('AFM', 'AUSTRALIAN FISHERIES MANAGEMENT AUT')[cite_start], -- [cite: 8]
('AHB', 'AUSTRALIAN HONEY BOARD')[cite_start], -- [cite: 8]
('AHC', 'AUSTRALIAN HORTICULTURAL CORPORATIO')[cite_start], -- [cite: 8]
('AWB', 'AUSTRALIAN WHEAT BOARD')[cite_start], -- [cite: 8]
('CSH', 'DEPT OF HEALTH SERVICES - DRUG TREA')[cite_start], -- [cite: 8]
('HAL', 'HORTICULTURE AUSTRALIA LIMITED')[cite_start], -- [cite: 8]
('HBE', 'DEPT. OF HEALTH SERVICES - BLOOD EX')[cite_start], -- [cite: 8, 9]
('HEA', 'DEPT. OF HEALTH SERVICES - GENERAL')[cite_start], -- [cite: 8]
('HIA', 'HORTICULTURE INNOVATION AUSTRALIA')[cite_start], -- [cite: 8]
('IMP', 'IMPORT PERMIT')[cite_start], -- [cite: 8]
('PWS', 'ENVIRONMENT AUSTRALIA')[cite_start], -- [cite: 8]
('WBC', 'AUSTRALIAN WINE AND BRANDY CORPORAT')[cite_start], -- [cite: 8]
('WEA', 'WHEAT EXPORT AUTHORITY'); [cite_start]-- [cite: 8]

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