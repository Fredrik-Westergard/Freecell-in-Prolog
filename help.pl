helptext :-
  nl,write('Rules:'),nl,nl,

  write('Freecell is a one-deck solitaire card game.'),nl,
  write('All cards are dealt into 8 tableau piles.'),nl,
  write('Four Cells and four stack piles are placed beside the tableau piles.'),nl,nl,

  write('The object of the game is to build up all cards on stacks from'),nl,
  write('Ace to King by following suit. You win when all 52 cards are moved there,'),nl,
  write('13 to a pile.'),nl,nl,

  write('Top cards of tableau piles and cards from hold are available to play.'),nl,
  write('You can build tableau piles down by alternating color.'),nl,
  write('Only one card at a time can be moved.'),nl,
  write('The top card of any tableau pile can also be moved to any hold cell.'),nl,
  write('Each hold cell (or Reserve space) may contain only one card.'),nl,
  write('Cards in the hold cells can be moved to the foundation piles or back'),nl,
  write('to the tableau piles, if possible.'),nl,nl,nl,

%https://www.freecell-solitaire-download.com/rules.html

  write('Controls:'),nl,nl,

  write('To move a card to another card type firstcard_secondcard like so: h1_s2'),nl,
  write('This moves ace of hearts to 2 of spades.'),nl,
  write('To move a card to the stacks type card_stacknumber like so: h1_S0'),nl,
  write('This moves ace of hearts to the first stack'),nl,
  write('To move a card to hold type card_holdnumber like so: h1_H0'),nl,
  write('This moves ace of hearts to the first hold cell'),nl,
  write('The hold cells and stacks each have 4 slots, numbered 0-3'),nl,
  write('To move a card to an empty tableau type card_EM like so: h1_EM'),nl,
  write('To undo a move type un_do'),nl,
  write('To end the game type endgame and the game will end'),nl,nl,nl,

  write('Type any letter to continue'),nl,
  read(_).
