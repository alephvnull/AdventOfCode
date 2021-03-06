from collections import deque
from math import gcd

def get_data(filepath):
    with open(filepath) as f:
        return [line.replace('\n', '') for line in f]

def earliest_bus(data):
    timestamp = int(data[0])
    values = list(map(int , [*(set(data[1].split(',')) - set('x'))]))
    div = list(map(lambda x: x - timestamp %x, values))
    mn = min(div) 
    indx = [i for i, j in enumerate(div) if j == mn][0] 
    return  mn * values[indx]


def gold_coin(data):
    id_bus = deque([(i, int(bus)) for i, bus in enumerate(data[1].split(',')) if bus not in 'x'])
    time, step = id_bus.popleft()    
    while id_bus:
        i, bus_id = id_bus[0]
        if (time + i) % bus_id:
            time += step
        else:
            step = abs(step * bus_id) // gcd(step, bus_id)
            id_bus.popleft()            
    return time
            
    

data = get_data('data/2020/input13.txt')

print("-----")
print("Day 13 problem 1: " + str(earliest_bus(data)))
print("Day 13 problem 2: " + str(gold_coin(data))) 
print("-----")