import gmpy
import operator
from functools import reduce

initial = [2,4,7]
w = 3
by2,by3 = {},{}

def to_i(s):
    return reduce(operator.ior, (1<<i for (i,c) in enumerate(s) if c == '#'), 0)

def setp(grid, x, y):
    return 0 if 0 == grid[y]&(1<<x) else 1

def rotations_of(k):
    yield k
    for _ in range(3):
        nk = [0] * len(k)
        for y in range(len(k)):
            for x in range(len(k)):
                nk[x] |= setp(k, x, y) << (len(k)-1-y)
        yield tuple(nk)
        k = nk

def variants_of(k):
    yield from rotations_of(k)
    yield from rotations_of(tuple(reversed(k)))

def str_of(k):
    s = []
    for y in range(len(k)):
        for x in range(len(k)):
            s.append('.' if 0 == setp(k, x, y) else '#')
        s.append('\n')
    return ''.join(s)

with open('day21.in') as f:
    for line in f:
        fro,to = [x.split('/') for x in line.strip().split(' => ')]
        width = len(fro)
        k = tuple(to_i(r) for r in fro)
        v = tuple(to_i(r) for r in to)
        if width == 2:
            for r in variants_of(k):
                by2[r] = v
        else:
            assert width == 3
            for r in variants_of(k):
                by3[r] = v

def block_at(grid, sz, ox, oy):
    b = [0]*sz
    for y in range(0, sz):
        for x in range(0, sz):
            b[y] |= setp(grid, x+ox, y+oy)<<x
    return tuple(b)

def shift_and_or_into(dst, src, ox, oy):
    for y in range(len(src)):
        dst[oy+y] |= src[y] << ox

def step(grid):
    if len(grid) % 2 == 0:
        new_grid = [0]*(3*len(grid)//2)
        for y in range(0, len(grid), 2):
            for x in range(0, len(grid), 2):
                b = block_at(grid, 2, x, y)
                assert b in by2
                shift_and_or_into(new_grid, by2[b], 3*x//2, 3*y//2)
    else:
        assert len(grid) % 3 == 0
        new_grid = [0]*(4*len(grid)//3)
        for y in range(0, len(grid), 3):
            for x in range(0, len(grid), 3):
                b = block_at(grid, 3, x, y)
                assert b in by3
                shift_and_or_into(new_grid, by3[b], 4*x//3, 4*y//3)
    return new_grid

grid = initial
for i in range(5):
    grid = step(grid)
print(sum(gmpy.popcount(r) for r in grid))
for i in range(18-5):
    grid = step(grid)
print(sum(gmpy.popcount(r) for r in grid))
