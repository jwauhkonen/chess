class Piece

  attr_reader :color, :board
  attr_accessor :pos

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
  end


  def valid_moves
    moves.select do |new_pos|
      new_board = board.cust_dup
      new_board.move!(pos, new_pos)
      !new_board.check?(color)
    end
  end

  def shift_by(shift)
    [pos[0] + shift[0], pos[1] + shift[1]]
  end

  def in_bounds?(pos)
    row, col = pos

    (0..7).cover?(row) && (0..7).cover?(col)
  end

  def display_piece
    mark.encode('utf-8').colorize(color)
  end

  def occupied_by_enemy?(pos)
    if !board.empty_space?(pos)
        return true if board[pos].color != color
    end
    
    false
  end

  def occupied_by_friend?(pos)
    if !board.empty_space?(pos)
        return true if board[pos].color == color
    end
    
    false
  end


end
