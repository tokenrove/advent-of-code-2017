lines = readlines.map {|s| s.split.map(&:to_i)}
puts lines.map {|is| is.max - is.min}.inject(:+)
puts lines.map {|is|
  p = is.inject(:*)
  is.select {|i| 0 == p % (i*i)}.
    map {|c| q = is.find {|i| i != c && 0 == i%c}; [c,q] if q}.
    compact.first.sort.reverse.inject(:/)
}.inject(:+)
