import os

def generate_e21_sql_script(input_file, output_file):
    # Header for the SQL Script
    sql_header = """-- =============================================================================
-- BATCH INSERT SCRIPT: ProductType Table (E21)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @ProductTypeCount INT = 0;

-- Temporary table to hold the source data
CREATE TABLE #SourceData (
    CommodityCode NVARCHAR(5),
    ProductTypeCode NVARCHAR(10),
    Description NVARCHAR(255),
    ScientificName NVARCHAR(255)
);

-- Inserting data from E21.txt
INSERT INTO #SourceData (CommodityCode, ProductTypeCode, Description, ScientificName) VALUES
"""

    # SQL logic for performing the join on CommodityID and inserting
    sql_footer = """
-- Insert joining on CommodityID from the Commodity Master table
INSERT INTO [ProductType] (CommodityID, ProductTypeCode, [Description], ScientificName)
SELECT 
    c.CommodityID, 
    s.ProductTypeCode, 
    s.Description, 
    s.ScientificName
FROM #SourceData s
JOIN [Commodity] c ON s.CommodityCode = c.CommodityCode
WHERE NOT EXISTS (
    SELECT 1 FROM [ProductType] t 
    WHERE t.CommodityID = c.CommodityID 
    AND t.ProductTypeCode = s.ProductTypeCode
);

SET @ProductTypeCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @ProductTypeCount > 0
    PRINT CAST(@ProductTypeCount AS NVARCHAR(10)) + ' records inserted successfully into Table ProductType.';
ELSE
    PRINT 'No new records were inserted into Table ProductType (all records already exist).';

COMMIT TRANSACTION;
GO
"""

    values_rows = []

    try:
        with open(input_file, 'r') as f:
            # Skip the header lines (Source info and column headers)
            lines = f.readlines()[2:] 
            
            for line in lines:
                if not line.strip():
                    continue
                
                # Split by tab (standard for these text files)
                parts = [p.strip() for p in line.split('\t')]
                
                if len(parts) >= 4:
                    comm_code = parts[0].replace("'", "''")
                    prod_code = parts[1].replace("'", "''")
                    desc = parts[2].replace("'", "''")
                    sci_name = parts[3].replace("'", "''")
                    
                    row = f"('{comm_code}', '{prod_code}', '{desc}', '{sci_name}')"
                    values_rows.append(row)

        # Join rows with commas and formatting
        full_sql = sql_header + ",\n".join(values_rows) + ";" + sql_footer

        with open(output_file, 'w') as out_f:
            out_f.write(full_sql)
            
        print(f"Success! SQL script generated: {output_file}")

    except Exception as e:
        print(f"An error occurred: {e}")

# Run the generator
generate_e21_sql_script('E21.txt', 'Batch_Insert_E21.sql')