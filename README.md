
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

