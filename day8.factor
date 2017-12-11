USING: kernel io io.files io.encodings.ascii splitting math assocs
    combinators sequences parser math.order prettyprint ;
IN: day8

: >cond ( a b s -- ? )
    { { "!=" [ = not ] } { "==" [ = ] } { ">" [ > ] } { ">=" [ >= ] } { "<" [ < ] } { "<=" [ <= ] } } case ;
: maybe-neg ( n o -- n ) { { "inc" [ ] } { "dec" [ neg ] } } case ;
: extract ( s -- a c b ) [ first ] [ third parse-number ] [ second ] tri ;
: apply-op ( o m -- v ) [ extract maybe-neg swap ] dip [ at+ ] 2keep at ;
: handle-line ( map line -- map v )
    " " { "if" } [ split ] bi@ first2 swap
    [ extract [ over at 0 or ] 2dip >cond ] dip
    swap [ over apply-op ] [ drop 0 ] if
    ;

: max-val ( dict -- max ) values 0 [ max ] reduce ;
: main ( -- )
    H{ } clone 0
    "day8.in" ascii <file-reader> [
        [ swap [ handle-line ] dip max ] each-line
    ] with-input-stream
    [ max-val "part 1: " write . ] [ "part 2: " write . ] bi*
    ;

MAIN: main
