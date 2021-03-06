def get_data(filepath):
    with open(filepath) as f:
        return [line.replace('\n', '') for line in f]

def process_row(row):
    row_range = list(range(0, 128))
    for m in row:
        if (m == 'B'):
            row_range = row_range[len(row_range)//2:]
        else:
            row_range = row_range[:len(row_range)//2]
    
    return row_range[0]
        
    
def process_col(col):
    col_range = list(range(0,8))
    
    for m in col:
        if (m == 'R'):
            col_range = col_range[len(col_range)//2:]
        else:
            col_range = col_range[:len(col_range)//2]
                   
    return col_range[0]
    

def get_pass_id(line):
    return process_row(line[0:7]) * 8 + process_col(line[7:10])
    

data = get_data('data/2020/input05.txt')
lst = [get_pass_id(line) for line in data] 
res = [n for n in list(set(range(0, get_pass_id('BBBBBBRRR'))) - set(lst)) if 100 < n < 884][0]



print("-----")
print("Day 5 problem 1: " + str(max(lst)))
print("Day 5 problem 2: " + str(res)) 
print("-----")