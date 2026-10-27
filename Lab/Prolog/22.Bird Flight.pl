% Facts: Define types of birds
bird(sparrow).
bird(pigeon).
bird(eagle).
bird(ostrich).
bird(penguin).

% Facts: Define birds that cannot fly
cannot_fly(ostrich).
cannot_fly(penguin).

% Rule: A bird can fly if it is a bird and is not in the cannot_fly list
can_fly(X) :-
    bird(X),
    \+ cannot_fly(X).

% Predicate to cleanly print the result
check_fly(X) :-
    can_fly(X),
    write(X), write(' can fly.'), nl.
check_fly(X) :-
    bird(X),
    cannot_fly(X),
    write(X), write(' cannot fly.'), nl.
check_fly(X) :-
    \+ bird(X),
    write(X), write(' is not even a bird!'), nl.
