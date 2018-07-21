
shuffle([],[]).
shuffle(Deck,Bs) :-
   random_permutation(Deck,L),
   Bs is L.

% PREDICADOS PARA MANIPULAR LISTAS

% Encontra o elemento de uma lista a partir do índice
encontraCarta(0, [H|_], H):- !.
encontraCarta(I, [_|T], E):- X is I - 1, encontraCarta(X, T, E).

% Remove um elemento da lista a partir do índice
removeind(0,[_|T],T):- !.
removeind(I,[H|T],R):- X is I - 1, removeind(X, T, Y), insereInicio(H, Y, R).

% Insere um elemento no início de uma lista
insereInicio(H, L, [H|L]):- !.

% Insere um elemento no fim de uma lista
insereFim(T, [H], L):- insereInicio(H,[T],L), !.
insereFim(N, [H|T], L):- insereFim(N,T,X), insereInicio(H, X, L).

match(Topo,Carta,S) :-
  encontraCarta(1,Topo,ColorTopo), encontraCarta(1,Carta,ColorCarta),
  encontraCarta(0,Topo,NumTopo), encontraCarta(0,Carta,NumCarta),
  encontraCarta(2,Topo,EffTopo), encontraCarta(2,Carta,EffCarta),
  ((ColorTopo == ColorCarta ; (NumCarta == NumTopo) ; ((EffTopo == EffCarta) , EffCarta \== "")) -> S is 1;
   S is 0
  ).

:- initialization(main).

main:-
  Baralho = [[0,"AZUL",""],[1,"AZUL",""],[2,"AZUL",""],[3,"AZUL",""],[4,"AZUL",""],[5,"AZUL",""],[6,"AZUL",""],[7,"AZUL",""],[8,"AZUL",""],[9,"AZUL",""]],
  random_permutation(Baralho,PilhaShuffled),
  Deck1 = [[3,"amarela",""],[3,"azul",""],[20,"verde","+2"]],
  rodar(Deck1,[[3,"verde",""],[4,"vermelha",""]],[[0,"amarela",""],[5,"azul",""]],[6,"azul","+2"],1,0).

rodar(Deck1,Deck2,Deck3,Topo,Vez,Reversed):-
  (Vez == 1 ->
    write("Topo: "), write(Topo),nl,
    write("Sua mão: "), write(Deck1),nl,
    write("Escolha sua carta: "),
    read(X),
    encontraCarta(X,Deck1,R),
    match(Topo,R,Saida),
    (Saida == 1 ->
      write("Ta no caminho certo"),nl,
      removeind(X,Deck1,Ret),
      rodar(Ret,[4,5,6],[7,8,9],R,Vez is Vez + 1,Reversed);
      Saida == 0 ->
      write("Tente outra carta"),nl,
      rodar(Deck1,Deck2,Deck3,Topo,Vez,Reversed) );
   Vez == 2 ->
       write("Vez de Lula"),nl,
       write("Topo: "), write(Topo),nl,
       write("Sua mão: "), write(Deck1),nl,
       write("Escolha sua carta: "),
       read(X),
       encontraCarta(X,Deck2,R),
       match(Topo,R,Saida),
       (Saida == 1 ->
         write("Ta no caminho certo"),nl,
         removeind(X,Deck2,Ret),
         rodar(Deck1,Ret,[7,8,9],R,Vez is Vez - 1,Reversed);
         Saida == 0 ->
         write("Tente outra carta"),nl,
         rodar(Deck1,Deck2,Deck3,Topo,Vez,Reversed)
       )
   ).
