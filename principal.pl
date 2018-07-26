use_module(deck).
use_module(util).
use_module(carta).
use_module(jogador).

:- initialization(main).

main:-
  tela_principal(),
  menu().

menu():-
  read(Input),
  ((Input =:= 1 ; Input == 2 ; Input == 0) -> executarOpcao(Input);
    write("Opção Inválida, Tente outra vez!!"),nl,
    menu()
  ).

executarOpcao(Input):-
  (Input == 1 -> prepararJogo();
   Input == 2 -> exibir_regras(),
   read(Voltar),
   (Voltar \== "" -> main
   );
   Input == 0 -> write("ATÉ BREVE!!"),nl
  ).

prepararJogo():-
  Pretas = [[30,"PRETA","+4"],[30,"PRETA","+4"],[30,"PRETA","+4"],[30,"PRETA","+4"],[40,"PRETA","newColor"],[40,"PRETA","newColor"],[40,"PRETA","newColor"],[40,"PRETA","newColor"]],
  Amarelas = [[0,"AMARELA"," "],[1,"AMARELA"," "],[2,"AMARELA"," "],[3,"AMARELA"," "],[4,"AMARELA"," "],[5,"AMARELA"," "],[6,"AMARELA"," "],[7,"AMARELA"," "],[8,"AMARELA"," "],[9,"AMARELA"," "],[70,"AMARELA","BLOCK"],
  [50,"AMARELA","REVERSE"],[60,"AMARELA","+2"],[70,"AMARELA","BLOCK"],[50,"AMARELA","REVERSE"],[60,"AMARELA","+2"]],
  Verdes = [[0,"VERDE"," "],[1,"VERDE"," "],[2,"VERDE"," "],[3,"VERDE"," "],[4,"VERDE"," "],[5,"VERDE"," "],
  [6,"VERDE"," "],[7,"VERDE"," "],[8,"VERDE"," "],[9,"VERDE"," "],[70,"VERDE","BLOCK"],[50,"VERDE","REVERSE"],[60,"VERDE","+2"],[70,"VERDE","BLOCK"],[50,"VERDE","REVERSE"],[60,"VERDE","+2"]],
  Azuis = [[0,"AZUL"," "],[1,"AZUL"," "],[2,"AZUL"," "],[3,"AZUL"," "],[4,"AZUL"," "],[5,"AZUL"," "],[6,"AZUL"," "],
  [7,"AZUL"," "],[8,"AZUL",""],[9,"AZUL",""],[70,"AZUL","BLOCK"],[50,"AZUL","REVERSE"],[60,"AZUL","+2"],[70,"AZUL","BLOCK"],[50,"AZUL","REVERSE"],[60,"AZUL","+2"]],
  Vermelhas = [[0,"VERMELHA"," "],[1,"VERMELHA"," "],[2,"VERMELHA"," "],[3,"VERMELHA"," "],[4,"VERMELHA"," "],[5,"VERMELHA"," "],[6,"VERMELHA"," "],[7,"VERMELHA"," "],[8,"VERMELHA"," "],[9,"VERMELHA"," "],
  [70,"VERMELHA","BLOCK"],[50,"VERMELHA","REVERSE"],[60,"VERMELHA","+2"],[70,"VERMELHA","BLOCK"],[50,"VERMELHA","REVERSE"],[60,"VERMELHA","+2"]],
  conc(Pretas,Amarelas,Result1), conc(Result1,Verdes,Result2), conc(Result2,Azuis,Result3), conc(Result3,Vermelhas,Baralho),
  random_permutation(Baralho,PilhaShuffled),
  getCards(PilhaShuffled,7,Deck1), remCards(PilhaShuffled,7,Pilha1),
  getCards(Pilha1,7,Deck2), remCards(Pilha1,7,Pilha2),
  getCards(Pilha2,7,Deck3), remCards(Pilha2,7,Pilha3),
  getCards(Pilha3,1,Topo), remCards(Pilha3,1,PilhaFinal),
  encontraCarta(0,Topo,TopoFinal),
  novoJogo(PilhaFinal,Deck1,Deck2,Deck3,TopoFinal,1,0).

