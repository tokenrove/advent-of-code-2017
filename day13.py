from itertools import dropwhile
from math import gcd
from functools import reduce

with open('day13.in') as f: v = dict(tuple(int(r) for r in l.split(': ')) for l in f)
print(sum(k*v for (k,v) in v.items() if k%(v+v-2) == 0))
lcm = reduce(lambda a,b: a*b//gcd(a,b), (x+x-2 for x in v.values()), 1)
print(next(dropwhile(lambda d: any((j+d)%(v+v-2) == 0 for (j,v) in v.items()), range(lcm))))
