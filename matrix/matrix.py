def find_string_location(M, S):
    rows = len(M)
    cols = len(M[0])
    max_len = max(rows, cols)
    
    # Check rows
    for i in range(rows):
        row_str = ''.join(M[i])
        if S in row_str:
            return f"row {i+1}"
        
        # Check for reversed string in row
        reversed_row_str = row_str[::-1]
        if S in reversed_row_str:
            return f"row {i+1} (reversed)"
    
    # Check columns
    for j in range(cols):
        col_str = ''.join(M[i][j] for i in range(rows))
        if S in col_str:
            return f"column {j+1}"
        
        # Check for reversed string in column
        reversed_col_str = col_str[::-1]
        if S in reversed_col_str:
            return f"column {j+1} (reversed)"
    
    return "String not found in matrix"


# Read matrix row by row from user input
M = []
while True:
    row_str = input()
    if not row_str:
        break
    row = list(row_str)
    M.append(row)

# Read word to search from user input
S = input()

# Find location of word in matrix
result = find_string_location(M, S)
print(result)
