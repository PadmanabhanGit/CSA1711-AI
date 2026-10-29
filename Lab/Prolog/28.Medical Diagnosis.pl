% =================================================================
% 1. TOP-LEVEL INTERFACE
% =================================================================
diagnose :-
    clear_stored_symptoms,                      
    hypothesis(Disease),                        
    format('~n*** Diagnosis Conclusion ***~n'),
    format('The patient is likely suffering from: ~w~n', [Disease]), !.

diagnose :-
    format('~n*** Diagnosis Conclusion ***~n'),
    writeln('Sorry, unable to diagnose the disease based on the symptoms provided.').

% =================================================================
% 2. KNOWLEDGE BASE
% =================================================================
hypothesis(cold) :-
    symptom(fever),
    symptom(cough),
    symptom(runny_nose).

hypothesis(flu) :-
    symptom(high_fever),
    symptom(body_ache),
    symptom(chills),
    symptom(cough).

hypothesis(typhoid) :-
    symptom(high_fever),
    symptom(headache),
    symptom(abdominal_pain),
    symptom(diarrhea).

hypothesis(malaria) :-
    symptom(high_fever),
    symptom(chills),
    symptom(sweating),
    symptom(headache).

% =================================================================
% 3. INTERACTIVE SYMPTOM CHECKING & MEMORY (FIXED FOR USER INPUT)
% =================================================================
:- dynamic yes/1.
:- dynamic no/1.

symptom(S) :- yes(S), !.                 
symptom(S) :- no(S), !, fail.            
symptom(S) :- ask_user(S).               

ask_user(S) :-
    format('Does the patient have ~w? (y/n): ', [S]),
    get_single_char(CharCode),          % Reads just 1 keypress instantly
    char_code(Char, CharCode),          % Converts the key code back to a character
    nl,                                 % Prints a new line for clean formatting
    process_reply(S, Char).

% Process the character pressed by the user
process_reply(S, y) :- !, store_answer(S, y).
process_reply(S, n) :- !, store_answer(S, n).
process_reply(S, _) :-                 % If they press anything else, ask again safely
    writeln('Invalid input! Please press exactly "y" or "n".'),
    ask_user(S).

store_answer(S, y) :- assertz(yes(S)).   
store_answer(S, n) :- assertz(no(S)), fail. 

clear_stored_symptoms :-
    retractall(yes(_)),
    retractall(no(_)).
