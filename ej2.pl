% Rafael Caballero González - Programación Lógica - MULCIA 17/18

% Ejercicio 2: Find floor and ceil of a number in a sorted array.
% (http://www.techiedelight.com/find-floor-ceil-number-sorted-array/)

% Entrada: Integer (A), Lista (List)
% Salida: Floor, Ceiling

% "checkNumber" es el predicado principal que se debe llamar para obtener
% la solución requerida. Toma un número y una lista.

checkNumber(A, [], A, A).                % Si no se proporciona lista, el número es la solución.
checkNumber(A, List, Floor, Ceiling) :-
  member(A, List),                       % Comprueba si A está en la lista.
  Floor is A,                            % Si está, A es la solución para Floor y Ceiling.
  Ceiling is Floor.

checkNumber(A, List, Floor, Ceiling) :-
  not(member(A, List)),                  % Comprueba que A no esté en la Lista.
  searchFloor(A, List, Floor),           % Busca la solución para Floor.
  searchCeiling(A, List, Ceiling).       % Busca la solución para Ceiling.

searchFloor(B, List, Result) :-
  last(List, Last),                      % Se obtiene el último elemento de la lista.
  B >= Last,                             % En caso de que el número sea mayor o igual al último elemento
  Result is -1.                          % de la lista, el resultado es -1.

searchFloor(B, _, Result) :-
  B =:= -1,                              % Si el número es -1, el resultado es -1 sin importar la lista.
  Result is B.

searchFloor(B, List, Result) :-
  member(B, List),                       % Si el número está en la lista es la solución (se usa para la iteración recursiva).
  Result is B.

searchFloor(B, List, Result) :-
  C is B - 1,                            % Decrementa 1 el número a comprobar e itera recursivamente.
  searchFloor(C, List, Result).

searchCeiling(B, List, Result) :-        % Si el último elemento de la lista es
  last(List, Last),                      % mayor o igual que el número el resultado es el último elemento de la lista.
  B >= Last,
  Result is Last.

searchCeiling(B, List, Result) :-        % Si el número está en la lista es la solución (se usa para la iteración recursiva).
  member(B, List),
  Result is B.

searchCeiling(B, List, Result) :-        % Incrementa 1 el número a comprobar e itera recursivamente.
  C is B + 1,
  searchCeiling(C, List, Result).
