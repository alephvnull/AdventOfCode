def get_data(filepath):
    with open(filepath) as f:
        return [int(line) for line in f]

data = get_data('data/2020/input01.txt')

print("-----")
print("Day 1 problem 1: "+str([x*y for x in data for y in data  if x+y == 2020][0]))
print("Day 1 problem 2: "+str([x*y*z for x in data for y in data for z in data if x+y+z == 2020][0]))
print("-----")
