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

peeps = {}
with open('day12.in') as f:
    for l in f:
        ls = l.split()
        peeps[int(ls[0])] = [int(s[:-1] if s[-1] == ',' else s) for s in ls[2:]]
d = DisjointSet(1+max(peeps.keys()))
for (k,v) in peeps.items():
    for o in v:
        d.unite(k, o)
print(sum(1 for i in peeps.keys() if d.find(i) == d.find(0)))
print(len({d.find(i) for i in peeps.keys()}))
