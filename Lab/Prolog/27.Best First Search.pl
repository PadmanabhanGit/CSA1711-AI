% 1. The Graph (directed edges)
edge(a, b).
edge(a, c).
edge(b, d).
edge(b, e).
edge(c, f).
edge(f, g).
edge(e, g).

% 2. Heuristic Estimates to Target 'g'
heuristic(a, 6).
heuristic(b, 4).
heuristic(c, 5).
heuristic(d, 4).
heuristic(e, 1). 
heuristic(f, 2).
heuristic(g, 0). 

% 3. Top-Level Wrapper
best_first(Start, Goal, Path) :-
    heuristic(Start, H),
    % Format initial state as a Key-Value pair: Heuristic-[Path]
    best_first_queue([H-[Start]], Goal, ReversePath),
    reverse(ReversePath, Path).

% 4. Base Case: The most promising path reaches the Goal
best_first_queue([_- [Goal|Path]|_], Goal, [Goal|Path]).

% 5. Recursive Step: Expand best path and re-sort queue
best_first_queue([_- [Node|Path]|RestQueue], Goal, FinalPath) :-
    % Generate all valid next steps as Key-Value pairs: NextH-[Next, Node|Path]
    findall(NextH-[Next, Node|Path],
            (edge(Node, Next), 
             \+ member(Next, [Node|Path]), % Cycle detection
             heuristic(Next, NextH)), 
            NewPaths),
    % Combine old and new paths
    append(RestQueue, NewPaths, CombinedQueue),
    % keysort/2 now successfully sorts by the 'Key' (the heuristic number)
    keysort(CombinedQueue, SortedQueue),
    % Continue searching with the best option at the front
    best_first_queue(SortedQueue, Goal, FinalPath).
