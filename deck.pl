:- module(deck, [showCard/1,showDeck/3,encontraCarta/3,removeind/3,podeJogar/3,size/2]).

% Mostra uma carta simples
showCard(Carta):-
  encontraCarta(0,Carta,Numero), encontraCarta(1,Carta,Cor), encontraCarta(2,Carta,Efeito),
  write("Número: "), write(Numero), write(" Cor: "), write(Cor), write(" Efeito: "), write(Efeito),nl.

% Mostra as cartas do deck
showDeck([],_,_).
showDeck(Deck,Indice,Id):-
  encontraCarta(Indice,Deck,Carta),
  removeind(Indice,Deck,DeckAtt),
  write(Id), write(" - "), showCard(Carta),
  NewId is Id+1,
  showDeck(DeckAtt,0,NewId).

% Encontra o elemento de uma lista a partir do índice
encontraCarta(0, [H|_], H):- !.
encontraCarta(I, [_|T], E):- X is I - 1, encontraCarta(X, T, E).

% Remove um elemento da lista a partir do índice
removeind(0,[_|T],T):- !.
removeind(I,[H|T],R):- X is I - 1, removeind(X, T, Y), insereInicio(H, Y, R).

% Verifica se o jogador tem carta que dá match com o topo
podeJogar([],_,Retorno):- Retorno is 0.
podeJogar([H|T],Carta,Retorno):-
  match(Carta,H,S),
  (S == 1 -> Retorno is S;
   podeJogar(T,Carta,Retorno)
  ).

% Qtd de cartas no deck
size([],0).
size([_|T],S):-size(T,G),S is 1+G.
