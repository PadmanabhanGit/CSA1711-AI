% =================================================================
% 1. THE KNOWLEDGE BASE (Facts & Rules)
% =================================================================

% Initial Facts (Base Truths)
fact(mammal).
fact(has_stripes).
fact(gives_milk).

% Rules (If the right side is true, the left side can be proven)
tiger :- 
    fact(mammal), 
    fact(has_stripes).

cow :- 
    fact(mammal), 
    fact(gives_milk).

% =================================================================
% 2. THE PROOF ENGINE (Making Backward Chaining Visible)
% =================================================================

% Top-level goal to verify a hypothesis
% prove(+Hypothesis)
prove(Hypothesis) :-
    format('Target Goal: Testing hypothesis [~w]...~n', [Hypothesis]),
    backward_chain(Hypothesis),
    format('Conclusion: Hypothesis [~w] is TRUE.~n', [Hypothesis]), !.

prove(Hypothesis) :-
    format('Conclusion: Hypothesis [~w] cannot be proven (FALSE).~n', [Hypothesis]).

% Case 1: The hypothesis is already a known base fact
backward_chain(Fact) :-
    fact(Fact),
    format(' -> Match found: "~w" is an established fact.~n', [Fact]).

% Case 2: The hypothesis is a rule. Find its conditions and test them backward.
backward_chain(Rule) :-
    \+ fact(Rule),                      % Ensure it's not a primitive fact
    clause(Rule, Conditions),          % Built-in: extracts the body/conditions of a rule
    format(' -> Moving backward: To prove "~w", checking conditions: [~w]~n', [Rule, Conditions]),
    verify_conditions(Conditions).     % Evaluate those conditions

% Helper to step through conditions linked by commas safely
verify_conditions(true) :- !.          % No conditions left to check
verify_conditions((Cond1, Cond2)) :-    % If conditions are joined by a comma (AND)
    !,
    backward_chain(Cond1),
    verify_conditions(Cond2).
verify_conditions(SingleCond) :-       % If there is only one condition left
    backward_chain(SingleCond).
