face(s,[h,d]).
face(c,[h,d]).
face(h,[c,s]).
face(d,[c,s]).

move(X,Y) :-
  whatmove(X),
  whatmove2(Y),
  wheremove(Y,Z,X),
  Z \= [e,r],
  savemove(X),
  movecard(X,Z),
  !;
  write('illegal move'),nl.

whatmove(X) :-
  \+card(X,'S',_),
  card(X,_,_).

whatmove2(X) :-
  card(X,_,_);
  X = ['H','0'];
  X = ['H','1'];
  X = ['H','2'];
  X = ['H','3'];
  X = ['S','0'];
  X = ['S','1'];
  X = ['S','2'];
  X = ['S','3'];
  X = ['E','M'].

wheremove([X,Y],[Z,W],[A,B]) :-
  card([X,Y],Z,V),
  face(A,C),
  member(X,C),
  checknumber(B,Y,_),
  checkopen([A,B]),
  checkopen([X,Y]),
  W is V + 1;
  chother([X,Y],[Z,W],[A,B]).

chother([X,Y],[Z,W],[A,B]) :-
  X = 'E',
  Y = 'M',
  findempty(Z,W,0),
  checkopen([A,B]),
  !;
  X = 'H',
  Y = '0',
  V is 0,
  \+card(_,X,V),
  char_code(Z, 72),
  W is 0,
  checkopen([A,B]);
  X = 'H',
  Y = '1',
  V is 1,
  \+card(_,X,V),
  char_code(Z, 72),
  W is 1,
  checkopen([A,B]);
  X = 'H',
  Y = '2',
  V is 2,
  \+card(_,X,V),
  char_code(Z, 72),
  W is 2,
  checkopen([A,B]);
  X = 'H',
  Y = '3',
  V is 3,
  \+card(_,X,V),
  char_code(Z, 72),
  W is 3,
  checkopen([A,B]);
  X = 'S',
  Y = '0',
  chcard([A,B],X,Y),
  char_code(Z, 83),
  W is 0,
  checkopen([A,B]);
  X = 'S',
  Y = '1',
  chcard([A,B],X,Y),
  char_code(Z, 83),
  W is 1,
  checkopen([A,B]);
  X = 'S',
  Y = '2',
  chcard([A,B],X,Y),
  char_code(Z, 83),
  W is 2,
  checkopen([A,B]);
  X = 'S',
  Y = '3',
  chcard([A,B],X,Y),
  char_code(Z, 83),
  W is 3,
  checkopen([A,B]);
  X = 'S',
  Y = '0',
  card([A,B],C,_),
  !,
  C = 'H',
  char_code(Z, 83),
  W is 0;
  X = 'S',
  Y = '1',
  card([A,B],C,_),
  !,
  C = 'H',
  char_code(Z, 83),
  W is 1;
  X = 'S',
  Y = '2',
  card([A,B],C,_),
  !,
  C = 'H',
  char_code(Z, 83),
  W is 2;
  X = 'S',
  Y = '3',
  card([A,B],C,_),
  !,
  C = 'H',
  char_code(Z, 83),
  W is 3;
  checkopen([X,Y]),
  card([A,B],C,_),
  !,
  C = 'H',
  card([X,Y],Z,V),
  W is V + 1.

chcard([_,B],X,Y) :-
  char_code(Y,Z),
  V is Z - 48,
  \+card(_,X,V),
  B = '1',
  !.

chcard([A,B],X,Y) :-
  char_code(Y,Z),
  V is Z - 48,
  card([C,D],X,V),
  A = C,
  char_code(B,E),
  char_code(D,F),
  G is F + 1,
  E = G,
  retract(card([C,D],X,V)),
  !.

chcard([A,B],X,Y) :-
  char_code(Y,Z),
  V is Z - 48,
  card([C,D],X,V),
  A = C,
  checknumber(B,D,X),
  retract(card([C,D],X,V));
  char_code(Y,Z),
  V is Z - 48,
  card([C,D],X,V),
  A = C,
  checknumber(B,D,X),
  retract(card([C,D],X,V));
  char_code(Y,Z),
  V is Z - 48,
  card([C,D],X,V),
  A = C,
  checknumber(B,D,X),
  retract(card([C,D],X,V));
  char_code(Y,Z),
  V is Z - 48,
  card([C,D],X,V),
  A = C,
  checknumber(B,D,X),
  retract(card([C,D],X,V)).

findempty(X,Y,8) :-
  char_code(X, 101),
  char_code(Y, 114).

findempty(X,Y,Z) :-
  \+card(_,Z,0),
  X is Z,
  Y is 0;
  W is Z + 1,
  findempty(X,Y,W),
  !.

checknumber(X,Y,Z) :-
  X = '9',
  Y = 'x';
  X = 'x',
  Y = 'j';
  X = 'j',
  Y = 'q';
  X = 'q',
  Y = 'k';
  X \= 'j',
  Y \= 'k',
  char_code(X,A),
  char_code(Y,B),
  C is A + 1,
  B = C;
  Z = 'S',
  checkS(X,Y),
  !.

checkS(X,Y) :-
  X = 'x',
  Y = '9';
  X = 'j',
  Y = 'x';
  X = 'q',
  Y = 'j';
  X = 'k',
  Y = 'q';
  X \= 'j',
  Y \= 'k'.

checkopen([X,B]):-
  X = 'E',
  !;
  X = 'H',
  !;
  X = 'S',
  !;
  card([X,B],Z,Y),
  W is Y + 1,
  \+card(_,Z,W).


movecard(X,[Y,Z]) :-
  Y = 'E',
  Z = 'M',
  findempty(A,B,0),
  card(X,W,V),
  retract(card(X,W,V)),
  assert(card(X,A,B)),
  tell('facts.pl'),
  listing(cards),
  listing(card),
  told,
  !;
  card(X,W,V),
  retract(card(X,W,V)),
  assert(card(X,Y,Z)),
  tell('facts.pl'),
  listing(cards),
  listing(card),
  told.
