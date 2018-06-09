%BV = [["Quijote","Cervantes",1985],["Demian","Hesse",1978],["Siddharta","Hesse",1993],["Odisea","Homero",1967],["Algebra Universal","Cohn",1967],["Algebra Universal","Shankapanavar", 1988]]

autor([_, Autor, _], Autor).
obra([Obra, _, _], Obra).
fecha([_, _, Fecha], Fecha).

%%% Predicado 1: buscaautor
buscaautor(_, [], []).
buscaautor(Cdn, _, []) :-
  string_length(Cdn, 0).

buscaautor(Cdn, Bb1, L) :-
  buscaIndexAutor(Cdn, Bbl, L, 0).

buscaIndexAutor(Cdn, [X], L, Index) :-
  autor(X, Autor),
  Cdn = Autor,
  append([Index], [], L).

buscaIndexAutor(Cdn, [X], [], Index) :-
  autor(X, Autor),
  not(Cdn = Autor),
  length(L, 0).

buscaIndexAutor(Cdn, [X], [], Index) :-
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
  append([Index], NewList, L).

%%% Predicado 2:
dime(Bbl, Clv, Pos, Cdn) :-
  Clv = "titulo",
  checkPosOnList(Bbl, Pos),
  buscaTituloEnPos(Bbl, Pos, 0, Cdn).

dime(Bbl, Clv, Pos, Cdn) :-
  Clv = "autor",
  buscaAutorEnPos(Bbl, Pos, 0, Cdn).

dime(Bbl, Clv, Pos, Cdn) :-
  Clv = "fecha",
  buscaFechaEnPos(Bbl, Pos, 0, Cdn).

dime(_, _, Pos, _) :-
  write("Position "), write(Pos), write(" is out of range!"),nl,fail.

checkPosOnList(List, Pos) :-
  length(List, Elements),
  Pos < Elements.

buscaTituloEnPos([X|Rest], Pos, CurrentPos, Cdn) :-
  Pos > CurrentPos,
  NextPos is CurrentPos + 1,
  buscaTituloEnPos(Rest, Pos, NextPos, Cdn).

buscaTituloEnPos([X|Rest], _, _, Cdn) :-
  obra(X, Cdn).

buscaAutorEnPos([X|Rest], Pos, CurrentPos, Cdn) :-
  Pos > CurrentPos,
  NextPos is CurrentPos + 1,
  buscaAutorEnPos(Rest, Pos, NextPos, Cdn).

buscaAutorEnPos([X|Rest], _, _, Cdn) :-
  autor(X, Cdn).

buscaFechaEnPos([X|Rest], Pos, CurrentPos, Cdn) :-
  Pos > CurrentPos,
  NextPos is CurrentPos + 1,
  buscaFechaEnPos(Rest, Pos, NextPos, Cdn).

buscaFechaEnPos([X|Rest], _, _, Cdn) :-
  fecha(X, Cdn).

%%% Predicado 3:
cambia(Bbl1, Pos, Clv, Val, Bbl2) :-
  Clv = "titulo",
  checkPosOnList(Bbl1, Pos),
  cambiaTitulo(Bbl1, Pos, 0, Val, Bbl2).

cambia(Bbl1, Pos, Clv, Val, Bbl2) :-
  Clv = "autor",
  checkPosOnList(Bbl1, Pos),
  cambiaAutor(Bbl1, Pos, 0, Val, Bbl2).

cambia(Bbl1, Pos, Clv, Val, Bbl2) :-
  Clv = "fecha",
  checkPosOnList(Bbl1, Pos),
  cambiaFecha(Bbl1, Pos, 0, Val, Bbl2).

cambia(_, Pos, _, _, _) :-
  write("Position "), write(Pos), write(" is out of range!"),nl,fail.

cambiaTitulo([], _, _, _, []).
cambiaTitulo([X|Rest], Pos, CurrentPos, Val, Bbl2) :-
  not(Pos =:= CurrentPos),
  NextPos is CurrentPos + 1,
  cambiaTitulo(Rest, Pos, NextPos, Val, NewBbl),
  append([X], NewBbl, Bbl2).

cambiaTitulo([X|Rest], Pos, CurrentPos, Val, Bbl2) :-
  autor(X, Autor),
  fecha(X, Fecha),
  NextPos is CurrentPos + 1,
  cambiaTitulo(Rest, Pos, NextPos, Val, NewBbl),
  append([[Val, Autor, Fecha]], NewBbl, Bbl2).

cambiaAutor([], _, _, _, []).
cambiaAutor([X|Rest], Pos, CurrentPos, Val, Bbl2) :-
  not(Pos =:= CurrentPos),
  NextPos is CurrentPos + 1,
  cambiaAutor(Rest, Pos, NextPos, Val, NewBbl),
  append([X], NewBbl, Bbl2).

cambiaAutor([X|Rest], Pos, CurrentPos, Val, Bbl2) :-
  obra(X, Obra),
  fecha(X, Fecha),
  NextPos is CurrentPos + 1,
  cambiaAutor(Rest, Pos, NextPos, Val, NewBbl),
  append([[Obra, Val, Fecha]], NewBbl, Bbl2).

cambiaFecha([], _, _, _, []).
cambiaFecha([X|Rest], Pos, CurrentPos, Val, Bbl2) :-
  not(Pos =:= CurrentPos),
  NextPos is CurrentPos + 1,
  cambiaFecha(Rest, Pos, NextPos, Val, NewBbl),
  append([X], NewBbl, Bbl2).

cambiaFecha([X|Rest], Pos, CurrentPos, Val, Bbl2) :-
  autor(X, Autor),
  obra(X, Obra),
  NextPos is CurrentPos + 1,
  cambiaFecha(Rest, Pos, NextPos, Val, NewBbl),
  append([[Obra, Autor, Val]], NewBbl, Bbl2).
