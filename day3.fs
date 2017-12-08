module Day3
type C = System.Numerics.Complex

let position_of lim =
    let rec f i n p d =
        if n >= lim then p else
            let m = min (i/2+1) (lim-n) in
            f (1+i) (n+m) (p + d*C(float m,0.)) (d * C.ImaginaryOne)
    in f 0 1 C.Zero C.One

let manhattan_distance (p:C) = abs p.Real + abs p.Imaginary

let part_1 n = position_of n |> manhattan_distance

let steps = Seq.initInfinite (fun i -> i/2+1)
let directions = Seq.initInfinite (fun _ -> [C.One; C(0.,1.); C(-1.,0.); C(0.,-1.)]) |> Seq.concat
let neighbors = seq { for i in -1. .. 1. do for j in -1. .. 1. -> C(i,j) } |> Seq.filter ((<>)C.Zero)

// We never need to look back more than one "wrap", so we could
// actually keep only the last four turns, but we just keep everything
// out of sloth.
let adjacency_values () =
    let v = System.Collections.Generic.Dictionary<C,int>() in
    v.[C.Zero] <- 1;
    let mutable p = C.One in
    let inner s d = seq {
        for _ in 1..s do
            let lk a = match v.TryGetValue (a+p) with (true,i) -> i | _ -> 0 in
            v.[p] <- Seq.map lk neighbors |> Seq.sum;
            yield v.[p]; p <- p + d
        } in
    seq { for (s,d) in Seq.tail (Seq.zip steps directions) do yield! inner s d }

let part_2 n = adjacency_values () |> Seq.skipWhile ((>=)n) |> Seq.head

[<EntryPoint>]
let main [|v|] = let v = int v in
    printfn "part 1: %g\npart 2: %d\n" (part_1 v) (part_2 v); 0
