require_relative 'stepping_piece'

class Knight < SteppingPiece

DIRECTION_DELTAS = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]]

  def mark
  	color == :blue ? "\u2658" : "\u265E"
  end

  def move_dirs
  	DIRECTION_DELTAS
  end




end