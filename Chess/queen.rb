require_relative 'piece.rb'

class Queen < Piece
  include SlidingPiece
  attr_reader :pos, :color

  def initialize(pos, color, board)
    super
    @symbol = 'Q'
  end

  def move_dirs
    [:diagonal, :horizontal]
  end

end