
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

% Qtd de cartas no deck
size([],0).
size([_|T],S):-size(T,G),S is 1+G.

% Verifica se a carta dá match com a do topo
match(Topo,Carta,S) :-
  encontraCarta(1,Topo,ColorTopo), encontraCarta(1,Carta,ColorCarta),
  encontraCarta(0,Topo,NumTopo), encontraCarta(0,Carta,NumCarta),
  encontraCarta(2,Topo,EffTopo), encontraCarta(2,Carta,EffCarta),
  ((ColorTopo == ColorCarta ; (NumCarta == NumTopo) ; ((EffTopo == EffCarta) , EffCarta \== "")) -> S is 1;
   S is 0
  ).




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
  Deck1 = [[3,"amarela",""],[3,"azul",""],[20,"verde","+2"]],
  Deck2 = [[3,"verde",""],[4,"amarela",""]],
  Deck3 = [[0,"amarela",""],[3,"azul",""]],
  novoJogo(PilhaShuffled,Deck1,Deck2,Deck3,[6,"azul","+2"],1,0).

novoJogo(Pilha,Deck1,Deck2,Deck3,Topo,Vez,Reversed):-
        write("\nIniciando o jogo: Você vs Lula vs Dilma... "),
        write("lets do this!!\n"),
        rodar(Pilha,Deck1,Deck2,Deck3,Topo,Vez,Reversed).

rodar(Pilha,Deck1,Deck2,Deck3,Topo,Vez,Reversed):-
  write("--------------------------------------------------------------\n"),
  size(Deck1,Size1),size(Deck2,Size2),size(Deck3,Size3),
    (Size1 == 0 -> write("VOCÊ VENCEU, PARABÉNS"),nl;
   Size2 == 0 -> write("LULA FOI SOLTO, VOCÊ PERDEU!!"),nl;
   Size3 == 0 -> write("DILMÃE VOLTOU À PRESIDÊNCIA, VOCÊ PERDEU!!"),nl
  );
  (Vez == 1 ->
    gerenciaPlayer(Pilha,Deck1,Deck2,Deck3,Topo,Vez,Reversed);
   Vez == 2 ->
     gerenciaBot1(Pilha,Deck1,Deck2,Deck3,Topo,Vez,Reversed);
   Vez == 3 ->
     gerenciaBot2(Pilha,Deck1,Deck2,Deck3,Topo,Vez,Reversed)
 ).

gerenciaPlayer(Pilha,Deck1,Deck2,Deck3,Topo,Vez,Reversed):-
  write("Topo: "), write(Topo),nl,
  write("Sua mão: "), write(Deck1),nl,
  write("Escolha sua carta: "),
  read(X),
  encontraCarta(X,Deck1,R),
  match(Topo,R,Saida),
  (Saida == 1 ->
    write("Ta no caminho certo"),nl,
    removeind(X,Deck1,Ret),
    Prox is Vez+1,
    rodar(Pilha,Ret,Deck2,Deck3,R,Prox,Reversed);
    Saida == 0 ->
    write("Tente outra carta"),nl,
    rodar(Pilha,Deck1,Deck2,Deck3,Topo,Vez,Reversed)
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

% Imprime a tela inicial do jogo
tela_principal():-
  write("\n                      UUUUUUUU     UUUUUUUUNNNNNNNN        NNNNNNNN     OOOOOOOOO
                      U::::::U     U::::::UN:::::::N       N::::::N   OO:::::::::OO
                      U::::::U     U::::::UN::::::::N      N::::::N OO:::::::::::::OO
                      UU:::::U     U:::::UUN:::::::::N     N::::::NO:::::::OOO:::::::O
                       U:::::U     U:::::U N::::::::::N    N::::::NO::::::O   O::::::O
                       U:::::D     D:::::U N:::::::::::N   N::::::NO:::::O     O:::::O
                       U:::::D     D:::::U N:::::::N::::N  N::::::NO:::::O     O:::::O
                       U:::::D     D:::::U N::::::N N::::N N::::::NO:::::O     O:::::O
                       U:::::D     D:::::U N::::::N  N::::N:::::::NO:::::O     O:::::O
                       U:::::D     D:::::U N::::::N   N:::::::::::NO:::::O     O:::::O
                       U:::::D     D:::::U N::::::N    N::::::::::NO:::::O     O:::::O
                       U::::::U   U::::::U N::::::N     N:::::::::NO::::::O   O::::::O
                       U:::::::UUU:::::::U N::::::N      N::::::::NO:::::::OOO:::::::O
                       UU:::::::::::::UU  N::::::N       N:::::::N OO:::::::::::::OO
                         UU:::::::::UU    N::::::N        N::::::N   OO:::::::::OO
                           UUUUUUUUU      NNNNNNNN         NNNNNNN     OOOOOOOOO


  *---------------------------------------------*
  |------ Seja bem-vindo(a) ao jogo UNO! -------|
  |--------Derrote ex presidentes do BR---------|
  |---------  e salve o Brasil  ----------------|
  |---------------------------------------------|
  |----------- Escolha uma opção: --------------|
  |---------------------------------------------|
  |---------------------------------------------|
  |---------------------------------------------|
  |----------- 1) START GAME -------------------|
  |----------- 2) Exibir Regras ----------------|
  |----------- 0) Quit Game --------------------|
  *---------------------------------------------*
"
  ).

% Exibe as regras do jogo
exibir_regras():-
  write("\n*--------------------------------------------------------------------------------------*
|                          REGRAS DO JOGO!
| 1) O jogo é 1x2, ou seja, um jogador contra 2 bots inteligentes;
| 2) São distribuidas 7 cartas aleatórias para cada jogador;
| 3) Cada jogador só pode jogar 1 carta por vez;
| 4) Caso o jogador não tenha uma carta válida para a jogada, uma nova carta
| será automaticamente puxada do deck e jogada, caso seja válida;
| 5) O jogo acaba quando não houver mais cartas no deck ou quando algum jogador zerar
| o número de cartas na mão;
| 6) Se não houver mais cartas no deck, ganha o jogador que tiver menos cartas!
|
|
|     		  ---  Aperte qualquer letra seguida de '.' para voltar ---
|
"
  ).
