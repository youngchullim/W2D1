require_relative "piece_list.rb"
require 'byebug'

class InvalidMoveError < StandardError; end

class Board

  def self.blank_board
    blank = Board.new
    blank.each_with_index do |row, r_idx|
      row.each_with_index do |space, c_idx|
        pos = [r_idx, c_idx]
        blank[pos] = NullPiece.instance
      end
    end
    blank
  end

  def initialize
    @grid = Array.new(8) {Array.new(8) }
    populate
  end

  def populate
    @grid[0].each_index do |i|
      if i == 0 || i == 7
        self[[0, i]] = Rook.new([0, i], :blue, self)
      elsif i == 1 || i == 6
        self[[0, i]] = Knight.new([0, i], :blue, self)
      elsif i == 2 || i == 5
        self[[0, i]] = Bishop.new([0, i], :blue, self)
      elsif i == 3
        self[[0, i]] = Queen.new([0, i], :blue, self)
      else
        self[[0, i]] = King.new([0, i], :blue, self)
      end
    end

    @grid[1].each_index do |i|
      self[[1, i]] = Pawn.new([1, i], :blue, self)
    end

    i = 2
    while i < 6
      @grid[i].each_index { |j| self[[i, j]] = NullPiece.instance }
      i += 1
    end

    @grid[6].each_index do |i|
      self[[6, i]] = Pawn.new([6, i], :red, self)
    end

    @grid[7].each_index do |i|
      if i == 0 || i == 7
        self[[7, i]] = Rook.new([7, i], :red, self)
      elsif i == 1 || i == 6
        self[[7, i]] = Knight.new([7, i], :red, self)
      elsif i == 2 || i == 5
        self[[7, i]] = Bishop.new([7, i], :red, self)
      elsif i == 3
        self[[7, i]] = Queen.new([7, i], :red, self)
      else
        self[[7, i]] = King.new([7, i], :red, self)
      end
    end
  end

  def in_check?(color)
    king_pos = nil
    color == :red ? opposite_color = :blue : opposite_color = :red

    self.each_with_index do |row, r_idx|
      row.each_index do |c_idx|
        curr_pos = [r_idx, c_idx]
        if self[curr_pos].is_a?(King) && self[curr_pos].color == color
          king_pos = curr_pos
        end
      end
    end

    self.each_with_index do |row, r_idx|
      row.each_index do |c_idx|
        curr_pos = [r_idx, c_idx]
        if self[curr_pos].color == opposite_color
          # byebug
          return true if self[curr_pos].moves.include?(king_pos)
        end
      end
    end

    false
  end

  def move_piece(start_pos, end_pos)
    raise InvalidMoveError if self[start_pos].is_a?(NullPiece)
    curr_piece = self[start_pos]
    possible_moves = curr_piece.moves

    if possible_moves.include?(end_pos)
      self[end_pos], self[start_pos] = curr_piece, NullPiece.instance
      curr_piece.pos = end_pos
    else
      raise InvalidMoveError
    end

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