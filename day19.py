with open('day19.in') as f:
    grid = [line for line in f]
width = len(grid[0])
height = len(grid)
alphas = set('ABCDEFGHIJKLMNOPQRSTUVWXYZ')

def at(p):
    x,y = p.real, p.imag
    if x < 0 or x >= width or y < 0 or y >= height:
        return ' '
    return grid[int(y)][int(x)]

def expected(d):
    if d.real != 0: return alphas | set('-')
    if d.imag != 0: return alphas | set('|')
    assert False, d

def walk_map(grid, p, d):
    c = at(p)
    while c != ' ':
        p += d
        c = at(p)
        if c == '+':
            d *= complex(0,1)
            if at(p+d) in expected(d):
                pass
            elif at(p-d) in expected(d):
                d = -d
            else:
                assert False, "{} {}".format(at(p+d), expected(d))
        elif c == ' ':
            break
        yield (c, p, d)

seen = []
steps = 1
for (c,p,d) in walk_map(grid, grid[0].index('|'), complex(0,1)):
    steps += 1
    if c in alphas:
        seen.append(c)
    else:
        assert c in set('|-+'), c
print(''.join(seen))
print(steps)
