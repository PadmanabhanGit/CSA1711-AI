% Facts: Genders
male(john).
male(bob).
male(mike).
female(mary).
female(lisa).

% Facts: Parents (parent(Parent, Child))
parent(john, bob).
parent(mary, bob).
parent(john, lisa).
parent(mary, lisa).
parent(bob, mike).

% Rules for Relationships
sibling(X, Y) :-
    parent(P, X),
    parent(P, Y),
    X \= Y.

grandparent(G, C) :-
    parent(G, P),
    parent(P, C).

father(F, C) :-
    male(F),
    parent(F, C).

mother(M, C) :-
    female(M),
    parent(M, C).
