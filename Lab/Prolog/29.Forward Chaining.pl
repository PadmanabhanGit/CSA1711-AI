% =================================================================
% 1. DYNAMIC DATA DECLARATIONS
% =================================================================
% These facts can change during runtime as we derive new data.
:- dynamic fact/1.

% =================================================================
% 2. THE KNOWLEDGE BASE (Rules and Initial Facts)
% =================================================================

% Initial known facts
init_facts :-
    assertz(fact(mammal)),
    assertz(fact(has_stripes)).

% Rules defined as structural patterns: rule(ConditionList, Result)
rule([mammal, has_stripes], tiger).
rule([mammal, gives_milk], cow).
rule([bird, cannot_fly, swims], penguin).

% =================================================================
% 3. THE FORWARD CHAINING ENGINE
% =================================================================

% Top-level goal to trigger the engine
forward_chain :-
    retractall(fact(_)),              % Clear any leftover facts from previous runs
    init_facts,                       % Load initial facts
    writeln('--- Starting Forward Chaining ---'),
    match_and_derive,                 % Begin the deduction loop
    writeln('--- Forward Chaining Complete ---'),
    print_all_derived_facts.

% Core deduction engine loop
match_and_derive :-
    rule(Conditions, Conclusion),     % 1. Find a rule in the knowledge base
    \+ fact(Conclusion),              % 2. Check that we haven't already derived this conclusion
    verify_conditions(Conditions),    % 3. Check if all conditions for the rule are met
    !,                                % 4. Cut to lock in this deduction path
    format('Derived new fact: ~w~n', [Conclusion]),
    assertz(fact(Conclusion)),        % 5. Add the new conclusion as a fact
    match_and_derive.                 % 6. Repeat the process with the expanded fact list

match_and_derive.                     % Base case: Stops when no new rules can be matched

% Helper to verify that every condition in a list exists as a known fact
verify_conditions([]).
verify_conditions([Cond|Rest]) :-
    fact(Cond),
    verify_conditions(Rest).

% Helper to output everything deduced
print_all_derived_facts :-
    writeln('Final Fact Database:'),
    forall(fact(X), format(' - ~w~n', [X])).
