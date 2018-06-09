% Rafael Caballero González - Programación Lógica - MULCIA 17/18

% Ejercicio 4: Print all paths from root to leaf nodes in given binary tree.
% (http://www.techiedelight.com/print-all-paths-from-root-to-leaf-nodes-binary-tree/)

% Entrada: Árbol (Tree)
% Salida: Ninguna, se imprime por pantalla

% "printRootToLeafPath" es el predicado principal que se debe llamar para obtener
% la solución requerida. Toma un árbol.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Predicados auxiliadores para los árboles
vacio([]).
raiz([_,N,_], N).
hi([HI,_,_], HI).
hd([_,_,HD], HD).
hazarbol(R, HI, HD, [HI,R,HD]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

printRootToLeafPath([]) :-                  % Caso árbol vacío
  write("Empty tree").

printRootToLeafPath(Tree) :-
  not(vacio(Tree)),                         % Árbol no vacío
  rootToLeaf(Tree, []).                     % Comieza a iterar recursivamente.

rootToLeaf(Tree, Path) :-
  raiz(Tree, Raiz),                         % Se obtiene la raiz.
  append([Raiz], Path, NewPath),            % Se añade la raiz a la lista.
  hi(Tree, Hi),                             % Se obtiene la hoja izq.
  hd(Tree, Hd),                             % Se obtiene la hoja der.
  not(vacio(Hi)),                           % Se comprueba que izq NO está vacía.
  not(vacio(Hd)),                           % Se comprueba que der NO está vacía.
  rootToLeaf(Hi, NewPath),                  % Itera recursivamente por la izquierda.
  rootToLeaf(Hd, NewPath).                  % Itera recursivamente por la derecha.

rootToLeaf(Tree, Path) :-                   % Caso de que ambas ramas (izq y der) estén vacías.
  raiz(Tree, Raiz),                         % Se obtiene la raiz.
  append([Raiz], Path, NewPath),            % Se añade la raiz a la lista.
  hi(Tree, Hi),                             % Se obtiene la hoja izq.
  hd(Tree, Hd),                             % Se obtiene la hoja der.
  vacio(Hi),                                % Se comprueba que izq está vacía.
  vacio(Hd),                                % Se comprueba que der está vacía.
  reverse(NewPath, PathR),                  % Dar la vuelta a la lista (para imprimir desde root)
  printList(PathR).                         % Imprimir path.

rootToLeaf(Tree, Path) :-                   % Caso de que rama izq está vacía y der NO.
  raiz(Tree, Raiz),                         % Se obtiene la raiz.
  append([Raiz], Path, NewPath),            % Se añade la raiz a la lista.
  hi(Tree, Hi),                             % Se obtiene la hoja izq.
  hd(Tree, Hd),                             % Se obtiene la hoja der.
  vacio(Hi),                                % Se comprueba que izq está vacía.
  not(vacio(Hd)),                           % Se comprueba que der NO está vacía.
  rootToLeaf(Hd, NewPath).                  % Itera recursivamente por la derecha.

rootToLeaf(Tree, Path) :-                   % Caso de que rama der está vacía y izq NO.
  raiz(Tree, Raiz),                         % Se obtiene la raiz.
  append([Raiz], Path, NewPath),            % Se añade la raiz a la lista.
  hi(Tree, Hi),                             % Se obtiene la hoja izq.
  hd(Tree, Hd),                             % Se obtiene la hoja der.
  not(vacio(Hi)),                           % Se comprueba que izq está vacía.
  vacio(Hd),                                % Se comprueba que der NO está vacía.
  rootToLeaf(Hi, NewPath).                  % Itera recursivamente por la izquierda.

rootToLeaf(_, Path) :-
  reverse(Path, PathR),                     % Dar la vuelta a la lista (para imprimir desde root)
  printList(PathR).                         % Imprimir path.

printList([]).                              % Caso base, lista vacía.
printList([X]) :-                           % Imprime último elemento de la lista y salto de línea.
  write(X), nl.

printList([X|Y]) :-                         % Itera recursivamente la lista imprimiendo los elementos y una flecha.
  write(X), write(" -> "),
  printList(Y).
