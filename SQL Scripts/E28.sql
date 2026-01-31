-- =============================================================================
-- BATCH INSERT SCRIPT: CertificateReason Table (E28)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @CertReasonCount INT = 0;

CREATE TABLE #SourceData (
    ReasonCode INT,
    Description NVARCHAR(100)
);

-- Inserting data from E28.txt
INSERT INTO #SourceData (ReasonCode, Description) VALUES
(9, 'Cert Request'),
(98, 'Cert Request Acknowledgement'),
(99, 'Remote Print Acknowledgement')[cite_start]; [cite: 19]

INSERT INTO [CertificateReason] (ReasonCode, Description)
SELECT s.ReasonCode, s.Description
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [CertificateReason] t 
    WHERE t.ReasonCode = s.ReasonCode
);

SET @CertReasonCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @CertReasonCount > 0
    PRINT CAST(@CertReasonCount AS NVARCHAR(10)) + ' records inserted successfully into Table CertificateReason.';
ELSE
    PRINT 'No new records were inserted into Table CertificateReason.';

COMMIT TRANSACTION;
GO