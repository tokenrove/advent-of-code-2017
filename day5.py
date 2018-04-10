# part 1
with open("day5.in") as f: jumps = [int(i) for i in f]
i,n = 0,0
while 0 <= i < len(jumps): j = i+jumps[i]; jumps[i] += 1; n += 1; i = j
# part 2
with open("day5.in") as f: jumps = [int(i) for i in f]
i,n = 0,0
while 0 <= i < len(jumps): j = i+jumps[i]; jumps[i] = jumps[i] + (1 if jumps[i] < 3 else -1); n += 1; i = j
