import re

def batch_sql_inserts(input_file, output_file, batch_size=999):
    # Template for the insert statement header
    insert_header = "INSERT INTO #E10Source (CommodityCode, PreservationCode, ProductTypeCode, PackTypeCode, SupplementaryCode) VALUES\n"
    
    with open(input_file, 'r') as f:
        content = f.read()

    # 1. Extract the script header (up to the first VALUES)
    header_match = re.search(r'([\s\S]*?INSERT INTO #E10Source .*? VALUES\n)', content, re.IGNORECASE)
    if not header_match:
        print("Could not find the start of the INSERT statement.")
        return
    
    script_header = header_match.group(1)
    
    # 2. Extract the data rows and the footer
    # Assumes data ends with a semicolon followed by the duplicate prevention logic
    data_and_footer = content[header_match.end():]
    split_point = data_and_footer.find(';')
    
    data_rows_raw = data_and_footer[:split_point].strip()
    script_footer = data_and_footer[split_point:]

    # Clean up data rows into a list
    # Splitting by '),\n(' or similar patterns to get individual rows
    rows = [r.strip() for r in data_rows_raw.split('),\n')]
    # Re-add the closing parenthesis removed by split, except for the last one
    rows = [r + ')' if not r.endswith(')') else r for r in rows]

    # 3. Process batches
    batched_content = [script_header]
    
    for i in range(0, len(rows), batch_size):
        batch = rows[i:i + batch_size]
        
        # Join rows with commas and newlines
        batch_text = ",\n".join(batch)
        batched_content.append(batch_text)
        
        # If there are more rows, close the current statement and start a new one
        if i + batch_size < len(rows):
            batched_content.append(";\nGO\n\n" + insert_header)
        else:
            # Last batch just gets the semicolon
            batched_content.append("")

    # 4. Write the final output
    with open(output_file, 'w') as f:
        f.write("".join(batched_content))
        f.write(script_footer)

    print(f"Successfully processed {len(rows)} records into batches.")

# Run the function
batch_sql_inserts('E10.sql', 'E10_Batched.sql')