import os

def generate_e37_sql_script(input_file, output_file):
    # Header for the SQL Script
    sql_header = """-- =============================================================================
-- BATCH INSERT SCRIPT: ProductCut Table (E37)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @ProductCutCount INT = 0;

-- Temporary table to hold the source data from E37.txt
CREATE TABLE #SourceData (
    AHECC NVARCHAR(20),
    CutCode NVARCHAR(20),
    ProductTypeCode NVARCHAR(10),
    Description NVARCHAR(255)
);

-- Inserting data from E37.txt
INSERT INTO #SourceData (AHECC, CutCode, ProductTypeCode, Description) VALUES
"""

    # SQL logic to join with ProductType to get the Foreign Key ID
    sql_footer = """
-- Insert joining on ProductTypeID from the ProductType Master table
INSERT INTO [ProductCut] (ProductTypeID, CutCode, AHECC, [Description])
SELECT 
    pt.ProductTypeID, 
    s.CutCode, 
    NULLIF(LTRIM(RTRIM(s.AHECC)), ''), -- Handle empty strings as NULL
    s.Description
FROM #SourceData s
JOIN [ProductType] pt ON s.ProductTypeCode = pt.ProductTypeCode
WHERE NOT EXISTS (
    SELECT 1 FROM [ProductCut] t 
    WHERE t.ProductTypeID = pt.ProductTypeID 
    AND t.CutCode = s.CutCode
);

SET @ProductCutCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @ProductCutCount > 0
    PRINT CAST(@ProductCutCount AS NVARCHAR(10)) + ' records inserted successfully into Table ProductCut.';
ELSE
    PRINT 'No new records were inserted into Table ProductCut (all records already exist).';

COMMIT TRANSACTION;
GO
"""

    values_rows = []

    try:
        if not os.path.exists(input_file):
            print(f"Error: {input_file} not found.")
            return

        with open(input_file, 'r', encoding='utf-8') as f:
            # Skip the header line (AHECC	CUT CODE	PRODUCT TYPE	DESCRIPTION)
            lines = f.readlines()[1:] 
            
            for line in lines:
                if not line.strip():
                    continue
                
                # Split by tab
                parts = [p.strip() for p in line.split('\t')]
                
                # Ensure we have all 4 columns, even if AHECC is blank
                if len(parts) >= 4:
                    ahecc = parts[0].replace("'", "''")
                    cut_code = parts[1].replace("'", "''")
                    prod_type_code = parts[2].replace("'", "''")
                    desc = parts[3].replace("'", "''")
                    
                    row = f"('{ahecc}', '{cut_code}', '{prod_type_code}', '{desc}')"
                    values_rows.append(row)

        # Build full SQL content
        full_sql = sql_header + ",\n".join(values_rows) + ";" + sql_footer

        with open(output_file, 'w', encoding='utf-8') as out_f:
            out_f.write(full_sql)
            
        print(f"Success! SQL script generated: {output_file}")
        print(f"Processed {len(values_rows)} rows.")

    except Exception as e:
        print(f"An error occurred: {e}")

# Run the generator
if __name__ == "__main__":
    generate_e37_sql_script('E37.txt', 'Batch_Insert_E37_ProductCut.sql')