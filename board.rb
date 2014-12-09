class MoveError < StandardError ;end

class Board

  POS_TRANSLATOR = {0 => "A", 1 => "B", 2 => "C", 3 => "D", 4 => "E", 5 => "F", 6 => "G", 7 => "H"}

  attr_accessor :grid, :highlight 

  def initialize(pop_board = true)
    @grid = Array.new(8) {Array.new(8)}
    @highlight = nil
    
    start_pieces if pop_board
  end

  def [](pos)
    x, y = pos[0], pos[1]
    @grid[x][y]
  end

  def []=(pos, piece)
    x, y = pos[0], pos[1]
    @grid[x][y] = piece
  end

  def empty_space?(pos)
    self[pos].nil?
  end

  def move(start_pos, end_pos, color)
    raise MoveError.new("Cannot move an empty space!") if self[start_pos].nil?
    raise MoveError.new("Not your color!") unless self[start_pos].color == color
    raise MoveError.new("Must choose a space with a piece in it!") if empty_space?(start_pos)
    
    piece = self[start_pos]
    raise MoveError.new("Invalid move!") unless piece.valid_moves.include?(end_pos)

    move!(start_pos, end_pos)
  end

  def move!(start_pos, end_pos)    
    piece = self[start_pos]
    self[end_pos] = piece
    piece.pos = end_pos
    self[start_pos] = nil
  end

  def checkmate?(color)
    check?(color) && team(color).all? {|p| p.valid_moves.empty? }
  end

  def cust_dup
    new_board = Board.new(false)

    grid.flatten.each do |p| 
      next if p.nil? 
      new_board.place_piece(p.class, p.color, p.pos) 
    end

    new_board
  end

  def display
    system('clear')
    @grid.each_with_index do |array, row|
      print "\n#{(7 - row + 1)} " #print row number
      array.each_index do |col|
        print background(row, col,
        if empty_space?([row, col])
          "   "
        else
          " #{self[[row, col]].display_piece} "
        end
        )
      end
    end
    #print column letter markers
    puts "\n   A  B  C  D  E  F  G  H \n"
    
  end

  def check?(color)
    my_king = team(color).select {|p| p.is_a?(King)}[0]
    other_color = (color == :blue ? :red : :blue)
    team(other_color).any? { |p| p.moves.include?(my_king.pos) }
  end

  def place_piece(piece, color, pos)
    self[pos] = piece.new(pos, color, self)
  end
  
  private

  def background(row, col, str)
    if [row, col] == @highlight.flatten
      str.on_light_cyan
    elsif (row + col).odd?
      str.on_light_black
    else
      str.on_white
    end
  end

  def start_pieces
    place_piece(Rook, :red, [0, 0])
    place_piece(Rook, :red, [0, 7])
    place_piece(Rook, :blue, [7, 0])
    place_piece(Rook, :blue, [7, 7])

    place_piece(Bishop, :red, [0, 2])
    place_piece(Bishop, :red, [0, 5])
    place_piece(Bishop, :blue, [7, 2])
    place_piece(Bishop, :blue, [7, 5])

    place_piece(Knight, :red, [0, 1])
    place_piece(Knight, :red, [0, 6])
    place_piece(Knight, :blue, [7, 1])
    place_piece(Knight, :blue, [7, 6])

    place_piece(Queen, :red, [0, 3])
    place_piece(King, :red, [0, 4])
    place_piece(Queen, :blue, [7, 3])
    place_piece(King, :blue, [7, 4])

    8.times do |i|
      place_piece(Pawn, :red, [1, i])
    end

    8.times do |i|
      place_piece(Pawn, :blue, [6, i])
    end

  end

  def team(color)
    @grid.flatten.select {|p| !p.nil? && p.color == color}
  end

  def translate_to_output_index(index_pos)
    row, col = index_pos
    new_row = (7 - row + 1)
    new_col = POS_TRANSLATOR[col]

    ["#{new_col}#{new_row}"]
  end

end