novoJogo(Pilha,Deck1,Deck2,Deck3,Topo,Vez,Reversed):-
        write("\nIniciando o jogo: Você vs Lula vs Dilma... \n"),
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
  podeJogar(Deck1,Topo,Retorno),
  (Retorno == 1 -> % Se tiver carta válida, pede pra o player escolher a carta desejada
    write("\n  Sua vez - "), next(Reversed), status(Deck2,Deck3), showDeck(Deck1,0,0,Topo),nl,
    write("Escolha uma carta "),
    read(Input),
    encontraCarta(Input,Deck1,Carta),
    match(Topo,Carta,Saida),
    (Saida == 1 -> % Se a carta der match then...
      removeind(Input,Deck1,DeckAtt), efeito(Carta,Efeito),
      (Reversed == 0 ->
          (Efeito == 10 -> Prox is Vez+1, rodar(Pilha,DeckAtt,Deck2,Deck3,Carta,Prox,Reversed);
           Efeito == 6 -> Prox is Vez+2, rodar(Pilha,DeckAtt,Deck2,Deck3,Carta,Prox,Reversed);
           Efeito == 3 -> Prox is Vez+2, rodar(Pilha,DeckAtt,Deck2,Deck3,Carta,Prox,1);
           Efeito == 2 -> Prox is Vez+1, getCards(Pilha, 2, CartasAdd), remCards(Pilha, 2, PilhaAtt), conc(Deck2,CartasAdd,Deck2Att),
            rodar(PilhaAtt, DeckAtt, Deck2Att, Deck3, Carta, Prox, Reversed);
           Efeito == 4 -> Prox is Vez+1, getCards(Pilha, 4, CartasAdd), remCards(Pilha, 4, PilhaAtt), conc(Deck2, CartasAdd, Deck2Att),
           writeln("Digite a cor da carta:"),writeln("1-Vermelha 2-Verde 3-Azul 4-Amarela"),read(X),
           (X == 1 -> rodar(PilhaAtt, DeckAtt, Deck2Att, Deck3, [30, "VERMELHA", " "] , Prox, Reversed);
            X == 2 -> rodar(PilhaAtt, DeckAtt, Deck2Att, Deck3, [30, "VERDE", " "], Prox, Reversed);
            X == 3 -> rodar(PilhaAtt, DeckAtt, Deck2Att, Deck3, [30, "AZUL", " "], Prox, Reversed);
            X == 4 -> rodar(PilhaAtt, DeckAtt, Deck2Att, Deck3, [30, "AMARELA", " "], Prox, Reversed))
           );

        (Efeito == 10 -> Prox is Vez+2, rodar(Pilha,DeckAtt,Deck2,Deck3,Carta,Prox,Reversed);
         Efeito == 6 -> Prox is Vez+1, rodar(Pilha,DeckAtt,Deck2,Deck3,Carta,Prox,Reversed);
         Efeito == 3 -> Prox is Vez+1, rodar(Pilha,DeckAtt,Deck2,Deck3,Carta,Prox,0);
         Efeito == 2 -> Prox is Vez+2, getCards(Pilha, 2, CartasAdd), remCards(Pilha, 2, PilhaAtt), conc(Deck3,CartasAdd,Deck3Att),
           rodar(PilhaAtt, DeckAtt, Deck2, Deck3Att, Carta, Prox, Reversed);
         Efeito == 4 -> Prox is Vez+2, getCards(Pilha, 4, CartasAdd), remCards(Pilha, 4, PilhaAtt), conc(Deck3, CartasAdd, Deck3Att),
           writeln("Digite a cor da carta:"),writeln("1-Vermelha 2-Verde 3-Azul 4-Amarela"),read(X),
           (X == 1 -> rodar(PilhaAtt, DeckAtt, Deck2, Deck3Att, [30, "VERMELHA", " "] , Prox, Reversed);
            X == 2 -> rodar(PilhaAtt, DeckAtt, Deck2, Deck3Att, [30, "VERDE", " "], Prox, Reversed);
            X == 3 -> rodar(PilhaAtt, DeckAtt, Deck2, Deck3Att, [30, "AZUL", " "], Prox, Reversed);
            X == 4 -> rodar(PilhaAtt, DeckAtt, Deck2, Deck3Att, [30, "AMARELA", " "], Prox, Reversed))
         )
      ) ; % Se não der, pede pra tentar outra...
      Prox is Vez,
      write("Tente outra carta"),nl,
      gerenciaPlayer(Pilha,Deck1,Deck2,Deck3,Topo,Prox,Reversed)
    ),
    rodar(Pilha,Deck1,Deck2,Deck3,Carta,Prox,Reversed)
  ; % Se chegou aqui, o player não possui carta válida
  write("Você não possui carta válida para esta rodada!!"), write("Aperte uma tecla para continuar"),
  read(X),
  getCards(Pilha, 1, CartaAdd), encontraCarta(0, CartaAdd, Carta), remCards(Pilha, 1, PilhaAtt), match(Topo,Carta,Valida),
  (Valida == 1 ->
    efeito(Carta, Efeito),
    (Reversed == 0 ->
          (Efeito == 10 -> Prox is Vez+1, rodar(PilhaAtt,Deck1,Deck2,Deck3,Carta,Prox,Reversed);
           Efeito == 6 -> Prox is Vez+2, rodar(PilhaAtt,Deck1,Deck2,Deck3,Carta,Prox,Reversed);
           Efeito == 3 -> Prox is Vez+2, rodar(PilhaAtt,Deck1,Deck2,Deck3,Carta,Prox,1);
           Efeito == 2 -> Prox is Vez+1, getCards(PilhaAtt, 2, CartasAdd), remCards(PilhaAtt, 2, PilhaAtt2), conc(Deck2,CartasAdd,Deck2Att),
           rodar(PilhaAtt2, Deck1, Deck2Att, Deck3, Carta, Prox, Reversed);
           Efeito == 4 -> Prox is Vez+1, getCards(PilhaAtt, 4, CartasAdd), remCards(PilhaAtt, 4, PilhaAtt2), conc(Deck2, CartasAdd, Deck2Att),
            rodar(PilhaAtt2, DeckAtt, Deck2Att, Deck3, Carta, Prox, Reversed)
           );

        (Efeito == 10 -> Prox is Vez+2, rodar(PilhaAtt,Deck1,Deck2,Deck3,Carta,Prox,Reversed);
         Efeito == 6 -> Prox is Vez+1, rodar(PilhaAtt,Deck1,Deck2,Deck3,Carta,Prox,Reversed);
         Efeito == 3 -> Prox is Vez+1, rodar(PilhaAtt,Deck1,Deck2,Deck3,Carta,Prox,0);
         Efeito == 2 -> Prox is Vez+2, getCards(PilhaAtt, 2, CartasAdd), remCards(PilhaAtt, 2, PilhaAtt2), conc(Deck3,CartasAdd,Deck3Att),
           rodar(PilhaAtt2, Deck1, Deck2, Deck3Att, Carta, Prox, Reversed);
         Efeito == 4 -> Prox is Vez+2, getCards(PilhaAtt, 4, CartasAdd), remCards(PilhaAtt, 4, PilhaAtt2), conc(Deck3, CartasAdd, Deck3Att),
           rodar(PilhaAtt2, DeckAtt, Deck2, Deck3Att, Carta, Prox, Reversed)
         )
      );
      conc(Deck1, CartaAdd, DeckAtt),
      (Reversed == 0 -> Prox is Vez + 1, rodar(PilhaAtt, DeckAtt, Deck2, Deck3, Topo, Prox, Reversed);
       Prox is Vez + 2, rodar(PilhaAtt, DeckAtt, Deck2, Deck3, Topo, Prox, Reversed) )
  )
  ).

