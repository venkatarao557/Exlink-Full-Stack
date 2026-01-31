import os

def generate_e40_sql_script(input_file, output_file):
    # Header for the SQL Script
    sql_header = """-- =============================================================================
-- BATCH INSERT SCRIPT: EU_ProductMapping Table (E40)
-- =============================================================================

BEGIN TRANSACTION;
GO

DECLARE @MappingCount INT = 0;

-- Temporary table to hold the source data from E40.txt
CREATE TABLE #SourceData (
    CNCode NVARCHAR(20),
    AHECC NVARCHAR(20),
    CNDescription NVARCHAR(MAX),
    StartDate DATETIME
);

-- Inserting data from E40.txt
INSERT INTO #SourceData (CNCode, AHECC, CNDescription, StartDate) VALUES
"""

    # SQL logic for the final insert
    sql_footer = """
-- Insert only if the unique combination of CNCode and AHECC doesn't exist
INSERT INTO [EU_ProductMapping] (CNCode, AHECC, CNDescription, StartDate)
SELECT 
    LTRIM(RTRIM(s.CNCode)), 
    NULLIF(LTRIM(RTRIM(s.AHECC)), ''), -- Handle blank AHECC as NULL
    s.CNDescription, 
    s.StartDate
FROM #SourceData s
WHERE NOT EXISTS (
    SELECT 1 FROM [EU_ProductMapping] t 
    WHERE t.CNCode = s.CNCode 
    AND (t.AHECC = s.AHECC OR (t.AHECC IS NULL AND s.AHECC = ''))
);

SET @MappingCount = @@ROWCOUNT;

DROP TABLE #SourceData;

IF @MappingCount > 0
    PRINT CAST(@MappingCount AS NVARCHAR(10)) + ' records inserted successfully into Table EU_ProductMapping.';
ELSE
    PRINT 'No new records were inserted into Table EU_ProductMapping.';

COMMIT TRANSACTION;
GO
"""

    values_rows = []

    try:
        if not os.path.exists(input_file):
            print(f"Error: {input_file} not found.")
            return

        with open(input_file, 'r', encoding='utf-8') as f:
            # Read all lines and skip the header (CN CODE, AHECC, CN DESCRIPTION, START DATE, END DATE)
            lines = f.readlines()[1:] 
            
            for line in lines:
                if not line.strip():
                    continue
                
                # Split by tab
                parts = [p.strip() for p in line.split('\t')]
                
                # We need at least 4 parts (CNCode, AHECC, Description, StartDate)
                if len(parts) >= 4:
                    cn_code = parts[0].replace("'", "''")
                    ahecc = parts[1].replace("'", "''")
                    description = parts[2].replace("'", "''")
                    start_date = parts[3].replace("'", "''")
                    
                    # Convert blank dates or descriptions if necessary, but here we follow string format
                    row = f"('{cn_code}', '{ahecc}', '{description}', '{start_date}')"
                    values_rows.append(row)

        # Combine components
        full_sql = sql_header + ",\n".join(values_rows) + ";" + sql_footer

        with open(output_file, 'w', encoding='utf-8') as out_f:
            out_f.write(full_sql)
            
        print(f"Success! SQL script generated: {output_file}")
        print(f"Processed {len(values_rows)} rows from {input_file}.")

    except Exception as e:
        print(f"An error occurred: {e}")

# Run the generator
if __name__ == "__main__":
    generate_e40_sql_script('E40.txt', 'Batch_Insert_E40_EU_ProductMapping.sql')