require_relative "cursor.rb"
require_relative "board.rb"
require 'colorize'

class Display
  def initialize
    @board = Board.new
    @cursor = Cursor.new([0,0], @board)
  end

  def render
    system("clear")
    @board.each_with_index do |row, r_idx|
      row.each_with_index do |col, c_idx|
        pos = [r_idx, c_idx]
        cursor = @cursor.cursor_pos == pos
        cursor ? color = :red : color = :green
        if @board[pos].is_a?(Piece)
          print "P".center(3).colorize(color)
        else
          print "*".center(3).colorize(color)
        end
      end
      puts
    end
  end

  def make_move
    render
    # This code is bad because it calls cursor.get_input twice!
    while @cursor.get_input == nil
      render
      @cursor.get_input
    end
  end

end