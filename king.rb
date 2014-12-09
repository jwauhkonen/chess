require_relative 'stepping_piece'
# encoding: utf-8
class King < SteppingPiece

DIRECTION_DELTAS = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]]

  def mark
  	color == :blue ? "\u2654" : "\u265A"
  end

  def move_dirs
  	DIRECTION_DELTAS
  end

  


end