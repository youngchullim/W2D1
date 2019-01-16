require_relative 'piece.rb'

class Bishop < Piece
  include SlidingPiece

  def initialize(pos, color, board)
    super
    @symbol = '♝'
  end

  def move_dirs
    [:diagonal]
  end

end