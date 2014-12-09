require_relative 'sliding_piece'


class Bishop < SlidingPiece
  DIRECTION_DELTAS = [[1, 1], [1, -1], [-1, 1], [-1, -1]]

  def move_dirs
    DIRECTION_DELTAS
  end

  def mark 
  	color == :blue ? "\u2657" : "\u265D"
  end
end