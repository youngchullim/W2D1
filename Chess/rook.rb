require_relative 'piece.rb'

class Rook < Piece
  include SlidingPiece
  attr_reader :pos, :color

  def initialize(pos, color, board)
    super
    @symbol = 'R'
  end

  def move_dirs
    [:horizontal]
  end

end