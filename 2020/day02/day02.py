#!/usr/bin/env python

from collections import Counter

def get_data(filepath):
    with open(filepath) as f:
        return [line for line in f]

def valid(line):
    ln = line.replace('\n', '').replace('-', ' ').replace(':', '').split(" ")
    return (int(ln[0]) <= (Counter(ln[3]))[ln[2]] <= int(ln[1]))

def valid2(line):
    ln = line.replace('\n', '').replace('-', ' ').replace(':', '').split(" ")
    return ((((ln[3])[int(ln[0]) - 1] == ln[2]) and ((ln[3])[int(ln[1]) - 1] != ln[2])) or (((ln[3])[int(ln[1]) - 1] == ln[2]) and ((ln[3])[int(ln[0]) - 1] != ln[2])))
  
data = get_data("2020/day02/input.txt")

print("-----")
print("Day 2 problem 1: "+str(sum(list(map(valid, data)))))
print("Day 2 problem 2: "+str(sum(list(map(valid2, data)))))
print("-----")