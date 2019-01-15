require_relative 'piece.rb'

class Bishop < Piece
  include SlidingPiece
  attr_reader :pos, :color

  def initialize(pos, color, board)
    super
    @symbol = 'B'
  end

  def move_dirs
    [:diagonal]
  end

end