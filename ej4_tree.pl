vacio([]).
raiz([_,N,_], N).
hi([HI,_,_], HI).
hd([_,_,HD], HD).
hazarbol(R, HI, HD, [HI,R,HD]).

printRootToLeafPath(Tree) :-
  not(vacio(Tree)),
  rootToLeaf(Tree, []).

rootToLeaf(Tree, Path) :-
  raiz(Tree, Raiz),
  append([Raiz], Path, NewPath),
  hi(Tree, Hi),
  hd(Tree, Hd),
  not(vacio(Hi)),
  not(vacio(Hd)),
  rootToLeaf(Hi, NewPath),
  rootToLeaf(Hd, NewPath).

rootToLeaf(Tree, Path) :- %Ambas ramas vacías
  raiz(Tree, Raiz),
  append([Raiz], Path, NewPath),
  hi(Tree, Hi),
  hd(Tree, Hd),
  vacio(Hi),
  vacio(Hd),
  reverse(NewPath, PathR),
  printList(PathR).

rootToLeaf(Tree, Path) :- %Rama izquierda vacía
  raiz(Tree, Raiz),
  append([Raiz], Path, NewPath),
  hi(Tree, Hi),
  hd(Tree, Hd),
  vacio(Hi),
  not(vacio(Hd)),
  rootToLeaf(Hd, NewPath).

rootToLeaf(Tree, Path) :- %Rama derecha vacía
  raiz(Tree, Raiz),
  append([Raiz], Path, NewPath),
  hi(Tree, Hi),
  hd(Tree, Hd),
  not(vacio(Hi)),
  vacio(Hd),
  rootToLeaf(Hi, NewPath).

rootToLeaf(Tree, Path) :-
  reverse(Path, PathR),
  printList(PathR).

printList([]) :-
  write("END"), nl.

printList([X|Y]) :-
  write(X), write(" -> "),
  printList(Y).

without_last([X|Xs], [X|WithoutLast]) :-
  without_last(Xs, WithoutLast).
