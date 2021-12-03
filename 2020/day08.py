def get_data(filepath):
    with open(filepath) as f:
        return [line.replace('\n', '') for line in f]

    
def get_acc(data):
    usedi = set()
    index = 0
    accumulator = 0   
    while True:
        if index in usedi:
            break
        usedi.add(index)
        line = (data[index]).split(' ')    
        if 'acc' in line[0]:
            accumulator += int(line[1]) 
        elif 'jmp' in line[0]:
            index += int(line[1]) - 1 
        index +=1
    return accumulator

def get_acc2(data): 
    def mutate (data):
        def redo(line):
            line = (line).split(' ')    
            if 'jmp' in line:
                return 'nop ' + line[1]
            elif 'nop' in line:
                return 'jmp ' + line[1]
            else:
                return 'acc ' + line[1]
        return list(map(redo, data))
    mutant = mutate(data)
    jndex = 0
    while jndex < len(data):
        usedi = set()
        index = 0
        accumulator = 0
        jndex += 1
        while index < len(data):
            if index in usedi:
                break 
            usedi.add(index)
            if jndex == index:
                line = (mutant[index]).split(' ') 
            else:
                line = (data[index]).split(' ')        
            if 'acc' in line[0]:
                accumulator += int(line[1]) 
            elif 'jmp' in line[0]:
                index += int(line[1]) - 1 
            index +=1
            if index == len(data):
                return accumulator 
        


data = get_data('data/2020/input08.txt')


print("-----")
print("Day 8 problem 1: " + str(get_acc(data)))
print("Day 8 problem 2: " + str(get_acc2(data))) 
print("-----")