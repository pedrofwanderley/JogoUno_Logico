:- module(deck, [showCard/1,showDeck/3,encontraCarta/3,removeind/3,podeJogar/3,size/2,insereFim/3,insereInicio/3,getCards/3,remCards/3,conc/3]).

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

% Insere um elemento no fim de uma lista
insereFim(T, [H], L):- insereInicio(H,[T],L), !.
insereFim(N, [H|T], L):- insereFim(N,T,X), insereInicio(H, X, L).

% Insere um elemento no início de uma lista
insereInicio(H, L, [H|L]):- !.

% Retorna a quantidade especificada do baralho
getCards([A,B,C,D,E,F,G|_],Qtd,Retorno):-
  (Qtd == 7 -> Retorno = [A,B,C,D,E,F,G];
    Qtd == 4 -> Retorno = [A,B,C,D];
    Qtd == 2 -> Retorno = [A,B];
    Qtd == 1 -> Retorno = [A]
  ).

% Remove a quantidade especificada do baralho
remCards([A,B,C,D,E,F,G|T],Qtd,Retorno):-
  (Qtd == 7 -> Retorno = T;
    Qtd == 4 -> conc([E,F,G],T,Lista), Retorno = Lista;
    Qtd == 2 -> conc([C,D,E,F,G],T,Lista), Retorno = Lista;
    Qtd == 1 -> conc([B,C,D,E,F,G],T,Lista), Retorno = Lista
  ).

% Concatena 2 listas
conc([],L,L).
conc([X|L1],L2,[X|L3]):-
  conc(L1,L2,L3).

      %  Pretas = [[30,"PRETA","+4"],[30,"PRETA","+4"],[30,"PRETA","+4"],[30,"PRETA","+4"],
      %  [40,"PRETA","newColor"],[40,"PRETA","newColor"],[40,"PRETA","newColor"],[40,"PRETA","newColor"]],
      %  Amarelas = [[0,"AMARELA"," "],[1,"AMARELA"," "],[2,"AMARELA"," "],[3,"AMARELA"," "],[4,"AMARELA"," "],
      %  [5,"AMARELA"," "],[6,"AMARELA"," "],[7,"AMARELA"," "],[8,"AMARELA"," "],[9,"AMARELA"," "],[70,"AMARELA","BLOCK"],
      %  [50,"AMARELA","REVERSE"],[60,"AMARELA","+2"],[70,"AMARELA","BLOCK"],[50,"AMARELA","REVERSE"],[60,"AMARELA","+2"]],
      %  Verdes = [[0,"VERDE"," "],[1,"VERDE"," "],[2,"VERDE"," "],[3,"VERDE"," "],[4,"VERDE"," "],[5,"VERDE"," "],
      %  [60,"VERDE","+2"],[70,"VERDE","BLOCK"],[50,"VERDE","REVERSE"],[60,"VERDE","+2"]],
      %  Azuis = [[0,"AZUL"," "],[1,"AZUL"," "],[2,"AZUL"," "],[3,"AZUL"," "],[4,"AZUL"," "],[5,"AZUL"," "],[6,"AZUL"," "],
      %  [7,"AZUL"," "],[8,"AZUL",""],[9,"AZUL",""],[70,"AZUL","BLOCK"],[50,"AZUL","REVERSE"],[60,"AZUL","+2"],
      %  [70,"AZUL","BLOCK"],[50,"AZUL","REVERSE"],[60,"AZUL","+2"]],
      %  Vermelhas = [[0,"VERMELHA"," "],[1,"VERMELHA"," "],[2,"VERMELHA"," "],[3,"VERMELHA"," "],[4,"VERMELHA"," "],
      %  [5,"VERMELHA"," "],[6,"VERMELHA"," "],[7,"VERMELHA"," "],[8,"VERMELHA"," "],[9,"VERMELHA"," "],
      %  [70,"VERMELHA","BLOCK"],[50,"VERMELHA","REVERSE"],[60,"VERMELHA","+2"],[70,"VERMELHA","BLOCK"],
      %  [50,"VERMELHA","REVERSE"],[60,"VERMELHA","+2"]],
