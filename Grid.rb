# for   : COMP3170 A1, summer 2012 by Matthew Skala
# author: Zhao Han (Student # is 7633813)

require './Cell.rb'

class Grid
  
  N = 200 # 200^2 cells
  
  def initialize(relativeXYsToMid)
    @grid = Array.new(N) { Array.new(N){ DeadCell.clone } }
    
    mid = N/2;
    relativeXYsToMid.each do |x,y|
      @grid[mid+x][mid+y].becomeAlive!
    end
  end
  
  def [](i)
    @grid[i]
  end
  
  def livingCells
    a = []
    N.times do |i|
      N.times do |j|
        a << [i,j] if self[i][j].alive?
      end
    end
    a
  end
  
  def _filterValid!(range)
    range.to_a.delete_if {|x| x < 0 || x >= N}
  end
  
  def _eachNeighborsOf(x,y)
    for i in _filterValid!(x-1..x+1)
      for j in _filterValid!(y-1..y+1)
        yield i,j unless i==x && j==y
      end
    end
  end
  
  def eachDeadNeighborsOf(i,j)
    _eachNeighborsOf(i,j) do |x,y|
      yield x,y if self[x][y].dead?
    end
  end
  
  def threeLivingNeighbors?(i,j)
    n = 0
    _eachNeighborsOf(i,j) do |x,y|
      n += 1 if self[x][y].alive?
      return false if n > 3
    end
    n == 3
  end
  
  def _numLivingNeighbors(i, j)
    n = 0
    _eachNeighborsOf(i,j) do |x,y|
      n += 1 if self[x][y].alive?
    end
    n
  end
  
  # won't include the line without any alive cell
  def to_s 
  	s = ""
    for i in 0...N
      line = ""
      for j in 0...N
        line << @grid[i][j].toChar
      end
      s << line+"\n" if line.include? Cell::ALIVE_CHAR
    end
    s
  end
end

class GridWithGeneration < Grid
  
  def initialize(relativeXYsToMid)
    @numGeneration = 1;
    super
  end

  def increaseGeneration
    @numGeneration += 1
  end
  
  def numGenerationsTook
    @numGeneration - 1
  end
  
  def to_s
    output = "Generation #{@numGeneration}:\n"
    output << super
  end
end