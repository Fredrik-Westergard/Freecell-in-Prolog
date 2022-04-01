:- reconsult('facts.pl').
:- reconsult('pre.pl').
:- reconsult('move.pl').
:- reconsult('unmove.pl').
:- reconsult('unmoves.pl').
:- reconsult('help.pl').

freecell :-
  write('Welcome to Freecell'),nl,nl,
  write('1. Play game.'),nl,
  write('2. How to play'),nl,
  write('3. Exit.'),nl,nl,
  read(X),
  choose(X).

choose(1) :-
  startgame,
  !.

choose(2) :-
  helptext,
  freecell,
  !.

choose(3) :-
  !.

choose(_) :-
  freecell.


startgame :-
  resetunm,
  scramble(0), %0 is regular, 1 is debug
  addtof,
  printfield,
  write('make your move...'),nl,
  read(X),

  translate(X,Y,Z),

  loop(Y,Z).

loop([e,n],[g,a]) :-
 write('game over'),nl,
 !.

loop([u,n],[d,o]) :-
  undo,
  printfield,
  write('make your move...'),nl,
  read(W),
  translate(W,Z,V),
  checkwin(Z,V),
  !.

loop(X,Y) :-
  move(X,Y),
  printfield,
  write('make your move...'),nl,
  read(W),
  translate(W,Z,V),
  checkwin(Z,V),
  !.

translate(X,Z,W) :-
  string_to_list(X,Y),
  pickc(Y,Z,W).

pickc([A,B,_,C,D|_],[E,F],[G,H]) :-
  char_code(E, A),
  char_code(F, B),
  char_code(G, C),
  char_code(H, D).

checkwin(Z,V) :-
  findall(X,card(_,_,X),Y),
  length(Y,5),
  write('Congratulations, You Won!'),nl,
  !;
  loop(Z,V).
