-- =============================================================================
-- BATCH INSERT SCRIPT: CertificateRequestStatus Table (E31)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @CertReqStatusCount INT = 0;

CREATE TABLE #SourceData (
    StatusCode CHAR(1),
    Description NVARCHAR(255)
);

-- Inserting data from E31.txt
INSERT INTO #SourceData (StatusCode, Description) VALUES
('A', 'The Certificate Request has been approved'),
('R', 'The Certificate Request is waiting to be reviewed by an AQIS Officer'),
('N', 'The Certificate Request has been rejected by an AQIS Officer');

INSERT INTO [CertificateRequestStatus] (StatusCode, Description)
SELECT s.StatusCode, s.Description
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [CertificateRequestStatus] t 
    WHERE t.StatusCode = s.StatusCode
);

SET @CertReqStatusCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @CertReqStatusCount > 0
    PRINT CAST(@CertReqStatusCount AS NVARCHAR(10)) + ' records inserted successfully into Table CertificateRequestStatus.';
ELSE
    PRINT 'No new records were inserted into Table CertificateRequestStatus.';

COMMIT TRANSACTION;
GO