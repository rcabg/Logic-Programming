%BV = [["Quijote","Cervantes",1985],["Demian","Hesse",1978],["Siddharta","Hesse",1993],["Odisea","Homero",1967],["Algebra Universal","Cohn",1967],["Algebra Universal","Shankapanavar", 1988]]

autor([_, Autor, _], Autor).
obra([Obra, _, _], Obra).
fecha([_, _, Fecha], Fecha).

buscaautor(_, [], []).
buscaautor(Cdn, _, []) :-
  string_length(Cdn, 0).

buscaautor(Cdn, Bb1, L) :-
  buscaIndexAutor(Cdn, Bb1, L, 0).

buscaIndexAutor(Cdn, [X], L, Index) :-
  autor(X, Autor),
  Cdn = Autor,
  append([Index], [], L).

buscaIndexAutor(Cdn, [X], [], Index) :-
  autor(X, Autor),
  not(Cdn = Autor),
  length(L, 0).

buscaIndexAutor(Cdn, [X], L, Index) :-
  autor(X, Autor),
  not(Cdn = Autor).

buscaIndexAutor(Cdn, [X|Rest], L, Index) :-
  autor(X, Autor),
  not(Cdn = Autor),
  NewIndex is Index + 1,
  buscaIndexAutor(Cdn, Rest, L, NewIndex).

buscaIndexAutor(Cdn, [X|Rest], L, Index) :-
  autor(X, Autor),
  Cdn = Autor,
  NewIndex is Index + 1,
  buscaIndexAutor(Cdn, Rest, NewList, NewIndex),
  length(NewList, 0),
  append([Index], NewList, L).

buscaIndexAutor(Cdn, [X|Rest], L, Index) :-
  autor(X, Autor),
  Cdn = Autor,
  NewIndex is Index + 1,
  buscaIndexAutor(Cdn, Rest, NewList, NewIndex),
  append([Index], NewList, L).
