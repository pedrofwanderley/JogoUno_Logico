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



      /*estrutura básica.*/
player(Nome,HandDeck) :-
    hand_deck(HandDeck).
      /* HandDeck é uma lista, possivelmente teremos 3 HandDecks default, foda-se o design
      um HandDeck para cada Player*/

bot1(Bot,HandDeckBot1).
bot2(Bot,HandDeckBot2).
      /* ex: add_card(card, HandDeck, L) --> L is HandDeck
        Não sei se pode fazer isso, pq é modificação de váriavel, mas é
        uma possibilidade
      */


%Metodos

/* Método que embaralha o deck */
%% shuffle(ListIn, ListOut) - randomly shuffles
%% ListIn and unifies it with ListOut
shuffle([],[]).
shuffle([A|As],Bs) :- shuffle(As,Xs), append(Ps,Qs,Xs), append(Ps,[A|Qs],Bs).

/* Método que adciona carta a uma lista*/
add_card(X,Y,[X|Y]).

/* Método que puxa carta do deck principal e adiciona na mão do jogador */
pick_card([X|Y],X).





check_card(amarela,  amarela).
check_card(verde, verde).
check_card(azul, azul).
check_card(vermelha, vermelha).
check(X,Y):- check_card(X,Y).

teste_card(card(2,colour(amarela)),card(2,colour(amarela))).
test_check(X,Y):- test_card(X,Y).

:- initialization main.

main:-

  add_card(card(2,colour(vermelha)),card(3,colour(amarela)),Deck),
  add_card(card(3,colour(verde)),Deck,S),
  add_card(card(2,colour(azul)),S,T),
  pick_card(T,Card),
  writeln(Card),

  shuffle(T,L2),

  pick_card(L2,Card2),
  writeln(Card2).
