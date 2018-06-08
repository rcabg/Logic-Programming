vacio([]).
raiz([_,N,_], N).
hi([HI,_,_], HI).
hd([_,_,HD], HD).
hazarbol(R, HI, HD, [HI,R,HD]).

nivel([], _, 0).
nivel(Tree, Node, D) :-
  length(Tree, 3),
  raiz(Tree, R),
  Node =:= R,
  D is 1.

nivel(Tree, Node, D) :-
  get_nivel(Tree, Node, D, 1).

get_nivel(Tree, Node, D, DT) :-
  ND is DT + 1,
  hi(Tree, Hi), hd(Tree, Hd),
  raiz(Hi, RHi), raiz(Hd, RHd),
  not(RHi =:= Node),not(RHd =:= Node),
  get_nivel(Hi, Node, D, ND),
  get_nivel(Hd, Node, D, ND).

get_nivel(Tree, Node, D, DT) :-
  D is DT + 1.

list_nivel([], _, []).
list_nivel([_, X, _], 1, [X]).
list_nivel(Tree, D, Lista) :-
  raiz(Tree, RAIZ),
  D > 1, DAux is D - 1,
  hi(Tree, Hi), hd(Tree, Hd),
  list_nivel(Hi, DAux, ListaIzq), list_nivel(Hd, DAux, ListaDer),
  append(ListaIzq, ListaDer, Lista).

list_nivel(Tree, D, Lista) :-
  D > 1, DAux is D - 1,
  hi(Tree, Hi),
  list_nivel(Hi, DAux, ListaIzq),
  append(ListaIzq, [], Lista).

list_nivel(Tree, D, Lista) :-
  D > 1, DAux is D - 1,
  hd(Tree, Hd),
  list_nivel(Hd, DAux, ListaDer),
  append(ListaDer, [], Lista).

solveEx3(Tree, Node, Result) :-
  nivel(Tree, Node, D),
  list_nivel(Tree, D, List),
  sort(List, Sorted),
  nextto(Node, Result, Sorted).

solveEx3(Tree, Node, []).
