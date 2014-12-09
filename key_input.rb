require 'io/console'
 
# Reads keypresses from the user including 2 and 3 escape character sequences.

class KeyInput
  attr_reader :highlight 

  def initialize(board, highlight = [4, 4])
    @board = board
    @highlight = [highlight[0], highlight[1]]
  end

  def read_char
    STDIN.echo = false
    STDIN.raw!
   
    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    STDIN.echo = true
    STDIN.cooked!
   
    return input
  end
  
  def in_bounds?(new_pos)
    row, col = new_pos

    (0..7).cover?(row) && (0..7).cover?(col)
  end

  def move_keys

    c = read_char
    if c == "q"
      exit
    end
    
    until c == " "
      c = read_char
      case c
      when "\e[A"
        # "UP ARROW"
        new_pos = [@highlight[0] - 1, @highlight[1]]
        @highlight = new_pos if in_bounds?(new_pos)
        # @highlight[0] -= 1
      when "\e[B"
        # "DOWN ARROW"
        new_pos = [@highlight[0] + 1, @highlight[1]]
        @highlight = new_pos if in_bounds?(new_pos)
        # @highlight[0] += 1
      when "\e[C"
        # "RIGHT ARROW"
        new_pos = [@highlight[0], @highlight[1] + 1]
        @highlight = new_pos if in_bounds?(new_pos)
        # @highlight[1] += 1
      when "\e[D"
        # "LEFT ARROW"
        new_pos = [@highlight[0], @highlight[1] - 1]
        @highlight = new_pos if in_bounds?(new_pos)
        # @highlight[1] -= 1
      end
      @board.highlight = [highlight[0], highlight[1]]
      @board.display
    end

    [highlight[0], highlight[1]]
  end

end
   
  # # oringal case statement from:
  # # http://www.alecjacobson.com/weblog/?p=75
  # def show_single_key
  #   c = read_char
   
  #   case c
  #   when " "
  #     puts "SPACE"
  #   when "\t"
  #     puts "TAB"
  #   when "\r"
  #     puts "RETURN"
  #   when "\n"
  #     puts "LINE FEED"
  #   when "\e"
  #     puts "ESCAPE"
  #   when "\e[A"
  #     puts "UP ARROW"
  #   when "\e[B"
  #     puts "DOWN ARROW"
  #   when "\e[C"
  #     puts "RIGHT ARROW"
  #   when "\e[D"
  #     puts "LEFT ARROW"
  #   when "\177"
  #     puts "BACKSPACE"
  #   when "\004"
  #     puts "DELETE"
  #   when "\e[3~"
  #     puts "ALTERNATE DELETE"
  #   when "\u0003"
  #     puts "CONTROL-C"
  #     exit 0
  #   when /^.$/
  #     puts "SINGLE CHAR HIT: #{c.inspect}"
  #   else
  #     puts "SOMETHING ELSE: #{c.inspect}"
  #   end
  # end
  # move_keys
   
  #show_single_key while(true)