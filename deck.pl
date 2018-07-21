:- module(deck, [showCard/1,showDeck/3]).

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
