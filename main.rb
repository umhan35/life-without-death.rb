# for   : COMP3170 A1, summer 2012 by Matthew Skala
# author: Zhao Han (Student # is 7633813)

require './LifeWithoutDeath.rb'

# Simulate this pattern until it terminates, #  and report how many generations that takes
# -------
# -@@@@@-
# -------
def simulationA
  puts "Simulating A..."
  grid = lifeWithoutDeath([ [0,-2], [0,-1], [0,0], [0,1], [0,2] ])
  puts "Simulation A takes #{grid.numGenerationsTook} generations."
  puts grid
end

# Simulate the following pattern twice, #  once for 50 generations and once for 100 generations
# ------
# ---@--
# -@@@@-
# ---@--
# ------
def simulationB
  initPattern = [ [-1,0], [0,-2], [0,-1], [0,0], [0,1], [1,0] ]
  
  puts "Simulating B for 50 generations..."
  grid = lifeWithoutDeath(initPattern, 50)
  puts grid
  
  puts "Simulating B for 100 generations..."
  grid = lifeWithoutDeath(initPattern, 100)
  puts grid
end

# Simulate this pattern for 200 generations
# ------
# -@@@@-
# ----@-
# ------
def simulationC
  puts "Simulating C for 200 generations..."
  grid = lifeWithoutDeath([ [0,-2], [0,-1], [0,0], [0,1], [1,1] ], 200)
  puts grid
end

simulationA
simulationB
simulationC