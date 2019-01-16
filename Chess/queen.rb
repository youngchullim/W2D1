require_relative 'piece.rb'

class Queen < Piece
  include SlidingPiece

  def initialize(pos, color, board)
    super
    @symbol = '♛'
  end

  def move_dirs
    [:diagonal, :horizontal]
  end

end