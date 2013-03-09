require 'test/unit'

require './Cell.rb'
require './Grid.rb'

class CellTest < Test::Unit::TestCase
  def testDeadCell
    deadCell = Cell.new(Cell::DEAD)
    assert(deadCell.dead?)
  end
  
  def testLivingCell
    deadCell = Cell.new(Cell::ALIVE)
    assert(deadCell.alive?)
  end
  
  def testDeadCellBackingToAlive
    cell = Cell.new(Cell::DEAD)
    cell.becomeAlive!
    assert(cell.alive?)
  end
  
  def testDeadToSymbol
    cell = Cell.new(Cell::DEAD)
    assert_equal(cell.toSymbol, "-")
  end
  
  def testAliveToSymbol
    cell = Cell.new(Cell::ALIVE)
    assert_equal(cell.toSymbol, "@")
  end

  def testDeadCell
    cell = Cell.deadCell
    assert(deadCell.dead?)
  end
end

class GridWithGenerationTest < Test::Unit::TestCase
  def setup
    @g = GridWithGeneration.new
  end
  
  def testInit
    assert_equal(@g.numGeneration, 1)
  end
  
  def testIncrease
    @g.increaseGeneration
    assert_equal(@g.numGeneration, 2)
  end
  
  def test_toS
    assert(@g.to_s.include?("Generation"))
  end
end

class GridTest < Test::Unit::TestCase
  def setup
    @grid = Grid.new
  end
  
  def testGet
    assert_not_nil(@grid[0][0])
    assert(@grid[0][0].dead?)
  end
  
  def testLivingCellsRowByRow
    @grid[0][0] = Cell.new(Cell::ALIVE)
    hasAlive = false
    @grid.eachLivingCell do |i, j|
      assert(@grid[i][j].alive?)
      hasAlive = true
    end
    assert(hasAlive)
  end
  
  def testSet
    grid = Grid.new
    assert_not_nil(grid[0][0])
  end
  
  def testfilterValid
    n = 0
    assert_equal(Grid.filterValid(n-1..n+1).size, 2)
  end
  
  def testHasNoThreeLivingNeighbors
    assert( ! @grid.threeLivingNeighbors?(0,0))
    assert( ! @grid.threeLivingNeighbors?(10,10))
  end
  
  def testHasThreeLivingNeighborsOne
    [@grid[0][1], @grid[0][2], @grid[0][3]].each do |cell|
      cell.becomeAlive!
      assert(cell.alive?)
    end
    assert(@grid.threeLivingNeighbors?(1,2))
  end
  
  def testHasThreeLivingNeighborsTwo
    [@grid[1][1], @grid[1][0], @grid[0][1]].each do |cell|
      cell.becomeAlive!
      assert(cell.alive?)
    end
    assert(@grid.threeLivingNeighbors?(0,0))
  end
  
  def testHasThreeLivingNeighborsThree
    [@grid[0][0], @grid[2][0], @grid[2][2]].each do |cell|
      cell.becomeAlive!
      assert(cell.alive?)
    end
    assert(@grid.threeLivingNeighbors?(1,1))
  end
end
