def dfs(graph, node, visited=None):
    if visited is None:
        visited = set()
    
    visited.add(node)
    traversal_order = [node]
    
    # Visit all unvisited neighbors recursively
    for neighbor in graph[node]:
        if neighbor not in visited:
            traversal_order.extend(dfs(graph, neighbor, visited))
            
    return traversal_order

#graph representation (Adjacency List)
graph = {
    'A': ['B', 'C'],
    'B': ['A', 'D', 'E'],
    'C': ['A', 'F'],
    'D': ['B'],
    'E': ['B', 'F'],
    'F': ['C', 'E']
}

print("DFS Traversal Order:", dfs(graph, 'A'))
