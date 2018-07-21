use_module(library(random)).

colour(amarela).
colour(verde).
colour(azul).
colour(vermelha).


deck([card(2,colour(amarela)),card(3,colour(amarela)),card(4,colour(amarela))]).

/*
      card(5,amarela),card(6,amarela),card(7,amarela),card(8,amarela),
      (9,amarela),
      (2,verde),(3,verde),(4,verde),
      (5,verde),(6,verde),(7,verde),(eight,verde),
      (9,verde),
      (2,azul),(3,azul),(4,azul),
      (5,azul),(6,azul),(7,azul),(8,azul),
      (9,azul),
      (2,vermelha),(3,vermelha),(4,vermelha),
      (5,vermelha),(6,vermelha),(7,vermelha),(8,vermelha),
      (9,vermelha)]).
*/

%Metodos

/* Método que embaralha o deck */
%% shuffle(ListIn, ListOut) - randomly shuffles
%% ListIn and unifies it with ListOut
shuffle([],[]).
shuffle(Deck,Bs) :-
   random_permutation(Deck,L),
   Bs is L.

/* Método que adciona carta a uma lista*/
add_card(X,Y,[X|Y]).

check_card(amarela,  amarela).
check_card(verde, verde).
check_card(azul, azul).
check_card(vermelha, vermelha).
check(X,Y):- check_card(X,Y).

teste_card(card(2,colour(amarela)),card(2,colour(amarela))).
test_check(X,Y):- test_card(X,Y).

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
  Deck1 = [[3,"amarela",""],[3,"azul",""],[20,"verde","+2"]],
  random_permutation(Deck1,S),
  write(S),
  rodar(Deck1,[[3,"verde",""],[4,"vermelha",""]],[[0,"amarela",""],[5,"azul",""]],[6,"azul","+2"],0,0).

rodar(Deck1,Deck2,Deck3,Topo,Vez,Reversed):-
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
    rodar(Deck1,Deck2,Deck3,Topo,Vez,Reversed)
    ).
