require_relative "piece.rb"
require_relative "display.rb"
require_relative "cursor.rb"
require 'byebug'

class Board
  def initialize
    @grid = Array.new(8) {Array.new(8) }
    populate
  end

  def populate
    @grid.each_with_index do |row, i|
      if [0,1,6,7].include?(i)
        row.each_with_index do |space, j|
          # space = Piece.new([i,j])
          self[[i, j]] = Piece.new([i, j])
        end
      end
    end
  end

  def move_piece(start_pos, end_pos)
    raise "Nothing at starting position" if self[start_pos] == nil
    raise "End position occupied by ally" if self[end_pos] != nil
    piece = self[start_pos]
    self[start_pos] = nil
    self[end_pos] = piece
    piece.pos = end_pos
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end
  
  def valid_pos?(pos)
    valid_range = (0...8)
    return false unless valid_range.include?(pos[0]) && valid_range.include?(pos[1])
    true
  end

  def each_with_index(&prc)
    # @grid.each(&prc)
    i = 0
    while i < @grid.length
      prc.call(@grid[i], i)
      i += 1
    end
  end

end