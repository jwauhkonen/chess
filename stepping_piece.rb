class SteppingPiece < Piece

  def moves
    moves = []

    move_dirs.each do |delta|
      new_pos = shift_by(delta)

      next if !in_bounds?(new_pos) || occupied_by_friend?(new_pos)
      
      moves << new_pos
    end

    moves
  end

end