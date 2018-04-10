# hash of connections from -> to,(from,to) in both directions
# set of visited, key is original (from,to) tuple which is unique

from collections import defaultdict
connect = defaultdict(list)

def dfs_p1(this, strength, visited):
    vs = [dfs_p1(to, this+to+strength, visited | set([c])) for (to,c) in connect[this] if c not in visited]
    vs.append(strength)
    return max(vs)

def dfs_p2(this, length, strength, visited):
    vs = [dfs_p2(to, length+1, this+to+strength, visited | set([c])) for (to,c) in connect[this] if c not in visited]
    vs.append((length,strength))
    return max(vs)


with open('day24.in') as f:
    for (id,line) in enumerate(f):
        (fro,to) = [int(x) for x in line.strip().split('/')]
        connect[fro].append((to,id))
        connect[to].append((fro,id))

#print(dfs_p1(0, 0, set()))
print(dfs_p2(0, 0, 0, set()))
