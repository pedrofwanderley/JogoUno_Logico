use_module(deck).
use_module(util).
use_module(carta).

shuffle([],[]).
shuffle(Deck,Bs) :-
   random_permutation(Deck,L),
   Bs is L.

% PREDICADOS PARA MANIPULAR LISTAS

% Insere um elemento no início de uma lista
insereInicio(H, L, [H|L]):- !.

% Insere um elemento no fim de uma lista
insereFim(T, [H], L):- insereInicio(H,[T],L), !.
insereFim(N, [H|T], L):- insereFim(N,T,X), insereInicio(H, X, L).


% Junta duas listas
concatenar([],Lista1,Lista2).
concatenar([Elem|Lista1],Lista2,[Elem|Lista3]):-
  concatenar(Lista1,Lista2,Lista3).

:- initialization(main).

main:-
  menu().

menu():-
  tela_principal(),
  read(Input),
  ((Input =:= 1 ; Input == 2 ; Input == 3) -> executarOpcao(Input);
    write("Opção Inválida, Tente outra vez!!"),nl,
    menu()
  ).

executarOpcao(Input):-
  (Input == 1 -> prepararJogo();
   Input == 2 -> exibir_regras(),
   read(Voltar),
   (Voltar \== "" -> menu()
   );
   Input == 3 -> write("ATÉ BREVE!!"),nl
  ).

prepararJogo():-
  Baralho = [[0,"AZUL",""],[1,"AZUL",""],[2,"AZUL",""],[3,"AZUL",""],[4,"AZUL",""],[5,"AZUL",""],[6,"AZUL",""],[7,"AZUL",""],[8,"AZUL",""],[9,"AZUL",""]],
  random_permutation(Baralho,PilhaShuffled),
  Deck1 = [[3,"AMARELA",""],[3,"AZUL",""],[20,"VERDE","+2"],[30,"AZUL","BLOCK"],[40,"AZUL","REVERSE"]],
  Deck2 = [[3,"VERDE",""],[4,"AMARELA",""]],
  Deck3 = [[0,"AMARELA",""],[3,"AZUL",""]],
  novoJogo(PilhaShuffled,Deck1,Deck2,Deck3,[6,"AZUL",""],1,0).

novoJogo(Pilha,Deck1,Deck2,Deck3,Topo,Vez,Reversed):-
        write("\nIniciando o jogo: Você vs Lula vs Dilma... "),
        write("lets do this!!\n"),
        rodar(Pilha,Deck1,Deck2,Deck3,Topo,Vez,Reversed).

rodar(Pilha,Deck1,Deck2,Deck3,Topo,Vez,Reversed):-
  write("--------------------------------------------------------------\n"),
  size(Deck1,Size1), size(Deck2,Size2), size(Deck3,Size3), size(Pilha,SizePilha),
    (Size1 == 0 -> write("VOCÊ VENCEU, PARABÉNS"),nl;
   Size2 == 0 -> write("LULA FOI SOLTO, VOCÊ PERDEU!!"),nl;
   Size3 == 0 -> write("DILMÃE VOLTOU À PRESIDÊNCIA, VOCÊ PERDEU!!"),nl;
   SizePilha == 0 -> write("O deck foi esgotado! O jogador com menos cartas venceu!")
  ), menu()
  ;
  (Vez == 1 ->
    gerenciaPlayer(Pilha,Deck1,Deck2,Deck3,Topo,Vez,Reversed);
   Vez == 2 ->
     gerenciaBot1(Pilha,Deck1,Deck2,Deck3,Topo,Vez,Reversed);
   Vez == 3 ->
     gerenciaBot2(Pilha,Deck1,Deck2,Deck3,Topo,Vez,Reversed)
 ).

gerenciaPlayer(Pilha,Deck1,Deck2,Deck3,Topo,Vez,Reversed):-
  write("Topo: "), showCard(Topo),
  write("Sua mão: "),nl,
  showDeck(Deck1,0,0),nl,
  podeJogar(Deck1,Topo,Retorno),
  (Retorno == 1 -> % Se tiver carta válida, pede pra o player escolher a carta desejada
    write("Escolha sua carta "),
    read(Input),
    encontraCarta(Input,Deck1,Carta),
    match(Topo,Carta,Saida),
    (Saida == 1 -> % Se a carta der match then...
      removeind(Input,Deck1,DeckAtt), efeito(Carta,Efeito),
      (Reversed == 0 ->
          (Efeito == 10 -> Prox is Vez+1, rodar(Pilha,DeckAtt,Deck2,Deck3,Carta,Prox,Reversed);
           Efeito == 6 -> Prox is Vez+2, rodar(Pilha,DeckAtt,Deck2,Deck3,Carta,Prox,Reversed);
           Efeito == 3 -> Prox is Vez+2, rodar(Pilha,DeckAtt,Deck2,Deck3,Carta,Prox,Reversed)
           );

        (Efeito == 10 -> Prox is Vez+2, rodar(Pilha,DeckAtt,Deck2,Deck3,Carta,Prox,Reversed);
         Efeito == 6 -> Prox is Vez+1, rodar(Pilha,DeckAtt,Deck2,Deck3,Carta,Prox,Reversed);
         Efeito == 3 -> Prox is Vez+1, rodar(Pilha,DeckAtt,Deck2,Deck3,Carta,Prox,Reversed)
         )
      ) ; % Se não der, pede pra tentar outra...
      Prox is Vez,
      write("Tente outra carta"),nl,
      gerenciaPlayer(Pilha,Deck1,Deck2,Deck3,Topo,Prox,Reversed)
    ),
    rodar(Pilha,Deck1,Deck2,Deck3,Carta,Prox,Reversed)
  ; % Se chegou aqui, o player não possui carta válida
  write("Você não possui carta válida para esta rodada!!")

  ).

gerenciaBot1(Pilha,Deck1,Deck2,Deck3,Topo,Vez,Reversed):-
  write("Vez de Lula"),nl,
  write("Topo: "), write(Topo),nl,
  write("Sua mão: "), write(Deck2),nl,
  write("Escolha sua carta: "),
  read(X),
  encontraCarta(X,Deck2,R),
  match(Topo,R,Saida),
  (Saida == 1 ->
    write("Ta no caminho certo"),nl,
    removeind(X,Deck2,Ret),
    Prox is Vez+1,
    rodar(Pilha,Deck1,Ret,Deck3,R,Prox,Reversed);
    Saida == 0 ->
    write("Tente outra carta"),nl,
    rodar(Pilha,Deck1,Deck2,Deck3,Topo,Vez,Reversed)
).

gerenciaBot2(Pilha,Deck1,Deck2,Deck3,Topo,Vez,Reversed):-
  write("Vez de Dilmãe"),nl,
  write("Topo: "), write(Topo),nl,
  write("Sua mão: "), write(Deck3),nl,
  write("Escolha sua carta: "),
  read(X),
  encontraCarta(X,Deck3,R),
  match(Topo,R,Saida),
  (Saida == 1 ->
    write("Ta no caminho certo"),nl,
    removeind(X,Deck3,Ret),
    Prox is Vez-2,
    rodar(Pilha,Deck1,Deck2,Ret,R,Prox,Reversed);
    Saida == 0 ->
    write("Tente outra carta"),nl,
    rodar(Pilha,Deck1,Deck2,Deck3,Topo,Vez,Reversed)
).
