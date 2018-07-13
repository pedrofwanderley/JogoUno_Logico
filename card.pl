colour(amarela).
colour(verde).
colour(azul).
colour(vermelha).

number( 2).
number( 3).
number( 4).
number( 5).
number( 6).
number( 7).
number( 8).
number( 9).

card(Colour,Number):-
        colour(Colour), number(Number).




check_card(amarela,  amarela).
check_card(verde, verde).
check_card(azul, azul).
check_card(vermelha, vermelha).
check(X,Y):- check_card(X,Y).
check(X,Y):- check_card(Y,X).
