# Define the regions (variables) and their neighbors (graph edges)
regions = ['RegionA', 'RegionB', 'RegionC', 'RegionD']

neighbors = {
    'RegionA': ['RegionB', 'RegionC'],
    'RegionB': ['RegionA', 'RegionC', 'RegionD'],
    'RegionC': ['RegionA', 'RegionB', 'RegionD'],
    'RegionD': ['RegionB', 'RegionC']
}

# Define the available colors (domain)
colors = ['Red', 'Green', 'Blue']

def is_valid(region, color, assignment, neighbors):
    # Check if any neighbor already has this color assigned
    for neighbor in neighbors[region]:
        if neighbor in assignment and assignment[neighbor] == color:
            return False
    return True

def solve_map_coloring(regions, colors, neighbors, assignment={}):
    # If all regions are assigned a color, return the solution
    if len(assignment) == len(regions):
        return assignment
    
    # Select the next unassigned region
    unassigned = [r for r in regions if r not in assignment]
    current_region = unassigned[0]
    
    # Try each color in the domain
    for color in colors:
        if is_valid(current_region, color, assignment, neighbors):
            assignment[current_region] = color
            
            # Recurse to color the rest of the map
            result = solve_map_coloring(regions, colors, neighbors, assignment)
            if result:
                return result
                
            # Backtrack if assignment doesn't lead to a solution
            del assignment[current_region]
            
    return None

# Execute the solver
solution = solve_map_coloring(regions, colors, neighbors)
print("Map Coloring Solution:", solution)
