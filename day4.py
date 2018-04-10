with open('day4.in') as f: sum(1 for l in f if len(set(l.split())) == len(l.split()))
with open('day4.in') as f: sum(1 for l in f if len({''.join(sorted(w)) for w in l.split()}) == len(l.split()))
