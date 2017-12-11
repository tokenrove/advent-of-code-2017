# after discussion with robert about restructuring this around
# generators; though I didn't end up using generators.

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

with open('day10.in') as f: input = f.readline().strip()

v = range(256)
round(v, 1, [int(i) for i in input.split(',')])
print(v[0]*v[1])

v = range(256)
round(v, 64, [ord(c) for c in input] + [17, 31, 73, 47, 23])
h = ''.join('{:02x}'.format(reduce(xor, v[i:i+16])) for i in range(0,256,16))
print(h)
