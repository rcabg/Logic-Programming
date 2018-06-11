% Rafael Caballero González - Programación Lógica - MULCIA 17/18

% Ejercicio Bloque 2: Una bibliografía.

%BV = [["Quijote","Cervantes",1985],["Demian","Hesse",1978],["Siddharta","Hesse",1993],["Odisea","Homero",1967],["Algebra Universal","Cohn",1967],["Algebra Universal","Shankapanavar", 1988]]

autor([_, Autor, _], Autor).                                 % Extrae autor.
obra([Obra, _, _], Obra).                                    % Extrae obra (titulo).
fecha([_, _, Fecha], Fecha).                                 % Extrae año.

%%% Predicado 1: buscaautor
buscaautor(_, [], []).                                       % Caso base sin ninguna base de datos.
buscaautor(Cdn, _, []) :-                                    % Caso que el autor sea cadena vacía.
  string_length(Cdn, 0).

buscaautor(Cdn, Bbl, L) :-                                   % Busca autor.
  buscaIndexAutor(Cdn, Bbl, L, 0).

buscaIndexAutor(Cdn, [X], L, Index) :-                       % Último elemento en la base de datos.
  autor(X, Autor),                                           % Extrae autor.
  Cdn = Autor,                                               % Comprueba que es igual al autor buscado.
  append([Index], [], L).                                    % Se añade a la lista.

buscaIndexAutor(Cdn, [X], [], _) :-                          % Último elemento en la base de datos y lista (L) vacía ([]) de salida.
  autor(X, Autor),
  not(Cdn = Autor).                                          % El autor buscado no es el acutal.

buscaIndexAutor(Cdn, [X|Rest], L, Index) :-
  autor(X, Autor),                                           % Extrae autor.
  not(Cdn = Autor),                                          % El autor buscado no es el actual.
  NewIndex is Index + 1,                                     % Aumenta el index.
  buscaIndexAutor(Cdn, Rest, L, NewIndex).                   % Itera recursivamente.

buscaIndexAutor(Cdn, [X|Rest], L, Index) :-
  autor(X, Autor),                                           % Extrae autor.
  Cdn = Autor,                                               % El autor buscando es el actual.
  NewIndex is Index + 1,                                     % Aumenta el index en 1.
  buscaIndexAutor(Cdn, Rest, NewList, NewIndex),             % Itera recursivamente.
  append([Index], NewList, L).                               % Añade index a la lista.

%%% Predicado 2:
dime(Bbl, Clv, Pos, Cdn) :-
  Clv = "titulo",                                            % Caso de que se introduzca "titulo".
  checkPosOnList(Bbl, Pos),                                  % Comprueba que la posición introducida está en el rango de la base de datos.
  buscaTituloEnPos(Bbl, Pos, 0, Cdn).                        % Busca el título de la posición introducida.

dime(Bbl, Clv, Pos, Cdn) :-
  Clv = "autor",                                             % Caso de que se introduzca "autor".
  checkPosOnList(Bbl, Pos),                                  % Comprueba que la posición introducida está en el rango de la base de datos.
  buscaAutorEnPos(Bbl, Pos, 0, Cdn).                         % Busca el autor de la posición introducida.

dime(Bbl, Clv, Pos, Cdn) :-
  Clv = "fecha",                                             % Caso de que se introduzca "fecha".
  checkPosOnList(Bbl, Pos),                                  % Comprueba que la posición introducida está en el rango de la base de datos.
  buscaFechaEnPos(Bbl, Pos, 0, Cdn).                         % Busca el año de la posición introducida.

dime(_, _, Pos, _) :-                                        % En caso de que la posición esté fuera de rango, mensaje por pantalla y fail.
  write("Position "), write(Pos),
  write(" is out of range!"),nl,fail.

checkPosOnList(List, Pos) :-                                 % Comprueba que la posición introducida está en el rango de la base de datos.
  length(List, Elements),
  Pos < Elements.

          % Para los tres casos se repite el mismo procedimiento:
          %  - Comprueba que la posición buscada es mayor a la actual.
          %  - Aumenta uno la posición actual
          %  - Itera recursivamente hasta que la posición buscada sea la actual.
          %  - Extrae el título/autor/año

buscaTituloEnPos([_|Rest], Pos, CurrentPos, Cdn) :-
  Pos > CurrentPos,
  NextPos is CurrentPos + 1,
  buscaTituloEnPos(Rest, Pos, NextPos, Cdn).

buscaTituloEnPos([X|_], _, _, Cdn) :-
  obra(X, Cdn).

buscaAutorEnPos([_|Rest], Pos, CurrentPos, Cdn) :-
  Pos > CurrentPos,
  NextPos is CurrentPos + 1,
  buscaAutorEnPos(Rest, Pos, NextPos, Cdn).

buscaAutorEnPos([X|_], _, _, Cdn) :-
  autor(X, Cdn).

buscaFechaEnPos([_|Rest], Pos, CurrentPos, Cdn) :-
  Pos > CurrentPos,
  NextPos is CurrentPos + 1,
  buscaFechaEnPos(Rest, Pos, NextPos, Cdn).

buscaFechaEnPos([X|_], _, _, Cdn) :-
  fecha(X, Cdn).

