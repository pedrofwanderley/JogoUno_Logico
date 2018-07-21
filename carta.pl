:- module(carta, [match/3,efeito/2]).

use_module(deck(encontraCarta)).

% Verifica se a carta dá match com a do topo
match(Topo,Carta,S) :-
  encontraCarta(1,Topo,ColorTopo), encontraCarta(1,Carta,ColorCarta),
  encontraCarta(0,Topo,NumTopo), encontraCarta(0,Carta,NumCarta),
  encontraCarta(2,Topo,EffTopo), encontraCarta(2,Carta,EffCarta),
  ((ColorTopo == ColorCarta ; (NumCarta == NumTopo) ; ((EffTopo == EffCarta) , EffCarta \== "")) -> S is 1;
   S is 0
  ).

% Retorna o efeito de uma carta
efeito(Carta,Saida):-
  encontraCarta(2,Carta,Effect),
  (Effect == "REVERSE" -> Saida is 3;
   Effect == "+2" -> Saida is 2;
   Effect == "+4" -> Saida is 4;
   Effect == "BLOCK" -> Saida is 6;
   Effect == "CORINGA" -> Saida is 8;
   Saida is 10
  ).
