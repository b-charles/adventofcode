
input(F, Lines) :-
  open(F, read, Stream),
  readInput(Stream, Lines),
  close(Stream).

readInput(Stream, []) :- at_end_of_stream(Stream).
readInput(Stream, [H|T]) :-
  \+ at_end_of_stream(Stream),
  read_string(Stream, "\n", "", _, H),
  readInput(Stream, T).

%%

bagsAcc([], Current, Acc, All) :- append([Current], Acc, All).
bagsAcc([""|T], Current, Acc, All) :- bagsAcc(T, 0, [Current|Acc], All).
bagsAcc([H|T], Current, Acc, All) :-
  \+ string_length(H, 0),
  number_codes(V, H), B is V + Current,
  bagsAcc(T, B, Acc, All).

bags(Lines, SortedBags) :- bagsAcc(Lines, 0, [], Bags), sort(Bags, Cres), reverse(Cres, SortedBags).

solve1(R) :- input('input.txt', L), bags(L, Bags), [R|_] = Bags.

%%

solve2(R) :- input('input.txt', L), bags(L, Bags), [R1, R2, R3|_] = Bags, R is R1+R2+R3.

