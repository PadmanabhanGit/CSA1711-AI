def print_board(board):
    for i in range(0, 9, 3):
        print(f"{board[i]} | {board[i+1]} | {board[i+2]}")
        if i < 6:
            print("--+---+--")
    print()

def check_winner(board, player):
    win_conditions = [
        (0, 1, 2), (3, 4, 5), (6, 7, 8),  # Rows
        (0, 3, 6), (1, 4, 7), (2, 5, 8),  # Columns
        (0, 4, 8), (2, 4, 6)             # Diagonals
    ]
    for a, b, c in win_conditions:
        if board[a] == board[b] == board[c] == player:
            return True
    return False

def is_full(board):
    return all(spot != ' ' for spot in board)

def minimax(board, depth, is_maximizing):
    if check_winner(board, 'O'):  # AI is 'O'
        return 10 - depth
    if check_winner(board, 'X'):  # Human is 'X'
        return depth - 10
    if is_full(board):
        return 0
    
    if is_maximizing:
        best_score = -float('inf')
        for i in range(9):
            if board[i] == ' ':
                board[i] = 'O'
                score = minimax(board, depth + 1, False)
                board[i] = ' '
                best_score = max(score, best_score)
        return best_score
    else:
        best_score = float('inf')
        for i in range(9):
            if board[i] == ' ':
                board[i] = 'X'
                score = minimax(board, depth + 1, True)
                board[i] = ' '
                best_score = min(score, best_score)
        return best_score

def best_move(board):
    best_score = -float('inf')
    move = -1
    for i in range(9):
        if board[i] == ' ':
            board[i] = 'O'
            score = minimax(board, 0, False)
            board[i] = ' '
            if score > best_score:
                best_score = score
                move = i
    return move

# Game Loop Simulation
board = [' '] * 9
print("Tic Tac Toe: You are X, AI is O. Enter positions 0-8.")
print_board(board)

while not check_winner(board, 'X') and not check_winner(board, 'O') and not is_full(board):
    # Human Move
    try:
        human_choice = int(input("Enter your move (0-8): "))
        if board[human_choice] == ' ':
            board[human_choice] = 'X'
        else:
            print("Spot taken, try again.")
            continue
    except (ValueError, IndexError):
        print("Invalid input. Choose a number between 0 and 8.")
        continue
        
    if check_winner(board, 'X') or is_full(board):
        break
        
    # AI Move
    ai_choice = best_move(board)
    board[ai_choice] = 'O'
    print(f"AI chose position {ai_choice}:")
    print_board(board)

print_board(board)
if check_winner(board, 'X'):
    print("You win!")
elif check_winner(board, 'O'):
    print("AI wins! (As expected, Minimax is unbeatable)")
else:
    print("It's a tie!")
