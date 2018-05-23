
checkNumber(A, List, Floor, Ceiling) :-
  member(A, List),
  Floor is A,
  Ceiling is Floor.

checkNumber(A, List, Floor, Ceiling) :-
  not(member(A, List)),
  searchFloor(A, List, Floor),
  searchCeiling(A, List, Ceiling).

searchFloor(B, List, Result) :-
  last(List, Last),
  B >= Last,
  Result is -1.

searchFloor(B, _, Result) :-
  B =:= -1,
  Result is B.

searchFloor(B, List, Result) :-
  member(B, List),
  Result is B.

searchFloor(B, List, Result) :-
  C is B - 1,
  searchFloor(C, List, Result).

searchCeiling(B, List, Result) :-
  last(List, Last),
  B >= Last,
  Result is Last.

searchCeiling(B, List, Result) :-
  member(B, List),
  Result is B.

searchCeiling(B, List, Result) :-
  C is B + 1,
  searchCeiling(C, List, Result).
