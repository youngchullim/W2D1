require_relative 'piece.rb'

class Pawn < Piece
  # attr_reader :board
  def initialize(pos, color, board)
    super
    @symbol = "♟"
  end

  def moves
    row, col = @pos
    self.color == :red ? dir = -1 : dir = 1
    moves_arr = []
    starting = (pos[0] == 1 && color == :blue) || (pos[0] == 6 && color == :red)
    forward = [[row + dir, col], [row + (dir * 2), col]]
    # moves_arr << forward if self.board.valid_pos?(forward) && self.board[forward].is_a?(NullPiece)
    forward.each do |pos|
      break if !starting && moves_arr.length == 1
      moves_arr << pos if self.board.valid_pos?(pos) && self.board[pos].is_a?(NullPiece)
    end
    diag = [ [row + dir, col - 1], [row + dir, col + 1] ]

    diag.each do |pos|
      next unless self.board.valid_pos?(pos)
      if self.color == :red
        moves_arr << pos if self.board[pos].color == :blue
      else
        moves_arr << pos if self.board[pos].color == :red
      end
    end

    moves_arr
  end

end