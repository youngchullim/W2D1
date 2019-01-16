require_relative 'piece.rb'

class Knight < Piece
  include SteppingPiece

  def initialize(pos, color, board)
    super
    @symbol = '♞'
  end

end