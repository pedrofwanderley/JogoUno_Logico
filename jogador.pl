:- module(jogador, [next/1,status/2]).

use_module(deck).

% Mostra ao jogador o próximo bot a jogar
next(Reversed):-
  (Reversed == 1 ->  write("Próximo a jogar: Dilmãe\n\n");
    write("Próximo a jogar: Lula\n\n")
    ).

% Mostra ao jogador quantas cartas cada bot tem na mão
status(Deck2,Deck3):-
  size(Deck2,Size2), size(Deck3,Size3),
  write("Status: Lula -> "), write(Size2), write(" cartas; Dilmãe -> "), write(Size3), write(" cartas\n\n").
