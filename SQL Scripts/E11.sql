-- =============================================================================
-- BATCH INSERT SCRIPT: CertificatePrintIndicator Table (E11)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @CertPrintCount INT = 0;

-- Temporary table to hold the source data
CREATE TABLE #SourceData (
    IndicatorCode CHAR(1),
    Description NVARCHAR(100)
);

-- Inserting data from E11.txt
INSERT INTO #SourceData (IndicatorCode, Description) VALUES
('A', 'Automatic'), --
('C', 'Custom Certificate'), --
('M', 'Manual'), --
('N', 'Not Required'); --

-- Insert only if the IndicatorCode doesn't already exist in the target table
INSERT INTO [CertificatePrintIndicator] (IndicatorCode, Description)
SELECT s.IndicatorCode, s.Description
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [CertificatePrintIndicator] t 
    WHERE t.IndicatorCode = s.IndicatorCode
);

SET @CertPrintCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @CertPrintCount > 0
    PRINT CAST(@CertPrintCount AS NVARCHAR(10)) + ' records inserted successfully into Table CertificatePrintIndicator.';
ELSE
    PRINT 'No new records were inserted into Table CertificatePrintIndicator (all records already exist).';

COMMIT TRANSACTION;
GO