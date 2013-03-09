# for   : COMP3170 A1, summer 2012 by Matthew Skala
# author: Zhao Han (Student # is 7633813)

require 'logger'

require './Grid.rb'

class LifeWithoutDeath
  
  def initialize
    @log = Logger.new STDOUT
    
    # WARN : print nothing
    # INFO : print all grids
    # DEBUG: print all grids & how cells are born
    @log.level = Logger::WARN
  end
  
  # example: lifeWithoutDeath([ [0,-1], [0,0], [0,1] ])
  def run(aliveCellsAroundCenter, nTimes)
    grid = GridWithGeneration.new(aliveCellsAroundCenter)
    @log.info grid.to_s
    
    lastBornCells = grid.livingCells
    @log.debug "lastBornCells: #{lastBornCells.inspect}"
    
    nTimes.times do
      bornCells = []
      lastBornCells.each do |i,j|
        grid.eachDeadNeighborsOf(i,j) do |x,y|
          s = "checking lastBornCell [#{i}][#{j}]'s dead neibor [#{x}][#{y}]: "\
            + "#{grid._numLivingNeighbors(x,y)}" if @log.debug?
          if grid.threeLivingNeighbors?(x,y)
            bornCells << [x,y]
            s << " (become ALIVE next time)" if @log.debug?
          end
          @log.debug s
        end
      end
      
      @log.debug "bornCells.empty? #{bornCells.empty?}"
      break if bornCells.empty?
      
      lastBornCells = []
      bornCells.each do |i,j|
        if grid[i][j].dead?
          grid[i][j].becomeAlive!
          lastBornCells << [i,j]
        end
      end
      
      grid.increaseGeneration
      @log.info grid.to_s
      @log.debug "lastBornCells: #{lastBornCells.inspect}"
    end
    
    grid
  end
end

def lifeWithoutDeath(aliveCellsAroundCenter, numGenerationsToRun = 1000000000)
  LifeWithoutDeath.new.run(aliveCellsAroundCenter, numGenerationsToRun)
end
