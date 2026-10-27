def is_valid(state):
    m, c, boat = state
    if m < 0 or m > 3 or c < 0 or c > 3:
        return False
    if m > 0 and m < c:
        return False
    rm, rc = 3 - m, 3 - c
    if rm > 0 and rm < rc:
        return False
    return True

def solve_missionaries():
    initial = (3, 3, 1)
    goal = (0, 0, 0)
    queue = [[initial]]
    visited = set([initial])
    
    # Possible boat loads: (missionaries, cannibals)
    moves = [(1, 0), (2, 0), (0, 1), (0, 2), (1, 1)]
    
    while queue:
        path = queue.pop(0)
        current = path[-1]
        
        if current == goal:
            return path
        
        m, c, boat = current
        for dm, dc in moves:
            if boat == 1:
                nxt = (m - dm, c - dc, 0)
            else:
                nxt = (m + dm, c + dc, 1)
                
            if is_valid(nxt) and nxt not in visited:
                visited.add(nxt)
                queue.append(path + [nxt])
                
    return None

path = solve_missionaries()
if path:
    for i, state in enumerate(path):
        m, c, boat = state
        loc = "Left" if boat == 1 else "Right"
        print(f"Step {i}: Missionaries={m}, Cannibals={c}, Boat on {loc}")
