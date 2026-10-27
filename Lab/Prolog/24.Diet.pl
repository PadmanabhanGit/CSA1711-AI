% diet_advice(Disease, Recommendation)

diet_advice(diabetes, 'Low sugar, high fiber, whole grains, and lean proteins. Limit carbohydrates.').
diet_advice(hypertension, 'Low sodium (DASH diet), rich in potassium, magnesium, and leafy greens.').
diet_advice(celiac, 'Strictly gluten-free diet. Avoid wheat, barley, and rye.').
diet_advice(high_cholesterol, 'Low saturated fats, avoid trans fats, increase soluble fiber (oats, beans).').
diet_advice(healthy, 'Balanced diet with fruits, vegetables, whole grains, and regular hydration.').

% Query interface rule
suggest_diet(Patient, Disease) :-
    diet_advice(Disease, Advice),
    write('Patient: '), write(Patient), nl,
    write('Diagnosed with: '), write(Disease), nl,
    write('Recommended Diet: '), write(Advice), nl.
suggest_diet(Patient, Disease) :-
    \+ diet_advice(Disease, _),
    write('Sorry, no diet plan found for '), write(Disease), text('. Please consult a nutritionist.'), nl.
