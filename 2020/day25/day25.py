# Day 25


def loop_find(x, num, rng):
    for i in range(rng):
        x = (x * 7) % 20201227
        if x == num:
            return(i+2)
            
def break_num(x, rng):
    n = x
    for i in range(rng -1):
        x = (x * n) % 20201227
    return(x)

impt1 = 2069194
impt2 = 16426071

print(break_num(impt1, loop_find(7, impt2, 100000000)))
print(break_num(impt2, loop_find(7, impt1, 100000000)))