gerenciaBot1(Pilha,Deck1,Deck2,Deck3,Topo,Vez,Reversed):-
  size(Deck1, Sum),
  writeln(Sum),
  write("Vez de LULA\n\n"), write("Topo: "), showCard(Topo),nl,
  showDeck(Deck2,0,0,Topo),nl,
  podeJogar(Deck2,Topo,Retorno),
  (Retorno == 1 -> % Se tiver carta válida, pede pra o player escolher a carta desejada
    write("Escolha sua carta "),
    read(Input),
    encontraCarta(Input,Deck2,Carta),
    match(Topo,Carta,Saida),
    (Saida == 1 -> % Se a carta der match then...
      removeind(Input,Deck2,DeckAtt), efeito(Carta,Efeito),
      (Reversed == 0 ->
          (Efeito == 10 -> Prox is Vez+1, rodar(Pilha,Deck1,DeckAtt,Deck3,Carta,Prox,Reversed);
           Efeito == 6 -> Prox is Vez-1, rodar(Pilha,Deck1,DeckAtt,Deck3,Carta,Prox,Reversed);
           Efeito == 3 -> Prox is Vez-1, rodar(Pilha,Deck1,DeckAtt,Deck3,Carta,Prox,1);
           Efeito == 2 -> Prox is Vez+1, getCards(Pilha, 2, CartasAdd), remCards(Pilha, 2, PilhaAtt), conc(Deck3, CartasAdd, Deck3Att),
           rodar(PilhaAtt, Deck1, DeckAtt, Deck3Att, Carta, Prox, Reversed)
           );

        (Efeito == 10 -> Prox is Vez-1, rodar(Pilha,Deck1,DeckAtt,Deck3,Carta,Prox,Reversed);
         Efeito == 6 -> Prox is Vez+1, rodar(Pilha,Deck1,DeckAtt,Deck3,Carta,Prox,Reversed);
         Efeito == 3 -> Prox is Vez+1, rodar(Pilha,Deck1,DeckAtt,Deck3,Carta,Prox,0);
         Efeito == 2 -> Prox is Vez-1, getCards(Pilha, 2, CartasAdd), remCards(Pilha, 2, PilhaAtt), conc(Deck1, CartasAdd, Deck1Att),
         rodar(PilhaAtt, Deck1Att, DeckAtt, Deck3, Carta, Prox, Reversed)
         )
      ) ; % Se não der, pede pra tentar outra...
      Prox is Vez,
      write("Tente outra carta"),nl,
      gerenciaBot1(Pilha,Deck1,Deck2,Deck3,Topo,Prox,Reversed)
    ),
    rodar(Pilha,Deck1,Deck2,Deck3,Carta,Prox,Reversed)
  ; % Se chegou aqui, o player não possui carta válida
  write("Você não possui carta válida para esta rodada!!"), write("Aperte uma tecla para continuar: ")

 ).

