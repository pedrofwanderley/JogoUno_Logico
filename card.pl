check_card(amarela,  amarela).
check_card(verde, verde).
check_card(azul, azul).
check_card(vermelha, vermelha).
check(X,Y):- check_card(X,Y).
check(X,Y):- check_card(Y,X).
