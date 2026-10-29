% 1. Knowledge Base (Facts)
fruit_color(apple, red).
fruit_color(apple, green).
fruit_color(banana, yellow).
fruit_color(grape, purple).
fruit_color(grape, green).
fruit_color(strawberry, red).

% 2. Rule to find fruits of a specific color
is_color(Fruit, Color) :- 
    fruit_color(Fruit, Color).
