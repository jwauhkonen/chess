class SlidingPiece < Piece

  def moves
    moves = []

    move_dirs.each do |delta|
      moves.concat(get_moves(delta))
    end

    moves
  end

  def get_moves(delta)
    moves = []
    shift = delta

    (1..7).each do |mul|
      shift = [delta[0] * mul, delta[1] * mul]
      new_pos = shift_by(shift)

      return moves if !in_bounds?(new_pos) || occupied_by_friend?(new_pos)
      moves << new_pos
      return moves if occupied_by_enemy?(new_pos)
    end

    moves
  end

end 
