import os

def generate_sql_from_e10(input_file, output_file):
    # SQL Template components
    sql_header = """-- =============================================================================
-- BATCH INSERT SCRIPT: ProductPack Table (Generated from E10.txt)
-- =============================================================================

BEGIN TRANSACTION;
GO

-- Temporary table to hold the source data
CREATE TABLE #E10Source (
    CommodityCode NVARCHAR(10),
    PreservationCode NVARCHAR(10),
    ProductTypeCode NVARCHAR(10),
    PackTypeCode NVARCHAR(10),
    SupplementaryCode NVARCHAR(10)
);

INSERT INTO #E10Source (CommodityCode, PreservationCode, ProductTypeCode, PackTypeCode, SupplementaryCode) VALUES
"""

    sql_footer = """
-- Bulk insert with duplicate prevention (Composite Key Check)
INSERT INTO [exlink].[ProductPack] (
    CommodityCode, 
    PreservationCode, 
    ProductTypeCode, 
    PackTypeCode, 
    SupplementaryCode
)
SELECT 
    s.CommodityCode, 
    s.PreservationCode, 
    s.ProductTypeCode, 
    s.PackTypeCode, 
    s.SupplementaryCode
FROM #E10Source s
WHERE NOT EXISTS (
    SELECT 1 FROM [exlink].[ProductPack] t 
    WHERE t.CommodityCode = s.CommodityCode
      AND t.PreservationCode = s.PreservationCode
      AND t.ProductTypeCode = s.ProductTypeCode
      AND t.PackTypeCode = s.PackTypeCode
      AND (t.SupplementaryCode = s.SupplementaryCode OR (t.SupplementaryCode IS NULL AND s.SupplementaryCode = ''))
);

PRINT CAST(@@ROWCOUNT AS NVARCHAR(10)) + ' mapping records processed into [exlink].[ProductPack].';

DROP TABLE #E10Source;
COMMIT TRANSACTION;
GO
"""

    values_list = []
    
    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            # Skip header line: COMMODITY CODE, PRESERVATION CODE, etc.
            header = f.readline()
            
            for line in f:
                line = line.strip('\n') # Keep internal spaces, strip newline
                if not line.strip():
                    continue
                
                # Split by tab
                parts = line.split('\t')
                
                # Ensure we handle up to 5 columns even if the last one is empty
                # Pad with empty strings if parts are missing
                while len(parts) < 5:
                    parts.append('')
                
                # Clean and escape values
                clean_parts = [p.strip().replace("'", "''") for p in parts[:5]]
                
                # Format as SQL values row
                val_row = "('" + "', '".join(clean_parts) + "')"
                values_list.append(val_row)

        # Combine and write to file
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(sql_header)
            # Join all rows with comma and newline
            f.write(",\n".join(values_list))
            f.write(";")
            f.write(sql_footer)
        
        print(f"Successfully generated {output_file} with {len(values_list)} records.")

    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    input_path = 'E10.txt'
    output_path = 'insert_E10_records.sql'
    
    if os.path.exists(input_path):
        generate_sql_from_e10(input_path, output_path)
    else:
        print(f"Error: {input_path} not found.")