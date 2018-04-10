from collections import defaultdict

def steps():
    i = 1
    while True:
        yield (i+1)//2
        i += 1

def directions():
    d = 1
    while True:
        yield d
        d *= complex(0,1)

def position_of(lim):
    n,p = 1,0
    for (step,d) in zip(steps(),directions()):
        if n >= lim: return p
        m = min(lim-n, step)
        p += m*d
        n += m

def manhattan_distance(p):
    return abs(p.real) + abs(p.imag)

def neighbor_matrix(n):
    def neighbors_of(p):
        for n in [complex(x,y) for (x,y) in [(-1,-1),(-1,0),(-1,1),(0,-1),(0,1),(1,-1),(1,0),(1,1)]]:
            yield v.get(p+n, 0)
    p = 0
    v = {}
    si,di = steps(),directions()
    v[p] = 1
    for (step,d) in zip(steps(),directions()):
        for s in range(step):
            p += d
            v[p] = sum(neighbors_of(p))
            if v[p] > n: return v[p]

def part_1(n):
    print(manhattan_distance(position_of(n)))

def part_2(n):
    print(neighbor_matrix(n))

part_1(289326)
part_2(289326)
