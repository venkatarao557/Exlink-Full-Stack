-- =============================================================================
-- BATCH INSERT SCRIPT: RFPComplianceStatus Table (E23)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @RFPStatusCount INT = 0;

CREATE TABLE #SourceData (
    StatusCode NVARCHAR(10),
    Description NVARCHAR(100)
);

-- Inserting data from E23.txt
INSERT INTO #SourceData (StatusCode, Description) VALUES
('CANC', 'CANCEL'),
('COMP', 'COMPLETED'),
('EMHC', 'EMERGENCY HEALTH CERTIFICATE'),
('FINL', 'FINAL'),
('HCRD', 'HEALTH CERTIFICATE READY'),
('INIT', 'INITIAL'),
('INSP', 'INSPECTED'),
('ORDR', 'ORDER'),
('SUSP', 'SUSPENDED')[cite_start]; [cite: 13]

INSERT INTO [RFPComplianceStatus] (StatusCode, Description)
SELECT s.StatusCode, s.Description
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [RFPComplianceStatus] t 
    WHERE t.StatusCode = s.StatusCode
);

SET @RFPStatusCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @RFPStatusCount > 0
    PRINT CAST(@RFPStatusCount AS NVARCHAR(10)) + ' records inserted successfully into Table RFPComplianceStatus.';
ELSE
    PRINT 'No new records were inserted into Table RFPComplianceStatus.';

COMMIT TRANSACTION;
GO