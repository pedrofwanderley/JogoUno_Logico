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
        
deck([(2,amarela),(3,amarela),(4,amarela),
      (5,amarela),(6,amarela),(7,amarela),(8,amarela),
      (9,amarela),
      (2,verde),(3,verde),(4,verde),
      (5,verde),(6,verde),(7,verde),(8,verde),
      (9,verde),
      (2,azul),(3,azul),(4,azul),
      (5,azul),(6,azul),(7,azul),(8,azul),
      (9,azul),
      (2,vermelha),(3,vermelha),(4,vermelha),
      (5,vermelha),(6,vermelha),(7,vermelha),(8,vermelha),
      (9,vermelha)]).




check_card(amarela,  amarela).
check_card(verde, verde).
check_card(azul, azul).
check_card(vermelha, vermelha).
check(X,Y):- check_card(X,Y).
check(X,Y):- check_card(Y,X).
