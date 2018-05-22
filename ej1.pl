
missing([], []).
missing([X], Result) :-
  append([], [X], Result).

missing([X, Y|Rest], Result) :-
  checkbetween(X, Y, Between),
  missing([Y|Rest], ResultTemp),
  append(Between, ResultTemp, Result).

checkbetween(X, Y, List) :-
  X + 1 =:= Y,
  append([], [X], List).

checkbetween(X, Y, List) :-
  X + 1 < Y,
  Z is Y - 1,
  setof(B, between(X, Z, B), List).
