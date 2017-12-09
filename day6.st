" -*- smalltalk -*- "
BlockClosure extend [doUntil:c [self value. c whileFalse: self]].
Set extend [addp: m [|r| r := self includes: m. self add: m. ^r]].
OrderedCollection extend [
  argmax [|i m|
    m := 0. i := 0.
    self keysAndValuesDo: [:k :v| (v > m) ifTrue: [i := k. m := v]]. ^i]
  incf: i [self at: i put: (1 + (self at: i))]
  swipe: i [|t| t := self at: i. self at: i put: 0. ^t]
  doIt [|seen count|
    seen := Set new. count := 0.
    [|i n|
      (seen addp: (self fold: [:x :y| (x bitShift: 8) bitOr: y])) ifTrue: [^count].
      count := count + 1. i := self argmax.
      (self swipe: i) timesRepeat: [self incf: (i := i \\ self size + 1)].
    ] repeat]
].

|in|
in := (((File name:'day6.in') readStream) nextLine) substrings collect: [:s|s asNumber].
Transcript show: 'part 1: '; show: in doIt asString; cr.
Transcript show: 'part 2: '; show: in doIt asString; cr.
