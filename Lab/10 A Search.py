import heapq

# Define graph structure using simple key additions to prevent formatting dropouts
graph = {}
graph['A'] = [('B', 1), ('C', 4)]
graph['B'] = [('A', 1), ('C', 2), ('D', 5)]
graph['C'] = [('A', 4), ('B', 2), ('D', 1)]
graph['D'] = [('B', 5), ('C', 1)]

# Straight-line distance estimates to goal 'D'
heuristics = {}
heuristics['A'] = 3
heuristics['B'] = 2
heuristics['C'] = 1
heuristics['D'] = 0

def a_star_search(adj_graph, start, goal, h_map):
    # Priority queue stores tuples: (f_score, current_node, path_list, g_score)
    priority_queue = []
    initial_f = 0 + h_map[start]
    heapq.heappush(priority_queue, (initial_f, start, [start], 0))
    
    visited = set()
    
    while priority_queue:
        f, current, path, g = heapq.heappop(priority_queue)
        
        if current == goal:
            return path, g
            
        if current in visited:
            continue
        visited.add(current)
        
        for neighbor, weight in adj_graph.get(current, []):
            if neighbor not in visited:
                new_g = g + weight
                new_f = new_g + h_map[neighbor]
                heapq.heappush(priority_queue, (new_f, neighbor, path + [neighbor], new_g))
                
    return None, float('inf')

# Execute search
shortest_path, total_cost = a_star_search(graph, 'A', 'D', heuristics)
print(f"Shortest Path: {shortest_path} with total cost: {total_cost}")
