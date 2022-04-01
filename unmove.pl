savemove(X) :-
  unmove([W|Tail]),
  retract(unmove([W|Tail])),
  card(X,Y,Z),
  !,
  assert(unmove([[X,Y,Z],W|Tail])),
  tell('unmoves.pl'),
  listing(unmove),
  told.


undo:-
  unmove([[[X,A],Y,Z]|Tail]),
  card([X,A],W,_),
  W = 'S',
  findnum(A,B),
  B = '0',
  unmove([[[X,A],Y,Z]|Tail]),
  retract(unmove(_)),
  retract(card([X,A],_,_)),
  assert(unmove(Tail)),
  assert(card([X,A],Y,Z)),
  tell('unmoves.pl'),
  listing(unmove),
  told,
  tell('facts.pl'),
  listing(cards),
  listing(card),
  told,
  !;
  card([X,A],W,V),
  W = 'S',
  findnum(A,B),
  assert(card([X,B],W,V)),
  unmove([[[X,A],Y,Z]|Tail]),
  retract(unmove(_)),
  retract(card([X,A],_,_)),
  assert(unmove(Tail)),
  assert(card([X,A],Y,Z)),
  tell('unmoves.pl'),
  listing(unmove),
  told,
  tell('facts.pl'),
  listing(cards),
  listing(card),
  told,
  !.


undo :-
  unmove([[X,Y,Z]|Tail]),
  retract(unmove(_)),
  retract(card(X,_,_)),
  assert(unmove(Tail)),
  assert(card(X,Y,Z)),
  tell('unmoves.pl'),
  listing(unmove),
  told,
  tell('facts.pl'),
  listing(cards),
  listing(card),
  told.


findnum(X,Y) :-
  X = '1';
  member(X,['2','3','4','5','6','7','8','9']),
  char_code(X,W),
  V is W-1,
  char_code(Y, V);
  X = 'x',
  char_code(Y, 57);
  X = 'j',
  char_code(Y, 120);
  X = 'q',
  char_code(Y, 106);
  X = 'k',
  char_code(Y, 113).
