from operator import xor
from functools import reduce

def r(v, p, e):
    # could use slices, but they're fiddly.
    for (i,j) in zip(range(p,e),range(e-1,p,-1)):
        if i >= j: return e
        v[i&255],v[j&255] = v[j&255],v[i&255]
    return e

def round(v, n, l):
    reduce(lambda p, i: i + r(v, p, p+l[i % len(l)]), range(n*len(l)), 0)

import gmpy

count = 0
grid = [0]*128
for i in range(128):
    # oundnydw
    #k = "flqrgnkx-{}".format(i)
    k = "oundnydw-{}".format(i)
    v = range(256)
    round(v, 64, [ord(c) for c in k] + [17, 31, 73, 47, 23])
    h = [reduce(xor, v[x:x+16], 0) for x in range(0,256,16)]
    count += sum(gmpy.popcount(x) for x in h)
    grid[i] = reduce(lambda acc,x: (acc<<8) | x, h, 0)
print(count)

class DisjointSet:
    def __init__(self, n):
        self.ids = [i for i in range(0,n)]
        self.size = [1] * n

    def find(self, p):
        while p != self.ids[p]:
            self.ids[p] = self.ids[self.ids[p]]
            p = self.ids[p]
        return p

    def unite(self, a, b):
        a,b = self.find(a), self.find(b)
        if self.size[a] >= self.size[b]:
            b,a = a,b
        self.ids[a] = b
        self.size[b] += self.size[a]

def lit_neighbors_of(grid, x, y):
    if x > 0 and (grid[y] & (1<<(x-1)) != 0):
        yield (x-1,y)
    if grid[y] & (1<<(x+1)) != 0:
        yield (x+1,y)
    if y > 0 and grid[y-1] & (1<<x) != 0:
        yield (x,y-1)
    if y+1 < len(grid) and grid[y+1] & (1<<x) != 0:
        yield (x,y+1)

comps = DisjointSet(128*128+1)
for y in range(128):
    row = grid[y]
    print('{:0128b}'.format(row))
    for x in range(128):
        if row & (1<<x) == 0: continue
        for (nx,ny) in lit_neighbors_of(grid, x, y):
            comps.unite(x*128+y, nx*128+ny)

s = set()
for y in range(128):
    row = grid[y]
    for x in range(128):
        if row & (1<<x) == 0: continue
        s.add(comps.find(x*128+y))
print(len(s))
