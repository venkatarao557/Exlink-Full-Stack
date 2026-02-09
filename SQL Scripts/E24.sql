-- =============================================================================
-- BATCH INSERT SCRIPT: RFPReason Table (E24)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @RFPReasonCount INT = 0;

CREATE TABLE #SourceData (
    ReasonCode INT,
    Description NVARCHAR(100)
);

-- Inserting data from E24.txt
INSERT INTO #SourceData (ReasonCode, Description) VALUES
(1, 'Delete'),
(4, 'Amend'),
(5, 'Mini Amend'),
(7, 'Copy Advice'),
(11, 'RFP Acknowledgement'),
(13, 'Lodge'),
(16, 'Order'),
(18, 'Reissue'),
(31, 'Copy'),
(80, 'Forward Advice'),
(90, 'Transfer'),
(91, 'Transfer Advice'),
(92, 'Accept'),
(93, 'Accept Advice'); 

INSERT INTO [RFPReason] (ReasonCode, Description)
SELECT s.ReasonCode, s.Description
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [RFPReason] t 
    WHERE t.ReasonCode = s.ReasonCode
);

SET @RFPReasonCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @RFPReasonCount > 0
    PRINT CAST(@RFPReasonCount AS NVARCHAR(10)) + ' records inserted successfully into Table RFPReason.';
ELSE
    PRINT 'No new records were inserted into Table RFPReason.';

COMMIT TRANSACTION;
GO