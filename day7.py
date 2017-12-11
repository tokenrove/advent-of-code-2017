from collections import defaultdict

parent,node,child = {},{},defaultdict(list)

def process(line):
    node[line[0]] = int(line[1][1:-1])
    for n in line[3:]:
        if n[-1] == ',': n = n[:-1]
        assert n not in parent
        parent[n] = line[0]
        child[line[0]].append(n)

with open('day7.in') as f:
    for line in f: process(line.split())

n = list(parent.keys())[0]
while n in parent: n = parent[n]
print(n)

def compute(n):
    return node[n] + sum(compute(c) for c in child[n])

def weights_of(root):
    w = node[root]
    weights = []
    for c in child[root]:
        weights.append((c, node[c], compute(c)))
    return weights

def find_unbalanced(n):
    weights = weights_of(n)
    if len(weights) == 0: return None
    base = weights[0][2]
    for w in weights:
        (node,weight,total) = w
        if total != base:
            x = find_unbalanced(node)
            if x is None: return (w,weight-(total-base))
            return x
    return None

print(find_unbalanced(n))
