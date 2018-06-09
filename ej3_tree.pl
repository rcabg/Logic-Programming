% Rafael Caballero González - Programación Lógica - MULCIA 17/18

% Ejercicio 3: Find next node in same level for given node in a binary tree.
% (http://www.techiedelight.com/find-next-node-in-same-level-binary-tree/)

% Entrada: Árbol (Tree), Nodo (Node)
% Salida: El siguiente nodo del mismo nivel

% "solveEx3" es el predicado principal que se debe llamar para obtener
% la solución requerida. Toma un árbol y un nodo.

% Ejemplo de ejecución (árbol A4 de arboles-binarios.pdf)
% solveEx3([[[[[],1,[]],5,[]],7,[[],3,[[],4,[]]]],6,[[[],10,[]],8,[[[],9,[]],11,[[],2,[]]]]], 4, Result).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Predicados auxiliadores para los árboles
vacio([]).
raiz([_,N,_], N).
hi([HI,_,_], HI).
hd([_,_,HD], HD).
hazarbol(R, HI, HD, [HI,R,HD]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


nivel([], _, 0).                        % Si el árbol es vacío, la profundidad es 0 sin importar el nodo.
nivel(Tree, Node, D) :-                 % Para un Tree y un Node, buscar D (profundidad).
  length(Tree, 3),                      % Comprueba que la lista tiene 3 elementos.
  raiz(Tree, R),                        % Obtiene la raiz del árbol.
  Node =:= R,                           % Comprueba que el nodo buscado es la raiz del árbol obtenida.
  D is 1.                               % En ese caso, la profundidad es 1.

nivel(Tree, Node, D) :-
  get_nivel(Tree, Node, D, 1).          % Si la raiz del árbol no es el nodo buscado,
                                        % se recorre el árbol de forma recurrente.

get_nivel(Tree, Node, D, DT) :-         % DT es la profunidad acumulada.
  ND is DT + 1,                         % Se incrementa la profundidad en un nivel.
  hi(Tree, Hi), hd(Tree, Hd),           % Se obtiene la hoja izq y der.
  raiz(Hi, RHi), raiz(Hd, RHd),         % Se obtiene la raiz de dichas ojas.
  not(RHi =:= Node),not(RHd =:= Node),  % Se comprueba que ninguna de esas raices sea el nodo buscado.
  get_nivel(Hi, Node, D, ND),           % Se itera recurrentemente por la rama izquierda.
  get_nivel(Hd, Node, D, ND).           % Se itera recurrentemente por la rama derecha.

get_nivel(_, _, D, DT) :-         % Cuando se encuentre el nodo, la profunidad es la acumulada + 1.
  D is DT + 1.

list_nivel([], _, []).                  % Si el árbol está vacío, la lista es vacía sin importar la profunidad.
list_nivel([_, X, _], 1, [X]).          % Si la profundidad es 1, la lista tiene solo la raiz del árbol
list_nivel(Tree, D, Lista) :-
  D > 1, DAux is D - 1,                 % Se comprueba que la profunidad buscada es mayor que 1. Resta 1 a la profunidad.
  hi(Tree, Hi), hd(Tree, Hd),           % Se obtiene la hoja izq y der.
  list_nivel(Hi, DAux, ListaIzq),       % Busca por la izquierda (ojo, profunidad - 1).
  list_nivel(Hd, DAux, ListaDer),       % Busca por la derecha (ojo, profunidad - 1).
  append(ListaIzq, ListaDer, Lista).    % Crea la lista.

list_nivel(Tree, D, Lista) :-           % Misma operación, solo que en caso de que solo exista una
  D > 1, DAux is D - 1,                 % rama por la izquierda y NO por la derecha.
  hi(Tree, Hi),
  list_nivel(Hi, DAux, ListaIzq),
  append(ListaIzq, [], Lista).

list_nivel(Tree, D, Lista) :-           % Misma operación, solo que en caso de que solo exista una
  D > 1, DAux is D - 1,                 % rama por la derecha y NO por izquierda.
  hd(Tree, Hd),
  list_nivel(Hd, DAux, ListaDer),
  append(ListaDer, [], Lista).

solveEx3(Tree, Node, Result) :-
  nivel(Tree, Node, D),                 % Obtiene en que nivel se encuentra dicho nodo.
  list_nivel(Tree, D, List),            % Obtiene una lista de los nodos en ese nivel
  sort(List, Sorted),                   % Ordena la lista de menor a mayor.
  nextto(Node, Result, Sorted).         % Obtiene el siguiente elemento de la lista

solveEx3(_, _, []).               % Si no hay siguiente elemento en la lista,
                                        % el resultado es [] ya que no existe nodo.
