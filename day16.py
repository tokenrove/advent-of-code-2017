
def spin(v, n):
    return v[-n:] + v[:-n]

def exchange(v, a, b):
    v = list(v)
    v[a],v[b] = v[b],v[a]
    return ''.join(v)

def partner(v, a, b):
    v = list(v)
    a,b = v.index(a), v.index(b)
    v[a],v[b] = v[b],v[a]
    return ''.join(v)

p = 'abcdefghijklmnop'
#p = 'abcde'
with open('day16.in') as f:
    insns = f.readline().strip().split(',')

def dance(p, insns):
    for insn in insns:
        if insn[0] == 's':
            p = spin(p, int(insn[1:]))
        elif insn[0] == 'x':
            a,b = tuple(int(x) for x in insn[1:].split('/'))
            p = exchange(p, a, b)
        elif insn[0] == 'p':
            p = partner(p, insn[1], insn[3])
        else:
            assert False
    return p

def to_perm(p, o):
    return [o.index(c) for c in list(p)]

def apply(p, perm):
    return [p[i] for i in perm]

def from_perm(p, o):
    return ''.join(o[i] for i in p)

#p = 'abcde'
#insns = ['s1','x3/4','pe/b']
o = p
perms = []
while True:
    n = p
    p = dance(p, insns)
    perm = to_perm(p, n)
    if perm in perms: break
    perms.append(perm)

import itertools
def do_it(n):
    p = to_perm(o, o)
    cycle = by_cycle()
    for i in range(n//len(perms)):
        p = apply(p, cycle)
    for (i, perm) in zip(range(n%len(perms)), perms):
        p = apply(p, perm)
    print(from_perm(p,o))

def by_cycle():
    p = to_perm(o, o)
    for perm in perms:
        p = apply(p, perm)
    return p

do_it(1)
do_it(1000000000)
