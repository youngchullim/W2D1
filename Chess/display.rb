require_relative "cursor.rb"
require_relative "board.rb"
require 'colorize'

class Display
  def initialize
    @board = Board.new
    @cursor = Cursor.new([0,0], @board)
  end

  def render(message="")
    system("clear")

    @board.each_with_index do |row, r_idx|
      row.each_with_index do |col, c_idx|
        pos = [r_idx, c_idx]
        selected_cur = @cursor.cursor_pos == pos
        selected_cur ? color = :yellow : color = @board[pos].color
        print @board[pos].symbol.center(3).colorize(color)
      end
      puts
    end
    puts message
  end

  def make_move
    begin
    render("Choose your piece!")
    flag = nil
    while flag == nil
      render("Choose your piece!")
      flag = @cursor.get_input
    end
    start_pos = flag

    render("Choose destination!")
    flag = nil
    while flag == nil
      render("Choose destination!")
      flag = @cursor.get_input
    end
    end_pos = flag

    @board.move_piece(start_pos, end_pos)
    rescue
      puts "Invalid move, Try again"
      sleep(1.5)
      retry
    end
    render
    if @board.in_check?(:blue)
      puts "Blue is in check"
    elsif @board.in_check?(:red)
      puts "Red is in check"
    end
  end

end