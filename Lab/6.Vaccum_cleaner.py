class VacuumEnvironment:
    def __init__(self, status_a, status_b):
        # Tracks room cleanliness and agent position
        self.room_status = {'A': status_a, 'B': status_b}
        self.agent_location = 'A'

def simple_reflex_agent(location, status):
    # Decides action based on current percept
    if status == 'Dirty':
        return 'Suck'
    elif location == 'A':
        return 'Right'
    elif location == 'B':
        return 'Left'

def run_vacuum_simulation(max_steps=6):
    # Initialize with both rooms dirty
    env = VacuumEnvironment('Dirty', 'Dirty')
    print(f"Initial Environment: {env.room_status}, Agent at Location {env.agent_location}\n")
    
    for step in range(1, max_steps + 1):
        loc = env.agent_location
        status = env.room_status[loc]
        action = simple_reflex_agent(loc, status)
        
        print(f"Step {step}: At '{loc}', room is {status} ➔ Action: {action}")
        
        # Execute action
        if action == 'Suck':
            env.room_status[loc] = 'Clean'
        elif action == 'Right':
            env.agent_location = 'B'
        elif action == 'Left':
            env.agent_location = 'A'
            
        # Check if goal is achieved (all rooms clean)
        if all(s == 'Clean' for s in env.room_status.values()):
            print(f"\nGoal Reached! Both rooms are clean after {step} steps.")
            break
        print(f"Current State: {env.room_status}, Agent at {env.agent_location}\n")

run_vacuum_simulation()
