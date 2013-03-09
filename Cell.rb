# for   : COMP3170 A1, summer 2012 by Matthew Skala
# author: Zhao Han (Student # is 7633813)

class Cell
  
  ALIVE, DEAD = true, false
  ALIVE_CHAR, DEAD_CHAR = "@", "-"
  
  def initialize(state)
    @state = state
  end
  
  def dead?
    @state == DEAD
  end
  
  def alive?
    ! dead?
  end
  
  def becomeAlive!
    @state = ALIVE
  end
  
  def clone
    Cell.new @state
  end
  
  def toChar
    return ALIVE_CHAR if alive?
    return DEAD_CHAR
  end
end

DeadCell = Cell.new Cell::DEAD
DeadCell.freeze