%%% Predicado 3:
cambia([], _, _, _, []).                                     % Caso base con base de datos vacía.
cambia(Bbl1, Pos, Clv, Val, Bbl2) :-
  Clv = "titulo",                                            % Caso de que se introduzca "titulo".
  checkPosOnList(Bbl1, Pos),                                 % Comprueba que la posición introducida está en el rango de la base de datos.
  cambiaTitulo(Bbl1, Pos, 0, Val, Bbl2).                     % Cambia el título en la posición introducida por el valor deseado.

cambia(Bbl1, Pos, Clv, Val, Bbl2) :-
  Clv = "autor",                                             % Caso de que se introduzca "autor".
  checkPosOnList(Bbl1, Pos),                                 % Comprueba que la posición introducida está en el rango de la base de datos.
  cambiaAutor(Bbl1, Pos, 0, Val, Bbl2).                      % Cambia el autor en la posición introducida por el valor deseado.

cambia(Bbl1, Pos, Clv, Val, Bbl2) :-
  Clv = "fecha",                                             % Caso de que se introduzca "fecha".
  checkPosOnList(Bbl1, Pos),                                 % Comprueba que la posición introducida está en el rango de la base de datos.
  cambiaFecha(Bbl1, Pos, 0, Val, Bbl2).                      % Cambia la fecha en la posición introducida por el valor deseado.

cambia(_, Pos, _, _, _) :-                                   % En caso de que la posición esté fuera de rango, mensaje por pantalla y fail.
  write("Position "), write(Pos),
  write(" is out of range!"),nl,fail.

          % Para los tres casos se repite el mismo procedimiento:
          %  - Comprueba que la posición buscada NO es la actual.
          %  - Aumenta uno la posición actual
          %  - Itera recursivamente hasta que la posición buscada sea la actual.
          %  - Cambia el título/autor/año si procede
          %  - Lo añade a la lista <- Se produce en cada iteración, sin importar que sea la posición deseada o no

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

%%% Predicado 4:
versiones([], _, []).                                        % Caso base de datos vacía, salida vacía.
versiones(Bib, Cad, L) :-
  listaTitulos(Bib, Cad, 0, L).                              % Crea una lista de los títulos.

listaTitulos([], _, _, []).                                  % Caso base.
listaTitulos([X|Rest], Cad, CurrentPos, L) :-
  obra(X, Titulo),                                           % Extrae el título.
  not(Titulo = Cad),                                         % Comprueba que no esa el deseado.
  NextPos is CurrentPos + 1,                                 % Incrementa en uno la posición actual.
  listaTitulos(Rest, Cad, NextPos, L).                       % Itera recursivamente.

listaTitulos([X|Rest], Cad, CurrentPos, L) :-
  obra(X, Titulo),                                           % Extrae el título.
  Titulo = Cad,                                              % Comprueba que sea el título deseado.
  autor(X, Autor), fecha(X, Fecha),                          % Extrae autor y fecha.
  NextPos is CurrentPos + 1,                                 % Incrementa en uno la posición actual.
  listaTitulos(Rest, Cad, NextPos, NewL),                    % Itera recursivamente.
  append([[Autor, Fecha]], NewL, L).                         % Añade [autor, fecha] a una lista.

%%% Predicado 5:
masantiguo([], []).                                          % Caso base.
masantiguo(BV, L) :-
  buscaMasAntiguo(BV, inf, MFecha),                          % Busca los elementos más antiguos de la base de datos introducida.
  hacerListaConFecha(BV, MFecha, 0, L).                      % Hace una lista con la fecha más antigua de la base de datos.

buscaMasAntiguo([X|Rest], Min, Result) :-
  fecha(X, Fecha),                                           % Extrae la fecha
  Fecha < Min,                                               % Si es menor a la que se considera menor hasta ahora (infinito en un inicio),
  buscaMasAntiguo(Rest, Fecha, Result).                      % iteramos con un nuevo mínimo.

buscaMasAntiguo([X|Rest], Min, Result) :-
  fecha(X, Fecha),                                           % Extrae la fecha
  Fecha >= Min,                                              % Si es mayor a la que se considera menor hasta ahora, itera sin actualizarla.
  buscaMasAntiguo(Rest, Min, Result).

buscaMasAntiguo([], Min, Min).                               % Se termina de iterar la base de datos y se tiene solución.

hacerListaConFecha([], _, _, []).                            % Caso base.
hacerListaConFecha([X|Rest], MFecha, CurrentPos, Result) :-
  fecha(X,Fecha),                                            % Extrae la fecha.
  MFecha =:= Fecha,                                          % Se comprueba que el elemento actual tiene la fecha introducida.
  NewPos is CurrentPos + 1,                                  % Incrementa en uno la posición actual.
  hacerListaConFecha(Rest, MFecha, NewPos, NewList),         % Itera recursivamente.
  append([CurrentPos], NewList, Result).                     % Añade la posición actual a la lista.

hacerListaConFecha([X|Rest], MFecha, CurrentPos, Result) :-
  fecha(X,Fecha),                                            % Extrae la fecha.
  not(MFecha =:= Fecha),                                     % Se comprueba que el elemento actual NO tiene la fecha introducida.
  NewPos is CurrentPos + 1,                                  % Incrementa en uno la posición actual.
  hacerListaConFecha(Rest, MFecha, NewPos, Result).          % Itera recursivamente.
