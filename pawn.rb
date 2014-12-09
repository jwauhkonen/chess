class Pawn < Piece

  def initialize(pos, color, board)
    super
    @start_pos = pos
    @delta, @diag_deltas = find_deltas
  end

  def mark
  	   color == :blue ? "\u2659" : "\u265F"
  end

  def moves
    moves = []
    pos1, pos2 = shift_by(@delta[0]), shift_by(@delta[1])
    diag1, diag2 = shift_by(@diag_deltas[0]), shift_by(@diag_deltas[1])

    moves << pos1 if valid_one_step?(pos1) 
    moves << pos2 if @start_pos == pos && valid_two_steps?(pos1, pos2)

    moves << diag1 if valid_take_step?(diag1)
    moves << diag2 if valid_take_step?(diag2)

  	moves
  end

  private

  def valid_two_steps?(pos1, pos2)
    in_bounds?(pos2) && board.empty_space?(pos2) && board.empty_space?(pos1)
  end

  def valid_one_step?(new_pos)
    in_bounds?(new_pos) && board.empty_space?(new_pos) 
  end

  def valid_take_step?(diag)
    in_bounds?(diag) && occupied_by_enemy?(diag)
  end

  def find_deltas
    if color == :red #red start from top
      [[[1, 0],[2, 0]], [[1, 1], [1, -1]]]
    else
      [[[-1,0],[-2, 0]], [[-1, 1], [-1, -1]]]
    end
  end

end