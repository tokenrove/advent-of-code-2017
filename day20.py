from collections import namedtuple, Counter

Particle = namedtuple('Particle', 'i p v a'.split())

with open('day20.in') as f: points = [Particle(i, *[tuple(int(y) for y in x[3:-1].split(',')) for x in line.strip().split(', ')]) for (i,line) in enumerate(f)]

def md(p): return sum(abs(i) for i in p)

by_acc = sorted(sorted(sorted(points, key=lambda x: md(x.p)),
                       key=lambda x: md(x.v)),
                key=lambda x: md(x.a))
print("by acc",by_acc[0:10])

def step(p):
    v = add(p.v, p.a)
    return Particle(p.i, add(p.p, v), v, p.a)

def add(a, b):
    return (a[0]+b[0], a[1]+b[1], a[2]+b[2])

def simulate(points):
    return [step(p) for p in points]

points = points
for i in range(10000):
    # should actually check which particles are colinear
    # except they're moving in curves.  maybe intersection of lines at each step?
    collide = Counter(p.p for p in points)
    points = [p for p in points if collide[p.p] == 1]
    points = simulate(points)
by_pos = sorted(points, key=lambda x: md(x.p))
print("by pos", by_pos[0:10])
print(len(points))
