
My goal, like last year, is to do each day in a different language.
We'll see what happens.  I might go back and do multiple solutions for
one day if I regret not doing something in APL or Lisp.

I should add the disclaimer that many of these solutions are not
idiomatic in the languages chosen.  Sometimes because I'm unaware of
the conventions, and sometimes because I'm actively defying them.

[Previously.](https://github.com/tokenrove/advent-of-code-2016)

- [1](day1.fut): [Futhark](http://futhark-lang.org)
  - `s ← "123123" ⋄ +/⍎¨"0",s/⍨s=s⌽⍨2÷⍨⍴s` in APL
- [2](day2.rb): [Ruby](https://www.ruby-lang.org/)
  - `+/ ((#~(=>.))@(#~(1&~:))@,@(%/]))"1 is` in J
- [3](day3.fs): [F#](http://fsharp.org/)
  - Also [in CL](day3.lisp).  Wanted a language with both generators
    and complex numbers for this; surprisingly hard ask.
- [4](day4.scm): [Guile Scheme](https://www.gnu.org/s/guile)
  - `sum(1 for l in f if len({''.join(sorted(w)) for w in l.split()}) == len(l.split()))`
- [5](day5.s): bootable x86 asm using `BOUND` instruction
  - `for (size_t i = 0; i < N; ++n) i += j[i] <3 ? j[i]++ : j[i]--;`
- [6](day6.st): [GNU Smalltalk](http://smalltalk.gnu.org/)
- [7](day7.pl): [SWI Prolog](http://www.swi-prolog.org/)
- [8](day8.factor): [Factor](http://factorcode.org/)
- [9](day9.icn): [Icon](https://www2.cs.arizona.edu/icon/)

Some of the discussion around this lead to demoing some of these as
(excessively-unPythonic) Python list comprehensions:

```python
with open('day1.in') as f: ds = [int(c) for c in f.readline().strip()]
r = 1 # or len(ds)/2 for part 2
sum(a for (a,b) in zip(ds, ds[r:] + [ds[:r]]) if a == b)
```

```python
with open('day2.in') as f: ls = [[int(i) for i in line.strip().split()] for line in f]
sum(max(row)-min(row) for row in ls)
sum([q//d for q in row for d in row if q != d and 0 == q % d][0] for row in ls)
```

``` python
with open('day4.in') as f: sum(1 for l in f if len(set(l.split())) == len(l.split()))
with open('day4.in') as f: sum(1 for l in f if len({''.join(sorted(w)) for w in l.split()}) == len(l.split()))
```

``` python
>>> with open("day5.in") as f: jumps = [int(i) for i in f]
>>> i,n = 0,0
>>> while 0 <= i < len(jumps): j = i+jumps[i]; jumps[i] = jumps[i] + (1 if jumps[i] < 3 else -1); n += 1; i = j
>>> print(n)
```

