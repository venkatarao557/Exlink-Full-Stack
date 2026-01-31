-- =============================================================================
-- BATCH INSERT SCRIPT: TreatmentActiveIngredient Table (E41)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @IngredientCount INT = 0;

CREATE TABLE #SourceData (
    IngredientCode INT,
    Description NVARCHAR(255)
);

INSERT INTO #SourceData (IngredientCode, Description) VALUES
(1, 'ALDRIN AND DIELDRIN'),
(2, 'AZINPHOS-METHYL'),
(7, 'CAPTAN'),
(8, 'CARBARYL'),
(12, 'CHLORDANE'),
(15, 'CHLORMEQUAT'),
(17, 'CHLORPYRIFOS'),
(20, '2,4-D'),
(21, 'DDT'),
(22, 'DIAZINON'),
(25, 'DICHLORVOS'),
(26, 'DICOFOL'),
(27, 'DIMETHOATE'),
(30, 'DIPHENYLAMINE'),
(31, 'DIQUAT'),
(32, 'ENDOSULFAN'),
(33, 'ENDRIN'),
(34, 'ETHION'),
(35, 'ETHOXYQUIN'),
(37, 'FENITROTHION'),
(252, 'SULFOXAFLOR'),
(253, 'PENTHIOPYRAD'),
(254, 'CHLORFENAPYR'),
(255, 'DINOTEFURAN'),
(256, 'FLUXAPYROXAD'),
(257, 'MCPA'),
(258, 'PICOXYSTROBIN'),
(259, 'SEDAXANE'),
(260, 'AMETOCTRADIN'),
(261, 'BENZOVINDIFLUPYR'),
(262, 'BIXAFEN'),
(263, 'CYANTRANILIPROLE'),
(264, 'FENAMIDONE'),
(265, 'FLUENSULFONE'),
(266, 'IMAZAPIC'),
(267, 'IMAZAPYR'),
(268, 'ISOXAFLUTOLE'),
(269, 'TOLFENPYRAD');

INSERT INTO [TreatmentActiveIngredient] (IngredientCode, Description)
SELECT s.IngredientCode, s.Description
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [TreatmentActiveIngredient] t 
    WHERE t.IngredientCode = s.IngredientCode
);

SET @IngredientCount = @@ROWCOUNT;
DROP TABLE #SourceData;

IF @IngredientCount > 0
    PRINT CAST(@IngredientCount AS NVARCHAR(10)) + ' records inserted successfully into Table TreatmentActiveIngredient.';

COMMIT TRANSACTION;
GO