
class Point(complex):
    x = property(lambda p: p.real)
    y = property(lambda p: p.imag)

infected = set()
w,h = 0,0
with open('day22.in') as f:
    for (y,line) in enumerate(f):
        for (x,c) in enumerate(line.strip()):
            if c == '#':
                infected.add(Point(x,y))
            if x > w: w = x
        if y > h: h = y

WEAKENED,INFECTED,FLAGGED = 1,2,3
state = {p:INFECTED for p in infected}
center = Point(w//2,h//2)

p = center
d = Point(0,-1)

def pt1_step():
    global p,d,infected
    dirty = p in infected
    d *= Point(0,1) if dirty else Point(0,-1)
    if dirty:
        infected.remove(p)
    else:
        infected.add(p)
    p += d
    return 0 if dirty else 1

print(sum(pt1_step() for _ in range(10000)))

p = center
d = Point(0,-1)

def pt2_step():
    global p,d,state
    score = 0
    if p not in state:
        d *= Point(0,-1)
        state[p] = WEAKENED
    elif state[p] == INFECTED:
        d *= Point(0,1)
        state[p] = FLAGGED
    elif state[p] == FLAGGED:
        d = -d
        del(state[p])
    else:
        assert state[p] == WEAKENED
        state[p] = INFECTED
        score = 1
    p += d
    return score

print(sum(pt2_step() for _ in range(10000000)))
