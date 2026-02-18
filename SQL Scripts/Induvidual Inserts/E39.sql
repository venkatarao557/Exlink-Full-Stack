/* DEVOPS READY DATA MIGRATION: Table [ApprovedCertifier] (E39)
   - Idempotent: Safe for multiple runs.
   - Integrity: Synchronizes CertifierCode and CertifierName.
*/

SET NOCOUNT ON;
GO

PRINT 'Starting data ingestion for [ApprovedCertifier] (E39)...';

BEGIN TRANSACTION;
BEGIN TRY
    IF OBJECT_ID('[dbo].[ApprovedCertifier]', 'U') IS NOT NULL
    BEGIN
        -- Temporary table for staging
        CREATE TABLE #StagingCertifier (
            [Code] NVARCHAR(10),
            [Name] NVARCHAR(255)
        );

        INSERT INTO #StagingCertifier ([Code], [Name])
        VALUES 
        ('H0001', 'ADELAIDE MOSQUE ISLAMIC SOCIETY OF SOUTH AUSTRALIA'),
        ('H0002', 'AL-IMAN ISLAMIC SOCIETY'),
        ('H0003', 'AUSTRALIAN FEDERATION OF ISLAMIC COUNCILS INC'),
        ('H0004', 'AUSTRALIAN HALAL AUTHORITY AND ADVISERS'),
        ('H0005', 'AUSTRALIAN HALAL FOOD SERVICES'),
        ('H0006', 'HALAL AUSTRALIA PTY LTD'),
        ('H0007', 'HALAL CERTIFICATION AUTHORITY-AUSTRALIA'),
        ('H0008', 'HALAL MEAT BOARD OF WESTERN AUSTRALIA'),
        ('H0010', 'HALAL SUPERVISORY BOARD OF SOUTH AUSTRALIA FOR THE KINGDOM OF SAUDI ARABIA'),
        ('H0011', 'ISLAMIC ASSOCIATION OF GERALDTON'),
        ('H0012', 'ISLAMIC ASSOCIATION OF KATANNING'),
        ('H0013', 'ISLAMIC COORDINATING COUNCIL OF VICTORIA'),
        ('H0014', 'ISLAMIC COUNCIL OF WESTERN AUSTRALIA'),
        ('H0015', 'PERTH MOSQUE INCORPORATED'),
        ('H0016', 'SUPREME ISLAMIC COUNCIL OF HALAL MEAT IN AUSTRALIA INC'),
        ('H0017', 'WESTERN AUSTRALIA HALAL AUTHORITY'),
        ('H0019', 'AUSTRALIAN HALAL DEVELOPMENT AND ACCREDITATION'),
        ('H0020', 'HALAL CERTIFICATION COUNCIL'),
        ('H0021', 'MUSLIM ASSOCIATION OF RIVERINA WAGGA WAGGA INC'),
        ('H0022', 'THE HALAL APPROVAL PTY LTD'),
        ('H0023', 'AUSTRALIAN NATIONAL IMAMS COUNCIL'),
        ('H0024', 'WORLD HALAL CERTIFICATION BODY'),
        ('H0025', 'AL SADEQ ASSOCIATION'),
        ('H0026', 'GLOBAL AUSTRALIAN HALAL CERTIFICATION'),
        ('H0027', 'NATIONAL HALAL AUTHORITY'),
        ('H0028', 'WHT CERTIFICATION AUSTRALIA PTY LTD'),
        ('H0029', 'NATIONAL HALAL ACCREDITATION SERVICES AUSTRALIA PTY LTD');

        -- Use MERGE to ensure idempotency (Update if exists, Insert if new)
        MERGE INTO [dbo].[ApprovedCertifier] AS target
        USING #StagingCertifier AS src
        ON (target.[CertifierCode] = src.[Code])
        WHEN MATCHED THEN
            UPDATE SET target.[CertifierName] = src.[Name]
        WHEN NOT MATCHED THEN
            INSERT ([CertifierCode], [CertifierName])
            VALUES (src.[Code], src.[Name]);

        DECLARE @Count INT = @@ROWCOUNT;
        PRINT 'SUCCESS: ' + CAST(@Count AS VARCHAR(10)) + ' records synchronized into [ApprovedCertifier].';
        
        DROP TABLE #StagingCertifier;
    END
    ELSE
    BEGIN
        PRINT 'ERROR: Table [dbo].[ApprovedCertifier] does not exist.';
    END

    COMMIT TRANSACTION;
    PRINT 'Data migration for [ApprovedCertifier] completed successfully.';

END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    PRINT 'CRITICAL ERROR: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO