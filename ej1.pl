% Rafael Caballero González - Programación Lógica - MULCIA 17/18

% Ejercicio 1: Find smallest missing element from a sorted array
% (http://www.techiedelight.com/find-smallest-missing-element-sorted-array/)

% Entrada: Lista
% Salida: El elemento más pequeño que falta

% "smallest_element" es el predicado principal que se debe llamar para obtener
% la solución requerida. Toma una lista y da la solución.
smallest_element([], 0).                 % Caso lista vacía, devuelve 0.
smallest_element([X], [X]).              % Caso lista con un valor, devuelve el valor.
smallest_element([X, Y|Rest], Result) :- % Caso lista con dos valores o mas, itera la lista.
  X =:= 0,                               % Comprueba que el primer elemento es 0.
  checkList([Y|Rest], X, Result).        % Itera de forma recurrente con el resto de la lista.

smallest_element(_, 0).                  % En caso de de primero elemento distinto de 0, la solución es 0.

checkList([], Prev, Result) :-           % Si no quedan elementos por comprobar, el resultado es el último número + 1.
  Result is Prev + 1.

checkList([X|Rest], Prev, Result) :-
  Can is Prev + 1,                       % Suma 1 al elemento anterior.
  X =:= Can,                             % Comprueba que es igual al actual.
  checkList(Rest, Can, Result).          % Itera de forma recurrente el reso de la lista.

checkList(_, Prev, Result) :-
  Result is Prev + 1.                    % Si la comprobación con el número anterior falla,
                                         % el resultado es el anterior + 1.
