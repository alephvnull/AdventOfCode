# Day 15

from typing import List
import collections

def part1(numbers: List[int], last_turn: int = 2020) -> int:
    turns = collections.defaultdict(lambda: collections.deque(maxlen=2))
    for i, n in enumerate(numbers):
        turns[n].append(i + 1)

    n = numbers[-1]
    for turn in range(len(numbers) + 1, last_turn + 1):
        try:
            n = turns[n][-1] - turns[n][-2]
        except IndexError:
            n = 0
        turns[n].append(turn)
    return n


def part2(numbers: List[int]) -> int:
    return part1(numbers, last_turn=30000000)

numbers = [15,5,1,4,7,0]

print("-----")
print("Day 15 problem 1: " + str(part1(numbers)))
print("Day 15 problem 2: " + str(part2(numbers))) 
print("-----")