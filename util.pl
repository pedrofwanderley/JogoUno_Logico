:- module(util, [tela_principal/0,exibir_regras/0]).

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
