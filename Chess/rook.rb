require_relative 'piece.rb'

class Rook < Piece
  include SlidingPiece

  def initialize(pos, color, board)
    super
    @symbol = '♜'
  end

  def move_dirs
    [:horizontal]
  end

end