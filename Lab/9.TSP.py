import itertools

# Setting up the row arrays manually to prevent syntax rendering bugs
row0 = [0, 10, 15, 20]
row1 = [10, 0, 35, 25]
row2 = [15, 35, 0, 30]
row3 = [20, 25, 30, 0]

# Combining rows into a clean 2D distance matrix
distance_matrix = [row0, row1, row2, row3]

def tsp_brute_force(matrix):
    n = len(matrix)
    cities = list(range(n))
    min_path = None
    min_cost = float('inf')
    
    start_city = cities[0]
    other_cities = cities[1:]
    
    for perm in itertools.permutations(other_cities):
        current_path = [start_city] + list(perm) + [start_city]
        current_cost = 0
        
        for i in range(len(current_path) - 1):
            current_cost += matrix[current_path[i]][current_path[i+1]]
            
        if current_cost < min_cost:
            min_cost = current_cost
            min_path = current_path
            
    return min_path, min_cost

def tsp_nearest_neighbor(matrix, start_node=0):
    n = len(matrix)
    visited = [False] * n
    path = [start_node]
    visited[start_node] = True
    total_cost = 0
    
    current = start_node
    for _ in range(n - 1):
        next_city = None
        min_dist = float('inf')
        
        for neighbor in range(n):
            if not visited[neighbor] and matrix[current][neighbor] < min_dist:
                min_dist = matrix[current][neighbor]
                next_city = neighbor
                
        visited[next_city] = True
        path.append(next_city)
        total_cost += min_dist
        current = next_city
        
    total_cost += matrix[current][start_node]
    path.append(start_node)
    
    return path, total_cost

# Execute both approaches
bf_path, bf_cost = tsp_brute_force(distance_matrix)
nn_path, nn_cost = tsp_nearest_neighbor(distance_matrix)

print(f"Brute Force Optimal Path: {bf_path} with cost: {bf_cost}")
print(f"Nearest Neighbor Path:   {nn_path} with cost: {nn_cost}")
