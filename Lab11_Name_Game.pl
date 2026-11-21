:- dynamic letters/1.

letters([a,b,c]).

name_game :-
    writeln('Hi. This is the "Name Game"'),
    writeln('You will be given a set of English letters in which you will add, delete or move to create your name.'),
    game_menu.

game_menu :-
    nl,
    writeln('Choose from the following:'),
    writeln('1- Display the current set of letters'),
    writeln('2- Add a letter'),
    writeln('3- Add a letter at the top'),
    writeln('4- Add a letter at the bottom'),
    writeln('5- Delete a letter'),
    writeln('6- Delete all letters'),
    writeln('7- Exit'),
    write('Enter your choice: '),
    read(Choice),
    game_choice(Choice).

game_choice(1) :-
    letters(List),
    write(List), nl,
    game_menu.

game_choice(2) :-
    write('Enter a letter: '),
    read(Letter),
    letters(List),
    length(List, Length),
    Max is Length + 1,
    format('Enter position (1-~w): ', [Max]),
    read(Position),
    insert_at(Letter, Position, List, NewList),
    retractall(letters(_)),
    assertz(letters(NewList)),
    game_menu.

game_choice(3) :-
    write('Enter a letter: '),
    read(Letter),
    letters(List),
    NewList = [Letter|List],
    retractall(letters(_)),
    assertz(letters(NewList)),
    game_menu.

game_choice(4) :-
    write('Enter a letter: '),
    read(Letter),
    letters(List),
    append(List, [Letter], NewList),
    retractall(letters(_)),
    assertz(letters(NewList)),
    game_menu.

game_choice(5) :-
    write('Enter a letter to delete: '),
    read(Letter),
    letters(List),
    (   select(Letter, List, NewList)
    ->  retractall(letters(_)),
        assertz(letters(NewList))
    ;   writeln('Letter not found.')
    ),
    game_menu.

game_choice(6) :-
    retractall(letters(_)),
    assertz(letters([])),
    game_menu.

game_choice(7) :-
    writeln('Goodbye!').

game_choice(_) :-
    writeln('Invalid choice.'),
    game_menu.

insert_at(X, 1, List, [X|List]).
insert_at(X, Position, [Head|Tail], [Head|Result]) :-
    Position > 1,
    NextPosition is Position - 1,
    insert_at(X, NextPosition, Tail, Result).
