with open('day11.in') as f:
    path = f.readline().strip().split(',')
p, m = (0,0), 0
for step in path:
    (x,y) = p
    d, par = ((x+1)/2)+y, x%2
    m = max(m, d)
    p = {'n': (x,y-1), 'ne': (x+1,y+par-1), 'nw': (x-1,y+par-1),
         'sw': (x-1,y+par), 'se':(x+1,y+par), 's': (x,y+1)}[step]
print(p, (abs(p[0])+1)/2 + abs(p[1]), m)
