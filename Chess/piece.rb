class Piece
  attr_accessor :pos
  attr_reader :color

  def initialize(pos, color, board)
    @color = color
    @board = board
    @pos = pos
  end

  def moves
    []
  end

end

module SlidingPiece

  def slide(dir)
    curr_pos = self.pos

    valid = true
    pos_moves = []
    while valid
      curr_pos[0] += dir[0]
      curr_pos[1] += dir[1]
      valid = false unless self.board.valid_pos?(curr_pos)
      if self.board[curr_pos].is_a?(NullPiece)
        pos_moves << curr_pos
      elsif self.board[curr_pos].color != self.color
        pos_moves << curr_pos
        valid = false
      else
        valid = false
      end  
    end
    pos_moves
  end

  def moves
    moves_arr = []
    if self.move_dirs.include?(:diagonal)
      moves_arr += self.slide([1,1]) + self.slide([1, -1]) + self.slide([-1, 1]) + self.slide([-1, -1])
    elsif self.move_dirs.include?(:horizontal)
      moves_arr += self.slide([0,1]) + self.slide([1,0]) + self.slide([0,-1]) + self.slide([-1,0])
    end
    moves_arr
  end


end

module SteppingPiece
  
  def moves

  end

end
