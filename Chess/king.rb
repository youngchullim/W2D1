require_relative 'piece.rb'

class King < Piece
  include SteppingPiece

  def initialize(pos, color, board)
    super
    @symbol = '♚'
  end

end