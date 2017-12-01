let day1 (r:i32) (s:[]i32) =
  let d = map (\x -> x-48) s in
  reduce (+) 0 (map (\x y -> if x == y then x else 0) d (rotate r d))

let part1 (s:[]i32) = day1 1 s
let part2 (s:[]i32) = day1 ((length s)/2) s

let main (s:[]i32) = part2 s