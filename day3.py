from collections import defaultdict

def steps():
    i = 1
    while True:
        yield i
        yield i
        i += 1

def directions():
    while True:
        yield (1,0)
        yield (0,1)
        yield (-1,0)
        yield (0,-1)

def position_of(lim):
    n,p = 1,(0,0)
    si,di = steps(),directions()
    while n < lim:
        step,d = next(si),next(di)
        m = step if n+step < lim else lim-n
        off = (m*d[0], m*d[1])
        p = (p[0]+off[0], p[1]+off[1])
        n += m
    return p

def manhattan_distance(p):
    return abs(p[0]) + abs(p[1])

def neighbor_matrix(n):
    def neighbors_of(p):
        for n in [(-1,-1),(-1,0),(-1,1),(0,-1),(0,1),(1,-1),(1,0),(1,1)]:
            yield v.get((p[0]+n[0],p[1]+n[1]), 0)
    p = (0,0)
    v = {}
    si,di = steps(),directions()
    v[p] = 1
    while True:
        d = next(di)
        for s in range(next(si)):
            p = (d[0]+p[0], d[1]+p[1])
            v[p] = sum(neighbors_of(p))
            if v[p] > n: return v[p]

def part_1(n):
    print(manhattan_distance(position_of(n)))

def part_2(n):
    print(neighbor_matrix(n))
