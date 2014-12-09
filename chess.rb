# encoding: utf-8

require_relative 'pieces'

class Game

  POS_TRANSLATOR = {"A" => 0, "B" => 1, "C" => 2, "D" => 3, "E" => 4, "F" => 5, "G" => 6, "H" => 7}

  class InputError < StandardError ;end
  
  attr_reader :input_type
  

  def initialize(input_type)
    @input_type = input_type
    @board = Board.new
    @current_color = :blue
    @key_input = KeyInput.new(@board)
  end
  
  def start_game
    input_type == :dir ? play_dir : play
  end

  def play
    until @board.checkmate?(:blue) || @board.checkmate?(:red)
      @board.display
      take_turn
      change_current_color
    end

    @board.display
    puts (@board.checkmate?(:blue) ? "Red wins!".colorize(:red) : "Blue wins!".colorize(:blue) )
  end
  
  def play_dir
    @board.highlight = [[4, 4]]
    @board.display
    until @board.checkmate?(:blue) || @board.checkmate?(:red)
      take_turn_dir
      change_current_color
    end
    
    @board.display
    puts (@board.checkmate?(:blue) ? "Red wins!".colorize(:red) : "Blue wins!".colorize(:blue) )
  end
  

  private

  def take_turn
    begin
      start_pos, end_pos = get_move
      @board.move(start_pos, end_pos, @current_color)
      @board.display
    rescue InputError => input_error
      puts input_error
      retry
    rescue MoveError => move_error
      puts move_error
      retry
    end
  end
  
  def take_turn_dir
    begin
      puts "\nTurn: #{@current_color}\tIn check? : #{@board.check?(@current_color)}"
      puts "Select piece to move"
      start_pos = @key_input.move_keys
      puts "Select space to move to"
      end_pos = @key_input.move_keys
      @board.move(start_pos, end_pos, @current_color)
      @board.display
    rescue InputError => input_error
      puts input_error
      retry
    rescue MoveError => move_error
      puts move_error
      retry
    end

  end

  def get_move
    puts "\nTurn: #{@current_color}\tIn check? : #{@board.check?(@current_color)}"
    puts "Select starting and ending position, e.g 'f2, f3'"

    move = gets.chomp.upcase.split(",").map(&:strip)
    raise InputError.new("Invalid Format! Please enter in the format of 'f2, f3'") unless valid_syntax?(move)
    parse_move(move)
  end


  def valid_syntax?(move)
    move.count == 2 &&
      move.all? do |pos_str|
        pos_str.length == 2 &&
          ("A".."H").cover?(pos_str[0].upcase) &&
          ("1".."8").cover?(pos_str[1])
      end
  end

  def parse_move(move)
    start_pos, end_pos = move

    new_start = [ 8 - start_pos[1].to_i, POS_TRANSLATOR[start_pos[0]]]
    new_end = [ 8 - end_pos[1].to_i, POS_TRANSLATOR[end_pos[0]]]

    [new_start, new_end]
  end

  def change_current_color
    @current_color = (@current_color == :blue ? :red : :blue)
  end
end

game = Game.new(:dir)
game.start_game







