USING: kernel io io.files io.encodings.ascii splitting math assocs
    combinators sequences parser math.order prettyprint ;
IN: day8

: >cond ( a b s -- ? )
    { { "!=" [ = not ] } { "==" [ = ] } { ">" [ > ] } { ">=" [ >= ] } { "<" [ < ] } { "<=" [ <= ] } } case ;
: maybe-neg ( n o -- n ) { { "inc" [ ] } { "dec" [ neg ] } } case ;
: extract ( s -- a c b ) [ first ] [ dup third parse-number swap second ] bi ;
: apply-op ( o m -- v ) [ extract maybe-neg swap ] dip [ at+ ] 2keep at ;

: handle-line ( map line -- map v )
    " " split { "if" } split first2 swap
    [ extract [ over at 0 or ] 2dip >cond ] dip
    swap [ over apply-op ] [ drop 0 ] if
    ;

: main ( -- )
    H{ } clone 0
    "day8.in" ascii <file-reader> [
        [ swap [ handle-line ] dip max ] each-line
    ] with-input-stream
    [ values 0 [ max ] reduce "part 1: " write . ] dip
    "part 2: " write .
    ;

MAIN: main
