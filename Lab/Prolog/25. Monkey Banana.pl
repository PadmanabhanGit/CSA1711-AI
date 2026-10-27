% state(MonkeyPosition, BoxPosition, MonkeyOnBoxOrFloor, HasBanana)

% Legal moves changing the state:

% 1. Grasp the banana (Must be at the middle, on the box, and not have it yet)
move(state(middle, middle, onbox, hasnot),
     grasp,
     state(middle, middle, onbox, has)).

% 2. Climb onto the box (Must be at the same position as the box, and on the floor)
move(state(P, P, onfloor, hasnot),
     climb,
     state(P, P, onbox, hasnot)).

% 3. Push the box from Position P1 to P2
move(state(P1, P1, onfloor, hasnot),
     push(P1, P2),
     state(P2, P2, onfloor, hasnot)).

% 4. Walk from Position P1 to P2
move(state(P1, Pbox, onfloor, hasnot),
     walk(P1, P2),
     state(P2, Pbox, onfloor, hasnot)).

% Recursive pathfinder to reach the goal state
canget(state(_, _, _, has), []). % Base case: Already has the banana

canget(State1, [Action | Actions]) :-
    move(State1, Action, State2),
    canget(State2, Actions).
