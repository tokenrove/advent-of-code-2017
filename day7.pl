%% -*- prolog -*-

:- use_module(library(dcg/basics)).

lines --> [].
lines --> line, lines.
line --> string(Ps), " (", { atom_codes(P, Ps) }, integer(V), ")", { asserta(value(P, V)) },
         ("\n" ; " -> ", children(Cs), { forall(member(C, Cs), asserta(parent(P,C))) }).
children([C]) --> child(C), "\n".
children([C|Cs]) --> child(C), ", ", children(Cs).
child(C) --> string_without(",\n", Cs), { atom_codes(C, Cs) }.

part_1(N) :- value(N, _), not(parent(_, N)).

kids_and_weights(N, Cs, Ws) :- findall(C, parent(N, C), Cs), maplist(weight, Cs, Ws).

weight(N, W) :- kids_and_weights(N, _, Ws), sumlist(Ws, Wc), value(N, Wu), W is Wu + Wc.

outsider(L, Crowd, Outsider) :- outsider(L, _, _, Crowd, Outsider), !.
outsider([], A, B, C, O) :- A \= B, C = A, O = B.
outsider([A|[B|Rest]], A, B, C, O) :- outsider(Rest, A, B, C, O).
outsider([A|Rest], A, B, C, O) :- outsider(Rest, A, B, C, O).
outsider([B|Rest], A, B, C, O) :- outsider(Rest, B, A, C, O).

unbalanced(N, U) :-
    kids_and_weights(N, Cs, Ws),
    outsider(Ws, _, O) -> nth1(I, Ws, O), nth1(I, Cs, U1), unbalanced(U1, U); N = U.

should_be(N, DesiredWeight) :-
    parent(P, N), kids_and_weights(P, _, Ws), outsider(Ws, C, O), value(N, V),
    DesiredWeight is V-(O-C).

main :-
    once(phrase_from_file(lines, "day7.in")),
    part_1(Root),
    unbalanced(Root, Unbalanced), should_be(Unbalanced, DesiredWeight),
    format('part 1: ~w~npart 2: ~w should be ~w~n', [Root, Unbalanced, DesiredWeight]).