gerenciaBot2(Pilha,Deck1,Deck2,Deck3,Topo,Vez,Reversed):-
  write("Vez de DILMÃE\n"), write("Topo: "), showCard(Topo),
  write("Sua mão: "),nl,
  showDeck(Deck3,0,0,Topo),nl,
  podeJogar(Deck3,Topo,Retorno),
  (Retorno == 1 -> % Se tiver carta válida, pede pra o player escolher a carta desejada
    write("Escolha sua carta "),
    read(Input),
    encontraCarta(Input,Deck3,Carta),
    match(Topo,Carta,Saida),
    (Saida == 1 -> % Se a carta der match then...
      removeind(Input,Deck3,DeckAtt), efeito(Carta,Efeito),
      (Reversed == 0 ->
          (Efeito == 10 -> Prox is Vez-2, rodar(Pilha,Deck1,Deck2,DeckAtt,Carta,Prox,Reversed);
           Efeito == 6 -> Prox is Vez-1, rodar(Pilha,Deck1,Deck2,DeckAtt,Carta,Prox,Reversed);
           Efeito == 3 -> Prox is Vez-1, rodar(Pilha,Deck1,Deck2,DeckAtt,Carta,Prox,1);
           Efeito == 2 -> Prox is Vez-2, getCards(Pilha, 2, CartasAdd), remCards(Pilha, 2, PilhaAtt), conc(Deck1, CartasAdd, Deck1Att),
           rodar(PilhaAtt, Deck1Att, Deck2, DeckAtt, Carta, Prox, Reversed)
           );

        (Efeito == 10 -> Prox is Vez-1, rodar(Pilha,Deck1,Deck2,DeckAtt,Carta,Prox,Reversed);
         Efeito == 6 -> Prox is Vez-2, rodar(Pilha,Deck1,Deck2,DeckAtt,Carta,Prox,Reversed);
         Efeito == 3 -> Prox is Vez-2, rodar(Pilha,Deck1,Deck2,DeckAtt,Carta,Prox,0);
         Efeito == 2 -> Prox is Vez-1, getCards(Pilha, 2, CartasAdd), remCards(Pilha, 2, PilhaAtt), conc(Deck2, CartasAdd, Deck2Att),
         rodar(PilhaAtt, Deck1, Deck2Att, DeckAtt, Carta, Prox, Reversed)
         )
      ) ; % Se não der, pede pra tentar outra...
      Prox is Vez,
      write("Tente outra carta"),nl,
      gerenciaBot2(Pilha,Deck1,Deck2,Deck3,Topo,Prox,Reversed)
    ),
    rodar(Pilha,Deck1,Deck2,Deck3,Carta,Prox,Reversed)
  ; % Se chegou aqui, o player não possui carta válida
  write("Você não possui carta válida para esta rodada!!")

  ).
