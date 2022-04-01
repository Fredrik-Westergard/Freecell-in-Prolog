
highest(X,Y) :-
  card(_,_,X),
  Z is X + 1,
  highest(Z,Y),
  !.

highest(Y,Y).

gethigh(Y) :-
  highest(0,X),
  X >= 4,
  Y is X,
  !;
  Y is 4.

printfield :-
  write("+----+-------------------------+----+"),nl,
  gethigh(X),
  Y is X + 1,
  spaceY(0,Y),
  write("     +-------------------------+"),nl.

spaceY(Y,Y).

spaceY(0,Y) :-
  printhold(0),
  spaceX(0,0),
  spaceY(1,Y),
  !.

spaceY(Y,X) :-
  printhold(Y),
  spaceX(0,Y),
  W is Y + 1,
  spaceY(W,X),
  !.

spaceX(8,Y) :-
 printstack(Y),nl,
 !.

spaceX(X,Y) :-
  card([C,T],X,Y),
  pcolor([C,T]),
  write(' '),
  W is X + 1,
  spaceX(W,Y);
  write('   '),
  W is X + 1,
  spaceX(W,Y).

printhold(4) :-
  write('+----| '),
  !.

printhold(Y) :-
  Y >= 4,
  write('     | '),
  !.

printhold(Y) :-
  card([C,T],'H',Y),
  write('| '),
  pcolor([C,T]),
  write(' | ');
  write('|    | ').

printstack(4) :-
  write('|----+'),
  !.

printstack(Y) :-
  Y >= 4,
  write('|'),
  !.

printstack(Y) :-
  card([C,T],'S',Y),
  write('| '),
  pcolor([C,T]),
  write(' | ');
  write('|    | ').

scramble(0) :-
  random_permutation([[s,'1'],[s,'2'],[s,'3'],[s,'4'],[s,'5'],[s,'6'],[s,'7'],[s,'8'],[s,'9'],[s,x],[s,j],[s,q],[s,k],
                      [c,'1'],[c,'2'],[c,'3'],[c,'4'],[c,'5'],[c,'6'],[c,'7'],[c,'8'],[c,'9'],[c,x],[c,j],[c,q],[c,k],
                      [h,'1'],[h,'2'],[h,'3'],[h,'4'],[h,'5'],[h,'6'],[h,'7'],[h,'8'],[h,'9'],[h,x],[h,j],[h,q],[h,k],
                      [d,'1'],[d,'2'],[d,'3'],[d,'4'],[d,'5'],[d,'6'],[d,'7'],[d,'8'],[d,'9'],[d,x],[d,j],[d,q],[d,k]],L),
  retract(cards(_)),
  assert(cards(L)),
  tell('facts.pl'),
  listing(cards),
  listing(card),
  told.

scramble(1) :-
  retract(cards(_)),
  assert(cards([[s,k],[s,q],[s,j],[s,x],[s,'9'],[s,'8'],[s,'7'],[s,'6'],[s,'5'],[s,'4'],[s,'3'],[s,'2'],[s,'1'],
                [c,k],[c,q],[c,j],[c,x],[c,'9'],[c,'8'],[c,'7'],[c,'6'],[c,'5'],[c,'4'],[c,'3'],[c,'2'],[c,'1'],
                [h,k],[h,q],[h,j],[h,x],[h,'9'],[h,'8'],[h,'7'],[h,'6'],[h,'5'],[h,'4'],[h,'3'],[h,'2'],[h,'1'],
                [d,k],[d,q],[d,j],[d,x],[d,'9'],[d,'8'],[d,'7'],[d,'6'],[d,'5'],[d,'4'],[d,'3'],[d,'2'],[d,'1']])),
  tell('facts.pl'),
  listing(cards),
  listing(card),
  told.

addtof :-
  cards(X),
  retractall(card(_,_,_)),
  add(X,0,0),
  tell('facts.pl'),
  listing(cards),
  listing(card),
  told.

add([],_,_).

add(C,8,Y) :-
  W is 0,
  V is Y + 1,
  add(C,W,V),
  !.

add([C|Tail],X,Y) :-
  assert(card(C,X,Y)),
  W is X + 1,
  add(Tail,W,Y).

pcolor([C,T]) :-
  member(C,[h,d]),
  ansi_format([bold,fg(white),bg(red)], C, []),
  ansi_format([bold,fg(white),bg(red)], T, []);
  member(C,[c,s]),
  ansi_format([bold,fg(black),bg(white)], C, []),
  ansi_format([bold,fg(black),bg(white)], T, []).

resetunm :-
  retract(unmove(_)),
  assert(unmove([0])),
  tell('unmoves.pl'),
  listing(unmove),
  told.
